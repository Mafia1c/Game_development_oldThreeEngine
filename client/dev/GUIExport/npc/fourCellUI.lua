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
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/04ts/bg.png")
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
	local leftList2 = GUI:Layout_Create(FrameLayout, "leftList2", 198, 476, 114, 440, false)
	GUI:setAnchorPoint(leftList2, 0.00, 1.00)
	GUI:setTouchEnabled(leftList2, false)
	GUI:setTag(leftList2, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(leftList2, "Image_1", 0, 404, "res/custom/yeqian1.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Image_1, "Text_1", 58, 18, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Image_1, "Image_2", 14, 48, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_2, 0.50, 0.50)
	GUI:setRotation(Image_2, 90.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

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

	-- Create Node_1
	local Node_1 = GUI:Node_Create(theItemBox, "Node_1", 386, 193)
	GUI:setTag(Node_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Node_1, "ItemShow_1", 0, 0, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(Node_1, "Image_3", -30, -30, "res/custom/lock.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create upBtn1
	local upBtn1 = GUI:Button_Create(midBox, "upBtn1", 184, 34, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn1, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn1, false)
	GUI:Button_setTitleText(upBtn1, [[背包合成]])
	GUI:Button_setTitleColor(upBtn1, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn1, 18)
	GUI:Button_titleEnableOutline(upBtn1, "#000000", 1)
	GUI:setAnchorPoint(upBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn1, true)
	GUI:setTag(upBtn1, 0)

	-- Create upBtn2
	local upBtn2 = GUI:Button_Create(midBox, "upBtn2", 338, 34, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn2, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn2, false)
	GUI:Button_setTitleText(upBtn2, [[身上合成]])
	GUI:Button_setTitleColor(upBtn2, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn2, 18)
	GUI:Button_titleEnableOutline(upBtn2, "#000000", 1)
	GUI:setAnchorPoint(upBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn2, true)
	GUI:setTag(upBtn2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
