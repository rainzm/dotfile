#!/usr/bin/env lua

local dkjson = require("dkjson")

local handle = io.popen("yabai -m query --windows --space")
if not handle then
	print("Failed to execute command")
	return
end
local result = handle:read("*a")
handle:close()

-- 将输出转换为 table
local windows, _, err = dkjson.decode(result)

if err or not windows then
	print("Error:", err)
	return
end

local visual_windows = {}
local current_stack_index = 0

if type(windows) ~= "table" then
	return
end

for _, window in ipairs(windows) do
	if window["is-minimized"] then
		goto continue
	end
	if window["is-hidden"] then
		goto continue
	end
	if not window["is-visible"] then
		goto continue
	end
	if window.subrole ~= "AXStandardWindow" then
		goto continue
	end
	if window["has-focus"] then
		current_stack_index = window["stack-index"]
	end
	table.insert(visual_windows, window)
	::continue::
end

local target_window_id = nil

if current_stack_index > 0 then
	local first_stack_id, next_stack_id = nil, nil
	for _, window in ipairs(visual_windows) do
		print(window["id"], window["stack-index"])
		if window["stack-index"] == current_stack_index + 1 then
			next_stack_id = window["id"]
			break
		end
		if window["stack-index"] == 1 then
			first_stack_id = window["id"]
		end
	end
	if next_stack_id then
		target_window_id = next_stack_id
	else
		target_window_id = first_stack_id
	end
else
	table.sort(visual_windows, function(a, b)
		if a.frame.y == b.frame.y then
			if a.frame.x == b.frame.x then
				return a["stack-index"] < b["stack-index"]
			end
			return a.frame.x < b.frame.x
		end
		return a.frame.y < b.frame.y
	end)
	for i, window in ipairs(visual_windows) do
		if window["has-focus"] then
			if i == #visual_windows then
				target_window_id = visual_windows[1]["id"]
			else
				target_window_id = visual_windows[i + 1]["id"]
			end
		end
	end
	if not target_window_id then
		target_window_id = visual_windows[1]["id"]
	end
end

if target_window_id then
	os.execute("yabai -m window --focus " .. target_window_id)
end
