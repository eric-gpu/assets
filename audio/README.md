# Concat sound library

The built-in sounds and music of the **Concat** shelf on the Library's Audio page.
The app reads [`manifest.json`](manifest.json) and fetches each file when it is first used,
checked against its SHA-256 (see `docs/AUDIO_LIBRARY.md` in the Concat repository).

## Licence

Every file in this folder is under **CC0 1.0** (public domain dedication), not the
repository's Apache-2.0 licence: use it for anything, with no attribution owed.
Each file's source page, where its licence can be checked, is listed below and in the manifest.

## Sources

| Files | Author | Source |
|---|---|---|
| `whoosh-fast.ogg`, `whoosh-soft.ogg`, `whoosh-long.ogg`, `boom-sub.ogg`, `riser-noise.ogg`, `riser-tonal.ogg`, `riser-short.ogg`, `reverse-swell.ogg`, `sub-drop.ogg` | Concat contributors | https://github.com/concatapp/assets/blob/main/audio/tools/synth.sh |
| `whoosh-mega-1.ogg`, `whoosh-mega-2.ogg`, `whoosh-slow-motion.ogg` | qubodup | https://opengameart.org/content/wind-hit-time-morph |
| `whoosh-stick-1.ogg`, `whoosh-stick-2.ogg` | qubodup | https://opengameart.org/content/swish-bamboo-stick-weapon-swhoshes |
| `whoosh-air.ogg` | pyranostudios | https://opengameart.org/content/air-whoosh |
| `whoosh-wind.ogg` | SketchMan3 | https://opengameart.org/content/wind-whoosh-loop |
| `boom-distant.ogg` | NenadSimic | https://opengameart.org/content/muffled-distant-explosion |
| `explosion-synth.ogg` | qubodup | https://opengameart.org/content/synthesized-explosion |
| `explosion-fuzzy.ogg` | qubodup | https://opengameart.org/content/metal-clang-explosions-zing |
| `explosion-low.ogg`, `explosion-crunch.ogg` | Kenney | https://kenney.nl/assets/sci-fi-sounds |
| `hit-punch.ogg`, `hit-wood.ogg`, `hit-metal.ogg`, `hit-bell.ogg` | Kenney | https://kenney.nl/assets/impact-sounds |
| `ambience-morning.ogg` | Kresiek The Furry | https://opengameart.org/content/amb-morning-sounds-perfect-loop |
| `ambience-outdoors.ogg` | Kresiek The Furry | https://opengameart.org/content/amb-outside-1 |
| `ambience-rain.ogg` | Kresiek The Furry | https://opengameart.org/content/amb-rain-loop-1 |
| `ambience-rain-heavy.ogg` | Ylmir | https://opengameart.org/content/rain-loopable |
| `ambience-crickets.ogg` | Wolfgang_ | https://opengameart.org/content/crickets-ambient-noise-loopable |
| `ambience-traffic.ogg` | IgnasD | https://opengameart.org/content/high-traffic-road-sounds |
| `ambience-wind.ogg` | Bashar3A | https://opengameart.org/content/mild-wind-background-noise |
| `ambience-river.ogg`, `ambience-field-wind.ogg` | Thimras | https://opengameart.org/content/park-ambiences |
| `ambience-birds-wind.ogg` | Spring Spring | https://opengameart.org/content/birds-and-wind-ambient-birds-wind-and-synth |
| `music-chill-lofi.ogg` | omfgdude | https://opengameart.org/content/chill-lofi-inspired |
| `music-lofi-countryside.ogg`, `music-lofi-morning-rain.ogg` | TAD | https://opengameart.org/content/lofi-compilation |
| `music-midnight-cruiser.ogg` | Zane Little Music | https://opengameart.org/content/midnight-cruiser |
| `music-field-of-dreams.ogg` | pauliuw | https://opengameart.org/content/the-field-of-dreams |
| `music-pacific-ocean.ogg` | josepharaoh99 | https://opengameart.org/content/pacific-ocean |
| `music-awake.ogg` | cynicmusic | https://opengameart.org/content/awake-megawall-10 |
| `music-determined-pursuit.ogg` | Emma_MA | https://opengameart.org/content/determined-pursuit-epic-orchestra-loop |
| `music-the-rush.ogg` | tebruno99 | https://opengameart.org/content/the-rush |
| `music-early-dawn.ogg` | antonioraymond71 | https://opengameart.org/content/rise-of-the-early-dawn |
| `music-piano-loop.ogg` | extenz | https://opengameart.org/content/emotional-piano-loop |

The files by *Concat contributors* are synthesized from noise and sine waves by
[`tools/synth.sh`](tools/synth.sh), with no samples in them; running it again makes the same sounds.

## How the files were prepared

Leading silence trimmed, resampled to 48 kHz, peaks normalised to about −1 dBFS, and encoded
as Ogg Vorbis (q6 for effects, q5 for ambience and music). Ambiences are cut to at most
60 seconds with a short fade at each end. Music tracks are whole.
