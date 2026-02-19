local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, false)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 530, 492, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/29my/sz/bg.png")
	GUI:setContentSize(bg_Image, 530, 492)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 529, 449, "res/public/1900000510.png")
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

	-- Create count_text
	local count_text = GUI:Text_Create(FrameLayout, "count_text", 25, 38, 18, "#00ff00", [[剩余刷新次数：]])
	GUI:Text_setTextHorizontalAlignment(count_text, 2)
	GUI:Text_enableOutline(count_text, "#000000", 1)
	GUI:setAnchorPoint(count_text, 0.00, 0.00)
	GUI:setTouchEnabled(count_text, false)
	GUI:setTag(count_text, 0)

	-- Create text
	local text = GUI:Text_Create(FrameLayout, "text", 25, 112, 18, "#ffffff", [[点击开启获得【命运宝箱】，即可获得本层【命运奖励】]])
	GUI:Text_enableOutline(text, "#000000", 1)
	GUI:setAnchorPoint(text, 0.00, 0.00)
	GUI:setTouchEnabled(text, false)
	GUI:setTag(text, 0)

	-- Create reflush_btn
	local reflush_btn = GUI:Button_Create(FrameLayout, "reflush_btn", 426, 35, "res/custom/npc/29my/bz/an3.png")
	GUI:setContentSize(reflush_btn, 64, 30)
	GUI:setIgnoreContentAdaptWithSize(reflush_btn, false)
	GUI:Button_setTitleText(reflush_btn, [[]])
	GUI:Button_setTitleColor(reflush_btn, "#ffffff")
	GUI:Button_setTitleFontSize(reflush_btn, 18)
	GUI:Button_titleEnableOutline(reflush_btn, "#000000", 1)
	GUI:setAnchorPoint(reflush_btn, 0.00, 0.00)
	GUI:setScale(reflush_btn, 1.20)
	GUI:setTouchEnabled(reflush_btn, true)
	GUI:setTag(reflush_btn, 0)

	-- Create award_bg_1
	local award_bg_1 = GUI:Image_Create(FrameLayout, "award_bg_1", 30, 213, "res/custom/npc/29my/bz/pz1.png")
	GUI:setAnchorPoint(award_bg_1, 0.00, 0.00)
	GUI:setTouchEnabled(award_bg_1, true)
	GUI:setTag(award_bg_1, 0)

	-- Create open_btn1
	local open_btn1 = GUI:Button_Create(award_bg_1, "open_btn1", 41, -43, "res/custom/npc/29my/bz/an1.png")
	GUI:setContentSize(open_btn1, 64, 30)
	GUI:setIgnoreContentAdaptWithSize(open_btn1, false)
	GUI:Button_setTitleText(open_btn1, [[]])
	GUI:Button_setTitleColor(open_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(open_btn1, 18)
	GUI:Button_titleEnableOutline(open_btn1, "#000000", 1)
	GUI:setAnchorPoint(open_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(open_btn1, true)
	GUI:setTag(open_btn1, 0)

	-- Create get_btn1
	local get_btn1 = GUI:Button_Create(award_bg_1, "get_btn1", 41, -43, "res/custom/npc/29my/bz/an2.png")
	GUI:setContentSize(get_btn1, 64, 30)
	GUI:setIgnoreContentAdaptWithSize(get_btn1, false)
	GUI:Button_setTitleText(get_btn1, [[]])
	GUI:Button_setTitleColor(get_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(get_btn1, 18)
	GUI:Button_titleEnableOutline(get_btn1, "#000000", 1)
	GUI:setAnchorPoint(get_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(get_btn1, true)
	GUI:setTag(get_btn1, 0)
	GUI:setVisible(get_btn1, false)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(award_bg_1, "ItemShow_1", 73, 117, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create item_name1
	local item_name1 = GUI:Text_Create(award_bg_1, "item_name1", 73, 60, 16, "#ff9b00", [[试试]])
	GUI:Text_setTextHorizontalAlignment(item_name1, 1)
	GUI:Text_enableOutline(item_name1, "#000000", 1)
	GUI:setAnchorPoint(item_name1, 0.50, 0.50)
	GUI:setTouchEnabled(item_name1, false)
	GUI:setTag(item_name1, 0)

	-- Create yilingqu_1
	local yilingqu_1 = GUI:Image_Create(award_bg_1, "yilingqu_1", 36, -44, "res/custom/tag/ylq_00.png")
	GUI:setAnchorPoint(yilingqu_1, 0.00, 0.00)
	GUI:setTouchEnabled(yilingqu_1, false)
	GUI:setTag(yilingqu_1, 0)

	-- Create award_bg_2
	local award_bg_2 = GUI:Image_Create(FrameLayout, "award_bg_2", 194, 213, "res/custom/npc/29my/bz/pz1.png")
	GUI:setAnchorPoint(award_bg_2, 0.00, 0.00)
	GUI:setTouchEnabled(award_bg_2, true)
	GUI:setTag(award_bg_2, 0)

	-- Create open_btn2
	local open_btn2 = GUI:Button_Create(award_bg_2, "open_btn2", 41, -43, "res/custom/npc/29my/bz/an1.png")
	GUI:setContentSize(open_btn2, 64, 30)
	GUI:setIgnoreContentAdaptWithSize(open_btn2, false)
	GUI:Button_setTitleText(open_btn2, [[]])
	GUI:Button_setTitleColor(open_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(open_btn2, 18)
	GUI:Button_titleEnableOutline(open_btn2, "#000000", 1)
	GUI:setAnchorPoint(open_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(open_btn2, true)
	GUI:setTag(open_btn2, 0)

	-- Create get_btn2
	local get_btn2 = GUI:Button_Create(award_bg_2, "get_btn2", 41, -43, "res/custom/npc/29my/bz/an2.png")
	GUI:setContentSize(get_btn2, 64, 30)
	GUI:setIgnoreContentAdaptWithSize(get_btn2, false)
	GUI:Button_setTitleText(get_btn2, [[]])
	GUI:Button_setTitleColor(get_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(get_btn2, 18)
	GUI:Button_titleEnableOutline(get_btn2, "#000000", 1)
	GUI:setAnchorPoint(get_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(get_btn2, true)
	GUI:setTag(get_btn2, 0)
	GUI:setVisible(get_btn2, false)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(award_bg_2, "ItemShow_2", 73, 117, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create item_name2
	local item_name2 = GUI:Text_Create(award_bg_2, "item_name2", 73, 60, 16, "#ff9b00", [[是的是的是发发发]])
	GUI:Text_setTextHorizontalAlignment(item_name2, 1)
	GUI:Text_enableOutline(item_name2, "#000000", 1)
	GUI:setAnchorPoint(item_name2, 0.50, 0.50)
	GUI:setTouchEnabled(item_name2, false)
	GUI:setTag(item_name2, 0)

	-- Create yilingqu_2
	local yilingqu_2 = GUI:Image_Create(award_bg_2, "yilingqu_2", 36, -44, "res/custom/tag/ylq_00.png")
	GUI:setAnchorPoint(yilingqu_2, 0.00, 0.00)
	GUI:setTouchEnabled(yilingqu_2, false)
	GUI:setTag(yilingqu_2, 0)

	-- Create award_bg_3
	local award_bg_3 = GUI:Image_Create(FrameLayout, "award_bg_3", 357, 213, "res/custom/npc/29my/bz/pz2.png")
	GUI:setAnchorPoint(award_bg_3, 0.00, 0.00)
	GUI:setTouchEnabled(award_bg_3, true)
	GUI:setTag(award_bg_3, 0)

	-- Create open_btn3
	local open_btn3 = GUI:Button_Create(award_bg_3, "open_btn3", 41, -43, "res/custom/npc/29my/bz/an1.png")
	GUI:setContentSize(open_btn3, 64, 30)
	GUI:setIgnoreContentAdaptWithSize(open_btn3, false)
	GUI:Button_setTitleText(open_btn3, [[]])
	GUI:Button_setTitleColor(open_btn3, "#ffffff")
	GUI:Button_setTitleFontSize(open_btn3, 18)
	GUI:Button_titleEnableOutline(open_btn3, "#000000", 1)
	GUI:setAnchorPoint(open_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(open_btn3, true)
	GUI:setTag(open_btn3, 0)

	-- Create get_btn3
	local get_btn3 = GUI:Button_Create(award_bg_3, "get_btn3", 41, -43, "res/custom/npc/29my/bz/an2.png")
	GUI:setContentSize(get_btn3, 64, 30)
	GUI:setIgnoreContentAdaptWithSize(get_btn3, false)
	GUI:Button_setTitleText(get_btn3, [[]])
	GUI:Button_setTitleColor(get_btn3, "#ffffff")
	GUI:Button_setTitleFontSize(get_btn3, 18)
	GUI:Button_titleEnableOutline(get_btn3, "#000000", 1)
	GUI:setAnchorPoint(get_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(get_btn3, true)
	GUI:setTag(get_btn3, 0)
	GUI:setVisible(get_btn3, false)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(award_bg_3, "ItemShow_3", 73, 117, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create item_name3
	local item_name3 = GUI:Text_Create(award_bg_3, "item_name3", 73, 60, 16, "#ff9b00", [[是的是的是发发发]])
	GUI:Text_setTextHorizontalAlignment(item_name3, 1)
	GUI:Text_enableOutline(item_name3, "#000000", 1)
	GUI:setAnchorPoint(item_name3, 0.50, 0.50)
	GUI:setTouchEnabled(item_name3, false)
	GUI:setTag(item_name3, 0)

	-- Create yilingqu_3
	local yilingqu_3 = GUI:Image_Create(award_bg_3, "yilingqu_3", 36, -44, "res/custom/tag/ylq_00.png")
	GUI:setAnchorPoint(yilingqu_3, 0.00, 0.00)
	GUI:setTouchEnabled(yilingqu_3, false)
	GUI:setTag(yilingqu_3, 0)

	-- Create text_1
	local text_1 = GUI:Text_Create(FrameLayout, "text_1", 25, 75, 18, "#ffffff", [[终身特权玩家每天拥有一次刷新机会！]])
	GUI:Text_enableOutline(text_1, "#000000", 1)
	GUI:setAnchorPoint(text_1, 0.00, 0.00)
	GUI:setTouchEnabled(text_1, false)
	GUI:setTag(text_1, 0)

	-- Create text_2
	local text_2 = GUI:Text_Create(FrameLayout, "text_2", 375, 75, 18, "#00ff00", [[领取后不可刷新]])
	GUI:Text_enableOutline(text_2, "#000000", 1)
	GUI:setAnchorPoint(text_2, 0.00, 0.00)
	GUI:setTouchEnabled(text_2, false)
	GUI:setTag(text_2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
