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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 834, 534, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/666lpxz/bg.png")
	GUI:setContentSize(bg_Image, 834, 534)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create xuemai_box
	local xuemai_box = GUI:Layout_Create(FrameLayout, "xuemai_box", 463, 229, 363, 212, true)
	GUI:setAnchorPoint(xuemai_box, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_box, false)
	GUI:setTag(xuemai_box, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 793, 492, "res/custom/npc/666lpxz/k1.png")
	GUI:setContentSize(closeBtn, 42, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create xuemai_bg
	local xuemai_bg = GUI:Image_Create(FrameLayout, "xuemai_bg", 138, 83, "res/public/bg_clhczy_01.jpg")
	GUI:Image_setScale9Slice(xuemai_bg, 73, 73, 148, 148)
	GUI:setContentSize(xuemai_bg, 311, 164)
	GUI:setIgnoreContentAdaptWithSize(xuemai_bg, false)
	GUI:setAnchorPoint(xuemai_bg, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg, false)
	GUI:setTag(xuemai_bg, 0)

	-- Create attr_box
	local attr_box = GUI:Layout_Create(xuemai_bg, "attr_box", 2, 0, 305, 148, false)
	GUI:setAnchorPoint(attr_box, 0.00, 0.00)
	GUI:setTouchEnabled(attr_box, false)
	GUI:setTag(attr_box, 0)

	-- Create xuemai_box1
	local xuemai_box1 = GUI:Image_Create(FrameLayout, "xuemai_box1", 150, 84, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box1, 0.00, 0.00)
	GUI:setScale(xuemai_box1, 0.60)
	GUI:setTouchEnabled(xuemai_box1, true)
	GUI:setTag(xuemai_box1, 0)

	-- Create xuemai_item1
	local xuemai_item1 = GUI:ItemShow_Create(xuemai_box1, "xuemai_item1", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item1, 0.50, 0.50)
	GUI:setTag(xuemai_item1, 0)

	-- Create xuemai_box2
	local xuemai_box2 = GUI:Image_Create(FrameLayout, "xuemai_box2", 199, 83, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box2, 0.00, 0.00)
	GUI:setScale(xuemai_box2, 0.60)
	GUI:setTouchEnabled(xuemai_box2, true)
	GUI:setTag(xuemai_box2, 0)

	-- Create xuemai_item2
	local xuemai_item2 = GUI:ItemShow_Create(xuemai_box2, "xuemai_item2", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item2, 0.50, 0.50)
	GUI:setTag(xuemai_item2, 0)

	-- Create xuemai_box3
	local xuemai_box3 = GUI:Image_Create(FrameLayout, "xuemai_box3", 247, 83, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box3, 0.00, 0.00)
	GUI:setScale(xuemai_box3, 0.60)
	GUI:setTouchEnabled(xuemai_box3, true)
	GUI:setTag(xuemai_box3, 0)

	-- Create xuemai_item3
	local xuemai_item3 = GUI:ItemShow_Create(xuemai_box3, "xuemai_item3", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item3, 0.50, 0.50)
	GUI:setTag(xuemai_item3, 0)

	-- Create xuemai_box4
	local xuemai_box4 = GUI:Image_Create(FrameLayout, "xuemai_box4", 297, 83, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box4, 0.00, 0.00)
	GUI:setScale(xuemai_box4, 0.60)
	GUI:setTouchEnabled(xuemai_box4, true)
	GUI:setTag(xuemai_box4, 0)

	-- Create xuemai_item4
	local xuemai_item4 = GUI:ItemShow_Create(xuemai_box4, "xuemai_item4", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item4, 0.50, 0.50)
	GUI:setTag(xuemai_item4, 0)

	-- Create xuemai_box5
	local xuemai_box5 = GUI:Image_Create(FrameLayout, "xuemai_box5", 346, 83, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box5, 0.00, 0.00)
	GUI:setScale(xuemai_box5, 0.60)
	GUI:setTouchEnabled(xuemai_box5, true)
	GUI:setTag(xuemai_box5, 0)

	-- Create xuemai_item5
	local xuemai_item5 = GUI:ItemShow_Create(xuemai_box5, "xuemai_item5", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item5, 0.50, 0.50)
	GUI:setTag(xuemai_item5, 0)

	-- Create xuemai_box6
	local xuemai_box6 = GUI:Image_Create(FrameLayout, "xuemai_box6", 395, 83, "res/custom/npc/23xm/k4.png")
	GUI:setAnchorPoint(xuemai_box6, 0.00, 0.00)
	GUI:setScale(xuemai_box6, 0.60)
	GUI:setTouchEnabled(xuemai_box6, true)
	GUI:setTag(xuemai_box6, 0)

	-- Create xuemai_item6
	local xuemai_item6 = GUI:ItemShow_Create(xuemai_box6, "xuemai_item6", 38, 35, {index = 1, count = 1, look = false, bgVisible = false, color = 255})
	GUI:setAnchorPoint(xuemai_item6, 0.50, 0.50)
	GUI:setTag(xuemai_item6, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(FrameLayout, "select_img", 154, 100, "res/custom/1900000678_1.png")
	GUI:setContentSize(select_img, 82, 83)
	GUI:setIgnoreContentAdaptWithSize(select_img, false)
	GUI:setAnchorPoint(select_img, 0.00, 0.00)
	GUI:setScale(select_img, 0.47)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 0, 333, 138, 126, 1)
	GUI:ListView_setGravity(ListView_1, 1)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create occupation_btn1
	local occupation_btn1 = GUI:Button_Create(ListView_1, "occupation_btn1", 0, 84, "res/custom/npc/666lpxz/tips2.png")
	GUI:Button_loadTexturePressed(occupation_btn1, "res/custom/npc/666lpxz/tips2.png")
	GUI:setContentSize(occupation_btn1, 138, 42)
	GUI:setIgnoreContentAdaptWithSize(occupation_btn1, false)
	GUI:Button_setTitleText(occupation_btn1, [[狂战]])
	GUI:Button_setTitleColor(occupation_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(occupation_btn1, 16)
	GUI:Button_titleDisableOutLine(occupation_btn1)
	GUI:setAnchorPoint(occupation_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(occupation_btn1, true)
	GUI:setTag(occupation_btn1, 0)

	-- Create occupation_btn2
	local occupation_btn2 = GUI:Button_Create(ListView_1, "occupation_btn2", 0, 42, "res/custom/npc/666lpxz/tips.png")
	GUI:setContentSize(occupation_btn2, 138, 42)
	GUI:setIgnoreContentAdaptWithSize(occupation_btn2, false)
	GUI:Button_setTitleText(occupation_btn2, [[武圣]])
	GUI:Button_setTitleColor(occupation_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(occupation_btn2, 16)
	GUI:Button_titleDisableOutLine(occupation_btn2)
	GUI:setAnchorPoint(occupation_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(occupation_btn2, true)
	GUI:setTag(occupation_btn2, 0)

	-- Create occupation_btn3
	local occupation_btn3 = GUI:Button_Create(ListView_1, "occupation_btn3", 0, 0, "res/custom/npc/666lpxz/tips.png")
	GUI:setContentSize(occupation_btn3, 138, 42)
	GUI:setIgnoreContentAdaptWithSize(occupation_btn3, false)
	GUI:Button_setTitleText(occupation_btn3, [[坦克]])
	GUI:Button_setTitleColor(occupation_btn3, "#ffffff")
	GUI:Button_setTitleFontSize(occupation_btn3, 16)
	GUI:Button_titleDisableOutLine(occupation_btn3)
	GUI:setAnchorPoint(occupation_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(occupation_btn3, true)
	GUI:setTag(occupation_btn3, 0)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(FrameLayout, "ListView_2", 0, 172, 135, 126, 1)
	GUI:ListView_setGravity(ListView_2, 1)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 0)

	-- Create occupation_btn4
	local occupation_btn4 = GUI:Button_Create(ListView_2, "occupation_btn4", -3, 84, "res/custom/npc/666lpxz/tips.png")
	GUI:setContentSize(occupation_btn4, 138, 42)
	GUI:setIgnoreContentAdaptWithSize(occupation_btn4, false)
	GUI:Button_setTitleText(occupation_btn4, [[符道]])
	GUI:Button_setTitleColor(occupation_btn4, "#ffffff")
	GUI:Button_setTitleFontSize(occupation_btn4, 16)
	GUI:Button_titleDisableOutLine(occupation_btn4)
	GUI:setAnchorPoint(occupation_btn4, 0.00, 0.00)
	GUI:setTouchEnabled(occupation_btn4, true)
	GUI:setTag(occupation_btn4, 0)

	-- Create occupation_btn5
	local occupation_btn5 = GUI:Button_Create(ListView_2, "occupation_btn5", -3, 42, "res/custom/npc/666lpxz/tips.png")
	GUI:setContentSize(occupation_btn5, 138, 42)
	GUI:setIgnoreContentAdaptWithSize(occupation_btn5, false)
	GUI:Button_setTitleText(occupation_btn5, [[道尊]])
	GUI:Button_setTitleColor(occupation_btn5, "#ffffff")
	GUI:Button_setTitleFontSize(occupation_btn5, 16)
	GUI:Button_titleDisableOutLine(occupation_btn5)
	GUI:setAnchorPoint(occupation_btn5, 0.00, 0.00)
	GUI:setTouchEnabled(occupation_btn5, true)
	GUI:setTag(occupation_btn5, 0)

	-- Create occupation_btn6
	local occupation_btn6 = GUI:Button_Create(ListView_2, "occupation_btn6", -3, 0, "res/custom/npc/666lpxz/tips.png")
	GUI:setContentSize(occupation_btn6, 138, 42)
	GUI:setIgnoreContentAdaptWithSize(occupation_btn6, false)
	GUI:Button_setTitleText(occupation_btn6, [[兽神]])
	GUI:Button_setTitleColor(occupation_btn6, "#ffffff")
	GUI:Button_setTitleFontSize(occupation_btn6, 16)
	GUI:Button_titleDisableOutLine(occupation_btn6)
	GUI:setAnchorPoint(occupation_btn6, 0.00, 0.00)
	GUI:setTouchEnabled(occupation_btn6, true)
	GUI:setTag(occupation_btn6, 0)

	-- Create ListView_3
	local ListView_3 = GUI:ListView_Create(FrameLayout, "ListView_3", 0, 4, 132, 129, 1)
	GUI:ListView_setGravity(ListView_3, 1)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)

	-- Create occupation_btn7
	local occupation_btn7 = GUI:Button_Create(ListView_3, "occupation_btn7", -6, 87, "res/custom/npc/666lpxz/tips.png")
	GUI:setContentSize(occupation_btn7, 138, 42)
	GUI:setIgnoreContentAdaptWithSize(occupation_btn7, false)
	GUI:Button_setTitleText(occupation_btn7, [[炎帝]])
	GUI:Button_setTitleColor(occupation_btn7, "#ffffff")
	GUI:Button_setTitleFontSize(occupation_btn7, 16)
	GUI:Button_titleDisableOutLine(occupation_btn7)
	GUI:setAnchorPoint(occupation_btn7, 0.00, 0.00)
	GUI:setTouchEnabled(occupation_btn7, true)
	GUI:setTag(occupation_btn7, 0)

	-- Create occupation_btn8
	local occupation_btn8 = GUI:Button_Create(ListView_3, "occupation_btn8", -6, 45, "res/custom/npc/666lpxz/tips.png")
	GUI:setContentSize(occupation_btn8, 138, 42)
	GUI:setIgnoreContentAdaptWithSize(occupation_btn8, false)
	GUI:Button_setTitleText(occupation_btn8, [[召唤]])
	GUI:Button_setTitleColor(occupation_btn8, "#ffffff")
	GUI:Button_setTitleFontSize(occupation_btn8, 16)
	GUI:Button_titleDisableOutLine(occupation_btn8)
	GUI:setAnchorPoint(occupation_btn8, 0.00, 0.00)
	GUI:setTouchEnabled(occupation_btn8, true)
	GUI:setTag(occupation_btn8, 0)

	-- Create occupation_btn9
	local occupation_btn9 = GUI:Button_Create(ListView_3, "occupation_btn9", -6, 3, "res/custom/npc/666lpxz/tips.png")
	GUI:setContentSize(occupation_btn9, 138, 42)
	GUI:setIgnoreContentAdaptWithSize(occupation_btn9, false)
	GUI:Button_setTitleText(occupation_btn9, [[分身]])
	GUI:Button_setTitleColor(occupation_btn9, "#ffffff")
	GUI:Button_setTitleFontSize(occupation_btn9, 16)
	GUI:Button_titleDisableOutLine(occupation_btn9)
	GUI:setAnchorPoint(occupation_btn9, 0.00, 0.00)
	GUI:setTouchEnabled(occupation_btn9, true)
	GUI:setTag(occupation_btn9, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 41, 460, 22, "#ff0000", [[战士]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 41, 297, 22, "#ff0000", [[道士]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 41, 136, 22, "#ff0000", [[法师]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create ListView_4
	local ListView_4 = GUI:ListView_Create(FrameLayout, "ListView_4", 137, 78, 312, 162, 1)
	GUI:ListView_setGravity(ListView_4, 2)
	GUI:ListView_setItemsMargin(ListView_4, 4)
	GUI:setAnchorPoint(ListView_4, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_4, false)
	GUI:setTag(ListView_4, 0)
	GUI:setVisible(ListView_4, false)

	-- Create skill_box
	local skill_box = GUI:Layout_Create(FrameLayout, "skill_box", 463, 11, 363, 212, true)
	GUI:setAnchorPoint(skill_box, 0.00, 0.00)
	GUI:setTouchEnabled(skill_box, false)
	GUI:setTag(skill_box, 0)

	-- Create change_occupation
	local change_occupation = GUI:Button_Create(FrameLayout, "change_occupation", 177, 20, "res/custom/npc/666lpxz/k2.png")
	GUI:Button_loadTexturePressed(change_occupation, "res/custom/npc/666lpxz/k3.png")
	GUI:setContentSize(change_occupation, 232, 38)
	GUI:setIgnoreContentAdaptWithSize(change_occupation, false)
	GUI:Button_setTitleText(change_occupation, [[]])
	GUI:Button_setTitleColor(change_occupation, "#ffffff")
	GUI:Button_setTitleFontSize(change_occupation, 16)
	GUI:Button_titleDisableOutLine(change_occupation)
	GUI:setAnchorPoint(change_occupation, 0.00, 0.00)
	GUI:setTouchEnabled(change_occupation, true)
	GUI:setTag(change_occupation, 0)

	-- Create skill_desc_box
	local skill_desc_box = GUI:ListView_Create(FrameLayout, "skill_desc_box", 140, 290, 312, 160, 1)
	GUI:setAnchorPoint(skill_desc_box, 0.00, 0.00)
	GUI:setTouchEnabled(skill_desc_box, true)
	GUI:setTag(skill_desc_box, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
