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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/62xs/bg2.png")
	GUI:Image_setScale9Slice(FrameBG, 77, 77, 172, 172)
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

	-- Create startBtn
	local startBtn = GUI:Button_Create(FrameLayout, "startBtn", 598, 69, "res/custom/npc/62xs/an.png")
	GUI:setContentSize(startBtn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(startBtn, false)
	GUI:Button_setTitleText(startBtn, [[]])
	GUI:Button_setTitleColor(startBtn, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn, 18)
	GUI:Button_titleEnableOutline(startBtn, "#000000", 1)
	GUI:setAnchorPoint(startBtn, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn, true)
	GUI:setTag(startBtn, 0)

	-- Create EquipShow_1
	local EquipShow_1 = GUI:EquipShow_Create(FrameLayout, "EquipShow_1", 288, 353, 12, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = false, lookPlayer = false, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_1)
	GUI:setAnchorPoint(EquipShow_1, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_1, false)
	GUI:setTag(EquipShow_1, 0)

	-- Create CheckBox_1
	local CheckBox_1 = GUI:CheckBox_Create(FrameLayout, "CheckBox_1", 749, 409, "res/custom/npc/62xs/gx0.png", "res/custom/npc/62xs/gx1.png")
	GUI:setContentSize(CheckBox_1, 28, 28)
	GUI:setIgnoreContentAdaptWithSize(CheckBox_1, false)
	GUI:CheckBox_setSelected(CheckBox_1, false)
	GUI:setAnchorPoint(CheckBox_1, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox_1, true)
	GUI:setTag(CheckBox_1, 0)

	-- Create CheckBox_2
	local CheckBox_2 = GUI:CheckBox_Create(FrameLayout, "CheckBox_2", 749, 343, "res/custom/npc/62xs/gx0.png", "res/custom/npc/62xs/gx1.png")
	GUI:setContentSize(CheckBox_2, 28, 28)
	GUI:setIgnoreContentAdaptWithSize(CheckBox_2, false)
	GUI:CheckBox_setSelected(CheckBox_2, false)
	GUI:setAnchorPoint(CheckBox_2, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox_2, true)
	GUI:setTag(CheckBox_2, 0)

	-- Create CheckBox_3
	local CheckBox_3 = GUI:CheckBox_Create(FrameLayout, "CheckBox_3", 749, 276, "res/custom/npc/62xs/gx0.png", "res/custom/npc/62xs/gx1.png")
	GUI:setContentSize(CheckBox_3, 28, 28)
	GUI:setIgnoreContentAdaptWithSize(CheckBox_3, false)
	GUI:CheckBox_setSelected(CheckBox_3, false)
	GUI:setAnchorPoint(CheckBox_3, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox_3, true)
	GUI:setTag(CheckBox_3, 0)

	-- Create needItem_1
	local needItem_1 = GUI:ItemShow_Create(FrameLayout, "needItem_1", 609, 154, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_1, 0.50, 0.50)
	GUI:setTag(needItem_1, 0)

	-- Create needItem_2
	local needItem_2 = GUI:ItemShow_Create(FrameLayout, "needItem_2", 681, 154, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_2, 0.50, 0.50)
	GUI:setTag(needItem_2, 0)

	-- Create title_txt
	local title_txt = GUI:Text_Create(FrameLayout, "title_txt", 289, 214, 18, "#ffff00", [[等级BUFF为79级生效]])
	GUI:Text_enableOutline(title_txt, "#000000", 1)
	GUI:setAnchorPoint(title_txt, 0.50, 0.00)
	GUI:setTouchEnabled(title_txt, false)
	GUI:setTag(title_txt, 0)

	-- Create ruleBtn
	local ruleBtn = GUI:Button_Create(FrameLayout, "ruleBtn", 437, 423, "res/custom/npc/62xs/wh.png")
	GUI:setContentSize(ruleBtn, 66, 52)
	GUI:setIgnoreContentAdaptWithSize(ruleBtn, false)
	GUI:Button_setTitleText(ruleBtn, [[]])
	GUI:Button_setTitleColor(ruleBtn, "#ffffff")
	GUI:Button_setTitleFontSize(ruleBtn, 16)
	GUI:Button_titleEnableOutline(ruleBtn, "#000000", 1)
	GUI:setAnchorPoint(ruleBtn, 0.00, 0.00)
	GUI:setTouchEnabled(ruleBtn, true)
	GUI:setTag(ruleBtn, 0)

	-- Create maskLayout
	local maskLayout = GUI:Layout_Create(parent, "maskLayout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(maskLayout, 0.00, 0.00)
	GUI:setTouchEnabled(maskLayout, true)
	GUI:setTag(maskLayout, 0)
	GUI:setVisible(maskLayout, false)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(maskLayout, "Image_1", 568, 320, "res/public/bg_npc_08.jpg")
	GUI:Image_setScale9Slice(Image_1, 40, 40, 88, 88)
	GUI:setContentSize(Image_1, 406, 200)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(Image_1, "ListView_1", 13, 15, 380, 170, 1)
	GUI:ListView_setItemsMargin(ListView_1, 8)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(ListView_1, "Text_1", 0, 146, 16, "#ff9b00", [[血石觉醒说明:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(ListView_1, "Text_2", 0, 114, 16, "#ff9b00", [[觉醒属性共分为4类：A级、S级、SP级、GP级]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(ListView_1, "Text_3", 0, 82, 16, "#00ff00", [[A级绿色属性，抽取概率50%]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(ListView_1, "Text_4", 0, 50, 16, "#ffff00", [[S级黄色属性，抽取概率30%]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(ListView_1, "Text_5", 0, 18, 16, "#9b00ff", [[SP级粉色属性，抽取概率15%]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(ListView_1, "Text_6", 0, -14, 16, "#ff0000", [[GP级红色属性，抽取概率5%]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
