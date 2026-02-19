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

	-- Create FrameBG1
	local FrameBG1 = GUI:Image_Create(parent, "FrameBG1", 0, 0, "res/custom/npc/37boss/001Boss.png")
	GUI:Image_setScale9Slice(FrameBG1, 113, 113, 213, 213)
	GUI:setContentSize(FrameBG1, 1136, 640)
	GUI:setIgnoreContentAdaptWithSize(FrameBG1, false)
	GUI:setAnchorPoint(FrameBG1, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG1, false)
	GUI:setTag(FrameBG1, -1)
	GUI:setVisible(FrameBG1, false)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 553, 334, 846, 566, false)
	GUI:Layout_setBackGroundImage(FrameLayout, "res/custom/npc/37boss/mb.png")
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/02sx/bg1.png")
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

	-- Create leftList1
	local leftList1 = GUI:ListView_Create(FrameLayout, "leftList1", 76, 476, 114, 440, 1)
	GUI:ListView_setItemsMargin(leftList1, 2)
	GUI:setAnchorPoint(leftList1, 0.00, 1.00)
	GUI:setTouchEnabled(leftList1, true)
	GUI:setTag(leftList1, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(leftList1, "Image_4", 0, 398, "res/custom/dayeqian2.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create leftList2
	local leftList2 = GUI:Layout_Create(FrameLayout, "leftList2", 193, 476, 119, 440, false)
	GUI:setAnchorPoint(leftList2, 0.00, 1.00)
	GUI:setTouchEnabled(leftList2, false)
	GUI:setTag(leftList2, 0)

	-- Create midBox
	local midBox = GUI:Layout_Create(FrameLayout, "midBox", 564, 260, 500, 450, false)
	GUI:setAnchorPoint(midBox, 0.50, 0.50)
	GUI:setTouchEnabled(midBox, false)
	GUI:setTag(midBox, 0)

	-- Create theItemBox
	local theItemBox = GUI:Layout_Create(midBox, "theItemBox", 0, 0, 500, 450, false)
	GUI:setAnchorPoint(theItemBox, 0.00, 0.00)
	GUI:setTouchEnabled(theItemBox, false)
	GUI:setTag(theItemBox, 0)

	-- Create animalText3
	local animalText3 = GUI:Text_Create(theItemBox, "animalText3", 238, 134, 16, "#ffff00", [[当前合成次数：3]])
	GUI:Text_enableOutline(animalText3, "#000000", 1)
	GUI:setAnchorPoint(animalText3, 0.50, 0.50)
	GUI:setTouchEnabled(animalText3, false)
	GUI:setTag(animalText3, 0)

	-- Create animalText1
	local animalText1 = GUI:Text_Create(theItemBox, "animalText1", 252, 110, 16, "#00ff00", [[传承生肖合成时随机赋予1-10星，并随机附加1-10点属性]])
	GUI:Text_enableOutline(animalText1, "#000000", 1)
	GUI:setAnchorPoint(animalText1, 0.50, 0.50)
	GUI:setTouchEnabled(animalText1, false)
	GUI:setTag(animalText1, 0)

	-- Create animalText2
	local animalText2 = GUI:Text_Create(theItemBox, "animalText2", 252, 84, 16, "#ffff00", [[说明：每合成12次，必出1个10星]])
	GUI:Text_enableOutline(animalText2, "#000000", 1)
	GUI:setAnchorPoint(animalText2, 0.50, 0.50)
	GUI:setTouchEnabled(animalText2, false)
	GUI:setTag(animalText2, 0)

	-- Create suitBtn
	local suitBtn = GUI:Button_Create(theItemBox, "suitBtn", 444, 418, "Default/Button_Normal.png")
	GUI:setContentSize(suitBtn, 50, 30)
	GUI:setIgnoreContentAdaptWithSize(suitBtn, false)
	GUI:Button_setTitleText(suitBtn, [[套装]])
	GUI:Button_setTitleColor(suitBtn, "#ffffff")
	GUI:Button_setTitleFontSize(suitBtn, 16)
	GUI:Button_titleEnableOutline(suitBtn, "#000000", 1)
	GUI:setAnchorPoint(suitBtn, 0.50, 0.50)
	GUI:setTouchEnabled(suitBtn, true)
	GUI:setTag(suitBtn, 0)

	-- Create Node_1
	local Node_1 = GUI:Node_Create(theItemBox, "Node_1", 386, 193)
	GUI:setTag(Node_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Node_1, "ItemShow_1", 0, 0, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midBox, "upBtn", 244, 34, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[合成生肖]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 16)
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
