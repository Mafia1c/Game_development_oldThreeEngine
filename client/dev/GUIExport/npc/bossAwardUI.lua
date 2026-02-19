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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 76)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 553, 334, 846, 566, false)
	GUI:Layout_setBackGroundImage(FrameLayout, "res/custom/npc/37boss/mb.png")
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/37boss/mb.png")
	GUI:Image_setScale9Slice(FrameBG, 282, 282, 189, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 838, 504, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.50, 0.50)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	-- Create title
	local title = GUI:Image_Create(FrameLayout, "title", 460, 504, "res/custom/npc/37boss/xs_title.png")
	GUI:setAnchorPoint(title, 0.50, 0.50)
	GUI:setTouchEnabled(title, false)
	GUI:setTag(title, 0)

	-- Create leftList
	local leftList = GUI:ScrollView_Create(FrameLayout, "leftList", 76, 476, 114, 440, 1)
	GUI:ScrollView_setBounceEnabled(leftList, true)
	GUI:ScrollView_setInnerContainerSize(leftList, 114.00, 440.00)
	GUI:setAnchorPoint(leftList, 0.00, 1.00)
	GUI:setTouchEnabled(leftList, true)
	GUI:setTag(leftList, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(leftList, "Image_4", 0, 398, "res/custom/dayeqian2.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create midList
	local midList = GUI:ListView_Create(FrameLayout, "midList", 498, 296, 596, 360, 2)
	GUI:ListView_setBounceEnabled(midList, true)
	GUI:ListView_setGravity(midList, 3)
	GUI:setAnchorPoint(midList, 0.50, 0.50)
	GUI:setTouchEnabled(midList, true)
	GUI:setTag(midList, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(midList, "Image_1", 0, 0, "res/custom/npc/37boss/mb_2.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(Image_1, "Text_2", 134, 336, 18, "#ff0000", [[巨魔·仙境真君]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Image_1, "Image_2", 230, 288, "res/custom/npc/37boss/tag2.png")
	GUI:setAnchorPoint(Image_2, 0.50, 0.50)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(Image_1, "Effect_1", 150, 142, 2, 20273, 0, 0, 4, 1)
	GUI:setScale(Effect_1, 0.70)
	GUI:setTag(Effect_1, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(Image_1, "Text_3", 134, 48, 16, "#ffff00", [[前往：实木七层]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.50, 0.50)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(Image_1, "Text_4", 134, 24, 16, "#ffff00", [[调整巨兽副本]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.50, 0.50)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create awardBox
	local awardBox = GUI:ListView_Create(FrameLayout, "awardBox", 280, 70, 60, 60, 2)
	GUI:ListView_setClippingEnabled(awardBox, false)
	GUI:ListView_setGravity(awardBox, 3)
	GUI:ListView_setItemsMargin(awardBox, 8)
	GUI:setAnchorPoint(awardBox, 0.00, 0.50)
	GUI:setTouchEnabled(awardBox, true)
	GUI:setTag(awardBox, 0)

	-- Create suitBox
	local suitBox = GUI:ListView_Create(FrameLayout, "suitBox", 650, 70, 60, 60, 2)
	GUI:ListView_setClippingEnabled(suitBox, false)
	GUI:ListView_setGravity(suitBox, 3)
	GUI:ListView_setItemsMargin(suitBox, 12)
	GUI:setAnchorPoint(suitBox, 0.00, 0.50)
	GUI:setTouchEnabled(suitBox, true)
	GUI:setTag(suitBox, 0)

	-- Create rewardBtn_1
	local rewardBtn_1 = GUI:Button_Create(FrameLayout, "rewardBtn_1", 522, 70, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(rewardBtn_1, 11, 11, 14, 14)
	GUI:setContentSize(rewardBtn_1, 80, 36)
	GUI:setIgnoreContentAdaptWithSize(rewardBtn_1, false)
	GUI:Button_setTitleText(rewardBtn_1, [[领取奖励]])
	GUI:Button_setTitleColor(rewardBtn_1, "#e8dcbd")
	GUI:Button_setTitleFontSize(rewardBtn_1, 16)
	GUI:Button_titleEnableOutline(rewardBtn_1, "#000000", 1)
	GUI:setAnchorPoint(rewardBtn_1, 0.50, 0.50)
	GUI:setTouchEnabled(rewardBtn_1, true)
	GUI:setTag(rewardBtn_1, 0)

	-- Create rewardBtn
	local rewardBtn = GUI:Button_Create(FrameLayout, "rewardBtn", 760, 70, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(rewardBtn, 11, 11, 14, 14)
	GUI:setContentSize(rewardBtn, 80, 36)
	GUI:setIgnoreContentAdaptWithSize(rewardBtn, false)
	GUI:Button_setTitleText(rewardBtn, [[领取奖励]])
	GUI:Button_setTitleColor(rewardBtn, "#e8dcbd")
	GUI:Button_setTitleFontSize(rewardBtn, 16)
	GUI:Button_titleEnableOutline(rewardBtn, "#000000", 1)
	GUI:setAnchorPoint(rewardBtn, 0.50, 0.50)
	GUI:setTouchEnabled(rewardBtn, true)
	GUI:setTag(rewardBtn, 0)

	-- Create copyMapBox
	local copyMapBox = GUI:Image_Create(FrameLayout, "copyMapBox", 476, 280, "res/public/1900000600.png")
	GUI:setAnchorPoint(copyMapBox, 0.50, 0.50)
	GUI:setTouchEnabled(copyMapBox, true)
	GUI:setTag(copyMapBox, 0)
	GUI:setVisible(copyMapBox, false)

	-- Create mask
	local mask = GUI:Layout_Create(copyMapBox, "mask", 250, 100, 500, 200, false)
	GUI:setAnchorPoint(mask, 0.50, 0.50)
	GUI:setTouchEnabled(mask, true)
	GUI:setTag(mask, 0)

	-- Create copyText1
	local copyText1 = GUI:Text_Create(copyMapBox, "copyText1", 22, 136, 16, "#ffffff", [[是否确定前往“巨兽镜像副本”调整？]])
	GUI:Text_enableOutline(copyText1, "#000000", 1)
	GUI:setAnchorPoint(copyText1, 0.00, 0.00)
	GUI:setTouchEnabled(copyText1, false)
	GUI:setTag(copyText1, 0)

	-- Create copyText2
	local copyText2 = GUI:Text_Create(copyMapBox, "copyText2", 22, 116, 16, "#ffffff", [[挑战需要：巨兽挑战书×1]])
	GUI:Text_enableOutline(copyText2, "#000000", 1)
	GUI:setAnchorPoint(copyText2, 0.00, 0.00)
	GUI:setTouchEnabled(copyText2, false)
	GUI:setTag(copyText2, 0)

	-- Create copyBtn1
	local copyBtn1 = GUI:Button_Create(copyMapBox, "copyBtn1", 290, 40, "res/public/00000361.png")
	GUI:Button_loadTexturePressed(copyBtn1, "res/public/00000362.png")
	GUI:setContentSize(copyBtn1, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(copyBtn1, false)
	GUI:Button_setTitleText(copyBtn1, [[]])
	GUI:Button_setTitleColor(copyBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(copyBtn1, 16)
	GUI:Button_titleEnableOutline(copyBtn1, "#000000", 1)
	GUI:setAnchorPoint(copyBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(copyBtn1, true)
	GUI:setTag(copyBtn1, 0)

	-- Create copyBtn2
	local copyBtn2 = GUI:Button_Create(copyMapBox, "copyBtn2", 390, 40, "res/public/00000365.png")
	GUI:Button_loadTexturePressed(copyBtn2, "res/public/00000366.png")
	GUI:setContentSize(copyBtn2, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(copyBtn2, false)
	GUI:Button_setTitleText(copyBtn2, [[]])
	GUI:Button_setTitleColor(copyBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(copyBtn2, 16)
	GUI:Button_titleEnableOutline(copyBtn2, "#000000", 1)
	GUI:setAnchorPoint(copyBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(copyBtn2, true)
	GUI:setTag(copyBtn2, 0)

	-- Create rewardHasImg1
	local rewardHasImg1 = GUI:Image_Create(FrameLayout, "rewardHasImg1", 520, 68, "res/custom/tag/c18.png")
	GUI:setAnchorPoint(rewardHasImg1, 0.50, 0.50)
	GUI:setTouchEnabled(rewardHasImg1, false)
	GUI:setTag(rewardHasImg1, 0)

	-- Create rewardHasImg2
	local rewardHasImg2 = GUI:Image_Create(FrameLayout, "rewardHasImg2", 760, 68, "res/custom/tag/c18.png")
	GUI:setAnchorPoint(rewardHasImg2, 0.50, 0.50)
	GUI:setTouchEnabled(rewardHasImg2, false)
	GUI:setTag(rewardHasImg2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
