#!/usr/bin/env bash
# play-sound.sh — Cross-platform sound player for claude-sounds plugin
# Usage: play-sound.sh <sound-name>
# Example: play-sound.sh session-start

set -euo pipefail

SOUND_NAME="${1:-}"
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$PLUGIN_DIR/.config"
SOUNDS_DIR="$PLUGIN_DIR/sounds"

# Check enabled/disabled state
if [[ -f "$CONFIG_FILE" ]]; then
  if grep -q "^enabled=false" "$CONFIG_FILE" 2>/dev/null; then
    exit 0
  fi
fi

# Validate sound name
if [[ -z "$SOUND_NAME" ]]; then
  exit 0
fi

SOUND_FILE="$SOUNDS_DIR/${SOUND_NAME}.mp3"
if [[ ! -f "$SOUND_FILE" ]]; then
  exit 0
fi

# Platform detection and playback
play_sound() {
  local file="$1"
  case "$(uname -s)" in
    Darwin)
      afplay "$file" &>/dev/null &
      ;;
    Linux)
      if command -v ffplay &>/dev/null; then
        ffplay -nodisp -autoexit "$file" &>/dev/null &
      elif command -v mpg123 &>/dev/null; then
        mpg123 -q "$file" &>/dev/null &
      elif command -v paplay &>/dev/null; then
        paplay "$file" &>/dev/null &
      elif command -v mplayer &>/dev/null; then
        mplayer -really-quiet "$file" &>/dev/null &
      fi
      ;;
    CYGWIN*|MINGW*|MSYS*)
      # Windows: PowerShell with WMP COM object for MP3 support
      powershell.exe -WindowStyle Hidden -Command "
        \$wmp = New-Object -ComObject WMPlayer.OCX
        \$wmp.URL = '$file'
        \$wmp.controls.play()
        Start-Sleep -Seconds 5
        \$wmp.controls.stop()
      " &>/dev/null &
      ;;
  esac
}

play_sound "$SOUND_FILE"
