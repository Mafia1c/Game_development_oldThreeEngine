local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 174, 51, 814, 496, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/25yk/bg1.png")
	GUI:setContentSize(bg_Image, 814, 496)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, true)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 720, 431, "res/custom/closeBtn2.png")
	GUI:setContentSize(closeBtn, 46, 46)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create activationBtn
	local activationBtn = GUI:Button_Create(FrameLayout, "activationBtn", 506, 144, "res/custom/npc/25yk/an1.png")
	GUI:setContentSize(activationBtn, 196, 54)
	GUI:setIgnoreContentAdaptWithSize(activationBtn, false)
	GUI:Button_setTitleText(activationBtn, [[]])
	GUI:Button_setTitleColor(activationBtn, "#ffffff")
	GUI:Button_setTitleFontSize(activationBtn, 16)
	GUI:Button_titleEnableOutline(activationBtn, "#000000", 1)
	GUI:setAnchorPoint(activationBtn, 0.50, 0.50)
	GUI:setTouchEnabled(activationBtn, true)
	GUI:setTag(activationBtn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(activationBtn, "Image_1", 177, 41, "res/public/btn_npcfh_04.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create todayBtn
	local todayBtn = GUI:Button_Create(FrameLayout, "todayBtn", 506, 144, "res/custom/npc/25yk/an2.png")
	GUI:setContentSize(todayBtn, 196, 54)
	GUI:setIgnoreContentAdaptWithSize(todayBtn, false)
	GUI:Button_setTitleText(todayBtn, [[]])
	GUI:Button_setTitleColor(todayBtn, "#ffffff")
	GUI:Button_setTitleFontSize(todayBtn, 16)
	GUI:Button_titleEnableOutline(todayBtn, "#000000", 1)
	GUI:setAnchorPoint(todayBtn, 0.50, 0.50)
	GUI:setTouchEnabled(todayBtn, true)
	GUI:setTag(todayBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
