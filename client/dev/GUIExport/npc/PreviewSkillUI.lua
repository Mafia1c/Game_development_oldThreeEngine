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
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 1390, 960, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/245jnzs/bg.png")
	GUI:setContentSize(bg_Image, 1390, 960)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, true)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 1175, 758, "res/public/1900000510.png")
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

	-- Create model_box
	local model_box = GUI:Layout_Create(FrameLayout, "model_box", 396, 397, 261, 323, false)
	GUI:setAnchorPoint(model_box, 0.00, 0.00)
	GUI:setTouchEnabled(model_box, false)
	GUI:setTag(model_box, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 414, 274, "res/private/create_hero/icon_cjzy_01.png")
	GUI:setContentSize(Button_1, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleDisableOutLine(Button_1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 475, 274, "res/private/create_hero/icon_cjzy_02.png")
	GUI:setContentSize(Button_2, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleDisableOutLine(Button_2)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(FrameLayout, "Button_3", 413, 223, "res/private/create_hero/icon_cjzy_03.png")
	GUI:setContentSize(Button_3, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleDisableOutLine(Button_3)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(FrameLayout, "Button_4", 474, 223, "res/private/create_hero/icon_cjzy_04.png")
	GUI:setContentSize(Button_4, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleDisableOutLine(Button_4)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create spine_box
	local spine_box = GUI:Layout_Create(FrameLayout, "spine_box", 715, 472, 304, 232, true)
	GUI:setAnchorPoint(spine_box, 0.00, 0.00)
	GUI:setTouchEnabled(spine_box, false)
	GUI:setTag(spine_box, 0)

	-- Create xuemai_bg
	local xuemai_bg = GUI:Image_Create(FrameLayout, "xuemai_bg", 715, 298, "res/public/bg_clhczy_01.jpg")
	GUI:Image_setScale9Slice(xuemai_bg, 73, 73, 148, 148)
	GUI:setContentSize(xuemai_bg, 304, 138)
	GUI:setIgnoreContentAdaptWithSize(xuemai_bg, false)
	GUI:setAnchorPoint(xuemai_bg, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg, false)
	GUI:setTag(xuemai_bg, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(xuemai_bg, "ItemShow_1", 30, 106, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create attr_box
	local attr_box = GUI:Layout_Create(xuemai_bg, "attr_box", -1, -1, 305, 140, false)
	GUI:setAnchorPoint(attr_box, 0.00, 0.00)
	GUI:setTouchEnabled(attr_box, false)
	GUI:setTag(attr_box, 0)

	-- Create xuemai_box1
	local xuemai_box1 = GUI:Image_Create(FrameLayout, "xuemai_box1", 703, 236, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box1, 0.00, 0.00)
	GUI:setScale(xuemai_box1, 0.70)
	GUI:setTouchEnabled(xuemai_box1, true)
	GUI:setTag(xuemai_box1, 0)

	-- Create xuemai_item1
	local xuemai_item1 = GUI:ItemShow_Create(xuemai_box1, "xuemai_item1", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item1, 0.50, 0.50)
	GUI:setTag(xuemai_item1, 0)

	-- Create xuemai_box2
	local xuemai_box2 = GUI:Image_Create(FrameLayout, "xuemai_box2", 758, 236, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box2, 0.00, 0.00)
	GUI:setScale(xuemai_box2, 0.70)
	GUI:setTouchEnabled(xuemai_box2, true)
	GUI:setTag(xuemai_box2, 0)

	-- Create xuemai_item2
	local xuemai_item2 = GUI:ItemShow_Create(xuemai_box2, "xuemai_item2", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item2, 0.50, 0.50)
	GUI:setTag(xuemai_item2, 0)

	-- Create xuemai_box3
	local xuemai_box3 = GUI:Image_Create(FrameLayout, "xuemai_box3", 813, 236, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box3, 0.00, 0.00)
	GUI:setScale(xuemai_box3, 0.70)
	GUI:setTouchEnabled(xuemai_box3, true)
	GUI:setTag(xuemai_box3, 0)

	-- Create xuemai_item3
	local xuemai_item3 = GUI:ItemShow_Create(xuemai_box3, "xuemai_item3", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item3, 0.50, 0.50)
	GUI:setTag(xuemai_item3, 0)

	-- Create xuemai_box4
	local xuemai_box4 = GUI:Image_Create(FrameLayout, "xuemai_box4", 868, 236, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box4, 0.00, 0.00)
	GUI:setScale(xuemai_box4, 0.70)
	GUI:setTouchEnabled(xuemai_box4, true)
	GUI:setTag(xuemai_box4, 0)

	-- Create xuemai_item4
	local xuemai_item4 = GUI:ItemShow_Create(xuemai_box4, "xuemai_item4", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item4, 0.50, 0.50)
	GUI:setTag(xuemai_item4, 0)

	-- Create xuemai_box5
	local xuemai_box5 = GUI:Image_Create(FrameLayout, "xuemai_box5", 923, 236, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box5, 0.00, 0.00)
	GUI:setScale(xuemai_box5, 0.70)
	GUI:setTouchEnabled(xuemai_box5, true)
	GUI:setTag(xuemai_box5, 0)

	-- Create xuemai_item5
	local xuemai_item5 = GUI:ItemShow_Create(xuemai_box5, "xuemai_item5", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item5, 0.50, 0.50)
	GUI:setTag(xuemai_item5, 0)

	-- Create xuemai_box6
	local xuemai_box6 = GUI:Image_Create(FrameLayout, "xuemai_box6", 978, 236, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box6, 0.00, 0.00)
	GUI:setScale(xuemai_box6, 0.70)
	GUI:setTouchEnabled(xuemai_box6, true)
	GUI:setTag(xuemai_box6, 0)

	-- Create xuemai_item6
	local xuemai_item6 = GUI:ItemShow_Create(xuemai_box6, "xuemai_item6", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item6, 0.50, 0.50)
	GUI:setTag(xuemai_item6, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(FrameLayout, "select_img", 709, 240, "res/custom/1900000678_1.png")
	GUI:setContentSize(select_img, 82, 83)
	GUI:setIgnoreContentAdaptWithSize(select_img, false)
	GUI:setAnchorPoint(select_img, 0.00, 0.00)
	GUI:setScale(select_img, 0.50)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)

	-- Create sex_btn5
	local sex_btn5 = GUI:Button_Create(FrameLayout, "sex_btn5", 604, 274, "res/private/create_hero/icon_cjzy_05.png")
	GUI:setContentSize(sex_btn5, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(sex_btn5, false)
	GUI:Button_setTitleText(sex_btn5, [[]])
	GUI:Button_setTitleColor(sex_btn5, "#ffffff")
	GUI:Button_setTitleFontSize(sex_btn5, 16)
	GUI:Button_titleDisableOutLine(sex_btn5)
	GUI:setAnchorPoint(sex_btn5, 0.00, 0.00)
	GUI:setTouchEnabled(sex_btn5, true)
	GUI:setTag(sex_btn5, 0)

	-- Create sex_btn6
	local sex_btn6 = GUI:Button_Create(FrameLayout, "sex_btn6", 604, 224, "res/private/create_hero/icon_cjzy_06.png")
	GUI:setContentSize(sex_btn6, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(sex_btn6, false)
	GUI:Button_setTitleText(sex_btn6, [[]])
	GUI:Button_setTitleColor(sex_btn6, "#ffffff")
	GUI:Button_setTitleFontSize(sex_btn6, 16)
	GUI:Button_titleDisableOutLine(sex_btn6)
	GUI:setAnchorPoint(sex_btn6, 0.00, 0.00)
	GUI:setTouchEnabled(sex_btn6, true)
	GUI:setTag(sex_btn6, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
