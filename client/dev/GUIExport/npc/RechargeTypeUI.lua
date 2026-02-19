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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 590, 334, 450, 200, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/public/1900000600.png")
	GUI:Image_setScale9Slice(FrameBG, 0, 0, 0, 0)
	GUI:setContentSize(FrameBG, 450, 200)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, 0)

	-- Create numberText
	local numberText = GUI:Text_Create(FrameBG, "numberText", 224, 152, 18, "#00ff00", [[充值金额：500元]])
	GUI:Text_enableOutline(numberText, "#000000", 1)
	GUI:setAnchorPoint(numberText, 0.50, 0.50)
	GUI:setTouchEnabled(numberText, false)
	GUI:setTag(numberText, 0)

	-- Create typeNode
	local typeNode = GUI:Node_Create(FrameBG, "typeNode", 230, 86)
	GUI:setTag(typeNode, 0)

	-- Create typeBtn1
	local typeBtn1 = GUI:Button_Create(typeNode, "typeBtn1", 0, 0, "res/public/bg_czzya_05.png")
	GUI:setContentSize(typeBtn1, 88, 33)
	GUI:setIgnoreContentAdaptWithSize(typeBtn1, false)
	GUI:Button_setTitleText(typeBtn1, [[]])
	GUI:Button_setTitleColor(typeBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn1, 16)
	GUI:Button_titleEnableOutline(typeBtn1, "#000000", 1)
	GUI:setAnchorPoint(typeBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn1, true)
	GUI:setTag(typeBtn1, 0)

	-- Create typeTag1
	local typeTag1 = GUI:Image_Create(typeBtn1, "typeTag1", 78, 22, "res/public/bg_czzya_05_1.png")
	GUI:setContentSize(typeTag1, 21, 21)
	GUI:setIgnoreContentAdaptWithSize(typeTag1, false)
	GUI:setAnchorPoint(typeTag1, 0.50, 0.50)
	GUI:setTouchEnabled(typeTag1, false)
	GUI:setTag(typeTag1, 0)
	GUI:setVisible(typeTag1, false)

	-- Create typeBtn2
	local typeBtn2 = GUI:Button_Create(typeNode, "typeBtn2", 0, 0, "res/public/bg_czzya_06.png")
	GUI:setContentSize(typeBtn2, 88, 33)
	GUI:setIgnoreContentAdaptWithSize(typeBtn2, false)
	GUI:Button_setTitleText(typeBtn2, [[]])
	GUI:Button_setTitleColor(typeBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn2, 16)
	GUI:Button_titleEnableOutline(typeBtn2, "#000000", 1)
	GUI:setAnchorPoint(typeBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn2, true)
	GUI:setTag(typeBtn2, 0)

	-- Create typeTag2
	local typeTag2 = GUI:Image_Create(typeBtn2, "typeTag2", 78, 22, "res/public/bg_czzya_06_1.png")
	GUI:setContentSize(typeTag2, 17, 17)
	GUI:setIgnoreContentAdaptWithSize(typeTag2, false)
	GUI:setAnchorPoint(typeTag2, 0.50, 0.50)
	GUI:setTouchEnabled(typeTag2, false)
	GUI:setTag(typeTag2, 0)
	GUI:setVisible(typeTag2, false)

	-- Create typeBtn3
	local typeBtn3 = GUI:Button_Create(typeNode, "typeBtn3", 0, 0, "res/public/bg_czzya_04.png")
	GUI:setContentSize(typeBtn3, 88, 33)
	GUI:setIgnoreContentAdaptWithSize(typeBtn3, false)
	GUI:Button_setTitleText(typeBtn3, [[]])
	GUI:Button_setTitleColor(typeBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn3, 16)
	GUI:Button_titleEnableOutline(typeBtn3, "#000000", 1)
	GUI:setAnchorPoint(typeBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn3, true)
	GUI:setTag(typeBtn3, 0)

	-- Create typeTag3
	local typeTag3 = GUI:Image_Create(typeBtn3, "typeTag3", 78, 22, "res/public/bg_czzya_04_1.png")
	GUI:setContentSize(typeTag3, 20, 21)
	GUI:setIgnoreContentAdaptWithSize(typeTag3, false)
	GUI:setAnchorPoint(typeTag3, 0.50, 0.50)
	GUI:setTouchEnabled(typeTag3, false)
	GUI:setTag(typeTag3, 0)
	GUI:setVisible(typeTag3, false)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 462, 179, "res/public/1900000510.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
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
