#!/bin/sh

VOL=$(pamixer --get-volume 2>/dev/null)
MUTE=$(pamixer --get-mute 2>/dev/null)

[ -z "$VOL" ] && VOL=0
[ -z "$MUTE" ] && MUTE=false

# Colors
COLOR_MUTED="%{F#707880}"
COLOR_ACTIVE="%{F#61AFEF}"
COLOR_RESET="%{F-}"

# Icons
ICON_MUTED=""
ICON_LOW=""
ICON_HIGH=""

if [ "$MUTE" = "true" ] || [ "$VOL" -eq 0 ]; then
  printf "%s%s%s\n" "$COLOR_MUTED" "$ICON_MUTED" "$COLOR_RESET"
else
  if [ "$VOL" -lt 30 ]; then
    ICON="$ICON_LOW"
  elif [ "$VOL" -lt 70 ]; then
    ICON="$ICON_LOW"
  else
    ICON="$ICON_HIGH"
  fi

  printf "%s%s  %s%%%s\n" "$COLOR_ACTIVE" "$ICON" "$VOL" "$COLOR_RESET"
fi
