#!/bin/sh

INTERFACE=$(ip route | awk '/default/ {print $5; exit}')
[ -z "$INTERFACE" ] && INTERFACE="eth0"

PREV_RX=$(cat /sys/class/net/"$INTERFACE"/statistics/rx_bytes 2>/dev/null)
PREV_TX=$(cat /sys/class/net/"$INTERFACE"/statistics/tx_bytes 2>/dev/null)

sleep 1

CURR_RX=$(cat /sys/class/net/"$INTERFACE"/statistics/rx_bytes 2>/dev/null)
CURR_TX=$(cat /sys/class/net/"$INTERFACE"/statistics/tx_bytes 2>/dev/null)

RX_SPEED=$((CURR_RX - PREV_RX))
TX_SPEED=$((CURR_TX - PREV_TX))

format_speed() {
  SPEED=$1
  if [ "$SPEED" -lt 1024 ]; then
    echo "${SPEED}B"
  elif [ "$SPEED" -lt 1048576 ]; then
    echo "$((SPEED / 1024))K"
  else
    echo "$((SPEED / 1048576))M"
  fi
}

COLOR_UP="%{F#a6e3a1}"
COLOR_DOWN="%{F#f38ba8}"
COLOR_RESET="%{F-}"

printf "%s↑%s %s↓%s%s\n" "$COLOR_UP" "$(format_speed "$TX_SPEED")" "$COLOR_DOWN" "$(format_speed "$RX_SPEED")" "$COLOR_RESET"