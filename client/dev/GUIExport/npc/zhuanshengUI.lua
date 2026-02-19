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
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 590, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/03zs/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 77, 77, 172, 172)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create leftBox
	local leftBox = GUI:Layout_Create(FrameBG, "leftBox", 54, 252, 466, 468, true)
	GUI:setAnchorPoint(leftBox, 0.00, 0.50)
	GUI:setTouchEnabled(leftBox, false)
	GUI:setTag(leftBox, 0)

	-- Create effectBox
	local effectBox = GUI:Layout_Create(leftBox, "effectBox", 0, 0, 466, 468, false)
	GUI:setAnchorPoint(effectBox, 0.00, 0.00)
	GUI:setTouchEnabled(effectBox, false)
	GUI:setTag(effectBox, 0)

	-- Create effect
	local effect = GUI:Effect_Create(effectBox, "effect", 236, 196, 0, 15000, 0, 0, 0, 1)
	GUI:setScale(effect, 0.80)
	GUI:setTag(effect, 0)

	-- Create ballImg
	local ballImg = GUI:Image_Create(leftBox, "ballImg", 242, 310, "res/custom/npc/03zs/xx.png")
	GUI:setAnchorPoint(ballImg, 0.50, 0.50)
	GUI:setTouchEnabled(ballImg, false)
	GUI:setTag(ballImg, 0)

	-- Create ball1
	local ball1 = GUI:Image_Create(ballImg, "ball1", 56, 22, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball1, 0.50, 0.50)
	GUI:setTouchEnabled(ball1, false)
	GUI:setTag(ball1, 0)

	-- Create ball2
	local ball2 = GUI:Image_Create(ballImg, "ball2", 22, 108, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball2, 0.50, 0.50)
	GUI:setTouchEnabled(ball2, false)
	GUI:setTag(ball2, 0)

	-- Create ball3
	local ball3 = GUI:Image_Create(ballImg, "ball3", 32, 202, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball3, 0.50, 0.50)
	GUI:setTouchEnabled(ball3, false)
	GUI:setTag(ball3, 0)

	-- Create ball4
	local ball4 = GUI:Image_Create(ballImg, "ball4", 84, 278, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball4, 0.50, 0.50)
	GUI:setTouchEnabled(ball4, false)
	GUI:setTag(ball4, 0)

	-- Create ball5
	local ball5 = GUI:Image_Create(ballImg, "ball5", 168, 324, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball5, 0.50, 0.50)
	GUI:setTouchEnabled(ball5, false)
	GUI:setTag(ball5, 0)

	-- Create ball6
	local ball6 = GUI:Image_Create(ballImg, "ball6", 262, 324, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball6, 0.50, 0.50)
	GUI:setTouchEnabled(ball6, false)
	GUI:setTag(ball6, 0)

	-- Create ball7
	local ball7 = GUI:Image_Create(ballImg, "ball7", 344, 278, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball7, 0.50, 0.50)
	GUI:setTouchEnabled(ball7, false)
	GUI:setTag(ball7, 0)

	-- Create ball8
	local ball8 = GUI:Image_Create(ballImg, "ball8", 394, 200, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball8, 0.50, 0.50)
	GUI:setTouchEnabled(ball8, false)
	GUI:setTag(ball8, 0)

	-- Create ball9
	local ball9 = GUI:Image_Create(ballImg, "ball9", 404, 108, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball9, 0.50, 0.50)
	GUI:setTouchEnabled(ball9, false)
	GUI:setTag(ball9, 0)

	-- Create ball10
	local ball10 = GUI:Image_Create(ballImg, "ball10", 368, 22, "res/custom/npc/03zs/x.png")
	GUI:setAnchorPoint(ball10, 0.50, 0.50)
	GUI:setTouchEnabled(ball10, false)
	GUI:setTag(ball10, 0)

	-- Create levelImg
	local levelImg = GUI:Image_Create(leftBox, "levelImg", 442, 416, "res/custom/npc/03zs/level/0.png")
	GUI:setAnchorPoint(levelImg, 0.50, 0.50)
	GUI:setTouchEnabled(levelImg, false)
	GUI:setTag(levelImg, 0)

	-- Create rightBox
	local rightBox = GUI:Layout_Create(FrameBG, "rightBox", 802, 250, 278, 468, true)
	GUI:setAnchorPoint(rightBox, 1.00, 0.50)
	GUI:setTouchEnabled(rightBox, false)
	GUI:setTag(rightBox, 0)

	-- Create infoList1
	local infoList1 = GUI:ListView_Create(rightBox, "infoList1", 140, 370, 90, 100, 1)
	GUI:ListView_setClippingEnabled(infoList1, false)
	GUI:ListView_setItemsMargin(infoList1, 2)
	GUI:setAnchorPoint(infoList1, 0.50, 0.50)
	GUI:setTouchEnabled(infoList1, true)
	GUI:setTag(infoList1, 0)

	-- Create text11
	local text11 = GUI:Text_Create(infoList1, "text11", 0, 76, 16, "#ffffff", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text11, "#000000", 1)
	GUI:setAnchorPoint(text11, 0.00, 0.00)
	GUI:setTouchEnabled(text11, false)
	GUI:setTag(text11, 0)

	-- Create text12
	local text12 = GUI:Text_Create(infoList1, "text12", 0, 50, 16, "#ffffff", [[ 防御：0-0]])
	GUI:Text_enableOutline(text12, "#000000", 1)
	GUI:setAnchorPoint(text12, 0.00, 0.00)
	GUI:setTouchEnabled(text12, false)
	GUI:setTag(text12, 0)

	-- Create text13
	local text13 = GUI:Text_Create(infoList1, "text13", 0, 24, 16, "#ffffff", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text13, "#000000", 1)
	GUI:setAnchorPoint(text13, 0.00, 0.00)
	GUI:setTouchEnabled(text13, false)
	GUI:setTag(text13, 0)

	-- Create text14
	local text14 = GUI:Text_Create(infoList1, "text14", 0, -2, 16, "#ffffff", [[生命值：0]])
	GUI:Text_enableOutline(text14, "#000000", 1)
	GUI:setAnchorPoint(text14, 0.00, 0.00)
	GUI:setTouchEnabled(text14, false)
	GUI:setTag(text14, 0)

	-- Create infoList2
	local infoList2 = GUI:ListView_Create(rightBox, "infoList2", 140, 222, 90, 100, 1)
	GUI:ListView_setClippingEnabled(infoList2, false)
	GUI:ListView_setItemsMargin(infoList2, 2)
	GUI:setAnchorPoint(infoList2, 0.50, 0.50)
	GUI:setTouchEnabled(infoList2, true)
	GUI:setTag(infoList2, 0)

	-- Create text21
	local text21 = GUI:Text_Create(infoList2, "text21", 0, 76, 16, "#00ff00", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text21, "#000000", 1)
	GUI:setAnchorPoint(text21, 0.00, 0.00)
	GUI:setTouchEnabled(text21, false)
	GUI:setTag(text21, 0)

	-- Create text22
	local text22 = GUI:Text_Create(infoList2, "text22", 0, 50, 16, "#00ff00", [[ 防御：0-0]])
	GUI:Text_enableOutline(text22, "#000000", 1)
	GUI:setAnchorPoint(text22, 0.00, 0.00)
	GUI:setTouchEnabled(text22, false)
	GUI:setTag(text22, 0)

	-- Create text23
	local text23 = GUI:Text_Create(infoList2, "text23", 0, 24, 16, "#00ff00", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text23, "#000000", 1)
	GUI:setAnchorPoint(text23, 0.00, 0.00)
	GUI:setTouchEnabled(text23, false)
	GUI:setTag(text23, 0)

	-- Create text24
	local text24 = GUI:Text_Create(infoList2, "text24", 0, -2, 16, "#00ff00", [[生命值：0]])
	GUI:Text_enableOutline(text24, "#000000", 1)
	GUI:setAnchorPoint(text24, 0.00, 0.00)
	GUI:setTouchEnabled(text24, false)
	GUI:setTag(text24, 0)

	-- Create needBox
	local needBox = GUI:Layout_Create(rightBox, "needBox", 136, 112, 100, 56, false)
	GUI:setAnchorPoint(needBox, 0.50, 0.50)
	GUI:setTouchEnabled(needBox, false)
	GUI:setTag(needBox, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightBox, "upBtn", 134, 48, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始转生]])
	GUI:Button_setTitleColor(upBtn, "#F8E6C6")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, -1)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 818, 488, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.00, 0.00)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
