#!/bin/bash

MAIL_COUNT=$(osascript -e "tell application \"Mail\" to return the unread count of inbox")

# set color based on mail MAIL_COUNT
if [ $MAIL_COUNT -eq 0 ]; then
    source "$CONFIG_DIR/colors.sh"
    sketchybar --set mail label=$MAIL_COUNT label.drawing=on icon.drawing=on icon.color=$ICON_COLOR
else
    sketchybar --set mail label=$MAIL_COUNT label.drawing=on icon.drawing=on icon.color=0xff82aaff
fi
