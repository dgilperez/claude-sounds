# Sounds

This directory is where your sound files go. No sounds are included in the repo — add your own `.mp3` files here.

## Recommended free sources

- [Freesound.org](https://freesound.org) — large library, many CC0/CC-BY files
- [Kenney.nl](https://kenney.nl/assets?q=audio) — game-quality UI sounds, CC0
- [ElevenLabs](https://elevenlabs.io) — generate your own voice clips (check your plan's license for redistribution)
- [OpenGameArt.org](https://opengameart.org) — CC-licensed game audio

## Expected filenames

| File | Hook event |
|------|------------|
| `session-start.mp3` | `SessionStart` |
| `task-complete.mp3` | `Stop`, `SubagentStop` |
| `acknowledged.mp3` | `Notification` |

Any `.mp3` you drop here can be triggered manually with `play-sound.sh <name>`.
