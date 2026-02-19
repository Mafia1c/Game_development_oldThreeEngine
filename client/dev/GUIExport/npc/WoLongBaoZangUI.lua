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
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 0, 0, "res/custom/npc/81wlbz/bg.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, true)
	GUI:setMouseEnabled(Image_1, true)
	GUI:setTag(Image_1, 0)

	-- Create TopBox
	local TopBox = GUI:Layout_Create(Image_1, "TopBox", 71, 156, 445, 324, false)
	GUI:setAnchorPoint(TopBox, 0.00, 0.00)
	GUI:setTouchEnabled(TopBox, false)
	GUI:setTag(TopBox, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(TopBox, "ItemShow_1", 45, 286, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(TopBox, "ItemShow_2", 116, 286, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(TopBox, "ItemShow_3", 188, 286, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(TopBox, "ItemShow_4", 259, 286, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(TopBox, "ItemShow_5", 331, 286, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(TopBox, "ItemShow_6", 402, 286, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(TopBox, "ItemShow_7", 45, 222, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(TopBox, "ItemShow_8", 45, 159, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(TopBox, "ItemShow_9", 45, 95, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setTag(ItemShow_9, 0)

	-- Create ItemShow_10
	local ItemShow_10 = GUI:ItemShow_Create(TopBox, "ItemShow_10", 44, 32, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_10, 0.50, 0.50)
	GUI:setTag(ItemShow_10, 0)

	-- Create ItemShow_11
	local ItemShow_11 = GUI:ItemShow_Create(TopBox, "ItemShow_11", 116, 32, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_11, 0.50, 0.50)
	GUI:setTag(ItemShow_11, 0)

	-- Create ItemShow_12
	local ItemShow_12 = GUI:ItemShow_Create(TopBox, "ItemShow_12", 187, 31, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_12, 0.50, 0.50)
	GUI:setTag(ItemShow_12, 0)

	-- Create ItemShow_13
	local ItemShow_13 = GUI:ItemShow_Create(TopBox, "ItemShow_13", 259, 32, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_13, 0.50, 0.50)
	GUI:setTag(ItemShow_13, 0)

	-- Create ItemShow_14
	local ItemShow_14 = GUI:ItemShow_Create(TopBox, "ItemShow_14", 331, 32, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_14, 0.50, 0.50)
	GUI:setTag(ItemShow_14, 0)

	-- Create ItemShow_15
	local ItemShow_15 = GUI:ItemShow_Create(TopBox, "ItemShow_15", 401, 32, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_15, 0.50, 0.50)
	GUI:setTag(ItemShow_15, 0)

	-- Create ItemShow_16
	local ItemShow_16 = GUI:ItemShow_Create(TopBox, "ItemShow_16", 402, 95, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_16, 0.50, 0.50)
	GUI:setTag(ItemShow_16, 0)

	-- Create ItemShow_17
	local ItemShow_17 = GUI:ItemShow_Create(TopBox, "ItemShow_17", 402, 159, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_17, 0.50, 0.50)
	GUI:setTag(ItemShow_17, 0)

	-- Create ItemShow_18
	local ItemShow_18 = GUI:ItemShow_Create(TopBox, "ItemShow_18", 402, 222, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_18, 0.50, 0.50)
	GUI:setTag(ItemShow_18, 0)

	-- Create TipBtn
	local TipBtn = GUI:Button_Create(TopBox, "TipBtn", 335, 217, "res/public/1900001024.png")
	GUI:setContentSize(TipBtn, 29, 29)
	GUI:setIgnoreContentAdaptWithSize(TipBtn, false)
	GUI:Button_setTitleText(TipBtn, [[]])
	GUI:Button_setTitleColor(TipBtn, "#ffffff")
	GUI:Button_setTitleFontSize(TipBtn, 16)
	GUI:Button_titleEnableOutline(TipBtn, "#000000", 1)
	GUI:setAnchorPoint(TipBtn, 0.00, 0.00)
	GUI:setTouchEnabled(TipBtn, true)
	GUI:setTag(TipBtn, 0)

	-- Create RightBox
	local RightBox = GUI:Layout_Create(Image_1, "RightBox", 514, 38, 283, 441, false)
	GUI:setAnchorPoint(RightBox, 0.00, 0.00)
	GUI:setTouchEnabled(RightBox, false)
	GUI:setTag(RightBox, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(RightBox, "RichText_1", 14, 256, [[<font color='#E110CB' size='18' >【卧龙宝藏】</font><font color='#ffffff' size='18' >内含珍贵稀有道具</font><br><font color='#ffffff' size='18' >每次开启需要使用</font><font color='#ffff00' size='18' >【卧龙钥匙x1】</font><br><font color='#ffffff' size='18' >可以使用</font><font color='#00ffe8' size='18' >【卧龙令x200】</font><font color='#ffffff' size='18' >兑换钥匙</font><br><font color='#ffff00' size='18' >【卧龙令】</font><font color='#ffffff' size='18' >参加龙魂禁地获得</font><br><font color='#ffffff' size='18' >每次攻击禁地中的</font><font color='#E110CB' size='18' >【卧龙夫人】</font><br><font color='#ffffff' size='18' >即可免费获得</font><font color='#ffff00' size='18' >【卧龙令】</font><font color='#ffffff' size='18' >！</font>]], 280, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create need_desc
	local need_desc = GUI:Text_Create(RightBox, "need_desc", 90, 194, 16, "#00ffe8", [[剩余卧龙令：00]])
	GUI:Text_enableOutline(need_desc, "#000000", 1)
	GUI:setAnchorPoint(need_desc, 0.00, 0.00)
	GUI:setTouchEnabled(need_desc, false)
	GUI:setTag(need_desc, 0)

	-- Create need_item
	local need_item = GUI:ItemShow_Create(RightBox, "need_item", 76, 151, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(need_item, 0.50, 0.50)
	GUI:setTag(need_item, 0)

	-- Create ExchangeBtn
	local ExchangeBtn = GUI:Button_Create(RightBox, "ExchangeBtn", 139, 153, "res/custom/yeqian1.png")
	GUI:setContentSize(ExchangeBtn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(ExchangeBtn, false)
	GUI:Button_setTitleText(ExchangeBtn, [[兑换钥匙]])
	GUI:Button_setTitleColor(ExchangeBtn, "#ffff00")
	GUI:Button_setTitleFontSize(ExchangeBtn, 16)
	GUI:Button_titleEnableOutline(ExchangeBtn, "#000000", 1)
	GUI:setAnchorPoint(ExchangeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(ExchangeBtn, true)
	GUI:setTag(ExchangeBtn, 0)

	-- Create OpenTreasure
	local OpenTreasure = GUI:Button_Create(RightBox, "OpenTreasure", 67, 18, "res/custom/npc/81wlbz/an.png")
	GUI:setContentSize(OpenTreasure, 156, 38)
	GUI:setIgnoreContentAdaptWithSize(OpenTreasure, false)
	GUI:Button_setTitleText(OpenTreasure, [[]])
	GUI:Button_setTitleColor(OpenTreasure, "#E110CB")
	GUI:Button_setTitleFontSize(OpenTreasure, 16)
	GUI:Button_titleEnableOutline(OpenTreasure, "#000000", 1)
	GUI:setAnchorPoint(OpenTreasure, 0.00, 0.00)
	GUI:setTouchEnabled(OpenTreasure, true)
	GUI:setTag(OpenTreasure, 0)

	-- Create open_count
	local open_count = GUI:Text_Create(RightBox, "open_count", 67, 69, 16, "#ffff00", [[今日开启次数：100次]])
	GUI:Text_enableOutline(open_count, "#000000", 1)
	GUI:setAnchorPoint(open_count, 0.00, 0.00)
	GUI:setTouchEnabled(open_count, false)
	GUI:setTag(open_count, 0)

	-- Create BuyKeyBtn
	local BuyKeyBtn = GUI:Button_Create(RightBox, "BuyKeyBtn", 140, 107, "res/custom/yeqian1.png")
	GUI:setContentSize(BuyKeyBtn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(BuyKeyBtn, false)
	GUI:Button_setTitleText(BuyKeyBtn, [[购买钥匙]])
	GUI:Button_setTitleColor(BuyKeyBtn, "#E110CB")
	GUI:Button_setTitleFontSize(BuyKeyBtn, 16)
	GUI:Button_titleEnableOutline(BuyKeyBtn, "#000000", 1)
	GUI:setAnchorPoint(BuyKeyBtn, 0.00, 0.00)
	GUI:setTouchEnabled(BuyKeyBtn, true)
	GUI:setTag(BuyKeyBtn, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(Image_1, "ListView_1", 91, 43, 403, 63, 2)
	GUI:ListView_setClippingEnabled(ListView_1, false)
	GUI:ListView_setGravity(ListView_1, 5)
	GUI:ListView_setItemsMargin(ListView_1, 8)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, false)
	GUI:setTag(ListView_1, 0)

	-- Create ItemShow_20
	local ItemShow_20 = GUI:ItemShow_Create(ListView_1, "ItemShow_20", 30, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_20, 0.50, 0.50)
	GUI:setTag(ItemShow_20, 0)

	-- Create ItemShow_21
	local ItemShow_21 = GUI:ItemShow_Create(ListView_1, "ItemShow_21", 98, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_21, 0.50, 0.50)
	GUI:setTag(ItemShow_21, 0)

	-- Create ItemShow_22
	local ItemShow_22 = GUI:ItemShow_Create(ListView_1, "ItemShow_22", 166, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_22, 0.50, 0.50)
	GUI:setTag(ItemShow_22, 0)

	-- Create ItemShow_23
	local ItemShow_23 = GUI:ItemShow_Create(ListView_1, "ItemShow_23", 234, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_23, 0.50, 0.50)
	GUI:setTag(ItemShow_23, 0)

	-- Create ItemShow_24
	local ItemShow_24 = GUI:ItemShow_Create(ListView_1, "ItemShow_24", 302, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_24, 0.50, 0.50)
	GUI:setTag(ItemShow_24, 0)

	-- Create ItemShow_25
	local ItemShow_25 = GUI:ItemShow_Create(ListView_1, "ItemShow_25", 370, 31, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_25, 0.50, 0.50)
	GUI:setTag(ItemShow_25, 0)

	-- Create OpenDesc
	local OpenDesc = GUI:Text_Create(Image_1, "OpenDesc", 108, 108, 18, "#00ff00", [[今日开启宝藏次数满100/99次获得全部奖励]])
	GUI:Text_enableOutline(OpenDesc, "#000000", 1)
	GUI:setAnchorPoint(OpenDesc, 0.00, 0.00)
	GUI:setTouchEnabled(OpenDesc, false)
	GUI:setTag(OpenDesc, 0)

	-- Create CloseBtn
	local CloseBtn = GUI:Button_Create(Image_1, "CloseBtn", 820, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseBtn, false)
	GUI:Button_setTitleText(CloseBtn, [[]])
	GUI:Button_setTitleColor(CloseBtn, "#ffffff")
	GUI:Button_setTitleFontSize(CloseBtn, 16)
	GUI:Button_titleEnableOutline(CloseBtn, "#000000", 1)
	GUI:setAnchorPoint(CloseBtn, 0.00, 0.00)
	GUI:setTouchEnabled(CloseBtn, true)
	GUI:setTag(CloseBtn, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
