local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 820, 487, "res/custom/closeBtn.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/1900000511.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/110feijian/bj.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create btn_list_view
	local btn_list_view = GUI:ListView_Create(FrameLayout, "btn_list_view", 73, 437, 726, 44, 2)
	GUI:ListView_setGravity(btn_list_view, 3)
	GUI:ListView_setItemsMargin(btn_list_view, 2)
	GUI:setAnchorPoint(btn_list_view, 0.00, 0.00)
	GUI:setTouchEnabled(btn_list_view, true)
	GUI:setTag(btn_list_view, 0)

	-- Create enter_btn
	local enter_btn = GUI:Button_Create(FrameLayout, "enter_btn", 676, 41, "res/custom/npc/110feijian/enter1.png")
	GUI:Button_loadTexturePressed(enter_btn, "res/custom/npc/110feijian/enter2.png")
	GUI:setContentSize(enter_btn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(enter_btn, false)
	GUI:Button_setTitleText(enter_btn, [[]])
	GUI:Button_setTitleColor(enter_btn, "#ffffff")
	GUI:Button_setTitleFontSize(enter_btn, 16)
	GUI:Button_titleDisableOutLine(enter_btn)
	GUI:setAnchorPoint(enter_btn, 0.00, 0.00)
	GUI:setTouchEnabled(enter_btn, true)
	GUI:setTag(enter_btn, 0)

	-- Create enter_num
	local enter_num = GUI:Text_Create(FrameLayout, "enter_num", 701, 103, 16, "#00ff00", [[今日剩余挑战次数：6次]])
	GUI:Text_enableOutline(enter_num, "#000000", 1)
	GUI:setAnchorPoint(enter_num, 0.50, 0.50)
	GUI:setTouchEnabled(enter_num, false)
	GUI:setTag(enter_num, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 92, 95, 16, "#00ff00", [[击杀BOSS归属玩家地图内同行会所有成员均可获得击杀奖励]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create boss_item1
	local boss_item1 = GUI:Image_Create(FrameLayout, "boss_item1", 73, 178, "res/custom/npc/110feijian/bg.png")
	GUI:setAnchorPoint(boss_item1, 0.00, 0.00)
	GUI:setTouchEnabled(boss_item1, false)
	GUI:setTag(boss_item1, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(boss_item1, "Effect_1", 74, 76, 2, 23060, 0, 0, 4, 1)
	GUI:setScale(Effect_1, 0.50)
	GUI:setTag(Effect_1, 0)

	-- Create boss_name1
	local boss_name1 = GUI:Text_Create(boss_item1, "boss_name1", 87, 237, 16, "#ffff00", [[一阶·执剑尊者]])
	GUI:Text_enableOutline(boss_name1, "#000000", 1)
	GUI:setAnchorPoint(boss_name1, 0.50, 0.50)
	GUI:setTouchEnabled(boss_name1, false)
	GUI:setTag(boss_name1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(boss_item1, "Text_1", 5, -53, 16, "#00ff00", [[专属
掉落]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create drop_item1_1
	local drop_item1_1 = GUI:ItemShow_Create(boss_item1, "drop_item1_1", 77, -29, {index = 1, count = 1, look = true, bgVisible = true, color = 0})
	GUI:setAnchorPoint(drop_item1_1, 0.50, 0.50)
	GUI:setTag(drop_item1_1, 0)

	-- Create drop_item1_2
	local drop_item1_2 = GUI:ItemShow_Create(boss_item1, "drop_item1_2", 144, -29, {index = 1, count = 1, look = true, bgVisible = true, color = 0})
	GUI:setAnchorPoint(drop_item1_2, 0.50, 0.50)
	GUI:setTag(drop_item1_2, 0)

	-- Create boss_item2
	local boss_item2 = GUI:Image_Create(FrameLayout, "boss_item2", 255, 178, "res/custom/npc/110feijian/bg.png")
	GUI:setAnchorPoint(boss_item2, 0.00, 0.00)
	GUI:setTouchEnabled(boss_item2, false)
	GUI:setTag(boss_item2, 0)

	-- Create Effect_2
	local Effect_2 = GUI:Effect_Create(boss_item2, "Effect_2", 76, 87, 2, 23061, 0, 0, 4, 1)
	GUI:setScale(Effect_2, 0.50)
	GUI:setTag(Effect_2, 0)

	-- Create boss_name2
	local boss_name2 = GUI:Text_Create(boss_item2, "boss_name2", 87, 237, 16, "#ffff00", [[一阶·执剑尊者]])
	GUI:Text_enableOutline(boss_name2, "#000000", 1)
	GUI:setAnchorPoint(boss_name2, 0.50, 0.50)
	GUI:setTouchEnabled(boss_name2, false)
	GUI:setTag(boss_name2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(boss_item2, "Text_1", 5, -53, 16, "#00ff00", [[专属
掉落]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create drop_item2_1
	local drop_item2_1 = GUI:ItemShow_Create(boss_item2, "drop_item2_1", 77, -29, {index = 1, count = 1, look = true, bgVisible = true, color = 0})
	GUI:setAnchorPoint(drop_item2_1, 0.50, 0.50)
	GUI:setTag(drop_item2_1, 0)

	-- Create drop_item2_2
	local drop_item2_2 = GUI:ItemShow_Create(boss_item2, "drop_item2_2", 144, -29, {index = 1, count = 1, look = true, bgVisible = true, color = 0})
	GUI:setAnchorPoint(drop_item2_2, 0.50, 0.50)
	GUI:setTag(drop_item2_2, 0)

	-- Create boss_item3
	local boss_item3 = GUI:Image_Create(FrameLayout, "boss_item3", 437, 178, "res/custom/npc/110feijian/bg.png")
	GUI:setAnchorPoint(boss_item3, 0.00, 0.00)
	GUI:setTouchEnabled(boss_item3, false)
	GUI:setTag(boss_item3, 0)

	-- Create Effect_3
	local Effect_3 = GUI:Effect_Create(boss_item3, "Effect_3", 61, 51, 2, 23062, 0, 0, 4, 1)
	GUI:setTag(Effect_3, 0)

	-- Create boss_name3
	local boss_name3 = GUI:Text_Create(boss_item3, "boss_name3", 87, 237, 16, "#ffff00", [[一阶·执剑尊者]])
	GUI:Text_enableOutline(boss_name3, "#000000", 1)
	GUI:setAnchorPoint(boss_name3, 0.50, 0.50)
	GUI:setTouchEnabled(boss_name3, false)
	GUI:setTag(boss_name3, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(boss_item3, "Text_1", 5, -53, 16, "#00ff00", [[专属
掉落]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create drop_item3_1
	local drop_item3_1 = GUI:ItemShow_Create(boss_item3, "drop_item3_1", 77, -29, {index = 1, count = 1, look = true, bgVisible = true, color = 0})
	GUI:setAnchorPoint(drop_item3_1, 0.50, 0.50)
	GUI:setTag(drop_item3_1, 0)

	-- Create drop_item3_2
	local drop_item3_2 = GUI:ItemShow_Create(boss_item3, "drop_item3_2", 144, -29, {index = 1, count = 1, look = true, bgVisible = true, color = 0})
	GUI:setAnchorPoint(drop_item3_2, 0.50, 0.50)
	GUI:setTag(drop_item3_2, 0)

	-- Create boss_item4
	local boss_item4 = GUI:Image_Create(FrameLayout, "boss_item4", 619, 178, "res/custom/npc/110feijian/bg.png")
	GUI:setAnchorPoint(boss_item4, 0.00, 0.00)
	GUI:setTouchEnabled(boss_item4, false)
	GUI:setTag(boss_item4, 0)

	-- Create Effect_4
	local Effect_4 = GUI:Effect_Create(boss_item4, "Effect_4", 66, 77, 2, 23063, 0, 0, 4, 1)
	GUI:setScale(Effect_4, 0.50)
	GUI:setTag(Effect_4, 0)

	-- Create boss_name4
	local boss_name4 = GUI:Text_Create(boss_item4, "boss_name4", 87, 237, 16, "#ffff00", [[一阶·执剑尊者]])
	GUI:Text_enableOutline(boss_name4, "#000000", 1)
	GUI:setAnchorPoint(boss_name4, 0.50, 0.50)
	GUI:setTouchEnabled(boss_name4, false)
	GUI:setTag(boss_name4, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(boss_item4, "Text_1", 5, -53, 16, "#00ff00", [[专属
掉落]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create drop_item4_1
	local drop_item4_1 = GUI:ItemShow_Create(boss_item4, "drop_item4_1", 77, -29, {index = 1, count = 1, look = true, bgVisible = true, color = 0})
	GUI:setAnchorPoint(drop_item4_1, 0.50, 0.50)
	GUI:setTag(drop_item4_1, 0)

	-- Create drop_item4_2
	local drop_item4_2 = GUI:ItemShow_Create(boss_item4, "drop_item4_2", 144, -29, {index = 1, count = 1, look = true, bgVisible = true, color = 0})
	GUI:setAnchorPoint(drop_item4_2, 0.50, 0.50)
	GUI:setTag(drop_item4_2, 0)

	-- Create award_list
	local award_list = GUI:Layout_Create(FrameLayout, "award_list", 108, 35, 297, 59, false)
	GUI:setAnchorPoint(award_list, 0.00, 0.00)
	GUI:setTouchEnabled(award_list, false)
	GUI:setTag(award_list, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 460, 69, 16, "#ffffff", [[开放时间]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(FrameLayout, "Text_4", 423, 41, 16, "#ffffff", [[每日11:00-24:00开放]])
	GUI:setIgnoreContentAdaptWithSize(Text_4, false)
	GUI:Text_setTextAreaSize(Text_4, 152, 24)
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
