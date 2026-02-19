local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/23xm/bg.png")
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, 0)

	-- Create rightBox
	local rightBox = GUI:Layout_Create(FrameBG, "rightBox", 568, 248, 229, 408, false)
	GUI:setAnchorPoint(rightBox, 0.00, 0.50)
	GUI:setTouchEnabled(rightBox, false)
	GUI:setTag(rightBox, 0)

	-- Create rebuildButton
	local rebuildButton = GUI:Button_Create(rightBox, "rebuildButton", 76, 65, "res/public/1900000679.png")
	GUI:setContentSize(rebuildButton, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(rebuildButton, false)
	GUI:Button_setTitleText(rebuildButton, [[重修天赋]])
	GUI:Button_setTitleColor(rebuildButton, "#ffffff")
	GUI:Button_setTitleFontSize(rebuildButton, 16)
	GUI:Button_titleEnableOutline(rebuildButton, "#000000", 1)
	GUI:setAnchorPoint(rebuildButton, 0.00, 0.00)
	GUI:setTouchEnabled(rebuildButton, true)
	GUI:setTag(rebuildButton, 0)

	-- Create rebuildText_1
	local rebuildText_1 = GUI:Text_Create(rightBox, "rebuildText_1", 36, 31, 16, "#ffff00", [[每个角色拥有5次重修]])
	GUI:Text_enableOutline(rebuildText_1, "#000000", 1)
	GUI:setAnchorPoint(rebuildText_1, 0.00, 0.00)
	GUI:setTouchEnabled(rebuildText_1, false)
	GUI:setTag(rebuildText_1, 0)

	-- Create rebuildText
	local rebuildText = GUI:Text_Create(rightBox, "rebuildText", 21, 4, 16, "#ffff00", [[终身特权每日免费3次重修]])
	GUI:Text_enableOutline(rebuildText, "#000000", 1)
	GUI:setAnchorPoint(rebuildText, 0.00, 0.00)
	GUI:setTouchEnabled(rebuildText, false)
	GUI:setTag(rebuildText, 0)

	-- Create rightInfoBox
	local rightInfoBox = GUI:Layout_Create(rightBox, "rightInfoBox", 1, 135, 228, 271, false)
	GUI:setAnchorPoint(rightInfoBox, 0.00, 0.00)
	GUI:setTouchEnabled(rightInfoBox, false)
	GUI:setTag(rightInfoBox, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(rightInfoBox, "Text_1", 76, 205, 16, "#ffffff", [[当前层数：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create ItemShow
	local ItemShow = GUI:ItemShow_Create(rightInfoBox, "ItemShow", 4, 202, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.00, 0.00)
	GUI:setTag(ItemShow, -1)

	-- Create selectTipText
	local selectTipText = GUI:Text_Create(rightBox, "selectTipText", 75, 262, 16, "#00ff00", [[未选择天赋]])
	GUI:Text_enableOutline(selectTipText, "#000000", 1)
	GUI:setAnchorPoint(selectTipText, 0.00, 0.00)
	GUI:setTouchEnabled(selectTipText, false)
	GUI:setTag(selectTipText, 0)

	-- Create leftDownBox
	local leftDownBox = GUI:Layout_Create(FrameBG, "leftDownBox", 75, 35, 485, 66, false)
	GUI:setAnchorPoint(leftDownBox, 0.00, 0.00)
	GUI:setTouchEnabled(leftDownBox, false)
	GUI:setTag(leftDownBox, 0)

	-- Create activateButton
	local activateButton = GUI:Button_Create(leftDownBox, "activateButton", 192, 13, "res/custom/npc/23xm/an4.png")
	GUI:setContentSize(activateButton, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(activateButton, false)
	GUI:Button_setTitleText(activateButton, [[]])
	GUI:Button_setTitleColor(activateButton, "#ffffff")
	GUI:Button_setTitleFontSize(activateButton, 16)
	GUI:Button_titleEnableOutline(activateButton, "#000000", 1)
	GUI:setAnchorPoint(activateButton, 0.00, 0.00)
	GUI:setTouchEnabled(activateButton, true)
	GUI:setTag(activateButton, 0)

	-- Create activateNumText
	local activateNumText = GUI:Text_Create(leftDownBox, "activateNumText", 313, 14, 16, "#00ee00", [[当前可激活次数：0次]])
	GUI:Text_disableOutLine(activateNumText)
	GUI:setAnchorPoint(activateNumText, 0.00, 0.00)
	GUI:setTouchEnabled(activateNumText, false)
	GUI:setTag(activateNumText, 0)

	-- Create tip_btn
	local tip_btn = GUI:Button_Create(leftDownBox, "tip_btn", 8, 16, "res/custom/npc/23xm/wenhao.png")
	GUI:setContentSize(tip_btn, 34, 34)
	GUI:setIgnoreContentAdaptWithSize(tip_btn, false)
	GUI:Button_setTitleText(tip_btn, [[]])
	GUI:Button_setTitleColor(tip_btn, "#ffffff")
	GUI:Button_setTitleFontSize(tip_btn, 16)
	GUI:Button_titleEnableOutline(tip_btn, "#000000", 1)
	GUI:setAnchorPoint(tip_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tip_btn, true)
	GUI:setTag(tip_btn, 0)

	-- Create tujian_btn
	local tujian_btn = GUI:Text_Create(leftDownBox, "tujian_btn", 80, 16, 18, "#00ff00", [[血脉图鉴]])
	GUI:Text_enableOutline(tujian_btn, "#000000", 1)
	GUI:Text_enableUnderline(tujian_btn)
	GUI:setAnchorPoint(tujian_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tujian_btn, true)
	GUI:setTag(tujian_btn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameBG, "Image_1", 93, 184, "res/custom/npc/23xm/k1.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameBG, "Image_2", 74, 101, "res/custom/npc/23xm/k2.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create itemBox1_1
	local itemBox1_1 = GUI:Image_Create(FrameBG, "itemBox1_1", 93, 407, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_1, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_1, false)
	GUI:setTag(itemBox1_1, 0)

	-- Create itemBoxlock1
	local itemBoxlock1 = GUI:Image_Create(itemBox1_1, "itemBoxlock1", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock1, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock1, false)
	GUI:setTag(itemBoxlock1, 0)

	-- Create itemBox1_2
	local itemBox1_2 = GUI:Image_Create(FrameBG, "itemBox1_2", 93, 350, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_2, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_2, false)
	GUI:setTag(itemBox1_2, 0)

	-- Create itemBoxlock2
	local itemBoxlock2 = GUI:Image_Create(itemBox1_2, "itemBoxlock2", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock2, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock2, false)
	GUI:setTag(itemBoxlock2, 0)

	-- Create itemBox1_3
	local itemBox1_3 = GUI:Image_Create(FrameBG, "itemBox1_3", 93, 295, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_3, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_3, false)
	GUI:setTag(itemBox1_3, 0)

	-- Create itemBoxlock3
	local itemBoxlock3 = GUI:Image_Create(itemBox1_3, "itemBoxlock3", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock3, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock3, false)
	GUI:setTag(itemBoxlock3, 0)

	-- Create itemBox1_4
	local itemBox1_4 = GUI:Image_Create(FrameBG, "itemBox1_4", 93, 239, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_4, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_4, false)
	GUI:setTag(itemBox1_4, 0)

	-- Create itemBoxlock4
	local itemBoxlock4 = GUI:Image_Create(itemBox1_4, "itemBoxlock4", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock4, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock4, false)
	GUI:setTag(itemBoxlock4, 0)

	-- Create itemBox1_5
	local itemBox1_5 = GUI:Image_Create(FrameBG, "itemBox1_5", 93, 184, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_5, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_5, false)
	GUI:setTag(itemBox1_5, 0)

	-- Create itemBoxlock5
	local itemBoxlock5 = GUI:Image_Create(itemBox1_5, "itemBoxlock5", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock5, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock5, false)
	GUI:setTag(itemBoxlock5, 0)

	-- Create itemBox1_6
	local itemBox1_6 = GUI:Image_Create(FrameBG, "itemBox1_6", 174, 407, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_6, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_6, false)
	GUI:setTag(itemBox1_6, 0)

	-- Create itemBoxlock6
	local itemBoxlock6 = GUI:Image_Create(itemBox1_6, "itemBoxlock6", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock6, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock6, false)
	GUI:setTag(itemBoxlock6, 0)

	-- Create itemBox1_7
	local itemBox1_7 = GUI:Image_Create(FrameBG, "itemBox1_7", 174, 350, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_7, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_7, false)
	GUI:setTag(itemBox1_7, 0)

	-- Create itemBoxlock7
	local itemBoxlock7 = GUI:Image_Create(itemBox1_7, "itemBoxlock7", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock7, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock7, false)
	GUI:setTag(itemBoxlock7, 0)

	-- Create itemBox1_8
	local itemBox1_8 = GUI:Image_Create(FrameBG, "itemBox1_8", 174, 295, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_8, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_8, false)
	GUI:setTag(itemBox1_8, 0)

	-- Create itemBoxlock8
	local itemBoxlock8 = GUI:Image_Create(itemBox1_8, "itemBoxlock8", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock8, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock8, false)
	GUI:setTag(itemBoxlock8, 0)

	-- Create itemBox1_9
	local itemBox1_9 = GUI:Image_Create(FrameBG, "itemBox1_9", 174, 239, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_9, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_9, false)
	GUI:setTag(itemBox1_9, 0)

	-- Create itemBoxlock9
	local itemBoxlock9 = GUI:Image_Create(itemBox1_9, "itemBoxlock9", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock9, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock9, false)
	GUI:setTag(itemBoxlock9, 0)

	-- Create itemBox1_10
	local itemBox1_10 = GUI:Image_Create(FrameBG, "itemBox1_10", 174, 184, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_10, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_10, false)
	GUI:setTag(itemBox1_10, 0)

	-- Create itemBoxlock10
	local itemBoxlock10 = GUI:Image_Create(itemBox1_10, "itemBoxlock10", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock10, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock10, false)
	GUI:setTag(itemBoxlock10, 0)

	-- Create itemBox1_11
	local itemBox1_11 = GUI:Image_Create(FrameBG, "itemBox1_11", 255, 407, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_11, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_11, false)
	GUI:setTag(itemBox1_11, 0)

	-- Create itemBoxlock11
	local itemBoxlock11 = GUI:Image_Create(itemBox1_11, "itemBoxlock11", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock11, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock11, false)
	GUI:setTag(itemBoxlock11, 0)

	-- Create itemBox1_12
	local itemBox1_12 = GUI:Image_Create(FrameBG, "itemBox1_12", 255, 350, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_12, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_12, false)
	GUI:setTag(itemBox1_12, 0)

	-- Create itemBoxlock12
	local itemBoxlock12 = GUI:Image_Create(itemBox1_12, "itemBoxlock12", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock12, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock12, false)
	GUI:setTag(itemBoxlock12, 0)

	-- Create itemBox1_13
	local itemBox1_13 = GUI:Image_Create(FrameBG, "itemBox1_13", 255, 295, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_13, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_13, false)
	GUI:setTag(itemBox1_13, 0)

	-- Create itemBoxlock13
	local itemBoxlock13 = GUI:Image_Create(itemBox1_13, "itemBoxlock13", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock13, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock13, false)
	GUI:setTag(itemBoxlock13, 0)

	-- Create itemBox1_14
	local itemBox1_14 = GUI:Image_Create(FrameBG, "itemBox1_14", 255, 239, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_14, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_14, false)
	GUI:setTag(itemBox1_14, 0)

	-- Create itemBoxlock14
	local itemBoxlock14 = GUI:Image_Create(itemBox1_14, "itemBoxlock14", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock14, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock14, false)
	GUI:setTag(itemBoxlock14, 0)

	-- Create itemBox1_15
	local itemBox1_15 = GUI:Image_Create(FrameBG, "itemBox1_15", 255, 184, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_15, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_15, false)
	GUI:setTag(itemBox1_15, 0)

	-- Create itemBoxlock15
	local itemBoxlock15 = GUI:Image_Create(itemBox1_15, "itemBoxlock15", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock15, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock15, false)
	GUI:setTag(itemBoxlock15, 0)

	-- Create itemBox1_16
	local itemBox1_16 = GUI:Image_Create(FrameBG, "itemBox1_16", 337, 407, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_16, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_16, false)
	GUI:setTag(itemBox1_16, 0)

	-- Create itemBoxlock16
	local itemBoxlock16 = GUI:Image_Create(itemBox1_16, "itemBoxlock16", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock16, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock16, false)
	GUI:setTag(itemBoxlock16, 0)

	-- Create itemBox1_17
	local itemBox1_17 = GUI:Image_Create(FrameBG, "itemBox1_17", 337, 350, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_17, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_17, false)
	GUI:setTag(itemBox1_17, 0)

	-- Create itemBoxlock17
	local itemBoxlock17 = GUI:Image_Create(itemBox1_17, "itemBoxlock17", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock17, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock17, false)
	GUI:setTag(itemBoxlock17, 0)

	-- Create itemBox1_18
	local itemBox1_18 = GUI:Image_Create(FrameBG, "itemBox1_18", 337, 295, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_18, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_18, false)
	GUI:setTag(itemBox1_18, 0)

	-- Create itemBoxlock18
	local itemBoxlock18 = GUI:Image_Create(itemBox1_18, "itemBoxlock18", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock18, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock18, false)
	GUI:setTag(itemBoxlock18, 0)

	-- Create itemBox1_19
	local itemBox1_19 = GUI:Image_Create(FrameBG, "itemBox1_19", 337, 239, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_19, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_19, false)
	GUI:setTag(itemBox1_19, 0)

	-- Create itemBoxlock19
	local itemBoxlock19 = GUI:Image_Create(itemBox1_19, "itemBoxlock19", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock19, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock19, false)
	GUI:setTag(itemBoxlock19, 0)

	-- Create itemBox1_20
	local itemBox1_20 = GUI:Image_Create(FrameBG, "itemBox1_20", 337, 184, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_20, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_20, false)
	GUI:setTag(itemBox1_20, 0)

	-- Create itemBoxlock20
	local itemBoxlock20 = GUI:Image_Create(itemBox1_20, "itemBoxlock20", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock20, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock20, false)
	GUI:setTag(itemBoxlock20, 0)

	-- Create itemBox1_21
	local itemBox1_21 = GUI:Image_Create(FrameBG, "itemBox1_21", 418, 407, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_21, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_21, false)
	GUI:setTag(itemBox1_21, 0)

	-- Create itemBoxlock21
	local itemBoxlock21 = GUI:Image_Create(itemBox1_21, "itemBoxlock21", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock21, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock21, false)
	GUI:setTag(itemBoxlock21, 0)

	-- Create itemBox1_22
	local itemBox1_22 = GUI:Image_Create(FrameBG, "itemBox1_22", 418, 350, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_22, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_22, false)
	GUI:setTag(itemBox1_22, 0)

	-- Create itemBoxlock22
	local itemBoxlock22 = GUI:Image_Create(itemBox1_22, "itemBoxlock22", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock22, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock22, false)
	GUI:setTag(itemBoxlock22, 0)

	-- Create itemBox1_23
	local itemBox1_23 = GUI:Image_Create(FrameBG, "itemBox1_23", 418, 295, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_23, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_23, false)
	GUI:setTag(itemBox1_23, 0)

	-- Create itemBoxlock23
	local itemBoxlock23 = GUI:Image_Create(itemBox1_23, "itemBoxlock23", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock23, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock23, false)
	GUI:setTag(itemBoxlock23, 0)

	-- Create itemBox1_24
	local itemBox1_24 = GUI:Image_Create(FrameBG, "itemBox1_24", 418, 239, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_24, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_24, false)
	GUI:setTag(itemBox1_24, 0)

	-- Create itemBoxlock24
	local itemBoxlock24 = GUI:Image_Create(itemBox1_24, "itemBoxlock24", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock24, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock24, false)
	GUI:setTag(itemBoxlock24, 0)

	-- Create itemBox1_25
	local itemBox1_25 = GUI:Image_Create(FrameBG, "itemBox1_25", 418, 184, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_25, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_25, false)
	GUI:setTag(itemBox1_25, 0)

	-- Create itemBoxlock25
	local itemBoxlock25 = GUI:Image_Create(itemBox1_25, "itemBoxlock25", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock25, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock25, false)
	GUI:setTag(itemBoxlock25, 0)

	-- Create itemBox1_26
	local itemBox1_26 = GUI:Image_Create(FrameBG, "itemBox1_26", 499, 407, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_26, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_26, false)
	GUI:setTag(itemBox1_26, 0)

	-- Create itemBoxlock26
	local itemBoxlock26 = GUI:Image_Create(itemBox1_26, "itemBoxlock26", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock26, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock26, false)
	GUI:setTag(itemBoxlock26, 0)

	-- Create itemBox1_27
	local itemBox1_27 = GUI:Image_Create(FrameBG, "itemBox1_27", 499, 350, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_27, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_27, false)
	GUI:setTag(itemBox1_27, 0)

	-- Create itemBoxlock27
	local itemBoxlock27 = GUI:Image_Create(itemBox1_27, "itemBoxlock27", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock27, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock27, false)
	GUI:setTag(itemBoxlock27, 0)

	-- Create itemBox1_28
	local itemBox1_28 = GUI:Image_Create(FrameBG, "itemBox1_28", 499, 295, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_28, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_28, false)
	GUI:setTag(itemBox1_28, 0)

	-- Create itemBoxlock28
	local itemBoxlock28 = GUI:Image_Create(itemBox1_28, "itemBoxlock28", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock28, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock28, false)
	GUI:setTag(itemBoxlock28, 0)

	-- Create itemBox1_29
	local itemBox1_29 = GUI:Image_Create(FrameBG, "itemBox1_29", 499, 239, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_29, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_29, false)
	GUI:setTag(itemBox1_29, 0)

	-- Create itemBoxlock29
	local itemBoxlock29 = GUI:Image_Create(itemBox1_29, "itemBoxlock29", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock29, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock29, false)
	GUI:setTag(itemBoxlock29, 0)

	-- Create itemBox1_30
	local itemBox1_30 = GUI:Image_Create(FrameBG, "itemBox1_30", 499, 184, "res/custom/npc/23xm/k3.png")
	GUI:setAnchorPoint(itemBox1_30, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1_30, false)
	GUI:setTag(itemBox1_30, 0)

	-- Create itemBoxlock30
	local itemBoxlock30 = GUI:Image_Create(itemBox1_30, "itemBoxlock30", -2, 1, "res/custom/npc/23xm/s3.png")
	GUI:setAnchorPoint(itemBoxlock30, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock30, false)
	GUI:setTag(itemBoxlock30, 0)

	-- Create itemBox2_1
	local itemBox2_1 = GUI:Image_Create(FrameBG, "itemBox2_1", 74, 101, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(itemBox2_1, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox2_1, false)
	GUI:setTag(itemBox2_1, 0)

	-- Create itemBoxlock2_1
	local itemBoxlock2_1 = GUI:Image_Create(itemBox2_1, "itemBoxlock2_1", 8, 4, "res/custom/npc/23xm/s1.png")
	GUI:setAnchorPoint(itemBoxlock2_1, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock2_1, false)
	GUI:setTag(itemBoxlock2_1, 0)

	-- Create itemBox2_2
	local itemBox2_2 = GUI:Image_Create(FrameBG, "itemBox2_2", 155, 102, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(itemBox2_2, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox2_2, false)
	GUI:setTag(itemBox2_2, 0)

	-- Create itemBoxlock2_2
	local itemBoxlock2_2 = GUI:Image_Create(itemBox2_2, "itemBoxlock2_2", 8, 4, "res/custom/npc/23xm/s1.png")
	GUI:setAnchorPoint(itemBoxlock2_2, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock2_2, false)
	GUI:setTag(itemBoxlock2_2, 0)

	-- Create itemBox2_3
	local itemBox2_3 = GUI:Image_Create(FrameBG, "itemBox2_3", 236, 101, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(itemBox2_3, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox2_3, false)
	GUI:setTag(itemBox2_3, 0)

	-- Create itemBoxlock2_3
	local itemBoxlock2_3 = GUI:Image_Create(itemBox2_3, "itemBoxlock2_3", 8, 4, "res/custom/npc/23xm/s1.png")
	GUI:setAnchorPoint(itemBoxlock2_3, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock2_3, false)
	GUI:setTag(itemBoxlock2_3, 0)

	-- Create itemBox2_4
	local itemBox2_4 = GUI:Image_Create(FrameBG, "itemBox2_4", 318, 101, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(itemBox2_4, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox2_4, false)
	GUI:setTag(itemBox2_4, 0)

	-- Create itemBoxlock2_4
	local itemBoxlock2_4 = GUI:Image_Create(itemBox2_4, "itemBoxlock2_4", 8, 4, "res/custom/npc/23xm/s1.png")
	GUI:setAnchorPoint(itemBoxlock2_4, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock2_4, false)
	GUI:setTag(itemBoxlock2_4, 0)

	-- Create itemBox2_5
	local itemBox2_5 = GUI:Image_Create(FrameBG, "itemBox2_5", 399, 101, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(itemBox2_5, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox2_5, false)
	GUI:setTag(itemBox2_5, 0)

	-- Create itemBoxlock2_5
	local itemBoxlock2_5 = GUI:Image_Create(itemBox2_5, "itemBoxlock2_5", 8, 4, "res/custom/npc/23xm/s1.png")
	GUI:setAnchorPoint(itemBoxlock2_5, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock2_5, false)
	GUI:setTag(itemBoxlock2_5, 0)

	-- Create itemBox2_6
	local itemBox2_6 = GUI:Image_Create(FrameBG, "itemBox2_6", 480, 101, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(itemBox2_6, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox2_6, false)
	GUI:setTag(itemBox2_6, 0)

	-- Create itemBoxlock2_6
	local itemBoxlock2_6 = GUI:Image_Create(itemBox2_6, "itemBoxlock2_6", 8, 4, "res/custom/npc/23xm/s1.png")
	GUI:setAnchorPoint(itemBoxlock2_6, 0.00, 0.00)
	GUI:setTouchEnabled(itemBoxlock2_6, false)
	GUI:setTag(itemBoxlock2_6, 0)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 820, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 16)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.00, 0.00)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, 0)

	-- Create xuemai_btn
	local xuemai_btn = GUI:Button_Create(FrameLayout, "xuemai_btn", 10, 249, "res/custom/npc/52wsxm/xuemai1.png")
	GUI:setContentSize(xuemai_btn, 48, 130)
	GUI:setIgnoreContentAdaptWithSize(xuemai_btn, false)
	GUI:Button_setTitleText(xuemai_btn, [[]])
	GUI:Button_setTitleColor(xuemai_btn, "#ffffff")
	GUI:Button_setTitleFontSize(xuemai_btn, 16)
	GUI:Button_titleEnableOutline(xuemai_btn, "#000000", 1)
	GUI:setAnchorPoint(xuemai_btn, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_btn, true)
	GUI:setTag(xuemai_btn, 0)

	-- Create wsxm_btn
	local wsxm_btn = GUI:Button_Create(FrameLayout, "wsxm_btn", 10, 119, "res/custom/npc/52wsxm/wushuang1.png")
	GUI:setContentSize(wsxm_btn, 48, 130)
	GUI:setIgnoreContentAdaptWithSize(wsxm_btn, false)
	GUI:Button_setTitleText(wsxm_btn, [[]])
	GUI:Button_setTitleColor(wsxm_btn, "#ffffff")
	GUI:Button_setTitleFontSize(wsxm_btn, 16)
	GUI:Button_titleEnableOutline(wsxm_btn, "#000000", 1)
	GUI:setAnchorPoint(wsxm_btn, 0.00, 0.00)
	GUI:setTouchEnabled(wsxm_btn, true)
	GUI:setTag(wsxm_btn, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
