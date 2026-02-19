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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/59sxjx/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 77, 77, 172, 172)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 818, 481, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/1900000511.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create equipShow_1
	local equipShow_1 = GUI:ItemShow_Create(FrameLayout, "equipShow_1", 496, 411, {index = 0, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(equipShow_1, 0.50, 0.50)
	GUI:setTag(equipShow_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 460, 254, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 534, 254, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create equip_name
	local equip_name = GUI:Text_Create(FrameLayout, "equip_name", 497, 330, 16, "#ffff00", [[传承·生肖(鼠)]])
	GUI:Text_enableOutline(equip_name, "#000000", 1)
	GUI:setAnchorPoint(equip_name, 0.50, 0.00)
	GUI:setTouchEnabled(equip_name, false)
	GUI:setTag(equip_name, 0)

	-- Create startBtn
	local startBtn = GUI:Button_Create(FrameLayout, "startBtn", 448, 139, "res/custom/npc/59sxjx/an.png")
	GUI:setContentSize(startBtn, 102, 36)
	GUI:setIgnoreContentAdaptWithSize(startBtn, false)
	GUI:Button_setTitleText(startBtn, [[]])
	GUI:Button_setTitleColor(startBtn, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn, 18)
	GUI:Button_titleEnableOutline(startBtn, "#000000", 1)
	GUI:setAnchorPoint(startBtn, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn, true)
	GUI:setTag(startBtn, 0)

	-- Create zodiacBtn
	local zodiacBtn = GUI:Button_Create(FrameLayout, "zodiacBtn", 75, 441, "res/public/xinanniu.png")
	GUI:setContentSize(zodiacBtn, 115, 37)
	GUI:setIgnoreContentAdaptWithSize(zodiacBtn, false)
	GUI:Button_setTitleText(zodiacBtn, [[传承生肖]])
	GUI:Button_setTitleColor(zodiacBtn, "#ffffff")
	GUI:Button_setTitleFontSize(zodiacBtn, 16)
	GUI:Button_titleEnableOutline(zodiacBtn, "#000000", 1)
	GUI:setAnchorPoint(zodiacBtn, 0.00, 0.00)
	GUI:setTouchEnabled(zodiacBtn, true)
	GUI:setTag(zodiacBtn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(zodiacBtn, "Image_1", -5, 8, "res/public/jiantouxia.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create btnList
	local btnList = GUI:ListView_Create(FrameLayout, "btnList", 76, 41, 110, 401, 1)
	GUI:setAnchorPoint(btnList, 0.00, 0.00)
	GUI:setTouchEnabled(btnList, true)
	GUI:setTag(btnList, 0)

	-- Create fj_Btn_1
	local fj_Btn_1 = GUI:Button_Create(FrameLayout, "fj_Btn_1", 541, 54, "res/custom/npc/59sxjx/an1.png")
	GUI:setContentSize(fj_Btn_1, 118, 38)
	GUI:setIgnoreContentAdaptWithSize(fj_Btn_1, false)
	GUI:Button_setTitleText(fj_Btn_1, [[]])
	GUI:Button_setTitleColor(fj_Btn_1, "#ffffff")
	GUI:Button_setTitleFontSize(fj_Btn_1, 18)
	GUI:Button_titleEnableOutline(fj_Btn_1, "#000000", 1)
	GUI:setAnchorPoint(fj_Btn_1, 0.00, 0.00)
	GUI:setTouchEnabled(fj_Btn_1, true)
	GUI:setTag(fj_Btn_1, 0)

	-- Create fj_Btn_2
	local fj_Btn_2 = GUI:Button_Create(FrameLayout, "fj_Btn_2", 677, 54, "res/custom/npc/59sxjx/an2.png")
	GUI:setContentSize(fj_Btn_2, 118, 38)
	GUI:setIgnoreContentAdaptWithSize(fj_Btn_2, false)
	GUI:Button_setTitleText(fj_Btn_2, [[]])
	GUI:Button_setTitleColor(fj_Btn_2, "#ffffff")
	GUI:Button_setTitleFontSize(fj_Btn_2, 18)
	GUI:Button_titleEnableOutline(fj_Btn_2, "#000000", 1)
	GUI:setAnchorPoint(fj_Btn_2, 0.00, 0.00)
	GUI:setTouchEnabled(fj_Btn_2, true)
	GUI:setTag(fj_Btn_2, 0)

	-- Create attrValue
	local attrValue = GUI:Text_Create(FrameLayout, "attrValue", 506, 414, 16, "#00ff00", [[x1]])
	GUI:Text_enableOutline(attrValue, "#000000", 1)
	GUI:setAnchorPoint(attrValue, 0.00, 0.00)
	GUI:setTouchEnabled(attrValue, false)
	GUI:setTag(attrValue, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
