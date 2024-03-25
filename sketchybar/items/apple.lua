local icons = require("icons")
local logo = {
	position = "left",
	icon = {
		string = icons.apple,
		font = {
			size = 16,
		},
		-- padding_left = styles.padding,
		-- padding_right = styles.padding,
	},
	label = {
		drawing = false,
	},
	popup = {
		align = "left",
	},
	click_script = "sketchybar --set $NAME popup.drawing=toggle",
}

local apple_logo = sbar.add("item", "apple", logo)

local logo_about = sbar.add("item", {
	position = "popup." .. apple_logo.name,
	icon = { string = "􀅴 " },
	label = { string = "关于本机" },
})

logo_about:subscribe("mouse.clicked", function(_)
	sbar.exec("open -a 'System Information'")
	apple_logo:set({ popup = { drawing = false } })
end)

-- wirte like logo_about
local logo_settings = sbar.add("item", {
	position = "popup." .. apple_logo.name,
	icon = { string = "􀍟 " },
	label = { string = "系统设置" },
})

logo_settings:subscribe("mouse.clicked", function(_)
	sbar.exec("open -a 'System Preferences'")
	apple_logo:set({ popup = { drawing = false } })
end)

local logo_activity = sbar.add("item", {
	position = "popup." .. apple_logo.name,
	icon = { string = "􀜚 " },
	label = { string = "活动监视器" },
})

logo_activity:subscribe("mouse.clicked", function(_)
	sbar.exec("open -a 'Activity Monitor'")
	apple_logo:set({ popup = { drawing = false } })
end)

local logo_lock = sbar.add("item", {
	position = "popup." .. apple_logo.name,
	icon = { string = "􀼑 " },
	label = { string = "锁定屏幕" },
})

logo_lock:subscribe("mouse.clicked", function(_)
	sbar.exec('osascript -e \'tell application "System Events" to keystroke "q" using {command down,control down}\'')
	apple_logo:set({ popup = { drawing = false } })
end)

local logo_refresh = sbar.add("item", {
	position = "popup." .. apple_logo.name,
	icon = { string = "􀅈 " },
	label = { string = "刷新 Sketchybar" },
})

logo_refresh:subscribe("mouse.clicked", function(_)
	apple_logo:set({ popup = { drawing = false } })
	sbar.exec("sketchybar --update")
end)
