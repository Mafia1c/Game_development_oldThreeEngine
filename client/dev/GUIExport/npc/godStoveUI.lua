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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 553, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/96sl/bg2.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 838, 504, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.50, 0.50)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	-- Create leftList
	local leftList = GUI:ListView_Create(FrameLayout, "leftList", 76, 476, 114, 440, 1)
	GUI:ListView_setItemsMargin(leftList, 2)
	GUI:setAnchorPoint(leftList, 0.00, 1.00)
	GUI:setTouchEnabled(leftList, true)
	GUI:setTag(leftList, 0)

	-- Create leftBtn1
	local leftBtn1 = GUI:Image_Create(leftList, "leftBtn1", 0, 398, "res/custom/dayeqian2.png")
	GUI:setAnchorPoint(leftBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn1, false)
	GUI:setTag(leftBtn1, 0)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create item_end
	local item_end = GUI:ItemShow_Create(midNode, "item_end", 373, 348, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(item_end, 0.50, 0.50)
	GUI:setTag(item_end, 0)

	-- Create arrowImage
	local arrowImage = GUI:Image_Create(midNode, "arrowImage", 374, 268, "res/custom/npc/96sl/t1.png")
	GUI:setContentSize(arrowImage, 32, 40)
	GUI:setIgnoreContentAdaptWithSize(arrowImage, false)
	GUI:setAnchorPoint(arrowImage, 0.50, 0.50)
	GUI:setTouchEnabled(arrowImage, false)
	GUI:setTag(arrowImage, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 378, 190)
	GUI:setTag(needItemNode, 0)

	-- Create itemBox1
	local itemBox1 = GUI:Image_Create(needItemNode, "itemBox1", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(itemBox1, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1, false)
	GUI:setTag(itemBox1, 0)

	-- Create itemBox2
	local itemBox2 = GUI:Image_Create(needItemNode, "itemBox2", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(itemBox2, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox2, false)
	GUI:setTag(itemBox2, 0)

	-- Create itemBox3
	local itemBox3 = GUI:Image_Create(needItemNode, "itemBox3", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(itemBox3, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox3, false)
	GUI:setTag(itemBox3, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameLayout, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create rightBigList
	local rightBigList = GUI:ListView_Create(rightNode, "rightBigList", 679, 278, 242, 332, 1)
	GUI:ListView_setBounceEnabled(rightBigList, true)
	GUI:ListView_setItemsMargin(rightBigList, 6)
	GUI:setAnchorPoint(rightBigList, 0.50, 0.50)
	GUI:setTouchEnabled(rightBigList, true)
	GUI:setTag(rightBigList, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(rightBigList, "ListView_1", 0, 272, 242, 60, 2)
	GUI:ListView_setGravity(ListView_1, 3)
	GUI:ListView_setItemsMargin(ListView_1, 2)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(ListView_1, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(ListView_1, "Image_3", 61, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(ListView_1, "Image_5", 122, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(ListView_1, "Image_6", 183, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(rightBigList, "ListView_2", 0, 206, 242, 60, 2)
	GUI:ListView_setGravity(ListView_2, 3)
	GUI:ListView_setItemsMargin(ListView_2, 2)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_2, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_2, "Image_3", 61, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_2, "Image_5", 122, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_2, "Image_6", 183, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_3
	local ListView_3 = GUI:ListView_Create(rightBigList, "ListView_3", 0, 140, 242, 60, 2)
	GUI:ListView_setGravity(ListView_3, 3)
	GUI:ListView_setItemsMargin(ListView_3, 2)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_3, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_3, "Image_3", 61, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_3, "Image_5", 122, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_3, "Image_6", 183, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_4
	local ListView_4 = GUI:ListView_Create(rightBigList, "ListView_4", 0, 74, 242, 60, 2)
	GUI:ListView_setGravity(ListView_4, 3)
	GUI:ListView_setItemsMargin(ListView_4, 2)
	GUI:setAnchorPoint(ListView_4, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_4, true)
	GUI:setTag(ListView_4, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_4, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_4, "Image_3", 61, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_4, "Image_5", 122, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_4, "Image_6", 183, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_5
	local ListView_5 = GUI:ListView_Create(rightBigList, "ListView_5", 0, 8, 242, 60, 2)
	GUI:ListView_setGravity(ListView_5, 3)
	GUI:ListView_setItemsMargin(ListView_5, 2)
	GUI:setAnchorPoint(ListView_5, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_5, true)
	GUI:setTag(ListView_5, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_5, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_5, "Image_3", 61, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_5, "Image_5", 122, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_5, "Image_6", 183, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create downBox
	local downBox = GUI:Layout_Create(FrameLayout, "downBox", 500, 66, 614, 80, false)
	GUI:setAnchorPoint(downBox, 0.50, 0.50)
	GUI:setTouchEnabled(downBox, false)
	GUI:setTag(downBox, 0)

	-- Create dwonText11
	local dwonText11 = GUI:Text_Create(downBox, "dwonText11", 72, 44, 16, "#ffffff", [[1.需要收集对应的道具材料]])
	GUI:Text_enableOutline(dwonText11, "#000000", 1)
	GUI:setAnchorPoint(dwonText11, 0.00, 0.00)
	GUI:setTouchEnabled(dwonText11, false)
	GUI:setTag(dwonText11, 0)

	-- Create dwonText12
	local dwonText12 = GUI:Text_Create(dwonText11, "dwonText12", 190, 0, 16, "#00ff00", [[的道具材料]])
	GUI:Text_enableOutline(dwonText12, "#000000", 1)
	GUI:setAnchorPoint(dwonText12, 0.00, 0.00)
	GUI:setTouchEnabled(dwonText12, false)
	GUI:setTag(dwonText12, 0)

	-- Create dwonText21
	local dwonText21 = GUI:Text_Create(downBox, "dwonText21", 72, 20, 16, "#ffffff", [[2.熔炼成功率：]])
	GUI:Text_enableOutline(dwonText21, "#000000", 1)
	GUI:setAnchorPoint(dwonText21, 0.00, 0.00)
	GUI:setTouchEnabled(dwonText21, false)
	GUI:setTag(dwonText21, 0)

	-- Create dwonText22
	local dwonText22 = GUI:Text_Create(dwonText21, "dwonText22", 110, 0, 16, "#00ff00", [[100%]])
	GUI:Text_enableOutline(dwonText22, "#000000", 1)
	GUI:setAnchorPoint(dwonText22, 0.00, 0.00)
	GUI:setTouchEnabled(dwonText22, false)
	GUI:setTag(dwonText22, 0)

	-- Create upBtn10
	local upBtn10 = GUI:Button_Create(downBox, "upBtn10", 424, 40, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn10, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn10, false)
	GUI:Button_setTitleText(upBtn10, [[熔炼10次]])
	GUI:Button_setTitleColor(upBtn10, "#F8E6C6")
	GUI:Button_setTitleFontSize(upBtn10, 18)
	GUI:Button_titleEnableOutline(upBtn10, "#000000", 1)
	GUI:setAnchorPoint(upBtn10, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn10, true)
	GUI:setTag(upBtn10, 0)

	-- Create upBtn1
	local upBtn1 = GUI:Button_Create(downBox, "upBtn1", 546, 40, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn1, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn1, false)
	GUI:Button_setTitleText(upBtn1, [[熔炼1次]])
	GUI:Button_setTitleColor(upBtn1, "#F8E6C6")
	GUI:Button_setTitleFontSize(upBtn1, 18)
	GUI:Button_titleEnableOutline(upBtn1, "#000000", 1)
	GUI:setAnchorPoint(upBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn1, true)
	GUI:setTag(upBtn1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
