#!/bin/env/bash
#
network_down=(
	y_offset=-5
	label.font="Fira Code:Medium:10.0"
	icon="$NETWORK_DOWN"
	icon.font="$SBARFONT:Bold:11.0"
	icon.color="$WHITE"
	icon.highlight_color="$GREEN"
	update_freq=2
)

network_up=(
	background.padding_right=-75
	y_offset=5
	label.font="Fira Code:Medium:10.0"
	icon="$NETWORK_UP"
	icon.font="$SBARFONT:Bold:11.0"
	icon.color="$WHITE"
	icon.highlight_color="$GREEN"
	update_freq=2
	script="$PLUGIN_DIR/network.sh"
)

sketchybar 	--add item network.down right 						\
						--set network.down "${network_down[@]}" 	\
						--add item network.up right 							\
						--set network.up "${network_up[@]}"
