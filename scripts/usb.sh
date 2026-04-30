#!/bin/bash

# =========================
# USB MANAGER (STABLE)
# =========================

get_unmounted() {
    lsblk -rpno NAME,TRAN,MOUNTPOINT | awk '$2=="usb" && $3=="" {print $1}'
}

get_mounted() {
    lsblk -rpno NAME,MOUNTPOINT | awk '$2 ~ "/media|/run/media" {print $1 "|" $2}'
}

mount_usb() {
    DEV=$(get_unmounted | yad --list \
        --title="Mount USB" \
        --width=300 --height=300 \
        --column="Device" \
        --no-headers)

    [ -n "$DEV" ] && udisksctl mount -b "$DEV"
}

unmount_usb() {
    CHOICE=$(get_mounted | yad --list \
        --title="Unmount USB" \
        --width=350 --height=300 \
        --column="Device" --column="Mount Point" \
        --separator="|" \
        --no-headers)

    DEV=$(echo "$CHOICE" | cut -d"|" -f1)

    [ -n "$DEV" ] && udisksctl unmount -b "$DEV"
}

case "$1" in
    --mount)
        mount_usb
        ;;
    --unmount)
        unmount_usb
        ;;
    *)
        MOUNTED_COUNT=$(lsblk -rpno NAME,MOUNTPOINT | awk '$2 ~ "/media|/run/media" {print $1}' | wc -l)
        UNMOUNTED_COUNT=$(get_unmounted | wc -l)
        if [ "$MOUNTED_COUNT" -gt 0 ]; then
            echo "%{F#00FF00} ${MOUNTED_COUNT}%{F-}"
        else
            echo "%{F#808080} ${UNMOUNTED_COUNT}%{F-}"
        fi
        ;;
esac
