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
	local LayoutBg = GUI:Image_Create(FrameLayout, "LayoutBg", 1, -1, "res/custom/npc/18tj/bg.png")
	GUI:setAnchorPoint(LayoutBg, 0.00, 0.00)
	GUI:setTouchEnabled(LayoutBg, true)
	GUI:setMouseEnabled(LayoutBg, true)
	GUI:setTag(LayoutBg, 0)

	-- Create equipTypelist
	local equipTypelist = GUI:ScrollView_Create(FrameLayout, "equipTypelist", 75, 74, 117, 409, 1)
	GUI:ScrollView_setBounceEnabled(equipTypelist, true)
	GUI:ScrollView_setInnerContainerSize(equipTypelist, 117.00, 443.00)
	GUI:setAnchorPoint(equipTypelist, 0.00, 0.00)
	GUI:setTouchEnabled(equipTypelist, true)
	GUI:setTag(equipTypelist, 0)

	-- Create equipChildTypelist
	local equipChildTypelist = GUI:ScrollView_Create(FrameLayout, "equipChildTypelist", 198, 114, 117, 368, 1)
	GUI:ScrollView_setBounceEnabled(equipChildTypelist, true)
	GUI:ScrollView_setInnerContainerSize(equipChildTypelist, 117.00, 436.00)
	GUI:setAnchorPoint(equipChildTypelist, 0.00, 0.00)
	GUI:setTouchEnabled(equipChildTypelist, true)
	GUI:setTag(equipChildTypelist, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 822, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create rightBox
	local rightBox = GUI:Layout_Create(FrameLayout, "rightBox", 326, 105, 480, 337, false)
	GUI:setAnchorPoint(rightBox, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox, false)
	GUI:setTag(rightBox, 0)

	-- Create equip_pos1
	local equip_pos1 = GUI:Image_Create(rightBox, "equip_pos1", 90, 247, "res/custom/npc/18tj/k.png")
	GUI:setAnchorPoint(equip_pos1, 0.00, 0.00)
	GUI:setTouchEnabled(equip_pos1, false)
	GUI:setTag(equip_pos1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(equip_pos1, "ItemShow_1", 36, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create lock1
	local lock1 = GUI:Image_Create(equip_pos1, "lock1", 9, 2, "res/custom/npc/18tj/s.png")
	GUI:setAnchorPoint(lock1, 0.00, 0.00)
	GUI:setTouchEnabled(lock1, false)
	GUI:setTag(lock1, 0)

	-- Create item_name1
	local item_name1 = GUI:Text_Create(equip_pos1, "item_name1", -29, 61, 16, "#ff9b00", [[]])
	GUI:setIgnoreContentAdaptWithSize(item_name1, false)
	GUI:Text_setTextAreaSize(item_name1, 131, 24)
	GUI:Text_setTextHorizontalAlignment(item_name1, 1)
	GUI:Text_enableOutline(item_name1, "#000000", 1)
	GUI:setAnchorPoint(item_name1, 0.00, 0.00)
	GUI:setTouchEnabled(item_name1, false)
	GUI:setTag(item_name1, 0)

	-- Create equip_pos2
	local equip_pos2 = GUI:Image_Create(rightBox, "equip_pos2", 207, 247, "res/custom/npc/18tj/k.png")
	GUI:setAnchorPoint(equip_pos2, 0.00, 0.00)
	GUI:setTouchEnabled(equip_pos2, false)
	GUI:setTag(equip_pos2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(equip_pos2, "ItemShow_2", 36, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create lock2
	local lock2 = GUI:Image_Create(equip_pos2, "lock2", 9, 2, "res/custom/npc/18tj/s.png")
	GUI:setAnchorPoint(lock2, 0.00, 0.00)
	GUI:setTouchEnabled(lock2, false)
	GUI:setTag(lock2, 0)

	-- Create item_name2
	local item_name2 = GUI:Text_Create(equip_pos2, "item_name2", -29, 61, 16, "#ff9b00", [[]])
	GUI:setIgnoreContentAdaptWithSize(item_name2, false)
	GUI:Text_setTextAreaSize(item_name2, 131, 24)
	GUI:Text_setTextHorizontalAlignment(item_name2, 1)
	GUI:Text_enableOutline(item_name2, "#000000", 1)
	GUI:setAnchorPoint(item_name2, 0.00, 0.00)
	GUI:setTouchEnabled(item_name2, false)
	GUI:setTag(item_name2, 0)

	-- Create equip_pos3
	local equip_pos3 = GUI:Image_Create(rightBox, "equip_pos3", 317, 247, "res/custom/npc/18tj/k.png")
	GUI:setAnchorPoint(equip_pos3, 0.00, 0.00)
	GUI:setTouchEnabled(equip_pos3, false)
	GUI:setTag(equip_pos3, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(equip_pos3, "ItemShow_3", 36, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create lock3
	local lock3 = GUI:Image_Create(equip_pos3, "lock3", 9, 2, "res/custom/npc/18tj/s.png")
	GUI:setAnchorPoint(lock3, 0.00, 0.00)
	GUI:setTouchEnabled(lock3, false)
	GUI:setTag(lock3, 0)

	-- Create item_name3
	local item_name3 = GUI:Text_Create(equip_pos3, "item_name3", -29, 61, 16, "#ff9b00", [[]])
	GUI:setIgnoreContentAdaptWithSize(item_name3, false)
	GUI:Text_setTextAreaSize(item_name3, 131, 24)
	GUI:Text_setTextHorizontalAlignment(item_name3, 1)
	GUI:Text_enableOutline(item_name3, "#000000", 1)
	GUI:setAnchorPoint(item_name3, 0.00, 0.00)
	GUI:setTouchEnabled(item_name3, false)
	GUI:setTag(item_name3, 0)

	-- Create equip_pos4
	local equip_pos4 = GUI:Image_Create(rightBox, "equip_pos4", 90, 146, "res/custom/npc/18tj/k.png")
	GUI:setAnchorPoint(equip_pos4, 0.00, 0.00)
	GUI:setTouchEnabled(equip_pos4, false)
	GUI:setTag(equip_pos4, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(equip_pos4, "ItemShow_4", 36, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create lock4
	local lock4 = GUI:Image_Create(equip_pos4, "lock4", 9, 2, "res/custom/npc/18tj/s.png")
	GUI:setAnchorPoint(lock4, 0.00, 0.00)
	GUI:setTouchEnabled(lock4, false)
	GUI:setTag(lock4, 0)

	-- Create item_name4
	local item_name4 = GUI:Text_Create(equip_pos4, "item_name4", -29, 61, 16, "#ff9b00", [[]])
	GUI:setIgnoreContentAdaptWithSize(item_name4, false)
	GUI:Text_setTextAreaSize(item_name4, 131, 24)
	GUI:Text_setTextHorizontalAlignment(item_name4, 1)
	GUI:Text_enableOutline(item_name4, "#000000", 1)
	GUI:setAnchorPoint(item_name4, 0.00, 0.00)
	GUI:setTouchEnabled(item_name4, false)
	GUI:setTag(item_name4, 0)

	-- Create equip_pos5
	local equip_pos5 = GUI:Image_Create(rightBox, "equip_pos5", 207, 146, "res/custom/npc/18tj/k.png")
	GUI:setAnchorPoint(equip_pos5, 0.00, 0.00)
	GUI:setTouchEnabled(equip_pos5, false)
	GUI:setTag(equip_pos5, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(equip_pos5, "ItemShow_5", 36, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create lock5
	local lock5 = GUI:Image_Create(equip_pos5, "lock5", 9, 2, "res/custom/npc/18tj/s.png")
	GUI:setAnchorPoint(lock5, 0.00, 0.00)
	GUI:setTouchEnabled(lock5, false)
	GUI:setTag(lock5, 0)

	-- Create item_name5
	local item_name5 = GUI:Text_Create(equip_pos5, "item_name5", -29, 61, 16, "#ff9b00", [[]])
	GUI:setIgnoreContentAdaptWithSize(item_name5, false)
	GUI:Text_setTextAreaSize(item_name5, 131, 24)
	GUI:Text_setTextHorizontalAlignment(item_name5, 1)
	GUI:Text_enableOutline(item_name5, "#000000", 1)
	GUI:setAnchorPoint(item_name5, 0.00, 0.00)
	GUI:setTouchEnabled(item_name5, false)
	GUI:setTag(item_name5, 0)

	-- Create equip_pos6
	local equip_pos6 = GUI:Image_Create(rightBox, "equip_pos6", 317, 146, "res/custom/npc/18tj/k.png")
	GUI:setAnchorPoint(equip_pos6, 0.00, 0.00)
	GUI:setTouchEnabled(equip_pos6, false)
	GUI:setTag(equip_pos6, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(equip_pos6, "ItemShow_6", 36, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create lock6
	local lock6 = GUI:Image_Create(equip_pos6, "lock6", 9, 2, "res/custom/npc/18tj/s.png")
	GUI:setAnchorPoint(lock6, 0.00, 0.00)
	GUI:setTouchEnabled(lock6, false)
	GUI:setTag(lock6, 0)

	-- Create item_name6
	local item_name6 = GUI:Text_Create(equip_pos6, "item_name6", -29, 61, 16, "#ff9b00", [[]])
	GUI:setIgnoreContentAdaptWithSize(item_name6, false)
	GUI:Text_setTextAreaSize(item_name6, 131, 24)
	GUI:Text_setTextHorizontalAlignment(item_name6, 1)
	GUI:Text_enableOutline(item_name6, "#000000", 1)
	GUI:setAnchorPoint(item_name6, 0.00, 0.00)
	GUI:setTouchEnabled(item_name6, false)
	GUI:setTag(item_name6, 0)

	-- Create award_item1
	local award_item1 = GUI:ItemShow_Create(rightBox, "award_item1", 192, 79, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_item1, 0.50, 0.50)
	GUI:setTag(award_item1, 0)

	-- Create award_item2
	local award_item2 = GUI:ItemShow_Create(rightBox, "award_item2", 283, 79, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_item2, 0.50, 0.50)
	GUI:setTag(award_item2, 0)

	-- Create shoujiBtn
	local shoujiBtn = GUI:Button_Create(rightBox, "shoujiBtn", 183, 4, "res/custom/yeqian2.png")
	GUI:setContentSize(shoujiBtn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(shoujiBtn, false)
	GUI:Button_setTitleText(shoujiBtn, [[一键收集]])
	GUI:Button_setTitleColor(shoujiBtn, "#F8E6C6")
	GUI:Button_setTitleFontSize(shoujiBtn, 16)
	GUI:Button_titleEnableOutline(shoujiBtn, "#000000", 1)
	GUI:setAnchorPoint(shoujiBtn, 0.00, 0.00)
	GUI:setTouchEnabled(shoujiBtn, true)
	GUI:setTag(shoujiBtn, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(rightBox, "Text_1", -125, -53, 16, "#ff9b00", [==========[[图鉴总属性]：]==========])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create attr_text
	local attr_text = GUI:Text_Create(rightBox, "attr_text", -22, -53, 16, "#00ffe8", [[生命值：10，攻魔道：1，防魔御：1，生命加成：0%]])
	GUI:Text_enableOutline(attr_text, "#000000", 1)
	GUI:setAnchorPoint(attr_text, 0.00, 0.00)
	GUI:setTouchEnabled(attr_text, false)
	GUI:setTag(attr_text, 0)

	-- Create yiWanCheng
	local yiWanCheng = GUI:Image_Create(rightBox, "yiWanCheng", 195, 2, "res/custom/tag/hdyl_106.png")
	GUI:setAnchorPoint(yiWanCheng, 0.00, 0.00)
	GUI:setTouchEnabled(yiWanCheng, false)
	GUI:setTag(yiWanCheng, 0)
	GUI:setVisible(yiWanCheng, false)

	-- Create tujian_btn
	local tujian_btn = GUI:Button_Create(FrameLayout, "tujian_btn", 739, 417, "res/custom/npc/18tj/bt1.png")
	GUI:setContentSize(tujian_btn, 64, 51)
	GUI:setIgnoreContentAdaptWithSize(tujian_btn, false)
	GUI:Button_setTitleText(tujian_btn, [[]])
	GUI:Button_setTitleColor(tujian_btn, "#ffffff")
	GUI:Button_setTitleFontSize(tujian_btn, 16)
	GUI:Button_titleEnableOutline(tujian_btn, "#000000", 1)
	GUI:setAnchorPoint(tujian_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tujian_btn, true)
	GUI:setTag(tujian_btn, 0)

	-- Create tujianAttrDescBg
	local tujianAttrDescBg = GUI:Image_Create(FrameLayout, "tujianAttrDescBg", 241, 185, "res/public/1900000650.png")
	GUI:Image_setScale9Slice(tujianAttrDescBg, 0, 0, 0, 0)
	GUI:setContentSize(tujianAttrDescBg, 398, 205)
	GUI:setIgnoreContentAdaptWithSize(tujianAttrDescBg, false)
	GUI:setAnchorPoint(tujianAttrDescBg, 0.00, 0.00)
	GUI:setTouchEnabled(tujianAttrDescBg, false)
	GUI:setTag(tujianAttrDescBg, 0)
	GUI:setVisible(tujianAttrDescBg, false)

	-- Create tujianBtnBox
	local tujianBtnBox = GUI:Layout_Create(tujianAttrDescBg, "tujianBtnBox", -240, -186, 846, 566, false)
	GUI:setAnchorPoint(tujianBtnBox, 0.00, 0.00)
	GUI:setTouchEnabled(tujianBtnBox, true)
	GUI:setTag(tujianBtnBox, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
