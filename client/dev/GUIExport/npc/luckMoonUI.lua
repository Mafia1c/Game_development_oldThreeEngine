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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 76)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 574, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/58cycf/bg.png")
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
	local personEffect = GUI:Effect_Create(infoNode, "personEffect", 158, 304, 0, 20445, 0, 0, 0, 1)
	GUI:setTag(personEffect, 0)

	-- Create clothesItem
	local clothesItem = GUI:ItemShow_Create(infoNode, "clothesItem", 408, 366, {index = 10248, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(clothesItem, 0.50, 0.50)
	GUI:setTag(clothesItem, 0)

	-- Create itemNode
	local itemNode = GUI:Node_Create(infoNode, "itemNode", 620, 312)
	GUI:setTag(itemNode, 0)

	-- Create item1
	local item1 = GUI:ItemShow_Create(itemNode, "item1", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item1, 0.50, 0.50)
	GUI:setTag(item1, 0)

	-- Create item2
	local item2 = GUI:ItemShow_Create(itemNode, "item2", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item2, 0.50, 0.50)
	GUI:setTag(item2, 0)

	-- Create item3
	local item3 = GUI:ItemShow_Create(itemNode, "item3", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item3, 0.50, 0.50)
	GUI:setTag(item3, 0)

	-- Create item4
	local item4 = GUI:ItemShow_Create(itemNode, "item4", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item4, 0.50, 0.50)
	GUI:setTag(item4, 0)

	-- Create item5
	local item5 = GUI:ItemShow_Create(itemNode, "item5", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item5, 0.50, 0.50)
	GUI:setTag(item5, 0)

	-- Create buyNode1
	local buyNode1 = GUI:Node_Create(infoNode, "buyNode1", 4, -10)
	GUI:setTag(buyNode1, 0)

	-- Create buyBtn1
	local buyBtn1 = GUI:Button_Create(buyNode1, "buyBtn1", 624, 182, "res/custom/npc/58cycf/yjgm.png")
	GUI:setContentSize(buyBtn1, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(buyBtn1, false)
	GUI:Button_setTitleText(buyBtn1, [[]])
	GUI:Button_setTitleColor(buyBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn1, 16)
	GUI:Button_titleEnableOutline(buyBtn1, "#000000", 1)
	GUI:setAnchorPoint(buyBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn1, true)
	GUI:setTag(buyBtn1, 0)

	-- Create priceText1
	local priceText1 = GUI:Text_Create(buyNode1, "priceText1", 624, 138, 18, "#ffff00", [[价格：588元]])
	GUI:Text_enableOutline(priceText1, "#000000", 1)
	GUI:setAnchorPoint(priceText1, 0.50, 0.50)
	GUI:setTouchEnabled(priceText1, false)
	GUI:setTag(priceText1, 0)

	-- Create buyNode2
	local buyNode2 = GUI:Node_Create(infoNode, "buyNode2", 4, -10)
	GUI:setTag(buyNode2, 0)
	GUI:setVisible(buyNode2, false)

	-- Create btnNode2
	local btnNode2 = GUI:Node_Create(buyNode2, "btnNode2", 622, 187)
	GUI:setTag(btnNode2, 0)

	-- Create buyBtn21
	local buyBtn21 = GUI:Button_Create(btnNode2, "buyBtn21", 0, 0, "res/custom/npc/58cycf/an01.png")
	GUI:setContentSize(buyBtn21, 124, 50)
	GUI:setIgnoreContentAdaptWithSize(buyBtn21, false)
	GUI:Button_setTitleText(buyBtn21, [[]])
	GUI:Button_setTitleColor(buyBtn21, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn21, 16)
	GUI:Button_titleEnableOutline(buyBtn21, "#000000", 1)
	GUI:setAnchorPoint(buyBtn21, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn21, true)
	GUI:setTag(buyBtn21, 0)

	-- Create buyBtn22
	local buyBtn22 = GUI:Button_Create(btnNode2, "buyBtn22", 0, 0, "res/custom/npc/58cycf/an10.png")
	GUI:setContentSize(buyBtn22, 124, 50)
	GUI:setIgnoreContentAdaptWithSize(buyBtn22, false)
	GUI:Button_setTitleText(buyBtn22, [[]])
	GUI:Button_setTitleColor(buyBtn22, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn22, 16)
	GUI:Button_titleEnableOutline(buyBtn22, "#000000", 1)
	GUI:setAnchorPoint(buyBtn22, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn22, true)
	GUI:setTag(buyBtn22, 0)

	-- Create priceNode2
	local priceNode2 = GUI:Node_Create(buyNode2, "priceNode2", 622, 140)
	GUI:setTag(priceNode2, 0)

	-- Create priceText21
	local priceText21 = GUI:Text_Create(priceNode2, "priceText21", 0, 0, 16, "#ffff00", [[直购单价：128元]])
	GUI:Text_enableOutline(priceText21, "#000000", 1)
	GUI:setAnchorPoint(priceText21, 0.50, 0.50)
	GUI:setTouchEnabled(priceText21, false)
	GUI:setTag(priceText21, 0)

	-- Create priceText22
	local priceText22 = GUI:Text_Create(priceNode2, "priceText22", 0, 0, 16, "#ffff00", [[每日各限购1次]])
	GUI:Text_enableOutline(priceText22, "#000000", 1)
	GUI:setAnchorPoint(priceText22, 0.50, 0.50)
	GUI:setTouchEnabled(priceText22, false)
	GUI:setTag(priceText22, 0)

	-- Create tipsText
	local tipsText = GUI:Text_Create(infoNode, "tipsText", 78, 44, 16, "#00ff00", [[购买荣耀赐福，可进入【苍月岛隐藏地图】遗忘禁地，噩梦之渊
地图坐标每日随机刷新。]])
	GUI:Text_enableOutline(tipsText, "#000000", 1)
	GUI:setAnchorPoint(tipsText, 0.00, 0.00)
	GUI:setTouchEnabled(tipsText, false)
	GUI:setTag(tipsText, 0)

	-- Create goMapBtn1
	local goMapBtn1 = GUI:Button_Create(infoNode, "goMapBtn1", 550, 43, "res/custom/npc/58cycf/an4.png")
	GUI:setContentSize(goMapBtn1, 84, 36)
	GUI:setIgnoreContentAdaptWithSize(goMapBtn1, false)
	GUI:Button_setTitleText(goMapBtn1, [[]])
	GUI:Button_setTitleColor(goMapBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(goMapBtn1, 16)
	GUI:Button_titleEnableOutline(goMapBtn1, "#000000", 1)
	GUI:setAnchorPoint(goMapBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(goMapBtn1, true)
	GUI:setTag(goMapBtn1, 0)

	-- Create goMapBtn2
	local goMapBtn2 = GUI:Button_Create(infoNode, "goMapBtn2", 670, 43, "res/custom/npc/58cycf/an3.png")
	GUI:setContentSize(goMapBtn2, 84, 36)
	GUI:setIgnoreContentAdaptWithSize(goMapBtn2, false)
	GUI:Button_setTitleText(goMapBtn2, [[]])
	GUI:Button_setTitleColor(goMapBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(goMapBtn2, 16)
	GUI:Button_titleEnableOutline(goMapBtn2, "#000000", 1)
	GUI:setAnchorPoint(goMapBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(goMapBtn2, true)
	GUI:setTag(goMapBtn2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
