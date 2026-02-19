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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 593, 414, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/01ditu/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 59, 59, 134, 134)
	GUI:setContentSize(FrameBG, 593, 414)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create miniMapImg
	local miniMapImg = GUI:Image_Create(FrameLayout, "miniMapImg", 150, 245, "scene/uiminimap/000305.png")
	GUI:setContentSize(miniMapImg, 512, 341)
	GUI:setIgnoreContentAdaptWithSize(miniMapImg, false)
	GUI:setAnchorPoint(miniMapImg, 0.50, 0.50)
	GUI:setScaleX(miniMapImg, 0.51)
	GUI:setScaleY(miniMapImg, 0.74)
	GUI:setTouchEnabled(miniMapImg, false)
	GUI:setTag(miniMapImg, 0)

	-- Create mapName
	local mapName = GUI:Text_Create(FrameLayout, "mapName", 426, 342, 18, "#ffffff", [[火龙巢穴]])
	GUI:Text_enableOutline(mapName, "#000000", 1)
	GUI:setAnchorPoint(mapName, 0.50, 0.00)
	GUI:setTouchEnabled(mapName, false)
	GUI:setTag(mapName, 0)

	-- Create baoLvTitle
	local baoLvTitle = GUI:Text_Create(FrameLayout, "baoLvTitle", 421, 198, 18, "#ffffff", [[部分爆率展示]])
	GUI:Text_enableOutline(baoLvTitle, "#000000", 1)
	GUI:setAnchorPoint(baoLvTitle, 0.50, 0.00)
	GUI:setTouchEnabled(baoLvTitle, false)
	GUI:setTag(baoLvTitle, 0)

	-- Create mapInfo
	local mapInfo = GUI:Node_Create(FrameLayout, "mapInfo", 419, 274)
	GUI:setTag(mapInfo, 0)

	-- Create map_title1
	local map_title1 = GUI:Text_Create(mapInfo, "map_title1", -120, 22, 18, "#00ff00", [[地图:]])
	GUI:Text_enableOutline(map_title1, "#000000", 1)
	GUI:setAnchorPoint(map_title1, 0.00, 0.00)
	GUI:setTouchEnabled(map_title1, false)
	GUI:setTag(map_title1, 0)

	-- Create map_title2
	local map_title2 = GUI:Text_Create(mapInfo, "map_title2", -120, -8, 18, "#00ff00", [[刷怪:]])
	GUI:Text_enableOutline(map_title2, "#000000", 1)
	GUI:setAnchorPoint(map_title2, 0.00, 0.00)
	GUI:setTouchEnabled(map_title2, false)
	GUI:setTag(map_title2, 0)

	-- Create map_title3
	local map_title3 = GUI:Text_Create(mapInfo, "map_title3", -120, -39, 18, "#00ff00", [[Boss:]])
	GUI:Text_enableOutline(map_title3, "#000000", 1)
	GUI:setAnchorPoint(map_title3, 0.00, 0.00)
	GUI:setTouchEnabled(map_title3, false)
	GUI:setTag(map_title3, 0)

	-- Create blInfo
	local blInfo = GUI:Node_Create(FrameLayout, "blInfo", 424, 152)
	GUI:setTag(blInfo, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(blInfo, "ItemShow_1", -97, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(blInfo, "ItemShow_2", -26, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(blInfo, "ItemShow_3", 42, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(blInfo, "ItemShow_4", 108, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create bottomInfo
	local bottomInfo = GUI:Node_Create(FrameLayout, "bottomInfo", 274, 59)
	GUI:setTag(bottomInfo, 0)

	-- Create b_title1
	local b_title1 = GUI:Text_Create(bottomInfo, "b_title1", -245, 12, 18, "#00ff00", [[进入条件:]])
	GUI:Text_enableOutline(b_title1, "#000000", 1)
	GUI:setAnchorPoint(b_title1, 0.00, 0.00)
	GUI:setTouchEnabled(b_title1, false)
	GUI:setTag(b_title1, 0)

	-- Create b_title2
	local b_title2 = GUI:Text_Create(bottomInfo, "b_title2", -245, -19, 18, "#00ff00", [[地图难度:]])
	GUI:Text_enableOutline(b_title2, "#000000", 1)
	GUI:setAnchorPoint(b_title2, 0.00, 0.00)
	GUI:setTouchEnabled(b_title2, false)
	GUI:setTag(b_title2, 0)

	-- Create enterGBBtn
	local enterGBBtn = GUI:Button_Create(FrameLayout, "enterGBBtn", 299, 26, "res/custom/npc/01ditu/an.png")
	GUI:Button_loadTexturePressed(enterGBBtn, "res/custom/npc/01ditu/taban.png")
	GUI:setContentSize(enterGBBtn, 128, 42)
	GUI:setIgnoreContentAdaptWithSize(enterGBBtn, false)
	GUI:Button_setTitleText(enterGBBtn, [[高爆地图]])
	GUI:Button_setTitleColor(enterGBBtn, "#ffffff")
	GUI:Button_setTitleFontSize(enterGBBtn, 18)
	GUI:Button_titleEnableOutline(enterGBBtn, "#000000", 1)
	GUI:setAnchorPoint(enterGBBtn, 0.00, 0.00)
	GUI:setTouchEnabled(enterGBBtn, true)
	GUI:setTag(enterGBBtn, 0)

	-- Create enterMapBtn
	local enterMapBtn = GUI:Button_Create(FrameLayout, "enterMapBtn", 435, 27, "res/custom/npc/01ditu/an.png")
	GUI:Button_loadTexturePressed(enterMapBtn, "res/custom/npc/01ditu/taban.png")
	GUI:setContentSize(enterMapBtn, 128, 42)
	GUI:setIgnoreContentAdaptWithSize(enterMapBtn, false)
	GUI:Button_setTitleText(enterMapBtn, [[地图传送]])
	GUI:Button_setTitleColor(enterMapBtn, "#ffffff")
	GUI:Button_setTitleFontSize(enterMapBtn, 18)
	GUI:Button_titleEnableOutline(enterMapBtn, "#000000", 1)
	GUI:setAnchorPoint(enterMapBtn, 0.00, 0.00)
	GUI:setTouchEnabled(enterMapBtn, true)
	GUI:setTag(enterMapBtn, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 591, 371, "res/public/1900000510.png")
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

	-- Create gaobaoLayout
	local gaobaoLayout = GUI:Layout_Create(FrameLayout, "gaobaoLayout", 296, 207, 1136, 640, false)
	GUI:setAnchorPoint(gaobaoLayout, 0.50, 0.50)
	GUI:setTouchEnabled(gaobaoLayout, true)
	GUI:setTag(gaobaoLayout, 0)
	GUI:setVisible(gaobaoLayout, false)

	-- Create BgImage
	local BgImage = GUI:Image_Create(gaobaoLayout, "BgImage", 568, 320, "res/public/bg_npc_08.jpg")
	GUI:setContentSize(BgImage, 406, 220)
	GUI:setIgnoreContentAdaptWithSize(BgImage, false)
	GUI:setAnchorPoint(BgImage, 0.50, 0.50)
	GUI:setTouchEnabled(BgImage, false)
	GUI:setTag(BgImage, 0)

	-- Create gb_title1
	local gb_title1 = GUI:Text_Create(gaobaoLayout, "gb_title1", 568, 390, 18, "#00ff00", [[高爆地图额外条件]])
	GUI:Text_enableOutline(gb_title1, "#000000", 1)
	GUI:setAnchorPoint(gb_title1, 0.50, 0.00)
	GUI:setTouchEnabled(gb_title1, false)
	GUI:setTag(gb_title1, 0)

	-- Create gb_title2
	local gb_title2 = GUI:Text_Create(gaobaoLayout, "gb_title2", 568, 360, 16, "#ffff00", [[进入条件一: 开通终身特权]])
	GUI:Text_enableOutline(gb_title2, "#000000", 1)
	GUI:setAnchorPoint(gb_title2, 0.50, 0.00)
	GUI:setTouchEnabled(gb_title2, false)
	GUI:setTag(gb_title2, 0)

	-- Create gb_title3
	local gb_title3 = GUI:Text_Create(gaobaoLayout, "gb_title3", 568, 330, 16, "#ffff00", [[进入条件二: 今日任意充值]])
	GUI:Text_enableOutline(gb_title3, "#000000", 1)
	GUI:setAnchorPoint(gb_title3, 0.50, 0.00)
	GUI:setTouchEnabled(gb_title3, false)
	GUI:setTag(gb_title3, 0)

	-- Create gb_title4
	local gb_title4 = GUI:Text_Create(gaobaoLayout, "gb_title4", 568, 290, 18, "#00ff00", [[需额外满足以上条件可进入,限时一小时]])
	GUI:Text_enableOutline(gb_title4, "#000000", 1)
	GUI:setAnchorPoint(gb_title4, 0.50, 0.00)
	GUI:setTouchEnabled(gb_title4, false)
	GUI:setTag(gb_title4, 0)

	-- Create Button_GB
	local Button_GB = GUI:Button_Create(gaobaoLayout, "Button_GB", 568, 230, "res/public/1900000680.png")
	GUI:setContentSize(Button_GB, 106, 40)
	GUI:setIgnoreContentAdaptWithSize(Button_GB, false)
	GUI:Button_setTitleText(Button_GB, [[立即进入]])
	GUI:Button_setTitleColor(Button_GB, "#ffffff")
	GUI:Button_setTitleFontSize(Button_GB, 16)
	GUI:Button_titleEnableOutline(Button_GB, "#000000", 1)
	GUI:setAnchorPoint(Button_GB, 0.50, 0.00)
	GUI:setTouchEnabled(Button_GB, true)
	GUI:setTag(Button_GB, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
