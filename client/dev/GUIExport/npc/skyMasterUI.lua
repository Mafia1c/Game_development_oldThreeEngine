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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/87zs/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create leftNode
	local leftNode = GUI:Node_Create(FrameBG, "leftNode", 0, 0)
	GUI:setTag(leftNode, 0)

	-- Create effectPerson
	local effectPerson = GUI:Effect_Create(leftNode, "effectPerson", 180, 444, 0, 15011, 0, 0, 0, 1)
	GUI:setScale(effectPerson, 0.50)
	GUI:setTag(effectPerson, 0)

	-- Create levelText
	local levelText = GUI:Text_Create(leftNode, "levelText", 327, 444, 16, "#00ff00", [[20转]])
	GUI:Text_enableOutline(levelText, "#000000", 1)
	GUI:setAnchorPoint(levelText, 0.00, 0.00)
	GUI:setTouchEnabled(levelText, false)
	GUI:setTag(levelText, 0)

	-- Create Rtext1
	local Rtext1 = GUI:Text_Create(leftNode, "Rtext1", 82, 180, 16, "#ffffff", [[人物等级突破提升1级，全系技能抵抗，异次元之力]])
	GUI:Text_enableOutline(Rtext1, "#000000", 1)
	GUI:setAnchorPoint(Rtext1, 0.00, 1.00)
	GUI:setTouchEnabled(Rtext1, false)
	GUI:setTag(Rtext1, 0)

	-- Create Rtext2
	local Rtext2 = GUI:Text_Create(leftNode, "Rtext2", 82, 108, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(Rtext2, "#000000", 1)
	GUI:setAnchorPoint(Rtext2, 0.00, 1.00)
	GUI:setTouchEnabled(Rtext2, false)
	GUI:setTag(Rtext2, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameBG, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create textNode1
	local textNode1 = GUI:Node_Create(rightNode, "textNode1", 666, 394)
	GUI:setTag(textNode1, 0)

	-- Create text11
	local text11 = GUI:Text_Create(textNode1, "text11", 16, 11, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(text11, "#000000", 1)
	GUI:setAnchorPoint(text11, 0.50, 0.50)
	GUI:setTouchEnabled(text11, false)
	GUI:setTag(text11, 0)

	-- Create text12
	local text12 = GUI:Text_Create(textNode1, "text12", 16, 11, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(text12, "#000000", 1)
	GUI:setAnchorPoint(text12, 0.50, 0.50)
	GUI:setTouchEnabled(text12, false)
	GUI:setTag(text12, 0)

	-- Create text13
	local text13 = GUI:Text_Create(textNode1, "text13", 16, 11, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(text13, "#000000", 1)
	GUI:setAnchorPoint(text13, 0.50, 0.50)
	GUI:setTouchEnabled(text13, false)
	GUI:setTag(text13, 0)

	-- Create text14
	local text14 = GUI:Text_Create(textNode1, "text14", 16, 11, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(text14, "#000000", 1)
	GUI:setAnchorPoint(text14, 0.50, 0.50)
	GUI:setTouchEnabled(text14, false)
	GUI:setTag(text14, 0)

	-- Create textNode2
	local textNode2 = GUI:Node_Create(rightNode, "textNode2", 666, 256)
	GUI:setTag(textNode2, 0)

	-- Create text21
	local text21 = GUI:Text_Create(textNode2, "text21", 16, 11, 16, "#00ff00", [[文本]])
	GUI:Text_enableOutline(text21, "#000000", 1)
	GUI:setAnchorPoint(text21, 0.50, 0.50)
	GUI:setTouchEnabled(text21, false)
	GUI:setTag(text21, 0)

	-- Create text22
	local text22 = GUI:Text_Create(textNode2, "text22", 16, 11, 16, "#00ff00", [[文本]])
	GUI:Text_enableOutline(text22, "#000000", 1)
	GUI:setAnchorPoint(text22, 0.50, 0.50)
	GUI:setTouchEnabled(text22, false)
	GUI:setTag(text22, 0)

	-- Create text23
	local text23 = GUI:Text_Create(textNode2, "text23", 16, 11, 16, "#00ff00", [[文本]])
	GUI:Text_enableOutline(text23, "#000000", 1)
	GUI:setAnchorPoint(text23, 0.50, 0.50)
	GUI:setTouchEnabled(text23, false)
	GUI:setTag(text23, 0)

	-- Create text24
	local text24 = GUI:Text_Create(textNode2, "text24", 16, 11, 16, "#00ff00", [[文本]])
	GUI:Text_enableOutline(text24, "#000000", 1)
	GUI:setAnchorPoint(text24, 0.50, 0.50)
	GUI:setTouchEnabled(text24, false)
	GUI:setTag(text24, 0)

	-- Create needBox
	local needBox = GUI:Layout_Create(rightNode, "needBox", 666, 130, 60, 60, false)
	GUI:setAnchorPoint(needBox, 0.50, 0.50)
	GUI:setTouchEnabled(needBox, false)
	GUI:setTag(needBox, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightNode, "upBtn", 668, 64, "res/custom/npc/87zs/an.png")
	GUI:setContentSize(upBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[]])
	GUI:Button_setTitleColor(upBtn, "#e8dcbd")
	GUI:Button_setTitleFontSize(upBtn, 16)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create activeImg
	local activeImg = GUI:Image_Create(rightNode, "activeImg", 668, 72, "res/custom/tag/c_103.png")
	GUI:setAnchorPoint(activeImg, 0.50, 0.50)
	GUI:setTouchEnabled(activeImg, false)
	GUI:setTag(activeImg, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 818, 488, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
