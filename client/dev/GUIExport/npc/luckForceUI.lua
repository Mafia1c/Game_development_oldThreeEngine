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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/60ws/bg1.png")
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
	local personEffect = GUI:Effect_Create(infoNode, "personEffect", 172, 260, 0, 20442, 0, 0, 0, 1)
	GUI:setTag(personEffect, 0)

	-- Create clothesItem
	local clothesItem = GUI:ItemShow_Create(infoNode, "clothesItem", 430, 364, {index = 10236, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(clothesItem, 0.50, 0.50)
	GUI:setTag(clothesItem, 0)

	-- Create itemNode1
	local itemNode1 = GUI:Node_Create(infoNode, "itemNode1", 620, 296)
	GUI:setTag(itemNode1, 0)

	-- Create item1
	local item1 = GUI:ItemShow_Create(itemNode1, "item1", 0, 0, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(item1, 0.50, 0.50)
	GUI:setTag(item1, 0)

	-- Create item2
	local item2 = GUI:ItemShow_Create(itemNode1, "item2", 0, 0, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(item2, 0.50, 0.50)
	GUI:setTag(item2, 0)

	-- Create itemNode2
	local itemNode2 = GUI:Node_Create(infoNode, "itemNode2", 620, 226)
	GUI:setTag(itemNode2, 0)

	-- Create item3
	local item3 = GUI:ItemShow_Create(itemNode2, "item3", 0, 0, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(item3, 0.50, 0.50)
	GUI:setTag(item3, 0)

	-- Create item4
	local item4 = GUI:ItemShow_Create(itemNode2, "item4", 0, 0, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(item4, 0.50, 0.50)
	GUI:setTag(item4, 0)

	-- Create item5
	local item5 = GUI:ItemShow_Create(itemNode2, "item5", 0, 0, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(item5, 0.50, 0.50)
	GUI:setTag(item5, 0)

	-- Create downBtn1
	local downBtn1 = GUI:Button_Create(infoNode, "downBtn1", 620, 154, "res/custom/npc/60ws/yjgm.png")
	GUI:Button_setTitleText(downBtn1, [[]])
	GUI:Button_setTitleColor(downBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(downBtn1, 16)
	GUI:Button_titleEnableOutline(downBtn1, "#000000", 1)
	GUI:setAnchorPoint(downBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(downBtn1, true)
	GUI:setTag(downBtn1, 0)

	-- Create priceText
	local priceText = GUI:Text_Create(downBtn1, "priceText", 50, -20, 16, "#ffff00", [[价格：288元]])
	GUI:Text_enableOutline(priceText, "#000000", 1)
	GUI:setAnchorPoint(priceText, 0.50, 0.50)
	GUI:setTouchEnabled(priceText, false)
	GUI:setTag(priceText, 0)

	-- Create downBtn2
	local downBtn2 = GUI:Button_Create(infoNode, "downBtn2", 620, 154, "res/custom/npc/60ws/mrlq.png")
	GUI:Button_setTitleText(downBtn2, [[]])
	GUI:Button_setTitleColor(downBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(downBtn2, 16)
	GUI:Button_titleEnableOutline(downBtn2, "#000000", 1)
	GUI:setAnchorPoint(downBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(downBtn2, true)
	GUI:setTag(downBtn2, 0)
	GUI:setVisible(downBtn2, false)

	-- Create todayText
	local todayText = GUI:Text_Create(downBtn2, "todayText", 50, -20, 16, "#00ff00", [[每日可领取]])
	GUI:Text_enableOutline(todayText, "#000000", 1)
	GUI:setAnchorPoint(todayText, 0.50, 0.50)
	GUI:setTouchEnabled(todayText, false)
	GUI:setTag(todayText, 0)

	-- Create tipsText
	local tipsText = GUI:Text_Create(infoNode, "tipsText", 438, 56, 16, "#ffff00", [[激活武圣赐福礼包：可免费领取0/30天礼包奖励]])
	GUI:Text_enableOutline(tipsText, "#000000", 1)
	GUI:setAnchorPoint(tipsText, 0.50, 0.50)
	GUI:setTouchEnabled(tipsText, false)
	GUI:setTag(tipsText, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
