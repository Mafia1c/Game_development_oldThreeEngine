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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/36jxzl/mb.png")
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
	local leftList = GUI:ListView_Create(FrameLayout, "leftList", 76, 476, 114, 440, 1)
	GUI:ListView_setBounceEnabled(leftList, true)
	GUI:setAnchorPoint(leftList, 0.00, 1.00)
	GUI:setTouchEnabled(leftList, true)
	GUI:setTag(leftList, 0)

	-- Create taskNode1
	local taskNode1 = GUI:Node_Create(FrameLayout, "taskNode1", 496, 386)
	GUI:setTag(taskNode1, 0)

	-- Create midBox1
	local midBox1 = GUI:Image_Create(taskNode1, "midBox1", 0, 0, "res/custom/npc/36jxzl/mb_1.png")
	GUI:setContentSize(midBox1, 290, 174)
	GUI:setIgnoreContentAdaptWithSize(midBox1, false)
	GUI:setAnchorPoint(midBox1, 0.00, 0.00)
	GUI:setTouchEnabled(midBox1, false)
	GUI:setTag(midBox1, 0)

	-- Create titleImg1
	local titleImg1 = GUI:Image_Create(midBox1, "titleImg1", 146, 152, "res/custom/npc/36jxzl/zbt1.png")
	GUI:setContentSize(titleImg1, 66, 22)
	GUI:setIgnoreContentAdaptWithSize(titleImg1, false)
	GUI:setAnchorPoint(titleImg1, 0.50, 0.50)
	GUI:setTouchEnabled(titleImg1, false)
	GUI:setTag(titleImg1, 0)

	-- Create point1
	local point1 = GUI:Text_Create(midBox1, "point1", 70, 104, 16, "#00ff00", [[迷失神庙杀怪*500只]])
	GUI:Text_enableOutline(point1, "#000000", 1)
	GUI:setAnchorPoint(point1, 0.00, 0.00)
	GUI:setTouchEnabled(point1, false)
	GUI:setTag(point1, 0)

	-- Create progress1
	local progress1 = GUI:Text_Create(midBox1, "progress1", 70, 78, 16, "#ff0000", [[0/500]])
	GUI:Text_enableOutline(progress1, "#000000", 1)
	GUI:setAnchorPoint(progress1, 0.00, 0.00)
	GUI:setTouchEnabled(progress1, false)
	GUI:setTag(progress1, 0)

	-- Create rewardNode1
	local rewardNode1 = GUI:Node_Create(midBox1, "rewardNode1", 120, 38)
	GUI:setTag(rewardNode1, 0)

	-- Create nodeBtn1
	local nodeBtn1 = GUI:Button_Create(midBox1, "nodeBtn1", 230, 36, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(nodeBtn1, 11, 11, 14, 14)
	GUI:setContentSize(nodeBtn1, 80, 36)
	GUI:setIgnoreContentAdaptWithSize(nodeBtn1, false)
	GUI:Button_setTitleText(nodeBtn1, [[领取]])
	GUI:Button_setTitleColor(nodeBtn1, "#e8dcbd")
	GUI:Button_setTitleFontSize(nodeBtn1, 16)
	GUI:Button_titleEnableOutline(nodeBtn1, "#000000", 1)
	GUI:setAnchorPoint(nodeBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(nodeBtn1, true)
	GUI:setTag(nodeBtn1, 0)

	-- Create activeImg1
	local activeImg1 = GUI:Image_Create(midBox1, "activeImg1", 228, 36, "res/custom/tag/ylq_01.png")
	GUI:setAnchorPoint(activeImg1, 0.50, 0.50)
	GUI:setTouchEnabled(activeImg1, false)
	GUI:setTag(activeImg1, 0)

	-- Create midBox2
	local midBox2 = GUI:Image_Create(taskNode1, "midBox2", 0, 0, "res/custom/npc/36jxzl/mb_1.png")
	GUI:setContentSize(midBox2, 290, 174)
	GUI:setIgnoreContentAdaptWithSize(midBox2, false)
	GUI:setAnchorPoint(midBox2, 0.00, 0.00)
	GUI:setTouchEnabled(midBox2, false)
	GUI:setTag(midBox2, 0)

	-- Create titleImg2
	local titleImg2 = GUI:Image_Create(midBox2, "titleImg2", 146, 152, "res/custom/npc/36jxzl/zbt2.png")
	GUI:setContentSize(titleImg2, 66, 22)
	GUI:setIgnoreContentAdaptWithSize(titleImg2, false)
	GUI:setAnchorPoint(titleImg2, 0.50, 0.50)
	GUI:setTouchEnabled(titleImg2, false)
	GUI:setTag(titleImg2, 0)

	-- Create point2
	local point2 = GUI:Text_Create(midBox2, "point2", 70, 104, 16, "#00ff00", [[迷失神庙杀怪*500只]])
	GUI:Text_enableOutline(point2, "#000000", 1)
	GUI:setAnchorPoint(point2, 0.00, 0.00)
	GUI:setTouchEnabled(point2, false)
	GUI:setTag(point2, 0)

	-- Create progress2
	local progress2 = GUI:Text_Create(midBox2, "progress2", 70, 78, 16, "#ff0000", [[0/500]])
	GUI:Text_enableOutline(progress2, "#000000", 1)
	GUI:setAnchorPoint(progress2, 0.00, 0.00)
	GUI:setTouchEnabled(progress2, false)
	GUI:setTag(progress2, 0)

	-- Create rewardNode2
	local rewardNode2 = GUI:Node_Create(midBox2, "rewardNode2", 120, 38)
	GUI:setTag(rewardNode2, 0)

	-- Create nodeBtn2
	local nodeBtn2 = GUI:Button_Create(midBox2, "nodeBtn2", 230, 36, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(nodeBtn2, 11, 11, 14, 14)
	GUI:setContentSize(nodeBtn2, 80, 36)
	GUI:setIgnoreContentAdaptWithSize(nodeBtn2, false)
	GUI:Button_setTitleText(nodeBtn2, [[领取]])
	GUI:Button_setTitleColor(nodeBtn2, "#e8dcbd")
	GUI:Button_setTitleFontSize(nodeBtn2, 16)
	GUI:Button_titleEnableOutline(nodeBtn2, "#000000", 1)
	GUI:setAnchorPoint(nodeBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(nodeBtn2, true)
	GUI:setTag(nodeBtn2, 0)

	-- Create activeImg2
	local activeImg2 = GUI:Image_Create(midBox2, "activeImg2", 228, 36, "res/custom/tag/ylq_01.png")
	GUI:setAnchorPoint(activeImg2, 0.50, 0.50)
	GUI:setTouchEnabled(activeImg2, false)
	GUI:setTag(activeImg2, 0)

	-- Create taskNode2
	local taskNode2 = GUI:Node_Create(FrameLayout, "taskNode2", 496, 202)
	GUI:setTag(taskNode2, 0)

	-- Create midBox3
	local midBox3 = GUI:Image_Create(taskNode2, "midBox3", 0, 0, "res/custom/npc/36jxzl/mb_1.png")
	GUI:setContentSize(midBox3, 290, 174)
	GUI:setIgnoreContentAdaptWithSize(midBox3, false)
	GUI:setAnchorPoint(midBox3, 0.00, 0.00)
	GUI:setTouchEnabled(midBox3, false)
	GUI:setTag(midBox3, 0)

	-- Create titleImg3
	local titleImg3 = GUI:Image_Create(midBox3, "titleImg3", 146, 152, "res/custom/npc/36jxzl/zbt3.png")
	GUI:setContentSize(titleImg3, 66, 22)
	GUI:setIgnoreContentAdaptWithSize(titleImg3, false)
	GUI:setAnchorPoint(titleImg3, 0.50, 0.50)
	GUI:setTouchEnabled(titleImg3, false)
	GUI:setTag(titleImg3, 0)

	-- Create point3
	local point3 = GUI:Text_Create(midBox3, "point3", 70, 104, 16, "#00ff00", [[迷失神庙杀怪*500只]])
	GUI:Text_enableOutline(point3, "#000000", 1)
	GUI:setAnchorPoint(point3, 0.00, 0.00)
	GUI:setTouchEnabled(point3, false)
	GUI:setTag(point3, 0)

	-- Create progress3
	local progress3 = GUI:Text_Create(midBox3, "progress3", 70, 78, 16, "#ff0000", [[0/500]])
	GUI:Text_enableOutline(progress3, "#000000", 1)
	GUI:setAnchorPoint(progress3, 0.00, 0.00)
	GUI:setTouchEnabled(progress3, false)
	GUI:setTag(progress3, 0)

	-- Create rewardNode3
	local rewardNode3 = GUI:Node_Create(midBox3, "rewardNode3", 120, 38)
	GUI:setTag(rewardNode3, 0)

	-- Create nodeBtn3
	local nodeBtn3 = GUI:Button_Create(midBox3, "nodeBtn3", 230, 36, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(nodeBtn3, 11, 11, 14, 14)
	GUI:setContentSize(nodeBtn3, 80, 36)
	GUI:setIgnoreContentAdaptWithSize(nodeBtn3, false)
	GUI:Button_setTitleText(nodeBtn3, [[领取]])
	GUI:Button_setTitleColor(nodeBtn3, "#e8dcbd")
	GUI:Button_setTitleFontSize(nodeBtn3, 16)
	GUI:Button_titleEnableOutline(nodeBtn3, "#000000", 1)
	GUI:setAnchorPoint(nodeBtn3, 0.50, 0.50)
	GUI:setTouchEnabled(nodeBtn3, true)
	GUI:setTag(nodeBtn3, 0)

	-- Create activeImg3
	local activeImg3 = GUI:Image_Create(midBox3, "activeImg3", 228, 36, "res/custom/tag/ylq_01.png")
	GUI:setAnchorPoint(activeImg3, 0.50, 0.50)
	GUI:setTouchEnabled(activeImg3, false)
	GUI:setTag(activeImg3, 0)

	-- Create midBox4
	local midBox4 = GUI:Image_Create(taskNode2, "midBox4", 0, 0, "res/custom/npc/36jxzl/mb_1.png")
	GUI:setContentSize(midBox4, 290, 174)
	GUI:setIgnoreContentAdaptWithSize(midBox4, false)
	GUI:setAnchorPoint(midBox4, 0.00, 0.00)
	GUI:setTouchEnabled(midBox4, false)
	GUI:setTag(midBox4, 0)

	-- Create titleImg4
	local titleImg4 = GUI:Image_Create(midBox4, "titleImg4", 146, 152, "res/custom/npc/36jxzl/zbt4.png")
	GUI:setContentSize(titleImg4, 66, 22)
	GUI:setIgnoreContentAdaptWithSize(titleImg4, false)
	GUI:setAnchorPoint(titleImg4, 0.50, 0.50)
	GUI:setTouchEnabled(titleImg4, false)
	GUI:setTag(titleImg4, 0)

	-- Create point4
	local point4 = GUI:Text_Create(midBox4, "point4", 70, 104, 16, "#00ff00", [[迷失神庙杀怪*500只]])
	GUI:Text_enableOutline(point4, "#000000", 1)
	GUI:setAnchorPoint(point4, 0.00, 0.00)
	GUI:setTouchEnabled(point4, false)
	GUI:setTag(point4, 0)

	-- Create progress4
	local progress4 = GUI:Text_Create(midBox4, "progress4", 70, 78, 16, "#ff0000", [[0/500]])
	GUI:Text_enableOutline(progress4, "#000000", 1)
	GUI:setAnchorPoint(progress4, 0.00, 0.00)
	GUI:setTouchEnabled(progress4, false)
	GUI:setTag(progress4, 0)

	-- Create rewardNode4
	local rewardNode4 = GUI:Node_Create(midBox4, "rewardNode4", 120, 38)
	GUI:setTag(rewardNode4, 0)

	-- Create nodeBtn4
	local nodeBtn4 = GUI:Button_Create(midBox4, "nodeBtn4", 230, 36, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(nodeBtn4, 11, 11, 14, 14)
	GUI:setContentSize(nodeBtn4, 80, 36)
	GUI:setIgnoreContentAdaptWithSize(nodeBtn4, false)
	GUI:Button_setTitleText(nodeBtn4, [[领取]])
	GUI:Button_setTitleColor(nodeBtn4, "#e8dcbd")
	GUI:Button_setTitleFontSize(nodeBtn4, 16)
	GUI:Button_titleEnableOutline(nodeBtn4, "#000000", 1)
	GUI:setAnchorPoint(nodeBtn4, 0.50, 0.50)
	GUI:setTouchEnabled(nodeBtn4, true)
	GUI:setTag(nodeBtn4, 0)

	-- Create activeImg4
	local activeImg4 = GUI:Image_Create(midBox4, "activeImg4", 228, 36, "res/custom/tag/ylq_01.png")
	GUI:setAnchorPoint(activeImg4, 0.50, 0.50)
	GUI:setTouchEnabled(activeImg4, false)
	GUI:setTag(activeImg4, 0)

	-- Create pageText
	local pageText = GUI:Text_Create(FrameLayout, "pageText", 240, 68, 18, "#00ffe8", [[完成本页
任务奖励]])
	GUI:Text_enableOutline(pageText, "#000000", 1)
	GUI:setAnchorPoint(pageText, 0.50, 0.50)
	GUI:setTouchEnabled(pageText, false)
	GUI:setTag(pageText, 0)

	-- Create awardNode
	local awardNode = GUI:Node_Create(FrameLayout, "awardNode", 404, 70)
	GUI:setTag(awardNode, 0)

	-- Create rewardBtn
	local rewardBtn = GUI:Button_Create(FrameLayout, "rewardBtn", 736, 66, "res/custom/bt_dz.png")
	GUI:Button_setScale9Slice(rewardBtn, 11, 11, 14, 14)
	GUI:setContentSize(rewardBtn, 100, 42)
	GUI:setIgnoreContentAdaptWithSize(rewardBtn, false)
	GUI:Button_setTitleText(rewardBtn, [[领取奖励]])
	GUI:Button_setTitleColor(rewardBtn, "#e8dcbd")
	GUI:Button_setTitleFontSize(rewardBtn, 16)
	GUI:Button_titleEnableOutline(rewardBtn, "#000000", 1)
	GUI:setAnchorPoint(rewardBtn, 0.50, 0.50)
	GUI:setTouchEnabled(rewardBtn, true)
	GUI:setTag(rewardBtn, 0)

	-- Create pageActiveImg
	local pageActiveImg = GUI:Image_Create(FrameLayout, "pageActiveImg", 742, 58, "res/custom/tag/ylq_03.png")
	GUI:setAnchorPoint(pageActiveImg, 0.50, 0.50)
	GUI:setTouchEnabled(pageActiveImg, false)
	GUI:setTag(pageActiveImg, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
