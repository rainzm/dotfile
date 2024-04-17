local journalPath = "/Users/rain/Documents/neorg/work/journal"
local function get_today_file()
	local today = os.date("%Y-%m-%d")
	return string.format("%s/%s.norg", journalPath, today)
end

local function _get_all_tasks(filename)
	local file = io.open(filename, "r")
	if not file then
		return {}
	end
	local items = {}
	local start = false
	for line in file:lines() do
		if line:match("^%* Task") then
			start = true
		end
		if not start then
			goto continue
		end
		local item = line:match("^%s*%- %( %) (.*)")
		if item then
			table.insert(items, item)
		end
		::continue::
	end
	file:close()
	return items
end

local function _mark_task_as_done(filename, taskname)
	-- 读取文件
	local lines = {}
	for line in io.lines(filename) do
		lines[#lines + 1] = line
	end

	-- 查找并替换任务
	for i, line in ipairs(lines) do
		local indent, task = string.match(line, "(%s*)- %( %) (.*)")
		if task == taskname then
			lines[i] = indent .. "- (x) " .. task
		end
	end

	-- 写回文件
	local file = io.open(filename, "w")
	for _, line in ipairs(lines) do
		file:write(line .. "\n")
	end
	file:close()
end

local function get_all_tasks()
	return _get_all_tasks(get_today_file())
end

local function mark_task_as_done(task)
	_mark_task_as_done(get_today_file(), task)
end

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

local function update_title(tasks)
	if not tasks then
		tasks = get_all_tasks()
	end
	if #tasks == 0 then
		taskman:set({ icon = { color = colors.green }, label = { string = "今天没有任务啦!" } })
	else
		taskman:set({ icon = { color = colors.red }, label = { string = tasks[1] } })
	end
	return tasks
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

	local undone_tasks = get_all_tasks()
	for i, undone in ipairs(undone_tasks) do
		local name = "taskman.list." .. tostring(i)
		local taskone = sbar.add("item", name, {
			position = "popup.taskman",
			align = "center",
			label = { string = undone },
			icon = { string = "􀅴 ", color = colors.red },
		})
		taskone:subscribe("mouse.clicked", function()
			sbar.animate("sin", 10.0, function()
				sbar.remove(name)
			end)
			mark_task_as_done(undone)
			local tasks = update_title()
			if #tasks == 0 then
				taskman:set({ popup = { drawing = false } })
			end
		end)
	end
	update_title(undone_tasks)
	taskman:set({ popup = { drawing = true } })
end

taskman:subscribe("mouse.clicked", task_toggle_details)
taskman:subscribe("mouse.exited.global", task_collapse_details)

update_title()
