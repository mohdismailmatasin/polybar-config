#!/bin/bash

if [ "$1" = "alt" ]; then
  printf "%%{F#cba6f7}日历 %s%%{F-}\n" "$(date "+%Y-%m-%d %H:%M:%S")"
else
  printf "%%{F#cba6f7}日历 %s%%{F-}\n" "$(date "+%a, %d %b %H:%M")"
fi
