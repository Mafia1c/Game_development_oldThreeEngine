local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 370, 65, 450, 520, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 449, 479, "res/public/1900000510.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create LayoutBg
	local LayoutBg = GUI:Image_Create(FrameLayout, "LayoutBg", 0, 0, "res/custom/npc/17hs/bg.png")
	GUI:setAnchorPoint(LayoutBg, 0.00, 0.00)
	GUI:setTouchEnabled(LayoutBg, true)
	GUI:setMouseEnabled(LayoutBg, true)
	GUI:setTag(LayoutBg, 0)

	-- Create pageBtns
	local pageBtns = GUI:Layout_Create(FrameLayout, "pageBtns", 448, 0, 34, 440, false)
	GUI:setAnchorPoint(pageBtns, 0.00, 0.00)
	GUI:setTouchEnabled(pageBtns, false)
	GUI:setTag(pageBtns, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(pageBtns, "Button_1", 0, 357, "res/custom/npc/17hs/c1.png")
	GUI:setContentSize(Button_1, 32, 84)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(Button_1, "Text_4", 6, 29, 18, "#ffffff", [[普
通]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(pageBtns, "Button_2", 0, 273, "res/custom/npc/17hs/c1.png")
	GUI:setContentSize(Button_2, 32, 84)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(Button_2, "Text_5", 6, 29, 18, "#ffffff", [[特
殊]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(pageBtns, "Button_3", 0, 186, "res/custom/npc/17hs/c1.png")
	GUI:setContentSize(Button_3, 32, 84)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(Button_3, "Text_6", 6, 29, 18, "#ffffff", [[高
级]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(pageBtns, "Button_4", 0, 99, "res/custom/npc/17hs/c1.png")
	GUI:setContentSize(Button_4, 32, 84)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(Button_4, "Text_7", 6, 29, 18, "#ffffff", [[灵
符]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.00, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)

	-- Create line_img
	local line_img = GUI:Image_Create(FrameLayout, "line_img", 16, 118, "res/custom/npc/17hs/fgx.png")
	GUI:setContentSize(line_img, 416, 4)
	GUI:setIgnoreContentAdaptWithSize(line_img, false)
	GUI:setAnchorPoint(line_img, 0.00, 0.00)
	GUI:setTouchEnabled(line_img, false)
	GUI:setTag(line_img, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 21, 78, 16, "#00ff00", [[自动回收]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create CheckBox_1
	local CheckBox_1 = GUI:CheckBox_Create(FrameLayout, "CheckBox_1", 90, 76, "res/custom/npc/17hs/public_kg_close.png", "res/custom/npc/17hs/public_kg_open.png")
	GUI:setContentSize(CheckBox_1, 55, 30)
	GUI:setIgnoreContentAdaptWithSize(CheckBox_1, false)
	GUI:CheckBox_setSelected(CheckBox_1, false)
	GUI:setAnchorPoint(CheckBox_1, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox_1, true)
	GUI:setTag(CheckBox_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 160, 78, 16, "#00ff00", [[自动经验]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create CheckBox_2
	local CheckBox_2 = GUI:CheckBox_Create(FrameLayout, "CheckBox_2", 230, 76, "res/custom/npc/17hs/public_kg_close.png", "res/custom/npc/17hs/public_kg_open.png")
	GUI:setContentSize(CheckBox_2, 55, 30)
	GUI:setIgnoreContentAdaptWithSize(CheckBox_2, false)
	GUI:CheckBox_setSelected(CheckBox_2, false)
	GUI:setAnchorPoint(CheckBox_2, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox_2, true)
	GUI:setTag(CheckBox_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 300, 78, 16, "#00ff00", [[自动元宝]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create CheckBox_3
	local CheckBox_3 = GUI:CheckBox_Create(FrameLayout, "CheckBox_3", 370, 76, "res/custom/npc/17hs/public_kg_close.png", "res/custom/npc/17hs/public_kg_open.png")
	GUI:setContentSize(CheckBox_3, 55, 30)
	GUI:setIgnoreContentAdaptWithSize(CheckBox_3, false)
	GUI:CheckBox_setSelected(CheckBox_3, false)
	GUI:setAnchorPoint(CheckBox_3, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox_3, true)
	GUI:setTag(CheckBox_3, 0)

	-- Create allOkBtn
	local allOkBtn = GUI:Button_Create(FrameLayout, "allOkBtn", 50, 30, "res/public/1900000662.png")
	GUI:setContentSize(allOkBtn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(allOkBtn, false)
	GUI:Button_setTitleText(allOkBtn, [[一键全选]])
	GUI:Button_setTitleColor(allOkBtn, "#ffffff")
	GUI:Button_setTitleFontSize(allOkBtn, 16)
	GUI:Button_titleEnableOutline(allOkBtn, "#000000", 1)
	GUI:setAnchorPoint(allOkBtn, 0.00, 0.00)
	GUI:setTouchEnabled(allOkBtn, true)
	GUI:setTag(allOkBtn, 0)

	-- Create allNoBtn
	local allNoBtn = GUI:Button_Create(FrameLayout, "allNoBtn", 177, 30, "res/public/1900000662.png")
	GUI:setContentSize(allNoBtn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(allNoBtn, false)
	GUI:Button_setTitleText(allNoBtn, [[一键全否]])
	GUI:Button_setTitleColor(allNoBtn, "#ffffff")
	GUI:Button_setTitleFontSize(allNoBtn, 16)
	GUI:Button_titleEnableOutline(allNoBtn, "#000000", 1)
	GUI:setAnchorPoint(allNoBtn, 0.00, 0.00)
	GUI:setTouchEnabled(allNoBtn, true)
	GUI:setTag(allNoBtn, 0)

	-- Create clickBtn
	local clickBtn = GUI:Button_Create(FrameLayout, "clickBtn", 308, 30, "res/public/1900000662.png")
	GUI:setContentSize(clickBtn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(clickBtn, false)
	GUI:Button_setTitleText(clickBtn, [[点击回收]])
	GUI:Button_setTitleColor(clickBtn, "#ffffff")
	GUI:Button_setTitleFontSize(clickBtn, 16)
	GUI:Button_titleEnableOutline(clickBtn, "#000000", 1)
	GUI:setAnchorPoint(clickBtn, 0.00, 0.00)
	GUI:setTouchEnabled(clickBtn, true)
	GUI:setTag(clickBtn, 0)

	-- Create infoList
	local infoList = GUI:ListView_Create(FrameLayout, "infoList", 18, 122, 417, 358, 1)
	GUI:setAnchorPoint(infoList, 0.00, 0.00)
	GUI:setTouchEnabled(infoList, true)
	GUI:setTag(infoList, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
