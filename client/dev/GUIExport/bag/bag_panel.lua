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
	local Panel_1 = GUI:Layout_Create(Scene, "Panel_1", 98, 340, 568, 469, false)
	GUI:setChineseName(Panel_1, "背包组合框")
	GUI:setAnchorPoint(Panel_1, 0.00, 0.50)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 2)
	TAGOBJ["2"] = Panel_1

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_1, "Image_bg", 284, 235, "res/private/bag_ui/bag_ui_mobile/bg_beibao_01.png")
	GUI:setChineseName(Image_bg, "背包_背景_图片")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, true)
	GUI:setTag(Image_bg, 3)
	TAGOBJ["3"] = Image_bg

	-- Create Button_page1
	local Button_page1 = GUI:Button_Create(Panel_1, "Button_page1", -14, 410, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page1, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page1, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page1, 34, 92)
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
	local PageText = GUI:Text_Create(Button_page1, "PageText", 20, 60, 18, "#ffffff", [[一]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第一页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	local TouchSize = GUI:Layout_Create(Button_page1, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第一页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page2
	local Button_page2 = GUI:Button_Create(Panel_1, "Button_page2", -14, 343, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page2, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page2, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page2, 34, 92)
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
	PageText = GUI:Text_Create(Button_page2, "PageText", 20, 60, 18, "#ffffff", [[二]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第二页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page2, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第二页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page3
	local Button_page3 = GUI:Button_Create(Panel_1, "Button_page3", -14, 276, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page3, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page3, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page3, 34, 92)
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
	PageText = GUI:Text_Create(Button_page3, "PageText", 20, 60, 18, "#ffffff", [[三]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第三页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page3, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第三页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page4
	local Button_page4 = GUI:Button_Create(Panel_1, "Button_page4", -14, 209, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page4, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page4, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page4, 34, 92)
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
	PageText = GUI:Text_Create(Button_page4, "PageText", 20, 60, 18, "#ffffff", [[四]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第四页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page4, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第四页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page5
	local Button_page5 = GUI:Button_Create(Panel_1, "Button_page5", -14, 142, "res/public/1900000641_1.png")
	GUI:Button_loadTexturePressed(Button_page5, "res/public/1900000640_1.png")
	GUI:Button_loadTextureDisabled(Button_page5, "res/public/1900000640_1.png")
	GUI:setContentSize(Button_page5, 34, 92)
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
	PageText = GUI:Text_Create(Button_page5, "PageText", 20, 60, 18, "#ffffff", [[五]])
	GUI:Text_enableOutline(PageText, "#000000", 1)
	GUI:setChineseName(PageText, "背包_第五页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page5, "TouchSize", 0, 92, 33, 75, false)
	GUI:setChineseName(TouchSize, "背包_第五页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_close
	local Button_close = GUI:Button_Create(Panel_1, "Button_close", 540, 428, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(Button_close, "res/public/1900000511.png")
	GUI:Button_setScale9Slice(Button_close, 9, 8, 15, 13)
	GUI:setContentSize(Button_close, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_close, false)
	GUI:Button_setTitleText(Button_close, [[]])
	GUI:Button_setTitleColor(Button_close, "#414146")
	GUI:Button_setTitleFontSize(Button_close, 14)
	GUI:Button_titleDisableOutLine(Button_close)
	GUI:setChineseName(Button_close, "背包_关闭按钮")
	GUI:setAnchorPoint(Button_close, 0.00, 0.00)
	GUI:setTouchEnabled(Button_close, true)
	GUI:setTag(Button_close, 8)
	TAGOBJ["8"] = Button_close

	-- Create Image_gold
	local Image_gold = GUI:Image_Create(Panel_1, "Image_gold", 25, 102, "res/private/bag_ui/bag_ui_mobile/1900015220.png")
	GUI:setChineseName(Image_gold, "背包_金币图片")
	GUI:setAnchorPoint(Image_gold, 0.50, 0.50)
	GUI:setTouchEnabled(Image_gold, true)
	GUI:setTag(Image_gold, 5)
	GUI:setVisible(Image_gold, false)
	TAGOBJ["5"] = Image_gold

	-- Create Button_store_hero_bag
	local Button_store_hero_bag = GUI:Button_Create(Panel_1, "Button_store_hero_bag", 320, 110, "res/public/1900000652.png")
	GUI:Button_loadTexturePressed(Button_store_hero_bag, "res/public/1900000652_1.png")
	GUI:Button_loadTextureDisabled(Button_store_hero_bag, "res/public/1900000652_1.png")
	GUI:setContentSize(Button_store_hero_bag, 120, 29)
	GUI:setIgnoreContentAdaptWithSize(Button_store_hero_bag, false)
	GUI:Button_setTitleText(Button_store_hero_bag, [[存入英雄背包]])
	GUI:Button_setTitleColor(Button_store_hero_bag, "#ffffff")
	GUI:Button_setTitleFontSize(Button_store_hero_bag, 18)
	GUI:Button_titleEnableOutline(Button_store_hero_bag, "#000000", 1)
	GUI:setChineseName(Button_store_hero_bag, "背包_存入英雄背包_按钮")
	GUI:setAnchorPoint(Button_store_hero_bag, 0.50, 0.50)
	GUI:setTouchEnabled(Button_store_hero_bag, true)
	GUI:setTag(Button_store_hero_bag, 17)
	GUI:setVisible(Button_store_hero_bag, false)
	TAGOBJ["17"] = Button_store_hero_bag

	-- Create ScrollView_items
	local ScrollView_items = GUI:ScrollView_Create(Panel_1, "ScrollView_items", 24, 452, 500, 320, 1)
	GUI:ScrollView_setInnerContainerSize(ScrollView_items, 500.00, 320.00)
	GUI:setChineseName(ScrollView_items, "背包_物品列表")
	GUI:setAnchorPoint(ScrollView_items, 0.00, 1.00)
	GUI:setTouchEnabled(ScrollView_items, true)
	GUI:setTag(ScrollView_items, -1)

	-- Create Panel_addItems
	local Panel_addItems = GUI:Layout_Create(Panel_1, "Panel_addItems", 24, 452, 500, 320, false)
	GUI:setChineseName(Panel_addItems, "背包_添加物品层")
	GUI:setAnchorPoint(Panel_addItems, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_addItems, true)
	GUI:setTag(Panel_addItems, 10)
	TAGOBJ["10"] = Panel_addItems

	-- Create yuanbao
	local yuanbao = GUI:Text_Create(Panel_1, "yuanbao", 75, 105, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(yuanbao, "#000000", 1)
	GUI:setAnchorPoint(yuanbao, 0.00, 0.00)
	GUI:setTouchEnabled(yuanbao, false)
	GUI:setTag(yuanbao, -1)

	-- Create bind_yuanbao
	local bind_yuanbao = GUI:Text_Create(Panel_1, "bind_yuanbao", 75, 77, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(bind_yuanbao, "#000000", 1)
	GUI:setAnchorPoint(bind_yuanbao, 0.00, 0.00)
	GUI:setTouchEnabled(bind_yuanbao, false)
	GUI:setTag(bind_yuanbao, -1)

	-- Create jgs
	local jgs = GUI:Text_Create(Panel_1, "jgs", 220, 105, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(jgs, "#000000", 1)
	GUI:setAnchorPoint(jgs, 0.00, 0.00)
	GUI:setTouchEnabled(jgs, false)
	GUI:setTag(jgs, -1)

	-- Create bind_jgs
	local bind_jgs = GUI:Text_Create(Panel_1, "bind_jgs", 220, 77, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(bind_jgs, "#000000", 1)
	GUI:setAnchorPoint(bind_jgs, 0.00, 0.00)
	GUI:setTouchEnabled(bind_jgs, false)
	GUI:setTag(bind_jgs, -1)

	-- Create lingfu
	local lingfu = GUI:Text_Create(Panel_1, "lingfu", 367, 105, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(lingfu, "#000000", 1)
	GUI:setAnchorPoint(lingfu, 0.00, 0.00)
	GUI:setTouchEnabled(lingfu, false)
	GUI:setTag(lingfu, -1)

	-- Create bind_lingfu
	local bind_lingfu = GUI:Text_Create(Panel_1, "bind_lingfu", 367, 77, 16, "#ffffff", [[0]])
	GUI:Text_enableOutline(bind_lingfu, "#000000", 1)
	GUI:setAnchorPoint(bind_lingfu, 0.00, 0.00)
	GUI:setTouchEnabled(bind_lingfu, false)
	GUI:setTag(bind_lingfu, -1)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Panel_1, "ItemShow_1", 55, 115, {index = 2, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(Panel_1, "ItemShow_2", 55, 87, {index = 2, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(Panel_1, "ItemShow_3", 201, 115, {index = 2, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(Panel_1, "ItemShow_4", 200, 87, {index = 2, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(Panel_1, "ItemShow_5", 346, 115, {index = 2, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(Panel_1, "ItemShow_6", 345, 87, {index = 2, count = 1, look = true, bgVisible = false})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create EquipTuJianBtn
	local EquipTuJianBtn = GUI:Button_Create(Panel_1, "EquipTuJianBtn", 487, 0, "res/custom/npc/18tj/bq1.png")
	GUI:Button_setTitleText(EquipTuJianBtn, [[]])
	GUI:Button_setTitleColor(EquipTuJianBtn, "#ffffff")
	GUI:Button_setTitleFontSize(EquipTuJianBtn, 16)
	GUI:Button_titleEnableOutline(EquipTuJianBtn, "#000000", 1)
	GUI:setAnchorPoint(EquipTuJianBtn, 0.00, 0.00)
	GUI:setTouchEnabled(EquipTuJianBtn, true)
	GUI:setTag(EquipTuJianBtn, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
