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

	-- Create LayoutBg
	local LayoutBg = GUI:Image_Create(FrameLayout, "LayoutBg", 0, 0, "res/custom/npc/53slzs/bg2.png")
	GUI:setAnchorPoint(LayoutBg, 0.00, 0.00)
	GUI:setTouchEnabled(LayoutBg, true)
	GUI:setMouseEnabled(LayoutBg, true)
	GUI:setTag(LayoutBg, 0)

	-- Create equipBg
	local equipBg = GUI:Image_Create(FrameLayout, "equipBg", 0, 0, "res/custom/npc/70ah/bg2.png")
	GUI:setContentSize(equipBg, 378, 506)
	GUI:setIgnoreContentAdaptWithSize(equipBg, false)
	GUI:setAnchorPoint(equipBg, 0.00, 0.00)
	GUI:setTouchEnabled(equipBg, false)
	GUI:setTag(equipBg, 0)

	-- Create equipBg_1
	local equipBg_1 = GUI:Image_Create(FrameLayout, "equipBg_1", 28, 342, "res/custom/itemBox.png")
	GUI:setContentSize(equipBg_1, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(equipBg_1, false)
	GUI:setAnchorPoint(equipBg_1, 0.00, 0.00)
	GUI:setTouchEnabled(equipBg_1, false)
	GUI:setTag(equipBg_1, 0)

	-- Create equipBg_2
	local equipBg_2 = GUI:Image_Create(FrameLayout, "equipBg_2", 292, 342, "res/custom/itemBox.png")
	GUI:setContentSize(equipBg_2, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(equipBg_2, false)
	GUI:setAnchorPoint(equipBg_2, 0.00, 0.00)
	GUI:setTouchEnabled(equipBg_2, false)
	GUI:setTag(equipBg_2, 0)

	-- Create equipBg_3
	local equipBg_3 = GUI:Image_Create(FrameLayout, "equipBg_3", 28, 184, "res/custom/itemBox.png")
	GUI:setContentSize(equipBg_3, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(equipBg_3, false)
	GUI:setAnchorPoint(equipBg_3, 0.00, 0.00)
	GUI:setTouchEnabled(equipBg_3, false)
	GUI:setTag(equipBg_3, 0)

	-- Create equipBg_4
	local equipBg_4 = GUI:Image_Create(FrameLayout, "equipBg_4", 292, 184, "res/custom/itemBox.png")
	GUI:setContentSize(equipBg_4, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(equipBg_4, false)
	GUI:setAnchorPoint(equipBg_4, 0.00, 0.00)
	GUI:setTouchEnabled(equipBg_4, false)
	GUI:setTag(equipBg_4, 0)

	-- Create equipBg_5
	local equipBg_5 = GUI:Image_Create(FrameLayout, "equipBg_5", 164, 83, "res/custom/itemBox.png")
	GUI:setContentSize(equipBg_5, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(equipBg_5, false)
	GUI:setAnchorPoint(equipBg_5, 0.00, 0.00)
	GUI:setTouchEnabled(equipBg_5, false)
	GUI:setTag(equipBg_5, 0)

	-- Create EquipShow_1
	local EquipShow_1 = GUI:EquipShow_Create(FrameLayout, "EquipShow_1", 58, 372, 97, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = true, lookPlayer = false, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_1)
	GUI:setAnchorPoint(EquipShow_1, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_1, false)
	GUI:setTag(EquipShow_1, 0)

	-- Create EquipShow_2
	local EquipShow_2 = GUI:EquipShow_Create(FrameLayout, "EquipShow_2", 322, 372, 98, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = true, lookPlayer = false, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_2)
	GUI:setAnchorPoint(EquipShow_2, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_2, false)
	GUI:setTag(EquipShow_2, 0)

	-- Create EquipShow_3
	local EquipShow_3 = GUI:EquipShow_Create(FrameLayout, "EquipShow_3", 58, 214, 95, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = true, lookPlayer = false, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_3)
	GUI:setAnchorPoint(EquipShow_3, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_3, false)
	GUI:setTag(EquipShow_3, 0)

	-- Create EquipShow_4
	local EquipShow_4 = GUI:EquipShow_Create(FrameLayout, "EquipShow_4", 322, 213, 96, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = true, lookPlayer = false, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_4)
	GUI:setAnchorPoint(EquipShow_4, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_4, false)
	GUI:setTag(EquipShow_4, 0)

	-- Create EquipShow_5
	local EquipShow_5 = GUI:EquipShow_Create(FrameLayout, "EquipShow_5", 194, 111, 99, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = true, lookPlayer = false, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_5)
	GUI:setAnchorPoint(EquipShow_5, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_5, false)
	GUI:setTag(EquipShow_5, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
