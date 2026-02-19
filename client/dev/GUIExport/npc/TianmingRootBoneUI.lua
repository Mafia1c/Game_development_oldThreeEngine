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
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/49tmgg/bg1.png")
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

	-- Create AwakeningBtn
	local AwakeningBtn = GUI:Button_Create(FrameLayout, "AwakeningBtn", 642, 40, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(AwakeningBtn, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(AwakeningBtn, false)
	GUI:Button_setTitleText(AwakeningBtn, [[觉醒无双根骨]])
	GUI:Button_setTitleColor(AwakeningBtn, "#ffff00")
	GUI:Button_setTitleFontSize(AwakeningBtn, 16)
	GUI:Button_titleEnableOutline(AwakeningBtn, "#000000", 1)
	GUI:setAnchorPoint(AwakeningBtn, 0.00, 0.00)
	GUI:setTouchEnabled(AwakeningBtn, true)
	GUI:setTag(AwakeningBtn, 0)

	-- Create successRate
	local successRate = GUI:Text_Create(FrameLayout, "successRate", 642, 80, 18, "#ffffff", [[成功几率:  11%]])
	GUI:Text_enableOutline(successRate, "#000000", 1)
	GUI:setAnchorPoint(successRate, 0.00, 0.00)
	GUI:setTouchEnabled(successRate, false)
	GUI:setTag(successRate, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 442, 50, "res/custom/npc/49tmgg/tip1.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create needItem_1
	local needItem_1 = GUI:ItemShow_Create(FrameLayout, "needItem_1", 520, 70, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_1, 0.50, 0.50)
	GUI:setTag(needItem_1, 0)

	-- Create needItem_2
	local needItem_2 = GUI:ItemShow_Create(FrameLayout, "needItem_2", 584, 70, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_2, 0.50, 0.50)
	GUI:setTag(needItem_2, 0)

	-- Create titleTips_1
	local titleTips_1 = GUI:Text_Create(FrameLayout, "titleTips_1", 83, 44, 18, "#00ff00", [[觉醒全套
即可获得]])
	GUI:Text_enableOutline(titleTips_1, "#000000", 1)
	GUI:setAnchorPoint(titleTips_1, 0.00, 0.00)
	GUI:setTouchEnabled(titleTips_1, false)
	GUI:setTag(titleTips_1, 0)

	-- Create giveItem
	local giveItem = GUI:ItemShow_Create(FrameLayout, "giveItem", 198, 68, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(giveItem, 0.50, 0.50)
	GUI:setTag(giveItem, 0)

	-- Create titleTips_2
	local titleTips_2 = GUI:Text_Create(FrameLayout, "titleTips_2", 255, 44, 18, "#9b00ff", [[每激活一个根骨:
生命加成+2%]])
	GUI:Text_enableOutline(titleTips_2, "#000000", 1)
	GUI:setAnchorPoint(titleTips_2, 0.00, 0.00)
	GUI:setTouchEnabled(titleTips_2, false)
	GUI:setTag(titleTips_2, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 166, 180, "res/custom/npc/49tmgg/tip2.png")
	GUI:setContentSize(Image_2, 250, 240)
	GUI:setIgnoreContentAdaptWithSize(Image_2, false)
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(FrameLayout, "Image_3", 473, 179, "res/custom/npc/49tmgg/tip3.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create effNode
	local effNode = GUI:Node_Create(FrameLayout, "effNode", 436, 449)
	GUI:setTag(effNode, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 87, 398, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_1, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[头颅]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(FrameLayout, "Button_5", 87, 339, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_5, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[右臂]])
	GUI:Button_setTitleColor(Button_5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_5, 16)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create Button_6
	local Button_6 = GUI:Button_Create(FrameLayout, "Button_6", 87, 280, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_6, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_6, false)
	GUI:Button_setTitleText(Button_6, [[右手]])
	GUI:Button_setTitleColor(Button_6, "#ffffff")
	GUI:Button_setTitleFontSize(Button_6, 16)
	GUI:Button_titleEnableOutline(Button_6, "#000000", 1)
	GUI:setAnchorPoint(Button_6, 0.00, 0.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, 0)

	-- Create Button_9
	local Button_9 = GUI:Button_Create(FrameLayout, "Button_9", 87, 217, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_9, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_9, false)
	GUI:Button_setTitleText(Button_9, [[右腿]])
	GUI:Button_setTitleColor(Button_9, "#ffffff")
	GUI:Button_setTitleFontSize(Button_9, 16)
	GUI:Button_titleEnableOutline(Button_9, "#000000", 1)
	GUI:setAnchorPoint(Button_9, 0.00, 0.00)
	GUI:setTouchEnabled(Button_9, true)
	GUI:setTag(Button_9, 0)

	-- Create Button_10
	local Button_10 = GUI:Button_Create(FrameLayout, "Button_10", 87, 161, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_10, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_10, false)
	GUI:Button_setTitleText(Button_10, [[右脚]])
	GUI:Button_setTitleColor(Button_10, "#ffffff")
	GUI:Button_setTitleFontSize(Button_10, 16)
	GUI:Button_titleEnableOutline(Button_10, "#000000", 1)
	GUI:setAnchorPoint(Button_10, 0.00, 0.00)
	GUI:setTouchEnabled(Button_10, true)
	GUI:setTag(Button_10, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 657, 398, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_2, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[身子]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(FrameLayout, "Button_3", 657, 339, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_3, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[左臂]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(FrameLayout, "Button_4", 657, 280, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_4, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[左手]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Button_7
	local Button_7 = GUI:Button_Create(FrameLayout, "Button_7", 657, 217, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_7, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_7, false)
	GUI:Button_setTitleText(Button_7, [[左腿]])
	GUI:Button_setTitleColor(Button_7, "#ffffff")
	GUI:Button_setTitleFontSize(Button_7, 16)
	GUI:Button_titleEnableOutline(Button_7, "#000000", 1)
	GUI:setAnchorPoint(Button_7, 0.00, 0.00)
	GUI:setTouchEnabled(Button_7, true)
	GUI:setTag(Button_7, 0)

	-- Create Button_8
	local Button_8 = GUI:Button_Create(FrameLayout, "Button_8", 657, 161, "res/custom/npc/49tmgg/an.png")
	GUI:setContentSize(Button_8, 125, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_8, false)
	GUI:Button_setTitleText(Button_8, [[左脚]])
	GUI:Button_setTitleColor(Button_8, "#ffffff")
	GUI:Button_setTitleFontSize(Button_8, 16)
	GUI:Button_titleEnableOutline(Button_8, "#000000", 1)
	GUI:setAnchorPoint(Button_8, 0.00, 0.00)
	GUI:setTouchEnabled(Button_8, true)
	GUI:setTag(Button_8, 0)

	-- Create CheckBox_1
	local CheckBox_1 = GUI:CheckBox_Create(FrameLayout, "CheckBox_1", 294, 123, "res/public/1900000550.png", "res/public/1900000551.png")
	GUI:setContentSize(CheckBox_1, 29, 28)
	GUI:setIgnoreContentAdaptWithSize(CheckBox_1, false)
	GUI:CheckBox_setSelected(CheckBox_1, false)
	GUI:setAnchorPoint(CheckBox_1, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox_1, true)
	GUI:setTag(CheckBox_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 325, 124, 18, "#ffff00", [[勾选使用幸运符, 可增加10%的几率]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
