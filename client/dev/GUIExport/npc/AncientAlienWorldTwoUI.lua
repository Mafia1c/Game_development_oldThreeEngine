local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout1
	local FrameLayout1 = GUI:Layout_Create(parent, "FrameLayout1", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(FrameLayout1, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout1, true)
	GUI:setMouseEnabled(FrameLayout1, true)
	GUI:setTag(FrameLayout1, 0)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout1, "FrameBG", 241, 124, "res/custom/npc/86yj/tb/bg.png")
	GUI:setContentSize(FrameBG, 644, 426)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create week_item
	local week_item = GUI:ItemShow_Create(FrameLayout1, "week_item", 340, 456, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(week_item, 0.50, 0.50)
	GUI:setTag(week_item, 0)

	-- Create week_num
	local week_num = GUI:Text_Create(FrameLayout1, "week_num", 320, 398, 16, "#ffff00", [[0/3次]])
	GUI:Text_setTextHorizontalAlignment(week_num, 1)
	GUI:Text_enableOutline(week_num, "#000000", 1)
	GUI:setAnchorPoint(week_num, 0.00, 0.00)
	GUI:setTouchEnabled(week_num, false)
	GUI:setTag(week_num, 0)

	-- Create week_get_btn
	local week_get_btn = GUI:Button_Create(FrameLayout1, "week_get_btn", 283, 353, "res/custom/yeqian2.png")
	GUI:setContentSize(week_get_btn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(week_get_btn, false)
	GUI:Button_setTitleText(week_get_btn, [[领取]])
	GUI:Button_setTitleColor(week_get_btn, "#f8e6c6")
	GUI:Button_setTitleFontSize(week_get_btn, 16)
	GUI:Button_titleEnableOutline(week_get_btn, "#000000", 1)
	GUI:setAnchorPoint(week_get_btn, 0.00, 0.00)
	GUI:setTouchEnabled(week_get_btn, true)
	GUI:setTag(week_get_btn, 0)

	-- Create total_item
	local total_item = GUI:ItemShow_Create(FrameLayout1, "total_item", 342, 274, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(total_item, 0.50, 0.50)
	GUI:setTag(total_item, 0)

	-- Create total_num
	local total_num = GUI:Text_Create(FrameLayout1, "total_num", 320, 211, 16, "#ffff00", [[0/3次]])
	GUI:Text_setTextHorizontalAlignment(total_num, 1)
	GUI:Text_enableOutline(total_num, "#000000", 1)
	GUI:setAnchorPoint(total_num, 0.00, 0.00)
	GUI:setTouchEnabled(total_num, false)
	GUI:setTag(total_num, 0)

	-- Create total_get_btn
	local total_get_btn = GUI:Button_Create(FrameLayout1, "total_get_btn", 283, 172, "res/custom/yeqian2.png")
	GUI:setContentSize(total_get_btn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(total_get_btn, false)
	GUI:Button_setTitleText(total_get_btn, [[领取]])
	GUI:Button_setTitleColor(total_get_btn, "#f8e6c6")
	GUI:Button_setTitleFontSize(total_get_btn, 16)
	GUI:Button_titleEnableOutline(total_get_btn, "#000000", 1)
	GUI:setAnchorPoint(total_get_btn, 0.00, 0.00)
	GUI:setTouchEnabled(total_get_btn, true)
	GUI:setTag(total_get_btn, 0)

	-- Create title_img
	local title_img = GUI:Image_Create(FrameLayout1, "title_img", 645, 508, "res/custom/npc/86yj/tb/t1.png")
	GUI:setAnchorPoint(title_img, 0.50, 0.50)
	GUI:setTouchEnabled(title_img, false)
	GUI:setTag(title_img, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout1, "Text_3", 427, 207, 16, "#ffffff", [[1.需要：]])
	GUI:Text_setTextHorizontalAlignment(Text_3, 1)
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(FrameLayout1, "Text_4", 427, 199, 16, "#ffffff", [[2.需要：]])
	GUI:Text_setTextHorizontalAlignment(Text_4, 1)
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)
	GUI:setVisible(Text_4, false)

	-- Create team_btn
	local team_btn = GUI:Button_Create(FrameLayout1, "team_btn", 712, 219, "res/custom/yeqian2.png")
	GUI:setContentSize(team_btn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(team_btn, false)
	GUI:Button_setTitleText(team_btn, [[组队信息]])
	GUI:Button_setTitleColor(team_btn, "#ffffff")
	GUI:Button_setTitleFontSize(team_btn, 16)
	GUI:Button_titleEnableOutline(team_btn, "#000000", 1)
	GUI:setAnchorPoint(team_btn, 0.00, 0.00)
	GUI:setTouchEnabled(team_btn, true)
	GUI:setTag(team_btn, 0)

	-- Create enter_map
	local enter_map = GUI:Button_Create(FrameLayout1, "enter_map", 712, 175, "res/custom/yeqian2.png")
	GUI:setContentSize(enter_map, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(enter_map, false)
	GUI:Button_setTitleText(enter_map, [[开始挑战]])
	GUI:Button_setTitleColor(enter_map, "#ffffff")
	GUI:Button_setTitleFontSize(enter_map, 16)
	GUI:Button_titleEnableOutline(enter_map, "#000000", 1)
	GUI:setAnchorPoint(enter_map, 0.00, 0.00)
	GUI:setTouchEnabled(enter_map, true)
	GUI:setTag(enter_map, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(FrameLayout1, "Text_5", 483, 199, 16, "#00ff00", [[【集结3人以上队伍】]])
	GUI:Text_setTextHorizontalAlignment(Text_5, 1)
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)
	GUI:setVisible(Text_5, false)

	-- Create need_desc
	local need_desc = GUI:Text_Create(FrameLayout1, "need_desc", 483, 207, 16, "#00ff00", [[【集结3人以上队伍】]])
	GUI:Text_setTextHorizontalAlignment(need_desc, 1)
	GUI:Text_enableOutline(need_desc, "#000000", 1)
	GUI:setAnchorPoint(need_desc, 0.00, 0.00)
	GUI:setTouchEnabled(need_desc, false)
	GUI:setTag(need_desc, 0)

	-- Create week_get_flag
	local week_get_flag = GUI:Image_Create(FrameLayout1, "week_get_flag", 304, 356, "res/custom/tag/ylq_00.png")
	GUI:setAnchorPoint(week_get_flag, 0.00, 0.00)
	GUI:setTouchEnabled(week_get_flag, false)
	GUI:setTag(week_get_flag, 0)
	GUI:setVisible(week_get_flag, false)

	-- Create total_get_flag
	local total_get_flag = GUI:Image_Create(FrameLayout1, "total_get_flag", 303, 173, "res/custom/tag/ylq_00.png")
	GUI:setAnchorPoint(total_get_flag, 0.00, 0.00)
	GUI:setTouchEnabled(total_get_flag, false)
	GUI:setTag(total_get_flag, 0)
	GUI:setVisible(total_get_flag, false)

	ui.update(__data__)
	return FrameLayout1
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
