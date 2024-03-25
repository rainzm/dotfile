local icons = require("icons")
local styles = require("styles")
local battery = sbar.add("item", "battery", {
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
	-- padding_right = 5,
	-- padding_left = 0,
	update_freq = 120,
	position = "right",
})

local function battery_update()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = "!"

		local drawing = true
		if string.find(batt_info, "AC Power") then
			icon = icons.battery.charging
			drawing = false
		else
			local found, _, charge = batt_info:find("(%d+)%%")
			if found then
				charge = tonumber(charge)
			end

			if found and charge > 80 then
				icon = icons.battery._100
			elseif found and charge > 60 then
				icon = icons.battery._75
			elseif found and charge > 40 then
				icon = icons.battery._50
			elseif found and charge > 20 then
				icon = icons.battery._25
			else
				icon = icons.battery._0
			end
		end
		if drawing then
			battery:set({
				icon = { string = icon, drawing = drawing },
				padding_right = styles.padding,
				padding_left = styles.padding,
			})
		else
			battery:set({ icon = { string = icon, drawing = drawing }, padding_right = 0, padding_left = 0 })
		end
	end)
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, battery_update)
