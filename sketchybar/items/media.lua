local helper = require("helper")
local styles = require("styles")
local media_ctrl = sbar.add("item", "media_ctrl", {
	position = "right",
	icon = {
		font = {
			family = "sketchybar-app-font",
			style = "Regular",
			size = styles.font_size,
		},
	},
	label = { drawing = false },
	--script = "$PLUGIN_DIR/media_ctrl.sh",
	click_script = "sketchybar -m --set media_ctrl popup.drawing=toggle",
	popup = {
		horizontal = true,
		align = "center",
		height = 150,
	},
})

local media_ctrl_cover = sbar.add("item", "media_ctrl.cover", {
	position = "popup.media_ctrl",
	--script = "$PLUGIN_DIR/media_ctrl.sh",
	label = { drawing = false },
	icon = { drawing = false },
	background = {
		image = {
			scale = 0.4,
			drawing = true,
		},
		drawing = true,
	},
})

local media_ctrl_title = sbar.add("item", "media_ctrl.title", {
	position = "popup.media_ctrl",
	icon = { drawing = false },
	padding_left = 0,
	padding_right = 0,
	width = 0,
	label = {
		max_chars = 13,
	},
	y_offset = 55,
})

local media_ctrl_artist = sbar.add("item", "media_ctrl.artist", {
	position = "popup.media_ctrl",
	icon = { drawing = false },
	y_offset = 30,
	padding_left = 0,
	padding_right = 0,
	width = 0,
	label = {
		max_chars = 13,
	},
})

local media_ctrl_album = sbar.add("item", "media_ctrl.album", {
	position = "popup.media_ctrl",
	icon = { drawing = false },
	padding_left = 0,
	padding_right = 0,
	y_offset = 10,
	width = 0,
	label = {
		max_chars = 13,
	},
})

local colors = require("colors")
local media_ctrl_back = sbar.add("item", "media_ctrl.back", {
	position = "popup.media_ctrl",
	icon = {
		string = "􀊎 ",
		padding_left = 5,
		padding_right = 5,
		color = colors.black,
	},
	click_script = "/usr/local/bin/nowplaying-cli previous",
	label = { drawing = false },
	y_offset = -45,
})

local media_ctrl_play = sbar.add("item", "media_ctrl.play", {
	position = "popup.media_ctrl",
	icon = {
		string = "􀊔 ",
		padding_left = 4,
		padding_right = 5,
	},
	width = 100,
	align = "center",
	background = {
		height = 40,
		corner_radius = 20,
		color = colors.popup_background_color,
		border_color = colors.white,
		border_width = 0,
		drawing = true,
	},
	updates = true,
	click_script = "media-control toggle-play-pause",
	label = { drawing = false },
	y_offset = -45,
})

local media_ctrl_next = sbar.add("item", "media_ctrl.next", {
	position = "popup.media_ctrl",
	icon = {
		string = "􀊐 ",
		padding_left = 5,
		padding_right = 5,
		color = colors.black,
	},
	click_script = "/usr/local/bin/nowplaying-cli next",
	label = { drawing = false },
	y_offset = -45,
})

sbar.add("item", "media_ctrl.spacer", {
	position = "popup.media_ctrl",
	width = 5,
})

sbar.add(
	"bracket",
	"media_ctrl.controls",
	{
		"media_ctrl.back",
		"media_ctrl.play",
		"media_ctrl.next",
	},
	styles.bracket({
		background = {
			color = colors.green,
			corner_radius = 11,
			drawing = true,
		},
		y_offset = -45,
	})
)

local function update()
	sbar.exec(
		"media-control get",
		function(result)
            local title = result.title
            local artist = result.artist
            local album = result.album
            local playing = result.playing -- 转为 boolean
			if title == "" then
				print("media title is empty")
				return
			end
			media_ctrl_title:set({ label = { string = title } })
			media_ctrl_artist:set({ label = { string = artist } })
			media_ctrl_album:set({ label = { string = album } })
			media_ctrl_play:set({ icon = { string = playing and "􀊆" or "􀊄 " } })
			media_ctrl:set({
				icon = { string = helper.app_icon("QQMusic") },
				--label = { string = app .. ": " .. title },
				drawing = true,
			})
            local data = result.artworkData
			local file = io.open("/tmp/cover.jpg", "wb")
			local decoded = helper.base64_decode(data)
			if file == nil then
				print("cover file is nil")
				return
			end
			file:write(decoded)
			file:close()
			media_ctrl_cover:set({
				background = {
					drawing = true,
					image = { string = "/tmp/cover.jpg", drawing = true },
					color = "0x00000000",
				},
			})
		end
	)
end

media_ctrl:subscribe("media_change", update)
media_ctrl:subscribe("mouse.exited.global", function()
	media_ctrl:set({ popup = { drawing = false } })
end)

update()
