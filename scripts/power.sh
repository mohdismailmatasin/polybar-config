#!/bin/sh
export GTK_THEME=mac-clone

CHOICE=$(yad --undecorated \
--center \
--width=260 \
--height=200 \
--title="Power Panel" \
--window-icon=system-shutdown \
--borders=12 \
--list \
--no-headers \
--column="Action" \
" Logout" \
"⭘ Reboot" \
"⏼ Power Off" \
--separator="")

# Strip icons safely
CHOICE=$(echo "$CHOICE" | sed 's/ //; s/⭘ //; s/⏼ //')

# =========================
# ACTIONS
# =========================

case "$CHOICE" in
  "Logout")
    cinnamon-session-quit --logout --no-prompt
    ;;

  "Reboot")
    systemctl reboot
    ;;

  "Power Off")
    systemctl poweroff
    ;;

  *)
    exit 0
    ;;
esac
