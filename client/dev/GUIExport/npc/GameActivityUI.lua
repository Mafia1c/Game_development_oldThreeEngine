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
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/22hd/bg8.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 819, 481, "res/public/1900000510.png")
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
	GUI:Button_setTitleText(Button_1, [[天降财宝]])
	GUI:Button_setTitleColor(Button_1, "#f8e6c6")
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
	local Button_2 = GUI:Button_Create(btn_list, "Button_2", 0, 346, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_2, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[押镖之路]])
	GUI:Button_setTitleColor(Button_2, "#f8e6c6")
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
	local Button_3 = GUI:Button_Create(btn_list, "Button_3", 0, 304, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_3, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[财富广场]])
	GUI:Button_setTitleColor(Button_3, "#f8e6c6")
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
	local Button_4 = GUI:Button_Create(btn_list, "Button_4", 0, 262, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_4, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[行会争霸]])
	GUI:Button_setTitleColor(Button_4, "#f8e6c6")
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
	local Button_5 = GUI:Button_Create(btn_list, "Button_5", 0, 220, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_5, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[天下第一]])
	GUI:Button_setTitleColor(Button_5, "#f8e6c6")
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

	-- Create Button_6
	local Button_6 = GUI:Button_Create(btn_list, "Button_6", 0, 178, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_6, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_6, false)
	GUI:Button_setTitleText(Button_6, [[激情夺宝]])
	GUI:Button_setTitleColor(Button_6, "#f8e6c6")
	GUI:Button_setTitleFontSize(Button_6, 18)
	GUI:Button_titleEnableOutline(Button_6, "#000000", 1)
	GUI:setAnchorPoint(Button_6, 0.00, 0.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(Button_6, "Image_6", -7, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create Button_7
	local Button_7 = GUI:Button_Create(btn_list, "Button_7", 0, 136, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_7, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_7, false)
	GUI:Button_setTitleText(Button_7, [[乱斗之王]])
	GUI:Button_setTitleColor(Button_7, "#f8e6c6")
	GUI:Button_setTitleFontSize(Button_7, 18)
	GUI:Button_titleEnableOutline(Button_7, "#000000", 1)
	GUI:setAnchorPoint(Button_7, 0.00, 0.00)
	GUI:setTouchEnabled(Button_7, true)
	GUI:setTag(Button_7, 0)

	-- Create Image_7
	local Image_7 = GUI:Image_Create(Button_7, "Image_7", -7, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_7, 0.00, 0.00)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, 0)

	-- Create Button_8
	local Button_8 = GUI:Button_Create(btn_list, "Button_8", 0, 94, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_8, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_8, false)
	GUI:Button_setTitleText(Button_8, [[狂暴争霸]])
	GUI:Button_setTitleColor(Button_8, "#f8e6c6")
	GUI:Button_setTitleFontSize(Button_8, 18)
	GUI:Button_titleEnableOutline(Button_8, "#000000", 1)
	GUI:setAnchorPoint(Button_8, 0.00, 0.00)
	GUI:setTouchEnabled(Button_8, true)
	GUI:setTag(Button_8, 0)

	-- Create Image_8
	local Image_8 = GUI:Image_Create(Button_8, "Image_8", -7, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_8, 0.00, 0.00)
	GUI:setTouchEnabled(Image_8, false)
	GUI:setTag(Image_8, 0)

	-- Create rewardNode
	local rewardNode = GUI:Node_Create(FrameLayout, "rewardNode", 486, 189)
	GUI:setTag(rewardNode, 0)

	-- Create state_img
	local state_img = GUI:Image_Create(FrameLayout, "state_img", 690, 407, "res/custom/tag/0-0.png")
	GUI:setContentSize(state_img, 80, 53)
	GUI:setIgnoreContentAdaptWithSize(state_img, false)
	GUI:setAnchorPoint(state_img, 0.00, 0.00)
	GUI:setTouchEnabled(state_img, false)
	GUI:setTag(state_img, 0)

	-- Create enter_btn
	local enter_btn = GUI:Button_Create(FrameLayout, "enter_btn", 493, 85, "res/public/1900000662.png")
	GUI:setContentSize(enter_btn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(enter_btn, false)
	GUI:Button_setTitleText(enter_btn, [[立即前往]])
	GUI:Button_setTitleColor(enter_btn, "#ffffff")
	GUI:Button_setTitleFontSize(enter_btn, 18)
	GUI:Button_titleEnableOutline(enter_btn, "#000000", 1)
	GUI:setAnchorPoint(enter_btn, 0.50, 0.50)
	GUI:setTouchEnabled(enter_btn, true)
	GUI:setTag(enter_btn, 0)

	-- Create kb_die_num
	local kb_die_num = GUI:Text_Create(FrameLayout, "kb_die_num", 606, 357, 24, "#ffff00", [[99]])
	GUI:Text_enableOutline(kb_die_num, "#000000", 1)
	GUI:setAnchorPoint(kb_die_num, 0.00, 0.00)
	GUI:setTouchEnabled(kb_die_num, false)
	GUI:setTag(kb_die_num, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
