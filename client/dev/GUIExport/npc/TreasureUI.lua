local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create LayoutBg
	local LayoutBg = GUI:Image_Create(FrameLayout, "LayoutBg", 1, 0, "res/custom/npc/07zsmb/bg1.png")
	GUI:setAnchorPoint(LayoutBg, 0.00, 0.00)
	GUI:setTouchEnabled(LayoutBg, true)
	GUI:setMouseEnabled(LayoutBg, true)
	GUI:setTag(LayoutBg, 0)

	-- Create tuJianBox
	local tuJianBox = GUI:Layout_Create(LayoutBg, "tuJianBox", 57, 30, 741, 454, false)
	GUI:setAnchorPoint(tuJianBox, 0.00, 0.00)
	GUI:setTouchEnabled(tuJianBox, false)
	GUI:setTag(tuJianBox, 0)

	-- Create item_list
	local item_list = GUI:ScrollView_Create(tuJianBox, "item_list", 141, 89, 594, 358, 1)
	GUI:ScrollView_setInnerContainerSize(item_list, 594.00, 358.00)
	GUI:setAnchorPoint(item_list, 0.00, 0.00)
	GUI:setTouchEnabled(item_list, true)
	GUI:setTag(item_list, 0)

	-- Create downBox
	local downBox = GUI:Layout_Create(tuJianBox, "downBox", 132, 4, 608, 73, false)
	GUI:setAnchorPoint(downBox, 0.00, 0.00)
	GUI:setTouchEnabled(downBox, false)
	GUI:setTag(downBox, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(downBox, "Button_1", 469, 17, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_1, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[秘宝图鉴]])
	GUI:Button_setTitleColor(Button_1, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create heChengBox
	local heChengBox = GUI:Layout_Create(LayoutBg, "heChengBox", 2, 2, 765, 514, false)
	GUI:setAnchorPoint(heChengBox, 0.00, 0.00)
	GUI:setTouchEnabled(heChengBox, false)
	GUI:setTag(heChengBox, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(heChengBox, "Image_5", -2, -2, "res/custom/npc/07zsmb/bg3.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, true)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(Image_5, "Image_6", 206, 111, "res/custom/npc/07zsmb/t2.png")
	GUI:Image_setScale9Slice(Image_6, 33, 33, 21, 21)
	GUI:setContentSize(Image_6, 334, 138)
	GUI:setIgnoreContentAdaptWithSize(Image_6, false)
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create jueXingbutton
	local jueXingbutton = GUI:Button_Create(heChengBox, "jueXingbutton", 427, 46, "res/public/1900000612.png")
	GUI:setContentSize(jueXingbutton, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(jueXingbutton, false)
	GUI:Button_setTitleText(jueXingbutton, [[觉醒秘宝]])
	GUI:Button_setTitleColor(jueXingbutton, "#ffffa7")
	GUI:Button_setTitleFontSize(jueXingbutton, 16)
	GUI:Button_titleEnableOutline(jueXingbutton, "#000000", 1)
	GUI:setAnchorPoint(jueXingbutton, 0.00, 0.00)
	GUI:setTouchEnabled(jueXingbutton, true)
	GUI:setTag(jueXingbutton, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(heChengBox, "Text_1", 213, 114, 16, "#00ff00", [[说明:觉醒成功主孤品/绝品可继承副孤品属性]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create heChengListView
	local heChengListView = GUI:ScrollView_Create(heChengBox, "heChengListView", 550, 107, 247, 372, 1)
	GUI:ScrollView_setInnerContainerSize(heChengListView, 247.00, 372.00)
	GUI:setAnchorPoint(heChengListView, 0.00, 0.00)
	GUI:setTouchEnabled(heChengListView, true)
	GUI:setTag(heChengListView, 0)

	-- Create hcExpendItem
	local hcExpendItem = GUI:ItemShow_Create(heChengBox, "hcExpendItem", 479, 412, {index = 0, count = 0, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(hcExpendItem, 0.50, 0.50)
	GUI:setOpacity(hcExpendItem, 224)
	GUI:setTag(hcExpendItem, 0)

	-- Create jiChengAttrText
	local jiChengAttrText = GUI:Text_Create(heChengBox, "jiChengAttrText", 245, 148, 16, "#00ffe8", [[]])
	GUI:setIgnoreContentAdaptWithSize(jiChengAttrText, false)
	GUI:Text_setTextAreaSize(jiChengAttrText, 272, 24)
	GUI:Text_setTextHorizontalAlignment(jiChengAttrText, 1)
	GUI:Text_enableOutline(jiChengAttrText, "#000000", 1)
	GUI:setAnchorPoint(jiChengAttrText, 0.00, 0.00)
	GUI:setTouchEnabled(jiChengAttrText, false)
	GUI:setTag(jiChengAttrText, 0)

	-- Create selectNameText
	local selectNameText = GUI:Text_Create(heChengBox, "selectNameText", 245, 207, 16, "#ff0000", [[副孤品：风水秘术]])
	GUI:setIgnoreContentAdaptWithSize(selectNameText, false)
	GUI:Text_setTextAreaSize(selectNameText, 235, 24)
	GUI:Text_setTextHorizontalAlignment(selectNameText, 1)
	GUI:Text_enableOutline(selectNameText, "#000000", 1)
	GUI:setAnchorPoint(selectNameText, 0.00, 0.00)
	GUI:setTouchEnabled(selectNameText, false)
	GUI:setTag(selectNameText, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(heChengBox, "Text_4", 234, 177, 16, "#ffffff", [[觉醒成功率：]])
	GUI:setIgnoreContentAdaptWithSize(Text_4, false)
	GUI:Text_setTextAreaSize(Text_4, 235, 24)
	GUI:Text_setTextHorizontalAlignment(Text_4, 1)
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create compoundBox
	local compoundBox = GUI:Layout_Create(heChengBox, "compoundBox", 202, 262, 345, 216, false)
	GUI:setAnchorPoint(compoundBox, 0.00, 0.00)
	GUI:setTouchEnabled(compoundBox, false)
	GUI:setTag(compoundBox, 0)

	-- Create EquipShow_1
	local EquipShow_1 = GUI:EquipShow_Create(compoundBox, "EquipShow_1", 58, 151, 0, false, {bgVisible = true, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = false, showModelEffect = false})
	GUI:setAnchorPoint(EquipShow_1, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_1, false)
	GUI:setTag(EquipShow_1, 0)

	-- Create materialItem
	local materialItem = GUI:ItemShow_Create(heChengBox, "materialItem", 370, 314, {index = 0, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(materialItem, 0.50, 0.50)
	GUI:setTag(materialItem, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(heChengBox, "Text_5", 394, 178, 16, "#ffff00", [[20%]])
	GUI:setIgnoreContentAdaptWithSize(Text_5, false)
	GUI:Text_setTextAreaSize(Text_5, 35, 24)
	GUI:Text_setTextHorizontalAlignment(Text_5, 1)
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create ScrollView_1
	local ScrollView_1 = GUI:ScrollView_Create(FrameLayout, "ScrollView_1", 76, 44, 117, 436, 1)
	GUI:ScrollView_setInnerContainerSize(ScrollView_1, 117.00, 436.00)
	GUI:setAnchorPoint(ScrollView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ScrollView_1, true)
	GUI:setTag(ScrollView_1, 0)

	-- Create Button_1
	Button_1 = GUI:Button_Create(ScrollView_1, "Button_1", 2, 393, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_1, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[秘宝图鉴]])
	GUI:Button_setTitleColor(Button_1, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Button_1, "Image_1", -5, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(ScrollView_1, "Button_2", 2, 352, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_2, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[秘宝回收]])
	GUI:Button_setTitleColor(Button_2, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Button_2, "Image_2", -5, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(ScrollView_1, "Button_3", 2, 310, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_3, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[秘宝兑换]])
	GUI:Button_setTitleColor(Button_3, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(Button_3, "Image_3", -5, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(ScrollView_1, "Button_4", 2, 268, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_4, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[秘宝觉醒]])
	GUI:Button_setTitleColor(Button_4, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(Button_4, "Image_4", -5, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 820, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
