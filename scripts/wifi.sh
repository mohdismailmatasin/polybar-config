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

STATE=$(cat /sys/class/net/wlan0/operstate 2>/dev/null)

if [ "$STATE" = "up" ] || [ "$STATE" = "unknown" ]; then

  SIGNAL=$(nmcli -t -f active,signal dev wifi | grep '^yes' | head -1 | cut -d: -f2)

  ICON=$(get_icon "$SIGNAL")

  echo "%{F#61AFEF}$ICON%{F-} %{F#61AFEF}${SIGNAL}%%{F-}"

else
  echo "%{F#A6A0A0}󰤫%{F-}"
fi
