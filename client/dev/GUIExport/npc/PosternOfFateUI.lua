local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 174, 51, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/29my/bg.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 821, 480, "res/public/1900000510.png")
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

	-- Create rewardNode
	local rewardNode = GUI:Node_Create(FrameLayout, "rewardNode", 616, 164)
	GUI:setTag(rewardNode, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(rewardNode, "ItemShow_1", -128, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(rewardNode, "ItemShow_2", -65, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(rewardNode, "ItemShow_3", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(rewardNode, "ItemShow_4", 67, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(rewardNode, "ItemShow_5", 135, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create GotoBtn
	local GotoBtn = GUI:Button_Create(FrameLayout, "GotoBtn", 574, 59, "res/public/zynpc.png")
	GUI:setContentSize(GotoBtn, 115, 37)
	GUI:setIgnoreContentAdaptWithSize(GotoBtn, false)
	GUI:Button_setTitleText(GotoBtn, [[立即前往]])
	GUI:Button_setTitleColor(GotoBtn, "#ffffff")
	GUI:Button_setTitleFontSize(GotoBtn, 18)
	GUI:Button_titleEnableOutline(GotoBtn, "#000000", 1)
	GUI:setAnchorPoint(GotoBtn, 0.00, 0.00)
	GUI:setTouchEnabled(GotoBtn, true)
	GUI:setTag(GotoBtn, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 179, 50, 18, "#ffff00", [[当前存在玩家数量：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 180, 82, 18, "#ffff00", [[Boss存活状态：]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create mon_count_txt
	local mon_count_txt = GUI:Text_Create(FrameLayout, "mon_count_txt", 302, 82, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(mon_count_txt, "#000000", 1)
	GUI:setAnchorPoint(mon_count_txt, 0.00, 0.00)
	GUI:setTouchEnabled(mon_count_txt, false)
	GUI:setTag(mon_count_txt, 0)

	-- Create role_count_txt
	local role_count_txt = GUI:Text_Create(FrameLayout, "role_count_txt", 333, 50, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(role_count_txt, "#000000", 1)
	GUI:setAnchorPoint(role_count_txt, 0.00, 0.00)
	GUI:setTouchEnabled(role_count_txt, false)
	GUI:setTag(role_count_txt, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
