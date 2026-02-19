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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 748, 474, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/31mb/mibaobz.png")
	GUI:Image_setScale9Slice(FrameBG, 73, 73, 149, 149)
	GUI:setContentSize(FrameBG, 731, 448)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create blInfo
	local blInfo = GUI:Node_Create(FrameLayout, "blInfo", 433, 252)
	GUI:setTag(blInfo, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(blInfo, "ItemShow_1", -140, -1, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create item_name_1
	local item_name_1 = GUI:Text_Create(ItemShow_1, "item_name_1", 29, -26, 18, "#ffff00", [[文本]])
	GUI:Text_enableOutline(item_name_1, "#000000", 1)
	GUI:setAnchorPoint(item_name_1, 0.50, 0.00)
	GUI:setTouchEnabled(item_name_1, false)
	GUI:setTag(item_name_1, 0)

	-- Create info_1
	local info_1 = GUI:Text_Create(ItemShow_1, "info_1", 29, -45, 16, "#00ff00", [[2/3]])
	GUI:Text_enableOutline(info_1, "#000000", 1)
	GUI:setAnchorPoint(info_1, 0.50, 0.00)
	GUI:setTouchEnabled(info_1, false)
	GUI:setTag(info_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(blInfo, "ItemShow_2", -50, 0, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create item_name_2
	local item_name_2 = GUI:Text_Create(ItemShow_2, "item_name_2", 29, -26, 18, "#ffff00", [[文本]])
	GUI:Text_enableOutline(item_name_2, "#000000", 1)
	GUI:setAnchorPoint(item_name_2, 0.50, 0.00)
	GUI:setTouchEnabled(item_name_2, false)
	GUI:setTag(item_name_2, 0)

	-- Create info_2
	local info_2 = GUI:Text_Create(ItemShow_2, "info_2", 29, -45, 16, "#00ff00", [[2/3]])
	GUI:Text_enableOutline(info_2, "#000000", 1)
	GUI:setAnchorPoint(info_2, 0.50, 0.00)
	GUI:setTouchEnabled(info_2, false)
	GUI:setTag(info_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(blInfo, "ItemShow_3", 40, 0, {index = 1, count = 1, look = false, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create item_name_3
	local item_name_3 = GUI:Text_Create(ItemShow_3, "item_name_3", 29, -26, 18, "#ffff00", [[文本]])
	GUI:Text_enableOutline(item_name_3, "#000000", 1)
	GUI:setAnchorPoint(item_name_3, 0.50, 0.00)
	GUI:setTouchEnabled(item_name_3, false)
	GUI:setTag(item_name_3, 0)

	-- Create info_3
	local info_3 = GUI:Text_Create(ItemShow_3, "info_3", 29, -45, 16, "#00ff00", [[2/3]])
	GUI:Text_enableOutline(info_3, "#000000", 1)
	GUI:setAnchorPoint(info_3, 0.50, 0.00)
	GUI:setTouchEnabled(info_3, false)
	GUI:setTag(info_3, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(blInfo, "Text_2", -194, 31, 18, "#00ffe8", [[收集一下足够物品:]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create pickTaskBtn
	local pickTaskBtn = GUI:Button_Create(FrameLayout, "pickTaskBtn", 413, 89, "res/custom/npc/31mb/btn_login_quit.png")
	GUI:Button_loadTexturePressed(pickTaskBtn, "res/custom/npc/31mb/btn_login_quit_01.png")
	GUI:setContentSize(pickTaskBtn, 146, 48)
	GUI:setIgnoreContentAdaptWithSize(pickTaskBtn, false)
	GUI:Button_setTitleText(pickTaskBtn, [[接收宝藏人物]])
	GUI:Button_setTitleColor(pickTaskBtn, "#00ff00")
	GUI:Button_setTitleFontSize(pickTaskBtn, 18)
	GUI:Button_titleEnableOutline(pickTaskBtn, "#000000", 1)
	GUI:setAnchorPoint(pickTaskBtn, 0.50, 0.00)
	GUI:setTouchEnabled(pickTaskBtn, true)
	GUI:setTag(pickTaskBtn, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 611, 335, "res/custom/npc/54dt/sc_close.png")
	GUI:setContentSize(closeBtn, 45, 47)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 66, 141, 0, 27589, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create icon_tag
	local icon_tag = GUI:Image_Create(FrameLayout, "icon_tag", 365, 87, "res/custom/tag/c_06.png")
	GUI:setAnchorPoint(icon_tag, 0.00, 0.00)
	GUI:setTouchEnabled(icon_tag, false)
	GUI:setTag(icon_tag, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
