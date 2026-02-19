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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/89zz/bg1.png")
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create leftBox
	local leftBox = GUI:Layout_Create(FrameBG, "leftBox", 69, 308, 449, 352, true)
	GUI:setAnchorPoint(leftBox, 0.00, 0.50)
	GUI:setTouchEnabled(leftBox, false)
	GUI:setTag(leftBox, 0)

	-- Create ball1
	local ball1 = GUI:Image_Create(leftBox, "ball1", 37, 293, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball1, 0.50, 0.50)
	GUI:setTouchEnabled(ball1, false)
	GUI:setTag(ball1, 0)

	-- Create ball2
	local ball2 = GUI:Image_Create(leftBox, "ball2", 37, 231, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball2, 0.50, 0.50)
	GUI:setTouchEnabled(ball2, false)
	GUI:setTag(ball2, 0)

	-- Create line_2
	local line_2 = GUI:Image_Create(ball2, "line_2", 20, 51, "res/custom/npc/89zz/t2.png")
	GUI:setContentSize(line_2, 10, 24)
	GUI:setIgnoreContentAdaptWithSize(line_2, false)
	GUI:setAnchorPoint(line_2, 0.50, 0.50)
	GUI:setTouchEnabled(line_2, false)
	GUI:setTag(line_2, 0)
	GUI:setVisible(line_2, false)

	-- Create ball3
	local ball3 = GUI:Image_Create(leftBox, "ball3", 36, 169, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball3, 0.50, 0.50)
	GUI:setTouchEnabled(ball3, false)
	GUI:setTag(ball3, 0)

	-- Create line_3
	local line_3 = GUI:Image_Create(ball3, "line_3", 20, 51, "res/custom/npc/89zz/t2.png")
	GUI:setContentSize(line_3, 10, 24)
	GUI:setIgnoreContentAdaptWithSize(line_3, false)
	GUI:setAnchorPoint(line_3, 0.50, 0.50)
	GUI:setTouchEnabled(line_3, false)
	GUI:setTag(line_3, 0)
	GUI:setVisible(line_3, false)

	-- Create ball4
	local ball4 = GUI:Image_Create(leftBox, "ball4", 37, 108, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball4, 0.50, 0.50)
	GUI:setTouchEnabled(ball4, false)
	GUI:setTag(ball4, 0)

	-- Create line_4
	local line_4 = GUI:Image_Create(ball4, "line_4", 20, 51, "res/custom/npc/89zz/t2.png")
	GUI:setContentSize(line_4, 10, 24)
	GUI:setIgnoreContentAdaptWithSize(line_4, false)
	GUI:setAnchorPoint(line_4, 0.50, 0.50)
	GUI:setTouchEnabled(line_4, false)
	GUI:setTag(line_4, 0)
	GUI:setVisible(line_4, false)

	-- Create ball5
	local ball5 = GUI:Image_Create(leftBox, "ball5", 37, 45, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball5, 0.50, 0.50)
	GUI:setTouchEnabled(ball5, false)
	GUI:setTag(ball5, 0)

	-- Create line_5
	local line_5 = GUI:Image_Create(ball5, "line_5", 20, 51, "res/custom/npc/89zz/t2.png")
	GUI:setContentSize(line_5, 10, 24)
	GUI:setIgnoreContentAdaptWithSize(line_5, false)
	GUI:setAnchorPoint(line_5, 0.50, 0.50)
	GUI:setTouchEnabled(line_5, false)
	GUI:setTag(line_5, 0)
	GUI:setVisible(line_5, false)

	-- Create ball6
	local ball6 = GUI:Image_Create(leftBox, "ball6", 415, 293, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball6, 0.50, 0.50)
	GUI:setTouchEnabled(ball6, false)
	GUI:setTag(ball6, 0)

	-- Create line_6
	local line_6 = GUI:Image_Create(ball6, "line_6", 20, -9, "res/custom/npc/89zz/t2.png")
	GUI:setContentSize(line_6, 10, 24)
	GUI:setIgnoreContentAdaptWithSize(line_6, false)
	GUI:setAnchorPoint(line_6, 0.50, 0.50)
	GUI:setTouchEnabled(line_6, false)
	GUI:setTag(line_6, 0)
	GUI:setVisible(line_6, false)

	-- Create ball7
	local ball7 = GUI:Image_Create(leftBox, "ball7", 416, 232, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball7, 0.50, 0.50)
	GUI:setTouchEnabled(ball7, false)
	GUI:setTag(ball7, 0)

	-- Create line_7
	local line_7 = GUI:Image_Create(ball7, "line_7", 20, -9, "res/custom/npc/89zz/t2.png")
	GUI:setContentSize(line_7, 10, 24)
	GUI:setIgnoreContentAdaptWithSize(line_7, false)
	GUI:setAnchorPoint(line_7, 0.50, 0.50)
	GUI:setTouchEnabled(line_7, false)
	GUI:setTag(line_7, 0)
	GUI:setVisible(line_7, false)

	-- Create ball8
	local ball8 = GUI:Image_Create(leftBox, "ball8", 415, 169, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball8, 0.50, 0.50)
	GUI:setTouchEnabled(ball8, false)
	GUI:setTag(ball8, 0)

	-- Create line_8
	local line_8 = GUI:Image_Create(ball8, "line_8", 20, -9, "res/custom/npc/89zz/t2.png")
	GUI:setContentSize(line_8, 10, 24)
	GUI:setIgnoreContentAdaptWithSize(line_8, false)
	GUI:setAnchorPoint(line_8, 0.50, 0.50)
	GUI:setTouchEnabled(line_8, false)
	GUI:setTag(line_8, 0)
	GUI:setVisible(line_8, false)

	-- Create ball9
	local ball9 = GUI:Image_Create(leftBox, "ball9", 416, 108, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball9, 0.50, 0.50)
	GUI:setTouchEnabled(ball9, false)
	GUI:setTag(ball9, 0)

	-- Create line_9
	local line_9 = GUI:Image_Create(ball9, "line_9", 20, -9, "res/custom/npc/89zz/t2.png")
	GUI:setContentSize(line_9, 10, 24)
	GUI:setIgnoreContentAdaptWithSize(line_9, false)
	GUI:setAnchorPoint(line_9, 0.50, 0.50)
	GUI:setTouchEnabled(line_9, false)
	GUI:setTag(line_9, 0)
	GUI:setVisible(line_9, false)

	-- Create ball10
	local ball10 = GUI:Image_Create(leftBox, "ball10", 416, 46, "res/custom/npc/89zz/t1.png")
	GUI:setAnchorPoint(ball10, 0.50, 0.50)
	GUI:setTouchEnabled(ball10, false)
	GUI:setTag(ball10, 0)

	-- Create effect_node
	local effect_node = GUI:Layout_Create(leftBox, "effect_node", 116, 44, 227, 247, false)
	GUI:setAnchorPoint(effect_node, 0.00, 0.00)
	GUI:setTouchEnabled(effect_node, false)
	GUI:setTag(effect_node, 0)

	-- Create name
	local name = GUI:Text_Create(leftBox, "name", 161, 318, 16, "#00ff00", [[归墟元神LV3444]])
	GUI:setIgnoreContentAdaptWithSize(name, false)
	GUI:Text_setTextAreaSize(name, 119, 24)
	GUI:Text_setTextHorizontalAlignment(name, 1)
	GUI:Text_setTextVerticalAlignment(name, 1)
	GUI:Text_enableOutline(name, "#000000", 1)
	GUI:setAnchorPoint(name, 0.00, 0.00)
	GUI:setTouchEnabled(name, false)
	GUI:setTag(name, 0)

	-- Create rightBox
	local rightBox = GUI:Layout_Create(FrameBG, "rightBox", 801, 250, 278, 416, true)
	GUI:setAnchorPoint(rightBox, 1.00, 0.50)
	GUI:setTouchEnabled(rightBox, false)
	GUI:setTag(rightBox, 0)

	-- Create infoList1
	local infoList1 = GUI:ListView_Create(rightBox, "infoList1", 139, 360, 90, 100, 1)
	GUI:ListView_setClippingEnabled(infoList1, false)
	GUI:ListView_setItemsMargin(infoList1, 2)
	GUI:setAnchorPoint(infoList1, 0.50, 0.50)
	GUI:setTouchEnabled(infoList1, true)
	GUI:setTag(infoList1, 0)

	-- Create text11
	local text11 = GUI:Text_Create(infoList1, "text11", 0, 76, 16, "#ffffff", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text11, "#000000", 1)
	GUI:setAnchorPoint(text11, 0.00, 0.00)
	GUI:setTouchEnabled(text11, false)
	GUI:setTag(text11, 0)

	-- Create text12
	local text12 = GUI:Text_Create(infoList1, "text12", 0, 50, 16, "#ffffff", [[ 防御：0-0]])
	GUI:Text_enableOutline(text12, "#000000", 1)
	GUI:setAnchorPoint(text12, 0.00, 0.00)
	GUI:setTouchEnabled(text12, false)
	GUI:setTag(text12, 0)

	-- Create text13
	local text13 = GUI:Text_Create(infoList1, "text13", 0, 24, 16, "#ffffff", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text13, "#000000", 1)
	GUI:setAnchorPoint(text13, 0.00, 0.00)
	GUI:setTouchEnabled(text13, false)
	GUI:setTag(text13, 0)

	-- Create text14
	local text14 = GUI:Text_Create(infoList1, "text14", 0, -2, 16, "#ffffff", [[生命值：0]])
	GUI:Text_enableOutline(text14, "#000000", 1)
	GUI:setAnchorPoint(text14, 0.00, 0.00)
	GUI:setTouchEnabled(text14, false)
	GUI:setTag(text14, 0)

	-- Create infoList2
	local infoList2 = GUI:ListView_Create(rightBox, "infoList2", 140, 224, 90, 100, 1)
	GUI:ListView_setClippingEnabled(infoList2, false)
	GUI:ListView_setItemsMargin(infoList2, 2)
	GUI:setAnchorPoint(infoList2, 0.50, 0.50)
	GUI:setTouchEnabled(infoList2, true)
	GUI:setTag(infoList2, 0)

	-- Create text21
	local text21 = GUI:Text_Create(infoList2, "text21", 0, 76, 16, "#00ff00", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text21, "#000000", 1)
	GUI:setAnchorPoint(text21, 0.00, 0.00)
	GUI:setTouchEnabled(text21, false)
	GUI:setTag(text21, 0)

	-- Create text22
	local text22 = GUI:Text_Create(infoList2, "text22", 0, 50, 16, "#00ff00", [[ 防御：0-0]])
	GUI:Text_enableOutline(text22, "#000000", 1)
	GUI:setAnchorPoint(text22, 0.00, 0.00)
	GUI:setTouchEnabled(text22, false)
	GUI:setTag(text22, 0)

	-- Create text23
	local text23 = GUI:Text_Create(infoList2, "text23", 0, 24, 16, "#00ff00", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text23, "#000000", 1)
	GUI:setAnchorPoint(text23, 0.00, 0.00)
	GUI:setTouchEnabled(text23, false)
	GUI:setTag(text23, 0)

	-- Create text24
	local text24 = GUI:Text_Create(infoList2, "text24", 0, -2, 16, "#00ff00", [[生命值：0]])
	GUI:Text_enableOutline(text24, "#000000", 1)
	GUI:setAnchorPoint(text24, 0.00, 0.00)
	GUI:setTouchEnabled(text24, false)
	GUI:setTag(text24, 0)

	-- Create need_box
	local need_box = GUI:ListView_Create(rightBox, "need_box", 142, 101, 191, 75, 2)
	GUI:ListView_setGravity(need_box, 5)
	GUI:ListView_setItemsMargin(need_box, 5)
	GUI:setAnchorPoint(need_box, 0.50, 0.50)
	GUI:setTouchEnabled(need_box, true)
	GUI:setTag(need_box, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(need_box, "ItemShow_1", 30, 37, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(need_box, "ItemShow_2", 95, 37, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(need_box, "ItemShow_3", 160, 37, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightBox, "upBtn", 144, 33, "res/custom/npc/89zz/an1.png")
	GUI:setContentSize(upBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[]])
	GUI:Button_setTitleColor(upBtn, "#F8E6C6")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, -1)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameBG, "RichText_1", 73, 49, [==========[<font color='#ffffff' size='16' >提升元神，需要在异次元地图收集</font><font color='#00ff00' size='16' >[定魂针]</font><font color='#ffffff' size='16' >与</font><font color='#00ff00' size='16' >[元神丹]</font><br><font color='#ffffff' size='16' >打通元神，即可获得元神属性提升并获得一次</font><font color='#00ff00' size='16' >异次元之力</font><br><font color='#ffffff' size='16' >突破元神，即可获得</font><font color='#00ff00' size='16' >额外</font><font color='#ffffff' size='16' >的</font><font color='#00ff00' size='16' >突破属性！</font>]==========], 450, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 821, 488, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.00, 0.00)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
