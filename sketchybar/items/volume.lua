local styles = require("styles")

local volume = sbar.add("item", "volume", {
	position = "right",
	--click_script = "$CONFIG_DIR/plugins/volume_click.sh",
	icon = { string = "󰕾 " },
	popup = {
		align = "center",
	},
})

local icons = require("icons")
volume:subscribe("volume_change", function(env)
	local volumen = tonumber(env.INFO)
	local icon = icons.volume._100
	if volumen > 66 and volumen <= 100 then
		icon = icons.volume._100
	elseif volumen > 33 and volumen <= 66 then
		icon = icons.volume._66
	elseif volumen > 10 and volumen <= 33 then
		icon = icons.volume._33
	elseif volumen > 0 and volumen <= 10 then
		icon = icons.volume._10
	elseif volumen == 0 then
		icon = icons.volume._0
	end
	volume:set({ icon = { string = icon }, label = { string = env.INFO .. "%" } })
end)

local colors = require("colors")
local has_switchaudiosource = os.execute("which SwitchAudioSource >/dev/null")
local function is_popup(popup)
	if popup == nil then
		return false
	end
	return popup.drawing == "on"
end
local function volume_collapse_details()
	if not is_popup(volume:query().popup) then
		return
	end
	volume:set({ popup = { drawing = false } })
	sbar.remove("/volume.device\\.*/")
end

local current_audio_device = "None"
local function volume_toggle_details(env)
	if env.BUTTON == "right" then
		sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
		return
	end

	if not has_switchaudiosource then
		return
	end

	local popup = volume:query().popup
	if is_popup(popup) then
		volume_collapse_details()
		return
	end

	sbar.exec("SwitchAudioSource -t output -c", function(result)
		current_audio_device = result:sub(1, -2)
		sbar.exec("SwitchAudioSource -a -t output", function(available)
			local current = current_audio_device
			local counter = 0

			for device in string.gmatch(available, "[^\r\n]+") do
				local color = colors.white
				if current == device then
					color = colors.highlight
				end
				sbar.add("item", "volume.device." .. counter, {
					position = "popup." .. volume.name,
					align = "center",
					label = { string = device, color = color },
					icon = { drawing = false },
					click_script = 'SwitchAudioSource -s "'
						.. device
						.. '" && sketchybar --set /volume.device\\.*/ label.color='
						.. colors.white
						.. " --set $NAME label.color="
						.. colors.highlight,
				})
				counter = counter + 1
			end
			volume:set({ popup = { drawing = true } })
		end)
	end)
end

--volume_toggle_details()
volume:subscribe("mouse.clicked", volume_toggle_details)
volume:subscribe("mouse.exited.global", volume_collapse_details)
