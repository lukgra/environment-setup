#!/bin/bash
# Bridges OmniWM's workspace-bar IPC events to a SketchyBar custom event.
# Install to ~/.config/sketchybar/scripts/omniwm_watch.sh and chmod +x it.
#
# Adjust the omniwmctl and sketchybar paths below if `which omniwmctl`
# or `which sketchybar` point elsewhere on your system.

OMNIWMCTL="$(command -v omniwmctl || echo /usr/local/bin/omniwmctl)"
SKETCHYBAR="$(command -v sketchybar || echo /opt/homebrew/bin/sketchybar)"

exec "$OMNIWMCTL" watch workspace-bar --exec "$SKETCHYBAR" --trigger omniwm_update
