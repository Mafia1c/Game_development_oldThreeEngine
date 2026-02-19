local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:Layout_setBackGroundColorType(CloseLayout, 1)
	GUI:Layout_setBackGroundColor(CloseLayout, "#000000")
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 450, 200, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create bg
	local bg = GUI:Image_Create(FrameLayout, "bg", 0, 0, "res/public/1900000600.png")
	GUI:Image_setScale9Slice(bg, 0, 0, 0, 0)
	GUI:setContentSize(bg, 450, 200)
	GUI:setIgnoreContentAdaptWithSize(bg, false)
	GUI:setAnchorPoint(bg, 0.00, 0.00)
	GUI:setTouchEnabled(bg, true)
	GUI:setTag(bg, 0)

	-- Create str_text
	local str_text = GUI:Text_Create(bg, "str_text", 224, 140, 18, "#ffff00", [[礼包价格：19元礼包]])
	GUI:Text_enableOutline(str_text, "#000000", 1)
	GUI:setAnchorPoint(str_text, 0.50, 0.50)
	GUI:setTouchEnabled(str_text, false)
	GUI:setTag(str_text, 0)

	-- Create btn1
	local btn1 = GUI:Button_Create(bg, "btn1", 92, 52, "res/custom/bt_dz.png")
	GUI:setContentSize(btn1, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(btn1, false)
	GUI:Button_setTitleText(btn1, [[购买1次]])
	GUI:Button_setTitleColor(btn1, "#f8e6c6")
	GUI:Button_setTitleFontSize(btn1, 16)
	GUI:Button_titleEnableOutline(btn1, "#000000", 1)
	GUI:setAnchorPoint(btn1, 0.50, 0.50)
	GUI:setTouchEnabled(btn1, true)
	GUI:setTag(btn1, 0)

	-- Create btn2
	local btn2 = GUI:Button_Create(bg, "btn2", 360, 52, "res/custom/bt_dz.png")
	GUI:setContentSize(btn2, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(btn2, false)
	GUI:Button_setTitleText(btn2, [[购买10次]])
	GUI:Button_setTitleColor(btn2, "#f8e6c6")
	GUI:Button_setTitleFontSize(btn2, 16)
	GUI:Button_titleEnableOutline(btn2, "#000000", 1)
	GUI:setAnchorPoint(btn2, 0.50, 0.50)
	GUI:setTouchEnabled(btn2, true)
	GUI:setTag(btn2, 0)

	-- Create close_btn
	local close_btn = GUI:Button_Create(bg, "close_btn", 484, 200, "res/custom/closeBtn.png")
	GUI:setContentSize(close_btn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleEnableOutline(close_btn, "#000000", 1)
	GUI:setAnchorPoint(close_btn, 1.00, 1.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
