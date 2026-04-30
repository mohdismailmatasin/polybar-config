#!/bin/bash

get_cpu() {
  CPU=(`cat /proc/stat | grep '^cpu '`)
  USER=${CPU[1]}
  NICE=${CPU[2]}
  SYSTEM=${CPU[3]}
  IDLE=${CPU[4]}
  IOWAIT=${CPU[5]}
  TOTAL=$((USER + NICE + SYSTEM + IDLE + IOWAIT))
  
  if [ -f /tmp/polybar_cpu_prev ]; then
    read -r PREV_TOTAL PREV_IDLE < /tmp/polybar_cpu_prev
  else
    PREV_TOTAL=$TOTAL
    PREV_IDLE=$IDLE
  fi
  
  DIFF_TOTAL=$((TOTAL - PREV_TOTAL))
  DIFF_IDLE=$((IDLE - PREV_IDLE))
  
  if [ $DIFF_TOTAL -gt 0 ]; then
    USAGE=$((100 * (DIFF_TOTAL - DIFF_IDLE) / DIFF_TOTAL))
  else
    USAGE=0
  fi
  
  echo "$TOTAL $IDLE" > /tmp/polybar_cpu_prev
  printf "%%{F#a6e3a1}  %s%%%%{F-}\n" "$USAGE"
}

get_cpu
