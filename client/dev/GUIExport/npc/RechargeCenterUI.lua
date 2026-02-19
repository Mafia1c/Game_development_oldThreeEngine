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
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 336, 130, 460, 314, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create layout
	local layout = GUI:Layout_Create(FrameLayout, "layout", 0, 0, 460, 314, true)
	GUI:setAnchorPoint(layout, 0.00, 0.00)
	GUI:setTouchEnabled(layout, false)
	GUI:setTag(layout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(layout, "bg_Image", 0, 0, "res/custom/npc/28cz/bg.png")
	GUI:setContentSize(bg_Image, 460, 314)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create textNode
	local textNode = GUI:Node_Create(layout, "textNode", 230, 186)
	GUI:setTag(textNode, 0)

	-- Create typeText1
	local typeText1 = GUI:Text_Create(textNode, "typeText1", 0, 0, 18, "#00ff00", [[充值项目：]])
	GUI:Text_enableOutline(typeText1, "#000000", 1)
	GUI:setAnchorPoint(typeText1, 0.00, 0.00)
	GUI:setTouchEnabled(typeText1, false)
	GUI:setTag(typeText1, 0)

	-- Create needMoney2
	local needMoney2 = GUI:Text_Create(textNode, "needMoney2", 0, 0, 18, "#00ff00", [[本次项目金额：]])
	GUI:Text_enableOutline(needMoney2, "#000000", 1)
	GUI:setAnchorPoint(needMoney2, 0.00, 0.00)
	GUI:setTouchEnabled(needMoney2, false)
	GUI:setTag(needMoney2, 0)

	-- Create hasMoney3
	local hasMoney3 = GUI:Text_Create(textNode, "hasMoney3", 0, 0, 18, "#ffff00", [[当前直购点余额：]])
	GUI:Text_enableOutline(hasMoney3, "#000000", 1)
	GUI:setAnchorPoint(hasMoney3, 0.00, 0.00)
	GUI:setTouchEnabled(hasMoney3, false)
	GUI:setTag(hasMoney3, 0)

	-- Create buyBtn
	local buyBtn = GUI:Button_Create(layout, "buyBtn", 230, 70, "res/custom/bt_dz.png")
	GUI:setContentSize(buyBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(buyBtn, false)
	GUI:Button_setTitleText(buyBtn, [[确定充值]])
	GUI:Button_setTitleColor(buyBtn, "#e8dcbd")
	GUI:Button_setTitleFontSize(buyBtn, 16)
	GUI:Button_titleEnableOutline(buyBtn, "#000000", 1)
	GUI:setAnchorPoint(buyBtn, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn, true)
	GUI:setTag(buyBtn, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 495, 314, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 1.00, 1.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
