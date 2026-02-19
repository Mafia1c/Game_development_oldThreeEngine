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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/72dw/bg.png")
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

	-- Create onTeamBtn
	local onTeamBtn = GUI:Button_Create(FrameLayout, "onTeamBtn", 595, 53, "res/custom/npc/54dt/an.png")
	GUI:Button_setTitleText(onTeamBtn, [[]])
	GUI:Button_setTitleColor(onTeamBtn, "#ffffff")
	GUI:Button_setTitleFontSize(onTeamBtn, 16)
	GUI:Button_titleEnableOutline(onTeamBtn, "#000000", 1)
	GUI:setAnchorPoint(onTeamBtn, 0.00, 0.00)
	GUI:setTouchEnabled(onTeamBtn, true)
	GUI:setTag(onTeamBtn, 0)
	GUI:setVisible(onTeamBtn, false)

	-- Create challengeBtn
	local challengeBtn = GUI:Button_Create(FrameLayout, "challengeBtn", 595, 52, "res/custom/npc/54dt/an.png")
	GUI:Button_setTitleText(challengeBtn, [[]])
	GUI:Button_setTitleColor(challengeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(challengeBtn, 16)
	GUI:Button_titleEnableOutline(challengeBtn, "#000000", 1)
	GUI:setAnchorPoint(challengeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(challengeBtn, true)
	GUI:setTag(challengeBtn, 0)

	-- Create title_txt_1
	local title_txt_1 = GUI:Text_Create(FrameLayout, "title_txt_1", 598, 195, 18, "#ffff00", [[转生等级15转]])
	GUI:Text_enableOutline(title_txt_1, "#000000", 1)
	GUI:setAnchorPoint(title_txt_1, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt_1, false)
	GUI:setTag(title_txt_1, 0)

	-- Create title_txt_2
	local title_txt_2 = GUI:Text_Create(FrameLayout, "title_txt_2", 584, 171, 18, "#ffff00", [[队伍人物不少于1个]])
	GUI:Text_enableOutline(title_txt_2, "#000000", 1)
	GUI:setAnchorPoint(title_txt_2, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt_2, false)
	GUI:setTag(title_txt_2, 0)
	GUI:setVisible(title_txt_2, false)

	-- Create title_txt_3
	local title_txt_3 = GUI:Text_Create(FrameLayout, "title_txt_3", 595, 153, 18, "#ffff00", [==========[[恶魔挑战卷X3]]==========])
	GUI:Text_enableOutline(title_txt_3, "#000000", 1)
	GUI:setAnchorPoint(title_txt_3, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt_3, false)
	GUI:setTag(title_txt_3, 0)

	-- Create rewardNode
	local rewardNode = GUI:Node_Create(FrameLayout, "rewardNode", 297, 86)
	GUI:setTag(rewardNode, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(rewardNode, "ItemShow_1", -141, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(rewardNode, "ItemShow_2", -71, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(rewardNode, "ItemShow_3", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(rewardNode, "ItemShow_4", 71, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(rewardNode, "ItemShow_5", 141, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
