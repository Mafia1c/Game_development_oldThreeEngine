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
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/33zb/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
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
	GUI:ListView_setItemsMargin(leftList, 2)
	GUI:setAnchorPoint(leftList, 0.00, 1.00)
	GUI:setTouchEnabled(leftList, true)
	GUI:setTag(leftList, 0)

	-- Create leftBtn1
	local leftBtn1 = GUI:Image_Create(leftList, "leftBtn1", 0, 398, "res/custom/dayeqian2.png")
	GUI:setAnchorPoint(leftBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn1, false)
	GUI:setTag(leftBtn1, 0)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create tipsBtn
	local tipsBtn = GUI:Button_Create(midNode, "tipsBtn", 532, 458, "res/custom/npc/33zb/an_sx.png")
	GUI:setContentSize(tipsBtn, 34, 34)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn, false)
	GUI:Button_setTitleText(tipsBtn, [[]])
	GUI:Button_setTitleColor(tipsBtn, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn, 16)
	GUI:Button_titleEnableOutline(tipsBtn, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn, 0.50, 0.50)
	GUI:setTouchEnabled(tipsBtn, true)
	GUI:setTag(tipsBtn, 0)
	GUI:setVisible(tipsBtn, false)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameLayout, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create nowName
	local nowName = GUI:Text_Create(rightNode, "nowName", 678, 372, 16, "#00ff00", [[]])
	GUI:Text_enableOutline(nowName, "#000000", 1)
	GUI:setAnchorPoint(nowName, 0.50, 0.50)
	GUI:setTouchEnabled(nowName, false)
	GUI:setTag(nowName, 0)

	-- Create hasBigList
	local hasBigList = GUI:ListView_Create(rightNode, "hasBigList", 683, 244, 244, 190, 1)
	GUI:ListView_setBounceEnabled(hasBigList, true)
	GUI:ListView_setGravity(hasBigList, 2)
	GUI:ListView_setItemsMargin(hasBigList, 3)
	GUI:setAnchorPoint(hasBigList, 0.50, 0.50)
	GUI:setTouchEnabled(hasBigList, true)
	GUI:setTag(hasBigList, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(hasBigList, "ListView_1", -1, 130, 246, 60, 2)
	GUI:ListView_setGravity(ListView_1, 3)
	GUI:ListView_setItemsMargin(ListView_1, 1)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)
	GUI:setVisible(ListView_1, false)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(ListView_1, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(ListView_1, "Image_3", 60, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(ListView_1, "Image_5", 120, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(ListView_1, "Image_6", 180, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(hasBigList, "ListView_2", -1, 67, 246, 60, 2)
	GUI:ListView_setGravity(ListView_2, 3)
	GUI:ListView_setItemsMargin(ListView_2, 1)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 0)
	GUI:setVisible(ListView_2, false)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_2, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_2, "Image_3", 60, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_2, "Image_5", 120, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_2, "Image_6", 180, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create ListView_3
	local ListView_3 = GUI:ListView_Create(hasBigList, "ListView_3", -1, 4, 246, 60, 2)
	GUI:ListView_setGravity(ListView_3, 3)
	GUI:ListView_setItemsMargin(ListView_3, 1)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)
	GUI:setVisible(ListView_3, false)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_3, "Image_2", 0, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_3, "Image_3", 60, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_3, "Image_5", 120, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	Image_6 = GUI:Image_Create(ListView_3, "Image_6", 180, 0, "res/custom/k1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightNode, "upBtn", 679, 68, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开启外显]])
	GUI:Button_setTitleColor(upBtn, "#F8E6C6")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
