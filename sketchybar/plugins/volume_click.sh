#!/bin/bash

toggle_devices() {
  which SwitchAudioSource >/dev/null || exit 0
  source "$CONFIG_DIR/colors.sh"
  source "$CONFIG_DIR/globalstyles.sh"
  
  args=(--remove '/volume.device\.*/' --set "$NAME" popup.drawing=toggle "${menu_defaults[@]}")
  COUNTER=0
  CURRENT="$(SwitchAudioSource -t output -c)"
  while IFS= read -r device; do
    COLOR=$WHITE
    ICON=􀆅
    ICON_COLOR=$TRANSPARENT
    if [ "${device}" = "$CURRENT" ]; then
      COLOR=$HIGHLIGHT
      ICON=􀆅
      ICON_COLOR=$COLOR
    fi

    args+=(--add item volume.device.$COUNTER popup."$NAME" \
           --set volume.device.$COUNTER label="${device}" \
                                        label.color="$COLOR" \
                                        icon=$ICON \
                                        icon.color=$ICON_COLOR \
                                        "${menu_item_defaults[@]}" \
                 click_script="SwitchAudioSource -s \"${device}\" && sketchybar --set /volume.device\.*/ label.color=$GREY --set \$NAME label.color=$WHITE --set $NAME popup.drawing=off")
    COUNTER=$((COUNTER+1))
  done <<< "$(SwitchAudioSource -a -t output)"

  sketchybar -m "${args[@]}" > /dev/null
}

if [ "$BUTTON" = "left" ] || [ "$MODIFIER" = "shift" ]; then
  toggle_devices
fi
