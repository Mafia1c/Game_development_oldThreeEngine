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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 76)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 590, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/45jx/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create midBox
	local midBox = GUI:Layout_Create(FrameBG, "midBox", 439, 257, 740, 456, true)
	GUI:setAnchorPoint(midBox, 0.50, 0.50)
	GUI:setTouchEnabled(midBox, false)
	GUI:setTag(midBox, 0)

	-- Create title
	local title = GUI:Image_Create(midBox, "title", 376, 480, "res/custom/npc/45jx/title.png")
	GUI:setAnchorPoint(title, 0.50, 0.50)
	GUI:setScale(title, 3.00)
	GUI:setOpacity(title, 0)
	GUI:setTouchEnabled(title, false)
	GUI:setTag(title, 0)

	-- Create midList
	local midList = GUI:ListView_Create(midBox, "midList", 3, 69, 732, 282, 1)
	GUI:setAnchorPoint(midList, 0.00, 0.00)
	GUI:setTouchEnabled(midList, true)
	GUI:setTag(midList, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(midList, "Panel_1", 0, 236, 732, 46, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 0)

	-- Create title
	title = GUI:Image_Create(Panel_1, "title", 34, 22, "res/custom/npc/45jx/n_1.png")
	GUI:setAnchorPoint(title, 0.50, 0.50)
	GUI:setTouchEnabled(title, false)
	GUI:setTag(title, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Panel_1, "Text_1", 140, 20, 16, "#ffffff", [[无敌是多模的啊啊寂寞]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(Panel_1, "Text_2", 369, 20, 16, "#ffffff", [[2000000]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(Panel_1, "Text_3", 610, 20, 16, "#ffffff", [[HP+10%、功魔道+10%]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.50, 0.50)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Panel_2
	local Panel_2 = GUI:Layout_Create(midList, "Panel_2", 0, 190, 732, 46, false)
	GUI:setAnchorPoint(Panel_2, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_2, false)
	GUI:setTag(Panel_2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Panel_2, "Text_1", 140, 20, 16, "#ffffff", [[无敌是多模的啊啊寂寞]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(Panel_2, "Text_2", 369, 20, 16, "#ffffff", [[2000000]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	Text_3 = GUI:Text_Create(Panel_2, "Text_3", 610, 20, 16, "#ffffff", [[HP+10%、功魔道+10%]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.50, 0.50)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create title
	title = GUI:Image_Create(Panel_2, "title", 34, 22, "res/custom/npc/45jx/n_2.png")
	GUI:setAnchorPoint(title, 0.50, 0.50)
	GUI:setTouchEnabled(title, false)
	GUI:setTag(title, 0)

	-- Create Panel_3
	local Panel_3 = GUI:Layout_Create(midList, "Panel_3", 0, 144, 732, 46, false)
	GUI:setAnchorPoint(Panel_3, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_3, false)
	GUI:setTag(Panel_3, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Panel_3, "Text_1", 140, 20, 16, "#ffffff", [[无敌是多模的啊啊寂寞]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(Panel_3, "Text_2", 369, 20, 16, "#ffffff", [[2000000]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	Text_3 = GUI:Text_Create(Panel_3, "Text_3", 610, 20, 16, "#ffffff", [[HP+10%、功魔道+10%]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.50, 0.50)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create title
	title = GUI:Image_Create(Panel_3, "title", 34, 22, "res/custom/npc/45jx/n_3.png")
	GUI:setAnchorPoint(title, 0.50, 0.50)
	GUI:setTouchEnabled(title, false)
	GUI:setTag(title, 0)

	-- Create Panel_4
	local Panel_4 = GUI:Layout_Create(midList, "Panel_4", 0, 98, 732, 46, false)
	GUI:setAnchorPoint(Panel_4, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_4, false)
	GUI:setTag(Panel_4, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Panel_4, "Text_1", 140, 20, 16, "#ffffff", [[无敌是多模的啊啊寂寞]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(Panel_4, "Text_2", 369, 20, 16, "#ffffff", [[2000000]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	Text_3 = GUI:Text_Create(Panel_4, "Text_3", 610, 20, 16, "#ffffff", [[HP+10%、功魔道+10%]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.50, 0.50)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create title
	title = GUI:Image_Create(Panel_4, "title", 34, 22, "res/custom/npc/45jx/n_4.png")
	GUI:setAnchorPoint(title, 0.50, 0.50)
	GUI:setTouchEnabled(title, false)
	GUI:setTag(title, 0)

	-- Create Panel_5
	local Panel_5 = GUI:Layout_Create(midList, "Panel_5", 0, 52, 732, 46, false)
	GUI:setAnchorPoint(Panel_5, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_5, false)
	GUI:setTag(Panel_5, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Panel_5, "Text_1", 140, 20, 16, "#ffffff", [[暂无玩家上榜]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(Panel_5, "Text_2", 369, 20, 16, "#ffffff", [[2000000]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	Text_3 = GUI:Text_Create(Panel_5, "Text_3", 610, 20, 16, "#ffffff", [[HP+10%、功魔道+10%]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.50, 0.50)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create title
	title = GUI:Image_Create(Panel_5, "title", 34, 22, "res/custom/npc/45jx/n_5.png")
	GUI:setAnchorPoint(title, 0.50, 0.50)
	GUI:setTouchEnabled(title, false)
	GUI:setTag(title, 0)

	-- Create Panel_6
	local Panel_6 = GUI:Layout_Create(midList, "Panel_6", 0, 6, 732, 46, false)
	GUI:setAnchorPoint(Panel_6, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_6, false)
	GUI:setTag(Panel_6, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Panel_6, "Text_1", 226, 20, 16, "#ffffff", [[捐献10灵符未上榜者，统一获得第6名属性]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(Panel_6, "Text_2", 369, 20, 16, "#ffffff", [[]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	Text_3 = GUI:Text_Create(Panel_6, "Text_3", 610, 20, 16, "#ffffff", [[HP+10%、功魔道+10%]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.50, 0.50)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create title
	title = GUI:Image_Create(Panel_6, "title", 34, 22, "res/custom/npc/45jx/n_6.png")
	GUI:setAnchorPoint(title, 0.50, 0.50)
	GUI:setTouchEnabled(title, false)
	GUI:setTag(title, 0)

	-- Create nowNumber
	local nowNumber = GUI:Text_Create(midBox, "nowNumber", 122, 34, 18, "#ffff00", [[]])
	GUI:Text_enableOutline(nowNumber, "#000000", 1)
	GUI:setAnchorPoint(nowNumber, 0.00, 0.50)
	GUI:setTouchEnabled(nowNumber, false)
	GUI:setTag(nowNumber, 0)

	-- Create inputBox
	local inputBox = GUI:Image_Create(midBox, "inputBox", 450, 36, "res/custom/npc/45jx/t.png")
	GUI:setAnchorPoint(inputBox, 0.50, 0.50)
	GUI:setTouchEnabled(inputBox, false)
	GUI:setTag(inputBox, 0)

	-- Create input
	local input = GUI:TextInput_Create(inputBox, "input", 10, 5, 174, 25, 16)
	GUI:TextInput_setString(input, "")
	GUI:TextInput_setPlaceHolder(input, "输入捐献金额")
	GUI:TextInput_setFontColor(input, "#ffffff")
	GUI:TextInput_setPlaceholderFontColor(input, "#a6a6a6")
	GUI:TextInput_setInputMode(input, 2)
	GUI:setAnchorPoint(input, 0.00, 0.00)
	GUI:setOpacity(input, 160)
	GUI:setTouchEnabled(input, true)
	GUI:setTag(input, 0)

	-- Create tipsText
	local tipsText = GUI:Text_Create(inputBox, "tipsText", 60, 18, 16, "#a6a6a6", [[输入捐献金额]])
	GUI:Text_enableOutline(tipsText, "#000000", 1)
	GUI:setAnchorPoint(tipsText, 0.50, 0.50)
	GUI:setTouchEnabled(tipsText, false)
	GUI:setTag(tipsText, 0)
	GUI:setVisible(tipsText, false)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midBox, "upBtn", 658, 36, "res/custom/npc/45jx/an.png")
	GUI:setContentSize(upBtn, 134, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[]])
	GUI:Button_setTitleColor(upBtn, "#ffffff")
	GUI:Button_setTitleFontSize(upBtn, 16)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 818, 486, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.00, 0.00)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
