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
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/82slzy/bg.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 820, 481, "res/public/1900000510.png")
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

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 226, 258, 0, 21005, 0, 0, 0, 1)
	GUI:setScale(Effect_1, 0.80)
	GUI:setTag(Effect_1, 0)

	-- Create activation
	local activation = GUI:Node_Create(FrameLayout, "activation", 240, 132)
	GUI:setTag(activation, 0)

	-- Create activationBtn
	local activationBtn = GUI:Button_Create(activation, "activationBtn", 42, -19, "res/public/1900000611.png")
	GUI:setContentSize(activationBtn, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(activationBtn, false)
	GUI:Button_setTitleText(activationBtn, [[激活]])
	GUI:Button_setTitleColor(activationBtn, "#ffffff")
	GUI:Button_setTitleFontSize(activationBtn, 18)
	GUI:Button_titleEnableOutline(activationBtn, "#000000", 1)
	GUI:setAnchorPoint(activationBtn, 0.00, 0.00)
	GUI:setTouchEnabled(activationBtn, true)
	GUI:setTag(activationBtn, 0)

	-- Create activationIcon
	local activationIcon = GUI:Image_Create(activation, "activationIcon", 44, -29, "res/custom/tag/hdyl_101.png")
	GUI:setContentSize(activationIcon, 85, 59)
	GUI:setIgnoreContentAdaptWithSize(activationIcon, false)
	GUI:setAnchorPoint(activationIcon, 0.00, 0.00)
	GUI:setTouchEnabled(activationIcon, false)
	GUI:setTag(activationIcon, 0)
	GUI:setVisible(activationIcon, false)

	-- Create NeedItem_1
	local NeedItem_1 = GUI:ItemShow_Create(activation, "NeedItem_1", -122, -3, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(NeedItem_1, 0.50, 0.50)
	GUI:setTag(NeedItem_1, 0)

	-- Create NeedItem_2
	local NeedItem_2 = GUI:ItemShow_Create(activation, "NeedItem_2", -51, -3, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(NeedItem_2, 0.50, 0.50)
	GUI:setTag(NeedItem_2, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 389, 86, 408, 396, 1)
	GUI:ListView_setItemsMargin(ListView_1, 1)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create itemCell_1
	local itemCell_1 = GUI:Image_Create(ListView_1, "itemCell_1", 0, 318, "res/custom/npc/82slzy/rq1.png")
	GUI:setAnchorPoint(itemCell_1, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_1, false)
	GUI:setTag(itemCell_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(itemCell_1, "ItemShow_1", 217, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(itemCell_1, "ItemShow_2", 283, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(itemCell_1, "Button_1", 320, 22, "res/public/1900000611.png")
	GUI:setContentSize(Button_1, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[幻化]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create itemCell_2
	local itemCell_2 = GUI:Image_Create(ListView_1, "itemCell_2", 0, 239, "res/custom/npc/82slzy/rq2.png")
	GUI:setAnchorPoint(itemCell_2, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_2, false)
	GUI:setTag(itemCell_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(itemCell_2, "ItemShow_3", 217, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(itemCell_2, "ItemShow_4", 283, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(itemCell_2, "Button_2", 320, 22, "res/public/1900000611.png")
	GUI:setContentSize(Button_2, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[幻化]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create itemCell_3
	local itemCell_3 = GUI:Image_Create(ListView_1, "itemCell_3", 0, 160, "res/custom/npc/82slzy/rq3.png")
	GUI:setAnchorPoint(itemCell_3, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_3, false)
	GUI:setTag(itemCell_3, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(itemCell_3, "ItemShow_5", 217, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(itemCell_3, "ItemShow_6", 283, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(itemCell_3, "Button_3", 320, 22, "res/public/1900000611.png")
	GUI:setContentSize(Button_3, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[幻化]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create itemCell_4
	local itemCell_4 = GUI:Image_Create(ListView_1, "itemCell_4", 0, 81, "res/custom/npc/82slzy/rq4.png")
	GUI:setAnchorPoint(itemCell_4, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_4, false)
	GUI:setTag(itemCell_4, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(itemCell_4, "ItemShow_7", 217, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(itemCell_4, "ItemShow_8", 283, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(itemCell_4, "Button_4", 320, 22, "res/public/1900000611.png")
	GUI:setContentSize(Button_4, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[幻化]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create itemCell_5
	local itemCell_5 = GUI:Image_Create(ListView_1, "itemCell_5", 0, 2, "res/custom/npc/82slzy/rq5.png")
	GUI:setAnchorPoint(itemCell_5, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_5, false)
	GUI:setTag(itemCell_5, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(itemCell_5, "ItemShow_9", 217, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setTag(ItemShow_9, 0)

	-- Create ItemShow_10
	local ItemShow_10 = GUI:ItemShow_Create(itemCell_5, "ItemShow_10", 283, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_10, 0.50, 0.50)
	GUI:setTag(ItemShow_10, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(itemCell_5, "Button_5", 320, 22, "res/public/1900000611.png")
	GUI:setContentSize(Button_5, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[幻化]])
	GUI:Button_setTitleColor(Button_5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_5, 18)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create titleTxt
	local titleTxt = GUI:Text_Create(FrameLayout, "titleTxt", 170, 445, 18, "#ff0000", [[<神龙之羽>]])
	GUI:Text_enableOutline(titleTxt, "#000000", 1)
	GUI:setAnchorPoint(titleTxt, 0.00, 0.00)
	GUI:setTouchEnabled(titleTxt, false)
	GUI:setTag(titleTxt, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
