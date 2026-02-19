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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 770, 516, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/35jx/mb.png")
	GUI:Image_setScale9Slice(FrameBG, 77, 77, 172, 172)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 819, 480, "res/public/1900000510.png")
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

	-- Create btnList_1
	local btnList_1 = GUI:ListView_Create(FrameLayout, "btnList_1", 74, 42, 114, 440, 1)
	GUI:setAnchorPoint(btnList_1, 0.00, 0.00)
	GUI:setTouchEnabled(btnList_1, true)
	GUI:setTag(btnList_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(btnList_1, "Button_1", 0, 398, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_1, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[斗笠觉醒]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Button_1, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(btnList_1, "Button_2", 0, 356, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_2, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[勋章觉醒]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_2, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(btnList_1, "Button_3", 0, 314, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_3, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[兵符觉醒]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_3, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(btnList_1, "Button_4", 0, 272, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_4, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[盾牌觉醒]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_4, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 245, 417, "res/custom/npc/35jx/word_125.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(FrameLayout, "Image_3", 615, 417, "res/custom/npc/35jx/word_126.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(FrameLayout, "Image_4", 217, 308, "res/custom/npc/35jx/bg_hhzy_01_1.png")
	GUI:Image_setScale9Slice(Image_4, 13, 13, 11, 11)
	GUI:setContentSize(Image_4, 181, 113)
	GUI:setIgnoreContentAdaptWithSize(Image_4, false)
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(FrameLayout, "Image_5", 580, 308, "res/custom/npc/35jx/bg_hhzy_01_1.png")
	GUI:Image_setScale9Slice(Image_5, 13, 13, 11, 11)
	GUI:setContentSize(Image_5, 181, 113)
	GUI:setIgnoreContentAdaptWithSize(Image_5, false)
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(FrameLayout, "Image_6", 282, 204, "res/custom/npc/35jx/bg_tbqb_2.png")
	GUI:Image_setScale9Slice(Image_6, 40, 40, 42, 42)
	GUI:setContentSize(Image_6, 408, 95)
	GUI:setIgnoreContentAdaptWithSize(Image_6, false)
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create equipShow_1
	local equipShow_1 = GUI:ItemShow_Create(FrameLayout, "equipShow_1", 496, 349, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(equipShow_1, 0.50, 0.50)
	GUI:setTag(equipShow_1, 0)

	-- Create activationNode
	local activationNode = GUI:Node_Create(FrameLayout, "activationNode", 491, 252)
	GUI:setTag(activationNode, 0)

	-- Create activation_img_1
	local activation_img_1 = GUI:Image_Create(activationNode, "activation_img_1", -160, 0, "res/custom/npc/35jx/icon/0_1.png")
	GUI:setAnchorPoint(activation_img_1, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_1, true)
	GUI:setTag(activation_img_1, 0)

	-- Create activation_img_2
	local activation_img_2 = GUI:Image_Create(activationNode, "activation_img_2", -80, 0, "res/custom/npc/35jx/icon/0_2.png")
	GUI:setAnchorPoint(activation_img_2, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_2, true)
	GUI:setTag(activation_img_2, 0)

	-- Create activation_img_3
	local activation_img_3 = GUI:Image_Create(activationNode, "activation_img_3", 0, 0, "res/custom/npc/35jx/icon/0_3.png")
	GUI:setAnchorPoint(activation_img_3, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_3, true)
	GUI:setTag(activation_img_3, 0)

	-- Create activation_img_4
	local activation_img_4 = GUI:Image_Create(activationNode, "activation_img_4", 80, 0, "res/custom/npc/35jx/icon/0_4.png")
	GUI:setAnchorPoint(activation_img_4, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_4, true)
	GUI:setTag(activation_img_4, 0)

	-- Create activation_img_5
	local activation_img_5 = GUI:Image_Create(activationNode, "activation_img_5", 160, 0, "res/custom/npc/35jx/icon/0_5.png")
	GUI:setAnchorPoint(activation_img_5, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_5, true)
	GUI:setTag(activation_img_5, 0)

	-- Create text
	local text = GUI:RichText_Create(FrameLayout, "text", 339, 182, [[<font color='#ff0000' size='16' >提示:   </font><font color='#00ffe8' size='16' >特殊觉醒到一定等级可获得额外提升! </font>]], 320, 16, "#ffffff", 1)
	GUI:setAnchorPoint(text, 0.00, 0.00)
	GUI:setTag(text, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 456, 142, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 530, 142, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create startBtn
	local startBtn = GUI:Button_Create(FrameLayout, "startBtn", 442, 65, "res/public/1900000612.png")
	GUI:setContentSize(startBtn, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(startBtn, false)
	GUI:Button_setTitleText(startBtn, [[开始觉醒]])
	GUI:Button_setTitleColor(startBtn, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn, 18)
	GUI:Button_titleEnableOutline(startBtn, "#000000", 1)
	GUI:setAnchorPoint(startBtn, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn, true)
	GUI:setTag(startBtn, 0)

	-- Create left_txt
	local left_txt = GUI:Text_Create(FrameLayout, "left_txt", 299, 355, 18, "#ffffff", [[防御加成: 6%]])
	GUI:Text_enableOutline(left_txt, "#000000", 1)
	GUI:setAnchorPoint(left_txt, 0.50, 0.00)
	GUI:setTouchEnabled(left_txt, false)
	GUI:setTag(left_txt, 0)

	-- Create right_txt
	local right_txt = GUI:Text_Create(FrameLayout, "right_txt", 672, 355, 18, "#00ff00", [[防御加成: 7%]])
	GUI:Text_enableOutline(right_txt, "#000000", 1)
	GUI:setAnchorPoint(right_txt, 0.50, 0.00)
	GUI:setTouchEnabled(right_txt, false)
	GUI:setTag(right_txt, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
