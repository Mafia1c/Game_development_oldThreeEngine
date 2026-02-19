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
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/27jnds/bg1.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 820, 482, "res/public/1900000510.png")
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

	-- Create pageBtn_1
	local pageBtn_1 = GUI:Button_Create(FrameLayout, "pageBtn_1", 24, 323, "res/custom/npc/27jnds/c1.png")
	GUI:setContentSize(pageBtn_1, 32, 84)
	GUI:setIgnoreContentAdaptWithSize(pageBtn_1, false)
	GUI:Button_setTitleText(pageBtn_1, [[]])
	GUI:Button_setTitleColor(pageBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(pageBtn_1, 16)
	GUI:Button_titleEnableOutline(pageBtn_1, "#000000", 1)
	GUI:setAnchorPoint(pageBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(pageBtn_1, true)
	GUI:setTag(pageBtn_1, 0)

	-- Create pageBtn_2
	local pageBtn_2 = GUI:Button_Create(FrameLayout, "pageBtn_2", 24, 235, "res/custom/npc/27jnds/c2.png")
	GUI:setContentSize(pageBtn_2, 32, 84)
	GUI:setIgnoreContentAdaptWithSize(pageBtn_2, false)
	GUI:Button_setTitleText(pageBtn_2, [[]])
	GUI:Button_setTitleColor(pageBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(pageBtn_2, 16)
	GUI:Button_titleEnableOutline(pageBtn_2, "#000000", 1)
	GUI:setAnchorPoint(pageBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(pageBtn_2, true)
	GUI:setTag(pageBtn_2, 0)

	-- Create page_node1
	local page_node1 = GUI:Node_Create(FrameLayout, "page_node1", 51, 20)
	GUI:setTag(page_node1, 0)

	-- Create line_img_1
	local line_img_1 = GUI:Image_Create(page_node1, "line_img_1", 85, 396, "res/custom/npc/27jnds/jdt.png")
	GUI:setContentSize(line_img_1, 336, 6)
	GUI:setIgnoreContentAdaptWithSize(line_img_1, false)
	GUI:setAnchorPoint(line_img_1, 0.00, 0.00)
	GUI:setTouchEnabled(line_img_1, false)
	GUI:setTag(line_img_1, 0)

	-- Create line_img_2
	local line_img_2 = GUI:Image_Create(page_node1, "line_img_2", 85, 248, "res/custom/npc/27jnds/jdt.png")
	GUI:setContentSize(line_img_2, 336, 6)
	GUI:setIgnoreContentAdaptWithSize(line_img_2, false)
	GUI:setAnchorPoint(line_img_2, 0.00, 0.00)
	GUI:setTouchEnabled(line_img_2, false)
	GUI:setTag(line_img_2, 0)

	-- Create line_img_3
	local line_img_3 = GUI:Image_Create(page_node1, "line_img_3", 85, 105, "res/custom/npc/27jnds/jdt.png")
	GUI:setContentSize(line_img_3, 336, 6)
	GUI:setIgnoreContentAdaptWithSize(line_img_3, false)
	GUI:setAnchorPoint(line_img_3, 0.00, 0.00)
	GUI:setTouchEnabled(line_img_3, false)
	GUI:setTag(line_img_3, 0)

	-- Create skillimg
	local skillimg = GUI:Node_Create(page_node1, "skillimg", 265, 264)
	GUI:setTag(skillimg, 0)

	-- Create skill_img_1_1
	local skill_img_1_1 = GUI:Image_Create(skillimg, "skill_img_1_1", -191, 134, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_1_1, 0.50, 0.50)
	GUI:setScale(skill_img_1_1, 0.80)
	GUI:setTouchEnabled(skill_img_1_1, true)
	GUI:setTag(skill_img_1_1, 0)

	-- Create skill_img_1_2
	local skill_img_1_2 = GUI:Image_Create(skillimg, "skill_img_1_2", -64, 134, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_1_2, 0.50, 0.50)
	GUI:setScale(skill_img_1_2, 0.80)
	GUI:setTouchEnabled(skill_img_1_2, true)
	GUI:setTag(skill_img_1_2, 0)

	-- Create skill_img_1_3
	local skill_img_1_3 = GUI:Image_Create(skillimg, "skill_img_1_3", 65, 134, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_1_3, 0.50, 0.50)
	GUI:setScale(skill_img_1_3, 0.80)
	GUI:setTouchEnabled(skill_img_1_3, true)
	GUI:setTag(skill_img_1_3, 0)

	-- Create skill_bg_1
	local skill_bg_1 = GUI:Image_Create(skillimg, "skill_bg_1", 142, 99, "res/custom/npc/27jnds/k.png")
	GUI:setAnchorPoint(skill_bg_1, 0.00, 0.00)
	GUI:setTouchEnabled(skill_bg_1, false)
	GUI:setTag(skill_bg_1, 0)

	-- Create skill_img_1_4
	local skill_img_1_4 = GUI:Image_Create(skillimg, "skill_img_1_4", 180, 135, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_1_4, 0.50, 0.50)
	GUI:setScale(skill_img_1_4, 0.85)
	GUI:setTouchEnabled(skill_img_1_4, true)
	GUI:setTag(skill_img_1_4, 0)

	-- Create skill_img_2_1
	local skill_img_2_1 = GUI:Image_Create(skillimg, "skill_img_2_1", -190, -10, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_2_1, 0.50, 0.50)
	GUI:setScale(skill_img_2_1, 0.80)
	GUI:setTouchEnabled(skill_img_2_1, true)
	GUI:setTag(skill_img_2_1, 0)

	-- Create skill_img_2_2
	local skill_img_2_2 = GUI:Image_Create(skillimg, "skill_img_2_2", -63, -10, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_2_2, 0.50, 0.50)
	GUI:setScale(skill_img_2_2, 0.80)
	GUI:setTouchEnabled(skill_img_2_2, true)
	GUI:setTag(skill_img_2_2, 0)

	-- Create skill_img_2_3
	local skill_img_2_3 = GUI:Image_Create(skillimg, "skill_img_2_3", 66, -10, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_2_3, 0.50, 0.50)
	GUI:setScale(skill_img_2_3, 0.80)
	GUI:setTouchEnabled(skill_img_2_3, true)
	GUI:setTag(skill_img_2_3, 0)

	-- Create skill_bg_2
	local skill_bg_2 = GUI:Image_Create(skillimg, "skill_bg_2", 143, -48, "res/custom/npc/27jnds/k.png")
	GUI:setAnchorPoint(skill_bg_2, 0.00, 0.00)
	GUI:setTouchEnabled(skill_bg_2, false)
	GUI:setTag(skill_bg_2, 0)

	-- Create skill_img_2_4
	local skill_img_2_4 = GUI:Image_Create(skillimg, "skill_img_2_4", 181, -12, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_2_4, 0.50, 0.50)
	GUI:setScale(skill_img_2_4, 0.85)
	GUI:setTouchEnabled(skill_img_2_4, true)
	GUI:setTag(skill_img_2_4, 0)

	-- Create skill_img_3_1
	local skill_img_3_1 = GUI:Image_Create(skillimg, "skill_img_3_1", -189, -155, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_3_1, 0.50, 0.50)
	GUI:setScale(skill_img_3_1, 0.80)
	GUI:setTouchEnabled(skill_img_3_1, true)
	GUI:setTag(skill_img_3_1, 0)

	-- Create skill_img_3_2
	local skill_img_3_2 = GUI:Image_Create(skillimg, "skill_img_3_2", -62, -155, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_3_2, 0.50, 0.50)
	GUI:setScale(skill_img_3_2, 0.80)
	GUI:setTouchEnabled(skill_img_3_2, true)
	GUI:setTag(skill_img_3_2, 0)

	-- Create skill_img_3_3
	local skill_img_3_3 = GUI:Image_Create(skillimg, "skill_img_3_3", 67, -155, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_3_3, 0.50, 0.50)
	GUI:setScale(skill_img_3_3, 0.80)
	GUI:setTouchEnabled(skill_img_3_3, true)
	GUI:setTag(skill_img_3_3, 0)

	-- Create skill_bg_3
	local skill_bg_3 = GUI:Image_Create(skillimg, "skill_bg_3", 144, -190, "res/custom/npc/27jnds/k.png")
	GUI:setAnchorPoint(skill_bg_3, 0.00, 0.00)
	GUI:setTouchEnabled(skill_bg_3, false)
	GUI:setTag(skill_bg_3, 0)

	-- Create skill_img_3_4
	local skill_img_3_4 = GUI:Image_Create(skillimg, "skill_img_3_4", 182, -154, "res/custom/npc/27jnds/icon/26.png")
	GUI:setAnchorPoint(skill_img_3_4, 0.50, 0.50)
	GUI:setScale(skill_img_3_4, 0.85)
	GUI:setTouchEnabled(skill_img_3_4, true)
	GUI:setTag(skill_img_3_4, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(skillimg, "select_img", 179, 135, "res/public/bg_bossdi_05.png")
	GUI:setContentSize(select_img, 50, 54)
	GUI:setIgnoreContentAdaptWithSize(select_img, false)
	GUI:setAnchorPoint(select_img, 0.50, 0.50)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)
	GUI:setVisible(select_img, false)

	-- Create skillname
	local skillname = GUI:Node_Create(page_node1, "skillname", 265, 264)
	GUI:setTag(skillname, 0)

	-- Create name_bg_1
	local name_bg_1 = GUI:Image_Create(skillname, "name_bg_1", -235, 75, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_1, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_1, false)
	GUI:setTag(name_bg_1, 0)

	-- Create name_bg_2
	local name_bg_2 = GUI:Image_Create(skillname, "name_bg_2", -112, 75, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_2, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_2, false)
	GUI:setTag(name_bg_2, 0)

	-- Create name_bg_3
	local name_bg_3 = GUI:Image_Create(skillname, "name_bg_3", 17, 75, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_3, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_3, false)
	GUI:setTag(name_bg_3, 0)

	-- Create name_bg_4
	local name_bg_4 = GUI:Image_Create(skillname, "name_bg_4", 132, 75, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_4, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_4, false)
	GUI:setTag(name_bg_4, 0)

	-- Create name_bg_5
	local name_bg_5 = GUI:Image_Create(skillname, "name_bg_5", -234, -69, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_5, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_5, false)
	GUI:setTag(name_bg_5, 0)

	-- Create name_bg_6
	local name_bg_6 = GUI:Image_Create(skillname, "name_bg_6", -111, -69, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_6, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_6, false)
	GUI:setTag(name_bg_6, 0)

	-- Create name_bg_7
	local name_bg_7 = GUI:Image_Create(skillname, "name_bg_7", 18, -69, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_7, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_7, false)
	GUI:setTag(name_bg_7, 0)

	-- Create name_bg_8
	local name_bg_8 = GUI:Image_Create(skillname, "name_bg_8", 133, -69, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_8, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_8, false)
	GUI:setTag(name_bg_8, 0)

	-- Create name_bg_9
	local name_bg_9 = GUI:Image_Create(skillname, "name_bg_9", -235, -212, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_9, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_9, false)
	GUI:setTag(name_bg_9, 0)

	-- Create name_bg_10
	local name_bg_10 = GUI:Image_Create(skillname, "name_bg_10", -112, -212, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_10, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_10, false)
	GUI:setTag(name_bg_10, 0)

	-- Create name_bg_11
	local name_bg_11 = GUI:Image_Create(skillname, "name_bg_11", 17, -212, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_11, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_11, false)
	GUI:setTag(name_bg_11, 0)

	-- Create name_bg_12
	local name_bg_12 = GUI:Image_Create(skillname, "name_bg_12", 132, -212, "res/custom/npc/27jnds/t.png")
	GUI:setAnchorPoint(name_bg_12, 0.00, 0.00)
	GUI:setTouchEnabled(name_bg_12, false)
	GUI:setTag(name_bg_12, 0)

	-- Create title_txt
	local title_txt = GUI:Text_Create(page_node1, "title_txt", 37, 15, 18, "#00ffe8", [==========[使用 [书页] 可修炼技能,技能等级越高,技能效果越强大!]==========])
	GUI:Text_enableOutline(title_txt, "#000000", 1)
	GUI:setAnchorPoint(title_txt, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt, false)
	GUI:setTag(title_txt, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(page_node1, "upBtn", 573, 20, "res/public/1900000661.png")
	GUI:setContentSize(upBtn, 106, 40)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[强化技能]])
	GUI:Button_setTitleColor(upBtn, "#ffffff")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.00, 0.00)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(page_node1, "ItemShow_1", 580, 105, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(page_node1, "ItemShow_2", 675, 105, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create page_node2
	local page_node2 = GUI:Node_Create(FrameLayout, "page_node2", 54, 26)
	GUI:setTag(page_node2, 0)
	GUI:setVisible(page_node2, false)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(page_node2, "ListView_1", 20, 8, 725, 449, 1)
	GUI:ListView_setBounceEnabled(ListView_1, true)
	GUI:ListView_setItemsMargin(ListView_1, 5)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
