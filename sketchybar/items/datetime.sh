#!/bin/env/bash

sketchybar                                                     \
  --add item clock right                                       \
  --set clock   update_freq=10                        \
  align=right                                                   \
  popup.align=right                                             \
  "${menu_defaults[@]}"                  \
  script="$PLUGIN_DIR/nextevent.sh"         \
  click_script="sketchybar --set clock popup.drawing=toggle; open -a Calendar.app"\
  --subscribe clock system_woke                                 \
                    mouse.entered                               \
                    mouse.exited                                \
                    mouse.exited.global                         \
  --add item clock.details popup.clock                          \
  --set clock.details "${menu_item_defaults[@]}"
