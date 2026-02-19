local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 770, 516, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create LayoutBg
	local LayoutBg = GUI:Image_Create(FrameLayout, "LayoutBg", -30, -12, "res/custom/npc/51lzqh/bg.png")
	GUI:setAnchorPoint(LayoutBg, 0.00, 0.00)
	GUI:setTouchEnabled(LayoutBg, true)
	GUI:setMouseEnabled(LayoutBg, true)
	GUI:setTag(LayoutBg, 0)

	-- Create strengthenLevelText
	local strengthenLevelText = GUI:Text_Create(LayoutBg, "strengthenLevelText", 278, 423, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(strengthenLevelText, "#000000", 1)
	GUI:setAnchorPoint(strengthenLevelText, 0.00, 0.00)
	GUI:setTouchEnabled(strengthenLevelText, false)
	GUI:setTag(strengthenLevelText, 0)

	-- Create strengthenBtn
	local strengthenBtn = GUI:Button_Create(LayoutBg, "strengthenBtn", 563, 109, "res/custom/dayeqian1.png")
	GUI:setContentSize(strengthenBtn, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(strengthenBtn, false)
	GUI:Button_setTitleText(strengthenBtn, [[开始强化]])
	GUI:Button_setTitleColor(strengthenBtn, "#f8e6c6")
	GUI:Button_setTitleFontSize(strengthenBtn, 16)
	GUI:Button_titleEnableOutline(strengthenBtn, "#000000", 1)
	GUI:setAnchorPoint(strengthenBtn, 0.00, 0.00)
	GUI:setTouchEnabled(strengthenBtn, true)
	GUI:setTag(strengthenBtn, 0)

	-- Create equipNameText
	local equipNameText = GUI:Text_Create(LayoutBg, "equipNameText", 463, 364, 16, "#ffff00", [[圣龙盔圣龙盔]])
	GUI:setIgnoreContentAdaptWithSize(equipNameText, false)
	GUI:Text_setTextAreaSize(equipNameText, 300, 24)
	GUI:Text_setTextHorizontalAlignment(equipNameText, 1)
	GUI:Text_enableOutline(equipNameText, "#000000", 1)
	GUI:setAnchorPoint(equipNameText, 0.00, 0.00)
	GUI:setTouchEnabled(equipNameText, false)
	GUI:setTag(equipNameText, 0)

	-- Create suitAttrBtn_1
	local suitAttrBtn_1 = GUI:Button_Create(LayoutBg, "suitAttrBtn_1", 729, 413, "res/custom/npc/37qh/tips.png")
	GUI:setContentSize(suitAttrBtn_1, 66, 50)
	GUI:setIgnoreContentAdaptWithSize(suitAttrBtn_1, false)
	GUI:Button_setTitleText(suitAttrBtn_1, [[]])
	GUI:Button_setTitleColor(suitAttrBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(suitAttrBtn_1, 16)
	GUI:Button_titleEnableOutline(suitAttrBtn_1, "#000000", 1)
	GUI:setAnchorPoint(suitAttrBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(suitAttrBtn_1, true)
	GUI:setTag(suitAttrBtn_1, 0)

	-- Create CheckBox
	local CheckBox = GUI:CheckBox_Create(LayoutBg, "CheckBox", 469, 81, "res/custom/npc/37qh/gx_0.png", "res/custom/npc/37qh/gx_1.png")
	GUI:setContentSize(CheckBox, 24, 24)
	GUI:setIgnoreContentAdaptWithSize(CheckBox, false)
	GUI:CheckBox_setSelected(CheckBox, false)
	GUI:setAnchorPoint(CheckBox, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox, true)
	GUI:setTag(CheckBox, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(LayoutBg, "Text_2", 77, 40, 16, "#ffff00", [[提示：仅GP灵装可进行强化，强化属性只跟随装备，]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(Text_2, "Text_4", 372, -1, 16, "#00ff00", [[强化失败时等级降低1级]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create oddsText_1
	local oddsText_1 = GUI:Text_Create(LayoutBg, "oddsText_1", 532, 226, 16, "#ffffff", [[本次强化成功率：]])
	GUI:Text_enableOutline(oddsText_1, "#000000", 1)
	GUI:setAnchorPoint(oddsText_1, 0.00, 0.00)
	GUI:setTouchEnabled(oddsText_1, false)
	GUI:setTag(oddsText_1, 0)

	-- Create oddsText
	local oddsText = GUI:Text_Create(LayoutBg, "oddsText", 656, 226, 16, "#00ff00", [[100%]])
	GUI:Text_enableOutline(oddsText, "#000000", 1)
	GUI:setAnchorPoint(oddsText, 0.00, 0.00)
	GUI:setTouchEnabled(oddsText, false)
	GUI:setTag(oddsText, 0)

	-- Create needBox
	local needBox = GUI:Layout_Create(LayoutBg, "needBox", 533, 162, 183, 64, false)
	GUI:setAnchorPoint(needBox, 0.00, 0.00)
	GUI:setTouchEnabled(needBox, false)
	GUI:setTag(needBox, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(LayoutBg, "closeBtn", 820, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create equipBox
	local equipBox = GUI:Layout_Create(LayoutBg, "equipBox", 75, 73, 347, 351, false)
	GUI:setAnchorPoint(equipBox, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox, false)
	GUI:setTag(equipBox, 0)

	-- Create equipPos20
	local equipPos20 = GUI:Node_Create(equipBox, "equipPos20", 42, 276)
	GUI:setTag(equipPos20, 0)

	-- Create equipPosBg20
	local equipPosBg20 = GUI:Image_Create(equipPos20, "equipPosBg20", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg20, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg20, true)
	GUI:setTag(equipPosBg20, 0)

	-- Create equipPos22
	local equipPos22 = GUI:Node_Create(equipBox, "equipPos22", 42, 206)
	GUI:setTag(equipPos22, 0)

	-- Create equipPosBg22
	local equipPosBg22 = GUI:Image_Create(equipPos22, "equipPosBg22", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg22, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg22, true)
	GUI:setTag(equipPosBg22, 0)

	-- Create equipPos23
	local equipPos23 = GUI:Node_Create(equipBox, "equipPos23", 42, 138)
	GUI:setTag(equipPos23, 0)

	-- Create equipPosBg23
	local equipPosBg23 = GUI:Image_Create(equipPos23, "equipPosBg23", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg23, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg23, true)
	GUI:setTag(equipPosBg23, 0)

	-- Create equipPos27
	local equipPos27 = GUI:Node_Create(equipBox, "equipPos27", 43, 72)
	GUI:setTag(equipPos27, 0)

	-- Create equipPosBg27
	local equipPosBg27 = GUI:Image_Create(equipPos27, "equipPosBg27", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg27, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg27, true)
	GUI:setTag(equipPosBg27, 0)

	-- Create equipPos26
	local equipPos26 = GUI:Node_Create(equipBox, "equipPos26", 305, 278)
	GUI:setTag(equipPos26, 0)

	-- Create equipPosBg26
	local equipPosBg26 = GUI:Image_Create(equipPos26, "equipPosBg26", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg26, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg26, true)
	GUI:setTag(equipPosBg26, 0)

	-- Create equipPos24
	local equipPos24 = GUI:Node_Create(equipBox, "equipPos24", 305, 208)
	GUI:setTag(equipPos24, 0)

	-- Create equipPosBg24
	local equipPosBg24 = GUI:Image_Create(equipPos24, "equipPosBg24", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg24, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg24, true)
	GUI:setTag(equipPosBg24, 0)

	-- Create equipPos25
	local equipPos25 = GUI:Node_Create(equipBox, "equipPos25", 305, 140)
	GUI:setTag(equipPos25, 0)

	-- Create equipPosBg25
	local equipPosBg25 = GUI:Image_Create(equipPos25, "equipPosBg25", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg25, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg25, true)
	GUI:setTag(equipPosBg25, 0)

	-- Create equipPos28
	local equipPos28 = GUI:Node_Create(equipBox, "equipPos28", 305, 74)
	GUI:setTag(equipPos28, 0)

	-- Create equipPosBg28
	local equipPosBg28 = GUI:Image_Create(equipPos28, "equipPosBg28", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg28, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg28, true)
	GUI:setTag(equipPosBg28, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(equipBox, "select_img", 42, 276, "res/public/1900000678_1.png")
	GUI:setContentSize(select_img, 65, 65)
	GUI:setIgnoreContentAdaptWithSize(select_img, false)
	GUI:setAnchorPoint(select_img, 0.50, 0.50)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)

	-- Create cur_attr_1
	local cur_attr_1 = GUI:Text_Create(LayoutBg, "cur_attr_1", 442, 304, 16, "#ffffff", [[攻	击：0000]])
	GUI:Text_enableOutline(cur_attr_1, "#000000", 1)
	GUI:setAnchorPoint(cur_attr_1, 0.00, 0.00)
	GUI:setTouchEnabled(cur_attr_1, false)
	GUI:setTag(cur_attr_1, 0)

	-- Create cur_attr_2
	local cur_attr_2 = GUI:Text_Create(LayoutBg, "cur_attr_2", 442, 280, 16, "#ffffff", [[人物体力增加：00%]])
	GUI:Text_enableOutline(cur_attr_2, "#000000", 1)
	GUI:setAnchorPoint(cur_attr_2, 0.00, 0.00)
	GUI:setTouchEnabled(cur_attr_2, false)
	GUI:setTag(cur_attr_2, 0)

	-- Create next_attr_1
	local next_attr_1 = GUI:Text_Create(LayoutBg, "next_attr_1", 649, 304, 16, "#00ff00", [[攻	击：]])
	GUI:Text_enableOutline(next_attr_1, "#000000", 1)
	GUI:setAnchorPoint(next_attr_1, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr_1, false)
	GUI:setTag(next_attr_1, 0)

	-- Create next_attr_2
	local next_attr_2 = GUI:Text_Create(LayoutBg, "next_attr_2", 649, 280, 16, "#00ff00", [[人物体力增加：00%]])
	GUI:Text_enableOutline(next_attr_2, "#000000", 1)
	GUI:setAnchorPoint(next_attr_2, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr_2, false)
	GUI:setTag(next_attr_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(LayoutBg, "Text_3", 496, 82, 16, "#ffff00", [[勾选使用幸运符，可增加10%的几率]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create QuickBuyBtn
	local QuickBuyBtn = GUI:Button_Create(LayoutBg, "QuickBuyBtn", 696, 36, "res/public/1900000662.png")
	GUI:setContentSize(QuickBuyBtn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(QuickBuyBtn, false)
	GUI:Button_setTitleText(QuickBuyBtn, [[快捷购买]])
	GUI:Button_setTitleColor(QuickBuyBtn, "#f8e6c6")
	GUI:Button_setTitleFontSize(QuickBuyBtn, 16)
	GUI:Button_titleEnableOutline(QuickBuyBtn, "#000000", 1)
	GUI:setAnchorPoint(QuickBuyBtn, 0.00, 0.00)
	GUI:setTouchEnabled(QuickBuyBtn, true)
	GUI:setTag(QuickBuyBtn, 0)

	-- Create suit_box
	local suit_box = GUI:Layout_Create(FrameLayout, "suit_box", -2, -3, 1136, 640, false)
	GUI:setAnchorPoint(suit_box, 0.00, 0.00)
	GUI:setTouchEnabled(suit_box, true)
	GUI:setTag(suit_box, 0)
	GUI:setVisible(suit_box, false)

	-- Create suit_box_bg
	local suit_box_bg = GUI:Image_Create(suit_box, "suit_box_bg", 49, 130, "res/public/bg_npc_01.png")
	GUI:Image_setScale9Slice(suit_box_bg, 54, 54, 59, 59)
	GUI:setContentSize(suit_box_bg, 718, 279)
	GUI:setIgnoreContentAdaptWithSize(suit_box_bg, false)
	GUI:setAnchorPoint(suit_box_bg, 0.00, 0.00)
	GUI:setTouchEnabled(suit_box_bg, false)
	GUI:setTag(suit_box_bg, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
