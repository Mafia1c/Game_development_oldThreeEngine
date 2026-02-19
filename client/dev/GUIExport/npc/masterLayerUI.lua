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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/06zsjj/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
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
	local effect = GUI:Effect_Create(effectBox, "effect", 5, 440, 0, 15013, 0, 0, 0, 1)
	GUI:setTag(effect, 0)

	-- Create effectLevel
	local effectLevel = GUI:Effect_Create(effectBox, "effectLevel", 32, 463, 0, 15243, 0, 0, 0, 1)
	GUI:setTag(effectLevel, 0)

	-- Create tipsImg
	local tipsImg = GUI:Image_Create(leftBox, "tipsImg", 244, 52, "res/custom/npc/06zsjj/text.png")
	GUI:setAnchorPoint(tipsImg, 0.50, 0.50)
	GUI:setOpacity(tipsImg, 0)
	GUI:setTouchEnabled(tipsImg, false)
	GUI:setTag(tipsImg, 0)

	-- Create rightBox
	local rightBox = GUI:Layout_Create(FrameBG, "rightBox", 802, 250, 278, 468, true)
	GUI:setAnchorPoint(rightBox, 1.00, 0.50)
	GUI:setTouchEnabled(rightBox, false)
	GUI:setTag(rightBox, 0)

	-- Create infoList1
	local infoList1 = GUI:ListView_Create(rightBox, "infoList1", 350, 370, 90, 80, 1)
	GUI:ListView_setClippingEnabled(infoList1, false)
	GUI:ListView_setItemsMargin(infoList1, 2)
	GUI:setAnchorPoint(infoList1, 0.50, 0.50)
	GUI:setTouchEnabled(infoList1, true)
	GUI:setTag(infoList1, 0)

	-- Create text11
	local text11 = GUI:Text_Create(infoList1, "text11", 0, 56, 16, "#ffffff", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text11, "#000000", 1)
	GUI:setAnchorPoint(text11, 0.00, 0.00)
	GUI:setOpacity(text11, 0)
	GUI:setTouchEnabled(text11, false)
	GUI:setTag(text11, 0)

	-- Create text12
	local text12 = GUI:Text_Create(infoList1, "text12", 0, 30, 16, "#ffffff", [[ 防御：0-0]])
	GUI:Text_enableOutline(text12, "#000000", 1)
	GUI:setAnchorPoint(text12, 0.00, 0.00)
	GUI:setOpacity(text12, 0)
	GUI:setTouchEnabled(text12, false)
	GUI:setTag(text12, 0)

	-- Create text13
	local text13 = GUI:Text_Create(infoList1, "text13", 0, 4, 16, "#ffffff", [[ 攻击：0-0]])
	GUI:Text_enableOutline(text13, "#000000", 1)
	GUI:setAnchorPoint(text13, 0.00, 0.00)
	GUI:setOpacity(text13, 0)
	GUI:setTouchEnabled(text13, false)
	GUI:setTag(text13, 0)

	-- Create infoList2
	local infoList2 = GUI:ListView_Create(rightBox, "infoList2", 350, 222, 90, 80, 1)
	GUI:ListView_setClippingEnabled(infoList2, false)
	GUI:ListView_setItemsMargin(infoList2, 2)
	GUI:setAnchorPoint(infoList2, 0.50, 0.50)
	GUI:setTouchEnabled(infoList2, true)
	GUI:setTag(infoList2, 0)

	-- Create text21
	local text21 = GUI:Text_Create(infoList2, "text21", 0, 56, 16, "#00ff00", [[ 攻 魔 道 ：0-0]])
	GUI:Text_enableOutline(text21, "#000000", 1)
	GUI:setAnchorPoint(text21, 0.00, 0.00)
	GUI:setOpacity(text21, 0)
	GUI:setTouchEnabled(text21, false)
	GUI:setTag(text21, 0)

	-- Create text22
	local text22 = GUI:Text_Create(infoList2, "text22", 0, 30, 16, "#00ff00", [[生命加成：0-0]])
	GUI:Text_enableOutline(text22, "#000000", 1)
	GUI:setAnchorPoint(text22, 0.00, 0.00)
	GUI:setOpacity(text22, 0)
	GUI:setTouchEnabled(text22, false)
	GUI:setTag(text22, 0)

	-- Create text23
	local text23 = GUI:Text_Create(infoList2, "text23", 0, 4, 16, "#00ff00", [[杀怪爆率：0-0]])
	GUI:Text_enableOutline(text23, "#000000", 1)
	GUI:setAnchorPoint(text23, 0.00, 0.00)
	GUI:setOpacity(text23, 0)
	GUI:setTouchEnabled(text23, false)
	GUI:setTag(text23, 0)

	-- Create needBox
	local needBox = GUI:Layout_Create(rightBox, "needBox", 140, 112, 100, 56, false)
	GUI:setAnchorPoint(needBox, 0.50, 0.50)
	GUI:setTouchEnabled(needBox, false)
	GUI:setTag(needBox, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightBox, "upBtn", 145, 51, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[突破境界]])
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
