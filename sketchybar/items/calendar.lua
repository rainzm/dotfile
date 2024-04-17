local cal = sbar.add("item", "calendar", {
	update_freq = 10,
	position = "right",
	click_script = "sketchybar --set $NAME popup.drawing=toggle; open -a Calendar.app",
	icon = {
		drawing = false,
	},
})

local weekDays = { "日", "一", "二", "三", "四", "五", "六" }

local function update()
	local t = os.date("*t") -- 获取当前的日期和时间
	local formattedTime = string.format("%d月%d日 周%s %02d:%02d", t.month, t.day, weekDays[t.wday], t.hour, t.min)
	cal:set({ label = { string = formattedTime } })
end

cal:subscribe("routine", update)

update()
