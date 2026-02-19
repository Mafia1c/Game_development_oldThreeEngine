local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 560, 391, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create closeButton
	local closeButton = GUI:Button_Create(FrameLayout, "closeButton", 559, 339, "res/public/1900000510.png")
	GUI:setContentSize(closeButton, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeButton, false)
	GUI:Button_setTitleText(closeButton, [[]])
	GUI:Button_setTitleColor(closeButton, "#ffffff")
	GUI:Button_setTitleFontSize(closeButton, 16)
	GUI:Button_titleEnableOutline(closeButton, "#000000", 1)
	GUI:setAnchorPoint(closeButton, 0.00, 0.00)
	GUI:setTouchEnabled(closeButton, true)
	GUI:setTag(closeButton, 0)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/23xm/bg2.png")
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, 0)

	-- Create kaipai
	local kaipai = GUI:Image_Create(FrameBG, "kaipai", 189, 107, "res/custom/npc/52wsxm/bg4.png")
	GUI:setAnchorPoint(kaipai, 0.00, 0.00)
	GUI:setTouchEnabled(kaipai, false)
	GUI:setTag(kaipai, 0)

	-- Create ItemShow
	local ItemShow = GUI:ItemShow_Create(kaipai, "ItemShow", 91, 138, {index = 1, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)

	-- Create selectButton
	local selectButton = GUI:Button_Create(kaipai, "selectButton", 51, 27, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(selectButton, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(selectButton, false)
	GUI:Button_setTitleText(selectButton, [[]])
	GUI:Button_setTitleColor(selectButton, "#ffffff")
	GUI:Button_setTitleFontSize(selectButton, 16)
	GUI:Button_titleEnableOutline(selectButton, "#000000", 1)
	GUI:setAnchorPoint(selectButton, 0.00, 0.00)
	GUI:setTouchEnabled(selectButton, true)
	GUI:setTag(selectButton, 0)

	-- Create name
	local name = GUI:Text_Create(kaipai, "name", 76, 196, 16, "#ff0000", [[无尽]])
	GUI:Text_setTextHorizontalAlignment(name, 1)
	GUI:Text_setTextVerticalAlignment(name, 1)
	GUI:Text_enableOutline(name, "#000000", 1)
	GUI:setAnchorPoint(name, 0.00, 0.00)
	GUI:setTouchEnabled(name, false)
	GUI:setTag(name, 0)

	-- Create runeReflushButton
	local runeReflushButton = GUI:Button_Create(FrameBG, "runeReflushButton", 231, 42, "res/custom/npc/23xm/an2.png")
	GUI:setContentSize(runeReflushButton, 100, 39)
	GUI:setIgnoreContentAdaptWithSize(runeReflushButton, false)
	GUI:Button_setTitleText(runeReflushButton, [[]])
	GUI:Button_setTitleColor(runeReflushButton, "#ffffff")
	GUI:Button_setTitleFontSize(runeReflushButton, 16)
	GUI:Button_titleEnableOutline(runeReflushButton, "#000000", 1)
	GUI:setAnchorPoint(runeReflushButton, 0.00, 0.00)
	GUI:setTouchEnabled(runeReflushButton, true)
	GUI:setTag(runeReflushButton, 0)

	-- Create reFlushTip
	local reFlushTip = GUI:Text_Create(FrameBG, "reFlushTip", 144, 18, 16, "#ccc3c3", [[花费：灵符x500，即可刷新一次无双血脉]])
	GUI:Text_enableOutline(reFlushTip, "#000000", 1)
	GUI:setAnchorPoint(reFlushTip, 0.00, 0.00)
	GUI:setTouchEnabled(reFlushTip, false)
	GUI:setTag(reFlushTip, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
