local M = {
	popup_toggle = "sketchybar --set $NAME popup.drawing=toggle",
	popup_off = "sketchybar --set $NAME popup.drawing=off",
}

function M._merge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				M._merge(t1[k], v)
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
end

function M.merge_tables(...)
	local merged = {}
	for _, tbl in ipairs({ ... }) do
		M._merge(merged, tbl)
	end
	return merged
end

function M.app_icon(app)
	local app_icon = require("app_icon")
	local lookup = app_icon[app]
	return ((lookup == nil) and app_icon["default"] or lookup)
end

local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

-- decoding
function M.base64_decode(data)
	data = string.gsub(data, "[^" .. b .. "=]", "")
	return (
		data:gsub(".", function(x)
			if x == "=" then
				return ""
			end
			local r, f = "", (b:find(x) - 1)
			for i = 6, 1, -1 do
				r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
			end
			return r
		end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
			if #x ~= 8 then
				return ""
			end
			local c = 0
			for i = 1, 8 do
				c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
			end
			return string.char(c)
		end)
	)
end

return M
