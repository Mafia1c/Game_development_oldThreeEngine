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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 367, 111, 466, 414, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/41zx/bg2.png")
	GUI:setContentSize(bg_Image, 466, 414)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 468, 373, "res/public/1900000510.png")
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

	-- Create ScrollView_1
	local ScrollView_1 = GUI:ScrollView_Create(FrameLayout, "ScrollView_1", 18, 20, 429, 340, 1)
	GUI:ScrollView_setInnerContainerSize(ScrollView_1, 429.00, 340.00)
	GUI:setAnchorPoint(ScrollView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ScrollView_1, true)
	GUI:setTag(ScrollView_1, 0)

	-- Create itemCell_1
	local itemCell_1 = GUI:Image_Create(ScrollView_1, "itemCell_1", 5, 172, "res/custom/npc/07zsmb/rq.png")
	GUI:setContentSize(itemCell_1, 133, 161)
	GUI:setIgnoreContentAdaptWithSize(itemCell_1, false)
	GUI:setAnchorPoint(itemCell_1, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_1, false)
	GUI:setTag(itemCell_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(itemCell_1, "ItemShow_1", 66, 93, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(itemCell_1, "Text_1", 66, 131, 16, "#00ffe8", [[风水秘术]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(itemCell_1, "Button_1", 66, 12, "res/custom/npc/07zsmb/bt2.png")
	GUI:setContentSize(Button_1, 104, 45)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[选择]])
	GUI:Button_setTitleColor(Button_1, "#ff9b00")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.50, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create itemCell_2
	local itemCell_2 = GUI:Image_Create(ScrollView_1, "itemCell_2", 148, 172, "res/custom/npc/07zsmb/rq.png")
	GUI:setContentSize(itemCell_2, 133, 161)
	GUI:setIgnoreContentAdaptWithSize(itemCell_2, false)
	GUI:setAnchorPoint(itemCell_2, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_2, false)
	GUI:setTag(itemCell_2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(itemCell_2, "ItemShow_2", 66, 93, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(itemCell_2, "Text_2", 66, 131, 16, "#ffffff", [[风水秘术]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(itemCell_2, "Button_2", 66, 12, "res/custom/npc/07zsmb/bt2.png")
	GUI:setContentSize(Button_2, 104, 45)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[选择]])
	GUI:Button_setTitleColor(Button_2, "#ff9b00")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.50, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create itemCell_3
	local itemCell_3 = GUI:Image_Create(ScrollView_1, "itemCell_3", 290, 172, "res/custom/npc/07zsmb/rq.png")
	GUI:setContentSize(itemCell_3, 133, 161)
	GUI:setIgnoreContentAdaptWithSize(itemCell_3, false)
	GUI:setAnchorPoint(itemCell_3, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_3, false)
	GUI:setTag(itemCell_3, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(itemCell_3, "ItemShow_3", 66, 93, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(itemCell_3, "Text_3", 66, 131, 16, "#ffffff", [[风水秘术]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.50, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(itemCell_3, "Button_3", 66, 12, "res/custom/npc/07zsmb/bt2.png")
	GUI:setContentSize(Button_3, 104, 45)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[选择]])
	GUI:Button_setTitleColor(Button_3, "#ff9b00")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.50, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create itemCell_4
	local itemCell_4 = GUI:Image_Create(ScrollView_1, "itemCell_4", 5, 7, "res/custom/npc/07zsmb/rq.png")
	GUI:setContentSize(itemCell_4, 133, 161)
	GUI:setIgnoreContentAdaptWithSize(itemCell_4, false)
	GUI:setAnchorPoint(itemCell_4, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_4, false)
	GUI:setTag(itemCell_4, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(itemCell_4, "ItemShow_4", 66, 93, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(itemCell_4, "Text_4", 66, 131, 16, "#ffffff", [[风水秘术]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.50, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(itemCell_4, "Button_4", 66, 12, "res/custom/npc/07zsmb/bt2.png")
	GUI:setContentSize(Button_4, 104, 45)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[选择]])
	GUI:Button_setTitleColor(Button_4, "#ff9b00")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.50, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create itemCell_5
	local itemCell_5 = GUI:Image_Create(ScrollView_1, "itemCell_5", 148, 7, "res/custom/npc/07zsmb/rq.png")
	GUI:setContentSize(itemCell_5, 133, 161)
	GUI:setIgnoreContentAdaptWithSize(itemCell_5, false)
	GUI:setAnchorPoint(itemCell_5, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_5, false)
	GUI:setTag(itemCell_5, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(itemCell_5, "ItemShow_5", 66, 93, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(itemCell_5, "Text_5", 66, 131, 16, "#ffffff", [[风水秘术]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.50, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(itemCell_5, "Button_5", 66, 12, "res/custom/npc/07zsmb/bt2.png")
	GUI:setContentSize(Button_5, 104, 45)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[选择]])
	GUI:Button_setTitleColor(Button_5, "#ff9b00")
	GUI:Button_setTitleFontSize(Button_5, 18)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.50, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create itemCell_6
	local itemCell_6 = GUI:Image_Create(ScrollView_1, "itemCell_6", 290, 7, "res/custom/npc/07zsmb/rq.png")
	GUI:setContentSize(itemCell_6, 133, 161)
	GUI:setIgnoreContentAdaptWithSize(itemCell_6, false)
	GUI:setAnchorPoint(itemCell_6, 0.00, 0.00)
	GUI:setTouchEnabled(itemCell_6, false)
	GUI:setTag(itemCell_6, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(itemCell_6, "ItemShow_6", 66, 93, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(itemCell_6, "Text_6", 66, 131, 16, "#ffffff", [[风水秘术]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.50, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create Button_6
	local Button_6 = GUI:Button_Create(itemCell_6, "Button_6", 66, 12, "res/custom/npc/07zsmb/bt2.png")
	GUI:setContentSize(Button_6, 104, 45)
	GUI:setIgnoreContentAdaptWithSize(Button_6, false)
	GUI:Button_setTitleText(Button_6, [[选择]])
	GUI:Button_setTitleColor(Button_6, "#ff9b00")
	GUI:Button_setTitleFontSize(Button_6, 18)
	GUI:Button_titleEnableOutline(Button_6, "#000000", 1)
	GUI:setAnchorPoint(Button_6, 0.50, 0.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
