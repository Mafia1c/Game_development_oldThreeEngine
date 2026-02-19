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
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/667zbdt/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
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

	-- Create leftList
	local leftList = GUI:ListView_Create(FrameLayout, "leftList", 76, 476, 114, 354, 1)
	GUI:ListView_setItemsMargin(leftList, 2)
	GUI:setAnchorPoint(leftList, 0.00, 1.00)
	GUI:setTouchEnabled(leftList, true)
	GUI:setTag(leftList, 0)

	-- Create leftBtn1
	local leftBtn1 = GUI:Image_Create(leftList, "leftBtn1", 0, 312, "res/custom/dayeqian2.png")
	GUI:setAnchorPoint(leftBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn1, false)
	GUI:setTag(leftBtn1, 0)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create bossBox1
	local bossBox1 = GUI:Image_Create(midNode, "bossBox1", 276, 413, "res/custom/npc/667zbdt/small.png")
	GUI:setAnchorPoint(bossBox1, 0.50, 0.50)
	GUI:setTouchEnabled(bossBox1, false)
	GUI:setTag(bossBox1, 0)

	-- Create bossEffect1
	local bossEffect1 = GUI:Effect_Create(bossBox1, "bossEffect1", 56, 40, 2, 23056, 0, 0, 4, 1)
	GUI:setScale(bossEffect1, 0.30)
	GUI:setTag(bossEffect1, 0)

	-- Create bossName1
	local bossName1 = GUI:Text_Create(bossBox1, "bossName1", 64, 12, 16, "#ffff00", [[]])
	GUI:Text_enableOutline(bossName1, "#000000", 1)
	GUI:setAnchorPoint(bossName1, 0.50, 0.50)
	GUI:setTouchEnabled(bossName1, false)
	GUI:setTag(bossName1, 0)

	-- Create itemShow_1
	local itemShow_1 = GUI:ItemShow_Create(bossBox1, "itemShow_1", 156, 58, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(itemShow_1, 0.50, 0.50)
	GUI:setTag(itemShow_1, 0)

	-- Create bossTime1
	local bossTime1 = GUI:Text_Create(bossBox1, "bossTime1", 64, -14, 16, "#ffffff", [[]])
	GUI:Text_enableOutline(bossTime1, "#000000", 1)
	GUI:setAnchorPoint(bossTime1, 0.50, 0.50)
	GUI:setTouchEnabled(bossTime1, false)
	GUI:setTag(bossTime1, 0)

	-- Create bossBox2
	local bossBox2 = GUI:Image_Create(midNode, "bossBox2", 710, 414, "res/custom/npc/667zbdt/small.png")
	GUI:setAnchorPoint(bossBox2, 0.50, 0.50)
	GUI:setTouchEnabled(bossBox2, false)
	GUI:setTag(bossBox2, 0)

	-- Create bossEffect2
	local bossEffect2 = GUI:Effect_Create(bossBox2, "bossEffect2", 60, 42, 2, 23057, 0, 0, 4, 1)
	GUI:setScale(bossEffect2, 0.30)
	GUI:setTag(bossEffect2, -1)

	-- Create bossName2
	local bossName2 = GUI:Text_Create(bossBox2, "bossName2", 64, 12, 16, "#ffff00", [[]])
	GUI:Text_enableOutline(bossName2, "#000000", 1)
	GUI:setAnchorPoint(bossName2, 0.50, 0.50)
	GUI:setTouchEnabled(bossName2, false)
	GUI:setTag(bossName2, 0)

	-- Create itemShow_2
	local itemShow_2 = GUI:ItemShow_Create(bossBox2, "itemShow_2", -24, 58, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(itemShow_2, 0.50, 0.50)
	GUI:setTag(itemShow_2, 0)

	-- Create bossTime2
	local bossTime2 = GUI:Text_Create(bossBox2, "bossTime2", 64, -14, 16, "#ffffff", [[]])
	GUI:Text_enableOutline(bossTime2, "#000000", 1)
	GUI:setAnchorPoint(bossTime2, 0.50, 0.50)
	GUI:setTouchEnabled(bossTime2, false)
	GUI:setTag(bossTime2, 0)

	-- Create bossBox3
	local bossBox3 = GUI:Image_Create(midNode, "bossBox3", 276, 200, "res/custom/npc/667zbdt/small.png")
	GUI:setAnchorPoint(bossBox3, 0.50, 0.50)
	GUI:setTouchEnabled(bossBox3, false)
	GUI:setTag(bossBox3, 0)

	-- Create bossEffect3
	local bossEffect3 = GUI:Effect_Create(bossBox3, "bossEffect3", 58, 40, 2, 23058, 0, 0, 4, 1)
	GUI:setScale(bossEffect3, 0.30)
	GUI:setTag(bossEffect3, -1)

	-- Create bossName3
	local bossName3 = GUI:Text_Create(bossBox3, "bossName3", 64, 12, 16, "#ffff00", [[]])
	GUI:Text_enableOutline(bossName3, "#000000", 1)
	GUI:setAnchorPoint(bossName3, 0.50, 0.50)
	GUI:setTouchEnabled(bossName3, false)
	GUI:setTag(bossName3, 0)

	-- Create itemShow_3
	local itemShow_3 = GUI:ItemShow_Create(bossBox3, "itemShow_3", 156, 58, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(itemShow_3, 0.50, 0.50)
	GUI:setTag(itemShow_3, 0)

	-- Create bossTime3
	local bossTime3 = GUI:Text_Create(bossBox3, "bossTime3", 64, -14, 16, "#ffffff", [[]])
	GUI:Text_enableOutline(bossTime3, "#000000", 1)
	GUI:setAnchorPoint(bossTime3, 0.50, 0.50)
	GUI:setTouchEnabled(bossTime3, false)
	GUI:setTag(bossTime3, 0)

	-- Create bossBox4
	local bossBox4 = GUI:Image_Create(midNode, "bossBox4", 710, 200, "res/custom/npc/667zbdt/small.png")
	GUI:setAnchorPoint(bossBox4, 0.50, 0.50)
	GUI:setTouchEnabled(bossBox4, false)
	GUI:setTag(bossBox4, 0)

	-- Create bossEffect3
	bossEffect3 = GUI:Effect_Create(bossBox4, "bossEffect3", 60, 54, 2, 23059, 0, 0, 4, 1)
	GUI:setScale(bossEffect3, 0.30)
	GUI:setTag(bossEffect3, -1)

	-- Create bossName4
	local bossName4 = GUI:Text_Create(bossBox4, "bossName4", 64, 12, 16, "#ffff00", [[]])
	GUI:Text_enableOutline(bossName4, "#000000", 1)
	GUI:setAnchorPoint(bossName4, 0.50, 0.50)
	GUI:setTouchEnabled(bossName4, false)
	GUI:setTag(bossName4, 0)

	-- Create itemShow_4
	local itemShow_4 = GUI:ItemShow_Create(bossBox4, "itemShow_4", -24, 58, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(itemShow_4, 0.50, 0.50)
	GUI:setTag(itemShow_4, 0)

	-- Create bossTime4
	local bossTime4 = GUI:Text_Create(bossBox4, "bossTime4", 64, -14, 16, "#ffffff", [[]])
	GUI:Text_enableOutline(bossTime4, "#000000", 1)
	GUI:setAnchorPoint(bossTime4, 0.50, 0.50)
	GUI:setTouchEnabled(bossTime4, false)
	GUI:setTag(bossTime4, 0)

	-- Create tipsText
	local tipsText = GUI:Text_Create(midNode, "tipsText", 294, 104, 16, "#00ff00", [[击杀BOSS归属玩家地图内同行会所有成员均可获得击杀奖励]])
	GUI:Text_enableOutline(tipsText, "#000000", 1)
	GUI:setAnchorPoint(tipsText, 0.50, 0.50)
	GUI:setTouchEnabled(tipsText, false)
	GUI:setTag(tipsText, 0)

	-- Create itemNode
	local itemNode = GUI:Node_Create(midNode, "itemNode", 280, 64)
	GUI:setTag(itemNode, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midNode, "upBtn", 700, 62, "res/custom/npc/667zbdt/goBtn1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/667zbdt/goBtn2.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[]])
	GUI:Button_setTitleColor(upBtn, "#f8e6c6")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create timeText
	local timeText = GUI:Text_Create(upBtn, "timeText", -32, 46, 16, "#00ff00", [[今日剩余挑战次数：6次]])
	GUI:Text_enableOutline(timeText, "#000000", 1)
	GUI:setAnchorPoint(timeText, 0.00, 0.00)
	GUI:setTouchEnabled(timeText, false)
	GUI:setTag(timeText, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
