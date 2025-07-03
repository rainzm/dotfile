local colors = require("colors")
local taskman = sbar.add("item", "taskman", {
	position = "center",
	icon = { string = " ", color = colors.green },
	label = { string = "今天没有任务啦!" },
	popup = { align = "center" },
})

local function is_popup(popup)
	if popup == nil then
		return false
	end
	return popup.drawing == "on"
end
local function task_collapse_details()
	if not is_popup(taskman:query().popup) then
		return
	end
	taskman:set({ popup = { drawing = false } })
	sbar.remove("/taskman.list\\.*/")
end

local function _update_title(tasks)
	if #tasks == 0 then
		taskman:set({ icon = { color = colors.green }, label = { string = "今天没有任务啦!" } })
	else
		taskman:set({ icon = { color = colors.red }, label = { string = tasks[1].title } })
	end
	return tasks
end

local function update_title(tasks)
	if tasks then
		_update_title(tasks)
	end
	sbar.exec("/Users/rain/Library/Python/3.9/bin/things-cli -j today", function(tasks)
		--today_tasks = tasks
		_update_title(tasks)
	end)
end

local function task_toggle_details(env)
	if env.BUTTON == "right" then
		update_title()
		return
	end

	local popup = taskman:query().popup
	if is_popup(popup) then
		task_collapse_details()
		return
	end

	sbar.exec("/Users/rain/Library/Python/3.9/bin/things-cli -j today", function(undone_tasks)
		for i, undone in ipairs(undone_tasks) do
			local name = "taskman.list." .. tostring(i)
			local taskone = sbar.add("item", name, {
				position = "popup.taskman",
				align = "center",
				label = { string = undone.title },
				icon = { string = "􀅴 ", color = colors.red },
			})
			taskone:subscribe("mouse.clicked", function()
				sbar.animate("sin", 10.0, function()
					sbar.remove(name)
				end)
				sbar.exec(
					"things update --completed --id=" .. undone.uuid .. " --auth-token=4KbaAwBgAAAQCmdKAQAAAA",
					function(result)
						update_title()
						if #undone_tasks == 1 then
							taskman:set({ popup = { drawing = false } })
						end
					end
				)
			end)
		end
		update_title(undone_tasks)
		taskman:set({ popup = { drawing = true } })
	end)
end

taskman:subscribe("mouse.clicked", task_toggle_details)
taskman:subscribe("mouse.exited.global", task_collapse_details)

update_title()
