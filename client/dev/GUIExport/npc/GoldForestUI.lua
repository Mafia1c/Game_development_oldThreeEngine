local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 0, 0, "res/custom/npc/57hjsl/z5.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, true)
	GUI:setMouseEnabled(Image_1, true)
	GUI:setTag(Image_1, 0)

	-- Create TopBox
	local TopBox = GUI:Layout_Create(Image_1, "TopBox", 73, 135, 441, 350, false)
	GUI:setAnchorPoint(TopBox, 0.00, 0.00)
	GUI:setTouchEnabled(TopBox, false)
	GUI:setTag(TopBox, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(TopBox, "ItemShow_1", 148, 274, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(TopBox, "ItemShow_2", 221, 274, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(TopBox, "ItemShow_3", 294, 274, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(TopBox, "ItemShow_4", 351, 235, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(TopBox, "ItemShow_5", 351, 171, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(TopBox, "ItemShow_6", 352, 105, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(TopBox, "ItemShow_7", 294, 59, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(TopBox, "ItemShow_8", 222, 59, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(TopBox, "ItemShow_9", 148, 59, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setTag(ItemShow_9, 0)

	-- Create ItemShow_10
	local ItemShow_10 = GUI:ItemShow_Create(TopBox, "ItemShow_10", 91, 105, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_10, 0.50, 0.50)
	GUI:setTag(ItemShow_10, 0)

	-- Create ItemShow_11
	local ItemShow_11 = GUI:ItemShow_Create(TopBox, "ItemShow_11", 91, 170, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_11, 0.50, 0.50)
	GUI:setTag(ItemShow_11, 0)

	-- Create ItemShow_12
	local ItemShow_12 = GUI:ItemShow_Create(TopBox, "ItemShow_12", 91, 235, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_12, 0.50, 0.50)
	GUI:setTag(ItemShow_12, 0)

	-- Create ItemShow_13
	local ItemShow_13 = GUI:ItemShow_Create(TopBox, "ItemShow_13", 57, 297, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_13, 0.50, 0.50)
	GUI:setTag(ItemShow_13, 0)

	-- Create ItemShow_14
	local ItemShow_14 = GUI:ItemShow_Create(TopBox, "ItemShow_14", 57, 39, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_14, 0.50, 0.50)
	GUI:setTag(ItemShow_14, 0)

	-- Create ItemShow_15
	local ItemShow_15 = GUI:ItemShow_Create(TopBox, "ItemShow_15", 381, 297, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_15, 0.50, 0.50)
	GUI:setTag(ItemShow_15, 0)

	-- Create ItemShow_16
	local ItemShow_16 = GUI:ItemShow_Create(TopBox, "ItemShow_16", 381, 39, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_16, 0.50, 0.50)
	GUI:setTag(ItemShow_16, 0)

	-- Create ItemShow_22
	local ItemShow_22 = GUI:ItemShow_Create(TopBox, "ItemShow_22", 222, 185, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_22, 0.50, 0.50)
	GUI:setTag(ItemShow_22, 0)

	-- Create CheckBox
	local CheckBox = GUI:CheckBox_Create(Image_1, "CheckBox", 239, 139, "res/custom/npc/37qh/gx_0.png", "res/custom/npc/37qh/gx_1.png")
	GUI:setContentSize(CheckBox, 24, 24)
	GUI:setIgnoreContentAdaptWithSize(CheckBox, false)
	GUI:CheckBox_setSelected(CheckBox, false)
	GUI:setAnchorPoint(CheckBox, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox, true)
	GUI:setTag(CheckBox, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(CheckBox, "Text_2", 32, -1, 18, "#ffff00", [[跳过动画]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create LotteryBtn
	local LotteryBtn = GUI:Button_Create(Image_1, "LotteryBtn", 245, 231, "res/custom/npc/57hjsl/an1.png")
	GUI:setContentSize(LotteryBtn, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(LotteryBtn, false)
	GUI:Button_setTitleText(LotteryBtn, [[]])
	GUI:Button_setTitleColor(LotteryBtn, "#ffffff")
	GUI:Button_setTitleFontSize(LotteryBtn, 16)
	GUI:Button_titleEnableOutline(LotteryBtn, "#000000", 1)
	GUI:setAnchorPoint(LotteryBtn, 0.00, 0.00)
	GUI:setTouchEnabled(LotteryBtn, true)
	GUI:setTag(LotteryBtn, 0)

	-- Create DownBox
	local DownBox = GUI:Layout_Create(Image_1, "DownBox", 72, 33, 442, 102, false)
	GUI:setAnchorPoint(DownBox, 0.00, 0.00)
	GUI:setTouchEnabled(DownBox, false)
	GUI:setTag(DownBox, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(DownBox, "Image_2", 71, 40, "res/custom/npc/57hjsl/jdt1.png")
	GUI:setContentSize(Image_2, 360, 16)
	GUI:setIgnoreContentAdaptWithSize(Image_2, false)
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create LoadingBar
	local LoadingBar = GUI:LoadingBar_Create(Image_2, "LoadingBar", -1, 2, "res/custom/npc/57hjsl/jdt2.png", 0)
	GUI:setContentSize(LoadingBar, 360, 12)
	GUI:setIgnoreContentAdaptWithSize(LoadingBar, false)
	GUI:LoadingBar_setPercent(LoadingBar, 0)
	GUI:setAnchorPoint(LoadingBar, 0.00, 0.00)
	GUI:setTouchEnabled(LoadingBar, false)
	GUI:setTag(LoadingBar, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(DownBox, "Image_3", 69, 18, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(DownBox, "Image_4", 144, 17, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(DownBox, "Image_5", 223, 17, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(DownBox, "Image_6", 298, 17, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create Image_7
	local Image_7 = GUI:Image_Create(DownBox, "Image_7", 374, 18, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_7, 0.00, 0.00)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, 0)

	-- Create ItemShow_17
	local ItemShow_17 = GUI:ItemShow_Create(DownBox, "ItemShow_17", 98, 48, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_17, 0.50, 0.50)
	GUI:setTag(ItemShow_17, 0)

	-- Create ItemShow_18
	local ItemShow_18 = GUI:ItemShow_Create(DownBox, "ItemShow_18", 173, 47, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_18, 0.50, 0.50)
	GUI:setTag(ItemShow_18, 0)

	-- Create ItemShow_19
	local ItemShow_19 = GUI:ItemShow_Create(DownBox, "ItemShow_19", 252, 47, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_19, 0.50, 0.50)
	GUI:setTag(ItemShow_19, 0)

	-- Create ItemShow_20
	local ItemShow_20 = GUI:ItemShow_Create(DownBox, "ItemShow_20", 327, 47, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_20, 0.50, 0.50)
	GUI:setTag(ItemShow_20, 0)

	-- Create ItemShow_21
	local ItemShow_21 = GUI:ItemShow_Create(DownBox, "ItemShow_21", 403, 48, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_21, 0.50, 0.50)
	GUI:setTag(ItemShow_21, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(Image_1, "closeBtn", 819, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create RightBox
	local RightBox = GUI:Layout_Create(Image_1, "RightBox", 521, 33, 282, 448, false)
	GUI:setAnchorPoint(RightBox, 0.00, 0.00)
	GUI:setTouchEnabled(RightBox, false)
	GUI:setTag(RightBox, 0)

	-- Create EnterBtn
	local EnterBtn = GUI:Button_Create(RightBox, "EnterBtn", 62, 14, "res/custom/npc/57hjsl/an.png")
	GUI:setContentSize(EnterBtn, 156, 38)
	GUI:setIgnoreContentAdaptWithSize(EnterBtn, false)
	GUI:Button_setTitleText(EnterBtn, [[]])
	GUI:Button_setTitleColor(EnterBtn, "#ffffff")
	GUI:Button_setTitleFontSize(EnterBtn, 16)
	GUI:Button_titleEnableOutline(EnterBtn, "#000000", 1)
	GUI:setAnchorPoint(EnterBtn, 0.00, 0.00)
	GUI:setTouchEnabled(EnterBtn, true)
	GUI:setTag(EnterBtn, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(RightBox, "Text_1", 74, 59, 16, "#ffffff", [[今日状态：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create stateText
	local stateText = GUI:Text_Create(RightBox, "stateText", 152, 59, 16, "#00ff00", [[已激活]])
	GUI:Text_enableOutline(stateText, "#000000", 1)
	GUI:setAnchorPoint(stateText, 0.00, 0.00)
	GUI:setTouchEnabled(stateText, false)
	GUI:setTag(stateText, 0)

	-- Create DescBtn
	local DescBtn = GUI:Button_Create(RightBox, "DescBtn", 6, 4, "res/public/1900001024.png")
	GUI:setContentSize(DescBtn, 29, 29)
	GUI:setIgnoreContentAdaptWithSize(DescBtn, false)
	GUI:Button_setTitleText(DescBtn, [[]])
	GUI:Button_setTitleColor(DescBtn, "#ffffff")
	GUI:Button_setTitleFontSize(DescBtn, 16)
	GUI:Button_titleEnableOutline(DescBtn, "#000000", 1)
	GUI:setAnchorPoint(DescBtn, 0.00, 0.00)
	GUI:setTouchEnabled(DescBtn, true)
	GUI:setTag(DescBtn, 0)

	-- Create dropBox
	local dropBox = GUI:Layout_Create(RightBox, "dropBox", 13, 92, 256, 64, false)
	GUI:setAnchorPoint(dropBox, 0.00, 0.00)
	GUI:setTouchEnabled(dropBox, false)
	GUI:setTag(dropBox, 0)

	-- Create TipPanel
	local TipPanel = GUI:Image_Create(FrameLayout, "TipPanel", 111, 52, "res/custom/npc/57hjsl/gz.png")
	GUI:setAnchorPoint(TipPanel, 0.00, 0.00)
	GUI:setTouchEnabled(TipPanel, true)
	GUI:setTag(TipPanel, 0)
	GUI:setVisible(TipPanel, false)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
