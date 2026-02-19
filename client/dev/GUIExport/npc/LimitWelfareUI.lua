local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 776, 480, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/42xsfl/bg.png")
	GUI:setContentSize(FrameBG, 776, 480)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameBG, "closeBtn", 640, 379, "res/custom/npc/42xsfl/x.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameBG, "Effect_1", 71, 249, 0, 20443, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create Effect_2
	local Effect_2 = GUI:Effect_Create(FrameBG, "Effect_2", 186, 334, 0, 20111, 0, 0, 0, 1)
	GUI:setTag(Effect_2, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(FrameBG, "Panel_1", 274, 211, 359, 137, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Panel_1, "ItemShow_1", 54, 104, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(Panel_1, "ItemShow_2", 136, 104, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(Panel_1, "ItemShow_3", 218, 104, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(Panel_1, "ItemShow_4", 303, 104, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(Panel_1, "ItemShow_5", 302, 34, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(Panel_1, "ItemShow_6", 54, 34, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(Panel_1, "ItemShow_7", 136, 34, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(Panel_1, "ItemShow_8", 219, 34, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create buy_btn
	local buy_btn = GUI:Button_Create(FrameBG, "buy_btn", 381, 102, "res/custom/npc/42xsfl/6r.png")
	GUI:setContentSize(buy_btn, 146, 44)
	GUI:setIgnoreContentAdaptWithSize(buy_btn, false)
	GUI:Button_setTitleText(buy_btn, [[]])
	GUI:Button_setTitleColor(buy_btn, "#ffffff")
	GUI:Button_setTitleFontSize(buy_btn, 16)
	GUI:Button_titleDisableOutLine(buy_btn)
	GUI:setAnchorPoint(buy_btn, 0.00, 0.00)
	GUI:setTouchEnabled(buy_btn, true)
	GUI:setTag(buy_btn, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(FrameBG, "ItemShow_9", 600, 178, {index = 50028, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setTag(ItemShow_9, 0)

	-- Create time_text_1
	local time_text_1 = GUI:Text_Create(FrameBG, "time_text_1", 559, 124, 20, "#00ff00", [[00:30:50]])
	GUI:Text_enableOutline(time_text_1, "#000000", 1)
	GUI:setAnchorPoint(time_text_1, 0.00, 0.50)
	GUI:setTouchEnabled(time_text_1, false)
	GUI:setTag(time_text_1, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
