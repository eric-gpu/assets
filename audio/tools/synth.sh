#!/usr/bin/env bash
# SPDX-License-Identifier: CC0-1.0
#
# Makes the synthesized sounds of the Concat sound library: risers, whooshes
# and booms built from noise and sine waves with ffmpeg, so they are original
# works with no samples in them, dedicated to the public domain (CC0 1.0).
#
#   ./synth.sh <output folder>
#
# Every sound is a plain ffmpeg expression (aevalsrc) plus filters, so running
# it again makes the same sound. Noise is ffmpeg's seeded random(), so
# the result is the same on every run.
set -euo pipefail
out="${1:?usage: synth.sh <output folder>}"
mkdir -p "$out"
R=48000

# Renders expression $2 (left|right) for $3 seconds, through filters $4, to $1.wav.
make() {
  ffmpeg -v error -y -f lavfi -i "aevalsrc=exprs='$2':s=$R:d=$3" \
    -af "$4" -c:a pcm_s16le "$out/$1.wav"
}

NOISE_L='(2*random(0)-1)'
NOISE_R='(2*random(1)-1)'

# --- Risers ---------------------------------------------------------------
# Noise that brightens and swells, with a sine sweeping up 300 Hz -> 2.4 kHz
# (exponential, so it sounds even), ending at its peak.
T=4; K=8; F=300
make riser-noise-4s \
  "0.55*$NOISE_L*pow(t/$T,3)+0.3*sin(2*PI*$F*$T/log($K)*(pow($K,t/$T)-1))*pow(t/$T,2)|0.55*$NOISE_R*pow(t/$T,3)+0.3*sin(2*PI*$F*$T/log($K)*(pow($K,t/$T)-1))*pow(t/$T,2)" \
  $T "highpass=f=250,lowpass=f=9000,aecho=0.8:0.6:45|90:0.25|0.15,afade=t=out:st=$(echo "$T-0.03" | bc):d=0.03"

# Three detuned saw waves a fifth and an octave apart, rising 110 -> 440 Hz.
T=6; K=4; F=110
P="($F*$T/log($K)*(pow($K,t/$T)-1))"
SAW="(2*(X-floor(X+0.5)))"
v() { echo "${SAW//X/($1*$P)}"; }
make riser-tonal-6s \
  "(0.22*$(v 1)+0.16*$(v 1.5)+0.12*$(v 2.003))*pow(t/$T,2)+0.2*$NOISE_L*pow(t/$T,4)|(0.22*$(v 1.004)+0.16*$(v 1.498)+0.12*$(v 2))*pow(t/$T,2)+0.2*$NOISE_R*pow(t/$T,4)" \
  $T "lowpass=f=5000,aecho=0.8:0.5:70|140:0.3|0.2,afade=t=out:st=$(echo "$T-0.04" | bc):d=0.04"

# A short, bright noise rush for quick cuts.
T=2
make riser-short-2s \
  "0.8*$NOISE_L*pow(t/$T,2.5)|0.8*$NOISE_R*pow(t/$T,2.5)" \
  $T "highpass=f=600,lowpass=f=12000,afade=t=out:st=$(echo "$T-0.02" | bc):d=0.02"

# --- Whooshes -------------------------------------------------------------
# Band-limited noise under a bell-shaped envelope that pans left to right.
whoosh() { # name seconds low-cut high-cut
  local T=$2
  make "$1" \
    "$NOISE_L*pow(sin(PI*t/$T),4)*(1-0.7*t/$T)|$NOISE_R*pow(sin(PI*t/$T),4)*(0.3+0.7*t/$T)" \
    "$T" "highpass=f=$3,lowpass=f=$4,aecho=0.7:0.4:30:0.2"
}
whoosh whoosh-fast-0.6s 0.6 400 7000
whoosh whoosh-soft-1s 1.0 200 3500
whoosh whoosh-long-1.6s 1.6 150 5000

# --- Booms ----------------------------------------------------------------
# A sine dropping from 70 Hz to 30 Hz, a click of noise at the start, and a
# slow decay: the low hit under a title or a cut.
T=3
make boom-sub-3s \
  "0.9*sin(2*PI*(30*t+40/6*(1-exp(-6*t))))*exp(-1.6*t)+0.5*$NOISE_L*exp(-45*t)|0.9*sin(2*PI*(30*t+40/6*(1-exp(-6*t))))*exp(-1.6*t)+0.5*$NOISE_R*exp(-45*t)" \
  $T "lowpass=f=4000,aecho=0.8:0.5:80|160:0.3|0.2,afade=t=out:st=2.6:d=0.4"

# A longer drop, 120 Hz falling to 35 Hz over two seconds.
T=4
make sub-drop-4s \
  "0.9*sin(2*PI*(35*t+85/1.5*(1-exp(-1.5*t))))*exp(-0.9*t)|0.9*sin(2*PI*(35*t+85/1.5*(1-exp(-1.5*t))))*exp(-0.9*t)" \
  $T "lowpass=f=1500,afade=t=out:st=3.4:d=0.6"

# The boom played backwards, with its echo, so it swells into the cut.
ffmpeg -v error -y -i "$out/boom-sub-3s.wav" \
  -af "apad=pad_dur=1,aecho=0.8:0.7:120|240:0.4|0.3,areverse,atrim=start=0.6,afade=t=in:d=0.2" \
  -c:a pcm_s16le "$out/reverse-swell-3s.wav"

ls "$out"
