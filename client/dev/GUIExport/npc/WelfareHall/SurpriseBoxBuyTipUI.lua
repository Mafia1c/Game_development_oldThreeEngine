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

	-- Create bg
	local bg = GUI:Image_Create(Panel_1, "bg", 367, 224, "res/public/1900000666.png")
	GUI:Image_setScale9Slice(bg, 30, 30, 73, 73)
	GUI:setContentSize(bg, 420, 199)
	GUI:setIgnoreContentAdaptWithSize(bg, false)
	GUI:setAnchorPoint(bg, 0.00, 0.00)
	GUI:setTouchEnabled(bg, true)
	GUI:setTag(bg, 0)

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

	-- Create btn_list
	local btn_list = GUI:ListView_Create(Panel_1, "btn_list", 575, 287, 404, 43, 2)
	GUI:ListView_setGravity(btn_list, 3)
	GUI:ListView_setItemsMargin(btn_list, 20)
	GUI:setAnchorPoint(btn_list, 0.50, 0.50)
	GUI:setTouchEnabled(btn_list, true)
	GUI:setTag(btn_list, 0)

	ui.update(__data__)
	return Panel_1
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
