local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create ChildLayout
	local ChildLayout = GUI:Layout_Create(parent, "ChildLayout", 149, 29, 610, 444, false)
	GUI:setAnchorPoint(ChildLayout, 0.00, 0.00)
	GUI:setTouchEnabled(ChildLayout, false)
	GUI:setTag(ChildLayout, 0)

	-- Create text1
	local text1 = GUI:Text_Create(ChildLayout, "text1", 11, 63, 16, "#ffff00", [[魔盒双倍收益暴击几率：]])
	GUI:Text_enableOutline(text1, "#000000", 1)
	GUI:setAnchorPoint(text1, 0.00, 0.00)
	GUI:setTouchEnabled(text1, false)
	GUI:setTag(text1, 0)

	-- Create critical_text
	local critical_text = GUI:Text_Create(ChildLayout, "critical_text", 190, 63, 16, "#00ff00", [[]])
	GUI:Text_enableOutline(critical_text, "#000000", 1)
	GUI:setAnchorPoint(critical_text, 0.00, 0.00)
	GUI:setTouchEnabled(critical_text, false)
	GUI:setTag(critical_text, 0)

	-- Create text1_2
	local text1_2 = GUI:Text_Create(ChildLayout, "text1_2", 10, 38, 16, "#00ff00", [[今天有任意充值下次开启必定双倍收益]])
	GUI:Text_enableOutline(text1_2, "#000000", 1)
	GUI:setAnchorPoint(text1_2, 0.00, 0.00)
	GUI:setTouchEnabled(text1_2, false)
	GUI:setTag(text1_2, 0)

	-- Create text1_3
	local text1_3 = GUI:Text_Create(ChildLayout, "text1_3", 10, 12, 16, "#00ff00", [[每天仅会触发一次，双倍收益：]])
	GUI:Text_enableOutline(text1_3, "#000000", 1)
	GUI:setAnchorPoint(text1_3, 0.00, 0.00)
	GUI:setTouchEnabled(text1_3, false)
	GUI:setTag(text1_3, 0)

	-- Create text1_4
	local text1_4 = GUI:Text_Create(ChildLayout, "text1_4", 366, 61, 16, "#ffffff", [[魔盒价格：]])
	GUI:Text_enableOutline(text1_4, "#000000", 1)
	GUI:setAnchorPoint(text1_4, 0.00, 0.00)
	GUI:setTouchEnabled(text1_4, false)
	GUI:setTag(text1_4, 0)

	-- Create text1_5
	local text1_5 = GUI:Text_Create(ChildLayout, "text1_5", 365, 18, 16, "#ffffff", [[魔盒数量：]])
	GUI:Text_enableOutline(text1_5, "#000000", 1)
	GUI:setAnchorPoint(text1_5, 0.00, 0.00)
	GUI:setTouchEnabled(text1_5, false)
	GUI:setTag(text1_5, 0)

	-- Create box_price
	local box_price = GUI:Text_Create(ChildLayout, "box_price", 447, 61, 16, "#00ff00", [[20元]])
	GUI:Text_enableOutline(box_price, "#000000", 1)
	GUI:setAnchorPoint(box_price, 0.00, 0.00)
	GUI:setTouchEnabled(box_price, false)
	GUI:setTag(box_price, 0)

	-- Create box_double
	local box_double = GUI:Text_Create(ChildLayout, "box_double", 231, 12, 16, "#ff0000", [[]])
	GUI:Text_enableOutline(box_double, "#000000", 1)
	GUI:setAnchorPoint(box_double, 0.00, 0.00)
	GUI:setTouchEnabled(box_double, false)
	GUI:setTag(box_double, 0)

	-- Create box_num
	local box_num = GUI:Text_Create(ChildLayout, "box_num", 447, 19, 16, "#00ff00", [[0个]])
	GUI:Text_enableOutline(box_num, "#000000", 1)
	GUI:setAnchorPoint(box_num, 0.00, 0.00)
	GUI:setTouchEnabled(box_num, false)
	GUI:setTag(box_num, 0)

	-- Create buy_box
	local buy_box = GUI:Button_Create(ChildLayout, "buy_box", 502, 54, "res/custom/npc/20fl/13/an1.png")
	GUI:setContentSize(buy_box, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(buy_box, false)
	GUI:Button_setTitleText(buy_box, [[]])
	GUI:Button_setTitleColor(buy_box, "#ffffff")
	GUI:Button_setTitleFontSize(buy_box, 16)
	GUI:Button_titleEnableOutline(buy_box, "#000000", 1)
	GUI:setAnchorPoint(buy_box, 0.00, 0.00)
	GUI:setTouchEnabled(buy_box, true)
	GUI:setTag(buy_box, 0)

	-- Create open_box
	local open_box = GUI:Button_Create(ChildLayout, "open_box", 502, 12, "res/custom/npc/20fl/13/an2.png")
	GUI:setContentSize(open_box, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(open_box, false)
	GUI:Button_setTitleText(open_box, [[]])
	GUI:Button_setTitleColor(open_box, "#ffffff")
	GUI:Button_setTitleFontSize(open_box, 16)
	GUI:Button_titleEnableOutline(open_box, "#000000", 1)
	GUI:setAnchorPoint(open_box, 0.00, 0.00)
	GUI:setTouchEnabled(open_box, true)
	GUI:setTag(open_box, 0)

	ui.update(__data__)
	return ChildLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
