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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 560, 334, 800, 482, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/76hs/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 80, 80, 160, 160)
	GUI:setContentSize(FrameBG, 800, 482)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 780, 424, "res/custom/closeBtn2.png")
	GUI:setContentSize(CloseButton, 46, 46)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.50, 0.50)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	-- Create topNode
	local topNode = GUI:Node_Create(FrameLayout, "topNode", 510, 300)
	GUI:setTag(topNode, 0)

	-- Create boxNode1
	local boxNode1 = GUI:Node_Create(topNode, "boxNode1", 0, 0)
	GUI:setTag(boxNode1, 0)

	-- Create itemEffect1
	local itemEffect1 = GUI:Effect_Create(boxNode1, "itemEffect1", -12, 50, 0, 27582, 0, 0, 0, 1)
	GUI:setScale(itemEffect1, 0.50)
	GUI:setTag(itemEffect1, 0)

	-- Create itemName1
	local itemName1 = GUI:Text_Create(boxNode1, "itemName1", 0, -8, 18, "#ff00ff", [[《帝王福袋》]])
	GUI:Text_enableOutline(itemName1, "#000000", 1)
	GUI:setAnchorPoint(itemName1, 0.50, 0.50)
	GUI:setTouchEnabled(itemName1, false)
	GUI:setTag(itemName1, 0)

	-- Create item1
	local item1 = GUI:ItemShow_Create(boxNode1, "item1", -2, -63, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item1, 0.50, 0.50)
	GUI:setTag(item1, 0)

	-- Create boxNode2
	local boxNode2 = GUI:Node_Create(topNode, "boxNode2", 0, 0)
	GUI:setTag(boxNode2, 0)

	-- Create itemEffect2
	local itemEffect2 = GUI:Effect_Create(boxNode2, "itemEffect2", -12, 50, 0, 27582, 0, 0, 0, 1)
	GUI:setScale(itemEffect2, 0.50)
	GUI:setTag(itemEffect2, 0)

	-- Create itemName2
	local itemName2 = GUI:Text_Create(boxNode2, "itemName2", 0, -8, 18, "#ff00ff", [[《帝王福袋》]])
	GUI:Text_enableOutline(itemName2, "#000000", 1)
	GUI:setAnchorPoint(itemName2, 0.50, 0.50)
	GUI:setTouchEnabled(itemName2, false)
	GUI:setTag(itemName2, 0)

	-- Create item2
	local item2 = GUI:ItemShow_Create(boxNode2, "item2", -2, -63, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item2, 0.50, 0.50)
	GUI:setTag(item2, 0)

	-- Create boxNode3
	local boxNode3 = GUI:Node_Create(topNode, "boxNode3", 0, 0)
	GUI:setTag(boxNode3, 0)

	-- Create itemEffect3
	local itemEffect3 = GUI:Effect_Create(boxNode3, "itemEffect3", -12, 50, 0, 27582, 0, 0, 0, 1)
	GUI:setScale(itemEffect3, 0.50)
	GUI:setTag(itemEffect3, 0)

	-- Create itemName3
	local itemName3 = GUI:Text_Create(boxNode3, "itemName3", 0, -8, 18, "#ff00ff", [[《帝去福袋》]])
	GUI:Text_enableOutline(itemName3, "#000000", 1)
	GUI:setAnchorPoint(itemName3, 0.50, 0.50)
	GUI:setTouchEnabled(itemName3, false)
	GUI:setTag(itemName3, 0)

	-- Create item3
	local item3 = GUI:ItemShow_Create(boxNode3, "item3", -2, -63, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item3, 0.50, 0.50)
	GUI:setTag(item3, 0)

	-- Create btnNode1
	local btnNode1 = GUI:Node_Create(FrameLayout, "btnNode1", 510, 142)
	GUI:setTag(btnNode1, 0)

	-- Create buyBtn11
	local buyBtn11 = GUI:Button_Create(btnNode1, "buyBtn11", 55, 21, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(buyBtn11, 11, 11, 14, 14)
	GUI:setContentSize(buyBtn11, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(buyBtn11, false)
	GUI:Button_setTitleText(buyBtn11, [[1299灵符购买]])
	GUI:Button_setTitleColor(buyBtn11, "#F8E6C6")
	GUI:Button_setTitleFontSize(buyBtn11, 16)
	GUI:Button_titleEnableOutline(buyBtn11, "#000000", 1)
	GUI:setAnchorPoint(buyBtn11, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn11, true)
	GUI:setTag(buyBtn11, 0)

	-- Create Rtext11
	local Rtext11 = GUI:Text_Create(buyBtn11, "Rtext11", 55, -12, 16, "#ffffff", [[限购：1/10次]])
	GUI:Text_enableOutline(Rtext11, "#000000", 1)
	GUI:setAnchorPoint(Rtext11, 0.50, 0.50)
	GUI:setTouchEnabled(Rtext11, false)
	GUI:setTag(Rtext11, 0)

	-- Create buyBtn12
	local buyBtn12 = GUI:Button_Create(btnNode1, "buyBtn12", 55, 21, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(buyBtn12, 11, 11, 14, 14)
	GUI:setContentSize(buyBtn12, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(buyBtn12, false)
	GUI:Button_setTitleText(buyBtn12, [[1299灵符购买]])
	GUI:Button_setTitleColor(buyBtn12, "#F8E6C6")
	GUI:Button_setTitleFontSize(buyBtn12, 16)
	GUI:Button_titleEnableOutline(buyBtn12, "#000000", 1)
	GUI:setAnchorPoint(buyBtn12, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn12, true)
	GUI:setTag(buyBtn12, 0)

	-- Create Rtext12
	local Rtext12 = GUI:Text_Create(buyBtn12, "Rtext12", 55, -12, 16, "#ffffff", [[限购：1/10次]])
	GUI:Text_enableOutline(Rtext12, "#000000", 1)
	GUI:setAnchorPoint(Rtext12, 0.50, 0.50)
	GUI:setTouchEnabled(Rtext12, false)
	GUI:setTag(Rtext12, 0)

	-- Create buyBtn13
	local buyBtn13 = GUI:Button_Create(btnNode1, "buyBtn13", 55, 21, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(buyBtn13, 11, 11, 14, 14)
	GUI:setContentSize(buyBtn13, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(buyBtn13, false)
	GUI:Button_setTitleText(buyBtn13, [[1299灵符购买]])
	GUI:Button_setTitleColor(buyBtn13, "#F8E6C6")
	GUI:Button_setTitleFontSize(buyBtn13, 16)
	GUI:Button_titleEnableOutline(buyBtn13, "#000000", 1)
	GUI:setAnchorPoint(buyBtn13, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn13, true)
	GUI:setTag(buyBtn13, 0)

	-- Create Rtext13
	local Rtext13 = GUI:Text_Create(buyBtn13, "Rtext13", 55, -12, 16, "#ffffff", [[限购：1/10次]])
	GUI:Text_enableOutline(Rtext13, "#000000", 1)
	GUI:setAnchorPoint(Rtext13, 0.50, 0.50)
	GUI:setTouchEnabled(Rtext13, false)
	GUI:setTag(Rtext13, 0)

	-- Create btnNode2
	local btnNode2 = GUI:Node_Create(FrameLayout, "btnNode2", 510, 72)
	GUI:setTag(btnNode2, 0)

	-- Create buyBtn21
	local buyBtn21 = GUI:Button_Create(btnNode2, "buyBtn21", 55, 21, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(buyBtn21, 11, 11, 14, 14)
	GUI:setContentSize(buyBtn21, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(buyBtn21, false)
	GUI:Button_setTitleText(buyBtn21, [[1299灵符购买]])
	GUI:Button_setTitleColor(buyBtn21, "#F8E6C6")
	GUI:Button_setTitleFontSize(buyBtn21, 16)
	GUI:Button_titleEnableOutline(buyBtn21, "#000000", 1)
	GUI:setAnchorPoint(buyBtn21, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn21, true)
	GUI:setTag(buyBtn21, 0)

	-- Create Rtext21
	local Rtext21 = GUI:Text_Create(buyBtn21, "Rtext21", 55, -12, 16, "#ffffff", [[限购：1/10次]])
	GUI:Text_enableOutline(Rtext21, "#000000", 1)
	GUI:setAnchorPoint(Rtext21, 0.50, 0.50)
	GUI:setTouchEnabled(Rtext21, false)
	GUI:setTag(Rtext21, 0)

	-- Create buyBtn22
	local buyBtn22 = GUI:Button_Create(btnNode2, "buyBtn22", 55, 21, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(buyBtn22, 11, 11, 14, 14)
	GUI:setContentSize(buyBtn22, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(buyBtn22, false)
	GUI:Button_setTitleText(buyBtn22, [[1299灵符购买]])
	GUI:Button_setTitleColor(buyBtn22, "#F8E6C6")
	GUI:Button_setTitleFontSize(buyBtn22, 16)
	GUI:Button_titleEnableOutline(buyBtn22, "#000000", 1)
	GUI:setAnchorPoint(buyBtn22, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn22, true)
	GUI:setTag(buyBtn22, 0)

	-- Create Rtext22
	local Rtext22 = GUI:Text_Create(buyBtn22, "Rtext22", 55, -12, 16, "#ffffff", [[限购：1/10次]])
	GUI:Text_enableOutline(Rtext22, "#000000", 1)
	GUI:setAnchorPoint(Rtext22, 0.50, 0.50)
	GUI:setTouchEnabled(Rtext22, false)
	GUI:setTag(Rtext22, 0)

	-- Create buyBtn23
	local buyBtn23 = GUI:Button_Create(btnNode2, "buyBtn23", 55, 21, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(buyBtn23, 11, 11, 14, 14)
	GUI:setContentSize(buyBtn23, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(buyBtn23, false)
	GUI:Button_setTitleText(buyBtn23, [[1299灵符购买]])
	GUI:Button_setTitleColor(buyBtn23, "#F8E6C6")
	GUI:Button_setTitleFontSize(buyBtn23, 16)
	GUI:Button_titleEnableOutline(buyBtn23, "#000000", 1)
	GUI:setAnchorPoint(buyBtn23, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn23, true)
	GUI:setTag(buyBtn23, 0)

	-- Create Rtext23
	local Rtext23 = GUI:Text_Create(buyBtn23, "Rtext23", 55, -12, 16, "#ffffff", [[限购：1/10次]])
	GUI:Text_enableOutline(Rtext23, "#000000", 1)
	GUI:setAnchorPoint(Rtext23, 0.50, 0.50)
	GUI:setTouchEnabled(Rtext23, false)
	GUI:setTag(Rtext23, 0)

	-- Create mask
	local mask = GUI:Layout_Create(FrameLayout, "mask", 410, 228, 1136, 640, false)
	GUI:setAnchorPoint(mask, 0.50, 0.50)
	GUI:setTouchEnabled(mask, true)
	GUI:setTag(mask, 0)
	GUI:setVisible(mask, false)

	-- Create copyMapBox
	local copyMapBox = GUI:Image_Create(mask, "copyMapBox", 620, 320, "res/public/1900000600.png")
	GUI:Image_setScale9Slice(copyMapBox, 0, 0, 0, 0)
	GUI:setContentSize(copyMapBox, 450, 200)
	GUI:setIgnoreContentAdaptWithSize(copyMapBox, false)
	GUI:setAnchorPoint(copyMapBox, 0.50, 0.50)
	GUI:setTouchEnabled(copyMapBox, true)
	GUI:setTag(copyMapBox, 0)

	-- Create copyText1
	local copyText1 = GUI:Text_Create(copyMapBox, "copyText1", 224, 160, 18, "#ff00ff", [[《根骨福袋》]])
	GUI:Text_enableOutline(copyText1, "#000000", 1)
	GUI:setAnchorPoint(copyText1, 0.50, 0.50)
	GUI:setTouchEnabled(copyText1, false)
	GUI:setTag(copyText1, 0)

	-- Create copyText2
	local copyText2 = GUI:Text_Create(copyMapBox, "copyText2", 224, 130, 16, "#ffff00", [[礼包价格：48元]])
	GUI:Text_enableOutline(copyText2, "#000000", 1)
	GUI:setAnchorPoint(copyText2, 0.50, 0.50)
	GUI:setTouchEnabled(copyText2, false)
	GUI:setTag(copyText2, 0)

	-- Create copyText3
	local copyText3 = GUI:Text_Create(copyMapBox, "copyText3", 224, 100, 16, "#00ff00", [[限购次数：0/10]])
	GUI:Text_enableOutline(copyText3, "#000000", 1)
	GUI:setAnchorPoint(copyText3, 0.50, 0.50)
	GUI:setTouchEnabled(copyText3, false)
	GUI:setTag(copyText3, 0)

	-- Create buyBtn_1
	local buyBtn_1 = GUI:Button_Create(copyMapBox, "buyBtn_1", 144, 52, "res/custom/bt_dz.png")
	GUI:setContentSize(buyBtn_1, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(buyBtn_1, false)
	GUI:Button_setTitleText(buyBtn_1, [[购买1次]])
	GUI:Button_setTitleColor(buyBtn_1, "#f8e6c6")
	GUI:Button_setTitleFontSize(buyBtn_1, 16)
	GUI:Button_titleEnableOutline(buyBtn_1, "#000000", 1)
	GUI:setAnchorPoint(buyBtn_1, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn_1, true)
	GUI:setTag(buyBtn_1, 0)

	-- Create buyBtn_10
	local buyBtn_10 = GUI:Button_Create(copyMapBox, "buyBtn_10", 304, 52, "res/custom/bt_dz.png")
	GUI:setContentSize(buyBtn_10, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(buyBtn_10, false)
	GUI:Button_setTitleText(buyBtn_10, [[购买10次]])
	GUI:Button_setTitleColor(buyBtn_10, "#f8e6c6")
	GUI:Button_setTitleFontSize(buyBtn_10, 16)
	GUI:Button_titleEnableOutline(buyBtn_10, "#000000", 1)
	GUI:setAnchorPoint(buyBtn_10, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn_10, true)
	GUI:setTag(buyBtn_10, 0)

	-- Create maskCloseBtn
	local maskCloseBtn = GUI:Button_Create(copyMapBox, "maskCloseBtn", 484, 200, "res/custom/closeBtn.png")
	GUI:setContentSize(maskCloseBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(maskCloseBtn, false)
	GUI:Button_setTitleText(maskCloseBtn, [[]])
	GUI:Button_setTitleColor(maskCloseBtn, "#ffffff")
	GUI:Button_setTitleFontSize(maskCloseBtn, 16)
	GUI:Button_titleEnableOutline(maskCloseBtn, "#000000", 1)
	GUI:setAnchorPoint(maskCloseBtn, 1.00, 1.00)
	GUI:setTouchEnabled(maskCloseBtn, true)
	GUI:setTag(maskCloseBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
