local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 204, 47, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create LayoutBg
	local LayoutBg = GUI:Image_Create(FrameLayout, "LayoutBg", 0, 0, "res/custom/npc/53slzs/bg1.png")
	GUI:setAnchorPoint(LayoutBg, 0.00, 0.00)
	GUI:setTouchEnabled(LayoutBg, true)
	GUI:setMouseEnabled(LayoutBg, true)
	GUI:setTag(LayoutBg, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 819, 481, "res/public/1900000510.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 198, 287, 0, 20425, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create Effect_2
	local Effect_2 = GUI:Effect_Create(FrameLayout, "Effect_2", 6, 486, 0, 46014, 0, 0, 0, 1)
	GUI:setTag(Effect_2, 0)

	-- Create equipNode
	local equipNode = GUI:Node_Create(FrameLayout, "equipNode", 42, 12)
	GUI:setTag(equipNode, 0)

	-- Create equipBg
	local equipBg = GUI:Image_Create(equipNode, "equipBg", 67, 7, "res/custom/npc/53slzs/icon.png")
	GUI:setContentSize(equipBg, 378, 506)
	GUI:setIgnoreContentAdaptWithSize(equipBg, false)
	GUI:setAnchorPoint(equipBg, 0.00, 0.00)
	GUI:setTouchEnabled(equipBg, false)
	GUI:setTag(equipBg, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(equipNode, "ItemShow_1", 125, 378, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create icon_click_1
	local icon_click_1 = GUI:Layout_Create(ItemShow_1, "icon_click_1", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(icon_click_1, 0.50, 0.50)
	GUI:setTouchEnabled(icon_click_1, true)
	GUI:setTag(icon_click_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(equipNode, "ItemShow_2", 389, 378, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create icon_click_2
	local icon_click_2 = GUI:Layout_Create(ItemShow_2, "icon_click_2", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(icon_click_2, 0.50, 0.50)
	GUI:setTouchEnabled(icon_click_2, true)
	GUI:setTag(icon_click_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(equipNode, "ItemShow_3", 124, 290, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create icon_click_3
	local icon_click_3 = GUI:Layout_Create(ItemShow_3, "icon_click_3", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(icon_click_3, 0.50, 0.50)
	GUI:setTouchEnabled(icon_click_3, true)
	GUI:setTag(icon_click_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(equipNode, "ItemShow_4", 389, 290, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create icon_click_4
	local icon_click_4 = GUI:Layout_Create(ItemShow_4, "icon_click_4", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(icon_click_4, 0.50, 0.50)
	GUI:setTouchEnabled(icon_click_4, true)
	GUI:setTag(icon_click_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(equipNode, "ItemShow_5", 124, 202, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create icon_click_5
	local icon_click_5 = GUI:Layout_Create(ItemShow_5, "icon_click_5", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(icon_click_5, 0.50, 0.50)
	GUI:setTouchEnabled(icon_click_5, true)
	GUI:setTag(icon_click_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(equipNode, "ItemShow_6", 388, 202, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create icon_click_6
	local icon_click_6 = GUI:Layout_Create(ItemShow_6, "icon_click_6", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(icon_click_6, 0.50, 0.50)
	GUI:setTouchEnabled(icon_click_6, true)
	GUI:setTag(icon_click_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(equipNode, "ItemShow_7", 124, 113, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create icon_click_7
	local icon_click_7 = GUI:Layout_Create(ItemShow_7, "icon_click_7", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(icon_click_7, 0.50, 0.50)
	GUI:setTouchEnabled(icon_click_7, true)
	GUI:setTag(icon_click_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(equipNode, "ItemShow_8", 389, 114, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create icon_click_8
	local icon_click_8 = GUI:Layout_Create(ItemShow_8, "icon_click_8", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(icon_click_8, 0.50, 0.50)
	GUI:setTouchEnabled(icon_click_8, true)
	GUI:setTag(icon_click_8, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(equipNode, "select_img", 125, 378, "res/public/1900000678_1.png")
	GUI:Image_setScale9Slice(select_img, 8, 8, 28, 28)
	GUI:setContentSize(select_img, 66, 66)
	GUI:setIgnoreContentAdaptWithSize(select_img, false)
	GUI:setAnchorPoint(select_img, 0.50, 0.50)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)

	-- Create needNode
	local needNode = GUI:Node_Create(FrameLayout, "needNode", 42, 12)
	GUI:setTag(needNode, 0)

	-- Create needItem_1
	local needItem_1 = GUI:ItemShow_Create(needNode, "needItem_1", 528, 110, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_1, 0.50, 0.50)
	GUI:setTag(needItem_1, 0)

	-- Create needItem_2
	local needItem_2 = GUI:ItemShow_Create(needNode, "needItem_2", 590, 110, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_2, 0.50, 0.50)
	GUI:setTag(needItem_2, 0)

	-- Create needItem_3
	local needItem_3 = GUI:ItemShow_Create(needNode, "needItem_3", 655, 110, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_3, 0.50, 0.50)
	GUI:setTag(needItem_3, 0)

	-- Create needItem_4
	local needItem_4 = GUI:ItemShow_Create(needNode, "needItem_4", 716, 110, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_4, 0.50, 0.50)
	GUI:setTag(needItem_4, 0)

	-- Create txtNode
	local txtNode = GUI:Node_Create(FrameLayout, "txtNode", 662, 285)
	GUI:setTag(txtNode, 0)

	-- Create unsealBtn
	local unsealBtn = GUI:Button_Create(FrameLayout, "unsealBtn", 602, 42, "res/custom/npc/53slzs/an.png")
	GUI:setContentSize(unsealBtn, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(unsealBtn, false)
	GUI:Button_setTitleText(unsealBtn, [[解封神器]])
	GUI:Button_setTitleColor(unsealBtn, "#ffff00")
	GUI:Button_setTitleFontSize(unsealBtn, 18)
	GUI:Button_titleEnableOutline(unsealBtn, "#000000", 1)
	GUI:setAnchorPoint(unsealBtn, 0.00, 0.00)
	GUI:setTouchEnabled(unsealBtn, true)
	GUI:setTag(unsealBtn, 0)

	-- Create showItem
	local showItem = GUI:ItemShow_Create(FrameLayout, "showItem", 665, 396, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(showItem, 0.50, 0.50)
	GUI:setTag(showItem, 0)

	-- Create equipName
	local equipName = GUI:Text_Create(FrameLayout, "equipName", 667, 321, 18, "#ff0000", [[文本]])
	GUI:Text_enableOutline(equipName, "#000000", 1)
	GUI:setAnchorPoint(equipName, 0.50, 0.00)
	GUI:setTouchEnabled(equipName, false)
	GUI:setTag(equipName, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
