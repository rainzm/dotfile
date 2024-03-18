#!/bin/bash
#
flow=(
    update_freq=1
    script="$PLUGIN_DIR/flow.sh"
	click_script="sketchybar -m --set flow popup.drawing=toggle"
	popup.horizontal=on
	popup.align=center
)

sketchybar --add item flow center \
           --set flow "${menu_defaults[@]}" \
           "${flow[@]}" \
	   --add item flow.start popup.flow \
	   --set flow.start "${menu_item_defaults[@]}" \
       label="Start" \
	                    click_script="osascript -e 'tell application \"Flow\" to start' ; sketchybar -m --set flow popup.drawing=toggle" \
	   		    \
	   --add item flow.stop popup.flow \
	   --set flow.stop "${menu_item_defaults[@]}" \
       label="Stop" \
	                   click_script="osascript -e 'tell application \"Flow\" to stop' ; sketchybar -m --set flow popup.drawing=toggle" \
	   		   \
	   --add item flow.skip popup.flow \
	   --set flow.skip "${menu_item_defaults[@]}" \
       label="Skip" \
	                   click_script="osascript -e 'tell application \"Flow\" to skip' ; sketchybar -m --set flow popup.drawing=toggle" \
			   \
	   --add item flow.reset popup.flow \
	   --set flow.reset "${menu_item_defaults[@]}" \
       label="Reset" \
	                   click_script="osascript -e 'tell application \"Flow\" to reset' ; sketchybar -m --set flow popup.drawing=toggle" \
			   \
	   --add item flow.show popup.flow \
	   --set flow.show "${menu_item_defaults[@]}" \
       label="Show" \
	                   click_script="osascript -e 'tell application \"Flow\" to show' ; sketchybar -m --set flow popup.drawing=toggle"
