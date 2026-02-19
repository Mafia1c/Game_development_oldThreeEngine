local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 337, 102, 426, 414, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create layout
	local layout = GUI:Layout_Create(FrameLayout, "layout", 0, 0, 426, 414, true)
	GUI:setAnchorPoint(layout, 0.00, 0.00)
	GUI:setTouchEnabled(layout, false)
	GUI:setTag(layout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(layout, "bg_Image", 0, 0, "res/custom/npc/69mj/bg2.png")
	GUI:setContentSize(bg_Image, 426, 414)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create itemNode1
	local itemNode1 = GUI:Node_Create(layout, "itemNode1", -24, 436)
	GUI:setTag(itemNode1, 0)

	-- Create itemNode2
	local itemNode2 = GUI:Node_Create(layout, "itemNode2", 450, 436)
	GUI:setTag(itemNode2, 0)

	-- Create itemNode3
	local itemNode3 = GUI:Node_Create(layout, "itemNode3", -24, -22)
	GUI:setTag(itemNode3, 0)

	-- Create itemNode4
	local itemNode4 = GUI:Node_Create(layout, "itemNode4", 450, -22)
	GUI:setTag(itemNode4, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 461, 414, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 1.00, 1.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
