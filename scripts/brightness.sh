#!/bin/bash

get_brightness() {
  brightnessctl g 2>/dev/null || cat /sys/class/backlight/intel_backlight/brightness 2>/dev/null
}

get_max() {
  brightnessctl m 2>/dev/null || cat /sys/class/backlight/intel_backlight/max_brightness 2>/dev/null
}

get_icon() {
  BRIGHT=$1
  if [ "$BRIGHT" -ge 80 ]; then
    echo "󰃠"
  elif [ "$BRIGHT" -ge 60 ]; then
    echo "󰃟"
  elif [ "$BRIGHT" -ge 40 ]; then
    echo "󰃝"
  else
    echo "󰃞"
  fi
}

CURRENT=$(get_brightness)
MAX=$(get_max)

if [ -z "$CURRENT" ] || [ -z "$MAX" ] || [ "$MAX" -eq 0 ]; then
  exit 0
fi

BRIGHTNESS=$(( CURRENT * 100 / MAX ))
ICON=$(get_icon "$BRIGHTNESS")

PCTG="${BRIGHTNESS}%"
echo "%{F#a6e3a1}${ICON} ${PCTG}%{F-}"