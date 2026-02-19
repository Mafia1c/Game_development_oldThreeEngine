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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 748, 474, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/54dt/fb1.png")
	GUI:Image_setScale9Slice(FrameBG, 74, 74, 158, 158)
	GUI:setContentSize(FrameBG, 748, 474)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create mapInfo
	local mapInfo = GUI:Node_Create(FrameLayout, "mapInfo", 529, 312)
	GUI:setTag(mapInfo, 0)

	-- Create blInfo
	local blInfo = GUI:Node_Create(FrameLayout, "blInfo", 529, 188)
	GUI:setTag(blInfo, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(blInfo, "ItemShow_1", -163, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(blInfo, "ItemShow_2", -88, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(blInfo, "ItemShow_3", -14, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(blInfo, "ItemShow_4", 60, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(blInfo, "ItemShow_5", 133, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create bottomInfo
	local bottomInfo = GUI:Node_Create(FrameLayout, "bottomInfo", 488, 98)
	GUI:setTag(bottomInfo, 0)

	-- Create enterGB1Btn
	local enterGB1Btn = GUI:Button_Create(FrameLayout, "enterGB1Btn", 590, 100, "res/public/1900000673.png")
	GUI:setContentSize(enterGB1Btn, 92, 35)
	GUI:setIgnoreContentAdaptWithSize(enterGB1Btn, false)
	GUI:Button_setTitleText(enterGB1Btn, [[挑战本服]])
	GUI:Button_setTitleColor(enterGB1Btn, "#00ff00")
	GUI:Button_setTitleFontSize(enterGB1Btn, 18)
	GUI:Button_titleEnableOutline(enterGB1Btn, "#000000", 1)
	GUI:setAnchorPoint(enterGB1Btn, 0.00, 0.00)
	GUI:setTouchEnabled(enterGB1Btn, true)
	GUI:setTag(enterGB1Btn, 0)

	-- Create enterGB2Btn
	local enterGB2Btn = GUI:Button_Create(FrameLayout, "enterGB2Btn", 590, 55, "res/public/1900000673.png")
	GUI:setContentSize(enterGB2Btn, 92, 35)
	GUI:setIgnoreContentAdaptWithSize(enterGB2Btn, false)
	GUI:Button_setTitleText(enterGB2Btn, [[挑战跨服]])
	GUI:Button_setTitleColor(enterGB2Btn, "#00ff00")
	GUI:Button_setTitleFontSize(enterGB2Btn, 18)
	GUI:Button_titleEnableOutline(enterGB2Btn, "#000000", 1)
	GUI:setAnchorPoint(enterGB2Btn, 0.00, 0.00)
	GUI:setTouchEnabled(enterGB2Btn, true)
	GUI:setTag(enterGB2Btn, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 685, 367, "res/custom/npc/54dt/sc_close.png")
	GUI:setContentSize(closeBtn, 45, 47)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
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
