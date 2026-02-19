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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 590, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/15sz/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create leftBox
	local leftBox = GUI:Layout_Create(FrameBG, "leftBox", 305, 255, 470, 500, true)
	GUI:setAnchorPoint(leftBox, 0.50, 0.50)
	GUI:setTouchEnabled(leftBox, false)
	GUI:setTag(leftBox, 0)

	-- Create box1
	local box1 = GUI:Image_Create(leftBox, "box1", -74, 484, "res/custom/npc/015sz/k.png")
	GUI:setAnchorPoint(box1, 0.00, 0.00)
	GUI:setTouchEnabled(box1, false)
	GUI:setTag(box1, 0)

	-- Create box2
	local box2 = GUI:Image_Create(leftBox, "box2", -108, 374, "res/custom/npc/015sz/k.png")
	GUI:setAnchorPoint(box2, 0.00, 0.00)
	GUI:setTouchEnabled(box2, false)
	GUI:setTag(box2, 0)

	-- Create box3
	local box3 = GUI:Image_Create(leftBox, "box3", -124, 100, "res/custom/npc/015sz/k.png")
	GUI:setAnchorPoint(box3, 0.00, 0.00)
	GUI:setTouchEnabled(box3, false)
	GUI:setTag(box3, 0)

	-- Create box4
	local box4 = GUI:Image_Create(leftBox, "box4", 15, -76, "res/custom/npc/015sz/k.png")
	GUI:setAnchorPoint(box4, 0.00, 0.00)
	GUI:setTouchEnabled(box4, false)
	GUI:setTag(box4, 0)

	-- Create box5
	local box5 = GUI:Image_Create(leftBox, "box5", 342, -76, "res/custom/npc/015sz/k.png")
	GUI:setAnchorPoint(box5, 0.00, 0.00)
	GUI:setTouchEnabled(box5, false)
	GUI:setTag(box5, 0)

	-- Create box6
	local box6 = GUI:Image_Create(leftBox, "box6", 522, 100, "res/custom/npc/015sz/k.png")
	GUI:setAnchorPoint(box6, 0.00, 0.00)
	GUI:setTouchEnabled(box6, false)
	GUI:setTag(box6, 0)

	-- Create box7
	local box7 = GUI:Image_Create(leftBox, "box7", 523, 374, "res/custom/npc/015sz/k.png")
	GUI:setAnchorPoint(box7, 0.00, 0.00)
	GUI:setTouchEnabled(box7, false)
	GUI:setTag(box7, 0)

	-- Create box8
	local box8 = GUI:Image_Create(leftBox, "box8", 486, 484, "res/custom/npc/015sz/k.png")
	GUI:setAnchorPoint(box8, 0.00, 0.00)
	GUI:setTouchEnabled(box8, false)
	GUI:setTag(box8, 0)

	-- Create tipsText1
	local tipsText1 = GUI:Text_Create(leftBox, "tipsText1", 12, 60, 16, "#ffff00", [[灵装：神秘、虹魔、魔血、狂风、祈祷、记忆、共六套]])
	GUI:Text_enableOutline(tipsText1, "#000000", 1)
	GUI:setAnchorPoint(tipsText1, 0.00, 0.00)
	GUI:setTouchEnabled(tipsText1, false)
	GUI:setTag(tipsText1, 0)

	-- Create tipsText2
	local tipsText2 = GUI:Text_Create(leftBox, "tipsText2", 12, 38, 16, "#ffff00", [[副装可以进行神装觉醒，必须佩戴在身上才可进行觉醒！]])
	GUI:Text_enableOutline(tipsText2, "#000000", 1)
	GUI:setAnchorPoint(tipsText2, 0.00, 0.00)
	GUI:setTouchEnabled(tipsText2, false)
	GUI:setTag(tipsText2, 0)

	-- Create rightBox
	local rightBox = GUI:Layout_Create(FrameBG, "rightBox", 810, 264, 278, 496, true)
	GUI:setAnchorPoint(rightBox, 1.00, 0.50)
	GUI:setTouchEnabled(rightBox, false)
	GUI:setTag(rightBox, 0)

	-- Create infoBox1
	local infoBox1 = GUI:Layout_Create(rightBox, "infoBox1", 146, 354, 200, 130, false)
	GUI:setAnchorPoint(infoBox1, 0.50, 0.50)
	GUI:setTouchEnabled(infoBox1, false)
	GUI:setTag(infoBox1, 0)

	-- Create infoText1
	local infoText1 = GUI:Text_Create(infoBox1, "infoText1", 20, 100, 16, "#00ff00", [[灵装装备可以进行觉醒]])
	GUI:Text_enableOutline(infoText1, "#000000", 1)
	GUI:setAnchorPoint(infoText1, 0.00, 0.00)
	GUI:setTouchEnabled(infoText1, false)
	GUI:setTag(infoText1, 0)

	-- Create infoText2
	local infoText2 = GUI:Text_Create(infoBox1, "infoText2", 14, 78, 16, "#00ff00", [[觉醒需要消耗一定的物品]])
	GUI:Text_enableOutline(infoText2, "#000000", 1)
	GUI:setAnchorPoint(infoText2, 0.00, 0.00)
	GUI:setTouchEnabled(infoText2, false)
	GUI:setTag(infoText2, 0)

	-- Create infoText3
	local infoText3 = GUI:Text_Create(infoBox1, "infoText3", 14, 54, 16, "#00ff00", [[觉醒成功可获得进阶灵装]])
	GUI:Text_enableOutline(infoText3, "#000000", 1)
	GUI:setAnchorPoint(infoText3, 0.00, 0.00)
	GUI:setTouchEnabled(infoText3, false)
	GUI:setTag(infoText3, 0)

	-- Create infoBox2
	local infoBox2 = GUI:Layout_Create(rightBox, "infoBox2", 148, 200, 200, 68, false)
	GUI:setAnchorPoint(infoBox2, 0.50, 0.50)
	GUI:setTouchEnabled(infoBox2, false)
	GUI:setTag(infoBox2, 0)

	-- Create Rtext1
	local Rtext1 = GUI:Text_Create(infoBox2, "Rtext1", 32, 38, 16, "#ffffff", [[选择灵装：未选择]])
	GUI:Text_enableOutline(Rtext1, "#000000", 1)
	GUI:setAnchorPoint(Rtext1, 0.00, 0.00)
	GUI:setTouchEnabled(Rtext1, false)
	GUI:setTag(Rtext1, 0)

	-- Create Rtext2
	local Rtext2 = GUI:Text_Create(infoBox2, "Rtext2", 32, 12, 16, "#ffffff", [[进阶灵装：未选择]])
	GUI:Text_enableOutline(Rtext2, "#000000", 1)
	GUI:setAnchorPoint(Rtext2, 0.00, 0.00)
	GUI:setTouchEnabled(Rtext2, false)
	GUI:setTag(Rtext2, 0)

	-- Create needBox
	local needBox = GUI:Layout_Create(rightBox, "needBox", 148, 130, 100, 56, false)
	GUI:setAnchorPoint(needBox, 0.50, 0.50)
	GUI:setTouchEnabled(needBox, false)
	GUI:setTag(needBox, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightBox, "upBtn", 148, 50, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[觉醒神装]])
	GUI:Button_setTitleColor(upBtn, "#F8E6C6")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, -1)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 837, 504, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.50, 0.50)
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
