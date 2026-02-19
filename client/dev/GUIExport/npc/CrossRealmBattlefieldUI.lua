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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 770, 516, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/48kf/bg1.png")
	GUI:setContentSize(bg_Image, 770, 516)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(bg_Image, "closeBtn", 769, 480, "res/custom/closeBtn.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/1900000511.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create view_box
	local view_box = GUI:Layout_Create(bg_Image, "view_box", 19, 17, 727, 445, false)
	GUI:setAnchorPoint(view_box, 0.00, 0.00)
	GUI:setTouchEnabled(view_box, false)
	GUI:setTag(view_box, 0)

	-- Create ScrollView_1
	local ScrollView_1 = GUI:ScrollView_Create(view_box, "ScrollView_1", 0, 30, 727, 414, 1)
	GUI:ScrollView_setInnerContainerSize(ScrollView_1, 727.00, 445.00)
	GUI:setAnchorPoint(ScrollView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ScrollView_1, true)
	GUI:setTag(ScrollView_1, 0)

	-- Create btn1
	local btn1 = GUI:Button_Create(bg_Image, "btn1", -32, 321, "res/custom/npc/48kf/c_1_0.png")
	GUI:setContentSize(btn1, 32, 130)
	GUI:setIgnoreContentAdaptWithSize(btn1, false)
	GUI:Button_setTitleText(btn1, [[]])
	GUI:Button_setTitleColor(btn1, "#ffffff")
	GUI:Button_setTitleFontSize(btn1, 16)
	GUI:Button_titleEnableOutline(btn1, "#000000", 1)
	GUI:setAnchorPoint(btn1, 0.00, 0.00)
	GUI:setTouchEnabled(btn1, true)
	GUI:setTag(btn1, 0)

	-- Create btn2
	local btn2 = GUI:Button_Create(bg_Image, "btn2", -32, 179, "res/custom/npc/48kf/c_2_0.png")
	GUI:setContentSize(btn2, 32, 130)
	GUI:setIgnoreContentAdaptWithSize(btn2, false)
	GUI:Button_setTitleText(btn2, [[]])
	GUI:Button_setTitleColor(btn2, "#ffffff")
	GUI:Button_setTitleFontSize(btn2, 16)
	GUI:Button_titleEnableOutline(btn2, "#000000", 1)
	GUI:setAnchorPoint(btn2, 0.00, 0.00)
	GUI:setTouchEnabled(btn2, true)
	GUI:setTag(btn2, 0)

	-- Create btn3
	local btn3 = GUI:Button_Create(bg_Image, "btn3", -32, 36, "res/custom/npc/48kf/c_3_0.png")
	GUI:setContentSize(btn3, 32, 130)
	GUI:setIgnoreContentAdaptWithSize(btn3, false)
	GUI:Button_setTitleText(btn3, [[]])
	GUI:Button_setTitleColor(btn3, "#ffffff")
	GUI:Button_setTitleFontSize(btn3, 16)
	GUI:Button_titleEnableOutline(btn3, "#000000", 1)
	GUI:setAnchorPoint(btn3, 0.00, 0.00)
	GUI:setTouchEnabled(btn3, true)
	GUI:setTag(btn3, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
