local styles = require("styles")
local mail = sbar.add("item", "mail", {
	position = "right",
	icon = {
		string = ":mail:",
		font = {
			family = "sketchybar-app-font",
			style = "Regular",
			size = styles.font_size,
		},
	},
	label = { string = "?", y_offset = 0 },
	update_freq = 60,
})

local colors = require("colors")

local function update(with_click)
	sbar.exec("osascript -e 'tell application \"Mail\" to return the unread count of inbox'", function(result)
		local mail_count = tonumber(result)
		if mail_count == 0 then
			mail:set({
				label = { string = result, drawing = true },
				icon = { color = colors.icon_color, drawing = true },
			})
		else
			if with_click then
				sbar.exec("open -a Mail", function() end)
			end
			mail:set({
				label = { string = result, drawing = true },
				icon = { color = colors.blue, drawing = true },
			})
		end
	end)
end

local function click()
	update(true)
end

mail:subscribe("routine", function()
	update(false)
end)

mail:subscribe("mouse.clicked", click)

update()
