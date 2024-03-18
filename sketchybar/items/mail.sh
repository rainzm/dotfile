#!/bin/bash

mail=(
    icon=:mail:
    icon.font="sketchybar-app-font:Regular:14.0"
    label=?
    update_freq=300
    script="$PLUGIN_DIR/mail.sh"
    click_script="open -a Mail"
)

sketchybar --add item mail right \
           --set mail "${mail[@]}" \
           --subscribe mail
