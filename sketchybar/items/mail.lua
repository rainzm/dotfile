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
	label = { string = "?" },
	update_freq = 60,
	click_script = "open -a Mail",
})

local colors = require("colors")

local function update()
	sbar.exec("osascript -e 'tell application \"Mail\" to return the unread count of inbox'", function(result)
		local mail_count = tonumber(result)
		if mail_count == 0 then
			mail:set({
				label = { string = result, drawing = true },
				icon = { color = colors.icon_color, drawing = true },
			})
		else
			mail:set({
				label = { string = result, drawing = true },
				icon = { color = colors.blue, drawing = true },
			})
		end
	end)
end

mail:subscribe("routine", update)

update()
