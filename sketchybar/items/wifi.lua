local helper = require("helper")
local styles = require("styles")
local colors = require("colors")
local wifi = sbar.add("item", "wifi", {
	position = "right",
	update_freq = 5,
	--updates = "when_shown",
	click_script = helper.popup_toggle,
	label = { drawing = false },
	icon = { y_offset = 0 },
	popup = {
		horizontal = false,
		align = "center",
	},
})

local wifi_ssid = sbar.add("item", {
	position = "popup." .. wifi.name,
	icon = { string = "􀅴 ", drawing = true },
	label = { string = "SSID" },
	click_script = "open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';sketchybar --set "
		.. wifi.name
		.. " popup.drawing=off",
})

local wifi_strength = sbar.add("item", {
	position = "popup." .. wifi.name,
	icon = { string = "􀋨 " },
	label = { string = "Speed" },
	click_script = "open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';sketchybar --set "
		.. wifi.name
		.. " popup.drawing=off",
})

local wifi_ipaddress = sbar.add("item", {
	position = "popup." .. wifi.name,
	icon = { string = "􀆪 " },
	label = { string = "IP Address" },
})

local function trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function update()
	sbar.exec(
		"sudo wdutil info && networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}' | xargs networksetup -getairportnetwork",
		function(wifi_info)
			local ssid, tx_rate, ip_address = "", "", "", ""
			for line in string.gmatch(wifi_info, "([^\n]*)\n?") do
				if ssid ~= "" and tx_rate ~= "" and ip_address ~= "" then
					break
				end
				local key, value = string.match(line, "^%s*([^:]-)%s*:%s*(.*)$")
				if key and value then
					if trim(key) == "Current Wi-Fi Network" then
						ssid = trim(value)
					elseif trim(key) == "Tx Rate" then
						tx_rate = trim(value)
					elseif trim(key) == "IPv4 Address" then
						ip_address = trim(value)
					end
				end
			end
			local icon = ""
			local icon_color = ""
			if ssid ~= "" then
				icon = "􀙇 "
				icon_color = colors.white
			elseif wifi_info == "AirPort: Off" then
				icon = "􀙈 "
				icon_color = colors.red
			else
				icon = "􀙈 "
				icon_color = colors.white_25
			end
			wifi:set({ icon = { string = icon, color = icon_color } })
			if ssid ~= "" then
				wifi:set({ click_script = helper.popup_toggle })
				wifi_ssid:set({ label = { string = ssid } })
				wifi_strength:set({ label = { string = tx_rate } })
				wifi_ipaddress:set({
					label = { string = ip_address },
					click_script = "echo "
						.. ip_address
						.. " | pbcopy;sketchybar --set "
						.. wifi.name
						.. " popup.drawing=off",
				})
			else
				wifi:set({ click_script = "" })
			end
		end
	)
end

wifi:subscribe({ "routine" }, update)

update()
