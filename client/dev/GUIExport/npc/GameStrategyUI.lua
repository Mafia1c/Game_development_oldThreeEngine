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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 174, 51, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/19gl/bg1.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create info_list
	local info_list = GUI:ScrollView_Create(FrameLayout, "info_list", 207, 480, 590, 435, 1)
	GUI:ScrollView_setBounceEnabled(info_list, true)
	GUI:ScrollView_setInnerContainerSize(info_list, 590.00, 4222.00)
	GUI:setAnchorPoint(info_list, 0.00, 1.00)
	GUI:setTouchEnabled(info_list, true)
	GUI:setTag(info_list, 0)

	-- Create img_value
	local img_value = GUI:Image_Create(info_list, "img_value", 0, 435, "res/custom/npc/19gl/banbenjs.png")
	GUI:setAnchorPoint(img_value, 0.00, 1.00)
	GUI:setTouchEnabled(img_value, false)
	GUI:setTag(img_value, 0)

	-- Create tujian_list
	local tujian_list = GUI:ListView_Create(FrameLayout, "tujian_list", 198, 480, 598, 434, 1)
	GUI:ListView_setBounceEnabled(tujian_list, true)
	GUI:ListView_setGravity(tujian_list, 2)
	GUI:setAnchorPoint(tujian_list, 0.00, 1.00)
	GUI:setTouchEnabled(tujian_list, true)
	GUI:setTag(tujian_list, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 820, 481, "res/public/1900000510.png")
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

	-- Create btn_list
	local btn_list = GUI:ScrollView_Create(FrameLayout, "btn_list", 75, 51, 114, 430, 1)
	GUI:ScrollView_setInnerContainerSize(btn_list, 114.00, 430.00)
	GUI:setAnchorPoint(btn_list, 0.00, 0.00)
	GUI:setTouchEnabled(btn_list, true)
	GUI:setTag(btn_list, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(btn_list, "Button_1", 0, 388, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_1, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[版本介绍]])
	GUI:Button_setTitleColor(Button_1, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Button_1, "Image_1", -7, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(btn_list, "Button_2", 0, 344, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_2, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[快速升级]])
	GUI:Button_setTitleColor(Button_2, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Button_2, "Image_2", -7, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(btn_list, "Button_3", 0, 300, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_3, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[起号推荐]])
	GUI:Button_setTitleColor(Button_3, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(Button_3, "Image_3", -7, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(btn_list, "Button_4", 0, 256, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_4, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[秘宝图鉴]])
	GUI:Button_setTitleColor(Button_4, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(Button_4, "Image_4", -7, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(btn_list, "Button_5", 0, 212, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_5, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[职业预览]])
	GUI:Button_setTitleColor(Button_5, "#ffffa7")
	GUI:Button_setTitleFontSize(Button_5, 18)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(Button_5, "Image_5", -7, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
