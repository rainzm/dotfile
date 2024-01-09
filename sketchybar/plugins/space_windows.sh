#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
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
fi
