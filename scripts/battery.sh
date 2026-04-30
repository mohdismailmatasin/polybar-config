#!/bin/bash

BAT_PATH="/sys/class/power_supply/BAT0"

# Read values
CAPACITY=$(cat "$BAT_PATH/capacity" 2>/dev/null)
STATUS=$(cat "$BAT_PATH/status" 2>/dev/null)

# Fallback
[ -z "$CAPACITY" ] && CAPACITY=0
[ -z "$STATUS" ] && STATUS="Unknown"

# Colors
COLOR="%{F#89b4fa}"   # primary
RESET="%{F-}"

# Icons (discharging ramp)
get_icon() {
  case $1 in
    0|1) echo "󰁺" ;;
    2|3) echo "󰁻" ;;
    4|5) echo "󰁼" ;;
    6|7) echo "󰁽" ;;
    8|9) echo "󰁾" ;;
    *) echo "󰁹" ;;
  esac
}

# Charging animation (loop)
ANIM_ICONS=("󰂆" "󰂇" "󰂈" "󰂉" "󰂊" "󰂋" "󰂅")
INDEX=$(( ( $(date +%s) / 1 ) % 7 ))

# Logic
if [ "$STATUS" = "Charging" ]; then
  ICON="${ANIM_ICONS[$INDEX]}"
  printf "%s%s %s%%%s\n" "$COLOR" "$ICON" "$CAPACITY" "$RESET"

elif [ "$STATUS" = "Full" ] || [ "$CAPACITY" -ge 100 ]; then
  ICON="󰂄"
  printf "%s%s%s\n" "$COLOR" "$ICON" "$RESET"

else
  LEVEL=$((CAPACITY / 10))
  ICON=$(get_icon "$LEVEL")
  printf "%s%s %s%%%s\n" "$COLOR" "$ICON" "$CAPACITY" "$RESET"
fi
