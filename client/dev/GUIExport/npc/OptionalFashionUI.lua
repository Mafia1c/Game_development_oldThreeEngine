local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 174, 51, 770, 516, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/41zx/mb.png")
	GUI:setContentSize(bg_Image, 770, 516)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 745, 436, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/1900000511.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create titleBg
	local titleBg = GUI:Layout_Create(FrameLayout, "titleBg", 92, 384, 200, 40, false)
	GUI:Layout_setBackGroundColorType(titleBg, 1)
	GUI:Layout_setBackGroundColor(titleBg, "#000000")
	GUI:Layout_setBackGroundColorOpacity(titleBg, 255)
	GUI:setAnchorPoint(titleBg, 0.00, 0.00)
	GUI:setTouchEnabled(titleBg, false)
	GUI:setTag(titleBg, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(titleBg, "Text_1", 100, 20, 18, "#ff0000", [[未选择]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 387, 57, 18, "#00ffe8", [[当前已选择:]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 483, 404, 18, "#00ff00", [[请点击选择下列物品]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create curItem
	local curItem = GUI:ItemShow_Create(FrameLayout, "curItem", 536, 68, {index = 0, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(curItem, 0.50, 0.50)
	GUI:setTag(curItem, 0)

	-- Create getBtn
	local getBtn = GUI:Button_Create(FrameLayout, "getBtn", 601, 49, "res/public/1900000660.png")
	GUI:setContentSize(getBtn, 106, 40)
	GUI:setIgnoreContentAdaptWithSize(getBtn, false)
	GUI:Button_setTitleText(getBtn, [[点击领取]])
	GUI:Button_setTitleColor(getBtn, "#ffffff")
	GUI:Button_setTitleFontSize(getBtn, 18)
	GUI:Button_titleEnableOutline(getBtn, "#000000", 1)
	GUI:setAnchorPoint(getBtn, 0.00, 0.00)
	GUI:setTouchEnabled(getBtn, true)
	GUI:setTag(getBtn, 0)

	-- Create Node_1
	local Node_1 = GUI:Node_Create(FrameLayout, "Node_1", 559, 358)
	GUI:setTag(Node_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Node_1, "ItemShow_1", -143, -1, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(ItemShow_1, "Panel_1", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(Node_1, "ItemShow_2", -72, 0, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create Panel_2
	local Panel_2 = GUI:Layout_Create(ItemShow_2, "Panel_2", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_2, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_2, true)
	GUI:setTag(Panel_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(Node_1, "ItemShow_3", 0, 0, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create Panel_3
	local Panel_3 = GUI:Layout_Create(ItemShow_3, "Panel_3", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_3, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_3, true)
	GUI:setTag(Panel_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(Node_1, "ItemShow_4", 72, 0, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create Panel_4
	local Panel_4 = GUI:Layout_Create(ItemShow_4, "Panel_4", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_4, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_4, true)
	GUI:setTag(Panel_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(Node_1, "ItemShow_5", 143, 0, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create Panel_5
	local Panel_5 = GUI:Layout_Create(ItemShow_5, "Panel_5", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_5, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_5, true)
	GUI:setTag(Panel_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(Node_1, "ItemShow_6", -143, -65, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create Panel_6
	local Panel_6 = GUI:Layout_Create(ItemShow_6, "Panel_6", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_6, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_6, true)
	GUI:setTag(Panel_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(Node_1, "ItemShow_7", -72, -65, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create Panel_7
	local Panel_7 = GUI:Layout_Create(ItemShow_7, "Panel_7", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_7, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_7, true)
	GUI:setTag(Panel_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(Node_1, "ItemShow_8", 0, -65, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create Panel_8
	local Panel_8 = GUI:Layout_Create(ItemShow_8, "Panel_8", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_8, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_8, true)
	GUI:setTag(Panel_8, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(Node_1, "ItemShow_9", 72, -65, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setTag(ItemShow_9, 0)

	-- Create Panel_9
	local Panel_9 = GUI:Layout_Create(ItemShow_9, "Panel_9", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_9, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_9, true)
	GUI:setTag(Panel_9, 0)

	-- Create ItemShow_10
	local ItemShow_10 = GUI:ItemShow_Create(Node_1, "ItemShow_10", 143, -65, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_10, 0.50, 0.50)
	GUI:setTag(ItemShow_10, 0)

	-- Create Panel_10
	local Panel_10 = GUI:Layout_Create(ItemShow_10, "Panel_10", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_10, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_10, true)
	GUI:setTag(Panel_10, 0)

	-- Create ItemShow_11
	local ItemShow_11 = GUI:ItemShow_Create(Node_1, "ItemShow_11", -143, -130, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_11, 0.50, 0.50)
	GUI:setTag(ItemShow_11, 0)

	-- Create Panel_11
	local Panel_11 = GUI:Layout_Create(ItemShow_11, "Panel_11", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_11, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_11, true)
	GUI:setTag(Panel_11, 0)

	-- Create ItemShow_12
	local ItemShow_12 = GUI:ItemShow_Create(Node_1, "ItemShow_12", -72, -130, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_12, 0.50, 0.50)
	GUI:setTag(ItemShow_12, 0)

	-- Create Panel_12
	local Panel_12 = GUI:Layout_Create(ItemShow_12, "Panel_12", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_12, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_12, true)
	GUI:setTag(Panel_12, 0)

	-- Create ItemShow_13
	local ItemShow_13 = GUI:ItemShow_Create(Node_1, "ItemShow_13", 0, -130, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_13, 0.50, 0.50)
	GUI:setTag(ItemShow_13, 0)

	-- Create Panel_13
	local Panel_13 = GUI:Layout_Create(ItemShow_13, "Panel_13", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_13, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_13, true)
	GUI:setTag(Panel_13, 0)

	-- Create ItemShow_14
	local ItemShow_14 = GUI:ItemShow_Create(Node_1, "ItemShow_14", 72, -130, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_14, 0.50, 0.50)
	GUI:setTag(ItemShow_14, 0)

	-- Create Panel_14
	local Panel_14 = GUI:Layout_Create(ItemShow_14, "Panel_14", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_14, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_14, true)
	GUI:setTag(Panel_14, 0)

	-- Create ItemShow_15
	local ItemShow_15 = GUI:ItemShow_Create(Node_1, "ItemShow_15", 143, -130, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_15, 0.50, 0.50)
	GUI:setTag(ItemShow_15, 0)

	-- Create Panel_15
	local Panel_15 = GUI:Layout_Create(ItemShow_15, "Panel_15", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_15, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_15, true)
	GUI:setTag(Panel_15, 0)

	-- Create ItemShow_16
	local ItemShow_16 = GUI:ItemShow_Create(Node_1, "ItemShow_16", -143, -195, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_16, 0.50, 0.50)
	GUI:setTag(ItemShow_16, 0)

	-- Create Panel_16
	local Panel_16 = GUI:Layout_Create(ItemShow_16, "Panel_16", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_16, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_16, true)
	GUI:setTag(Panel_16, 0)

	-- Create ItemShow_17
	local ItemShow_17 = GUI:ItemShow_Create(Node_1, "ItemShow_17", -72, -195, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_17, 0.50, 0.50)
	GUI:setTag(ItemShow_17, 0)

	-- Create Panel_17
	local Panel_17 = GUI:Layout_Create(ItemShow_17, "Panel_17", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_17, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_17, true)
	GUI:setTag(Panel_17, 0)

	-- Create ItemShow_18
	local ItemShow_18 = GUI:ItemShow_Create(Node_1, "ItemShow_18", 0, -195, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_18, 0.50, 0.50)
	GUI:setTag(ItemShow_18, 0)

	-- Create Panel_18
	local Panel_18 = GUI:Layout_Create(ItemShow_18, "Panel_18", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_18, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_18, true)
	GUI:setTag(Panel_18, 0)

	-- Create ItemShow_19
	local ItemShow_19 = GUI:ItemShow_Create(Node_1, "ItemShow_19", 72, -195, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_19, 0.50, 0.50)
	GUI:setTag(ItemShow_19, 0)

	-- Create Panel_19
	local Panel_19 = GUI:Layout_Create(ItemShow_19, "Panel_19", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_19, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_19, true)
	GUI:setTag(Panel_19, 0)

	-- Create selectEffect
	local selectEffect = GUI:Effect_Create(Node_1, "selectEffect", 0, 0, 0, 27566, 0, 0, 0, 1)
	GUI:setTag(selectEffect, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
