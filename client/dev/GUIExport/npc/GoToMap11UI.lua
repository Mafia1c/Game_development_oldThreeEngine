local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:Layout_setBackGroundColorType(CloseLayout, 1)
	GUI:Layout_setBackGroundColor(CloseLayout, "#000000")
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 888, 534, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/94dt/bg2_2.png")
	GUI:Image_setScale9Slice(FrameBG, 88, 88, 178, 178)
	GUI:setContentSize(FrameBG, 888, 534)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create blInfo
	local blInfo = GUI:Node_Create(FrameLayout, "blInfo", 574, 173)
	GUI:setTag(blInfo, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(blInfo, "ItemShow_1", -163, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(blInfo, "ItemShow_2", -88, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(blInfo, "ItemShow_3", -14, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(blInfo, "ItemShow_4", 60, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(blInfo, "ItemShow_5", 133, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create enterBtn
	local enterBtn = GUI:Button_Create(FrameLayout, "enterBtn", 384, 22, "res/custom/npc/94dt/an2.png")
	GUI:setContentSize(enterBtn, 130, 42)
	GUI:setIgnoreContentAdaptWithSize(enterBtn, false)
	GUI:Button_setTitleText(enterBtn, [[]])
	GUI:Button_setTitleColor(enterBtn, "#00ff00")
	GUI:Button_setTitleFontSize(enterBtn, 18)
	GUI:Button_titleEnableOutline(enterBtn, "#000000", 1)
	GUI:setAnchorPoint(enterBtn, 0.00, 0.00)
	GUI:setTouchEnabled(enterBtn, true)
	GUI:setTag(enterBtn, 0)

	-- Create enterKfBtn
	local enterKfBtn = GUI:Button_Create(FrameLayout, "enterKfBtn", 570, 22, "res/custom/npc/94dt/an3.png")
	GUI:setContentSize(enterKfBtn, 130, 42)
	GUI:setIgnoreContentAdaptWithSize(enterKfBtn, false)
	GUI:Button_setTitleText(enterKfBtn, [[]])
	GUI:Button_setTitleColor(enterKfBtn, "#00ff00")
	GUI:Button_setTitleFontSize(enterKfBtn, 18)
	GUI:Button_titleEnableOutline(enterKfBtn, "#000000", 1)
	GUI:setAnchorPoint(enterKfBtn, 0.00, 0.00)
	GUI:setTouchEnabled(enterKfBtn, true)
	GUI:setTag(enterKfBtn, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 785, 433, "res/custom/npc/54dt/sc_close.png")
	GUI:setContentSize(closeBtn, 45, 47)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create iconImg
	local iconImg = GUI:Image_Create(FrameLayout, "iconImg", 461, 430, "res/custom/npc/94dt/icon2_2.png")
	GUI:setContentSize(iconImg, 244, 57)
	GUI:setIgnoreContentAdaptWithSize(iconImg, false)
	GUI:setAnchorPoint(iconImg, 0.00, 0.00)
	GUI:setTouchEnabled(iconImg, false)
	GUI:setTag(iconImg, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
