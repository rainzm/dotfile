#!/bin/bash

volume=(
  script="$PLUGIN_DIR/volume.sh"
  click_script="$PLUGIN_DIR/volume_click.sh"
)

sketchybar --add item volume right \
           --set volume "${volume[@]}" \
           --subscribe volume volume_change
