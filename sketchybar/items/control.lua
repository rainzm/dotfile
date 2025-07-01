local styles = require("styles")
local control = sbar.add("item", "controler", {
	position = "right",
	icon = {
		string = ":rekordbox:",
		font = {
			family = "sketchybar-app-font",
			style = "Regular",
			size = styles.font_size,
		},
	},
	label = { drawing = false },
	click_script = 'osascript -e \'tell application "System Events" to tell process "控制中心" to click menu bar item 2 of menu bar 1\'',
})
