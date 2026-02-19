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
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create closeButton
	local closeButton = GUI:Button_Create(FrameLayout, "closeButton", 560, 339, "res/public/1900000510.png")
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

	-- Create kapai_box
	local kapai_box = GUI:Layout_Create(FrameBG, "kapai_box", 31, 142, 494, 200, false)
	GUI:setAnchorPoint(kapai_box, 0.00, 0.00)
	GUI:setTouchEnabled(kapai_box, false)
	GUI:setTag(kapai_box, 0)

	-- Create kaipai
	local kaipai = GUI:Image_Create(kapai_box, "kaipai", 164, -27, "res/custom/npc/23xm/type_1.png")
	GUI:setAnchorPoint(kaipai, 0.00, 0.00)
	GUI:setTouchEnabled(kaipai, false)
	GUI:setTag(kaipai, 0)

	-- Create ItemShow
	local ItemShow = GUI:ItemShow_Create(kaipai, "ItemShow", 85, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)

	-- Create selectButton
	local selectButton = GUI:Button_Create(kaipai, "selectButton", 45, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(selectButton, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(selectButton, false)
	GUI:Button_setTitleText(selectButton, [[]])
	GUI:Button_setTitleColor(selectButton, "#ffffff")
	GUI:Button_setTitleFontSize(selectButton, 16)
	GUI:Button_titleEnableOutline(selectButton, "#000000", 1)
	GUI:setAnchorPoint(selectButton, 0.00, 0.00)
	GUI:setTouchEnabled(selectButton, true)
	GUI:setTag(selectButton, 0)

	-- Create bookReflushButton
	local bookReflushButton = GUI:Button_Create(FrameBG, "bookReflushButton", 137, 43, "res/custom/npc/23xm/an11.png")
	GUI:setContentSize(bookReflushButton, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(bookReflushButton, false)
	GUI:Button_setTitleText(bookReflushButton, [[]])
	GUI:Button_setTitleColor(bookReflushButton, "#ffffff")
	GUI:Button_setTitleFontSize(bookReflushButton, 16)
	GUI:Button_titleEnableOutline(bookReflushButton, "#000000", 1)
	GUI:setAnchorPoint(bookReflushButton, 0.00, 0.00)
	GUI:setTouchEnabled(bookReflushButton, true)
	GUI:setTag(bookReflushButton, 0)

	-- Create runeReflushButton
	local runeReflushButton = GUI:Button_Create(FrameBG, "runeReflushButton", 324, 43, "res/custom/npc/23xm/an10.png")
	GUI:setContentSize(runeReflushButton, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(runeReflushButton, false)
	GUI:Button_setTitleText(runeReflushButton, [[]])
	GUI:Button_setTitleColor(runeReflushButton, "#ffffff")
	GUI:Button_setTitleFontSize(runeReflushButton, 16)
	GUI:Button_titleEnableOutline(runeReflushButton, "#000000", 1)
	GUI:setAnchorPoint(runeReflushButton, 0.00, 0.00)
	GUI:setTouchEnabled(runeReflushButton, true)
	GUI:setTag(runeReflushButton, 0)

	-- Create reFlushTip
	local reFlushTip = GUI:Text_Create(FrameBG, "reFlushTip", 94, 18, 16, "#ffffff", [[花费:书页x199 或 灵符x100，即可刷新一次当前天赋]])
	GUI:Text_enableOutline(reFlushTip, "#000000", 1)
	GUI:setAnchorPoint(reFlushTip, 0.00, 0.00)
	GUI:setTouchEnabled(reFlushTip, false)
	GUI:setTag(reFlushTip, 0)

	-- Create reFlushTip_1
	local reFlushTip_1 = GUI:Text_Create(FrameBG, "reFlushTip_1", 35, 99, 16, "#00ff00", [[天赋介绍:稀有天赋→卓越天赋→传承天赋→天命天赋（仅大天赋出现）]])
	GUI:Text_enableOutline(reFlushTip_1, "#000000", 1)
	GUI:setAnchorPoint(reFlushTip_1, 0.00, 0.00)
	GUI:setTouchEnabled(reFlushTip_1, false)
	GUI:setTag(reFlushTip_1, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
