#!/bin/sh

ICON=" "

get_wifi_info() {
  STATE=$(cat /sys/class/net/wlan0/operstate 2>/dev/null)
  if [ "$STATE" = "up" ] || [ "$STATE" = "unknown" ]; then
    INFO=$(wifitui list --json 2>/dev/null)
    SSID=$(echo "$INFO" | grep -oP '(?<="SSID": ")[^"]+' | head -1)
    SIGNAL=$(echo "$INFO" | grep -oP '(?<="Strength": )[^,]+' | head -1)
    if [ -n "$SSID" ] && [ -n "$SIGNAL" ]; then
      echo "%{F#61AFEF}$ICON%{F-}   %{F#ABB2BF}$SSID%{F-} %{F#61AFEF}${SIGNAL}%{F-}%"
    else
      echo "%{F#98C379}$ICON%{F-}"
    fi
  else
    echo "%{F#A6A0A0}$ICON%{F-}"
  fi
}

get_wifi_info