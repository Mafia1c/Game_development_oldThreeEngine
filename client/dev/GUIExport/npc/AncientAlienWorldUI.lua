local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 577, 324, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/86yj/bg1.png")
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 820, 486, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create btn_cell_1
	local btn_cell_1 = GUI:Button_Create(FrameLayout, "btn_cell_1", 73, 201, "res/custom/npc/86yj/an1.png")
	GUI:setContentSize(btn_cell_1, 240, 280)
	GUI:setIgnoreContentAdaptWithSize(btn_cell_1, false)
	GUI:Button_setTitleText(btn_cell_1, [[]])
	GUI:Button_setTitleColor(btn_cell_1, "#ffffff")
	GUI:Button_setTitleFontSize(btn_cell_1, 16)
	GUI:Button_titleEnableOutline(btn_cell_1, "#000000", 1)
	GUI:setAnchorPoint(btn_cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(btn_cell_1, true)
	GUI:setTag(btn_cell_1, 0)

	-- Create btn_cell_2
	local btn_cell_2 = GUI:Button_Create(FrameLayout, "btn_cell_2", 317, 201, "res/custom/npc/86yj/an2.png")
	GUI:setContentSize(btn_cell_2, 240, 280)
	GUI:setIgnoreContentAdaptWithSize(btn_cell_2, false)
	GUI:Button_setTitleText(btn_cell_2, [[]])
	GUI:Button_setTitleColor(btn_cell_2, "#ffffff")
	GUI:Button_setTitleFontSize(btn_cell_2, 16)
	GUI:Button_titleEnableOutline(btn_cell_2, "#000000", 1)
	GUI:setAnchorPoint(btn_cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(btn_cell_2, true)
	GUI:setTag(btn_cell_2, 0)

	-- Create btn_cell_3
	local btn_cell_3 = GUI:Button_Create(FrameLayout, "btn_cell_3", 563, 201, "res/custom/npc/86yj/an3.png")
	GUI:setContentSize(btn_cell_3, 240, 280)
	GUI:setIgnoreContentAdaptWithSize(btn_cell_3, false)
	GUI:Button_setTitleText(btn_cell_3, [[]])
	GUI:Button_setTitleColor(btn_cell_3, "#ffffff")
	GUI:Button_setTitleFontSize(btn_cell_3, 16)
	GUI:Button_titleEnableOutline(btn_cell_3, "#000000", 1)
	GUI:setAnchorPoint(btn_cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(btn_cell_3, true)
	GUI:setTag(btn_cell_3, 0)

	-- Create btn_cell_4
	local btn_cell_4 = GUI:Button_Create(FrameLayout, "btn_cell_4", 71, 37, "res/custom/npc/86yj/an4.png")
	GUI:setContentSize(btn_cell_4, 366, 154)
	GUI:setIgnoreContentAdaptWithSize(btn_cell_4, false)
	GUI:Button_setTitleText(btn_cell_4, [[]])
	GUI:Button_setTitleColor(btn_cell_4, "#ffffff")
	GUI:Button_setTitleFontSize(btn_cell_4, 16)
	GUI:Button_titleEnableOutline(btn_cell_4, "#000000", 1)
	GUI:setAnchorPoint(btn_cell_4, 0.00, 0.00)
	GUI:setTouchEnabled(btn_cell_4, true)
	GUI:setTag(btn_cell_4, 0)

	-- Create btn_cell_5
	local btn_cell_5 = GUI:Button_Create(FrameLayout, "btn_cell_5", 444, 37, "res/custom/npc/86yj/an5.png")
	GUI:setContentSize(btn_cell_5, 358, 154)
	GUI:setIgnoreContentAdaptWithSize(btn_cell_5, false)
	GUI:Button_setTitleText(btn_cell_5, [[]])
	GUI:Button_setTitleColor(btn_cell_5, "#ffffff")
	GUI:Button_setTitleFontSize(btn_cell_5, 16)
	GUI:Button_titleEnableOutline(btn_cell_5, "#000000", 1)
	GUI:setAnchorPoint(btn_cell_5, 0.00, 0.00)
	GUI:setTouchEnabled(btn_cell_5, true)
	GUI:setTag(btn_cell_5, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
