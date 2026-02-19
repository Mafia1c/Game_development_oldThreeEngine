local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create ChildLayout
	local ChildLayout = GUI:Layout_Create(parent, "ChildLayout", 149, 29, 610, 444, false)
	GUI:setAnchorPoint(ChildLayout, 0.00, 0.00)
	GUI:setTouchEnabled(ChildLayout, false)
	GUI:setTag(ChildLayout, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(ChildLayout, "Effect_1", 82, 230, 0, 27590, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create get_btn
	local get_btn = GUI:Button_Create(ChildLayout, "get_btn", 246, 31, "res/custom/bt_dz.png")
	GUI:setContentSize(get_btn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(get_btn, false)
	GUI:Button_setTitleText(get_btn, [[领取]])
	GUI:Button_setTitleColor(get_btn, "#ffffff")
	GUI:Button_setTitleFontSize(get_btn, 18)
	GUI:Button_titleEnableOutline(get_btn, "#000000", 1)
	GUI:setAnchorPoint(get_btn, 0.00, 0.00)
	GUI:setTouchEnabled(get_btn, true)
	GUI:setTag(get_btn, 0)

	-- Create has_get
	local has_get = GUI:Image_Create(ChildLayout, "has_get", 262, 29, "res/custom/tag/fuli_zt_1.png")
	GUI:setAnchorPoint(has_get, 0.00, 0.00)
	GUI:setTouchEnabled(has_get, false)
	GUI:setTag(has_get, 0)
	GUI:setVisible(has_get, false)

	-- Create service_list
	local service_list = GUI:Layout_Create(ChildLayout, "service_list", 350, 220, 277, 79, false)
	GUI:setAnchorPoint(service_list, 0.50, 0.50)
	GUI:setTouchEnabled(service_list, false)
	GUI:setTag(service_list, 0)

	ui.update(__data__)
	return ChildLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
