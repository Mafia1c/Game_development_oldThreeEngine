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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 680, 448, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/43xh/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 67, 67, 150, 150)
	GUI:setContentSize(FrameBG, 680, 448)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 681, 405, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/1900000511.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create btn_1
	local btn_1 = GUI:Button_Create(FrameLayout, "btn_1", 478, 347, "res/custom/npc/43xh/an_jl.png")
	GUI:setContentSize(btn_1, 134, 42)
	GUI:setIgnoreContentAdaptWithSize(btn_1, false)
	GUI:Button_setTitleText(btn_1, [[]])
	GUI:Button_setTitleColor(btn_1, "#ffffff")
	GUI:Button_setTitleFontSize(btn_1, 16)
	GUI:Button_titleEnableOutline(btn_1, "#000000", 1)
	GUI:setAnchorPoint(btn_1, 0.00, 0.00)
	GUI:setTouchEnabled(btn_1, true)
	GUI:setTag(btn_1, 0)

	-- Create btn_2
	local btn_2 = GUI:Button_Create(FrameLayout, "btn_2", 478, 295, "res/custom/npc/43xh/an_jl.png")
	GUI:setContentSize(btn_2, 134, 42)
	GUI:setIgnoreContentAdaptWithSize(btn_2, false)
	GUI:Button_setTitleText(btn_2, [[]])
	GUI:Button_setTitleColor(btn_2, "#ffffff")
	GUI:Button_setTitleFontSize(btn_2, 16)
	GUI:Button_titleEnableOutline(btn_2, "#000000", 1)
	GUI:setAnchorPoint(btn_2, 0.00, 0.00)
	GUI:setTouchEnabled(btn_2, true)
	GUI:setTag(btn_2, 0)

	-- Create btn_3
	local btn_3 = GUI:Button_Create(FrameLayout, "btn_3", 478, 242, "res/custom/npc/43xh/an_jl.png")
	GUI:setContentSize(btn_3, 134, 42)
	GUI:setIgnoreContentAdaptWithSize(btn_3, false)
	GUI:Button_setTitleText(btn_3, [[]])
	GUI:Button_setTitleColor(btn_3, "#ffffff")
	GUI:Button_setTitleFontSize(btn_3, 16)
	GUI:Button_titleEnableOutline(btn_3, "#000000", 1)
	GUI:setAnchorPoint(btn_3, 0.00, 0.00)
	GUI:setTouchEnabled(btn_3, true)
	GUI:setTag(btn_3, 0)

	-- Create start_btn
	local start_btn = GUI:Button_Create(FrameLayout, "start_btn", 255, 37, "res/custom/npc/43xh/an_ks.png")
	GUI:setContentSize(start_btn, 134, 42)
	GUI:setIgnoreContentAdaptWithSize(start_btn, false)
	GUI:Button_setTitleText(start_btn, [[]])
	GUI:Button_setTitleColor(start_btn, "#ffffff")
	GUI:Button_setTitleFontSize(start_btn, 16)
	GUI:Button_titleEnableOutline(start_btn, "#000000", 1)
	GUI:setAnchorPoint(start_btn, 0.00, 0.00)
	GUI:setTouchEnabled(start_btn, true)
	GUI:setTag(start_btn, 0)

	-- Create checkBox_1
	local checkBox_1 = GUI:CheckBox_Create(FrameLayout, "checkBox_1", 160, 192, "res/custom/npc/43xh/an_wgx.png", "res/custom/npc/43xh/an_gx.png")
	GUI:setContentSize(checkBox_1, 28, 28)
	GUI:setIgnoreContentAdaptWithSize(checkBox_1, false)
	GUI:CheckBox_setSelected(checkBox_1, false)
	GUI:setAnchorPoint(checkBox_1, 0.00, 0.00)
	GUI:setTouchEnabled(checkBox_1, true)
	GUI:setTag(checkBox_1, 0)

	-- Create checkBox_2
	local checkBox_2 = GUI:CheckBox_Create(FrameLayout, "checkBox_2", 160, 161, "res/custom/npc/43xh/an_wgx.png", "res/custom/npc/43xh/an_gx.png")
	GUI:setContentSize(checkBox_2, 28, 28)
	GUI:setIgnoreContentAdaptWithSize(checkBox_2, false)
	GUI:CheckBox_setSelected(checkBox_2, false)
	GUI:setAnchorPoint(checkBox_2, 0.00, 0.00)
	GUI:setTouchEnabled(checkBox_2, true)
	GUI:setTag(checkBox_2, 0)

	-- Create checkBox_3
	local checkBox_3 = GUI:CheckBox_Create(FrameLayout, "checkBox_3", 160, 129, "res/custom/npc/43xh/an_wgx.png", "res/custom/npc/43xh/an_gx.png")
	GUI:setContentSize(checkBox_3, 28, 28)
	GUI:setIgnoreContentAdaptWithSize(checkBox_3, false)
	GUI:CheckBox_setSelected(checkBox_3, false)
	GUI:setAnchorPoint(checkBox_3, 0.00, 0.00)
	GUI:setTouchEnabled(checkBox_3, true)
	GUI:setTag(checkBox_3, 0)

	-- Create checkBox_4
	local checkBox_4 = GUI:CheckBox_Create(FrameLayout, "checkBox_4", 160, 99, "res/custom/npc/43xh/an_wgx.png", "res/custom/npc/43xh/an_gx.png")
	GUI:setContentSize(checkBox_4, 28, 28)
	GUI:setIgnoreContentAdaptWithSize(checkBox_4, false)
	GUI:CheckBox_setSelected(checkBox_4, false)
	GUI:setAnchorPoint(checkBox_4, 0.00, 0.00)
	GUI:setTouchEnabled(checkBox_4, true)
	GUI:setTag(checkBox_4, 0)

	-- Create map_name1
	local map_name1 = GUI:Text_Create(FrameLayout, "map_name1", 185, 356, 18, "#ffffff", [[未记录地图]])
	GUI:Text_enableOutline(map_name1, "#000000", 1)
	GUI:setAnchorPoint(map_name1, 0.00, 0.00)
	GUI:setTouchEnabled(map_name1, false)
	GUI:setTag(map_name1, 0)

	-- Create map_name2
	local map_name2 = GUI:Text_Create(FrameLayout, "map_name2", 185, 302, 18, "#ffffff", [[未记录地图]])
	GUI:Text_enableOutline(map_name2, "#000000", 1)
	GUI:setAnchorPoint(map_name2, 0.00, 0.00)
	GUI:setTouchEnabled(map_name2, false)
	GUI:setTag(map_name2, 0)

	-- Create map_name3
	local map_name3 = GUI:Text_Create(FrameLayout, "map_name3", 185, 249, 18, "#ffffff", [[未记录地图]])
	GUI:Text_enableOutline(map_name3, "#000000", 1)
	GUI:setAnchorPoint(map_name3, 0.00, 0.00)
	GUI:setTouchEnabled(map_name3, false)
	GUI:setTag(map_name3, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
