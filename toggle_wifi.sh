#!/bin/sh
if [ "$(nmcli -t -f WIFI g)" = "enabled" ]; then
  nmcli radio wifi off
else
  nmcli radio wifi on
fi