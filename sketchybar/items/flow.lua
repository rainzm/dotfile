local styles = require("styles")
local colors = require("colors")

local flow = sbar.add("item", {
	position = "center",
	update_freq = 1,
	click_script = "sketchybar --set $NAME popup.drawing=toggle",
	icon = { string = "󰄉 " },
	popup = {
		horizontal = true,
		align = "center",
	},
})

local function setflow()
	local cmd =
		"osascript -e 'tell application \"Flow\" to getTime'; osascript -e 'tell application \"Flow\" to getPhase'"
	sbar.exec(cmd, function(result)
		local time, phase = result:match("([^\n]*)\n?([^\n]*)")
		local color = colors.green
		if phase == "暂停" or phase == "Break" then
			color = colors.red
		end
		flow:set({ label = { string = time .. " " .. phase }, icon = { color = color } })
	end)
end

flow:subscribe("routine", setflow)

local start = sbar.add("item", {
	position = "popup." .. flow.name,
	label = { string = "开始" },
	icon = { drawing = false },
})

start:subscribe("mouse.clicked", function(_)
	sbar.exec("osascript -e 'tell application \"Flow\" to start'", function(_)
		flow:set({ update_freq = 1, popup = { drawing = false } })
		setflow()
	end)
end)

local stop = sbar.add("item", {
	position = "popup." .. flow.name,
	label = { string = "停止" },
	icon = { drawing = false },
})

stop:subscribe("mouse.clicked", function(_)
	sbar.exec("osascript -e 'tell application \"Flow\" to stop'", function(_)
		flow:set({ update_freq = 0, popup = { drawing = false } })
		setflow()
	end)
end)

local skip = sbar.add("item", {
	position = "popup." .. flow.name,
	label = { string = "跳过" },
	icon = { drawing = false },
})

skip:subscribe("mouse.clicked", function(_)
	sbar.exec("osascript -e 'tell application \"Flow\" to skip'", function(_)
		flow:set({ update_freq = 0, popup = { drawing = false } })
		setflow()
	end)
end)

local reset = sbar.add("item", {
	position = "popup." .. flow.name,
	label = { string = "重置" },
	icon = { drawing = false },
})

reset:subscribe("mouse.clicked", function(_)
	sbar.exec("osascript -e 'tell application \"Flow\" to reset'", function(_)
		flow:set({ update_freq = 0, popup = { drawing = false } })
		setflow()
	end)
end)

local show = sbar.add("item", {
	position = "popup." .. flow.name,
	label = { string = "显示" },
	icon = { drawing = false },
})

show:subscribe("mouse.clicked", function(_)
	sbar.exec("osascript -e 'tell application \"Flow\" to show'", function(_)
		flow:set({ popup = { drawing = false } })
	end)
end)
