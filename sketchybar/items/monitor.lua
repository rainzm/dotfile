local styles = require("styles")

sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/cpu_load/bin/cpu_load cpu_update 2.0")

local ram_label = sbar.add("item", "ram_label", {
	position = "right",
	label = {
		string = "RAM",
		font = {
			size = 7.0 + styles.font_rel,
		},
	},
	icon = {
		drawing = false,
	},
	y_offset = 6,
	width = 0,
})

local ram = sbar.add("item", "ram_percent", {
	position = "right",
	icon = {
		drawing = false,
	},
	label = {
		string = "??%",
		font = {
			style = "Bold",
			size = 11.0 + styles.font_rel,
		},
	},
	y_offset = -3,
	update_freq = 2,
})

local cpu_label = sbar.add("item", "cpu_label", {
	position = "right",
	label = {
		string = "CPU",
		font = {
			size = 7.0 + styles.font_rel,
		},
	},
	icon = {
		drawing = false,
	},
	y_offset = 6,
	width = 0,
})

local cpu = sbar.add("item", "cpu_percent", {
	position = "right",
	icon = {
		drawing = false,
	},
	label = {
		string = "??%",
		font = {
			style = "Bold",
			size = 11.0 + styles.font_rel,
		},
	},
	y_offset = -3,
})

cpu:subscribe("cpu_update", function(env)
	cpu:set({
		label = env.total_load .. "%",
	})
end)

cpu:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Activity Monitor'")
end)

cpu_label:subscribe("mouse.clicked.entered", function(env)
	sbar.exec("open -a 'Activity Monitor'")
end)

ram:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Activity Monitor'")
end)

ram_label:subscribe("mouse.clicked.entered", function(env)
	sbar.exec("open -a 'Activity Monitor'")
end)

ram:subscribe("routine", function()
	sbar.exec(
		[[memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }']],
		function(result)
			ram:set({ label = { string = result .. "%" } })
		end
	)
end)
