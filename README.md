# claude-sounds

Sound notifications for [Claude Code](https://claude.ai/claude-code) hook events.

Plays a sound when Claude starts a session, finishes responding, sends a notification, or a subagent completes a task. Works on macOS out of the box. Linux and Windows require a compatible audio player (see below).

## Installation

```bash
# Clone directly into the plugins directory
git clone https://github.com/dgilperez/claude-sounds ~/.claude/plugins/claude-sounds
```

Then register the hooks in `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {"hooks": [{"type": "command", "command": "~/.claude/plugins/claude-sounds/hooks/play-sound.sh session-start"}]}
    ],
    "Stop": [
      {"hooks": [{"type": "command", "command": "~/.claude/plugins/claude-sounds/hooks/play-sound.sh task-complete"}]}
    ],
    "Notification": [
      {"hooks": [{"type": "command", "command": "~/.claude/plugins/claude-sounds/hooks/play-sound.sh acknowledged"}]}
    ],
    "SubagentStop": [
      {"hooks": [{"type": "command", "command": "~/.claude/plugins/claude-sounds/hooks/play-sound.sh task-complete"}]}
    ]
  }
}
```

Restart Claude Code for the hooks to take effect.

## Sounds

| File | Default mapping | Description |
|------|----------------|-------------|
| `session-start.mp3` | `SessionStart` | New session started |
| `task-complete.mp3` | `Stop`, `SubagentStop` | Claude finished responding |
| `acknowledged.mp3` | `Notification` | Claude notification |
| `error.mp3` | — | Available for custom mapping |
| `alarm.mp3` | — | Available for custom mapping |
| `on-my-way.mp3` | — | Available for custom mapping |
| `vale.mp3` | — | Available for custom mapping |
| `ya-voy.mp3` | — | Available for custom mapping |

To use a custom sound, drop any `.mp3` into `sounds/` and call `play-sound.sh <name>` (without the extension).

## Platform support

### macOS
Works out of the box. Uses `afplay`, which is built into macOS and supports MP3 natively.

### Linux
Requires one of the following audio players (the script tries each in order):

```bash
# Ubuntu/Debian
sudo apt install ffmpeg        # recommended
# or
sudo apt install mpg123

# Arch
sudo pacman -S ffmpeg
# or
sudo pacman -S mpg123
```

> Note: `paplay` (PulseAudio) is in the fallback chain but does not support MP3 directly. Install `ffmpeg` or `mpg123` for reliable playback.

### Windows (Git Bash / MSYS2 / Cygwin)
Uses Windows Media Player via PowerShell, which is available on all Windows versions. No additional software required. Run from Git Bash, MSYS2, or Cygwin.

## Usage

### Test manually

```bash
~/.claude/plugins/claude-sounds/hooks/play-sound.sh session-start
~/.claude/plugins/claude-sounds/hooks/play-sound.sh task-complete
```

### Toggle on/off

```bash
~/.claude/plugins/claude-sounds/scripts/toggle.sh status   # on / off
~/.claude/plugins/claude-sounds/scripts/toggle.sh off      # disable
~/.claude/plugins/claude-sounds/scripts/toggle.sh on       # enable
~/.claude/plugins/claude-sounds/scripts/toggle.sh toggle   # flip
```

### Replace sounds

Swap out any `.mp3` in `sounds/` with a file of the same name. The hook picks it up immediately — no restart needed.

## Inspiration

My setup uses voice clips from the classic [Commandos](https://en.wikipedia.org/wiki/Commandos_(series)) game (Pyro Studios, 1998) — "vale", "ya voy", "voy para allá". Grab them from [soundinstants.com](https://soundinstants.com/search/commander). Not redistributable, but perfect locally.

## License

MIT — see [LICENSE](LICENSE).
