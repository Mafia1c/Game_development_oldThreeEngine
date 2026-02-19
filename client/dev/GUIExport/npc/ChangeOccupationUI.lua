local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 599, 242, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 0, 0, "res/public/bg_npc_10.jpg")
	GUI:Image_setScale9Slice(Image_1, 59, 59, 103, 103)
	GUI:setContentSize(Image_1, 599, 242)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, true)
	GUI:setMouseEnabled(Image_1, true)
	GUI:setTag(Image_1, 0)

	-- Create closeButton
	local closeButton = GUI:Button_Create(FrameLayout, "closeButton", 599, 202, "res/public/1900000510.png")
	GUI:setContentSize(closeButton, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeButton, false)
	GUI:Button_setTitleText(closeButton, [[]])
	GUI:Button_setTitleColor(closeButton, "#ffffff")
	GUI:Button_setTitleFontSize(closeButton, 16)
	GUI:Button_titleEnableOutline(closeButton, "#000000", 1)
	GUI:setAnchorPoint(closeButton, 0.00, 0.00)
	GUI:setTouchEnabled(closeButton, true)
	GUI:setTag(closeButton, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 19, 204, 16, "#ff9b00", [[转职规则：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 19, 155, 16, "#00e95a", [[同时会清空所有天赋血脉，需重新激活]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(FrameLayout, "Text_5", 19, 180, 16, "#00e95a", [[转职后仅保留初始职业技能，强化技能等级不保留！]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 19, 104, 16, "#ff9b00", [[当前职业：]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(FrameLayout, "Text_4", 19, 130, 16, "#ff9b00", [[转职条件：]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create change_expend
	local change_expend = GUI:Text_Create(FrameLayout, "change_expend", 95, 130, 16, "#ffff00", [[非绑灵符x5888]])
	GUI:Text_enableOutline(change_expend, "#000000", 1)
	GUI:setAnchorPoint(change_expend, 0.00, 0.00)
	GUI:setTouchEnabled(change_expend, false)
	GUI:setTag(change_expend, 0)

	-- Create currentOccupationText
	local currentOccupationText = GUI:Text_Create(FrameLayout, "currentOccupationText", 95, 104, 16, "#00ff00", [[法师]])
	GUI:Text_enableOutline(currentOccupationText, "#000000", 1)
	GUI:setAnchorPoint(currentOccupationText, 0.00, 0.00)
	GUI:setTouchEnabled(currentOccupationText, false)
	GUI:setTag(currentOccupationText, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(FrameLayout, "Text_6", 19, 76, 16, "#ffffff", [[必须阅读：]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(FrameLayout, "Text_7", 95, 76, 16, "#ff0000", [[点击转职操作不可逆，请仔细阅读转职规则！]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.00, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)

	-- Create changeOccupationBtn1
	local changeOccupationBtn1 = GUI:Button_Create(FrameLayout, "changeOccupationBtn1", 84, 26, "res/public/1900000612.png")
	GUI:setContentSize(changeOccupationBtn1, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(changeOccupationBtn1, false)
	GUI:Button_setTitleText(changeOccupationBtn1, [[转职战士]])
	GUI:Button_setTitleColor(changeOccupationBtn1, "#f8e6c6")
	GUI:Button_setTitleFontSize(changeOccupationBtn1, 16)
	GUI:Button_titleEnableOutline(changeOccupationBtn1, "#000000", 1)
	GUI:setAnchorPoint(changeOccupationBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(changeOccupationBtn1, true)
	GUI:setTag(changeOccupationBtn1, 0)

	-- Create changeOccupationBtn2
	local changeOccupationBtn2 = GUI:Button_Create(FrameLayout, "changeOccupationBtn2", 213, 26, "res/public/1900000612.png")
	GUI:setContentSize(changeOccupationBtn2, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(changeOccupationBtn2, false)
	GUI:Button_setTitleText(changeOccupationBtn2, [[转职法师]])
	GUI:Button_setTitleColor(changeOccupationBtn2, "#f8e6c6")
	GUI:Button_setTitleFontSize(changeOccupationBtn2, 16)
	GUI:Button_titleEnableOutline(changeOccupationBtn2, "#000000", 1)
	GUI:setAnchorPoint(changeOccupationBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(changeOccupationBtn2, true)
	GUI:setTag(changeOccupationBtn2, 0)

	-- Create changeOccupationBtn3
	local changeOccupationBtn3 = GUI:Button_Create(FrameLayout, "changeOccupationBtn3", 341, 26, "res/public/1900000612.png")
	GUI:setContentSize(changeOccupationBtn3, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(changeOccupationBtn3, false)
	GUI:Button_setTitleText(changeOccupationBtn3, [[转职道士]])
	GUI:Button_setTitleColor(changeOccupationBtn3, "#f8e6c6")
	GUI:Button_setTitleFontSize(changeOccupationBtn3, 16)
	GUI:Button_titleEnableOutline(changeOccupationBtn3, "#000000", 1)
	GUI:setAnchorPoint(changeOccupationBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(changeOccupationBtn3, true)
	GUI:setTag(changeOccupationBtn3, 0)

	-- Create Text_9
	local Text_9 = GUI:Text_Create(FrameLayout, "Text_9", 19, 130, 16, "#00e95a", [[]])
	GUI:Text_enableOutline(Text_9, "#000000", 1)
	GUI:setAnchorPoint(Text_9, 0.00, 0.00)
	GUI:setTouchEnabled(Text_9, false)
	GUI:setTag(Text_9, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
