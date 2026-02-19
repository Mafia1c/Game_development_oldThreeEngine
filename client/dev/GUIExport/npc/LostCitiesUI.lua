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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 856, 514, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/73mszc/bg2.png")
	GUI:Image_setScale9Slice(FrameBG, 85, 85, 171, 171)
	GUI:setContentSize(FrameBG, 856, 514)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create blInfo
	local blInfo = GUI:Node_Create(FrameLayout, "blInfo", 449, 240)
	GUI:setTag(blInfo, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(blInfo, "ItemShow_1", -143, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(blInfo, "ItemShow_2", -78, 1, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(blInfo, "ItemShow_3", -14, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(blInfo, "ItemShow_4", 50, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(blInfo, "ItemShow_5", 113, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 801, 393, "res/custom/closeBtn2.png")
	GUI:setContentSize(closeBtn, 46, 46)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create joinBtn
	local joinBtn = GUI:Button_Create(FrameLayout, "joinBtn", 352, 14, "res/custom/npc/73mszc/an.png")
	GUI:setContentSize(joinBtn, 130, 40)
	GUI:setIgnoreContentAdaptWithSize(joinBtn, false)
	GUI:Button_setTitleText(joinBtn, [[]])
	GUI:Button_setTitleColor(joinBtn, "#ffffff")
	GUI:Button_setTitleFontSize(joinBtn, 16)
	GUI:Button_titleEnableOutline(joinBtn, "#000000", 1)
	GUI:setAnchorPoint(joinBtn, 0.00, 0.00)
	GUI:setTouchEnabled(joinBtn, true)
	GUI:setTag(joinBtn, 0)

	-- Create buyItem
	local buyItem = GUI:ItemShow_Create(FrameLayout, "buyItem", 353, 152, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(buyItem, 0.50, 0.50)
	GUI:setTag(buyItem, 0)

	-- Create buyBtn
	local buyBtn = GUI:Button_Create(FrameLayout, "buyBtn", 420, 112, "res/custom/bt_dz.png")
	GUI:setContentSize(buyBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(buyBtn, false)
	GUI:Button_setTitleText(buyBtn, [[购买随机]])
	GUI:Button_setTitleColor(buyBtn, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn, 18)
	GUI:Button_titleEnableOutline(buyBtn, "#000000", 1)
	GUI:setAnchorPoint(buyBtn, 0.00, 0.00)
	GUI:setTouchEnabled(buyBtn, true)
	GUI:setTag(buyBtn, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 431, 164, 18, "#ffff00", [[灵符x500]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 232, 80, 16, "#ffff00", [[进入条件:]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 307, 80, 16, "#00ff00", [[五倍秘境卷轴*1     终身特权      每秒扣金刚石x2]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(FrameLayout, "Text_4", 247, 58, 16, "#00ff00", [[跨服地图每次停留限时30分钟(小退或死亡退出跨服)。]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
