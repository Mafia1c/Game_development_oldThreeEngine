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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/16jj/2/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 820, 481, "res/public/1900000510.png")
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

	-- Create btnList_1
	local btnList_1 = GUI:ListView_Create(FrameLayout, "btnList_1", 76, 41, 114, 440, 1)
	GUI:setAnchorPoint(btnList_1, 0.00, 0.00)
	GUI:setTouchEnabled(btnList_1, true)
	GUI:setTag(btnList_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(btnList_1, "Button_1", 0, 398, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_1, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[神兵互换]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Button_1, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(btnList_1, "Button_2", 0, 356, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_2, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[剑甲附魔]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_2, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(btnList_1, "Button_3", 0, 314, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_3, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[附魔转移]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_3, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create btnList_2
	local btnList_2 = GUI:ListView_Create(FrameLayout, "btnList_2", 198, 40, 114, 399, 1)
	GUI:setAnchorPoint(btnList_2, 0.00, 0.00)
	GUI:setTouchEnabled(btnList_2, true)
	GUI:setTag(btnList_2, 0)

	-- Create colTopBtn
	local colTopBtn = GUI:Button_Create(FrameLayout, "colTopBtn", 198, 439, "res/custom/dayeqian2.png")
	GUI:setContentSize(colTopBtn, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(colTopBtn, false)
	GUI:Button_setTitleText(colTopBtn, [[神兵互换]])
	GUI:Button_setTitleColor(colTopBtn, "#ffffff")
	GUI:Button_setTitleFontSize(colTopBtn, 18)
	GUI:Button_titleEnableOutline(colTopBtn, "#000000", 1)
	GUI:setAnchorPoint(colTopBtn, 0.00, 0.00)
	GUI:setTouchEnabled(colTopBtn, true)
	GUI:setTag(colTopBtn, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(colTopBtn, "Image_1", -6, 6, "res/public/jiantouxia.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 335, 57, 18, "#ffff00", [[战神系列互换消耗:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create needItem_1
	local needItem_1 = GUI:ItemShow_Create(FrameLayout, "needItem_1", 524, 67, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_1, 0.50, 0.50)
	GUI:setTag(needItem_1, 0)

	-- Create needItem_2
	local needItem_2 = GUI:ItemShow_Create(FrameLayout, "needItem_2", 593, 67, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_2, 0.50, 0.50)
	GUI:setTag(needItem_2, 0)
	GUI:setVisible(needItem_2, false)

	-- Create page_1
	local page_1 = GUI:Node_Create(FrameLayout, "page_1", 52, 21)
	GUI:setTag(page_1, 0)
	GUI:setVisible(page_1, false)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(page_1, "ListView_1", 269, 97, 479, 361, 1)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(page_1, "Text_2", 516, 27, 18, "#ffffff", [[提醒:   神兵附魔绑定装备
             互换后附魔属性消失]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create page_2
	local page_2 = GUI:Node_Create(FrameLayout, "page_2", 52, 21)
	GUI:setTag(page_2, 0)

	-- Create ruleBtn
	local ruleBtn = GUI:Button_Create(page_2, "ruleBtn", 672, 403, "res/custom/bt2.png")
	GUI:setContentSize(ruleBtn, 64, 51)
	GUI:setIgnoreContentAdaptWithSize(ruleBtn, false)
	GUI:Button_setTitleText(ruleBtn, [[]])
	GUI:Button_setTitleColor(ruleBtn, "#ffffff")
	GUI:Button_setTitleFontSize(ruleBtn, 16)
	GUI:Button_titleEnableOutline(ruleBtn, "#000000", 1)
	GUI:setAnchorPoint(ruleBtn, 0.00, 0.00)
	GUI:setTouchEnabled(ruleBtn, true)
	GUI:setTag(ruleBtn, 0)

	-- Create equipItem
	local equipItem = GUI:ItemShow_Create(page_2, "equipItem", 510, 317, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(equipItem, 0.50, 0.50)
	GUI:setTag(equipItem, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(page_2, "Image_2", 371, 119, "res/custom/npc/16jj/2/t1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create startFMBtn
	local startFMBtn = GUI:Button_Create(page_2, "startFMBtn", 616, 33, "res/custom/bt_dz.png")
	GUI:setContentSize(startFMBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(startFMBtn, false)
	GUI:Button_setTitleText(startFMBtn, [[开始附魔]])
	GUI:Button_setTitleColor(startFMBtn, "#ffffff")
	GUI:Button_setTitleFontSize(startFMBtn, 18)
	GUI:Button_titleEnableOutline(startFMBtn, "#000000", 1)
	GUI:setAnchorPoint(startFMBtn, 0.00, 0.00)
	GUI:setTouchEnabled(startFMBtn, true)
	GUI:setTag(startFMBtn, 0)

	-- Create page_3
	local page_3 = GUI:Node_Create(FrameLayout, "page_3", 52, 21)
	GUI:setTag(page_3, 0)
	GUI:setVisible(page_3, false)

	-- Create zhuanFMBtn
	local zhuanFMBtn = GUI:Button_Create(page_3, "zhuanFMBtn", 617, 25, "res/custom/bt_dz.png")
	GUI:setContentSize(zhuanFMBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(zhuanFMBtn, false)
	GUI:Button_setTitleText(zhuanFMBtn, [[转移附魔]])
	GUI:Button_setTitleColor(zhuanFMBtn, "#ffffff")
	GUI:Button_setTitleFontSize(zhuanFMBtn, 18)
	GUI:Button_titleEnableOutline(zhuanFMBtn, "#000000", 1)
	GUI:setAnchorPoint(zhuanFMBtn, 0.00, 0.00)
	GUI:setTouchEnabled(zhuanFMBtn, true)
	GUI:setTag(zhuanFMBtn, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(page_3, "Image_3", 271, 113, "res/custom/npc/16jj/2/t1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_btn_1
	local Image_btn_1 = GUI:Image_Create(page_3, "Image_btn_1", 595, 427, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_1, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_1, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_1, false)
	GUI:setAnchorPoint(Image_btn_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_1, true)
	GUI:setTag(Image_btn_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Image_btn_1, "ItemShow_1", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Image_btn_2
	local Image_btn_2 = GUI:Image_Create(page_3, "Image_btn_2", 656, 427, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_2, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_2, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_2, false)
	GUI:setAnchorPoint(Image_btn_2, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_2, true)
	GUI:setTag(Image_btn_2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(Image_btn_2, "ItemShow_2", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create Image_btn_3
	local Image_btn_3 = GUI:Image_Create(page_3, "Image_btn_3", 718, 427, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_3, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_3, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_3, false)
	GUI:setAnchorPoint(Image_btn_3, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_3, true)
	GUI:setTag(Image_btn_3, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(Image_btn_3, "ItemShow_3", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create Image_btn_4
	local Image_btn_4 = GUI:Image_Create(page_3, "Image_btn_4", 595, 367, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_4, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_4, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_4, false)
	GUI:setAnchorPoint(Image_btn_4, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_4, true)
	GUI:setTag(Image_btn_4, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(Image_btn_4, "ItemShow_4", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create Image_btn_5
	local Image_btn_5 = GUI:Image_Create(page_3, "Image_btn_5", 656, 367, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_5, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_5, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_5, false)
	GUI:setAnchorPoint(Image_btn_5, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_5, true)
	GUI:setTag(Image_btn_5, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(Image_btn_5, "ItemShow_5", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create Image_btn_6
	local Image_btn_6 = GUI:Image_Create(page_3, "Image_btn_6", 718, 367, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_6, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_6, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_6, false)
	GUI:setAnchorPoint(Image_btn_6, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_6, true)
	GUI:setTag(Image_btn_6, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(Image_btn_6, "ItemShow_6", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create Image_btn_7
	local Image_btn_7 = GUI:Image_Create(page_3, "Image_btn_7", 595, 307, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_7, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_7, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_7, false)
	GUI:setAnchorPoint(Image_btn_7, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_7, true)
	GUI:setTag(Image_btn_7, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(Image_btn_7, "ItemShow_7", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create Image_btn_8
	local Image_btn_8 = GUI:Image_Create(page_3, "Image_btn_8", 656, 307, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_8, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_8, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_8, false)
	GUI:setAnchorPoint(Image_btn_8, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_8, true)
	GUI:setTag(Image_btn_8, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(Image_btn_8, "ItemShow_8", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create Image_btn_9
	local Image_btn_9 = GUI:Image_Create(page_3, "Image_btn_9", 718, 307, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_9, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_9, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_9, false)
	GUI:setAnchorPoint(Image_btn_9, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_9, true)
	GUI:setTag(Image_btn_9, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(Image_btn_9, "ItemShow_9", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setTag(ItemShow_9, 0)

	-- Create Image_btn_10
	local Image_btn_10 = GUI:Image_Create(page_3, "Image_btn_10", 595, 247, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_10, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_10, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_10, false)
	GUI:setAnchorPoint(Image_btn_10, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_10, true)
	GUI:setTag(Image_btn_10, 0)

	-- Create ItemShow_10
	local ItemShow_10 = GUI:ItemShow_Create(Image_btn_10, "ItemShow_10", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_10, 0.50, 0.50)
	GUI:setTag(ItemShow_10, 0)

	-- Create Image_btn_11
	local Image_btn_11 = GUI:Image_Create(page_3, "Image_btn_11", 656, 247, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_11, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_11, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_11, false)
	GUI:setAnchorPoint(Image_btn_11, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_11, true)
	GUI:setTag(Image_btn_11, 0)

	-- Create ItemShow_11
	local ItemShow_11 = GUI:ItemShow_Create(Image_btn_11, "ItemShow_11", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_11, 0.50, 0.50)
	GUI:setTag(ItemShow_11, 0)

	-- Create Image_btn_12
	local Image_btn_12 = GUI:Image_Create(page_3, "Image_btn_12", 718, 247, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_12, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_12, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_12, false)
	GUI:setAnchorPoint(Image_btn_12, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_12, true)
	GUI:setTag(Image_btn_12, 0)

	-- Create ItemShow_12
	local ItemShow_12 = GUI:ItemShow_Create(Image_btn_12, "ItemShow_12", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_12, 0.50, 0.50)
	GUI:setTag(ItemShow_12, 0)

	-- Create Image_btn_13
	local Image_btn_13 = GUI:Image_Create(page_3, "Image_btn_13", 595, 187, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_13, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_13, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_13, false)
	GUI:setAnchorPoint(Image_btn_13, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_13, true)
	GUI:setTag(Image_btn_13, 0)

	-- Create ItemShow_13
	local ItemShow_13 = GUI:ItemShow_Create(Image_btn_13, "ItemShow_13", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_13, 0.50, 0.50)
	GUI:setTag(ItemShow_13, 0)

	-- Create Image_btn_14
	local Image_btn_14 = GUI:Image_Create(page_3, "Image_btn_14", 656, 187, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_14, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_14, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_14, false)
	GUI:setAnchorPoint(Image_btn_14, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_14, true)
	GUI:setTag(Image_btn_14, 0)

	-- Create ItemShow_14
	local ItemShow_14 = GUI:ItemShow_Create(Image_btn_14, "ItemShow_14", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_14, 0.50, 0.50)
	GUI:setTag(ItemShow_14, 0)

	-- Create Image_btn_15
	local Image_btn_15 = GUI:Image_Create(page_3, "Image_btn_15", 718, 187, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_15, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_15, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_15, false)
	GUI:setAnchorPoint(Image_btn_15, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_15, true)
	GUI:setTag(Image_btn_15, 0)

	-- Create ItemShow_15
	local ItemShow_15 = GUI:ItemShow_Create(Image_btn_15, "ItemShow_15", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_15, 0.50, 0.50)
	GUI:setTag(ItemShow_15, 0)

	-- Create Image_btn_16
	local Image_btn_16 = GUI:Image_Create(page_3, "Image_btn_16", 595, 127, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_16, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_16, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_16, false)
	GUI:setAnchorPoint(Image_btn_16, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_16, true)
	GUI:setTag(Image_btn_16, 0)

	-- Create ItemShow_16
	local ItemShow_16 = GUI:ItemShow_Create(Image_btn_16, "ItemShow_16", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_16, 0.50, 0.50)
	GUI:setTag(ItemShow_16, 0)

	-- Create Image_btn_17
	local Image_btn_17 = GUI:Image_Create(page_3, "Image_btn_17", 656, 127, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_17, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_17, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_17, false)
	GUI:setAnchorPoint(Image_btn_17, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_17, true)
	GUI:setTag(Image_btn_17, 0)

	-- Create ItemShow_17
	local ItemShow_17 = GUI:ItemShow_Create(Image_btn_17, "ItemShow_17", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_17, 0.50, 0.50)
	GUI:setTag(ItemShow_17, 0)

	-- Create Image_btn_18
	local Image_btn_18 = GUI:Image_Create(page_3, "Image_btn_18", 718, 127, "res/custom/k1.png")
	GUI:Image_setScale9Slice(Image_btn_18, 5, 5, 20, 20)
	GUI:setContentSize(Image_btn_18, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(Image_btn_18, false)
	GUI:setAnchorPoint(Image_btn_18, 0.50, 0.50)
	GUI:setTouchEnabled(Image_btn_18, true)
	GUI:setTag(Image_btn_18, 0)

	-- Create ItemShow_18
	local ItemShow_18 = GUI:ItemShow_Create(Image_btn_18, "ItemShow_18", 30, 30, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_18, 0.50, 0.50)
	GUI:setTag(ItemShow_18, 0)

	-- Create ItemShow_19
	local ItemShow_19 = GUI:ItemShow_Create(page_3, "ItemShow_19", 325, 355, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_19, 0.50, 0.50)
	GUI:setTag(ItemShow_19, 0)

	-- Create ItemShow_20
	local ItemShow_20 = GUI:ItemShow_Create(page_3, "ItemShow_20", 500, 356, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_20, 0.50, 0.50)
	GUI:setTag(ItemShow_20, 0)

	-- Create mask_layout
	local mask_layout = GUI:Layout_Create(FrameLayout, "mask_layout", 423, 283, 1136, 640, false)
	GUI:Layout_setBackGroundColorType(mask_layout, 1)
	GUI:Layout_setBackGroundColor(mask_layout, "#000000")
	GUI:Layout_setBackGroundColorOpacity(mask_layout, 81)
	GUI:setAnchorPoint(mask_layout, 0.50, 0.50)
	GUI:setTouchEnabled(mask_layout, true)
	GUI:setTag(mask_layout, 0)
	GUI:setVisible(mask_layout, false)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(mask_layout, "Image_4", 568, 320, "res/public/bg_npc_04.jpg")
	GUI:setContentSize(Image_4, 680, 305)
	GUI:setIgnoreContentAdaptWithSize(Image_4, false)
	GUI:setAnchorPoint(Image_4, 0.50, 0.50)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(mask_layout, "ListView_2", 243, 181, 650, 280, 1)
	GUI:ListView_setItemsMargin(ListView_2, 10)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(ListView_2, "Text_3", 0, 253, 18, "#00ff00", [[神兵附魔规则:]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(ListView_2, "Text_4", 0, 216, 18, "#ffff00", [[神兵附魔1次, 获得属性, 攻魔道伤2%]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(ListView_2, "Text_5", 0, 179, 18, "#ffff00", [[神兵附魔2次, 获得属性, 攻魔道伤4%]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(ListView_2, "Text_6", 0, 142, 18, "#ffff00", [[神兵附魔3次, 获得属性, 攻魔道伤4%]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(ListView_2, "Text_7", 0, 105, 18, "#ffff00", [[神兵附魔4次, 获得属性, 攻魔道伤8%]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.00, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)

	-- Create Text_8
	local Text_8 = GUI:Text_Create(ListView_2, "Text_8", 0, 68, 18, "#ffff00", [[神兵附魔5次, 获得属性, 攻魔道伤10%]])
	GUI:Text_enableOutline(Text_8, "#000000", 1)
	GUI:setAnchorPoint(Text_8, 0.00, 0.00)
	GUI:setTouchEnabled(Text_8, false)
	GUI:setTag(Text_8, 0)

	-- Create Text_9
	local Text_9 = GUI:Text_Create(ListView_2, "Text_9", 0, 31, 18, "#ffff00", [[神兵附魔6次, 获得属性, 攻魔道伤12%]])
	GUI:Text_enableOutline(Text_9, "#000000", 1)
	GUI:setAnchorPoint(Text_9, 0.00, 0.00)
	GUI:setTouchEnabled(Text_9, false)
	GUI:setTag(Text_9, 0)

	-- Create Text_10
	local Text_10 = GUI:Text_Create(ListView_2, "Text_10", 0, -6, 18, "#9b00ff", [[神兵附魔7次, 获得属性, 攻魔道伤15%, 攻击速度:  1-10点]])
	GUI:Text_enableOutline(Text_10, "#000000", 1)
	GUI:setAnchorPoint(Text_10, 0.00, 0.00)
	GUI:setTouchEnabled(Text_10, false)
	GUI:setTag(Text_10, 0)

	-- Create Text_11
	local Text_11 = GUI:Text_Create(ListView_2, "Text_11", 0, -43, 18, "#00ff00", [[神兵附魔7次, 获得一次攻速加成, 之后可选择重新洗练攻击速度]])
	GUI:Text_enableOutline(Text_11, "#000000", 1)
	GUI:setAnchorPoint(Text_11, 0.00, 0.00)
	GUI:setTouchEnabled(Text_11, false)
	GUI:setTag(Text_11, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
