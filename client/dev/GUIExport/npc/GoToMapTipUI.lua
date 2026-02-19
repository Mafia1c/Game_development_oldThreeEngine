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
	local FrameBG = GUI:Image_Create(parent, "FrameBG", 956, 350, "res/custom/npc/79wldt/tc1.png")
	GUI:setContentSize(FrameBG, 170, 220)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 1.00, 0.50)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create enter_btn
	local enter_btn = GUI:Button_Create(FrameBG, "enter_btn", 40, 15, "res/custom/dayeqian1.png")
	GUI:setContentSize(enter_btn, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(enter_btn, false)
	GUI:Button_setTitleText(enter_btn, [[立即前往]])
	GUI:Button_setTitleColor(enter_btn, "#ffffcd")
	GUI:Button_setTitleFontSize(enter_btn, 16)
	GUI:Button_titleEnableOutline(enter_btn, "#000000", 1)
	GUI:setAnchorPoint(enter_btn, 0.00, 0.00)
	GUI:setTouchEnabled(enter_btn, true)
	GUI:setTag(enter_btn, 0)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameBG, "close_btn", 169, 181, "res/custom/closeBtn.png")
	GUI:setContentSize(close_btn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleEnableOutline(close_btn, "#000000", 1)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameBG, "Image_1", 30, 45, "res/public/btn_npcfh_04.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
