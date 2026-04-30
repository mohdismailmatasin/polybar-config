#!/bin/sh

get_icon() {
  SIGNAL=$1

  [ -z "$SIGNAL" ] && { echo "󰣽"; return; }

  SIGNAL=$(echo "$SIGNAL" | tr -d '%')

  if [ "$SIGNAL" -ge 75 ]; then
    echo "󰣺"
  elif [ "$SIGNAL" -ge 50 ]; then
    echo "󰣸"
  elif [ "$SIGNAL" -ge 25 ]; then
    echo "󰣶"
  elif [ "$SIGNAL" -ge 10 ]; then
    echo "󰣴"
  else
    echo "󰣾"
  fi
}

COLOR_CONNECTED="%{F#89b4fa}"
COLOR_OFF="%{F#707880}"
COLOR_DISABLED="%{F#f38ba8}"

STATE=$(cat /sys/class/net/wlan0/operstate 2>/dev/null)

if [ "$STATE" = "up" ] || [ "$STATE" = "unknown" ]; then

  SIGNAL=$(nmcli -t -f active,signal dev wifi | grep '^yes' | head -1 | cut -d: -f2)

  ICON=$(get_icon "$SIGNAL")

  echo "$COLOR_CONNECTED$ICON%{F-} $COLOR_CONNECTED${SIGNAL}%%{F-}"

elif [ "$STATE" = "down" ]; then
  STATE_CHECK=$(rfkill list wifi | grep -i "soft blocked" | awk '{print $3}')
  if [ "$STATE_CHECK" = "yes" ]; then
    echo "$COLOR_DISABLED󰤫%{F-}"
  else
    echo "$COLOR_OFF󰤫%{F-}"
  fi
else
  echo "$COLOR_OFF󰤫%{F-}"
fi
