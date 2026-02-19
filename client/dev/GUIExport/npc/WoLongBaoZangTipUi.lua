local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create close_btn
	local close_btn = GUI:Layout_Create(parent, "close_btn", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 420, 230, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 0, 0, "res/public/1900000666.png")
	GUI:Image_setScale9Slice(Image_2, 30, 30, 73, 73)
	GUI:setContentSize(Image_2, 420, 230)
	GUI:setIgnoreContentAdaptWithSize(Image_2, false)
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, true)
	GUI:setMouseEnabled(Image_2, true)
	GUI:setTag(Image_2, 0)

	-- Create Panel
	local Panel = GUI:Layout_Create(FrameLayout, "Panel", 8, 61, 403, 159, false)
	GUI:setAnchorPoint(Panel, 0.00, 0.00)
	GUI:setTouchEnabled(Panel, false)
	GUI:setTag(Panel, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 88, 27, "res/public/1900000662.png")
	GUI:setContentSize(Button_1, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[确定]])
	GUI:Button_setTitleColor(Button_1, "#efd6ad")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 237, 27, "res/public/1900000662.png")
	GUI:setContentSize(Button_2, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[取消]])
	GUI:Button_setTitleColor(Button_2, "#efd6ad")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create CloseBtn
	local CloseBtn = GUI:Button_Create(FrameLayout, "CloseBtn", 419, 188, "res/public/1900000510.png")
	GUI:setContentSize(CloseBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(CloseBtn, false)
	GUI:Button_setTitleText(CloseBtn, [[]])
	GUI:Button_setTitleColor(CloseBtn, "#ffffff")
	GUI:Button_setTitleFontSize(CloseBtn, 16)
	GUI:Button_titleEnableOutline(CloseBtn, "#000000", 1)
	GUI:setAnchorPoint(CloseBtn, 0.00, 0.00)
	GUI:setTouchEnabled(CloseBtn, true)
	GUI:setTag(CloseBtn, 0)

	ui.update(__data__)
	return close_btn
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
