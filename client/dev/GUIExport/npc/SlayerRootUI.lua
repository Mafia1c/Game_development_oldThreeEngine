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
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/32tm/tumomj.png")
	GUI:Image_setScale9Slice(FrameBG, 77, 77, 172, 172)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 821, 483, "res/public/1900000510.png")
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

	-- Create startBtn
	local startBtn = GUI:Button_Create(FrameLayout, "startBtn", 666, 37, "res/custom/bt_dz.png")
	GUI:setContentSize(startBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(startBtn, false)
	GUI:Button_setTitleText(startBtn, [[开始屠魔]])
	GUI:Button_setTitleColor(startBtn, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn, 18)
	GUI:Button_titleEnableOutline(startBtn, "#000000", 1)
	GUI:setAnchorPoint(startBtn, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn, true)
	GUI:setTag(startBtn, 0)

	-- Create teamBtn
	local teamBtn = GUI:Button_Create(FrameLayout, "teamBtn", 528, 37, "res/custom/bt_dz.png")
	GUI:setContentSize(teamBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(teamBtn, false)
	GUI:Button_setTitleText(teamBtn, [[组队信息]])
	GUI:Button_setTitleColor(teamBtn, "#ffffff")
	GUI:Button_setTitleFontSize(teamBtn, 18)
	GUI:Button_titleEnableOutline(teamBtn, "#000000", 1)
	GUI:setAnchorPoint(teamBtn, 0.00, 0.00)
	GUI:setTouchEnabled(teamBtn, true)
	GUI:setTag(teamBtn, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 551, 151, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 643, 152, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(FrameLayout, "ItemShow_3", 736, 152, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create mask_layout
	local mask_layout = GUI:Layout_Create(parent, "mask_layout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(mask_layout, 0.00, 0.00)
	GUI:setTouchEnabled(mask_layout, true)
	GUI:setTag(mask_layout, 0)
	GUI:setVisible(mask_layout, false)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(mask_layout, "Image_1", 632, 62, "res/custom/npc/32tm/bg.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create rateBtn3
	local rateBtn3 = GUI:Button_Create(Image_1, "rateBtn3", 96, 330, "res/custom/npc/32tm/mj3b.png")
	GUI:setContentSize(rateBtn3, 146, 46)
	GUI:setIgnoreContentAdaptWithSize(rateBtn3, false)
	GUI:Button_setTitleText(rateBtn3, [[]])
	GUI:Button_setTitleColor(rateBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(rateBtn3, 16)
	GUI:Button_titleEnableOutline(rateBtn3, "#000000", 1)
	GUI:setAnchorPoint(rateBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(rateBtn3, true)
	GUI:setTag(rateBtn3, 0)

	-- Create rateBtn5
	local rateBtn5 = GUI:Button_Create(Image_1, "rateBtn5", 96, 280, "res/custom/npc/32tm/mj5b.png")
	GUI:setContentSize(rateBtn5, 146, 46)
	GUI:setIgnoreContentAdaptWithSize(rateBtn5, false)
	GUI:Button_setTitleText(rateBtn5, [[]])
	GUI:Button_setTitleColor(rateBtn5, "#ffffff")
	GUI:Button_setTitleFontSize(rateBtn5, 16)
	GUI:Button_titleEnableOutline(rateBtn5, "#000000", 1)
	GUI:setAnchorPoint(rateBtn5, 0.00, 0.00)
	GUI:setTouchEnabled(rateBtn5, true)
	GUI:setTag(rateBtn5, 0)

	-- Create rateBtn10
	local rateBtn10 = GUI:Button_Create(Image_1, "rateBtn10", 95, 230, "res/custom/npc/32tm/mj10b.png")
	GUI:setContentSize(rateBtn10, 146, 46)
	GUI:setIgnoreContentAdaptWithSize(rateBtn10, false)
	GUI:Button_setTitleText(rateBtn10, [[]])
	GUI:Button_setTitleColor(rateBtn10, "#ffffff")
	GUI:Button_setTitleFontSize(rateBtn10, 16)
	GUI:Button_titleEnableOutline(rateBtn10, "#000000", 1)
	GUI:setAnchorPoint(rateBtn10, 0.00, 0.00)
	GUI:setTouchEnabled(rateBtn10, true)
	GUI:setTag(rateBtn10, 0)

	-- Create rateBtn15
	local rateBtn15 = GUI:Button_Create(Image_1, "rateBtn15", 94, 180, "res/custom/npc/32tm/mj15b.png")
	GUI:setContentSize(rateBtn15, 146, 46)
	GUI:setIgnoreContentAdaptWithSize(rateBtn15, false)
	GUI:Button_setTitleText(rateBtn15, [[]])
	GUI:Button_setTitleColor(rateBtn15, "#ffffff")
	GUI:Button_setTitleFontSize(rateBtn15, 16)
	GUI:Button_titleEnableOutline(rateBtn15, "#000000", 1)
	GUI:setAnchorPoint(rateBtn15, 0.00, 0.00)
	GUI:setTouchEnabled(rateBtn15, true)
	GUI:setTag(rateBtn15, 0)

	-- Create rateBtn20
	local rateBtn20 = GUI:Button_Create(Image_1, "rateBtn20", 94, 130, "res/custom/npc/32tm/mj20b.png")
	GUI:setContentSize(rateBtn20, 146, 46)
	GUI:setIgnoreContentAdaptWithSize(rateBtn20, false)
	GUI:Button_setTitleText(rateBtn20, [[]])
	GUI:Button_setTitleColor(rateBtn20, "#ffffff")
	GUI:Button_setTitleFontSize(rateBtn20, 16)
	GUI:Button_titleEnableOutline(rateBtn20, "#000000", 1)
	GUI:setAnchorPoint(rateBtn20, 0.00, 0.00)
	GUI:setTouchEnabled(rateBtn20, true)
	GUI:setTag(rateBtn20, 0)

	-- Create rateBtn30
	local rateBtn30 = GUI:Button_Create(Image_1, "rateBtn30", 94, 80, "res/custom/npc/32tm/mj30b.png")
	GUI:setContentSize(rateBtn30, 146, 46)
	GUI:setIgnoreContentAdaptWithSize(rateBtn30, false)
	GUI:Button_setTitleText(rateBtn30, [[]])
	GUI:Button_setTitleColor(rateBtn30, "#ffffff")
	GUI:Button_setTitleFontSize(rateBtn30, 16)
	GUI:Button_titleEnableOutline(rateBtn30, "#000000", 1)
	GUI:setAnchorPoint(rateBtn30, 0.00, 0.00)
	GUI:setTouchEnabled(rateBtn30, true)
	GUI:setTag(rateBtn30, 0)

	-- Create rateBtn50
	local rateBtn50 = GUI:Button_Create(Image_1, "rateBtn50", 94, 30, "res/custom/npc/32tm/mj50b.png")
	GUI:setContentSize(rateBtn50, 146, 46)
	GUI:setIgnoreContentAdaptWithSize(rateBtn50, false)
	GUI:Button_setTitleText(rateBtn50, [[]])
	GUI:Button_setTitleColor(rateBtn50, "#ffffff")
	GUI:Button_setTitleFontSize(rateBtn50, 16)
	GUI:Button_titleEnableOutline(rateBtn50, "#000000", 1)
	GUI:setAnchorPoint(rateBtn50, 0.00, 0.00)
	GUI:setTouchEnabled(rateBtn50, true)
	GUI:setTag(rateBtn50, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
