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
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/05wx/bg.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

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

	-- Create wx_list
	local wx_list = GUI:ScrollView_Create(FrameLayout, "wx_list", 74, 44, 197, 438, 1)
	GUI:ScrollView_setBounceEnabled(wx_list, true)
	GUI:ScrollView_setInnerContainerSize(wx_list, 197.00, 500.00)
	GUI:setAnchorPoint(wx_list, 0.00, 0.00)
	GUI:setTouchEnabled(wx_list, true)
	GUI:setTag(wx_list, 0)

	-- Create cell_1
	local cell_1 = GUI:Image_Create(wx_list, "cell_1", 0, 356, "res/custom/npc/05wx/rq.png")
	GUI:setAnchorPoint(cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(cell_1, true)
	GUI:setTag(cell_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(cell_1, "ItemShow_1", 41, 41, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create item_name1
	local item_name1 = GUI:Text_Create(cell_1, "item_name1", 135, 40, 18, "#ffffff", [[坚韧之躯Lv0]])
	GUI:Text_enableOutline(item_name1, "#000000", 1)
	GUI:setAnchorPoint(item_name1, 0.50, 0.00)
	GUI:setTouchEnabled(item_name1, false)
	GUI:setTag(item_name1, 0)

	-- Create item_info1
	local item_info1 = GUI:Text_Create(cell_1, "item_info1", 135, 19, 16, "#ffffff", [[(增加HP/MP)]])
	GUI:Text_enableOutline(item_info1, "#000000", 1)
	GUI:setAnchorPoint(item_info1, 0.50, 0.00)
	GUI:setTouchEnabled(item_info1, false)
	GUI:setTag(item_info1, 0)

	-- Create cell_2
	local cell_2 = GUI:Image_Create(wx_list, "cell_2", 0, 272, "res/custom/npc/05wx/rq.png")
	GUI:setAnchorPoint(cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(cell_2, true)
	GUI:setTag(cell_2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(cell_2, "ItemShow_2", 41, 41, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create item_name2
	local item_name2 = GUI:Text_Create(cell_2, "item_name2", 135, 40, 18, "#ffffff", [[狂怒之心Lv0]])
	GUI:Text_enableOutline(item_name2, "#000000", 1)
	GUI:setAnchorPoint(item_name2, 0.50, 0.00)
	GUI:setTouchEnabled(item_name2, false)
	GUI:setTag(item_name2, 0)

	-- Create item_info2
	local item_info2 = GUI:Text_Create(cell_2, "item_info2", 135, 19, 16, "#ffffff", [[(增加攻魔道伤)]])
	GUI:Text_enableOutline(item_info2, "#000000", 1)
	GUI:setAnchorPoint(item_info2, 0.50, 0.00)
	GUI:setTouchEnabled(item_info2, false)
	GUI:setTag(item_info2, 0)

	-- Create cell_3
	local cell_3 = GUI:Image_Create(wx_list, "cell_3", 0, 189, "res/custom/npc/05wx/rq.png")
	GUI:setAnchorPoint(cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(cell_3, true)
	GUI:setTag(cell_3, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(cell_3, "ItemShow_3", 41, 41, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create item_name3
	local item_name3 = GUI:Text_Create(cell_3, "item_name3", 135, 40, 18, "#ffffff", [[制裁之殇Lv0]])
	GUI:Text_enableOutline(item_name3, "#000000", 1)
	GUI:setAnchorPoint(item_name3, 0.50, 0.00)
	GUI:setTouchEnabled(item_name3, false)
	GUI:setTag(item_name3, 0)

	-- Create item_info3
	local item_info3 = GUI:Text_Create(cell_3, "item_info3", 135, 19, 16, "#ffffff", [[(增加PK增伤)]])
	GUI:Text_enableOutline(item_info3, "#000000", 1)
	GUI:setAnchorPoint(item_info3, 0.50, 0.00)
	GUI:setTouchEnabled(item_info3, false)
	GUI:setTag(item_info3, 0)

	-- Create cell_4
	local cell_4 = GUI:Image_Create(wx_list, "cell_4", 0, 106, "res/custom/npc/05wx/rq.png")
	GUI:setAnchorPoint(cell_4, 0.00, 0.00)
	GUI:setTouchEnabled(cell_4, true)
	GUI:setTag(cell_4, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(cell_4, "ItemShow_4", 41, 41, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create item_name4
	local item_name4 = GUI:Text_Create(cell_4, "item_name4", 135, 40, 18, "#ffffff", [[荆棘之力Lv0]])
	GUI:Text_enableOutline(item_name4, "#000000", 1)
	GUI:setAnchorPoint(item_name4, 0.50, 0.00)
	GUI:setTouchEnabled(item_name4, false)
	GUI:setTag(item_name4, 0)

	-- Create item_info4
	local item_info4 = GUI:Text_Create(cell_4, "item_info4", 135, 19, 16, "#ffffff", [[(增加PK减伤)]])
	GUI:Text_enableOutline(item_info4, "#000000", 1)
	GUI:setAnchorPoint(item_info4, 0.50, 0.00)
	GUI:setTouchEnabled(item_info4, false)
	GUI:setTag(item_info4, 0)

	-- Create cell_5
	local cell_5 = GUI:Image_Create(wx_list, "cell_5", 0, 23, "res/custom/npc/05wx/rq.png")
	GUI:setAnchorPoint(cell_5, 0.00, 0.00)
	GUI:setTouchEnabled(cell_5, true)
	GUI:setTag(cell_5, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(cell_5, "ItemShow_5", 41, 41, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create item_name5
	local item_name5 = GUI:Text_Create(cell_5, "item_name5", 135, 40, 18, "#ffffff", [[宗师之威Lv0]])
	GUI:Text_enableOutline(item_name5, "#000000", 1)
	GUI:setAnchorPoint(item_name5, 0.50, 0.00)
	GUI:setTouchEnabled(item_name5, false)
	GUI:setTag(item_name5, 0)

	-- Create item_info5
	local item_info5 = GUI:Text_Create(cell_5, "item_info5", 135, 19, 16, "#ffffff", [[(增加对怪增伤)]])
	GUI:Text_enableOutline(item_info5, "#000000", 1)
	GUI:setAnchorPoint(item_info5, 0.50, 0.00)
	GUI:setTouchEnabled(item_info5, false)
	GUI:setTag(item_info5, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(wx_list, "select_img", 0, 23, "res/custom/npc/05wx/xz.png")
	GUI:setAnchorPoint(select_img, 0.00, 0.00)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)

	-- Create effect_node
	local effect_node = GUI:Node_Create(FrameLayout, "effect_node", 421, 237)
	GUI:setTag(effect_node, 0)

	-- Create startBtn
	local startBtn = GUI:Button_Create(FrameLayout, "startBtn", 643, 40, "res/public/1900000661.png")
	GUI:setContentSize(startBtn, 106, 40)
	GUI:setIgnoreContentAdaptWithSize(startBtn, false)
	GUI:Button_setTitleText(startBtn, [[开始晋升]])
	GUI:Button_setTitleColor(startBtn, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn, 18)
	GUI:Button_titleEnableOutline(startBtn, "#000000", 1)
	GUI:setAnchorPoint(startBtn, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn, true)
	GUI:setTag(startBtn, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(FrameLayout, "ItemShow_6", 648, 123, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(FrameLayout, "ItemShow_7", 741, 123, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create cur_att_txt
	local cur_att_txt = GUI:Text_Create(FrameLayout, "cur_att_txt", 692, 371, 18, "#ffffff", [[对怪增伤: 0]])
	GUI:Text_enableOutline(cur_att_txt, "#000000", 1)
	GUI:setAnchorPoint(cur_att_txt, 0.50, 0.00)
	GUI:setTouchEnabled(cur_att_txt, false)
	GUI:setTag(cur_att_txt, 0)

	-- Create next_attr_txt
	local next_attr_txt = GUI:Text_Create(FrameLayout, "next_attr_txt", 692, 225, 18, "#00ff00", [[对怪增上: 0.5%]])
	GUI:Text_enableOutline(next_attr_txt, "#000000", 1)
	GUI:setAnchorPoint(next_attr_txt, 0.50, 0.00)
	GUI:setTouchEnabled(next_attr_txt, false)
	GUI:setTag(next_attr_txt, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
