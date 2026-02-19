local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(parent, "Panel_1", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Panel_1, "Image_2", 319, 208, "res/public/1900000650_1.png")
	GUI:setContentSize(Image_2, 500, 250)
	GUI:setIgnoreContentAdaptWithSize(Image_2, false)
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, true)
	GUI:setMouseEnabled(Image_2, true)
	GUI:setTag(Image_2, 0)

	-- Create OneBtn
	local OneBtn = GUI:Button_Create(Panel_1, "OneBtn", 630, 322, "res/custom/npc/20fl/017fldt9/an11.png")
	GUI:setContentSize(OneBtn, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(OneBtn, false)
	GUI:Button_setTitleText(OneBtn, [[]])
	GUI:Button_setTitleColor(OneBtn, "#efd6ad")
	GUI:Button_setTitleFontSize(OneBtn, 16)
	GUI:Button_titleEnableOutline(OneBtn, "#000000", 1)
	GUI:setAnchorPoint(OneBtn, 0.00, 0.00)
	GUI:setTouchEnabled(OneBtn, true)
	GUI:setTag(OneBtn, 0)

	-- Create TenBtn
	local TenBtn = GUI:Button_Create(Panel_1, "TenBtn", 631, 255, "res/custom/npc/20fl/017fldt9/an10.png")
	GUI:setContentSize(TenBtn, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(TenBtn, false)
	GUI:Button_setTitleText(TenBtn, [[]])
	GUI:Button_setTitleColor(TenBtn, "#efd6ad")
	GUI:Button_setTitleFontSize(TenBtn, 16)
	GUI:Button_titleEnableOutline(TenBtn, "#000000", 1)
	GUI:setAnchorPoint(TenBtn, 0.00, 0.00)
	GUI:setTouchEnabled(TenBtn, true)
	GUI:setTag(TenBtn, 0)

	-- Create CloseBtn
	local CloseBtn = GUI:Button_Create(Panel_1, "CloseBtn", 767, 372, "res/public/1900000510.png")
	GUI:setContentSize(CloseBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(CloseBtn, false)
	GUI:Button_setTitleText(CloseBtn, [[]])
	GUI:Button_setTitleColor(CloseBtn, "#ffffff")
	GUI:Button_setTitleFontSize(CloseBtn, 16)
	GUI:Button_titleEnableOutline(CloseBtn, "#000000", 1)
	GUI:setAnchorPoint(CloseBtn, 0.00, 0.00)
	GUI:setTouchEnabled(CloseBtn, true)
	GUI:setTag(CloseBtn, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Panel_1, "Text_1", 442, 352, 16, "#ffff00", [[强化增益包]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(Panel_1, "Text_2", 440, 326, 16, "#ffff00", [[价格：20元]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Panel_2
	local Panel_2 = GUI:Layout_Create(Panel_1, "Panel_2", 380, 258, 245, 65, false)
	GUI:setAnchorPoint(Panel_2, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_2, false)
	GUI:setTag(Panel_2, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Panel_2, "ItemShow_1", 72, 33, {index = 10377, count = 58, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(Panel_2, "ItemShow_2", 147, 33, {index = 10378, count = 10, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	ui.update(__data__)
	return Panel_1
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
