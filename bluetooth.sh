#!/bin/sh

ICON=" "
CONNECTED=""

for addr in $(bluetoothctl devices | cut -d' ' -f2); do
  if bluetoothctl info "$addr" 2>/dev/null | grep -q "Connected: yes"; then
    CONNECTED=$(bluetoothctl info "$addr" 2>/dev/null | grep "^	Name:" | cut -d' ' -f2-)
    break
  fi
done

if bluetoothctl show | grep -q "Powered: yes"; then
  if [ -n "$CONNECTED" ]; then
    echo "%{F#61AFEF}$ICON%{F-}   %{F#ABB2BF}$CONNECTED%{F-}"
  else
    echo "%{F#98C379}$ICON%{F-}"
  fi
else
  echo "%{F#A6A0A0}$ICON%{F-}"
fi
