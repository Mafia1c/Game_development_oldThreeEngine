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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 854, 500, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/73mszc/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 85, 85, 166, 166)
	GUI:setContentSize(FrameBG, 854, 500)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 809, 412, "res/custom/closeBtn2.png")
	GUI:setContentSize(closeBtn, 46, 46)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 196, 414, 0, 15014, 0, 0, 0, 1)
	GUI:setScale(Effect_1, 0.60)
	GUI:setTag(Effect_1, 0)

	-- Create exchange1_btn
	local exchange1_btn = GUI:Button_Create(FrameLayout, "exchange1_btn", 366, 81, "res/custom/an1.png")
	GUI:setContentSize(exchange1_btn, 84, 36)
	GUI:setIgnoreContentAdaptWithSize(exchange1_btn, false)
	GUI:Button_setTitleText(exchange1_btn, [[]])
	GUI:Button_setTitleColor(exchange1_btn, "#ffffff")
	GUI:Button_setTitleFontSize(exchange1_btn, 16)
	GUI:Button_titleEnableOutline(exchange1_btn, "#000000", 1)
	GUI:setAnchorPoint(exchange1_btn, 0.00, 0.00)
	GUI:setTouchEnabled(exchange1_btn, true)
	GUI:setTag(exchange1_btn, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 316, 96, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create exchange2_btn
	local exchange2_btn = GUI:Button_Create(FrameLayout, "exchange2_btn", 720, 173, "res/custom/an1.png")
	GUI:setContentSize(exchange2_btn, 84, 36)
	GUI:setIgnoreContentAdaptWithSize(exchange2_btn, false)
	GUI:Button_setTitleText(exchange2_btn, [[]])
	GUI:Button_setTitleColor(exchange2_btn, "#ffffff")
	GUI:Button_setTitleFontSize(exchange2_btn, 16)
	GUI:Button_titleEnableOutline(exchange2_btn, "#000000", 1)
	GUI:setAnchorPoint(exchange2_btn, 0.00, 0.00)
	GUI:setTouchEnabled(exchange2_btn, true)
	GUI:setTag(exchange2_btn, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 521, 202, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(FrameLayout, "ItemShow_3", 591, 202, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(FrameLayout, "ItemShow_4", 663, 202, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create buy_btn
	local buy_btn = GUI:Button_Create(FrameLayout, "buy_btn", 721, 81, "res/custom/an2.png")
	GUI:setContentSize(buy_btn, 84, 36)
	GUI:setIgnoreContentAdaptWithSize(buy_btn, false)
	GUI:Button_setTitleText(buy_btn, [[]])
	GUI:Button_setTitleColor(buy_btn, "#ffffff")
	GUI:Button_setTitleFontSize(buy_btn, 16)
	GUI:Button_titleEnableOutline(buy_btn, "#000000", 1)
	GUI:setAnchorPoint(buy_btn, 0.00, 0.00)
	GUI:setTouchEnabled(buy_btn, true)
	GUI:setTag(buy_btn, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(FrameLayout, "ItemShow_5", 521, 109, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(FrameLayout, "ItemShow_6", 591, 109, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(FrameLayout, "ItemShow_7", 663, 109, {index = 1, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create joinBtn_1
	local joinBtn_1 = GUI:Button_Create(FrameLayout, "joinBtn_1", 484, 26, "res/custom/npc/73mszc/an1.png")
	GUI:setContentSize(joinBtn_1, 160, 40)
	GUI:setIgnoreContentAdaptWithSize(joinBtn_1, false)
	GUI:Button_setTitleText(joinBtn_1, [[]])
	GUI:Button_setTitleColor(joinBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(joinBtn_1, 16)
	GUI:Button_titleEnableOutline(joinBtn_1, "#000000", 1)
	GUI:setAnchorPoint(joinBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(joinBtn_1, true)
	GUI:setTag(joinBtn_1, 0)

	-- Create joinBtn_2
	local joinBtn_2 = GUI:Button_Create(FrameLayout, "joinBtn_2", 654, 27, "res/custom/npc/73mszc/an2.png")
	GUI:setContentSize(joinBtn_2, 160, 40)
	GUI:setIgnoreContentAdaptWithSize(joinBtn_2, false)
	GUI:Button_setTitleText(joinBtn_2, [[]])
	GUI:Button_setTitleColor(joinBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(joinBtn_2, 16)
	GUI:Button_titleEnableOutline(joinBtn_2, "#000000", 1)
	GUI:setAnchorPoint(joinBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(joinBtn_2, true)
	GUI:setTag(joinBtn_2, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 724, 123, 16, "#ffff00", [[直购:  29元]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 720, 213, 16, "#ffff00", [[每日:  0/3次]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Node_1
	local Node_1 = GUI:Node_Create(FrameLayout, "Node_1", 364, 262)
	GUI:setTag(Node_1, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(Node_1, "ItemShow_8", 0, 0, {index = 10496, count = 1, look = true, bgVisible = true})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(Node_1, "Text_5", -39, 41, 16, "#ffff00", [[恶魔令兑换]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Panel_mask
	local Panel_mask = GUI:Layout_Create(parent, "Panel_mask", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(Panel_mask, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_mask, true)
	GUI:setTag(Panel_mask, 0)
	GUI:setVisible(Panel_mask, false)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Panel_mask, "Image_1", 568, 320, "res/public/1900000600.png")
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create buy1_btn
	local buy1_btn = GUI:Button_Create(Panel_mask, "buy1_btn", 430, 265, "res/public/1900000662.png")
	GUI:setContentSize(buy1_btn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(buy1_btn, false)
	GUI:Button_setTitleText(buy1_btn, [[购买一次]])
	GUI:Button_setTitleColor(buy1_btn, "#ffffff")
	GUI:Button_setTitleFontSize(buy1_btn, 16)
	GUI:Button_titleEnableOutline(buy1_btn, "#000000", 1)
	GUI:setAnchorPoint(buy1_btn, 0.00, 0.00)
	GUI:setTouchEnabled(buy1_btn, true)
	GUI:setTag(buy1_btn, 0)

	-- Create buy10_btn
	local buy10_btn = GUI:Button_Create(Panel_mask, "buy10_btn", 610, 265, "res/public/1900000662.png")
	GUI:setContentSize(buy10_btn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(buy10_btn, false)
	GUI:Button_setTitleText(buy10_btn, [[购买十次]])
	GUI:Button_setTitleColor(buy10_btn, "#ffffff")
	GUI:Button_setTitleFontSize(buy10_btn, 16)
	GUI:Button_titleEnableOutline(buy10_btn, "#000000", 1)
	GUI:setAnchorPoint(buy10_btn, 0.00, 0.00)
	GUI:setTouchEnabled(buy10_btn, true)
	GUI:setTag(buy10_btn, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(Panel_mask, "Text_3", 503, 363, 18, "#9b00ff", [[<<购买恶魔令>>]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(Panel_mask, "Text_4", 507, 328, 18, "#ffff00", [[礼包价格: 29元]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Panel_mask, "Button_1", 792, 368, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(Button_1, "res/public/1900000511.png")
	GUI:setContentSize(Button_1, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
