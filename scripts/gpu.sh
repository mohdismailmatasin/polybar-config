#!/bin/sh

COLOR="%{F#a6e3a1}"
COLOR_OFF="%{F#707880}"
COLOR_RESET="%{F-}"

if command -v nvidia-smi >/dev/null 2>&1; then
  GPU=$(nvidia-smi --query-gpu=utilization.gpu --format=%%,noheader,nounits | tr -d ' ')
  [ -z "$GPU" ] && GPU=0
  printf "%s%s %s%%%%%s\n" "$COLOR" "🧠" "$GPU" "$COLOR_RESET"
elif [ -f "/sys/class/drm/card1/gt_cur_freq_mhz" ]; then
  GPU=$(cat /sys/class/drm/card1/gt_cur_freq_mhz 2>/dev/null)
  printf "%s%s %sMHz%s\n" "$COLOR" "" "$GPU" "$COLOR_RESET"
else
  printf "%s%s N/A%s\n" "$COLOR_OFF" "🧠" "$COLOR_RESET"
fi
