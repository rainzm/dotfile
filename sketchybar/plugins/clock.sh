#!/bin/zsh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

sketchybar --set $NAME label="$(LANG=zh_CN.UTF-8 date +'%m月%d日 周%a %H:%M' | sed 's/^0//; s/月0/月/; s/日0/日/')"
