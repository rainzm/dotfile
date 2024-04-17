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

-- front_app:subscribe("front_app_switched", function(env)
-- 	front_app:set({
-- 		label = {
-- 			string = env.INFO,
-- 		},
-- 	})
-- end)

local function front_window()
	sbar.exec("yabai -m query --windows --window", function(result)
		if type(result) ~= "table" then
			return
		end
		local app = result["app"]
		local stack_index = result["stack-index"]
		if stack_index == 0 then
			front_app:set({
				label = {
					string = app,
				},
			})
			return
		end
		sbar.exec("yabai -m query --windows --window stack.last", function(ret)
			local label = string.format("%s %d/%d", app, stack_index, ret["stack-index"])
			front_app:set({
				label = {
					string = label,
				},
			})
		end)
	end)
end

front_app:subscribe("window_focus", front_window)

front_window()
