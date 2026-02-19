local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/95sl/bg.png")
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameBG, "Effect_1", 279, 323, 0, 46109, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameBG, "closeBtn", 820, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameBG, "RichText_1", 130, 55, [==========[<font color='#ffffff' size='16' >1.激活需要领取</font><font color='#00ff00' size='16' >[远古异界]</font><font color='#ffffff' size='16' >全部通关奖励</font><br><font color='#ffffff' size='16' >2.激活</font><font color='#00ff00' size='16' >[死灵圣祖]</font><font color='#ffffff' size='16' >完全免费,无其他附加条件</font>]==========], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create active_btn
	local active_btn = GUI:Button_Create(FrameBG, "active_btn", 600, 53, "res/custom/npc/95sl/an.png")
	GUI:setContentSize(active_btn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(active_btn, false)
	GUI:Button_setTitleText(active_btn, [[]])
	GUI:Button_setTitleColor(active_btn, "#ffffff")
	GUI:Button_setTitleFontSize(active_btn, 10)
	GUI:Button_titleEnableOutline(active_btn, "#000000", 1)
	GUI:setAnchorPoint(active_btn, 0.00, 0.00)
	GUI:setTouchEnabled(active_btn, true)
	GUI:setTag(active_btn, -1)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameBG, "ItemShow_1", 664, 205, {index = 10559, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create UIModel_1
	local UIModel_1 = GUI:UIModel_Create(FrameBG, "UIModel_1", 298, 292, 0, {showNodeModel=true, showHair=false, capID=2081, clothID=86, weaponID=69}, 1)
	GUI:setAnchorPoint(UIModel_1, 0.00, 0.00)
	GUI:setScale(UIModel_1, 0.80)
	GUI:setTouchEnabled(UIModel_1, true)
	GUI:setTag(UIModel_1, 0)

	-- Create has_active
	local has_active = GUI:Image_Create(FrameBG, "has_active", 608, 49, "res/custom/tag/ylq_102.png")
	GUI:setAnchorPoint(has_active, 0.00, 0.00)
	GUI:setTouchEnabled(has_active, false)
	GUI:setTag(has_active, 0)
	GUI:setVisible(has_active, false)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
