local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Node_Create(parent, "Scene", 0, 0)
	GUI:setChineseName(Scene, "背包场景")
	GUI:setTag(Scene, -1)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(Scene, "Panel_1", 98, 340, 390, 340, false)
	GUI:setChineseName(Panel_1, "背包组合框")
	GUI:setAnchorPoint(Panel_1, 0.00, 0.50)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 18)
	TAGOBJ["18"] = Panel_1

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_1, "Image_bg", 205, 152, "res/private/bag_ui/bag_ui_win32/bg_beibao_01.png")
	GUI:setContentSize(Image_bg, 618, 622)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "背包_背景_图片")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 20)
	TAGOBJ["20"] = Image_bg

	-- Create yuanbao
	local yuanbao = GUI:Text_Create(Image_bg, "yuanbao", 63, 73, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(yuanbao, "#000000", 1)
	GUI:setAnchorPoint(yuanbao, 0.00, 0.00)
	GUI:setTouchEnabled(yuanbao, false)
	GUI:setTag(yuanbao, 0)

	-- Create bind_yuanbao
	local bind_yuanbao = GUI:Text_Create(Image_bg, "bind_yuanbao", 63, 51, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(bind_yuanbao, "#000000", 1)
	GUI:setAnchorPoint(bind_yuanbao, 0.00, 0.00)
	GUI:setTouchEnabled(bind_yuanbao, false)
	GUI:setTag(bind_yuanbao, 0)

	-- Create jgs
	local jgs = GUI:Text_Create(Image_bg, "jgs", 194, 73, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(jgs, "#000000", 1)
	GUI:setAnchorPoint(jgs, 0.00, 0.00)
	GUI:setTouchEnabled(jgs, false)
	GUI:setTag(jgs, 0)

	-- Create bind_jgs
	local bind_jgs = GUI:Text_Create(Image_bg, "bind_jgs", 194, 51, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(bind_jgs, "#000000", 1)
	GUI:setAnchorPoint(bind_jgs, 0.00, 0.00)
	GUI:setTouchEnabled(bind_jgs, false)
	GUI:setTag(bind_jgs, 0)

	-- Create lingfu
	local lingfu = GUI:Text_Create(Image_bg, "lingfu", 325, 73, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(lingfu, "#000000", 1)
	GUI:setAnchorPoint(lingfu, 0.00, 0.00)
	GUI:setTouchEnabled(lingfu, false)
	GUI:setTag(lingfu, 0)

	-- Create bind_lingfu
	local bind_lingfu = GUI:Text_Create(Image_bg, "bind_lingfu", 325, 51, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(bind_lingfu, "#000000", 1)
	GUI:setAnchorPoint(bind_lingfu, 0.00, 0.00)
	GUI:setTouchEnabled(bind_lingfu, false)
	GUI:setTag(bind_lingfu, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Image_bg, "ItemShow_1", 46, 87, {index = 2, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(Image_bg, "ItemShow_2", 46, 61, {index = 2, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(Image_bg, "ItemShow_3", 179, 87, {index = 2, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(Image_bg, "ItemShow_4", 179, 60, {index = 2, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(Image_bg, "ItemShow_5", 309, 87, {index = 2, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(Image_bg, "ItemShow_6", 309, 62, {index = 2, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create EquipTuJianBtn
	local EquipTuJianBtn = GUI:Button_Create(Image_bg, "EquipTuJianBtn", 520, 33, "res/custom/npc/18tj/bq1.png")
	GUI:setContentSize(EquipTuJianBtn, 78, 74)
	GUI:setIgnoreContentAdaptWithSize(EquipTuJianBtn, false)
	GUI:Button_setTitleText(EquipTuJianBtn, [[]])
	GUI:Button_setTitleColor(EquipTuJianBtn, "#ffffff")
	GUI:Button_setTitleFontSize(EquipTuJianBtn, 16)
	GUI:Button_titleEnableOutline(EquipTuJianBtn, "#000000", 1)
	GUI:setAnchorPoint(EquipTuJianBtn, 0.50, 0.50)
	GUI:setTouchEnabled(EquipTuJianBtn, true)
	GUI:setTag(EquipTuJianBtn, 0)

	-- Create Button_page1
	local Button_page1 = GUI:Button_Create(Panel_1, "Button_page1", 5, 287, "res/public_win32/1900000683_1_f.png")
	GUI:Button_loadTexturePressed(Button_page1, "res/public_win32/1900000683_f.png")
	GUI:Button_loadTextureDisabled(Button_page1, "res/public_win32/1900000683_f.png")
	GUI:setContentSize(Button_page1, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page1, false)
	GUI:Button_setTitleText(Button_page1, [[]])
	GUI:Button_setTitleColor(Button_page1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page1, 14)
	GUI:Button_titleEnableOutline(Button_page1, "#000000", 1)
	GUI:setChineseName(Button_page1, "背包_第一页_组合框")
	GUI:setAnchorPoint(Button_page1, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page1, false)
	GUI:setTag(Button_page1, -1)

	-- Create PageText
	local PageText = GUI:Text_Create(Button_page1, "PageText", 13, 45, 14, "#ffffff", [[一]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第一页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	local TouchSize = GUI:Layout_Create(Button_page1, "TouchSize", 0, 67, 25, 55, false)
	GUI:setChineseName(TouchSize, "背包_第一页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page2
	local Button_page2 = GUI:Button_Create(Panel_1, "Button_page2", 5, 237, "res/public_win32/1900000683_1_f.png")
	GUI:Button_loadTexturePressed(Button_page2, "res/public_win32/1900000683_f.png")
	GUI:Button_loadTextureDisabled(Button_page2, "res/public_win32/1900000683_f.png")
	GUI:setContentSize(Button_page2, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page2, false)
	GUI:Button_setTitleText(Button_page2, [[]])
	GUI:Button_setTitleColor(Button_page2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page2, 14)
	GUI:Button_titleEnableOutline(Button_page2, "#000000", 1)
	GUI:setChineseName(Button_page2, "背包_第二页_组合框")
	GUI:setAnchorPoint(Button_page2, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page2, false)
	GUI:setTag(Button_page2, -1)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page2, "PageText", 13, 45, 14, "#ffffff", [[二]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第二页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page2, "TouchSize", 0, 67, 25, 55, false)
	GUI:setChineseName(TouchSize, "背包_第二页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page3
	local Button_page3 = GUI:Button_Create(Panel_1, "Button_page3", 5, 187, "res/public_win32/1900000683_1_f.png")
	GUI:Button_loadTexturePressed(Button_page3, "res/public_win32/1900000683_f.png")
	GUI:Button_loadTextureDisabled(Button_page3, "res/public_win32/1900000683_f.png")
	GUI:setContentSize(Button_page3, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page3, false)
	GUI:Button_setTitleText(Button_page3, [[]])
	GUI:Button_setTitleColor(Button_page3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page3, 14)
	GUI:Button_titleEnableOutline(Button_page3, "#000000", 1)
	GUI:setChineseName(Button_page3, "背包_第三页_组合框")
	GUI:setAnchorPoint(Button_page3, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page3, false)
	GUI:setTag(Button_page3, -1)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page3, "PageText", 13, 45, 14, "#ffffff", [[三]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第三页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page3, "TouchSize", 0, 67, 25, 55, false)
	GUI:setChineseName(TouchSize, "背包_第三页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page4
	local Button_page4 = GUI:Button_Create(Panel_1, "Button_page4", 5, 137, "res/public_win32/1900000683_1_f.png")
	GUI:Button_loadTexturePressed(Button_page4, "res/public_win32/1900000683_f.png")
	GUI:Button_loadTextureDisabled(Button_page4, "res/public_win32/1900000683_f.png")
	GUI:setContentSize(Button_page4, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page4, false)
	GUI:Button_setTitleText(Button_page4, [[]])
	GUI:Button_setTitleColor(Button_page4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page4, 14)
	GUI:Button_titleEnableOutline(Button_page4, "#000000", 1)
	GUI:setChineseName(Button_page4, "背包_第四页_组合框")
	GUI:setAnchorPoint(Button_page4, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page4, false)
	GUI:setTag(Button_page4, -1)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page4, "PageText", 13, 45, 14, "#ffffff", [[四]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第四页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page4, "TouchSize", 0, 67, 25, 55, false)
	GUI:setChineseName(TouchSize, "背包_第四页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page5
	local Button_page5 = GUI:Button_Create(Panel_1, "Button_page5", 5, 87, "res/public_win32/1900000683_1_f.png")
	GUI:Button_loadTexturePressed(Button_page5, "res/public_win32/1900000683_f.png")
	GUI:Button_loadTextureDisabled(Button_page5, "res/public_win32/1900000683_f.png")
	GUI:setContentSize(Button_page5, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page5, false)
	GUI:Button_setTitleText(Button_page5, [[]])
	GUI:Button_setTitleColor(Button_page5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page5, 14)
	GUI:Button_titleEnableOutline(Button_page5, "#000000", 1)
	GUI:setChineseName(Button_page5, "背包_第五页_组合框")
	GUI:setAnchorPoint(Button_page5, 0.50, 0.50)
	GUI:setTouchEnabled(Button_page5, false)
	GUI:setTag(Button_page5, -1)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page5, "PageText", 13, 45, 14, "#ffffff", [[五]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第五页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page5, "TouchSize", 0, 67, 25, 55, false)
	GUI:setChineseName(TouchSize, "背包_第五页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_close
	local Button_close = GUI:Button_Create(Panel_1, "Button_close", 396, 315, "res/public_win32/btn_02.png")
	GUI:setContentSize(Button_close, 16, 27)
	GUI:setIgnoreContentAdaptWithSize(Button_close, false)
	GUI:Button_setTitleText(Button_close, [[]])
	GUI:Button_setTitleColor(Button_close, "#414146")
	GUI:Button_setTitleFontSize(Button_close, 14)
	GUI:Button_titleDisableOutLine(Button_close)
	GUI:setChineseName(Button_close, "背包_关闭按钮")
	GUI:setAnchorPoint(Button_close, 0.50, 0.50)
	GUI:setTouchEnabled(Button_close, true)
	GUI:setTag(Button_close, 19)
	TAGOBJ["19"] = Button_close

	-- Create Panel_items
	local Panel_items = GUI:Layout_Create(Panel_1, "Panel_items", 32, 316, 338, 214, false)
	GUI:setChineseName(Panel_items, "背包_物品")
	GUI:setAnchorPoint(Panel_items, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_items, true)
	GUI:setTag(Panel_items, 21)
	TAGOBJ["21"] = Panel_items

	-- Create Image_gold
	local Image_gold = GUI:Image_Create(Panel_1, "Image_gold", 37, 75, "res/private/bag_ui/bag_ui_win32/1900015220.png")
	GUI:setChineseName(Image_gold, "背包_金币图片")
	GUI:setAnchorPoint(Image_gold, 0.50, 0.50)
	GUI:setTouchEnabled(Image_gold, true)
	GUI:setTag(Image_gold, 23)
	TAGOBJ["23"] = Image_gold

	-- Create Text_goldNum
	local Text_goldNum = GUI:Text_Create(Panel_1, "Text_goldNum", 73, 82, 14, "#ffffff", [[]])
	GUI:Text_enableOutline(Text_goldNum, "#000000", 1)
	GUI:setChineseName(Text_goldNum, "背包_金币数量")
	GUI:setAnchorPoint(Text_goldNum, 0.00, 0.50)
	GUI:setTouchEnabled(Text_goldNum, false)
	GUI:setTag(Text_goldNum, 25)
	GUI:setVisible(Text_goldNum, false)
	TAGOBJ["25"] = Text_goldNum

	-- Create Button_store_hero_bag
	local Button_store_hero_bag = GUI:Button_Create(Panel_1, "Button_store_hero_bag", 305, 85, "res/public/1900000652.png")
	GUI:Button_loadTexturePressed(Button_store_hero_bag, "res/public/1900000652_1.png")
	GUI:Button_loadTextureDisabled(Button_store_hero_bag, "res/public/1900000652_1.png")
	GUI:setContentSize(Button_store_hero_bag, 89, 29)
	GUI:setIgnoreContentAdaptWithSize(Button_store_hero_bag, false)
	GUI:Button_setTitleText(Button_store_hero_bag, [[存入英雄背包]])
	GUI:Button_setTitleColor(Button_store_hero_bag, "#ffffff")
	GUI:Button_setTitleFontSize(Button_store_hero_bag, 13)
	GUI:Button_titleEnableOutline(Button_store_hero_bag, "#000000", 1)
	GUI:setChineseName(Button_store_hero_bag, "背包_存入英雄背包_按钮")
	GUI:setAnchorPoint(Button_store_hero_bag, 0.50, 0.50)
	GUI:setTouchEnabled(Button_store_hero_bag, true)
	GUI:setTag(Button_store_hero_bag, 17)
	TAGOBJ["17"] = Button_store_hero_bag

	-- Create ScrollView_items
	local ScrollView_items = GUI:ScrollView_Create(Panel_1, "ScrollView_items", 32, 316, 338, 214, 1)
	GUI:ScrollView_setInnerContainerSize(ScrollView_items, 338.00, 462.00)
	GUI:setChineseName(ScrollView_items, "背包_物品列表")
	GUI:setAnchorPoint(ScrollView_items, 0.00, 1.00)
	GUI:setTouchEnabled(ScrollView_items, true)
	GUI:setTag(ScrollView_items, -1)

	-- Create Panel_addItems
	local Panel_addItems = GUI:Layout_Create(Panel_1, "Panel_addItems", 32, 287, 338, 214, false)
	GUI:setChineseName(Panel_addItems, "背包_添加物品层")
	GUI:setAnchorPoint(Panel_addItems, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_addItems, true)
	GUI:setTag(Panel_addItems, 22)
	TAGOBJ["22"] = Panel_addItems

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
