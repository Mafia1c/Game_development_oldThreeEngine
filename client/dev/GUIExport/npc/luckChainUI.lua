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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/08xy/bg1.png")
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

	-- Create Image_4
	local Image_4 = GUI:Image_Create(leftList, "Image_4", 0, 398, "res/custom/dayeqian2.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create midBox
	local midBox = GUI:Layout_Create(FrameLayout, "midBox", 370, 296, 360, 380, true)
	GUI:setAnchorPoint(midBox, 0.50, 0.50)
	GUI:setTouchEnabled(midBox, false)
	GUI:setTag(midBox, 0)

	-- Create theItemBox
	local theItemBox = GUI:Layout_Create(midBox, "theItemBox", 0, 0, 360, 380, false)
	GUI:setAnchorPoint(theItemBox, 0.00, 0.00)
	GUI:setTouchEnabled(theItemBox, false)
	GUI:setTag(theItemBox, 0)

	-- Create Node_1
	local Node_1 = GUI:Node_Create(theItemBox, "Node_1", 70, 285)
	GUI:setTag(Node_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Node_1, "ItemShow_1", 0, 0, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Node_2
	local Node_2 = GUI:Node_Create(theItemBox, "Node_2", 290, 285)
	GUI:setTag(Node_2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(Node_2, "ItemShow_2", 0, 0, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create Node_3
	local Node_3 = GUI:Node_Create(theItemBox, "Node_3", 181, 188)
	GUI:setTag(Node_3, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(Node_3, "ItemShow_3", 0, 0, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(ItemShow_3, "Image_1", 38, 38, "res/custom/equip_tips.png")
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setScale(Image_1, 0.80)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create textBg
	local textBg = GUI:Image_Create(midBox, "textBg", 180, 78, "res/custom/blackBg1.png")
	GUI:Image_setScale9Slice(textBg, 33, 33, 20, 20)
	GUI:setContentSize(textBg, 350, 150)
	GUI:setIgnoreContentAdaptWithSize(textBg, false)
	GUI:setAnchorPoint(textBg, 0.50, 0.50)
	GUI:setTouchEnabled(textBg, false)
	GUI:setTag(textBg, 0)

	-- Create textList1
	local textList1 = GUI:ListView_Create(textBg, "textList1", 26, -6, 148, 146, 1)
	GUI:ListView_setItemsMargin(textList1, 8)
	GUI:setAnchorPoint(textList1, 0.00, 0.00)
	GUI:setTouchEnabled(textList1, true)
	GUI:setTag(textList1, 0)

	-- Create luckText
	local luckText = GUI:Text_Create(textList1, "luckText", 0, 122, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText, "#000000", 1)
	GUI:setAnchorPoint(luckText, 0.00, 0.00)
	GUI:setTouchEnabled(luckText, false)
	GUI:setTag(luckText, 0)

	-- Create luckNumber
	local luckNumber = GUI:Text_Create(luckText, "luckNumber", 110, -1, 16, "#ffff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create luckText_1
	local luckText_1 = GUI:Text_Create(textList1, "luckText_1", 0, 90, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText_1, "#000000", 1)
	GUI:setAnchorPoint(luckText_1, 0.00, 0.00)
	GUI:setTouchEnabled(luckText_1, false)
	GUI:setTag(luckText_1, 0)

	-- Create luckNumber
	luckNumber = GUI:Text_Create(luckText_1, "luckNumber", 110, -1, 16, "#ffff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create luckText_2
	local luckText_2 = GUI:Text_Create(textList1, "luckText_2", 0, 58, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText_2, "#000000", 1)
	GUI:setAnchorPoint(luckText_2, 0.00, 0.00)
	GUI:setTouchEnabled(luckText_2, false)
	GUI:setTag(luckText_2, 0)

	-- Create luckNumber
	luckNumber = GUI:Text_Create(luckText_2, "luckNumber", 110, -1, 16, "#ffff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create luckText_3
	local luckText_3 = GUI:Text_Create(textList1, "luckText_3", 0, 26, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText_3, "#000000", 1)
	GUI:setAnchorPoint(luckText_3, 0.00, 0.00)
	GUI:setTouchEnabled(luckText_3, false)
	GUI:setTag(luckText_3, 0)

	-- Create luckNumber
	luckNumber = GUI:Text_Create(luckText_3, "luckNumber", 110, -1, 16, "#ffff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create luckText_4
	local luckText_4 = GUI:Text_Create(textList1, "luckText_4", 0, -6, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText_4, "#000000", 1)
	GUI:setAnchorPoint(luckText_4, 0.00, 0.00)
	GUI:setTouchEnabled(luckText_4, false)
	GUI:setTag(luckText_4, 0)

	-- Create luckNumber
	luckNumber = GUI:Text_Create(luckText_4, "luckNumber", 110, -1, 16, "#ffff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create textList1_1
	local textList1_1 = GUI:ListView_Create(textBg, "textList1_1", 190, -6, 148, 146, 1)
	GUI:ListView_setItemsMargin(textList1_1, 8)
	GUI:setAnchorPoint(textList1_1, 0.00, 0.00)
	GUI:setTouchEnabled(textList1_1, true)
	GUI:setTag(textList1_1, 0)

	-- Create luckText
	luckText = GUI:Text_Create(textList1_1, "luckText", 0, 122, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText, "#000000", 1)
	GUI:setAnchorPoint(luckText, 0.00, 0.00)
	GUI:setTouchEnabled(luckText, false)
	GUI:setTag(luckText, 0)

	-- Create luckNumber
	luckNumber = GUI:Text_Create(luckText, "luckNumber", 110, -1, 16, "#00ff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create luckText_1
	luckText_1 = GUI:Text_Create(textList1_1, "luckText_1", 0, 90, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText_1, "#000000", 1)
	GUI:setAnchorPoint(luckText_1, 0.00, 0.00)
	GUI:setTouchEnabled(luckText_1, false)
	GUI:setTag(luckText_1, 0)

	-- Create luckNumber
	luckNumber = GUI:Text_Create(luckText_1, "luckNumber", 110, -1, 16, "#ffff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create luckText_2
	luckText_2 = GUI:Text_Create(textList1_1, "luckText_2", 0, 58, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText_2, "#000000", 1)
	GUI:setAnchorPoint(luckText_2, 0.00, 0.00)
	GUI:setTouchEnabled(luckText_2, false)
	GUI:setTag(luckText_2, 0)

	-- Create luckNumber
	luckNumber = GUI:Text_Create(luckText_2, "luckNumber", 110, -1, 16, "#ffff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create luckText_3
	luckText_3 = GUI:Text_Create(textList1_1, "luckText_3", 0, 26, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText_3, "#000000", 1)
	GUI:setAnchorPoint(luckText_3, 0.00, 0.00)
	GUI:setTouchEnabled(luckText_3, false)
	GUI:setTag(luckText_3, 0)

	-- Create luckNumber
	luckNumber = GUI:Text_Create(luckText_3, "luckNumber", 110, -1, 16, "#ffff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create luckText_4
	luckText_4 = GUI:Text_Create(textList1_1, "luckText_4", 0, -6, 16, "#ffffff", [[身上项链幸运：]])
	GUI:Text_enableOutline(luckText_4, "#000000", 1)
	GUI:setAnchorPoint(luckText_4, 0.00, 0.00)
	GUI:setTouchEnabled(luckText_4, false)
	GUI:setTag(luckText_4, 0)

	-- Create luckNumber
	luckNumber = GUI:Text_Create(luckText_4, "luckNumber", 110, -1, 16, "#ffff00", [[+0]])
	GUI:Text_enableOutline(luckNumber, "#000000", 1)
	GUI:setAnchorPoint(luckNumber, 0.00, 0.00)
	GUI:setTouchEnabled(luckNumber, false)
	GUI:setTag(luckNumber, 0)

	-- Create rightBox
	local rightBox = GUI:Layout_Create(FrameLayout, "rightBox", 676, 294, 254, 380, true)
	GUI:setAnchorPoint(rightBox, 0.50, 0.50)
	GUI:setTouchEnabled(rightBox, false)
	GUI:setTag(rightBox, 0)

	-- Create text11
	local text11 = GUI:Text_Create(rightBox, "text11", 72, 356, 16, "#f0b42a", [==========[[幸运洗练说明]：]==========])
	GUI:Text_enableOutline(text11, "#000000", 1)
	GUI:setAnchorPoint(text11, 0.50, 0.50)
	GUI:setTouchEnabled(text11, false)
	GUI:setTag(text11, 0)
	GUI:setVisible(text11, false)

	-- Create text12
	local text12 = GUI:Text_Create(rightBox, "text12", 10, 340, 16, "#63d64a", [==========[[幸运洗练说明]11111111111111]==========])
	GUI:Text_enableOutline(text12, "#000000", 1)
	GUI:setAnchorPoint(text12, 0.00, 1.00)
	GUI:setTouchEnabled(text12, false)
	GUI:setTag(text12, 0)
	GUI:setVisible(text12, false)

	-- Create rightList
	local rightList = GUI:ListView_Create(rightBox, "rightList", 126, 140, 200, 160, 1)
	GUI:ListView_setItemsMargin(rightList, 10)
	GUI:setAnchorPoint(rightList, 0.50, 0.50)
	GUI:setTouchEnabled(rightList, true)
	GUI:setTag(rightList, 0)
	GUI:setVisible(rightList, false)

	-- Create textBlack1
	local textBlack1 = GUI:Image_Create(rightList, "textBlack1", 100, 115, "res/custom/blackBg2.png")
	GUI:Image_setScale9Slice(textBlack1, 5, 5, 10, 10)
	GUI:setContentSize(textBlack1, 200, 30)
	GUI:setIgnoreContentAdaptWithSize(textBlack1, false)
	GUI:setAnchorPoint(textBlack1, 0.50, 0.50)
	GUI:setTouchEnabled(textBlack1, false)
	GUI:setTag(textBlack1, 0)

	-- Create infoText11
	local infoText11 = GUI:Text_Create(textBlack1, "infoText11", 30, 3, 16, "#ff00ff", [[暴击伤害增加：0%]])
	GUI:Text_enableOutline(infoText11, "#000000", 1)
	GUI:setAnchorPoint(infoText11, 0.00, 0.00)
	GUI:setTouchEnabled(infoText11, false)
	GUI:setTag(infoText11, 0)

	-- Create rightBigList
	local rightBigList = GUI:ListView_Create(rightBox, "rightBigList", 0, 0, 254, 380, 1)
	GUI:ListView_setItemsMargin(rightBigList, 3)
	GUI:setAnchorPoint(rightBigList, 0.00, 0.00)
	GUI:setTouchEnabled(rightBigList, true)
	GUI:setTag(rightBigList, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(rightBigList, "ListView_1", 0, 320, 254, 60, 2)
	GUI:ListView_setGravity(ListView_1, 3)
	GUI:ListView_setItemsMargin(ListView_1, 5)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(ListView_1, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(Image_2, "ItemShow_4", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(ItemShow_4, "Panel_1", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(Panel_1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(ListView_1, "Image_3", 64, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(ListView_1, "Image_5", 128, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(ListView_1, "Image_6", 192, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(rightBigList, "ListView_2", 0, 257, 254, 60, 2)
	GUI:ListView_setGravity(ListView_2, 3)
	GUI:ListView_setItemsMargin(ListView_2, 5)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_2, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_2, "Image_3", 64, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_2, "Image_5", 128, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_2, "Image_6", 192, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_3
	local ListView_3 = GUI:ListView_Create(rightBigList, "ListView_3", 0, 194, 254, 60, 2)
	GUI:ListView_setGravity(ListView_3, 3)
	GUI:ListView_setItemsMargin(ListView_3, 5)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_3, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_3, "Image_3", 64, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_3, "Image_5", 128, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_3, "Image_6", 192, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_4
	local ListView_4 = GUI:ListView_Create(rightBigList, "ListView_4", 0, 131, 254, 60, 2)
	GUI:ListView_setGravity(ListView_4, 3)
	GUI:ListView_setItemsMargin(ListView_4, 5)
	GUI:setAnchorPoint(ListView_4, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_4, true)
	GUI:setTag(ListView_4, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_4, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_4, "Image_3", 64, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_4, "Image_5", 128, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_4, "Image_6", 192, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_5
	local ListView_5 = GUI:ListView_Create(rightBigList, "ListView_5", 0, 68, 254, 60, 2)
	GUI:ListView_setGravity(ListView_5, 3)
	GUI:ListView_setItemsMargin(ListView_5, 5)
	GUI:setAnchorPoint(ListView_5, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_5, true)
	GUI:setTag(ListView_5, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_5, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_5, "Image_3", 64, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_5, "Image_5", 128, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_5, "Image_6", 192, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_6
	local ListView_6 = GUI:ListView_Create(rightBigList, "ListView_6", 0, 5, 254, 60, 2)
	GUI:ListView_setGravity(ListView_6, 3)
	GUI:ListView_setItemsMargin(ListView_6, 5)
	GUI:setAnchorPoint(ListView_6, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_6, true)
	GUI:setTag(ListView_6, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_6, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_6, "Image_3", 64, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_6, "Image_5", 128, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_6, "Image_6", 192, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create downBox
	local downBox = GUI:Layout_Create(FrameLayout, "downBox", 500, 66, 614, 80, false)
	GUI:setAnchorPoint(downBox, 0.50, 0.50)
	GUI:setTouchEnabled(downBox, false)
	GUI:setTag(downBox, 0)

	-- Create dwonText1
	local dwonText1 = GUI:Text_Create(downBox, "dwonText1", 11, 53, 16, "#f0b42a", [==========[[转移说明]：]==========])
	GUI:Text_enableOutline(dwonText1, "#000000", 1)
	GUI:setAnchorPoint(dwonText1, 0.00, 0.00)
	GUI:setTouchEnabled(dwonText1, false)
	GUI:setTag(dwonText1, 0)

	-- Create dwonText2
	local dwonText2 = GUI:Text_Create(downBox, "dwonText2", 11, 9, 16, "#00ff00", [[转移幸运项链仅支持非绑定灵符，无法使用绑定灵符
转移幸运项链成功将幸运及元素属性覆盖至身上项链]])
	GUI:Text_enableOutline(dwonText2, "#000000", 1)
	GUI:setAnchorPoint(dwonText2, 0.00, 0.00)
	GUI:setTouchEnabled(dwonText2, false)
	GUI:setTag(dwonText2, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(downBox, "upBtn", 474, 40, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[强化幸运]])
	GUI:Button_setTitleColor(upBtn, "#F8E6C6")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
