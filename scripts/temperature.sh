#!/bin/sh

# Try common thermal paths (CPU)
get_temp() {
  for ZONE in /sys/class/thermal/thermal_zone*/temp; do
    [ -f "$ZONE" ] && cat "$ZONE" && return
  done
}

RAW=$(get_temp)

# Fallback if nothing found
[ -z "$RAW" ] && RAW=0

# Convert millidegree → degree
TEMP=$((RAW / 1000))

# Colors (match your theme)
COLOR_NORMAL="%{F#89b4fa}"  # primary
COLOR_WARN="%{F#f38ba8}"    # alert
RESET="%{F-}"

# Icons
ICON_NORMAL="󱃂"
ICON_WARN="󱃃"

# Threshold
WARN=80

if [ "$TEMP" -ge "$WARN" ]; then
  printf "%s%s %s°C%s\n" "$COLOR_WARN" "$ICON_WARN" "$TEMP" "$RESET"
else
  printf "%s%s %s°C%s\n" "$COLOR_NORMAL" "$ICON_NORMAL" "$TEMP" "$RESET"
fi
