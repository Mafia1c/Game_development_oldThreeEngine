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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 174, 50, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/78wlzz/bg1.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, true)
	GUI:setMouseEnabled(bg_Image, true)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 856, 522, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 1.00, 1.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create leftList
	local leftList = GUI:ListView_Create(FrameLayout, "leftList", 75, 480, 114, 430, 1)
	GUI:ListView_setItemsMargin(leftList, 2)
	GUI:setAnchorPoint(leftList, 0.00, 1.00)
	GUI:setTouchEnabled(leftList, true)
	GUI:setTag(leftList, 0)

	-- Create rightBox1
	local rightBox1 = GUI:Layout_Create(FrameLayout, "rightBox1", 498, 258, 612, 456, false)
	GUI:setAnchorPoint(rightBox1, 0.50, 0.50)
	GUI:setTouchEnabled(rightBox1, false)
	GUI:setTag(rightBox1, 0)

	-- Create boxList1
	local boxList1 = GUI:ListView_Create(rightBox1, "boxList1", 4, 9, 600, 440, 1)
	GUI:ListView_setItemsMargin(boxList1, 2)
	GUI:setAnchorPoint(boxList1, 0.00, 0.00)
	GUI:setTouchEnabled(boxList1, true)
	GUI:setTag(boxList1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(boxList1, "Image_1", 0, 354, "res/custom/npc/78wlzz/rq1.png")
	GUI:setContentSize(Image_1, 600, 86)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Image_1, "ItemShow_1", 250, 42, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(Image_1, "ItemShow_2", 384, 42, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Image_1, "Button_1", 524, 44, "res/custom/yeqian1.png")
	GUI:setContentSize(Button_1, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[前往挑战]])
	GUI:Button_setTitleColor(Button_1, "#F8E6C6")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.50, 0.50)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create rightBox2
	local rightBox2 = GUI:Layout_Create(FrameLayout, "rightBox2", 498, 258, 612, 456, false)
	GUI:setAnchorPoint(rightBox2, 0.50, 0.50)
	GUI:setTouchEnabled(rightBox2, false)
	GUI:setTag(rightBox2, 0)
	GUI:setVisible(rightBox2, false)

	-- Create effectPerson2
	local effectPerson2 = GUI:Effect_Create(rightBox2, "effectPerson2", 276, 242, 2, 20155, 0, 0, 4, 1)
	GUI:setScale(effectPerson2, 0.80)
	GUI:setTag(effectPerson2, 0)

	-- Create itemNode2
	local itemNode2 = GUI:Node_Create(rightBox2, "itemNode2", 296, 142)
	GUI:setTag(itemNode2, 0)

	-- Create item_21
	local item_21 = GUI:ItemShow_Create(itemNode2, "item_21", 0, 0, {index = 10511, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_21, 0.50, 0.50)
	GUI:setTag(item_21, 0)

	-- Create item_22
	local item_22 = GUI:ItemShow_Create(itemNode2, "item_22", 0, 0, {index = 10512, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_22, 0.50, 0.50)
	GUI:setTag(item_22, 0)

	-- Create item_23
	local item_23 = GUI:ItemShow_Create(itemNode2, "item_23", 0, 0, {index = 10513, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_23, 0.50, 0.50)
	GUI:setTag(item_23, 0)

	-- Create item_24
	local item_24 = GUI:ItemShow_Create(itemNode2, "item_24", 0, 0, {index = 10514, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_24, 0.50, 0.50)
	GUI:setTag(item_24, 0)

	-- Create item_25
	local item_25 = GUI:ItemShow_Create(itemNode2, "item_25", 0, 0, {index = 10515, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_25, 0.50, 0.50)
	GUI:setTag(item_25, 0)

	-- Create Rtext2
	local Rtext2 = GUI:Text_Create(rightBox2, "Rtext2", 10, 104, 16, "#ffffff", [[挑战卧龙庄主说明：
收集五种【元素魔石×1】进行召唤挑战【卧龙庄主】
击败【卧龙庄主】可获得激活【诛仙之力】所需材料
元素魔石：【智慧魔石、力量魔石、自然魔石、权力魔石、黑暗魔石】]])
	GUI:Text_enableOutline(Rtext2, "#000000", 1)
	GUI:setAnchorPoint(Rtext2, 0.00, 1.00)
	GUI:setTouchEnabled(Rtext2, false)
	GUI:setTag(Rtext2, 0)

	-- Create goBtn2
	local goBtn2 = GUI:Button_Create(rightBox2, "goBtn2", 481, 40, "res/custom/bt_dz.png")
	GUI:setContentSize(goBtn2, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(goBtn2, false)
	GUI:Button_setTitleText(goBtn2, [[前往庄主之家]])
	GUI:Button_setTitleColor(goBtn2, "#F8E6C6")
	GUI:Button_setTitleFontSize(goBtn2, 16)
	GUI:Button_titleEnableOutline(goBtn2, "#000000", 1)
	GUI:setAnchorPoint(goBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(goBtn2, true)
	GUI:setTag(goBtn2, 0)

	-- Create rightBox3
	local rightBox3 = GUI:Layout_Create(FrameLayout, "rightBox3", 498, 258, 612, 456, false)
	GUI:setAnchorPoint(rightBox3, 0.50, 0.50)
	GUI:setTouchEnabled(rightBox3, false)
	GUI:setTag(rightBox3, 0)
	GUI:setVisible(rightBox3, false)

	-- Create effectTitle3
	local effectTitle3 = GUI:Effect_Create(rightBox3, "effectTitle3", 154, 244, 0, 15276, 0, 0, 4, 1)
	GUI:setTag(effectTitle3, 0)

	-- Create textNode3
	local textNode3 = GUI:Node_Create(rightBox3, "textNode3", 450, 280)
	GUI:setTag(textNode3, 0)

	-- Create text31
	local text31 = GUI:Text_Create(textNode3, "text31", 43, 12, 16, "#ffffff", [[防御：18-18]])
	GUI:Text_enableOutline(text31, "#000000", 1)
	GUI:setAnchorPoint(text31, 0.50, 0.50)
	GUI:setTouchEnabled(text31, false)
	GUI:setTag(text31, 0)

	-- Create text32
	local text32 = GUI:Text_Create(textNode3, "text32", 43, 12, 16, "#ffffff", [[魔法：18-18]])
	GUI:Text_enableOutline(text32, "#000000", 1)
	GUI:setAnchorPoint(text32, 0.50, 0.50)
	GUI:setTouchEnabled(text32, false)
	GUI:setTag(text32, 0)

	-- Create text33
	local text33 = GUI:Text_Create(textNode3, "text33", 43, 12, 16, "#ffffff", [[攻击：18-18]])
	GUI:Text_enableOutline(text33, "#000000", 1)
	GUI:setAnchorPoint(text33, 0.50, 0.50)
	GUI:setTouchEnabled(text33, false)
	GUI:setTag(text33, 0)

	-- Create text34
	local text34 = GUI:Text_Create(textNode3, "text34", 43, 12, 16, "#ffffff", [[魔防：18-18]])
	GUI:Text_enableOutline(text34, "#000000", 1)
	GUI:setAnchorPoint(text34, 0.50, 0.50)
	GUI:setTouchEnabled(text34, false)
	GUI:setTag(text34, 0)

	-- Create text35
	local text35 = GUI:Text_Create(textNode3, "text35", 43, 12, 16, "#ffffff", [[魔防：18-18]])
	GUI:Text_enableOutline(text35, "#000000", 1)
	GUI:setAnchorPoint(text35, 0.50, 0.50)
	GUI:setTouchEnabled(text35, false)
	GUI:setTag(text35, 0)

	-- Create text36
	local text36 = GUI:Text_Create(textNode3, "text36", 43, 12, 16, "#ff9b00", [[圣神一击：3%]])
	GUI:Text_enableOutline(text36, "#000000", 1)
	GUI:setAnchorPoint(text36, 0.50, 0.50)
	GUI:setTouchEnabled(text36, false)
	GUI:setTag(text36, 0)

	-- Create itemNode3
	local itemNode3 = GUI:Node_Create(rightBox3, "itemNode3", 220, 44)
	GUI:setTag(itemNode3, 0)

	-- Create item_31
	local item_31 = GUI:ItemShow_Create(itemNode3, "item_31", 0, 0, {index = 10511, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_31, 0.50, 0.50)
	GUI:setTag(item_31, 0)

	-- Create item_32
	local item_32 = GUI:ItemShow_Create(itemNode3, "item_32", 0, 0, {index = 10512, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_32, 0.50, 0.50)
	GUI:setTag(item_32, 0)

	-- Create item_33
	local item_33 = GUI:ItemShow_Create(itemNode3, "item_33", 0, 0, {index = 10513, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_33, 0.50, 0.50)
	GUI:setTag(item_33, 0)

	-- Create item_34
	local item_34 = GUI:ItemShow_Create(itemNode3, "item_34", 0, 0, {index = 10514, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_34, 0.50, 0.50)
	GUI:setTag(item_34, 0)

	-- Create item_35
	local item_35 = GUI:ItemShow_Create(itemNode3, "item_35", 0, 0, {index = 10515, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_35, 0.50, 0.50)
	GUI:setTag(item_35, 0)

	-- Create item_36
	local item_36 = GUI:ItemShow_Create(itemNode3, "item_36", 0, 0, {index = 7, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_36, 0.50, 0.50)
	GUI:setTag(item_36, 0)

	-- Create activeBtn3
	local activeBtn3 = GUI:Button_Create(rightBox3, "activeBtn3", 536, 46, "res/custom/bt_dz.png")
	GUI:setContentSize(activeBtn3, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(activeBtn3, false)
	GUI:Button_setTitleText(activeBtn3, [[激活]])
	GUI:Button_setTitleColor(activeBtn3, "#F8E6C6")
	GUI:Button_setTitleFontSize(activeBtn3, 16)
	GUI:Button_titleEnableOutline(activeBtn3, "#000000", 1)
	GUI:setAnchorPoint(activeBtn3, 0.50, 0.50)
	GUI:setTouchEnabled(activeBtn3, true)
	GUI:setTag(activeBtn3, 0)

	-- Create activeImg3
	local activeImg3 = GUI:Image_Create(rightBox3, "activeImg3", 524, 50, "res/custom/tag/iconjh.png")
	GUI:setContentSize(activeImg3, 88, 56)
	GUI:setIgnoreContentAdaptWithSize(activeImg3, false)
	GUI:setAnchorPoint(activeImg3, 0.50, 0.50)
	GUI:setTouchEnabled(activeImg3, false)
	GUI:setTag(activeImg3, 0)
	GUI:setVisible(activeImg3, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
