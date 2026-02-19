local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 174, 51, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/14xq/bg.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 819, 481, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/1900000511.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create gemstone_list
	local gemstone_list = GUI:ScrollView_Create(FrameLayout, "gemstone_list", 556, 181, 243, 302, 1)
	GUI:ScrollView_setInnerContainerSize(gemstone_list, 243.00, 302.00)
	GUI:setAnchorPoint(gemstone_list, 0.00, 0.00)
	GUI:setTouchEnabled(gemstone_list, true)
	GUI:setTag(gemstone_list, 0)

	-- Create bag_item_1
	local bag_item_1 = GUI:ItemShow_Create(gemstone_list, "bag_item_1", 32, 270, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_1, 0.50, 0.50)
	GUI:setTag(bag_item_1, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(bag_item_1, "Panel_1", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 0)

	-- Create bag_item_2
	local bag_item_2 = GUI:ItemShow_Create(gemstone_list, "bag_item_2", 92, 270, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_2, 0.50, 0.50)
	GUI:setTag(bag_item_2, 0)

	-- Create Panel_2
	local Panel_2 = GUI:Layout_Create(bag_item_2, "Panel_2", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_2, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_2, true)
	GUI:setTag(Panel_2, 0)

	-- Create bag_item_3
	local bag_item_3 = GUI:ItemShow_Create(gemstone_list, "bag_item_3", 152, 270, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_3, 0.50, 0.50)
	GUI:setTag(bag_item_3, 0)

	-- Create Panel_3
	local Panel_3 = GUI:Layout_Create(bag_item_3, "Panel_3", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_3, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_3, true)
	GUI:setTag(Panel_3, 0)

	-- Create bag_item_4
	local bag_item_4 = GUI:ItemShow_Create(gemstone_list, "bag_item_4", 212, 270, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_4, 0.50, 0.50)
	GUI:setTag(bag_item_4, 0)

	-- Create Panel_4
	local Panel_4 = GUI:Layout_Create(bag_item_4, "Panel_4", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_4, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_4, true)
	GUI:setTag(Panel_4, 0)

	-- Create bag_item_5
	local bag_item_5 = GUI:ItemShow_Create(gemstone_list, "bag_item_5", 32, 210, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_5, 0.50, 0.50)
	GUI:setTag(bag_item_5, 0)

	-- Create Panel_5
	local Panel_5 = GUI:Layout_Create(bag_item_5, "Panel_5", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_5, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_5, true)
	GUI:setTag(Panel_5, 0)

	-- Create bag_item_6
	local bag_item_6 = GUI:ItemShow_Create(gemstone_list, "bag_item_6", 92, 210, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_6, 0.50, 0.50)
	GUI:setTag(bag_item_6, 0)

	-- Create Panel_6
	local Panel_6 = GUI:Layout_Create(bag_item_6, "Panel_6", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_6, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_6, true)
	GUI:setTag(Panel_6, 0)

	-- Create bag_item_7
	local bag_item_7 = GUI:ItemShow_Create(gemstone_list, "bag_item_7", 152, 210, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_7, 0.50, 0.50)
	GUI:setTag(bag_item_7, 0)

	-- Create Panel_7
	local Panel_7 = GUI:Layout_Create(bag_item_7, "Panel_7", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_7, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_7, true)
	GUI:setTag(Panel_7, 0)

	-- Create bag_item_8
	local bag_item_8 = GUI:ItemShow_Create(gemstone_list, "bag_item_8", 212, 210, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_8, 0.50, 0.50)
	GUI:setTag(bag_item_8, 0)

	-- Create Panel_8
	local Panel_8 = GUI:Layout_Create(bag_item_8, "Panel_8", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_8, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_8, true)
	GUI:setTag(Panel_8, 0)

	-- Create bag_item_9
	local bag_item_9 = GUI:ItemShow_Create(gemstone_list, "bag_item_9", 32, 150, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_9, 0.50, 0.50)
	GUI:setTag(bag_item_9, 0)

	-- Create Panel_9
	local Panel_9 = GUI:Layout_Create(bag_item_9, "Panel_9", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_9, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_9, true)
	GUI:setTag(Panel_9, 0)

	-- Create bag_item_10
	local bag_item_10 = GUI:ItemShow_Create(gemstone_list, "bag_item_10", 92, 150, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_10, 0.50, 0.50)
	GUI:setTag(bag_item_10, 0)

	-- Create Panel_10
	local Panel_10 = GUI:Layout_Create(bag_item_10, "Panel_10", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_10, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_10, true)
	GUI:setTag(Panel_10, 0)

	-- Create bag_item_11
	local bag_item_11 = GUI:ItemShow_Create(gemstone_list, "bag_item_11", 152, 150, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_11, 0.50, 0.50)
	GUI:setTag(bag_item_11, 0)

	-- Create Panel_11
	local Panel_11 = GUI:Layout_Create(bag_item_11, "Panel_11", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_11, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_11, true)
	GUI:setTag(Panel_11, 0)

	-- Create bag_item_12
	local bag_item_12 = GUI:ItemShow_Create(gemstone_list, "bag_item_12", 212, 150, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_12, 0.50, 0.50)
	GUI:setTag(bag_item_12, 0)

	-- Create Panel_12
	local Panel_12 = GUI:Layout_Create(bag_item_12, "Panel_12", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_12, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_12, true)
	GUI:setTag(Panel_12, 0)

	-- Create bag_item_13
	local bag_item_13 = GUI:ItemShow_Create(gemstone_list, "bag_item_13", 32, 90, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_13, 0.50, 0.50)
	GUI:setTag(bag_item_13, 0)

	-- Create Panel_13
	local Panel_13 = GUI:Layout_Create(bag_item_13, "Panel_13", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_13, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_13, true)
	GUI:setTag(Panel_13, 0)

	-- Create bag_item_14
	local bag_item_14 = GUI:ItemShow_Create(gemstone_list, "bag_item_14", 92, 90, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_14, 0.50, 0.50)
	GUI:setTag(bag_item_14, 0)

	-- Create Panel_14
	local Panel_14 = GUI:Layout_Create(bag_item_14, "Panel_14", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_14, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_14, true)
	GUI:setTag(Panel_14, 0)

	-- Create bag_item_15
	local bag_item_15 = GUI:ItemShow_Create(gemstone_list, "bag_item_15", 152, 90, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_15, 0.50, 0.50)
	GUI:setTag(bag_item_15, 0)

	-- Create Panel_15
	local Panel_15 = GUI:Layout_Create(bag_item_15, "Panel_15", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_15, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_15, true)
	GUI:setTag(Panel_15, 0)

	-- Create bag_item_16
	local bag_item_16 = GUI:ItemShow_Create(gemstone_list, "bag_item_16", 212, 90, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_16, 0.50, 0.50)
	GUI:setTag(bag_item_16, 0)

	-- Create Panel_16
	local Panel_16 = GUI:Layout_Create(bag_item_16, "Panel_16", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_16, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_16, true)
	GUI:setTag(Panel_16, 0)

	-- Create bag_item_17
	local bag_item_17 = GUI:ItemShow_Create(gemstone_list, "bag_item_17", 32, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_17, 0.50, 0.50)
	GUI:setTag(bag_item_17, 0)

	-- Create Panel_17
	local Panel_17 = GUI:Layout_Create(bag_item_17, "Panel_17", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_17, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_17, true)
	GUI:setTag(Panel_17, 0)

	-- Create bag_item_18
	local bag_item_18 = GUI:ItemShow_Create(gemstone_list, "bag_item_18", 92, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_18, 0.50, 0.50)
	GUI:setTag(bag_item_18, 0)

	-- Create Panel_18
	local Panel_18 = GUI:Layout_Create(bag_item_18, "Panel_18", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_18, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_18, true)
	GUI:setTag(Panel_18, 0)

	-- Create bag_item_19
	local bag_item_19 = GUI:ItemShow_Create(gemstone_list, "bag_item_19", 152, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_19, 0.50, 0.50)
	GUI:setTag(bag_item_19, 0)

	-- Create Panel_19
	local Panel_19 = GUI:Layout_Create(bag_item_19, "Panel_19", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_19, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_19, true)
	GUI:setTag(Panel_19, 0)

	-- Create bag_item_20
	local bag_item_20 = GUI:ItemShow_Create(gemstone_list, "bag_item_20", 212, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(bag_item_20, 0.50, 0.50)
	GUI:setTag(bag_item_20, 0)

	-- Create Panel_20
	local Panel_20 = GUI:Layout_Create(bag_item_20, "Panel_20", 0, 0, 60, 60, false)
	GUI:setAnchorPoint(Panel_20, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_20, true)
	GUI:setTag(Panel_20, 0)

	-- Create equipNode
	local equipNode = GUI:Node_Create(FrameLayout, "equipNode", 304, 100)
	GUI:setTag(equipNode, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(equipNode, "ItemShow_1", -150, 42, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create touch_item_1
	local touch_item_1 = GUI:Layout_Create(ItemShow_1, "touch_item_1", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_1, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_1, true)
	GUI:setTag(touch_item_1, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(equipNode, "ItemShow_4", -69, 42, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create touch_item_4
	local touch_item_4 = GUI:Layout_Create(ItemShow_4, "touch_item_4", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_4, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_4, true)
	GUI:setTag(touch_item_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(equipNode, "ItemShow_5", 6, 42, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create touch_item_5
	local touch_item_5 = GUI:Layout_Create(ItemShow_5, "touch_item_5", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_5, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_5, true)
	GUI:setTag(touch_item_5, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(equipNode, "ItemShow_7", 84, 42, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create touch_item_7
	local touch_item_7 = GUI:Layout_Create(ItemShow_7, "touch_item_7", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_7, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_7, true)
	GUI:setTag(touch_item_7, 0)

	-- Create ItemShow_10
	local ItemShow_10 = GUI:ItemShow_Create(equipNode, "ItemShow_10", 167, 42, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_10, 0.50, 0.50)
	GUI:setTag(ItemShow_10, 0)

	-- Create touch_item_10
	local touch_item_10 = GUI:Layout_Create(ItemShow_10, "touch_item_10", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_10, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_10, true)
	GUI:setTag(touch_item_10, 0)

	-- Create ItemShow_0
	local ItemShow_0 = GUI:ItemShow_Create(equipNode, "ItemShow_0", -150, -23, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_0, 0.50, 0.50)
	GUI:setTag(ItemShow_0, 0)

	-- Create touch_item_0
	local touch_item_0 = GUI:Layout_Create(ItemShow_0, "touch_item_0", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_0, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_0, true)
	GUI:setTag(touch_item_0, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(equipNode, "ItemShow_3", -69, -23, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create touch_item_3
	local touch_item_3 = GUI:Layout_Create(ItemShow_3, "touch_item_3", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_3, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_3, true)
	GUI:setTag(touch_item_3, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(equipNode, "ItemShow_6", 6, -23, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create touch_item_6
	local touch_item_6 = GUI:Layout_Create(ItemShow_6, "touch_item_6", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_6, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_6, true)
	GUI:setTag(touch_item_6, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(equipNode, "ItemShow_8", 84, -23, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create touch_item_8
	local touch_item_8 = GUI:Layout_Create(ItemShow_8, "touch_item_8", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_8, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_8, true)
	GUI:setTag(touch_item_8, 0)

	-- Create ItemShow_11
	local ItemShow_11 = GUI:ItemShow_Create(equipNode, "ItemShow_11", 167, -23, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_11, 0.50, 0.50)
	GUI:setTag(ItemShow_11, 0)

	-- Create touch_item_11
	local touch_item_11 = GUI:Layout_Create(ItemShow_11, "touch_item_11", 30, 30, 60, 60, false)
	GUI:setAnchorPoint(touch_item_11, 0.50, 0.50)
	GUI:setTouchEnabled(touch_item_11, true)
	GUI:setTag(touch_item_11, 0)

	-- Create select_equip_img
	local select_equip_img = GUI:Image_Create(equipNode, "select_equip_img", -149, 44, "res/public/1900000678_1.png")
	GUI:Image_setScale9Slice(select_equip_img, 8, 8, 28, 28)
	GUI:setContentSize(select_equip_img, 66, 66)
	GUI:setIgnoreContentAdaptWithSize(select_equip_img, false)
	GUI:setAnchorPoint(select_equip_img, 0.50, 0.50)
	GUI:setTouchEnabled(select_equip_img, false)
	GUI:setTag(select_equip_img, 0)

	-- Create btnNode
	local btnNode = GUI:Node_Create(FrameLayout, "btnNode", 310, 216)
	GUI:setTag(btnNode, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(btnNode, "Button_1", -223, -30, "res/custom/npc/14xq/bt.png")
	GUI:setContentSize(Button_1, 84, 39)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[按钮]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(btnNode, "Button_2", -134, -29, "res/custom/npc/14xq/bt.png")
	GUI:setContentSize(Button_2, 84, 39)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[按钮]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(btnNode, "Button_3", -40, -30, "res/custom/npc/14xq/bt.png")
	GUI:setContentSize(Button_3, 84, 39)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[按钮]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(btnNode, "Button_4", 55, -30, "res/custom/npc/14xq/bt.png")
	GUI:setContentSize(Button_4, 84, 39)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[按钮]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(btnNode, "Button_5", 149, -30, "res/custom/npc/14xq/bt.png")
	GUI:setContentSize(Button_5, 84, 39)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[按钮]])
	GUI:Button_setTitleColor(Button_5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_5, 16)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create gemstoneNode
	local gemstoneNode = GUI:Node_Create(FrameLayout, "gemstoneNode", 318, 251)
	GUI:setTag(gemstoneNode, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(gemstoneNode, "Image_1", -226, -30, "res/custom/npc/14xq/k1.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create baoshi_1
	local baoshi_1 = GUI:ItemShow_Create(Image_1, "baoshi_1", 36, 37, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(baoshi_1, 0.50, 0.50)
	GUI:setTag(baoshi_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(gemstoneNode, "Image_2", -137, -30, "res/custom/npc/14xq/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create baoshi_2
	local baoshi_2 = GUI:ItemShow_Create(Image_2, "baoshi_2", 36, 37, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(baoshi_2, 0.50, 0.50)
	GUI:setTag(baoshi_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(gemstoneNode, "Image_3", -43, -30, "res/custom/npc/14xq/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create baoshi_3
	local baoshi_3 = GUI:ItemShow_Create(Image_3, "baoshi_3", 36, 37, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(baoshi_3, 0.50, 0.50)
	GUI:setTag(baoshi_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(gemstoneNode, "Image_4", 53, -30, "res/custom/npc/14xq/k1.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create baoshi_4
	local baoshi_4 = GUI:ItemShow_Create(Image_4, "baoshi_4", 36, 37, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(baoshi_4, 0.50, 0.50)
	GUI:setTag(baoshi_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(gemstoneNode, "Image_5", 145, -30, "res/custom/npc/14xq/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create baoshi_5
	local baoshi_5 = GUI:ItemShow_Create(Image_5, "baoshi_5", 36, 37, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(baoshi_5, 0.50, 0.50)
	GUI:setTag(baoshi_5, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(gemstoneNode, "Text_1", -205, 43, 16, "#ffffff", [[风灵]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(gemstoneNode, "Text_2", -116, 43, 16, "#ffffff", [[火灵]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(gemstoneNode, "Text_3", -23, 43, 16, "#ffffff", [[水灵]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(gemstoneNode, "Text_4", 73, 43, 16, "#ffffff", [[雷灵]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(gemstoneNode, "Text_5", 160, 43, 16, "#ffffff", [[诅咒]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create ruleNode
	local ruleNode = GUI:Node_Create(FrameLayout, "ruleNode", 687, 111)
	GUI:setTag(ruleNode, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(ruleNode, "Text_6", -120, 36, 16, "#ffff00", [==========[[宝石镶嵌说明]:]==========])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(ruleNode, "Text_7", -120, -61, 16, "#00ff00", [[每件装备可开5个镶嵌孔位,打
孔费用为元宝x100万,每个孔位
只能镶嵌对应名称宝石,镶嵌
宝石与取下宝石均免费!]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.00, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)

	-- Create SelectEquip
	local SelectEquip = GUI:ItemShow_Create(FrameLayout, "SelectEquip", 309, 375, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(SelectEquip, 0.50, 0.50)
	GUI:setTag(SelectEquip, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
