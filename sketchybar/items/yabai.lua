local colors = require("colors")
local icons = require("icons")
local yabai = {}

local width = 40
local function setyabai(iconstr, labelstr, color, localwidth)
	local icon = { string = iconstr, color = color }
	local label = { string = labelstr }
	if localwidth then
		sbar.animate("sin", 10.0, function()
			yabai:set({ icon = icon, label = label, width = localwidth })
		end)
	else
		sbar.animate("sin", 10.0, function()
			yabai:set({ icon = icon, label = label, width = width })
		end)
	end
end

local function window_state(_)
	sbar.exec("yabai -m query --windows --window", function(result)
		if type(result) ~= "table" then
			setyabai(icons.yabai.grid, "", colors.label_color)
			return
		end
		local stack_index = result["stack-index"]
		if stack_index > 0 then
			-- 	setyabai(
			-- 		icons.yabai.stack,
			-- 		string.format("[%d of %d]", stack_index, ret["stack-index"]),
			-- 		colors.red,
			-- 		105
			-- 	)
			-- sbar.exec("yabai -m query --windows --window stack.last", function(ret)
			-- 	setyabai(
			-- 		icons.yabai.stack,
			-- 		string.format("[%d of %d]", stack_index, ret["stack-index"]),
			-- 		colors.red,
			-- 		105
			-- 	)
			-- end)
			setyabai(icons.yabai.stack, "", colors.red)
		elseif result["has-fullscreen-zoom"] then
			setyabai(icons.yabai.fullscreen, "", colors.green)
		elseif result["split-type"] == "vertical" then
			setyabai(icons.yabai.split_v, "", colors.label_color)
		elseif result["split-type"] == "horizontal" then
			setyabai(icons.yabai.split_h, "", colors.label_color)
		elseif result["is-floating"] then
			setyabai(icons.yabai.float, "", colors.green)
		elseif result["has-parent-zoom"] then
			setyabai(icons.yabai.parent, "", colors.blue)
		else
			setyabai(icons.yabai.grid, "", colors.label_color)
		end
	end)
end

local function mouse_clicked(_)
	sbar.exec("yabai -m window --toggle zoom-fullscreen", function() end)
end

yabai = sbar.add("item", "yabai", {
	icon = { string = icons.yabai.grid },
	label = { color = colors.label_color },
})

yabai:subscribe("mouse.clicked", mouse_clicked)
yabai:subscribe("window_focus", window_state)

window_state()
