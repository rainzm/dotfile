local colors = require("colors")
local styles = require("styles")
local helper = require("helper")
local spaces = {}

local function mouse_click(env)
	if env.BUTTON == "right" or env.MODIFIER == "shift" then
		local command =
			'osascript -e "return (text returned of (display dialog \\"Give a name to space $NAME:\\" default answer \\"\\" with icon note buttons {\\"Cancel\\", \\"Continue\\"} default button \\"Continue\\"))"'
		sbar.exec(command, function(result)
			spaces[tonumber(env.SID)]:set({ icon = { string = env.SID .. " " .. result } })
		end)
	else
		sbar.exec("yabai -m space --focus " .. env.SID)
	end
end

local function space_selection(env)
	local color = env.SELECTED == "true" and colors.highlight or colors.transparent
	sbar.set(env.NAME, {
		icon = { highlight = env.SELECTED },
		label = { highlight = env.SELECTED },
		background = { color = color },
	})
end

local function space_windows_change(env)
	local space = env.INFO.space
	local apps = env.INFO.apps
	local icon_strip = " "
	for app in pairs(apps) do
		icon_strip = icon_strip .. helper.app_icon(app)
	end
	if icon_strip == " " then
		icon_strip = " —"
	end
	sbar.animate("sin", 10.0, function()
		spaces[tonumber(space)]:set({ label = { string = icon_strip } })
	end)
end

for i = 1, 12, 1 do
	local space = sbar.add("space", "space." .. tostring(i), {
		associated_space = i,
		icon = {
			string = i,
			padding_left = 0,
			padding_right = -styles.padding / 2,
			highlight_color = colors.highlight,
		},
		padding_left = styles.padding,
		padding_right = styles.padding,
		label = {
			padding_right = styles.padding,
			color = colors.white_50,
			highlight_color = colors.highlight,
			font = {
				family = "sketchybar-app-font",
				style = "Regular",
				size = styles.font_size,
			},
			y_offset = -1,
		},
		background = {
			height = 2,
			y_offset = 2 - styles.font_size,
		},
	})

	spaces[i] = space
	space:subscribe("space_change", space_selection)
	space:subscribe("mouse.clicked", mouse_click)
	space:subscribe("space_windows_change", space_windows_change)
end
