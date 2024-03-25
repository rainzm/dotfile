local colors = require("colors")
local helper = require("helper")

local padding = 6
local font_size = 14.0
local space_padding = 8
local icon_label_padding = 4

local font = {
	family = "FiraCode Nerd Font",
	style = "Medium",
	size = 14.0,
}

local bar = {
	color = colors.bar_color,
	position = "top",
	topmost = "window",
	sticky = "on",
	height = 25,
	--height = 39,
	padding_left = padding,
	padding_right = padding,
	corner_radius = 0,
	blur_radius = 0,
	display = "main",
	-- notch_width=160
}

local item = {
	icon = {
		font = {
			family = "FiraCode Nerd Font",
			style = "Medium",
			size = font_size,
		},
		color = colors.icon_color,
		padding_left = icon_label_padding,
		padding_right = icon_label_padding,
	},
	label = {
		font = {
			family = "Fira Code",
			style = "Medium",
			size = font_size,
		},
		color = colors.label_color,
		padding_left = icon_label_padding,
		padding_right = icon_label_padding,
	},
	padding_left = padding,
	padding_right = padding,
	popup = {
		blur_radius = 32,
		background = {
			color = colors.popup_background_color,
			corner_radius = padding,
			shadow = {
				drawing = true,
			},
			border_width = 1,
			border_color = colors.grey_50,
		},
	},
}

local _bracket = {
	background = {
		height = 24,
		color = colors.bar_color,
		corner_radius = 0,
		padding_left = 5,
		padding_right = 5,
	},
	blur_radius = 32,
}

local separator = {
	background = {
		height = 1,
		color = colors.white_50,
		y_offset = -16,
	},
	width = 200,
}

return {
	padding = padding,
	spance_padding = space_padding,
	font = font,
	font_size = font_size,
	bar = bar,
	item = item,
	bracket = function(...)
		return helper.merge_tables(_bracket, ...)
	end,
	separator = separator,
}
