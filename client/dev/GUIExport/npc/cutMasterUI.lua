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
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/13fj/bg.png")
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

	-- Create rightBox
	local rightBox = GUI:Layout_Create(FrameLayout, "rightBox", 498, 258, 612, 456, false)
	GUI:setAnchorPoint(rightBox, 0.50, 0.50)
	GUI:setTouchEnabled(rightBox, false)
	GUI:setTag(rightBox, 0)

	-- Create allBtn
	local allBtn = GUI:Button_Create(rightBox, "allBtn", 480, 394, "res/custom/bt_dz.png")
	GUI:setContentSize(allBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(allBtn, false)
	GUI:Button_setTitleText(allBtn, [[一键分解]])
	GUI:Button_setTitleColor(allBtn, "#F8E6C6")
	GUI:Button_setTitleFontSize(allBtn, 16)
	GUI:Button_titleEnableOutline(allBtn, "#000000", 1)
	GUI:setAnchorPoint(allBtn, 0.00, 0.00)
	GUI:setTouchEnabled(allBtn, true)
	GUI:setTag(allBtn, 0)

	-- Create infoList
	local infoList = GUI:ListView_Create(rightBox, "infoList", 305, 170, 610, 343, 1)
	GUI:setAnchorPoint(infoList, 0.50, 0.50)
	GUI:setTouchEnabled(infoList, true)
	GUI:setTag(infoList, 0)

	-- Create midBox1
	local midBox1 = GUI:Image_Create(infoList, "midBox1", 0, 287, "res/custom/npc/13fj/neirong.png")
	GUI:setAnchorPoint(midBox1, 0.00, 0.00)
	GUI:setTouchEnabled(midBox1, false)
	GUI:setTag(midBox1, 0)

	-- Create equip1
	local equip1 = GUI:Image_Create(midBox1, "equip1", 44, 29, "res/custom/itemBox.png")
	GUI:setAnchorPoint(equip1, 0.50, 0.50)
	GUI:setScale(equip1, 0.80)
	GUI:setTouchEnabled(equip1, false)
	GUI:setTag(equip1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(equip1, "ItemShow_1", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create name1
	local name1 = GUI:Text_Create(midBox1, "name1", 84, 15, 16, "#ffffff", [[火龙神甲]])
	GUI:Text_enableOutline(name1, "#000000", 1)
	GUI:setAnchorPoint(name1, 0.00, 0.00)
	GUI:setTouchEnabled(name1, false)
	GUI:setTag(name1, 0)

	-- Create midList1
	local midList1 = GUI:ListView_Create(midBox1, "midList1", 330, 29, 184, 60, 2)
	GUI:ListView_setClippingEnabled(midList1, false)
	GUI:ListView_setGravity(midList1, 3)
	GUI:ListView_setItemsMargin(midList1, 2)
	GUI:setAnchorPoint(midList1, 0.50, 0.50)
	GUI:setScale(midList1, 0.80)
	GUI:setTouchEnabled(midList1, true)
	GUI:setTag(midList1, 0)

	-- Create item11
	local item11 = GUI:Image_Create(midList1, "item11", 0, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(item11, 0.00, 0.00)
	GUI:setTouchEnabled(item11, false)
	GUI:setTag(item11, 0)

	-- Create item12
	local item12 = GUI:Image_Create(midList1, "item12", 62, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(item12, 0.00, 0.00)
	GUI:setTouchEnabled(item12, false)
	GUI:setTag(item12, 0)

	-- Create item13
	local item13 = GUI:Image_Create(midList1, "item13", 124, 0, "res/custom/itemBox.png")
	GUI:setAnchorPoint(item13, 0.00, 0.00)
	GUI:setTouchEnabled(item13, false)
	GUI:setTag(item13, 0)

	-- Create allBtn
	allBtn = GUI:Button_Create(midBox1, "allBtn", 542, 28, "res/custom/npc/13fj/fj1.png")
	GUI:Button_loadTexturePressed(allBtn, "res/custom/npc/13fj/fj2.png")
	GUI:setContentSize(allBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(allBtn, false)
	GUI:Button_setTitleText(allBtn, [[]])
	GUI:Button_setTitleColor(allBtn, "#ffffff")
	GUI:Button_setTitleFontSize(allBtn, 16)
	GUI:Button_titleEnableOutline(allBtn, "#000000", 1)
	GUI:setAnchorPoint(allBtn, 0.50, 0.50)
	GUI:setTouchEnabled(allBtn, true)
	GUI:setTag(allBtn, 0)

	-- Create midBox1_1
	local midBox1_1 = GUI:Image_Create(infoList, "midBox1_1", 0, 231, "res/custom/npc/13fj/neirong.png")
	GUI:setAnchorPoint(midBox1_1, 0.00, 0.00)
	GUI:setTouchEnabled(midBox1_1, false)
	GUI:setTag(midBox1_1, 0)

	-- Create midBox1_2
	local midBox1_2 = GUI:Image_Create(infoList, "midBox1_2", 0, 175, "res/custom/npc/13fj/neirong.png")
	GUI:setAnchorPoint(midBox1_2, 0.00, 0.00)
	GUI:setTouchEnabled(midBox1_2, false)
	GUI:setTag(midBox1_2, 0)

	-- Create midBox1_3
	local midBox1_3 = GUI:Image_Create(infoList, "midBox1_3", 0, 119, "res/custom/npc/13fj/neirong.png")
	GUI:setAnchorPoint(midBox1_3, 0.00, 0.00)
	GUI:setTouchEnabled(midBox1_3, false)
	GUI:setTag(midBox1_3, 0)

	-- Create midBox1_4
	local midBox1_4 = GUI:Image_Create(infoList, "midBox1_4", 0, 63, "res/custom/npc/13fj/neirong.png")
	GUI:setAnchorPoint(midBox1_4, 0.00, 0.00)
	GUI:setTouchEnabled(midBox1_4, false)
	GUI:setTag(midBox1_4, 0)

	-- Create midBox1_5
	local midBox1_5 = GUI:Image_Create(infoList, "midBox1_5", 0, 7, "res/custom/npc/13fj/neirong.png")
	GUI:setAnchorPoint(midBox1_5, 0.00, 0.00)
	GUI:setTouchEnabled(midBox1_5, false)
	GUI:setTag(midBox1_5, 0)

	-- Create elseBox
	local elseBox = GUI:Image_Create(FrameLayout, "elseBox", 476, 280, "res/public/1900000600.png")
	GUI:setAnchorPoint(elseBox, 0.50, 0.50)
	GUI:setTouchEnabled(elseBox, true)
	GUI:setTag(elseBox, 0)
	GUI:setVisible(elseBox, false)

	-- Create mask
	local mask = GUI:Layout_Create(elseBox, "mask", 250, 100, 500, 200, false)
	GUI:setAnchorPoint(mask, 0.50, 0.50)
	GUI:setTouchEnabled(mask, true)
	GUI:setMouseEnabled(mask, true)
	GUI:setTag(mask, 0)

	-- Create elseTextList
	local elseTextList = GUI:ListView_Create(elseBox, "elseTextList", 228, 86, 426, 148, 1)
	GUI:setAnchorPoint(elseTextList, 0.50, 0.50)
	GUI:setTouchEnabled(elseTextList, true)
	GUI:setTag(elseTextList, 0)

	-- Create elseText1
	local elseText1 = GUI:Text_Create(elseTextList, "elseText1", 0, 106, 16, "#ffffff", [[是否确定前往“巨兽镜像副本”调整？]])
	GUI:Text_enableOutline(elseText1, "#000000", 1)
	GUI:setAnchorPoint(elseText1, 0.00, 1.00)
	GUI:setTouchEnabled(elseText1, false)
	GUI:setTag(elseText1, 0)

	-- Create elseText2
	local elseText2 = GUI:Text_Create(elseTextList, "elseText2", 0, 85, 16, "#ffffff", [[挑战需要：巨兽挑战书×1]])
	GUI:Text_enableOutline(elseText2, "#000000", 1)
	GUI:setAnchorPoint(elseText2, 0.00, 1.00)
	GUI:setTouchEnabled(elseText2, false)
	GUI:setTag(elseText2, 0)

	-- Create elseCloseBtn
	local elseCloseBtn = GUI:Button_Create(elseBox, "elseCloseBtn", 386, 40, "res/public/00000361.png")
	GUI:Button_loadTexturePressed(elseCloseBtn, "res/public/00000362.png")
	GUI:setContentSize(elseCloseBtn, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(elseCloseBtn, false)
	GUI:Button_setTitleText(elseCloseBtn, [[]])
	GUI:Button_setTitleColor(elseCloseBtn, "#ffffff")
	GUI:Button_setTitleFontSize(elseCloseBtn, 16)
	GUI:Button_titleEnableOutline(elseCloseBtn, "#000000", 1)
	GUI:setAnchorPoint(elseCloseBtn, 0.50, 0.50)
	GUI:setTouchEnabled(elseCloseBtn, true)
	GUI:setTag(elseCloseBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
