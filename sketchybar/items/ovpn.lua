local styles = require("styles")
local colors = require("colors")
local ovpn = sbar.add("item", "ovpn", {
	position = "right",
	icon = {
		string = ":openvpn_connect:",
		color = colors.icon_color,
		font = {
			family = "sketchybar-app-font",
			style = "Regular",
			size = styles.font_size,
		},
	},
	label = { drawing = false },
})

local function update()
	sbar.exec("ps aux | grep openvpn | grep -v grep", function(result)
		if result and result ~= "" then
			ovpn:set({
				icon = { color = colors.icon_color },
			})
		else
			ovpn:set({
				icon = { color = colors.icon_color_inactive },
			})
		end
	end)
end

local function click()
	sbar.exec("ps aux | grep openvpn | grep -v grep", function(result)
		if result and result ~= "" then
            print("Stopping OpenVPN...")
			sbar.exec("sudo pkill openvpn", function()
			    ovpn:set({
				    icon = { color = colors.icon_color_inactive },
			    })
			end)
		else
			sbar.exec(
				"sudo /opt/homebrew/opt/openvpn/sbin/openvpn --config ~/.config/openvpn/work.ovpn --auth-user-pass ~/.config/openvpn/ovpnup --daemon openvpn",
				function()
					update()
				end
			)
		end
	end)
end

ovpn:subscribe("mouse.clicked", click)

update()
