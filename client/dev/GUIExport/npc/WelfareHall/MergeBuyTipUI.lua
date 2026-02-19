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
	local Image_2 = GUI:Image_Create(Panel_1, "Image_2", 367, 224, "res/public/1900000666.png")
	GUI:Image_setScale9Slice(Image_2, 30, 30, 73, 73)
	GUI:setContentSize(Image_2, 420, 199)
	GUI:setIgnoreContentAdaptWithSize(Image_2, false)
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, true)
	GUI:setTag(Image_2, 0)

	-- Create CloseBtn
	local CloseBtn = GUI:Button_Create(Panel_1, "CloseBtn", 785, 382, "res/public/1900000510.png")
	GUI:setContentSize(CloseBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(CloseBtn, false)
	GUI:Button_setTitleText(CloseBtn, [[]])
	GUI:Button_setTitleColor(CloseBtn, "#ffffff")
	GUI:Button_setTitleFontSize(CloseBtn, 16)
	GUI:Button_titleEnableOutline(CloseBtn, "#000000", 1)
	GUI:setAnchorPoint(CloseBtn, 0.00, 0.00)
	GUI:setTouchEnabled(CloseBtn, true)
	GUI:setTag(CloseBtn, 0)

	-- Create Panel_2
	local Panel_2 = GUI:Layout_Create(Panel_1, "Panel_2", 376, 233, 401, 42, false)
	GUI:setAnchorPoint(Panel_2, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_2, false)
	GUI:setTag(Panel_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(Panel_2, "Button_3", 194, 4, "res/public/1900000662.png")
	GUI:setContentSize(Button_3, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[购买百次]])
	GUI:Button_setTitleColor(Button_3, "#efd6ad")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(Panel_2, "Button_2", 97, 4, "res/public/1900000662.png")
	GUI:setContentSize(Button_2, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[购买十次]])
	GUI:Button_setTitleColor(Button_2, "#efd6ad")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Panel_2, "Button_1", 0, 4, "res/public/1900000662.png")
	GUI:setContentSize(Button_1, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[购买一次]])
	GUI:Button_setTitleColor(Button_1, "#efd6ad")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	ui.update(__data__)
	return Panel_1
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
