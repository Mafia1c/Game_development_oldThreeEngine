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
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/40zbfl/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 821, 482, "res/public/1900000510.png")
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

	-- Create itemNode
	local itemNode = GUI:Node_Create(FrameLayout, "itemNode", 252, 270)
	GUI:setTag(itemNode, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(itemNode, "ItemShow_1", -116, -25, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(itemNode, "ItemShow_2", -38, -25, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(itemNode, "ItemShow_3", 38, -25, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(itemNode, "ItemShow_4", 119, -25, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(itemNode, "ItemShow_5", -115, -99, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(itemNode, "ItemShow_6", -37, -99, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(itemNode, "ItemShow_7", 39, -99, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(itemNode, "ItemShow_8", 120, -99, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create cardNode
	local cardNode = GUI:Node_Create(FrameLayout, "cardNode", 617, 241)
	GUI:setTag(cardNode, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(cardNode, "Image_1", -120, 31, "res/custom/npc/40zbfl/p1.png")
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, true)
	GUI:setTag(Image_1, 0)

	-- Create ItemShow
	local ItemShow = GUI:ItemShow_Create(Image_1, "ItemShow", 33, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)
	GUI:setVisible(ItemShow, false)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(cardNode, "Image_2", -37, 31, "res/custom/npc/40zbfl/p1.png")
	GUI:setAnchorPoint(Image_2, 0.50, 0.50)
	GUI:setTouchEnabled(Image_2, true)
	GUI:setTag(Image_2, 0)

	-- Create ItemShow
	ItemShow = GUI:ItemShow_Create(Image_2, "ItemShow", 33, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)
	GUI:setVisible(ItemShow, false)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(cardNode, "Image_3", 44, 31, "res/custom/npc/40zbfl/p1.png")
	GUI:setAnchorPoint(Image_3, 0.50, 0.50)
	GUI:setTouchEnabled(Image_3, true)
	GUI:setTag(Image_3, 0)

	-- Create ItemShow
	ItemShow = GUI:ItemShow_Create(Image_3, "ItemShow", 33, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)
	GUI:setVisible(ItemShow, false)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(cardNode, "Image_4", 124, 31, "res/custom/npc/40zbfl/p1.png")
	GUI:setAnchorPoint(Image_4, 0.50, 0.50)
	GUI:setTouchEnabled(Image_4, true)
	GUI:setTag(Image_4, 0)

	-- Create ItemShow
	ItemShow = GUI:ItemShow_Create(Image_4, "ItemShow", 33, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)
	GUI:setVisible(ItemShow, false)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(cardNode, "Image_5", -120, -72, "res/custom/npc/40zbfl/p1.png")
	GUI:setAnchorPoint(Image_5, 0.50, 0.50)
	GUI:setTouchEnabled(Image_5, true)
	GUI:setTag(Image_5, 0)

	-- Create ItemShow
	ItemShow = GUI:ItemShow_Create(Image_5, "ItemShow", 33, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)
	GUI:setVisible(ItemShow, false)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(cardNode, "Image_6", -37, -72, "res/custom/npc/40zbfl/p1.png")
	GUI:setAnchorPoint(Image_6, 0.50, 0.50)
	GUI:setTouchEnabled(Image_6, true)
	GUI:setTag(Image_6, 0)

	-- Create ItemShow
	ItemShow = GUI:ItemShow_Create(Image_6, "ItemShow", 33, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)
	GUI:setVisible(ItemShow, false)

	-- Create Image_7
	local Image_7 = GUI:Image_Create(cardNode, "Image_7", 44, -72, "res/custom/npc/40zbfl/p1.png")
	GUI:setAnchorPoint(Image_7, 0.50, 0.50)
	GUI:setTouchEnabled(Image_7, true)
	GUI:setTag(Image_7, 0)

	-- Create ItemShow
	ItemShow = GUI:ItemShow_Create(Image_7, "ItemShow", 33, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)
	GUI:setVisible(ItemShow, false)

	-- Create Image_8
	local Image_8 = GUI:Image_Create(cardNode, "Image_8", 124, -72, "res/custom/npc/40zbfl/p1.png")
	GUI:setAnchorPoint(Image_8, 0.50, 0.50)
	GUI:setTouchEnabled(Image_8, true)
	GUI:setTag(Image_8, 0)

	-- Create ItemShow
	ItemShow = GUI:ItemShow_Create(Image_8, "ItemShow", 33, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)
	GUI:setVisible(ItemShow, false)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 192, 61, "res/public/1900000612.png")
	GUI:setContentSize(Button_1, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[每日抽取]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 671, 58, "res/public/1900000611.png")
	GUI:setContentSize(Button_2, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[兑换]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create TextInput_1
	local TextInput_1 = GUI:TextInput_Create(FrameLayout, "TextInput_1", 454, 60, 100, 25, 16)
	GUI:TextInput_setString(TextInput_1, "")
	GUI:TextInput_setPlaceHolder(TextInput_1, "输入兑换码")
	GUI:TextInput_setFontColor(TextInput_1, "#ffffff")
	GUI:TextInput_setPlaceholderFontColor(TextInput_1, "#a6a6a6")
	GUI:TextInput_setInputMode(TextInput_1, 0)
	GUI:setAnchorPoint(TextInput_1, 0.00, 0.00)
	GUI:setTouchEnabled(TextInput_1, true)
	GUI:setTag(TextInput_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
