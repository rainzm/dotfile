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
	return
end

local visual_windows = {}

if type(windows) ~= "table" then
	return
end

for _, window in ipairs(windows) do
	if window["has-focus"] then
		return
	end
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
	table.insert(visual_windows, window)
	::continue::
end

table.sort(visual_windows, function(a, b)
	if a["is-floating"] and b["is-floating"] then
		if a.frame.y == b.frame.y then
			if a.frame.x == b.frame.x then
				return a["stack-index"] < b["stack-index"]
			end
			return a.frame.x < b.frame.x
		end
		return a.frame.y < b.frame.y
	end
	return a["is-floating"]
end)

if #visual_windows > 0 then
	local target_window_id = visual_windows[1]["id"]
	os.execute("yabai -m window --focus " .. target_window_id)
end
