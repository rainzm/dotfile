#!/bin/bash

update() {
  source "$CONFIG_DIR/colors.sh"
  COLOR=$TRANSPARENT
  if [ "$SELECTED" = "true" ]; then
    COLOR=$HIGHLIGHT
  fi
  sketchybar --set $NAME icon.highlight=$SELECTED \
                         label.highlight=$SELECTED \
                         background.color=$COLOR
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ] || [ "$MODIFIER" = "shift" ]; then
    SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
    if [ $? -eq 0 ]; then
      if [ "$SPACE_LABEL" = "" ]; then
        set_space_label "${NAME:6}"
      else
        set_space_label "${NAME:6} $SPACE_LABEL"
      fi
    fi
  else
    yabai -m space --focus $SID 2>/dev/null
  fi
}

create_icons() {
  source "$CONFIG_DIR/plugins/icon_map_fn.sh"
  args=(--animate sin 10)

  echo "receive space_windows_change" >> ~/bar.log

  space="$(echo "$INFO" | jq -r '.space')"
  apps="$(echo "$INFO" | jq -r '.apps | keys[]')"

  echo "INFO: ${INFO}" >> ~/bar.log
  echo "apps: ${apps}" >> ~/bar.log

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_map "${app}"
      icon_strip+=" ${icon_result}"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi
  args+=(--set space.$space label="$icon_strip")

  sketchybar -m "${args[@]}"
  echo "${args[@]}" >> ~/bar.log
}

case "$SENDER" in
  "mouse.clicked")
  mouse_clicked
  ;;
  "space_windows_change")
  create_icons
  ;;
  *) update
  ;;
esac
