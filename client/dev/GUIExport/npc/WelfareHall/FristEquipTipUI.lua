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
	GUI:setTouchEnabled(CloseLayout, false)
	GUI:setTag(CloseLayout, -1)
	GUI:setVisible(CloseLayout, false)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(parent, "FrameBG", 992, 331, "res/custom/tc/bg1.png")
	GUI:setContentSize(FrameBG, 148, 198)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 1.00, 0.50)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create equip_item
	local equip_item = GUI:ItemShow_Create(FrameBG, "equip_item", 73, 110, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(equip_item, 0.50, 0.50)
	GUI:setTag(equip_item, 0)

	-- Create equip_name
	local equip_name = GUI:Text_Create(FrameBG, "equip_name", 19, 53, 16, "#00ff00", [[天龙战链]])
	GUI:setIgnoreContentAdaptWithSize(equip_name, false)
	GUI:Text_setTextAreaSize(equip_name, 111, 24)
	GUI:Text_setTextHorizontalAlignment(equip_name, 1)
	GUI:Text_enableOutline(equip_name, "#000000", 1)
	GUI:setAnchorPoint(equip_name, 0.00, 0.00)
	GUI:setTouchEnabled(equip_name, false)
	GUI:setTag(equip_name, 0)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameBG, "close_btn", 37, 19, "res/public/1900000611.png")
	GUI:Button_setTitleText(close_btn, [[确定]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleEnableOutline(close_btn, "#000000", 1)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create close_time
	local close_time = GUI:Text_Create(FrameBG, "close_time", 114, 7, 16, "#00ff00", [[5秒]])
	GUI:Text_enableOutline(close_time, "#000000", 1)
	GUI:setAnchorPoint(close_time, 0.00, 0.00)
	GUI:setTouchEnabled(close_time, false)
	GUI:setTag(close_time, 0)

	-- Create title_img
	local title_img = GUI:Image_Create(FrameBG, "title_img", 31, 159, "res/custom/tc/icon1.png")
	GUI:setAnchorPoint(title_img, 0.00, 0.00)
	GUI:setTouchEnabled(title_img, false)
	GUI:setTag(title_img, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
