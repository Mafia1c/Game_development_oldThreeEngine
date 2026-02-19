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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0, _V("SCREEN_HEIGHT") * 0, 768, 432, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/97mrcz/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 76, 76, 144, 144)
	GUI:setContentSize(FrameBG, 768, 432)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create getBtn
	local getBtn = GUI:Button_Create(FrameLayout, "getBtn", 366, 40, "res/custom/npc/97mrcz/buy.png")
	GUI:setContentSize(getBtn, 124, 52)
	GUI:setIgnoreContentAdaptWithSize(getBtn, false)
	GUI:Button_setTitleText(getBtn, [[]])
	GUI:Button_setTitleColor(getBtn, "#ffffff")
	GUI:Button_setTitleFontSize(getBtn, 16)
	GUI:Button_titleEnableOutline(getBtn, "#000000", 1)
	GUI:setAnchorPoint(getBtn, 0.00, 0.00)
	GUI:setTouchEnabled(getBtn, true)
	GUI:setTag(getBtn, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 685, 310, "res/custom/npc/97mrcz/x.png")
	GUI:setContentSize(closeBtn, 56, 48)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create iconTag
	local iconTag = GUI:Image_Create(FrameLayout, "iconTag", 382, 39, "res/custom/tag/hdyl_002.png")
	GUI:setAnchorPoint(iconTag, 0.00, 0.00)
	GUI:setTouchEnabled(iconTag, false)
	GUI:setTag(iconTag, 0)

	-- Create award_list_view
	local award_list_view = GUI:Layout_Create(FrameLayout, "award_list_view", 279, 99, 376, 86, false)
	GUI:setAnchorPoint(award_list_view, 0.00, 0.00)
	GUI:setTouchEnabled(award_list_view, false)
	GUI:setTag(award_list_view, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
