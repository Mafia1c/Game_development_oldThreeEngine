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
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/010clhc/bg.png")
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
	local Node_1 = GUI:Node_Create(theItemBox, "Node_1", 245, 280)
	GUI:setTag(Node_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Node_1, "ItemShow_1", 0, 0, {index = 1, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Node_2
	local Node_2 = GUI:Node_Create(theItemBox, "Node_2", 118, 168)
	GUI:setTag(Node_2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(Node_2, "ItemShow_2", 0, 0, {index = 1, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create Node_3
	local Node_3 = GUI:Node_Create(theItemBox, "Node_3", 372, 168)
	GUI:setTag(Node_3, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(Node_3, "ItemShow_3", 0, 0, {index = 1, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create oddText1
	local oddText1 = GUI:Text_Create(midBox, "oddText1", 222, 120, 16, "#ffffff", [[成功率：]])
	GUI:Text_enableOutline(oddText1, "#000000", 1)
	GUI:setAnchorPoint(oddText1, 0.50, 0.50)
	GUI:setTouchEnabled(oddText1, false)
	GUI:setTag(oddText1, 0)

	-- Create oddText2
	local oddText2 = GUI:Text_Create(oddText1, "oddText2", 62, 12, 16, "#00ff00", [[100%]])
	GUI:Text_enableOutline(oddText2, "#000000", 1)
	GUI:setAnchorPoint(oddText2, 0.00, 0.50)
	GUI:setTouchEnabled(oddText2, false)
	GUI:setTag(oddText2, 0)

	-- Create itemText1
	local itemText1 = GUI:Text_Create(midBox, "itemText1", 214, 94, 16, "#ffffff", [[合成材料：]])
	GUI:Text_enableOutline(itemText1, "#000000", 1)
	GUI:setAnchorPoint(itemText1, 0.50, 0.50)
	GUI:setTouchEnabled(itemText1, false)
	GUI:setTag(itemText1, 0)

	-- Create itemText2
	local itemText2 = GUI:Text_Create(itemText1, "itemText2", 76, 11, 16, "#ff0000", [[诅咒宝石]])
	GUI:Text_enableOutline(itemText2, "#000000", 1)
	GUI:setAnchorPoint(itemText2, 0.00, 0.50)
	GUI:setTouchEnabled(itemText2, false)
	GUI:setTag(itemText2, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midBox, "upBtn", 240, 34, "res/custom/bt_dz.png")
	GUI:Button_setTitleText(upBtn, [[材料合成]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
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
