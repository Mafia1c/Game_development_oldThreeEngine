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
	local LayoutBg = GUI:Image_Create(FrameLayout, "LayoutBg", -1, 1, "res/custom/npc/37qh/bg.png")
	GUI:setAnchorPoint(LayoutBg, 0.00, 0.00)
	GUI:setTouchEnabled(LayoutBg, true)
	GUI:setMouseEnabled(LayoutBg, true)
	GUI:setTag(LayoutBg, 0)

	-- Create strengthenLevelText
	local strengthenLevelText = GUI:Text_Create(LayoutBg, "strengthenLevelText", 280, 425, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(strengthenLevelText, "#000000", 1)
	GUI:setAnchorPoint(strengthenLevelText, 0.00, 0.00)
	GUI:setTouchEnabled(strengthenLevelText, false)
	GUI:setTag(strengthenLevelText, 0)

	-- Create strengthenBtn
	local strengthenBtn = GUI:Button_Create(LayoutBg, "strengthenBtn", 561, 110, "res/custom/dayeqian1.png")
	GUI:setContentSize(strengthenBtn, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(strengthenBtn, false)
	GUI:Button_setTitleText(strengthenBtn, [[开始强化]])
	GUI:Button_setTitleColor(strengthenBtn, "#ffffff")
	GUI:Button_setTitleFontSize(strengthenBtn, 16)
	GUI:Button_titleEnableOutline(strengthenBtn, "#000000", 1)
	GUI:setAnchorPoint(strengthenBtn, 0.00, 0.00)
	GUI:setTouchEnabled(strengthenBtn, true)
	GUI:setTag(strengthenBtn, 0)

	-- Create equipNameText
	local equipNameText = GUI:Text_Create(LayoutBg, "equipNameText", 465, 361, 16, "#ffff00", [[圣龙盔圣龙盔]])
	GUI:setIgnoreContentAdaptWithSize(equipNameText, false)
	GUI:Text_setTextAreaSize(equipNameText, 300, 24)
	GUI:Text_setTextHorizontalAlignment(equipNameText, 1)
	GUI:Text_enableOutline(equipNameText, "#000000", 1)
	GUI:setAnchorPoint(equipNameText, 0.00, 0.00)
	GUI:setTouchEnabled(equipNameText, false)
	GUI:setTag(equipNameText, 0)

	-- Create suitAttrBtn_1
	local suitAttrBtn_1 = GUI:Button_Create(LayoutBg, "suitAttrBtn_1", 736, 415, "res/custom/npc/37qh/tips.png")
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
	local CheckBox = GUI:CheckBox_Create(LayoutBg, "CheckBox", 467, 80, "res/custom/npc/37qh/gx_0.png", "res/custom/npc/37qh/gx_1.png")
	GUI:setContentSize(CheckBox, 24, 24)
	GUI:setIgnoreContentAdaptWithSize(CheckBox, false)
	GUI:CheckBox_setSelected(CheckBox, false)
	GUI:setAnchorPoint(CheckBox, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox, true)
	GUI:setTag(CheckBox, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(LayoutBg, "Text_2", 83, 37, 16, "#00ff00", [[提示：强化属性绑定装备位置（更新装备不受影响），强化失败时等级降低1级！]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create oddsText_1
	local oddsText_1 = GUI:Text_Create(LayoutBg, "oddsText_1", 538, 231, 16, "#ffffff", [[本次强化成功率：]])
	GUI:Text_enableOutline(oddsText_1, "#000000", 1)
	GUI:setAnchorPoint(oddsText_1, 0.00, 0.00)
	GUI:setTouchEnabled(oddsText_1, false)
	GUI:setTag(oddsText_1, 0)

	-- Create oddsText
	local oddsText = GUI:Text_Create(LayoutBg, "oddsText", 662, 231, 16, "#00ff00", [[100%]])
	GUI:Text_enableOutline(oddsText, "#000000", 1)
	GUI:setAnchorPoint(oddsText, 0.00, 0.00)
	GUI:setTouchEnabled(oddsText, false)
	GUI:setTag(oddsText, 0)

	-- Create needBox
	local needBox = GUI:Layout_Create(LayoutBg, "needBox", 530, 162, 183, 64, false)
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
	local equipBox = GUI:Layout_Create(LayoutBg, "equipBox", 75, 71, 347, 351, false)
	GUI:setAnchorPoint(equipBox, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox, false)
	GUI:setTag(equipBox, 0)

	-- Create equipPos1
	local equipPos1 = GUI:Node_Create(equipBox, "equipPos1", 42, 309)
	GUI:setTag(equipPos1, 0)

	-- Create equipPosBg1
	local equipPosBg1 = GUI:Image_Create(equipPos1, "equipPosBg1", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg1, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg1, true)
	GUI:setTag(equipPosBg1, 0)

	-- Create equipPos4
	local equipPos4 = GUI:Node_Create(equipBox, "equipPos4", 42, 239)
	GUI:setTag(equipPos4, 0)

	-- Create equipPosBg4
	local equipPosBg4 = GUI:Image_Create(equipPos4, "equipPosBg4", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg4, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg4, true)
	GUI:setTag(equipPosBg4, 0)

	-- Create equipPos6
	local equipPos6 = GUI:Node_Create(equipBox, "equipPos6", 42, 171)
	GUI:setTag(equipPos6, 0)

	-- Create equipPosBg6
	local equipPosBg6 = GUI:Image_Create(equipPos6, "equipPosBg6", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg6, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg6, true)
	GUI:setTag(equipPosBg6, 0)

	-- Create equipPos8
	local equipPos8 = GUI:Node_Create(equipBox, "equipPos8", 42, 105)
	GUI:setTag(equipPos8, 0)

	-- Create equipPosBg8
	local equipPosBg8 = GUI:Image_Create(equipPos8, "equipPosBg8", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg8, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg8, true)
	GUI:setTag(equipPosBg8, 0)

	-- Create equipPos10
	local equipPos10 = GUI:Node_Create(equipBox, "equipPos10", 42, 38)
	GUI:setTag(equipPos10, 0)

	-- Create equipPosBg10
	local equipPosBg10 = GUI:Image_Create(equipPos10, "equipPosBg10", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg10, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg10, true)
	GUI:setTag(equipPosBg10, 0)

	-- Create equipPos0
	local equipPos0 = GUI:Node_Create(equipBox, "equipPos0", 305, 311)
	GUI:setTag(equipPos0, 0)

	-- Create equipPosBg0
	local equipPosBg0 = GUI:Image_Create(equipPos0, "equipPosBg0", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg0, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg0, true)
	GUI:setTag(equipPosBg0, 0)

	-- Create equipPos3
	local equipPos3 = GUI:Node_Create(equipBox, "equipPos3", 305, 241)
	GUI:setTag(equipPos3, 0)

	-- Create equipPosBg3
	local equipPosBg3 = GUI:Image_Create(equipPos3, "equipPosBg3", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg3, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg3, true)
	GUI:setTag(equipPosBg3, 0)

	-- Create equipPos5
	local equipPos5 = GUI:Node_Create(equipBox, "equipPos5", 305, 173)
	GUI:setTag(equipPos5, 0)

	-- Create equipPosBg5
	local equipPosBg5 = GUI:Image_Create(equipPos5, "equipPosBg5", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg5, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg5, true)
	GUI:setTag(equipPosBg5, 0)

	-- Create equipPos7
	local equipPos7 = GUI:Node_Create(equipBox, "equipPos7", 305, 107)
	GUI:setTag(equipPos7, 0)

	-- Create equipPosBg7
	local equipPosBg7 = GUI:Image_Create(equipPos7, "equipPosBg7", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg7, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg7, true)
	GUI:setTag(equipPosBg7, 0)

	-- Create equipPos11
	local equipPos11 = GUI:Node_Create(equipBox, "equipPos11", 305, 41)
	GUI:setTag(equipPos11, 0)

	-- Create equipPosBg11
	local equipPosBg11 = GUI:Image_Create(equipPos11, "equipPosBg11", 0, -2, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equipPosBg11, 0.50, 0.50)
	GUI:setTouchEnabled(equipPosBg11, true)
	GUI:setTag(equipPosBg11, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(equipBox, "select_img", 42, 309, "res/public/1900000678_1.png")
	GUI:setContentSize(select_img, 65, 65)
	GUI:setIgnoreContentAdaptWithSize(select_img, false)
	GUI:setAnchorPoint(select_img, 0.50, 0.50)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)

	-- Create cur_attr_1
	local cur_attr_1 = GUI:Text_Create(LayoutBg, "cur_attr_1", 453, 302, 16, "#ffffff", [[攻	击：0]])
	GUI:setIgnoreContentAdaptWithSize(cur_attr_1, false)
	GUI:Text_setTextAreaSize(cur_attr_1, 108, 24)
	GUI:Text_enableOutline(cur_attr_1, "#000000", 1)
	GUI:setAnchorPoint(cur_attr_1, 0.00, 0.00)
	GUI:setTouchEnabled(cur_attr_1, false)
	GUI:setTag(cur_attr_1, 0)

	-- Create cur_attr_2
	local cur_attr_2 = GUI:Text_Create(LayoutBg, "cur_attr_2", 453, 278, 16, "#ffffff", [[人物体力增加：00%]])
	GUI:Text_enableOutline(cur_attr_2, "#000000", 1)
	GUI:setAnchorPoint(cur_attr_2, 0.00, 0.00)
	GUI:setTouchEnabled(cur_attr_2, false)
	GUI:setTag(cur_attr_2, 0)

	-- Create next_attr_1
	local next_attr_1 = GUI:Text_Create(LayoutBg, "next_attr_1", 660, 302, 16, "#00ff00", [[攻	击：0]])
	GUI:setIgnoreContentAdaptWithSize(next_attr_1, false)
	GUI:Text_setTextAreaSize(next_attr_1, 108, 24)
	GUI:Text_enableOutline(next_attr_1, "#000000", 1)
	GUI:setAnchorPoint(next_attr_1, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr_1, false)
	GUI:setTag(next_attr_1, 0)

	-- Create next_attr_2
	local next_attr_2 = GUI:Text_Create(LayoutBg, "next_attr_2", 660, 278, 16, "#00ff00", [[人物体力增加：00%]])
	GUI:setIgnoreContentAdaptWithSize(next_attr_2, false)
	GUI:Text_setTextAreaSize(next_attr_2, 160, 24)
	GUI:Text_enableOutline(next_attr_2, "#000000", 1)
	GUI:setAnchorPoint(next_attr_2, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr_2, false)
	GUI:setTag(next_attr_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(LayoutBg, "Text_3", 504, 80, 16, "#ffff00", [[勾选使用幸运符，可增加10%的几率]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create quick_btn
	local quick_btn = GUI:Button_Create(LayoutBg, "quick_btn", 694, 35, "res/public/1900000662.png")
	GUI:setContentSize(quick_btn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(quick_btn, false)
	GUI:Button_setTitleText(quick_btn, [[快捷购买]])
	GUI:Button_setTitleColor(quick_btn, "#ffffff")
	GUI:Button_setTitleFontSize(quick_btn, 16)
	GUI:Button_titleEnableOutline(quick_btn, "#000000", 1)
	GUI:setAnchorPoint(quick_btn, 0.00, 0.00)
	GUI:setTouchEnabled(quick_btn, true)
	GUI:setTag(quick_btn, 0)

	-- Create yimanji
	local yimanji = GUI:Image_Create(LayoutBg, "yimanji", 572, 103, "res/custom/tag/hdyl_006.png")
	GUI:setAnchorPoint(yimanji, 0.00, 0.00)
	GUI:setTouchEnabled(yimanji, false)
	GUI:setTag(yimanji, 0)

	-- Create suit_box
	local suit_box = GUI:Layout_Create(FrameLayout, "suit_box", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(suit_box, 0.00, 0.00)
	GUI:setTouchEnabled(suit_box, true)
	GUI:setTag(suit_box, 0)
	GUI:setVisible(suit_box, false)

	-- Create suit_box_bg
	local suit_box_bg = GUI:Image_Create(suit_box, "suit_box_bg", 104, 78, "res/public/bg_npc_01.png")
	GUI:Image_setScale9Slice(suit_box_bg, 54, 54, 59, 59)
	GUI:setContentSize(suit_box_bg, 657, 393)
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
