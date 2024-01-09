#!/bin/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    space=$sid
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=0
    icon.padding_right=-"$PADDINGS"
    padding_left=$PADDINGS
    padding_right=$PADDINGS
    label.padding_right=$PADDINGS
    icon.highlight_color=$HIGHLIGHT
    label.color=$WHITE_50
    label.highlight_color=$HIGHLIGHT
    label.font="sketchybar-app-font:Regular:14.0"
    label.y_offset=-1
    background.height=2
    background.y_offset=-12
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked space_windows_change
done
