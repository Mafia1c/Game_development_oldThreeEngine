local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 560, 390, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
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

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 0, 0, "res/custom/npc/23xm/bg3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create cxKaPaiImg
	local cxKaPaiImg = GUI:Image_Create(Image_1, "cxKaPaiImg", 190, 101, "res/custom/npc/52wsxm/bg4.png")
	GUI:setContentSize(cxKaPaiImg, 182, 244)
	GUI:setIgnoreContentAdaptWithSize(cxKaPaiImg, false)
	GUI:setAnchorPoint(cxKaPaiImg, 0.00, 0.00)
	GUI:setTouchEnabled(cxKaPaiImg, false)
	GUI:setTag(cxKaPaiImg, 0)

	-- Create cxItem
	local cxItem = GUI:ItemShow_Create(cxKaPaiImg, "cxItem", 90, 137, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(cxItem, 0.50, 0.50)
	GUI:setTag(cxItem, 0)

	-- Create SelectBtn
	local SelectBtn = GUI:Button_Create(cxKaPaiImg, "SelectBtn", 46, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(SelectBtn, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(SelectBtn, false)
	GUI:Button_setTitleText(SelectBtn, [[]])
	GUI:Button_setTitleColor(SelectBtn, "#ffffff")
	GUI:Button_setTitleFontSize(SelectBtn, 16)
	GUI:Button_titleEnableOutline(SelectBtn, "#000000", 1)
	GUI:setAnchorPoint(SelectBtn, 0.00, 0.00)
	GUI:setTouchEnabled(SelectBtn, true)
	GUI:setTag(SelectBtn, 0)

	-- Create name
	local name = GUI:Text_Create(cxKaPaiImg, "name", 76, 196, 16, "#ff0000", [[文本]])
	GUI:Text_enableOutline(name, "#000000", 1)
	GUI:setAnchorPoint(name, 0.00, 0.00)
	GUI:setTouchEnabled(name, false)
	GUI:setTag(name, 0)

	-- Create expendTip
	local expendTip = GUI:Text_Create(Image_1, "expendTip", 142, 17, 16, "#ccc3c3", [[花费：灵符x500，即可刷新一次无双血脉]])
	GUI:Text_enableOutline(expendTip, "#000000", 1)
	GUI:setAnchorPoint(expendTip, 0.00, 0.00)
	GUI:setTouchEnabled(expendTip, false)
	GUI:setTag(expendTip, 0)

	-- Create runeRebuildButton
	local runeRebuildButton = GUI:Button_Create(Image_1, "runeRebuildButton", 230, 43, "res/custom/npc/23xm/an2.png")
	GUI:setContentSize(runeRebuildButton, 100, 39)
	GUI:setIgnoreContentAdaptWithSize(runeRebuildButton, false)
	GUI:Button_setTitleText(runeRebuildButton, [[]])
	GUI:Button_setTitleColor(runeRebuildButton, "#ffffff")
	GUI:Button_setTitleFontSize(runeRebuildButton, 16)
	GUI:Button_titleEnableOutline(runeRebuildButton, "#000000", 1)
	GUI:setAnchorPoint(runeRebuildButton, 0.00, 0.00)
	GUI:setTouchEnabled(runeRebuildButton, true)
	GUI:setTag(runeRebuildButton, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
