local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 337, 102, 432, 402, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create layout
	local layout = GUI:Layout_Create(FrameLayout, "layout", 0, 0, 432, 402, true)
	GUI:setAnchorPoint(layout, 0.00, 0.00)
	GUI:setTouchEnabled(layout, false)
	GUI:setTag(layout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(layout, "bg_Image", 0, 0, "res/custom/npc/71bz/bg.png")
	GUI:setContentSize(bg_Image, 432, 402)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create equipNode1
	local equipNode1 = GUI:Node_Create(layout, "equipNode1", 216, 290)
	GUI:setTag(equipNode1, 0)

	-- Create equipBox1
	local equipBox1 = GUI:Image_Create(equipNode1, "equipBox1", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox1, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox1, false)
	GUI:setTag(equipBox1, 0)

	-- Create equipBox2
	local equipBox2 = GUI:Image_Create(equipNode1, "equipBox2", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox2, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox2, false)
	GUI:setTag(equipBox2, 0)

	-- Create equipBox3
	local equipBox3 = GUI:Image_Create(equipNode1, "equipBox3", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox3, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox3, false)
	GUI:setTag(equipBox3, 0)

	-- Create equipBox4
	local equipBox4 = GUI:Image_Create(equipNode1, "equipBox4", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox4, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox4, false)
	GUI:setTag(equipBox4, 0)

	-- Create equipNode2
	local equipNode2 = GUI:Node_Create(layout, "equipNode2", 216, 194)
	GUI:setTag(equipNode2, 0)

	-- Create equipBox5
	local equipBox5 = GUI:Image_Create(equipNode2, "equipBox5", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox5, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox5, false)
	GUI:setTag(equipBox5, 0)

	-- Create equipBox6
	local equipBox6 = GUI:Image_Create(equipNode2, "equipBox6", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox6, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox6, false)
	GUI:setTag(equipBox6, 0)

	-- Create equipBox7
	local equipBox7 = GUI:Image_Create(equipNode2, "equipBox7", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox7, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox7, false)
	GUI:setTag(equipBox7, 0)

	-- Create equipBox8
	local equipBox8 = GUI:Image_Create(equipNode2, "equipBox8", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox8, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox8, false)
	GUI:setTag(equipBox8, 0)

	-- Create equipNode3
	local equipNode3 = GUI:Node_Create(layout, "equipNode3", 216, 94)
	GUI:setTag(equipNode3, 0)

	-- Create equipBox9
	local equipBox9 = GUI:Image_Create(equipNode3, "equipBox9", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox9, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox9, false)
	GUI:setTag(equipBox9, 0)

	-- Create equipBox10
	local equipBox10 = GUI:Image_Create(equipNode3, "equipBox10", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox10, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox10, false)
	GUI:setTag(equipBox10, 0)

	-- Create equipBox11
	local equipBox11 = GUI:Image_Create(equipNode3, "equipBox11", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox11, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox11, false)
	GUI:setTag(equipBox11, 0)

	-- Create equipBox12
	local equipBox12 = GUI:Image_Create(equipNode3, "equipBox12", 0, 0, "res/custom/itemBox4.png")
	GUI:setAnchorPoint(equipBox12, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox12, false)
	GUI:setTag(equipBox12, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 466, 402, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 1.00, 1.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
