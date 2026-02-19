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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 174, 51, 530, 492, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/29my/sz/bg.png")
	GUI:setContentSize(bg_Image, 530, 492)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 532, 449, "res/public/1900000510.png")
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

	-- Create challengeBtn
	local challengeBtn = GUI:Button_Create(FrameLayout, "challengeBtn", 363, 40, "res/custom/yeqian2.png")
	GUI:setContentSize(challengeBtn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(challengeBtn, false)
	GUI:Button_setTitleText(challengeBtn, [[挑战命运]])
	GUI:Button_setTitleColor(challengeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(challengeBtn, 18)
	GUI:Button_titleEnableOutline(challengeBtn, "#000000", 1)
	GUI:setAnchorPoint(challengeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(challengeBtn, true)
	GUI:setTag(challengeBtn, 0)

	-- Create point_1
	local point_1 = GUI:Node_Create(FrameLayout, "point_1", 110, 333)
	GUI:setTag(point_1, 0)

	-- Create pointBtn_1
	local pointBtn_1 = GUI:Button_Create(point_1, "pointBtn_1", -42, -20, "res/custom/npc/29my/sz/an1.png")
	GUI:setContentSize(pointBtn_1, 84, 40)
	GUI:setIgnoreContentAdaptWithSize(pointBtn_1, false)
	GUI:Button_setTitleText(pointBtn_1, [[]])
	GUI:Button_setTitleColor(pointBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(pointBtn_1, 16)
	GUI:Button_titleEnableOutline(pointBtn_1, "#000000", 1)
	GUI:setAnchorPoint(pointBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(pointBtn_1, true)
	GUI:setTag(pointBtn_1, 0)

	-- Create diceBg_1
	local diceBg_1 = GUI:Image_Create(point_1, "diceBg_1", -30, 25, "res/public/1900000651.png")
	GUI:setAnchorPoint(diceBg_1, 0.00, 0.00)
	GUI:setTouchEnabled(diceBg_1, false)
	GUI:setTag(diceBg_1, 0)

	-- Create dice_1
	local dice_1 = GUI:Image_Create(point_1, "dice_1", -25, 27, "res/custom/npc/29my/icon_sezi_01.png")
	GUI:setContentSize(dice_1, 50, 55)
	GUI:setIgnoreContentAdaptWithSize(dice_1, false)
	GUI:setAnchorPoint(dice_1, 0.00, 0.00)
	GUI:setTouchEnabled(dice_1, false)
	GUI:setTag(dice_1, 0)

	-- Create point_2
	local point_2 = GUI:Node_Create(FrameLayout, "point_2", 265, 333)
	GUI:setTag(point_2, 0)

	-- Create pointBtn_2
	local pointBtn_2 = GUI:Button_Create(point_2, "pointBtn_2", -42, -20, "res/custom/npc/29my/sz/an2.png")
	GUI:setContentSize(pointBtn_2, 84, 40)
	GUI:setIgnoreContentAdaptWithSize(pointBtn_2, false)
	GUI:Button_setTitleText(pointBtn_2, [[]])
	GUI:Button_setTitleColor(pointBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(pointBtn_2, 16)
	GUI:Button_titleEnableOutline(pointBtn_2, "#000000", 1)
	GUI:setAnchorPoint(pointBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(pointBtn_2, true)
	GUI:setTag(pointBtn_2, 0)

	-- Create diceBg_1
	diceBg_1 = GUI:Image_Create(point_2, "diceBg_1", -30, 25, "res/public/1900000651.png")
	GUI:setAnchorPoint(diceBg_1, 0.00, 0.00)
	GUI:setTouchEnabled(diceBg_1, false)
	GUI:setTag(diceBg_1, 0)

	-- Create dice_1
	dice_1 = GUI:Image_Create(point_2, "dice_1", -25, 27, "res/custom/npc/29my/icon_sezi_02.png")
	GUI:setContentSize(dice_1, 50, 55)
	GUI:setIgnoreContentAdaptWithSize(dice_1, false)
	GUI:setAnchorPoint(dice_1, 0.00, 0.00)
	GUI:setTouchEnabled(dice_1, false)
	GUI:setTag(dice_1, 0)

	-- Create point_3
	local point_3 = GUI:Node_Create(FrameLayout, "point_3", 425, 333)
	GUI:setTag(point_3, 0)

	-- Create pointBtn_3
	local pointBtn_3 = GUI:Button_Create(point_3, "pointBtn_3", -42, -20, "res/custom/npc/29my/sz/an3.png")
	GUI:setContentSize(pointBtn_3, 84, 40)
	GUI:setIgnoreContentAdaptWithSize(pointBtn_3, false)
	GUI:Button_setTitleText(pointBtn_3, [[]])
	GUI:Button_setTitleColor(pointBtn_3, "#ffffff")
	GUI:Button_setTitleFontSize(pointBtn_3, 16)
	GUI:Button_titleEnableOutline(pointBtn_3, "#000000", 1)
	GUI:setAnchorPoint(pointBtn_3, 0.00, 0.00)
	GUI:setTouchEnabled(pointBtn_3, true)
	GUI:setTag(pointBtn_3, 0)

	-- Create diceBg_1
	diceBg_1 = GUI:Image_Create(point_3, "diceBg_1", -30, 25, "res/public/1900000651.png")
	GUI:setAnchorPoint(diceBg_1, 0.00, 0.00)
	GUI:setTouchEnabled(diceBg_1, false)
	GUI:setTag(diceBg_1, 0)

	-- Create dice_1
	dice_1 = GUI:Image_Create(point_3, "dice_1", -25, 27, "res/custom/npc/29my/icon_sezi_03.png")
	GUI:setContentSize(dice_1, 50, 55)
	GUI:setIgnoreContentAdaptWithSize(dice_1, false)
	GUI:setAnchorPoint(dice_1, 0.00, 0.00)
	GUI:setTouchEnabled(dice_1, false)
	GUI:setTag(dice_1, 0)

	-- Create point_4
	local point_4 = GUI:Node_Create(FrameLayout, "point_4", 110, 200)
	GUI:setTag(point_4, 0)

	-- Create pointBtn_4
	local pointBtn_4 = GUI:Button_Create(point_4, "pointBtn_4", -42, -20, "res/custom/npc/29my/sz/an4.png")
	GUI:setContentSize(pointBtn_4, 84, 40)
	GUI:setIgnoreContentAdaptWithSize(pointBtn_4, false)
	GUI:Button_setTitleText(pointBtn_4, [[]])
	GUI:Button_setTitleColor(pointBtn_4, "#ffffff")
	GUI:Button_setTitleFontSize(pointBtn_4, 16)
	GUI:Button_titleEnableOutline(pointBtn_4, "#000000", 1)
	GUI:setAnchorPoint(pointBtn_4, 0.00, 0.00)
	GUI:setTouchEnabled(pointBtn_4, true)
	GUI:setTag(pointBtn_4, 0)

	-- Create diceBg_1
	diceBg_1 = GUI:Image_Create(point_4, "diceBg_1", -30, 25, "res/public/1900000651.png")
	GUI:setAnchorPoint(diceBg_1, 0.00, 0.00)
	GUI:setTouchEnabled(diceBg_1, false)
	GUI:setTag(diceBg_1, 0)

	-- Create dice_1
	dice_1 = GUI:Image_Create(point_4, "dice_1", -25, 27, "res/custom/npc/29my/icon_sezi_04.png")
	GUI:setContentSize(dice_1, 50, 55)
	GUI:setIgnoreContentAdaptWithSize(dice_1, false)
	GUI:setAnchorPoint(dice_1, 0.00, 0.00)
	GUI:setTouchEnabled(dice_1, false)
	GUI:setTag(dice_1, 0)

	-- Create point_5
	local point_5 = GUI:Node_Create(FrameLayout, "point_5", 265, 200)
	GUI:setTag(point_5, 0)

	-- Create pointBtn_5
	local pointBtn_5 = GUI:Button_Create(point_5, "pointBtn_5", -42, -20, "res/custom/npc/29my/sz/an5.png")
	GUI:setContentSize(pointBtn_5, 84, 40)
	GUI:setIgnoreContentAdaptWithSize(pointBtn_5, false)
	GUI:Button_setTitleText(pointBtn_5, [[]])
	GUI:Button_setTitleColor(pointBtn_5, "#ffffff")
	GUI:Button_setTitleFontSize(pointBtn_5, 16)
	GUI:Button_titleEnableOutline(pointBtn_5, "#000000", 1)
	GUI:setAnchorPoint(pointBtn_5, 0.00, 0.00)
	GUI:setTouchEnabled(pointBtn_5, true)
	GUI:setTag(pointBtn_5, 0)

	-- Create diceBg_1
	diceBg_1 = GUI:Image_Create(point_5, "diceBg_1", -30, 25, "res/public/1900000651.png")
	GUI:setAnchorPoint(diceBg_1, 0.00, 0.00)
	GUI:setTouchEnabled(diceBg_1, false)
	GUI:setTag(diceBg_1, 0)

	-- Create dice_1
	dice_1 = GUI:Image_Create(point_5, "dice_1", -25, 27, "res/custom/npc/29my/icon_sezi_05.png")
	GUI:setContentSize(dice_1, 50, 55)
	GUI:setIgnoreContentAdaptWithSize(dice_1, false)
	GUI:setAnchorPoint(dice_1, 0.00, 0.00)
	GUI:setTouchEnabled(dice_1, false)
	GUI:setTag(dice_1, 0)

	-- Create point_6
	local point_6 = GUI:Node_Create(FrameLayout, "point_6", 425, 200)
	GUI:setTag(point_6, 0)

	-- Create pointBtn_6
	local pointBtn_6 = GUI:Button_Create(point_6, "pointBtn_6", -42, -20, "res/custom/npc/29my/sz/an6.png")
	GUI:setContentSize(pointBtn_6, 84, 40)
	GUI:setIgnoreContentAdaptWithSize(pointBtn_6, false)
	GUI:Button_setTitleText(pointBtn_6, [[]])
	GUI:Button_setTitleColor(pointBtn_6, "#ffffff")
	GUI:Button_setTitleFontSize(pointBtn_6, 16)
	GUI:Button_titleEnableOutline(pointBtn_6, "#000000", 1)
	GUI:setAnchorPoint(pointBtn_6, 0.00, 0.00)
	GUI:setTouchEnabled(pointBtn_6, true)
	GUI:setTag(pointBtn_6, 0)

	-- Create diceBg_1
	diceBg_1 = GUI:Image_Create(point_6, "diceBg_1", -30, 25, "res/public/1900000651.png")
	GUI:setAnchorPoint(diceBg_1, 0.00, 0.00)
	GUI:setTouchEnabled(diceBg_1, false)
	GUI:setTag(diceBg_1, 0)

	-- Create dice_1
	dice_1 = GUI:Image_Create(point_6, "dice_1", -25, 27, "res/custom/npc/29my/icon_sezi_06.png")
	GUI:setContentSize(dice_1, 50, 55)
	GUI:setIgnoreContentAdaptWithSize(dice_1, false)
	GUI:setAnchorPoint(dice_1, 0.00, 0.00)
	GUI:setTouchEnabled(dice_1, false)
	GUI:setTag(dice_1, 0)

	-- Create view_level_txt
	local view_level_txt = GUI:Text_Create(FrameLayout, "view_level_txt", 30, 39, 18, "#ffff00", [[当前层数: 命运一关]])
	GUI:Text_enableOutline(view_level_txt, "#000000", 1)
	GUI:setAnchorPoint(view_level_txt, 0.00, 0.00)
	GUI:setTouchEnabled(view_level_txt, false)
	GUI:setTag(view_level_txt, 0)

	-- Create open_treasure_btn
	local open_treasure_btn = GUI:Button_Create(FrameLayout, "open_treasure_btn", 238, 40, "res/custom/yeqian2.png")
	GUI:setContentSize(open_treasure_btn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(open_treasure_btn, false)
	GUI:Button_setTitleText(open_treasure_btn, [[开启宝藏]])
	GUI:Button_setTitleColor(open_treasure_btn, "#ffffff")
	GUI:Button_setTitleFontSize(open_treasure_btn, 18)
	GUI:Button_titleEnableOutline(open_treasure_btn, "#000000", 1)
	GUI:setAnchorPoint(open_treasure_btn, 0.00, 0.00)
	GUI:setTouchEnabled(open_treasure_btn, true)
	GUI:setTag(open_treasure_btn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
