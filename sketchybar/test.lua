function parse(str)
	local t = {}
	for line in str:gmatch("[^\r\n]+") do -- 遍历每一行
		local key, value = line:match("(%S+)%s*:%s*(%S.*)") -- 匹配键值对
		if key and value then
			if value:match("^%s*{%s*$") then -- 如果值是一个新的 table 的开始
				local subtable = {}
				for subline in str:gmatch("[^\r\n]+") do
					local subkey, subvalue = subline:match("(%S+)%s*:%s*(%S.*)") -- 匹配子表的键值对
					if subkey and subvalue then
						subtable[subkey] = subvalue
					end
				end
				t[key] = subtable
			else
				t[key] = value
			end
		end
	end
	return t
end

-- 测试
local str = [[
is-grabbed : false
can-move : true
sub-level : 0
can-resize : true
role : AXWindow
is-sticky : false
is-floating : false
root-window : true
has-focus : true
stack-index : 0
is-visible : true
is-minimized : false
space : 6
has-ax-reference : true
level : 0
pid : 6209
opacity : 1
display : 1
subrole : AXStandardWindow
has-parent-zoom : false
frame : 
  h : 1405
  y : 30
  x : 5
  w : 1270
layer : normal
is-native-fullscreen : false
split-type : vertical
id : 289
is-hidden : false
title : dotfiles/.config/sketchybar/items/widgets/volume.lua at 1589c769e28f110b1177f6a83fa145235c8f7bd6 · Fel
ixKratz/dotfiles - Google Chrome
has-fullscreen-zoom : false
split-child : first_child
has-shadow : false
app : Google Chrome
sub-layer : normal
]]

local t = parse(str)

-- 打印结果
for k, v in pairs(t) do
	print(k, v)
end
