#!/bin/sh

# Get memory usage (%)
MEM=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

# Fallback safety
[ -z "$MEM" ] && MEM=0

# Colors (match your theme)
COLOR="%{F#a6e3a1}"   # replace with your ${colors.primary}
RESET="%{F-}"

# Icon
ICON=""

# Output (icon + space + data)
printf "%s%s  %s%%%s\n" "$COLOR" "$ICON" "$MEM" "$RESET"
