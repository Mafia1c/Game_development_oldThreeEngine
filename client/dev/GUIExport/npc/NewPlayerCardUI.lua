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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/39zbzl/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 821, 482, "res/public/1900000510.png")
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

	-- Create startBtn
	local startBtn = GUI:Button_Create(FrameLayout, "startBtn", 657, 109, "res/custom/npc/39zbzl/an.png")
	GUI:setContentSize(startBtn, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(startBtn, false)
	GUI:Button_setTitleText(startBtn, [[]])
	GUI:Button_setTitleColor(startBtn, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn, 18)
	GUI:Button_titleEnableOutline(startBtn, "#000000", 1)
	GUI:setAnchorPoint(startBtn, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn, true)
	GUI:setTag(startBtn, 0)

	-- Create itemNode
	local itemNode = GUI:Node_Create(FrameLayout, "itemNode", 209, 290)
	GUI:setTag(itemNode, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(itemNode, "ItemShow_1", -104, -5, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(itemNode, "ItemShow_2", -34, -5, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(itemNode, "ItemShow_3", 34, -5, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(itemNode, "ItemShow_4", 103, -5, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(itemNode, "ItemShow_5", -104, -72, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(itemNode, "ItemShow_6", -34, -72, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(itemNode, "ItemShow_7", 34, -72, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(itemNode, "ItemShow_8", 103, -72, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(itemNode, "ItemShow_9", -104, -137, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setTag(ItemShow_9, 0)

	-- Create ItemShow_10
	local ItemShow_10 = GUI:ItemShow_Create(itemNode, "ItemShow_10", -34, -137, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_10, 0.50, 0.50)
	GUI:setTag(ItemShow_10, 0)

	-- Create ItemShow_11
	local ItemShow_11 = GUI:ItemShow_Create(itemNode, "ItemShow_11", 34, -137, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_11, 0.50, 0.50)
	GUI:setTag(ItemShow_11, 0)

	-- Create ItemShow_12
	local ItemShow_12 = GUI:ItemShow_Create(itemNode, "ItemShow_12", 103, -137, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_12, 0.50, 0.50)
	GUI:setTag(ItemShow_12, 0)

	-- Create txtNode
	local txtNode = GUI:Node_Create(FrameLayout, "txtNode", 460, 314)
	GUI:setTag(txtNode, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(txtNode, "Text_1", -70, 53, 16, "#00ff00", [[打怪爆率 +50%]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(txtNode, "Text_2", -70, 17, 16, "#00ff00", [[打怪经验 +50%]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(txtNode, "Text_3", -70, -13, 16, "#00ff00", [[回收经验 +50%]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(txtNode, "Text_4", -70, -46, 16, "#00ff00", [[三倍经验卷轴]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(txtNode, "Text_5", -70, -76, 16, "#00ff00", [[高级职业技能书]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(txtNode, "Text_6", -94, -160, 16, "#00ffe8", [[当前区服:]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(txtNode, "Text_7", -95, -199, 16, "#00ffe8", [[角色名字:]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.00, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)

	-- Create Text_8
	local Text_8 = GUI:Text_Create(txtNode, "Text_8", -95, -237, 16, "#00ffe8", [[玩家状态:]])
	GUI:Text_enableOutline(Text_8, "#000000", 1)
	GUI:setAnchorPoint(Text_8, 0.00, 0.00)
	GUI:setTouchEnabled(Text_8, false)
	GUI:setTag(Text_8, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 487, 404, 0, 20686, 0, 0, 0, 1)
	GUI:setScale(Effect_1, 1.20)
	GUI:setTag(Effect_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
