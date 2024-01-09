#!/bin/env/bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

POPUP_OFF='sketchybar --set logo popup.drawing=off'

logo=(
  icon=􀣺 
  icon.font="$SBARFONT:Medium:16.0"
  label.drawing=off
  icon.padding_left=$PADDINGS
  icon.padding_right=$PADDINGS
  popup.align=left
  click_script="sketchybar --set logo popup.drawing=toggle"
)

logo_about=(
  icon=􀅴 
  label="关于本机"
  click_script="open -a 'System Information'; $POPUP_OFF"
)

logo_settings=(
  icon=􀍟 
  label="系统设置"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

logo_activity=(
  icon=􀜚 
  label="活动监视器"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

logo_lock=(
  icon=􀼑 
  label="锁定屏幕"
  click_script="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'; $POPUP_OFF"
)

logo_refresh=(
  icon=􀅈 
  label="刷新 Sketchybar"
  click_script="$POPUP_OFF; sketchybar --update"
)

sketchybar --add item logo left                       \
  --set logo "${menu_defaults[@]}"                    \
  "${logo[@]}"                                        \
  --subscribe logo mouse.exited                       \
                   mouse.exited.global                \
                                                      \
  --add item logo.about popup.logo                    \
  --set logo.about "${menu_item_defaults[@]}"         \
  "${logo_about[@]}"                                  \
  "${separator[@]}"                                   \
                                                      \
  --add item logo.settings popup.logo                 \
  --set logo.settings "${menu_item_defaults[@]}"      \
  "${logo_settings[@]}"                               \
                                                      \
  --add item logo.activity popup.logo                 \
  --set logo.activity "${menu_item_defaults[@]}"      \
  "${logo_activity[@]}"                               \
                                                      \
  --add item logo.lock_screen popup.logo              \
  --set logo.lock_screen "${menu_item_defaults[@]}"   \
  "${logo_lock[@]}"                                   \
                                                      \
  --add item logo.refresh popup.logo                  \
  --set logo.refresh "${menu_item_defaults[@]}"       \
  "${logo_refresh[@]}"
