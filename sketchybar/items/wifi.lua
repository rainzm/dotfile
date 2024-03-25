local helper = require("helper")
local styles = require("styles")
local colors = require("colors")
local wifi = sbar.add("item", "wifi", {
	position = "right",
	update_freq = 5,
	--updates = "when_shown",
	click_script = helper.popup_toggle,
	label = { drawing = false },
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

local function update()
	sbar.exec(
		"/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I",
		function(wifi_info)
			local ssid = ""
			for line in wifi_info:gmatch("[^\r\n]+") do
				if line:find("SSID:") and not line:find("BSSID:") then
					ssid = line:match("SSID:%s*(.-)$")
					break
				end
			end
			local tx_rate = wifi_info:match("lastTxRate:%s*(%d+)")
			local ip_address = io.popen("ipconfig getifaddr en0"):read("*a"):gsub("\n", "")
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
				wifi_strength:set({ label = { string = tx_rate .. " Mbps" } })
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
