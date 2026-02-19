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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.4489, _V("SCREEN_HEIGHT") * 0.5188, 770, 540, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 9, 5, "res/custom/npc/30sc/top_sc.png")
	GUI:Image_setScale9Slice(FrameBG, 73, 73, 146, 146)
	GUI:setContentSize(FrameBG, 770, 504)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create blInfo
	local blInfo = GUI:Node_Create(FrameLayout, "blInfo", 478, 242)
	GUI:setScale(blInfo, 1.10)
	GUI:setTag(blInfo, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(blInfo, "ItemShow_1", -150, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(blInfo, "ItemShow_2", -76, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(blInfo, "ItemShow_3", -4, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(blInfo, "ItemShow_4", 70, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(blInfo, "ItemShow_5", 143, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(blInfo, "ItemShow_6", -149, -37, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(blInfo, "ItemShow_7", -76, -37, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(blInfo, "ItemShow_8", -3, -37, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(blInfo, "ItemShow_9", 70, -37, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setTag(ItemShow_9, 0)

	-- Create ItemShow_10
	local ItemShow_10 = GUI:ItemShow_Create(blInfo, "ItemShow_10", 143, -37, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_10, 0.50, 0.50)
	GUI:setTag(ItemShow_10, 0)

	-- Create getBtn
	local getBtn = GUI:Button_Create(FrameLayout, "getBtn", 382, 71, "res/custom/npc/30sc/sc_an.png")
	GUI:setContentSize(getBtn, 148, 56)
	GUI:setIgnoreContentAdaptWithSize(getBtn, false)
	GUI:Button_setTitleText(getBtn, [[]])
	GUI:Button_setTitleColor(getBtn, "#ffffff")
	GUI:Button_setTitleFontSize(getBtn, 16)
	GUI:Button_titleEnableOutline(getBtn, "#000000", 1)
	GUI:setAnchorPoint(getBtn, 0.00, 0.00)
	GUI:setTouchEnabled(getBtn, true)
	GUI:setTag(getBtn, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 676, 390, "res/custom/npc/30sc/sc_close.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create iconTag
	local iconTag = GUI:Image_Create(FrameLayout, "iconTag", 428, 70, "res/custom/tag/0-4.png")
	GUI:setAnchorPoint(iconTag, 0.00, 0.00)
	GUI:setTouchEnabled(iconTag, false)
	GUI:setTag(iconTag, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
