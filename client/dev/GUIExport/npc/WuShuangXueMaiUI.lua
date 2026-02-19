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
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 0, 0, "res/custom/npc/52wsxm/bg.png")
	GUI:setContentSize(Image_1, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, true)
	GUI:setMouseEnabled(Image_1, true)
	GUI:setTag(Image_1, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(Image_1, "Image_5", 154, 135, "res/custom/npc/52wsxm/bg2.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create btn_info_box
	local btn_info_box = GUI:Image_Create(Image_1, "btn_info_box", 133, 96, "res/custom/npc/52wsxm/bg3.png")
	GUI:setAnchorPoint(btn_info_box, 0.00, 0.00)
	GUI:setTouchEnabled(btn_info_box, false)
	GUI:setTag(btn_info_box, 0)

	-- Create xuemai_box1
	local xuemai_box1 = GUI:Image_Create(btn_info_box, "xuemai_box1", 125, 286, "res/custom/npc/52wsxm/dt.png")
	GUI:setAnchorPoint(xuemai_box1, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_box1, true)
	GUI:setTag(xuemai_box1, 0)

	-- Create lock_1
	local lock_1 = GUI:Image_Create(xuemai_box1, "lock_1", 12, 11, "res/custom/npc/52wsxm/s1.png")
	GUI:setAnchorPoint(lock_1, 0.00, 0.00)
	GUI:setTouchEnabled(lock_1, false)
	GUI:setTag(lock_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(xuemai_box1, "ItemShow_1", 40, 39, {index = 0, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create xuemai_box2
	local xuemai_box2 = GUI:Image_Create(btn_info_box, "xuemai_box2", 248, 211, "res/custom/npc/52wsxm/dt.png")
	GUI:setAnchorPoint(xuemai_box2, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_box2, true)
	GUI:setTag(xuemai_box2, 0)

	-- Create lock_2
	local lock_2 = GUI:Image_Create(xuemai_box2, "lock_2", 12, 11, "res/custom/npc/52wsxm/s1.png")
	GUI:setAnchorPoint(lock_2, 0.00, 0.00)
	GUI:setTouchEnabled(lock_2, false)
	GUI:setTag(lock_2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(xuemai_box2, "ItemShow_2", 40, 39, {index = 0, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create xuemai_box3
	local xuemai_box3 = GUI:Image_Create(btn_info_box, "xuemai_box3", 248, 73, "res/custom/npc/52wsxm/dt.png")
	GUI:setAnchorPoint(xuemai_box3, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_box3, true)
	GUI:setTag(xuemai_box3, 0)

	-- Create lock_3
	local lock_3 = GUI:Image_Create(xuemai_box3, "lock_3", 12, 11, "res/custom/npc/52wsxm/s1.png")
	GUI:setAnchorPoint(lock_3, 0.00, 0.00)
	GUI:setTouchEnabled(lock_3, false)
	GUI:setTag(lock_3, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(xuemai_box3, "ItemShow_3", 40, 39, {index = 0, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create xuemai_box4
	local xuemai_box4 = GUI:Image_Create(btn_info_box, "xuemai_box4", 125, 2, "res/custom/npc/52wsxm/dt.png")
	GUI:setAnchorPoint(xuemai_box4, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_box4, true)
	GUI:setTag(xuemai_box4, 0)

	-- Create lock_4
	local lock_4 = GUI:Image_Create(xuemai_box4, "lock_4", 12, 11, "res/custom/npc/52wsxm/s1.png")
	GUI:setAnchorPoint(lock_4, 0.00, 0.00)
	GUI:setTouchEnabled(lock_4, false)
	GUI:setTag(lock_4, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(xuemai_box4, "ItemShow_4", 40, 39, {index = 0, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create xuemai_box5
	local xuemai_box5 = GUI:Image_Create(btn_info_box, "xuemai_box5", 0, 73, "res/custom/npc/52wsxm/dt.png")
	GUI:setAnchorPoint(xuemai_box5, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_box5, true)
	GUI:setTag(xuemai_box5, 0)

	-- Create lock_5
	local lock_5 = GUI:Image_Create(xuemai_box5, "lock_5", 12, 11, "res/custom/npc/52wsxm/s1.png")
	GUI:setAnchorPoint(lock_5, 0.00, 0.00)
	GUI:setTouchEnabled(lock_5, false)
	GUI:setTag(lock_5, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(xuemai_box5, "ItemShow_5", 40, 39, {index = 0, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create xuemai_box6
	local xuemai_box6 = GUI:Image_Create(btn_info_box, "xuemai_box6", 0, 211, "res/custom/npc/52wsxm/dt.png")
	GUI:setAnchorPoint(xuemai_box6, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_box6, true)
	GUI:setTag(xuemai_box6, 0)

	-- Create lock_6
	local lock_6 = GUI:Image_Create(xuemai_box6, "lock_6", 12, 11, "res/custom/npc/52wsxm/s1.png")
	GUI:setAnchorPoint(lock_6, 0.00, 0.00)
	GUI:setTouchEnabled(lock_6, false)
	GUI:setTag(lock_6, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(xuemai_box6, "ItemShow_6", 40, 39, {index = 0, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(btn_info_box, "select_img", 248, 211, "res/custom/npc/52wsxm/sd.png")
	GUI:setAnchorPoint(select_img, 0.00, 0.00)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)
	GUI:setVisible(select_img, false)

	-- Create xuemai_btn
	local xuemai_btn = GUI:Button_Create(Image_1, "xuemai_btn", 5, 256, "res/custom/npc/52wsxm/xuemai1.png")
	GUI:setContentSize(xuemai_btn, 50, 144)
	GUI:setIgnoreContentAdaptWithSize(xuemai_btn, false)
	GUI:Button_setTitleText(xuemai_btn, [[]])
	GUI:Button_setTitleColor(xuemai_btn, "#ffffff")
	GUI:Button_setTitleFontSize(xuemai_btn, 16)
	GUI:Button_titleEnableOutline(xuemai_btn, "#000000", 1)
	GUI:setAnchorPoint(xuemai_btn, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_btn, true)
	GUI:setTag(xuemai_btn, 0)

	-- Create wsxm_btn
	local wsxm_btn = GUI:Button_Create(Image_1, "wsxm_btn", 5, 113, "res/custom/npc/52wsxm/wushuang1.png")
	GUI:setContentSize(wsxm_btn, 50, 144)
	GUI:setIgnoreContentAdaptWithSize(wsxm_btn, false)
	GUI:Button_setTitleText(wsxm_btn, [[]])
	GUI:Button_setTitleColor(wsxm_btn, "#ffffff")
	GUI:Button_setTitleFontSize(wsxm_btn, 16)
	GUI:Button_titleEnableOutline(wsxm_btn, "#000000", 1)
	GUI:setAnchorPoint(wsxm_btn, 0.00, 0.00)
	GUI:setTouchEnabled(wsxm_btn, true)
	GUI:setTag(wsxm_btn, 0)

	-- Create tip_btn
	local tip_btn = GUI:Button_Create(Image_1, "tip_btn", 83, 42, "res/custom/tips.png")
	GUI:setContentSize(tip_btn, 34, 34)
	GUI:setIgnoreContentAdaptWithSize(tip_btn, false)
	GUI:Button_setTitleText(tip_btn, [[]])
	GUI:Button_setTitleColor(tip_btn, "#ffffff")
	GUI:Button_setTitleFontSize(tip_btn, 16)
	GUI:Button_titleEnableOutline(tip_btn, "#000000", 1)
	GUI:setAnchorPoint(tip_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tip_btn, true)
	GUI:setTag(tip_btn, 0)

	-- Create active_count_text
	local active_count_text = GUI:Text_Create(Image_1, "active_count_text", 360, 39, 16, "#00ff00", [[]])
	GUI:Text_enableOutline(active_count_text, "#000000", 1)
	GUI:setAnchorPoint(active_count_text, 0.00, 0.00)
	GUI:setTouchEnabled(active_count_text, false)
	GUI:setTag(active_count_text, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(Image_1, "Image_6", 544, 122, "res/custom/npc/52wsxm/xt.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create reset_btn
	local reset_btn = GUI:Button_Create(Image_1, "reset_btn", 600, 49, "res/custom/yeqian2.png")
	GUI:setContentSize(reset_btn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(reset_btn, false)
	GUI:Button_setTitleText(reset_btn, [[重修天赋]])
	GUI:Button_setTitleColor(reset_btn, "#f8e6c6")
	GUI:Button_setTitleFontSize(reset_btn, 18)
	GUI:Button_titleEnableOutline(reset_btn, "#000000", 1)
	GUI:setAnchorPoint(reset_btn, 0.00, 0.00)
	GUI:setTouchEnabled(reset_btn, true)
	GUI:setTag(reset_btn, 0)

	-- Create select_info_box
	local select_info_box = GUI:Layout_Create(Image_1, "select_info_box", 545, 132, 234, 308, false)
	GUI:setAnchorPoint(select_info_box, 0.00, 0.00)
	GUI:setTouchEnabled(select_info_box, false)
	GUI:setTag(select_info_box, 0)

	-- Create RightItemShow
	local RightItemShow = GUI:ItemShow_Create(select_info_box, "RightItemShow", 35, 275, {index = 0, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(RightItemShow, 0.50, 0.50)
	GUI:setTag(RightItemShow, 0)

	-- Create XueMaiName
	local XueMaiName = GUI:Text_Create(select_info_box, "XueMaiName", 71, 280, 16, "#f65715", [[迷踪]])
	GUI:Text_enableOutline(XueMaiName, "#000000", 1)
	GUI:setAnchorPoint(XueMaiName, 0.00, 0.00)
	GUI:setTouchEnabled(XueMaiName, false)
	GUI:setTag(XueMaiName, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(select_info_box, "RichText_1", 70, 249, [[<font color='#ffffff' size='16' >当前层数：</font><font color='#00ff00' size='16' >1</font><font color='#ffffff' size='16' >/</font><font color='#ff0000' size='16' >1</font><font color='#ffffff' size='16' >层</font>]], 150, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create text
	local text = GUI:Text_Create(select_info_box, "text", 68, 216, 18, "#ff0000", [[無双血脉]])
	GUI:Text_enableOutline(text, "#000000", 1)
	GUI:setAnchorPoint(text, 0.00, 0.00)
	GUI:setTouchEnabled(text, false)
	GUI:setTag(text, 0)

	-- Create not_select_tip
	local not_select_tip = GUI:Text_Create(Image_1, "not_select_tip", 619, 274, 16, "#00ff00", [[未选择血脉]])
	GUI:Text_enableOutline(not_select_tip, "#000000", 1)
	GUI:setAnchorPoint(not_select_tip, 0.00, 0.00)
	GUI:setTouchEnabled(not_select_tip, false)
	GUI:setTag(not_select_tip, 0)
	GUI:setVisible(not_select_tip, false)

	-- Create close_btn
	local close_btn = GUI:Button_Create(Image_1, "close_btn", 820, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(close_btn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleEnableOutline(close_btn, "#000000", 1)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create active_btn
	local active_btn = GUI:Button_Create(Image_1, "active_btn", 245, 39, "res/custom/npc/52wsxm/an.png")
	GUI:setContentSize(active_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(active_btn, false)
	GUI:Button_setTitleText(active_btn, [[]])
	GUI:Button_setTitleColor(active_btn, "#ffffff")
	GUI:Button_setTitleFontSize(active_btn, 16)
	GUI:Button_titleEnableOutline(active_btn, "#000000", 1)
	GUI:setAnchorPoint(active_btn, 0.00, 0.00)
	GUI:setTouchEnabled(active_btn, true)
	GUI:setTag(active_btn, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
