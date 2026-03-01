# claude-sounds

Sound notifications for [Claude Code](https://claude.ai/claude-code) hook events. Cross-platform: macOS, Linux, Windows.

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

## Installation

```bash
# Clone
git clone https://github.com/dgilperez/claude-sounds ~/.claude/plugins/claude-sounds

# Or as a symlink from a local checkout
git clone https://github.com/dgilperez/claude-sounds ~/src/personal/claude-sounds
ln -sf ~/src/personal/claude-sounds ~/.claude/plugins/claude-sounds
```

Then add the hooks to your `~/.claude/settings.json`:

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
~/.claude/plugins/claude-sounds/scripts/toggle.sh toggle   # flip current state
```

### Custom sounds

Drop any MP3 into the `sounds/` directory and call `play-sound.sh <name>` (without `.mp3`).

## Platform support

| Platform | Player used |
|----------|-------------|
| macOS | `afplay` (built-in, supports MP3) |
| Linux | `ffplay` → `mpg123` → `paplay` → `mplayer` (first found) |
| Windows | Windows Media Player via PowerShell COM object |

Players are invoked in the background and fail silently if not available.

## Replace the sounds

The included sounds are defaults. Replace any `.mp3` in `sounds/` with your own files of the same name.

## License

MIT — see [LICENSE](LICENSE).
