#!/bin/bash
# toggle.sh — Enable/disable claude-sounds plugin
# Usage: toggle.sh [on|off|status|toggle]

set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$PLUGIN_DIR/.config"

get_status() {
  if [[ -f "$CONFIG_FILE" ]] && grep -q "^enabled=false" "$CONFIG_FILE" 2>/dev/null; then
    echo "off"
  else
    echo "on"
  fi
}

set_enabled() {
  local value="$1"
  if [[ -f "$CONFIG_FILE" ]]; then
    # Update existing entry
    sed -i.bak "s/^enabled=.*/enabled=$value/" "$CONFIG_FILE" && rm -f "$CONFIG_FILE.bak"
    # Add if not present
    if ! grep -q "^enabled=" "$CONFIG_FILE"; then
      echo "enabled=$value" >> "$CONFIG_FILE"
    fi
  else
    echo "enabled=$value" > "$CONFIG_FILE"
  fi
}

ACTION="${1:-status}"

case "$ACTION" in
  on)
    set_enabled true
    echo "claude-sounds: enabled"
    ;;
  off)
    set_enabled false
    echo "claude-sounds: disabled"
    ;;
  status)
    echo "claude-sounds: $(get_status)"
    ;;
  toggle)
    if [[ "$(get_status)" == "on" ]]; then
      set_enabled false
      echo "claude-sounds: disabled"
    else
      set_enabled true
      echo "claude-sounds: enabled"
    fi
    ;;
  *)
    echo "Usage: toggle.sh [on|off|status|toggle]" >&2
    exit 1
    ;;
esac
