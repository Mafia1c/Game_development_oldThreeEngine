local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create closeButton
	local closeButton = GUI:Button_Create(FrameLayout, "closeButton", 829, 476, "res/public/1900000510.png")
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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 270, 137, "res/custom/npc/23xm/bg2.png")
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, 0)

	-- Create kapai_box
	local kapai_box = GUI:Layout_Create(FrameBG, "kapai_box", 31, 142, 494, 200, false)
	GUI:setAnchorPoint(kapai_box, 0.00, 0.00)
	GUI:setTouchEnabled(kapai_box, false)
	GUI:setTag(kapai_box, 0)

	-- Create kaipai1
	local kaipai1 = GUI:Image_Create(kapai_box, "kaipai1", -11, -27, "res/custom/npc/23xm/type_2.png")
	GUI:setAnchorPoint(kaipai1, 0.00, 0.00)
	GUI:setTouchEnabled(kaipai1, false)
	GUI:setTag(kaipai1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(kaipai1, "ItemShow_1", 85, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create selectButton1
	local selectButton1 = GUI:Button_Create(kaipai1, "selectButton1", 45, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(selectButton1, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(selectButton1, false)
	GUI:Button_setTitleText(selectButton1, [[]])
	GUI:Button_setTitleColor(selectButton1, "#ffffff")
	GUI:Button_setTitleFontSize(selectButton1, 16)
	GUI:Button_titleEnableOutline(selectButton1, "#000000", 1)
	GUI:setAnchorPoint(selectButton1, 0.00, 0.00)
	GUI:setTouchEnabled(selectButton1, true)
	GUI:setTag(selectButton1, 0)

	-- Create kaipai2
	local kaipai2 = GUI:Image_Create(kapai_box, "kaipai2", 164, -27, "res/custom/npc/23xm/type_1.png")
	GUI:setAnchorPoint(kaipai2, 0.00, 0.00)
	GUI:setTouchEnabled(kaipai2, false)
	GUI:setTag(kaipai2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(kaipai2, "ItemShow_2", 85, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create selectButton2
	local selectButton2 = GUI:Button_Create(kaipai2, "selectButton2", 45, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(selectButton2, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(selectButton2, false)
	GUI:Button_setTitleText(selectButton2, [[]])
	GUI:Button_setTitleColor(selectButton2, "#ffffff")
	GUI:Button_setTitleFontSize(selectButton2, 16)
	GUI:Button_titleEnableOutline(selectButton2, "#000000", 1)
	GUI:setAnchorPoint(selectButton2, 0.00, 0.00)
	GUI:setTouchEnabled(selectButton2, true)
	GUI:setTag(selectButton2, 0)

	-- Create kaipai3
	local kaipai3 = GUI:Image_Create(kapai_box, "kaipai3", 335, -27, "res/custom/npc/23xm/type_1.png")
	GUI:setAnchorPoint(kaipai3, 0.00, 0.00)
	GUI:setTouchEnabled(kaipai3, false)
	GUI:setTag(kaipai3, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(kaipai3, "ItemShow_3", 85, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create selectButton3
	local selectButton3 = GUI:Button_Create(kaipai3, "selectButton3", 45, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(selectButton3, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(selectButton3, false)
	GUI:Button_setTitleText(selectButton3, [[]])
	GUI:Button_setTitleColor(selectButton3, "#ffffff")
	GUI:Button_setTitleFontSize(selectButton3, 16)
	GUI:Button_titleEnableOutline(selectButton3, "#000000", 1)
	GUI:setAnchorPoint(selectButton3, 0.00, 0.00)
	GUI:setTouchEnabled(selectButton3, true)
	GUI:setTag(selectButton3, 0)

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
