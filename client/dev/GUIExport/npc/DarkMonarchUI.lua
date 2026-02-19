local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/70ah/bg.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, true)
	GUI:setMouseEnabled(bg_Image, true)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(bg_Image, "closeBtn", 819, 487, "res/custom/closeBtn.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/1900000511.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create JieFengBtn
	local JieFengBtn = GUI:Button_Create(bg_Image, "JieFengBtn", 620, 48, "res/custom/yeqian2.png")
	GUI:setContentSize(JieFengBtn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(JieFengBtn, false)
	GUI:Button_setTitleText(JieFengBtn, [[解封神器]])
	GUI:Button_setTitleColor(JieFengBtn, "#f8e6c6")
	GUI:Button_setTitleFontSize(JieFengBtn, 18)
	GUI:Button_titleEnableOutline(JieFengBtn, "#000000", 1)
	GUI:setAnchorPoint(JieFengBtn, 0.00, 0.00)
	GUI:setTouchEnabled(JieFengBtn, true)
	GUI:setTag(JieFengBtn, 0)

	-- Create NeedItem_1
	local NeedItem_1 = GUI:ItemShow_Create(bg_Image, "NeedItem_1", 578, 192, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(NeedItem_1, 0.50, 0.50)
	GUI:setTag(NeedItem_1, 0)

	-- Create NeedItem_2
	local NeedItem_2 = GUI:ItemShow_Create(bg_Image, "NeedItem_2", 649, 192, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(NeedItem_2, 0.50, 0.50)
	GUI:setTag(NeedItem_2, 0)

	-- Create NeedItem_3
	local NeedItem_3 = GUI:ItemShow_Create(bg_Image, "NeedItem_3", 765, 193, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(NeedItem_3, 0.50, 0.50)
	GUI:setTag(NeedItem_3, 0)

	-- Create section_cell1
	local section_cell1 = GUI:Button_Create(bg_Image, "section_cell1", 74, 395, "res/custom/npc/70ah/rq1.png")
	GUI:setContentSize(section_cell1, 466, 82)
	GUI:setIgnoreContentAdaptWithSize(section_cell1, false)
	GUI:Button_setTitleText(section_cell1, [[]])
	GUI:Button_setTitleColor(section_cell1, "#ffffff")
	GUI:Button_setTitleFontSize(section_cell1, 16)
	GUI:Button_titleEnableOutline(section_cell1, "#000000", 1)
	GUI:setAnchorPoint(section_cell1, 0.00, 0.00)
	GUI:setTouchEnabled(section_cell1, true)
	GUI:setTag(section_cell1, 0)

	-- Create section_cell2
	local section_cell2 = GUI:Button_Create(bg_Image, "section_cell2", 74, 308, "res/custom/npc/70ah/rq2.png")
	GUI:setContentSize(section_cell2, 466, 82)
	GUI:setIgnoreContentAdaptWithSize(section_cell2, false)
	GUI:Button_setTitleText(section_cell2, [[]])
	GUI:Button_setTitleColor(section_cell2, "#ffffff")
	GUI:Button_setTitleFontSize(section_cell2, 16)
	GUI:Button_titleEnableOutline(section_cell2, "#000000", 1)
	GUI:setAnchorPoint(section_cell2, 0.00, 0.00)
	GUI:setTouchEnabled(section_cell2, true)
	GUI:setTag(section_cell2, 0)

	-- Create section_cell3
	local section_cell3 = GUI:Button_Create(bg_Image, "section_cell3", 74, 221, "res/custom/npc/70ah/rq3.png")
	GUI:setContentSize(section_cell3, 466, 82)
	GUI:setIgnoreContentAdaptWithSize(section_cell3, false)
	GUI:Button_setTitleText(section_cell3, [[]])
	GUI:Button_setTitleColor(section_cell3, "#ffffff")
	GUI:Button_setTitleFontSize(section_cell3, 16)
	GUI:Button_titleEnableOutline(section_cell3, "#000000", 1)
	GUI:setAnchorPoint(section_cell3, 0.00, 0.00)
	GUI:setTouchEnabled(section_cell3, true)
	GUI:setTag(section_cell3, 0)

	-- Create section_cell4
	local section_cell4 = GUI:Button_Create(bg_Image, "section_cell4", 74, 134, "res/custom/npc/70ah/rq4.png")
	GUI:setContentSize(section_cell4, 466, 82)
	GUI:setIgnoreContentAdaptWithSize(section_cell4, false)
	GUI:Button_setTitleText(section_cell4, [[]])
	GUI:Button_setTitleColor(section_cell4, "#ffffff")
	GUI:Button_setTitleFontSize(section_cell4, 16)
	GUI:Button_titleEnableOutline(section_cell4, "#000000", 1)
	GUI:setAnchorPoint(section_cell4, 0.00, 0.00)
	GUI:setTouchEnabled(section_cell4, true)
	GUI:setTag(section_cell4, 0)

	-- Create section_cell5
	local section_cell5 = GUI:Button_Create(bg_Image, "section_cell5", 74, 47, "res/custom/npc/70ah/rq5.png")
	GUI:setContentSize(section_cell5, 466, 82)
	GUI:setIgnoreContentAdaptWithSize(section_cell5, false)
	GUI:Button_setTitleText(section_cell5, [[]])
	GUI:Button_setTitleColor(section_cell5, "#ffffff")
	GUI:Button_setTitleFontSize(section_cell5, 16)
	GUI:Button_titleEnableOutline(section_cell5, "#000000", 1)
	GUI:setAnchorPoint(section_cell5, 0.00, 0.00)
	GUI:setTouchEnabled(section_cell5, true)
	GUI:setTag(section_cell5, 0)

	-- Create select_hl_img
	local select_hl_img = GUI:Image_Create(bg_Image, "select_hl_img", 74, 396, "res/custom/npc/70ah/sd.png")
	GUI:setAnchorPoint(select_hl_img, 0.00, 0.00)
	GUI:setTouchEnabled(select_hl_img, false)
	GUI:setTag(select_hl_img, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(bg_Image, "Text_1", 604, 126, 16, "#00ff00", [[材料出处：暗黑之城]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(bg_Image, "Text_2", 596, 96, 16, "#ffff00", [[每人仅限兑换一次专属]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
