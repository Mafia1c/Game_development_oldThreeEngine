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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 574, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/49fm/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 836, 505, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.50, 0.50)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	-- Create infoNode
	local infoNode = GUI:Node_Create(FrameLayout, "infoNode", 0, 0)
	GUI:setTag(infoNode, 0)

	-- Create personEffect
	local personEffect = GUI:Effect_Create(infoNode, "personEffect", 156, 256, 0, 20427, 0, 0, 0, 1)
	GUI:setTag(personEffect, 0)

	-- Create clothesItem
	local clothesItem = GUI:ItemShow_Create(infoNode, "clothesItem", 406, 344, {index = 10238, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(clothesItem, 0.50, 0.50)
	GUI:setTag(clothesItem, 0)

	-- Create buyBtn
	local buyBtn = GUI:Button_Create(infoNode, "buyBtn", 708, 430, "res/custom/npc/49fm/198mai.png")
	GUI:setContentSize(buyBtn, 176, 44)
	GUI:setIgnoreContentAdaptWithSize(buyBtn, false)
	GUI:Button_setTitleText(buyBtn, [[]])
	GUI:Button_setTitleColor(buyBtn, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn, 16)
	GUI:Button_titleEnableOutline(buyBtn, "#000000", 1)
	GUI:setAnchorPoint(buyBtn, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn, true)
	GUI:setTag(buyBtn, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(buyBtn, "Image_2", 153, 29, "res/public/btn_npcfh_04.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create buyImg
	local buyImg = GUI:Image_Create(infoNode, "buyImg", 710, 430, "res/custom/tag/y_112.png")
	GUI:setContentSize(buyImg, 101, 85)
	GUI:setIgnoreContentAdaptWithSize(buyImg, false)
	GUI:setAnchorPoint(buyImg, 0.50, 0.50)
	GUI:setTouchEnabled(buyImg, false)
	GUI:setTag(buyImg, 0)

	-- Create infoList
	local infoList = GUI:ListView_Create(infoNode, "infoList", 448, 38, 346, 338, 1)
	GUI:ListView_setBounceEnabled(infoList, true)
	GUI:ListView_setItemsMargin(infoList, 4)
	GUI:setAnchorPoint(infoList, 0.00, 0.00)
	GUI:setTouchEnabled(infoList, true)
	GUI:setTag(infoList, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(infoList, "Image_1", 0, 230, "res/custom/npc/49fm/z10.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Image_1, "Text_1", 174, 92, 16, "#ffff00", [[【第一天】可领]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create itemNode1
	local itemNode1 = GUI:Node_Create(Image_1, "itemNode1", 130, 38)
	GUI:setTag(itemNode1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Image_1, "Button_1", 298, 40, "res/custom/npc/49fm/lq.png")
	GUI:setContentSize(Button_1, 84, 36)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.50, 0.50)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(Image_1, "Button_2", 298, 40, "res/custom/tag/ok.png")
	GUI:setContentSize(Button_2, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.50, 0.50)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
