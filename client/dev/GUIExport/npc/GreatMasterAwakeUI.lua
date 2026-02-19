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
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 0, 0, "res/custom/npc/47jx/bg1.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, true)
	GUI:setMouseEnabled(Image_1, true)
	GUI:setTag(Image_1, 0)

	-- Create oneList
	local oneList = GUI:ListView_Create(Image_1, "oneList", 72, 47, 119, 435, 1)
	GUI:ListView_setBounceEnabled(oneList, true)
	GUI:ListView_setGravity(oneList, 2)
	GUI:ListView_setItemsMargin(oneList, 1)
	GUI:setAnchorPoint(oneList, 0.00, 0.00)
	GUI:setTouchEnabled(oneList, true)
	GUI:setTag(oneList, 0)

	-- Create twoList
	local twoList = GUI:ListView_Create(Image_1, "twoList", 194, 116, 120, 366, 1)
	GUI:ListView_setGravity(twoList, 2)
	GUI:setAnchorPoint(twoList, 0.00, 0.00)
	GUI:setTouchEnabled(twoList, true)
	GUI:setTag(twoList, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(Image_1, "RichText_1", 196, 34, [[<font color='#ffff00' size='16' >提示：觉醒成功，主装备觉醒成对应的聖龍级别装备！</font><br><font color='#ffff00' size='16' >            觉醒失败，主装备不消失，只消耗附加材料和元宝！</font><br><font color='#ffffff' size='16' >            </font><font color='#00ff00' size='16' >每次觉醒失败，增加临时成功几率1%，最高提示10%(强化成功重新计算)</font>]], 600, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create jueXingButton
	local jueXingButton = GUI:Button_Create(Image_1, "jueXingButton", 508, 108, "res/custom/bt_dz.png")
	GUI:setContentSize(jueXingButton, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(jueXingButton, false)
	GUI:Button_setTitleText(jueXingButton, [[开始觉醒]])
	GUI:Button_setTitleColor(jueXingButton, "#f8e6c6")
	GUI:Button_setTitleFontSize(jueXingButton, 18)
	GUI:Button_titleEnableOutline(jueXingButton, "#000000", 1)
	GUI:setAnchorPoint(jueXingButton, 0.00, 0.00)
	GUI:setTouchEnabled(jueXingButton, true)
	GUI:setTag(jueXingButton, 0)

	-- Create needitem2
	local needitem2 = GUI:ItemShow_Create(Image_1, "needitem2", 560, 339, {index = 0, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(needitem2, 0.50, 0.50)
	GUI:setTag(needitem2, 0)

	-- Create needitem3
	local needitem3 = GUI:ItemShow_Create(Image_1, "needitem3", 691, 339, {index = 0, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(needitem3, 0.50, 0.50)
	GUI:setTag(needitem3, 0)

	-- Create needitem1
	local needitem1 = GUI:ItemShow_Create(Image_1, "needitem1", 429, 338, {index = 0, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(needitem1, 0.50, 0.50)
	GUI:setTag(needitem1, 0)

	-- Create needitem4
	local needitem4 = GUI:ItemShow_Create(Image_1, "needitem4", 561, 435, {index = 0, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(needitem4, 0.50, 0.50)
	GUI:setTag(needitem4, 0)

	-- Create targetItem
	local targetItem = GUI:ItemShow_Create(Image_1, "targetItem", 561, 250, {index = 0, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(targetItem, 0.50, 0.50)
	GUI:setTag(targetItem, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(Image_1, "closeBtn", 820, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#f8e6c6")
	GUI:Button_setTitleFontSize(closeBtn, 18)
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
