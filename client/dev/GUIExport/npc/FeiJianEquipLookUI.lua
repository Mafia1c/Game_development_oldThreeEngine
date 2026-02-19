local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 370, 65, 378, 506, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 378, 464, "res/public/1900000510.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create equipBg
	local equipBg = GUI:Image_Create(FrameLayout, "equipBg", 0, 0, "res/custom/npc/111kfsc/fjbg.png")
	GUI:setContentSize(equipBg, 380, 506)
	GUI:setIgnoreContentAdaptWithSize(equipBg, false)
	GUI:setAnchorPoint(equipBg, 0.00, 0.00)
	GUI:setTouchEnabled(equipBg, false)
	GUI:setTag(equipBg, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 1, 0, "res/custom/npc/53slzs/icon.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create EquipShow_1
	local EquipShow_1 = GUI:EquipShow_Create(FrameLayout, "EquipShow_1", 58, 372, 71, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = true, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_1)
	GUI:setAnchorPoint(EquipShow_1, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_1, false)
	GUI:setTag(EquipShow_1, 0)

	-- Create EquipShow_2
	local EquipShow_2 = GUI:EquipShow_Create(FrameLayout, "EquipShow_2", 322, 371, 72, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = true, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_2)
	GUI:setAnchorPoint(EquipShow_2, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_2, false)
	GUI:setTag(EquipShow_2, 0)

	-- Create EquipShow_3
	local EquipShow_3 = GUI:EquipShow_Create(FrameLayout, "EquipShow_3", 58, 283, 73, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = true, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_3)
	GUI:setAnchorPoint(EquipShow_3, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_3, false)
	GUI:setTag(EquipShow_3, 0)

	-- Create EquipShow_4
	local EquipShow_4 = GUI:EquipShow_Create(FrameLayout, "EquipShow_4", 323, 283, 74, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = true, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_4)
	GUI:setAnchorPoint(EquipShow_4, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_4, false)
	GUI:setTag(EquipShow_4, 0)

	-- Create EquipShow_5
	local EquipShow_5 = GUI:EquipShow_Create(FrameLayout, "EquipShow_5", 58, 195, 117, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = true, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_5)
	GUI:setAnchorPoint(EquipShow_5, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_5, false)
	GUI:setTag(EquipShow_5, 0)

	-- Create EquipShow_6
	local EquipShow_6 = GUI:EquipShow_Create(FrameLayout, "EquipShow_6", 322, 195, 118, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = true, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_6)
	GUI:setAnchorPoint(EquipShow_6, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_6, false)
	GUI:setTag(EquipShow_6, 0)

	-- Create EquipShow_7
	local EquipShow_7 = GUI:EquipShow_Create(FrameLayout, "EquipShow_7", 58, 107, 119, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = true, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_7)
	GUI:setAnchorPoint(EquipShow_7, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_7, false)
	GUI:setTag(EquipShow_7, 0)

	-- Create EquipShow_8
	local EquipShow_8 = GUI:EquipShow_Create(FrameLayout, "EquipShow_8", 322, 108, 120, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = true, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_8)
	GUI:setAnchorPoint(EquipShow_8, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_8, false)
	GUI:setTag(EquipShow_8, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
