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

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 1, 0, "res/custom/npc/92zs/bg.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, true)
	GUI:setMouseEnabled(Image_1, true)
	GUI:setTag(Image_1, 0)

	-- Create oneList
	local oneList = GUI:ListView_Create(Image_1, "oneList", 74, 65, 119, 417, 1)
	GUI:ListView_setBounceEnabled(oneList, true)
	GUI:ListView_setGravity(oneList, 2)
	GUI:ListView_setItemsMargin(oneList, 1)
	GUI:setAnchorPoint(oneList, 0.00, 0.00)
	GUI:setTouchEnabled(oneList, true)
	GUI:setTag(oneList, 0)

	-- Create twoList
	local twoList = GUI:ListView_Create(Image_1, "twoList", 194, 70, 120, 412, 1)
	GUI:ListView_setGravity(twoList, 2)
	GUI:setAnchorPoint(twoList, 0.00, 0.00)
	GUI:setTouchEnabled(twoList, true)
	GUI:setTag(twoList, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(Image_1, "closeBtn", 819, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#f8e6c6")
	GUI:Button_setTitleFontSize(closeBtn, 18)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create DeblockingBox
	local DeblockingBox = GUI:Layout_Create(Image_1, "DeblockingBox", 317, 40, 485, 444, false)
	GUI:setAnchorPoint(DeblockingBox, 0.00, 0.00)
	GUI:setTouchEnabled(DeblockingBox, false)
	GUI:setTag(DeblockingBox, 0)
	GUI:setVisible(DeblockingBox, false)

	-- Create needitem4
	local needitem4 = GUI:ItemShow_Create(DeblockingBox, "needitem4", 331, 285, {index = 0, count = 2, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needitem4, 0.50, 0.50)
	GUI:setTag(needitem4, 0)

	-- Create needitem3
	local needitem3 = GUI:ItemShow_Create(DeblockingBox, "needitem3", 153, 286, {index = 0, count = 2, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needitem3, 0.50, 0.50)
	GUI:setTag(needitem3, 0)

	-- Create targetItem
	local targetItem = GUI:ItemShow_Create(DeblockingBox, "targetItem", 241, 368, {index = 0, count = 2, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(targetItem, 0.50, 0.50)
	GUI:setTag(targetItem, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(DeblockingBox, "Text_1", 147, 147, 16, "#ffffff", [[解封需要2件相同宗师装备
并且不会保留附魔属性
请提前将附魔剑甲存仓]])
	GUI:setIgnoreContentAdaptWithSize(Text_1, false)
	GUI:Text_setTextAreaSize(Text_1, 188, 72)
	GUI:Text_setTextHorizontalAlignment(Text_1, 1)
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create jf_btn
	local jf_btn = GUI:Button_Create(DeblockingBox, "jf_btn", 352, 46, "res/custom/yeqian2.png")
	GUI:setContentSize(jf_btn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(jf_btn, false)
	GUI:Button_setTitleText(jf_btn, [[开始觉醒]])
	GUI:Button_setTitleColor(jf_btn, "#f8e6c6")
	GUI:Button_setTitleFontSize(jf_btn, 18)
	GUI:Button_titleEnableOutline(jf_btn, "#000000", 1)
	GUI:setAnchorPoint(jf_btn, 0.00, 0.00)
	GUI:setTouchEnabled(jf_btn, true)
	GUI:setTag(jf_btn, 0)

	-- Create zengfu_box
	local zengfu_box = GUI:Layout_Create(Image_1, "zengfu_box", 317, 40, 485, 444, false)
	GUI:setAnchorPoint(zengfu_box, 0.00, 0.00)
	GUI:setTouchEnabled(zengfu_box, false)
	GUI:setTag(zengfu_box, 0)

	-- Create success_rate_text_1
	local success_rate_text_1 = GUI:Text_Create(zengfu_box, "success_rate_text_1", 92, 217, 16, "#ffff00", [[仅异次元装备可进行增幅]])
	GUI:setIgnoreContentAdaptWithSize(success_rate_text_1, false)
	GUI:Text_setTextAreaSize(success_rate_text_1, 300, 24)
	GUI:Text_setTextHorizontalAlignment(success_rate_text_1, 1)
	GUI:Text_enableOutline(success_rate_text_1, "#000000", 1)
	GUI:setAnchorPoint(success_rate_text_1, 0.00, 0.00)
	GUI:setTouchEnabled(success_rate_text_1, false)
	GUI:setTag(success_rate_text_1, 0)

	-- Create success_rate_text
	local success_rate_text = GUI:Text_Create(zengfu_box, "success_rate_text", 91, 186, 16, "#ffff00", [[增幅成功几率：20%]])
	GUI:setIgnoreContentAdaptWithSize(success_rate_text, false)
	GUI:Text_setTextAreaSize(success_rate_text, 300, 24)
	GUI:Text_setTextHorizontalAlignment(success_rate_text, 1)
	GUI:Text_enableOutline(success_rate_text, "#000000", 1)
	GUI:setAnchorPoint(success_rate_text, 0.00, 0.00)
	GUI:setTouchEnabled(success_rate_text, false)
	GUI:setTag(success_rate_text, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(zengfu_box, "Text_3", 177, 155, 16, "#9b00ff", [[失败扣除消耗材料]])
	GUI:Text_setTextHorizontalAlignment(Text_3, 1)
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(zengfu_box, "Text_4", 191, 127, 16, "#00ff00", [[增幅属性：]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create attr_text
	local attr_text = GUI:Text_Create(zengfu_box, "attr_text", 269, 127, 16, "#ff0000", [[无]])
	GUI:Text_enableOutline(attr_text, "#000000", 1)
	GUI:setAnchorPoint(attr_text, 0.00, 0.00)
	GUI:setTouchEnabled(attr_text, false)
	GUI:setTag(attr_text, 0)

	-- Create zf_btn
	local zf_btn = GUI:Button_Create(zengfu_box, "zf_btn", 352, 46, "res/custom/yeqian2.png")
	GUI:setContentSize(zf_btn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(zf_btn, false)
	GUI:Button_setTitleText(zf_btn, [[开始增幅]])
	GUI:Button_setTitleColor(zf_btn, "#f8e6c6")
	GUI:Button_setTitleFontSize(zf_btn, 18)
	GUI:Button_titleEnableOutline(zf_btn, "#000000", 1)
	GUI:setAnchorPoint(zf_btn, 0.00, 0.00)
	GUI:setTouchEnabled(zf_btn, true)
	GUI:setTag(zf_btn, 0)

	-- Create needitem1
	local needitem1 = GUI:ItemShow_Create(Image_1, "needitem1", 475, 98, {index = 0, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needitem1, 0.50, 0.50)
	GUI:setTag(needitem1, 0)

	-- Create needitem2
	local needitem2 = GUI:ItemShow_Create(Image_1, "needitem2", 543, 98, {index = 0, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needitem2, 0.50, 0.50)
	GUI:setTag(needitem2, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
