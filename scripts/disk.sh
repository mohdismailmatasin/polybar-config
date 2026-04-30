#!/bin/bash

DISK=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

COLOR="%{F#89b4fa}"
RESET="%{F-}"
ICON="󰋊"

printf "%s%s  %s%%%s\n" "$COLOR" "$ICON" "$DISK" "$RESET"