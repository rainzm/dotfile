#!/bin/bash

# Load defined icons
source "$CONFIG_DIR/icons.sh"

# Load defined colors
source "$CONFIG_DIR/colors.sh"

PADDINGS=8
SBARFONT="FiraCode Nerd Font"

# Bar Appearance
bar=(
  color=$BAR_COLOR
  position=top
  topmost=window
  sticky=on
  height=25
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  corner_radius=0
  blur_radius=0
  display=main
  #notch_width=160
)

# Item Defaults
item_defaults=(
    icon.font="FiraCode Nerd Font:Medium:14.0"
    icon.color=$ICON_COLOR
    label.font="Fira Code:Medium:14.0"
    label.color=$LABEL_COLOR
    padding_left=5
    padding_right=5
    label.padding_left=4
    label.padding_right=4
    icon.padding_left=4
    icon.padding_right=4
  # background.color=$TRANSPARENT
  # background.padding_left=0
  # background.padding_right=0
  # background.corner_radius=0
  # icon.font="$SBARFONT:Semibold:14"
  # icon.color=$ICON_COLOR
  # icon.highlight_color=$HIGHLIGHT
  # icon.padding_left=$PADDINGS
  # icon.padding_right=0
  # label.font="$SBARFONT:Regular:14"
  # label.color=$LABEL_COLOR
  # label.highlight_color=$HIGHLIGHT
  # label.padding_left=$PADDINGS
  # label.padding_right=$PADDINGS
  # updates=when_shown
  # scroll_texts=on
)

icon_defaults=(
  alias.color=$ICON_COLOR
  label.drawing=off
  padding_left=0
  padding_right=-$PADDINGS
)

bracket_defaults=(
  # background.height=24
  # background.color=$BAR_COLOR
  # blur_radius=32
  # background.corner_radius=$PADDINGS
  # background.padding_left=$(($PADDINGS * 2))
  # background.padding_right=$(($PADDINGS * 2))
)

menu_defaults=(
  popup.blur_radius=32
  popup.background.color=$BAR_COLOR
  popup.background.corner_radius=$PADDINGS
  popup.background.shadow.drawing=on
  popup.background.border_width=1
  popup.background.border_color=$GREY_50
)

menu_item_defaults=(
  label.font="$SBARFONT:Medium:14"
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  icon.padding_left=0
  icon.padding_right=0
  background.color=$TRANSPARENT
)

separator=(
  background.height=1
  width=200
  background.color=$WHITE_50
  background.y_offset=-16
)
