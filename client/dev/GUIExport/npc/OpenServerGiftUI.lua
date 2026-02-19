local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 0, 0, "res/custom/npc/20fl/017fldt5/bg.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, true)
	GUI:setMouseEnabled(Image_1, true)
	GUI:setTag(Image_1, 0)

	-- Create open_server_list
	local open_server_list = GUI:ScrollView_Create(FrameLayout, "open_server_list", 76, 406, 722, 279, 1)
	GUI:ScrollView_setBounceEnabled(open_server_list, true)
	GUI:ScrollView_setInnerContainerSize(open_server_list, 722.00, 352.00)
	GUI:setAnchorPoint(open_server_list, 0.00, 1.00)
	GUI:setTouchEnabled(open_server_list, true)
	GUI:setTag(open_server_list, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 159, 64, 16, "#00ff00", [[购买需非绑灵符x580，可立即获得：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 445, 75, {index = 10204, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 516, 75, {index = 10134, count = 188, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create op_server_buy_btn
	local op_server_buy_btn = GUI:Button_Create(FrameLayout, "op_server_buy_btn", 623, 53, "res/custom/npc/20fl/017fldt8/gmth.png")
	GUI:setContentSize(op_server_buy_btn, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(op_server_buy_btn, false)
	GUI:Button_setTitleText(op_server_buy_btn, [[]])
	GUI:Button_setTitleColor(op_server_buy_btn, "#ffffff")
	GUI:Button_setTitleFontSize(op_server_buy_btn, 16)
	GUI:Button_titleEnableOutline(op_server_buy_btn, "#000000", 1)
	GUI:setAnchorPoint(op_server_buy_btn, 0.00, 0.00)
	GUI:setTouchEnabled(op_server_buy_btn, true)
	GUI:setTag(op_server_buy_btn, 0)

	-- Create op_server_has_get
	local op_server_has_get = GUI:Image_Create(FrameLayout, "op_server_has_get", 637, 59, "res/custom/tag/ok.png")
	GUI:setAnchorPoint(op_server_has_get, 0.00, 0.00)
	GUI:setTouchEnabled(op_server_has_get, false)
	GUI:setTag(op_server_has_get, 0)
	GUI:setVisible(op_server_has_get, false)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 818, 488, "res/custom/closeBtn.png")
	GUI:setContentSize(close_btn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleDisableOutLine(close_btn)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
