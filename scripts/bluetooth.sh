#!/bin/sh

ICON=""
CONNECTED=""
COLOR_CONNECTED="%{F#89b4fa}"
COLOR_ON="%{F#707880}"
COLOR_DISABLED="%{F#f38ba8}"

for addr in $(bluetoothctl devices | cut -d' ' -f2); do
  if bluetoothctl info "$addr" 2>/dev/null | grep -q "Connected: yes"; then
    CONNECTED=$(bluetoothctl info "$addr" 2>/dev/null | grep "^	Name:" | cut -d' ' -f2-)
    break
  fi
done

if bluetoothctl show | grep -q "Powered: yes"; then
  if [ -n "$CONNECTED" ]; then
    echo "$COLOR_CONNECTED$ICON%{F-}   $COLOR_CONNECTED$CONNECTED%{F-}"
  else
    echo "$COLOR_ON$ICON%{F-}"
  fi
else
  echo "$COLOR_DISABLED$ICON%{F-}"
fi
