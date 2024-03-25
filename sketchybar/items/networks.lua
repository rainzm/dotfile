local colors = require("colors")
local icons = require("icons")
local network_down_attrs = {
	y_offset = -5,
	label = {
		font = {
			size = 10.0,
		},
	},
	icon = {
		string = icons.network.down,
		font = {
			style = "Bold",
			size = 11.0,
		},
		color = colors.white,
		highlight_color = colors.green,
	},
	update_freq = 2,
	position = "right",
	padding_left = 5,
}

local network_up_attrs = {
	padding_right = -75,
	y_offset = 5,
	label = {
		font = {
			size = 10.0,
		},
	},
	icon = {
		string = icons.network.up,
		font = {
			style = "Bold",
			size = 11.0,
		},
		color = colors.white,
		highlight_color = colors.green,
	},
	position = "right",
}

local network_down = sbar.add("item", "network.down", network_down_attrs)
local network_up = sbar.add("item", "network.up", network_up_attrs)

local function update()
	sbar.exec('ifstat -i "en0" -b 0.1 1 | tail -n1', function(result)
		local speeds = {}
		for num in string.gmatch(result, "%d+%.%d+") do
			table.insert(speeds, num)
		end
		local down = tonumber(speeds[1]) / 8
		local up = tonumber(speeds[2]) / 8
		local down_label = ""
		if down > 999 then
			down_label = string.format("%03.0f MB/s", down / 1000)
		else
			down_label = string.format("%03.0f KB/s", down)
		end
		local up_label = ""
		if up > 999 then
			up_label = string.format("%03.0f MB/s", up / 1000)
		else
			up_label = string.format("%03.0f KB/s", up)
		end
		network_down:set({
			label = { string = down_label },
			icon = { highlight = down > 0 },
		})
		network_up:set({
			label = { string = up_label },
			icon = { highlight = up > 0 },
		})
	end)
end

network_down:subscribe("routine", update)

update()
