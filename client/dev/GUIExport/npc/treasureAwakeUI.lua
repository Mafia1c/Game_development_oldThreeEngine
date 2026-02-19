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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/80slmb/bg.png")
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

	-- Create equipName
	local equipName = GUI:Text_Create(leftNode, "equipName", 288, 466, 16, "#ff0000", [[文本]])
	GUI:Text_enableOutline(equipName, "#000000", 1)
	GUI:setAnchorPoint(equipName, 0.50, 0.50)
	GUI:setTouchEnabled(equipName, false)
	GUI:setTag(equipName, 0)

	-- Create starText
	local starText = GUI:Text_Create(leftNode, "starText", 330, 244, 16, "#00ff00", [[0星]])
	GUI:Text_enableOutline(starText, "#000000", 1)
	GUI:setAnchorPoint(starText, 0.00, 0.00)
	GUI:setTouchEnabled(starText, false)
	GUI:setTag(starText, 0)

	-- Create oddText
	local oddText = GUI:Text_Create(leftNode, "oddText", 330, 214, 16, "#ffff00", [[80%]])
	GUI:Text_enableOutline(oddText, "#000000", 1)
	GUI:setAnchorPoint(oddText, 0.00, 0.00)
	GUI:setTouchEnabled(oddText, false)
	GUI:setTag(oddText, 0)

	-- Create tipsText1
	local tipsText1 = GUI:Text_Create(leftNode, "tipsText1", 98, 54, 16, "#ffffff", [[说明：]])
	GUI:Text_enableOutline(tipsText1, "#000000", 1)
	GUI:setAnchorPoint(tipsText1, 0.50, 0.50)
	GUI:setTouchEnabled(tipsText1, false)
	GUI:setTag(tipsText1, 0)

	-- Create tipsText2
	local tipsText2 = GUI:Text_Create(tipsText1, "tipsText2", 42, 0, 16, "#ffff00", [[只有继承过至少5条属性的绝品或孤品秘宝可以觉醒，觉醒属性更换装备不会保留]])
	GUI:Text_enableOutline(tipsText2, "#000000", 1)
	GUI:setAnchorPoint(tipsText2, 0.00, 0.00)
	GUI:setTouchEnabled(tipsText2, false)
	GUI:setTag(tipsText2, 0)

	-- Create equipItem
	local equipItem = GUI:EquipShow_Create(leftNode, "equipItem", 290, 359, 0, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = false, showModelEffect = false})
	GUI:setAnchorPoint(equipItem, 0.50, 0.50)
	GUI:setTouchEnabled(equipItem, false)
	GUI:setTag(equipItem, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameBG, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create needBox
	local needBox = GUI:Layout_Create(rightNode, "needBox", 662, 186, 60, 60, false)
	GUI:setAnchorPoint(needBox, 0.50, 0.50)
	GUI:setTouchEnabled(needBox, false)
	GUI:setTag(needBox, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightNode, "upBtn", 664, 114, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[秘宝觉醒]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 16)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

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
