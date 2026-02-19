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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/50ldxr/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create leftNode
	local leftNode = GUI:Node_Create(FrameBG, "leftNode", 0, 0)
	GUI:setTag(leftNode, 0)

	-- Create effect
	local effect = GUI:Effect_Create(leftNode, "effect", 88, 479, 0, 46140, 0, 0, 0, 1)
	GUI:setTag(effect, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameBG, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create arrowImg
	local arrowImg = GUI:Image_Create(rightNode, "arrowImg", 700, 220, "res/custom/npc/50ldxr/an_0.png")
	GUI:setContentSize(arrowImg, 48, 38)
	GUI:setIgnoreContentAdaptWithSize(arrowImg, false)
	GUI:setAnchorPoint(arrowImg, 0.50, 0.50)
	GUI:setTouchEnabled(arrowImg, false)
	GUI:setTag(arrowImg, 0)

	-- Create item_1
	local item_1 = GUI:ItemShow_Create(rightNode, "item_1", 570, 220, {index = 15, count = 100000, look = true, bgVisible = true})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create item_2
	local item_2 = GUI:ItemShow_Create(rightNode, "item_2", 638, 220, {index = 5, count = 1000000, look = true, bgVisible = true})
	GUI:setAnchorPoint(item_2, 0.50, 0.50)
	GUI:setTag(item_2, 0)

	-- Create item_3
	local item_3 = GUI:ItemShow_Create(rightNode, "item_3", 756, 220, {index = 10438, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(item_3, 0.50, 0.50)
	GUI:setTag(item_3, 0)

	-- Create needText
	local needText = GUI:Text_Create(rightNode, "needText", 666, 130, 16, "#ffff00", [[需要：大宗师境界 + 79级]])
	GUI:Text_enableOutline(needText, "#000000", 1)
	GUI:setAnchorPoint(needText, 0.50, 0.50)
	GUI:setTouchEnabled(needText, false)
	GUI:setTag(needText, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightNode, "upBtn", 666, 74, "res/custom/npc/50ldxr/an1.png")
	GUI:setContentSize(upBtn, 156, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 16)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create activeImg
	local activeImg = GUI:Image_Create(rightNode, "activeImg", 668, 82, "res/custom/tag/y_106.png")
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
