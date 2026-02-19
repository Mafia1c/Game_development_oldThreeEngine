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
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/34sbk/mb.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 820, 481, "res/public/1900000510.png")
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

	-- Create getReward
	local getReward = GUI:Button_Create(FrameLayout, "getReward", 603, 74, "res/custom/npc/34sbk/an_5.png")
	GUI:setContentSize(getReward, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(getReward, false)
	GUI:Button_setTitleText(getReward, [[]])
	GUI:Button_setTitleColor(getReward, "#ffffff")
	GUI:Button_setTitleFontSize(getReward, 16)
	GUI:Button_titleEnableOutline(getReward, "#000000", 1)
	GUI:setAnchorPoint(getReward, 0.00, 0.00)
	GUI:setTouchEnabled(getReward, true)
	GUI:setTag(getReward, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 123, 128, "res/custom/npc/34sbk/an_1.png")
	GUI:setContentSize(Button_1, 84, 36)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Button_1, "Text_1", 18, -23, 18, "#00ff00", [[(免费)]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 254, 128, "res/custom/npc/34sbk/an_2.png")
	GUI:setContentSize(Button_2, 84, 36)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Button_2, "Text_1", 18, -23, 18, "#00ff00", [[(免费)]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(FrameLayout, "Button_3", 386, 128, "res/custom/npc/34sbk/an_3.png")
	GUI:setContentSize(Button_3, 84, 36)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Button_3, "Text_1", 18, -23, 18, "#00ff00", [[(免费)]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(FrameLayout, "Button_4", 119, 54, "res/custom/npc/34sbk/an_4.png")
	GUI:setContentSize(Button_4, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create tagImg
	local tagImg = GUI:Image_Create(FrameLayout, "tagImg", 85, 417, "res/custom/tag/0-0.png")
	GUI:setContentSize(tagImg, 80, 53)
	GUI:setIgnoreContentAdaptWithSize(tagImg, false)
	GUI:setAnchorPoint(tagImg, 0.00, 0.00)
	GUI:setTouchEnabled(tagImg, false)
	GUI:setTag(tagImg, 0)

	-- Create guild_txt
	local guild_txt = GUI:Text_Create(FrameLayout, "guild_txt", 590, 128, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(guild_txt, "#000000", 1)
	GUI:setAnchorPoint(guild_txt, 0.00, 0.00)
	GUI:setTouchEnabled(guild_txt, false)
	GUI:setTag(guild_txt, 0)

	-- Create point_txt
	local point_txt = GUI:Text_Create(FrameLayout, "point_txt", 725, 128, 16, "#ff0000", [[0]])
	GUI:Text_enableOutline(point_txt, "#000000", 1)
	GUI:setAnchorPoint(point_txt, 0.00, 0.00)
	GUI:setTouchEnabled(point_txt, false)
	GUI:setTag(point_txt, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
