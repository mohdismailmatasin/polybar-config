#!/bin/sh

ICON=" "

STATE=$(nmcli -t -f WIFI g)

if [ "$STATE" = "enabled" ]; then
  if nmcli -t -f ACTIVE,SSID dev wifi | grep -q '^yes:'; then
    SSID=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes:' | cut -d: -f2)
    SIGNAL=$(nmcli -t -f SIGNAL dev wifi | head -1)
    echo "%{F#61AFEF}$ICON%{F-}   %{F#ABB2BF}$SSID%{F-} %{F#61AFEF}$SIGNAL%{F-}%"
  else
    # ON (idle) → GREEN
    echo "%{F#98C379}$ICON%{F-}"
  fi
else
  # OFF → GREY
  echo "%{F#A6A0A0}$ICON%{F-}"
fi
