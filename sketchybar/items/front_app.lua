sbar.add("item", {
	icon = {
		string = " ",
	},
	padding_left = 10,
	padding_right = 10,
	label = {
		drawing = false,
	},
})

local front_app = sbar.add("item", {
	icon = {
		drawing = false,
	},
})

front_app:subscribe("front_app_switched", function(env)
	front_app:set({
		label = {
			string = env.INFO,
		},
	})
end)
