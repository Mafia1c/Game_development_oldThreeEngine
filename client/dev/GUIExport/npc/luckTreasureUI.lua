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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 590, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/71bz/1/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create leftBtnNode
	local leftBtnNode = GUI:Node_Create(FrameBG, "leftBtnNode", 0, 0)
	GUI:setTag(leftBtnNode, 0)

	-- Create leftBtn3
	local leftBtn3 = GUI:Button_Create(leftBtnNode, "leftBtn3", 32, 114, "res/custom/npc/71bz/btn32.png")
	GUI:Button_loadTexturePressed(leftBtn3, "res/custom/npc/71bz/btn31.png")
	GUI:setContentSize(leftBtn3, 50, 144)
	GUI:setIgnoreContentAdaptWithSize(leftBtn3, false)
	GUI:Button_setTitleText(leftBtn3, [[]])
	GUI:Button_setTitleColor(leftBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn3, 16)
	GUI:Button_titleEnableOutline(leftBtn3, "#000000", 1)
	GUI:setAnchorPoint(leftBtn3, 0.50, 0.50)
	GUI:setTouchEnabled(leftBtn3, true)
	GUI:setTag(leftBtn3, 0)

	-- Create leftBtn2
	local leftBtn2 = GUI:Button_Create(leftBtnNode, "leftBtn2", 32, 232, "res/custom/npc/71bz/btn22.png")
	GUI:Button_loadTexturePressed(leftBtn2, "res/custom/npc/71bz/btn21.png")
	GUI:setContentSize(leftBtn2, 50, 144)
	GUI:setIgnoreContentAdaptWithSize(leftBtn2, false)
	GUI:Button_setTitleText(leftBtn2, [[]])
	GUI:Button_setTitleColor(leftBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn2, 16)
	GUI:Button_titleEnableOutline(leftBtn2, "#000000", 1)
	GUI:setAnchorPoint(leftBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(leftBtn2, true)
	GUI:setTag(leftBtn2, 0)

	-- Create leftBtn1
	local leftBtn1 = GUI:Button_Create(leftBtnNode, "leftBtn1", 32, 350, "res/custom/npc/71bz/btn12.png")
	GUI:Button_loadTexturePressed(leftBtn1, "res/custom/npc/71bz/btn11.png")
	GUI:setContentSize(leftBtn1, 50, 144)
	GUI:setIgnoreContentAdaptWithSize(leftBtn1, false)
	GUI:Button_setTitleText(leftBtn1, [[]])
	GUI:Button_setTitleColor(leftBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn1, 16)
	GUI:Button_titleEnableOutline(leftBtn1, "#000000", 1)
	GUI:setAnchorPoint(leftBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(leftBtn1, true)
	GUI:setTag(leftBtn1, 0)

	-- Create midNode1
	local midNode1 = GUI:Node_Create(FrameBG, "midNode1", 0, 0)
	GUI:setTag(midNode1, 0)

	-- Create leftNode11
	local leftNode11 = GUI:Node_Create(midNode1, "leftNode11", 0, 0)
	GUI:setTag(leftNode11, 0)

	-- Create tipsBtn11
	local tipsBtn11 = GUI:Button_Create(leftNode11, "tipsBtn11", 495, 462, "res/custom/tips.png")
	GUI:setContentSize(tipsBtn11, 34, 34)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn11, false)
	GUI:Button_setTitleText(tipsBtn11, [[]])
	GUI:Button_setTitleColor(tipsBtn11, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn11, 16)
	GUI:Button_titleEnableOutline(tipsBtn11, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn11, 0.50, 0.50)
	GUI:setTouchEnabled(tipsBtn11, true)
	GUI:setTag(tipsBtn11, 0)

	-- Create todayItem11
	local todayItem11 = GUI:ItemShow_Create(leftNode11, "todayItem11", 124, 394, {index = 10152, count = 888, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(todayItem11, 0.50, 0.50)
	GUI:setTag(todayItem11, 0)

	-- Create todayRtext1
	local todayRtext1 = GUI:RichText_Create(leftNode11, "todayRtext1", 132, 349, [[<font color='#FFFFFF' size='16' >开启</font><font color='#ff0000' size='16' >18次</font>]], 80, 16, "#ffffff", 4)
	GUI:setAnchorPoint(todayRtext1, 0.50, 0.50)
	GUI:setTag(todayRtext1, 0)

	-- Create todayItem12
	local todayItem12 = GUI:ItemShow_Create(leftNode11, "todayItem12", 124, 304, {index = 10250, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(todayItem12, 0.50, 0.50)
	GUI:setTag(todayItem12, 0)

	-- Create todayRtext2
	local todayRtext2 = GUI:RichText_Create(leftNode11, "todayRtext2", 131, 260, [[<font color='#FFFFFF' size='16' >开启</font><font color='#ff0000' size='16' >58次</font>]], 80, 16, "#ffffff", 4)
	GUI:setAnchorPoint(todayRtext2, 0.50, 0.50)
	GUI:setTag(todayRtext2, 0)

	-- Create textList1
	local textList1 = GUI:ListView_Create(leftNode11, "textList1", 292, 162, 426, 80, 1)
	GUI:ListView_setItemsMargin(textList1, 4)
	GUI:setAnchorPoint(textList1, 0.50, 0.50)
	GUI:setTouchEnabled(textList1, true)
	GUI:setTag(textList1, 0)

	-- Create oddText11
	local oddText11 = GUI:Text_Create(textList1, "oddText11", 0, 56, 16, "#00ff00", [[开启宝藏1%概率，可获得：龙神坐骑(限定装扮)]])
	GUI:Text_enableOutline(oddText11, "#000000", 1)
	GUI:setAnchorPoint(oddText11, 0.00, 0.00)
	GUI:setTouchEnabled(oddText11, false)
	GUI:setTag(oddText11, 0)

	-- Create openText12
	local openText12 = GUI:Text_Create(textList1, "openText12", 0, 28, 16, "#ffff00", [[累计开启0/99次后必出！]])
	GUI:Text_enableOutline(openText12, "#000000", 1)
	GUI:setAnchorPoint(openText12, 0.00, 0.00)
	GUI:setTouchEnabled(openText12, false)
	GUI:setTag(openText12, 0)

	-- Create keyText13
	local keyText13 = GUI:Text_Create(textList1, "keyText13", 0, 0, 16, "#ffff00", [[终身特权用户每日可领取：祥瑞钥匙(福利)×1]])
	GUI:Text_enableOutline(keyText13, "#000000", 1)
	GUI:setAnchorPoint(keyText13, 0.00, 0.00)
	GUI:setTouchEnabled(keyText13, false)
	GUI:setTag(keyText13, 0)

	-- Create tqBtn1
	local tqBtn1 = GUI:Button_Create(keyText13, "tqBtn1", 350, 0, "res/custom/bt_dz.png")
	GUI:setContentSize(tqBtn1, 70, 32)
	GUI:setIgnoreContentAdaptWithSize(tqBtn1, false)
	GUI:Button_setTitleText(tqBtn1, [[领取]])
	GUI:Button_setTitleColor(tqBtn1, "#e8dcbd")
	GUI:Button_setTitleFontSize(tqBtn1, 16)
	GUI:Button_titleEnableOutline(tqBtn1, "#000000", 1)
	GUI:setAnchorPoint(tqBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(tqBtn1, true)
	GUI:setTag(tqBtn1, 0)

	-- Create awardList1
	local awardList1 = GUI:ScrollView_Create(leftNode11, "awardList1", 320, 80, 388, 60, 1)
	GUI:ScrollView_setInnerContainerSize(awardList1, 388.00, 200.00)
	GUI:setAnchorPoint(awardList1, 0.50, 0.50)
	GUI:setTouchEnabled(awardList1, true)
	GUI:setTag(awardList1, 0)

	-- Create leftNode12
	local leftNode12 = GUI:Node_Create(midNode1, "leftNode12", 0, 0)
	GUI:setTag(leftNode12, 0)
	GUI:setVisible(leftNode12, false)

	-- Create recycleItemNode11
	local recycleItemNode11 = GUI:Node_Create(leftNode12, "recycleItemNode11", 290, 436)
	GUI:setTag(recycleItemNode11, 0)

	-- Create recycleBox1
	local recycleBox1 = GUI:Image_Create(recycleItemNode11, "recycleBox1", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox1, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox1, false)
	GUI:setTag(recycleBox1, 0)

	-- Create recycleItem1
	local recycleItem1 = GUI:ItemShow_Create(recycleBox1, "recycleItem1", 32, 32, {index = 51044, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem1, 0.50, 0.50)
	GUI:setTag(recycleItem1, 0)

	-- Create recycleBtn1
	local recycleBtn1 = GUI:Button_Create(recycleBox1, "recycleBtn1", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn1, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn1, false)
	GUI:Button_setTitleText(recycleBtn1, [[]])
	GUI:Button_setTitleColor(recycleBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn1, 16)
	GUI:Button_titleEnableOutline(recycleBtn1, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn1, true)
	GUI:setTag(recycleBtn1, 0)

	-- Create recycleBox2
	local recycleBox2 = GUI:Image_Create(recycleItemNode11, "recycleBox2", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox2, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox2, false)
	GUI:setTag(recycleBox2, 0)

	-- Create recycleItem2
	local recycleItem2 = GUI:ItemShow_Create(recycleBox2, "recycleItem2", 32, 32, {index = 51045, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem2, 0.50, 0.50)
	GUI:setTag(recycleItem2, 0)

	-- Create recycleBtn2
	local recycleBtn2 = GUI:Button_Create(recycleBox2, "recycleBtn2", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn2, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn2, false)
	GUI:Button_setTitleText(recycleBtn2, [[]])
	GUI:Button_setTitleColor(recycleBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn2, 16)
	GUI:Button_titleEnableOutline(recycleBtn2, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn2, true)
	GUI:setTag(recycleBtn2, 0)

	-- Create recycleBox3
	local recycleBox3 = GUI:Image_Create(recycleItemNode11, "recycleBox3", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox3, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox3, false)
	GUI:setTag(recycleBox3, 0)

	-- Create recycleItem3
	local recycleItem3 = GUI:ItemShow_Create(recycleBox3, "recycleItem3", 32, 32, {index = 51046, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem3, 0.50, 0.50)
	GUI:setTag(recycleItem3, 0)

	-- Create recycleBtn3
	local recycleBtn3 = GUI:Button_Create(recycleBox3, "recycleBtn3", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn3, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn3, false)
	GUI:Button_setTitleText(recycleBtn3, [[]])
	GUI:Button_setTitleColor(recycleBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn3, 16)
	GUI:Button_titleEnableOutline(recycleBtn3, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn3, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn3, true)
	GUI:setTag(recycleBtn3, 0)

	-- Create recycleBox4
	local recycleBox4 = GUI:Image_Create(recycleItemNode11, "recycleBox4", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox4, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox4, false)
	GUI:setTag(recycleBox4, 0)

	-- Create recycleItem4
	local recycleItem4 = GUI:ItemShow_Create(recycleBox4, "recycleItem4", 32, 32, {index = 51047, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem4, 0.50, 0.50)
	GUI:setTag(recycleItem4, 0)

	-- Create recycleBtn4
	local recycleBtn4 = GUI:Button_Create(recycleBox4, "recycleBtn4", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn4, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn4, false)
	GUI:Button_setTitleText(recycleBtn4, [[]])
	GUI:Button_setTitleColor(recycleBtn4, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn4, 16)
	GUI:Button_titleEnableOutline(recycleBtn4, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn4, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn4, true)
	GUI:setTag(recycleBtn4, 0)

	-- Create recycleItemNode12
	local recycleItemNode12 = GUI:Node_Create(leftNode12, "recycleItemNode12", 290, 324)
	GUI:setTag(recycleItemNode12, 0)

	-- Create recycleBox5
	local recycleBox5 = GUI:Image_Create(recycleItemNode12, "recycleBox5", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox5, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox5, false)
	GUI:setTag(recycleBox5, 0)

	-- Create recycleItem5
	local recycleItem5 = GUI:ItemShow_Create(recycleBox5, "recycleItem5", 32, 32, {index = 51048, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem5, 0.50, 0.50)
	GUI:setTag(recycleItem5, 0)

	-- Create recycleBtn5
	local recycleBtn5 = GUI:Button_Create(recycleBox5, "recycleBtn5", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn5, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn5, false)
	GUI:Button_setTitleText(recycleBtn5, [[]])
	GUI:Button_setTitleColor(recycleBtn5, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn5, 16)
	GUI:Button_titleEnableOutline(recycleBtn5, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn5, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn5, true)
	GUI:setTag(recycleBtn5, 0)

	-- Create recycleBox6
	local recycleBox6 = GUI:Image_Create(recycleItemNode12, "recycleBox6", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox6, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox6, false)
	GUI:setTag(recycleBox6, 0)

	-- Create recycleItem6
	local recycleItem6 = GUI:ItemShow_Create(recycleBox6, "recycleItem6", 32, 32, {index = 51049, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem6, 0.50, 0.50)
	GUI:setTag(recycleItem6, 0)

	-- Create recycleBtn6
	local recycleBtn6 = GUI:Button_Create(recycleBox6, "recycleBtn6", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn6, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn6, false)
	GUI:Button_setTitleText(recycleBtn6, [[]])
	GUI:Button_setTitleColor(recycleBtn6, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn6, 16)
	GUI:Button_titleEnableOutline(recycleBtn6, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn6, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn6, true)
	GUI:setTag(recycleBtn6, 0)

	-- Create recycleBox7
	local recycleBox7 = GUI:Image_Create(recycleItemNode12, "recycleBox7", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox7, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox7, false)
	GUI:setTag(recycleBox7, 0)

	-- Create recycleItem7
	local recycleItem7 = GUI:ItemShow_Create(recycleBox7, "recycleItem7", 32, 32, {index = 51050, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem7, 0.50, 0.50)
	GUI:setTag(recycleItem7, 0)

	-- Create recycleBtn7
	local recycleBtn7 = GUI:Button_Create(recycleBox7, "recycleBtn7", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn7, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn7, false)
	GUI:Button_setTitleText(recycleBtn7, [[]])
	GUI:Button_setTitleColor(recycleBtn7, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn7, 16)
	GUI:Button_titleEnableOutline(recycleBtn7, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn7, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn7, true)
	GUI:setTag(recycleBtn7, 0)

	-- Create recycleBox8
	local recycleBox8 = GUI:Image_Create(recycleItemNode12, "recycleBox8", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox8, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox8, false)
	GUI:setTag(recycleBox8, 0)

	-- Create recycleItem8
	local recycleItem8 = GUI:ItemShow_Create(recycleBox8, "recycleItem8", 32, 32, {index = 51051, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem8, 0.50, 0.50)
	GUI:setTag(recycleItem8, 0)

	-- Create recycleBtn8
	local recycleBtn8 = GUI:Button_Create(recycleBox8, "recycleBtn8", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn8, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn8, false)
	GUI:Button_setTitleText(recycleBtn8, [[]])
	GUI:Button_setTitleColor(recycleBtn8, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn8, 16)
	GUI:Button_titleEnableOutline(recycleBtn8, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn8, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn8, true)
	GUI:setTag(recycleBtn8, 0)

	-- Create recycleItemNode13
	local recycleItemNode13 = GUI:Node_Create(leftNode12, "recycleItemNode13", 290, 208)
	GUI:setTag(recycleItemNode13, 0)

	-- Create recycleBox9
	local recycleBox9 = GUI:Image_Create(recycleItemNode13, "recycleBox9", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox9, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox9, false)
	GUI:setTag(recycleBox9, 0)

	-- Create recycleItem9
	local recycleItem9 = GUI:ItemShow_Create(recycleBox9, "recycleItem9", 32, 32, {index = 51052, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem9, 0.50, 0.50)
	GUI:setTag(recycleItem9, 0)

	-- Create recycleBtn9
	local recycleBtn9 = GUI:Button_Create(recycleBox9, "recycleBtn9", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn9, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn9, false)
	GUI:Button_setTitleText(recycleBtn9, [[]])
	GUI:Button_setTitleColor(recycleBtn9, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn9, 16)
	GUI:Button_titleEnableOutline(recycleBtn9, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn9, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn9, true)
	GUI:setTag(recycleBtn9, 0)

	-- Create recycleBox10
	local recycleBox10 = GUI:Image_Create(recycleItemNode13, "recycleBox10", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox10, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox10, false)
	GUI:setTag(recycleBox10, 0)

	-- Create recycleItem10
	local recycleItem10 = GUI:ItemShow_Create(recycleBox10, "recycleItem10", 32, 32, {index = 51053, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem10, 0.50, 0.50)
	GUI:setTag(recycleItem10, 0)

	-- Create recycleBtn10
	local recycleBtn10 = GUI:Button_Create(recycleBox10, "recycleBtn10", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn10, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn10, false)
	GUI:Button_setTitleText(recycleBtn10, [[]])
	GUI:Button_setTitleColor(recycleBtn10, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn10, 16)
	GUI:Button_titleEnableOutline(recycleBtn10, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn10, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn10, true)
	GUI:setTag(recycleBtn10, 0)

	-- Create recycleBox11
	local recycleBox11 = GUI:Image_Create(recycleItemNode13, "recycleBox11", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox11, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox11, false)
	GUI:setTag(recycleBox11, 0)

	-- Create recycleItem11
	local recycleItem11 = GUI:ItemShow_Create(recycleBox11, "recycleItem11", 32, 32, {index = 51054, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem11, 0.50, 0.50)
	GUI:setTag(recycleItem11, 0)

	-- Create recycleBtn11
	local recycleBtn11 = GUI:Button_Create(recycleBox11, "recycleBtn11", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn11, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn11, false)
	GUI:Button_setTitleText(recycleBtn11, [[]])
	GUI:Button_setTitleColor(recycleBtn11, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn11, 16)
	GUI:Button_titleEnableOutline(recycleBtn11, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn11, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn11, true)
	GUI:setTag(recycleBtn11, 0)

	-- Create recycleBox12
	local recycleBox12 = GUI:Image_Create(recycleItemNode13, "recycleBox12", 0, 0, "res/custom/npc/71bz/1/k.png")
	GUI:setAnchorPoint(recycleBox12, 0.00, 0.00)
	GUI:setTouchEnabled(recycleBox12, false)
	GUI:setTag(recycleBox12, 0)

	-- Create recycleItem12
	local recycleItem12 = GUI:ItemShow_Create(recycleBox12, "recycleItem12", 32, 32, {index = 51055, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(recycleItem12, 0.50, 0.50)
	GUI:setTag(recycleItem12, 0)

	-- Create recycleBtn12
	local recycleBtn12 = GUI:Button_Create(recycleBox12, "recycleBtn12", 34, -24, "res/custom/npc/71bz/1/an.png")
	GUI:setContentSize(recycleBtn12, 84, 30)
	GUI:setIgnoreContentAdaptWithSize(recycleBtn12, false)
	GUI:Button_setTitleText(recycleBtn12, [[]])
	GUI:Button_setTitleColor(recycleBtn12, "#ffffff")
	GUI:Button_setTitleFontSize(recycleBtn12, 16)
	GUI:Button_titleEnableOutline(recycleBtn12, "#000000", 1)
	GUI:setAnchorPoint(recycleBtn12, 0.50, 0.50)
	GUI:setTouchEnabled(recycleBtn12, true)
	GUI:setTag(recycleBtn12, 0)

	-- Create rightNode1
	local rightNode1 = GUI:Node_Create(midNode1, "rightNode1", 0, 0)
	GUI:setTag(rightNode1, 0)

	-- Create keyItemNode11
	local keyItemNode11 = GUI:Node_Create(rightNode1, "keyItemNode11", 664, 348)
	GUI:setTag(keyItemNode11, 0)

	-- Create keyItem1
	local keyItem1 = GUI:ItemShow_Create(keyItemNode11, "keyItem1", 0, 0, {index = 51044, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem1, 0.50, 0.50)
	GUI:setTag(keyItem1, 0)

	-- Create keyItem2
	local keyItem2 = GUI:ItemShow_Create(keyItemNode11, "keyItem2", 0, 0, {index = 51045, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem2, 0.50, 0.50)
	GUI:setTag(keyItem2, 0)

	-- Create keyItem3
	local keyItem3 = GUI:ItemShow_Create(keyItemNode11, "keyItem3", 0, 0, {index = 51046, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem3, 0.50, 0.50)
	GUI:setTag(keyItem3, 0)

	-- Create keyItem4
	local keyItem4 = GUI:ItemShow_Create(keyItemNode11, "keyItem4", 0, 0, {index = 51047, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem4, 0.50, 0.50)
	GUI:setTag(keyItem4, 0)

	-- Create keyItemNode12
	local keyItemNode12 = GUI:Node_Create(rightNode1, "keyItemNode12", 664, 280)
	GUI:setTag(keyItemNode12, 0)

	-- Create keyItem5
	local keyItem5 = GUI:ItemShow_Create(keyItemNode12, "keyItem5", 0, 0, {index = 51048, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem5, 0.50, 0.50)
	GUI:setTag(keyItem5, 0)

	-- Create keyItem6
	local keyItem6 = GUI:ItemShow_Create(keyItemNode12, "keyItem6", 0, 0, {index = 51049, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem6, 0.50, 0.50)
	GUI:setTag(keyItem6, 0)

	-- Create keyItem7
	local keyItem7 = GUI:ItemShow_Create(keyItemNode12, "keyItem7", 0, 0, {index = 51050, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem7, 0.50, 0.50)
	GUI:setTag(keyItem7, 0)

	-- Create keyItem8
	local keyItem8 = GUI:ItemShow_Create(keyItemNode12, "keyItem8", 0, 0, {index = 51051, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem8, 0.50, 0.50)
	GUI:setTag(keyItem8, 0)

	-- Create keyItemNode13
	local keyItemNode13 = GUI:Node_Create(rightNode1, "keyItemNode13", 664, 212)
	GUI:setTag(keyItemNode13, 0)

	-- Create keyItem9
	local keyItem9 = GUI:ItemShow_Create(keyItemNode13, "keyItem9", 0, 0, {index = 51052, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem9, 0.50, 0.50)
	GUI:setTag(keyItem9, 0)

	-- Create keyItem10
	local keyItem10 = GUI:ItemShow_Create(keyItemNode13, "keyItem10", 0, 0, {index = 51053, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem10, 0.50, 0.50)
	GUI:setTag(keyItem10, 0)

	-- Create keyItem11
	local keyItem11 = GUI:ItemShow_Create(keyItemNode13, "keyItem11", 0, 0, {index = 51054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem11, 0.50, 0.50)
	GUI:setTag(keyItem11, 0)

	-- Create keyItem12
	local keyItem12 = GUI:ItemShow_Create(keyItemNode13, "keyItem12", 0, 0, {index = 51055, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(keyItem12, 0.50, 0.50)
	GUI:setTag(keyItem12, 0)

	-- Create btnNode11
	local btnNode11 = GUI:Node_Create(rightNode1, "btnNode11", 668, 124)
	GUI:setTag(btnNode11, 0)

	-- Create mapBtn11
	local mapBtn11 = GUI:Button_Create(btnNode11, "mapBtn11", 0, 0, "res/custom/npc/71bz/1/an20.png")
	GUI:setContentSize(mapBtn11, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(mapBtn11, false)
	GUI:Button_setTitleText(mapBtn11, [[]])
	GUI:Button_setTitleColor(mapBtn11, "#ffffff")
	GUI:Button_setTitleFontSize(mapBtn11, 16)
	GUI:Button_titleEnableOutline(mapBtn11, "#000000", 1)
	GUI:setAnchorPoint(mapBtn11, 0.00, 0.00)
	GUI:setTouchEnabled(mapBtn11, true)
	GUI:setTag(mapBtn11, 0)

	-- Create mapBtn12
	local mapBtn12 = GUI:Button_Create(btnNode11, "mapBtn12", 0, 0, "res/custom/npc/71bz/1/an21.png")
	GUI:setContentSize(mapBtn12, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(mapBtn12, false)
	GUI:Button_setTitleText(mapBtn12, [[]])
	GUI:Button_setTitleColor(mapBtn12, "#ffffff")
	GUI:Button_setTitleFontSize(mapBtn12, 16)
	GUI:Button_titleEnableOutline(mapBtn12, "#000000", 1)
	GUI:setAnchorPoint(mapBtn12, 0.00, 0.00)
	GUI:setTouchEnabled(mapBtn12, true)
	GUI:setTag(mapBtn12, 0)

	-- Create btnNode12
	local btnNode12 = GUI:Node_Create(rightNode1, "btnNode12", 668, 66)
	GUI:setTag(btnNode12, 0)

	-- Create openBtn11
	local openBtn11 = GUI:Button_Create(btnNode12, "openBtn11", 0, 0, "res/custom/npc/71bz/1/an11.png")
	GUI:setContentSize(openBtn11, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(openBtn11, false)
	GUI:Button_setTitleText(openBtn11, [[]])
	GUI:Button_setTitleColor(openBtn11, "#ffffff")
	GUI:Button_setTitleFontSize(openBtn11, 16)
	GUI:Button_titleEnableOutline(openBtn11, "#000000", 1)
	GUI:setAnchorPoint(openBtn11, 0.00, 0.00)
	GUI:setTouchEnabled(openBtn11, true)
	GUI:setTag(openBtn11, 0)

	-- Create openBtn12
	local openBtn12 = GUI:Button_Create(btnNode12, "openBtn12", 0, 0, "res/custom/npc/71bz/1/an12.png")
	GUI:setContentSize(openBtn12, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(openBtn12, false)
	GUI:Button_setTitleText(openBtn12, [[]])
	GUI:Button_setTitleColor(openBtn12, "#ffffff")
	GUI:Button_setTitleFontSize(openBtn12, 16)
	GUI:Button_titleEnableOutline(openBtn12, "#000000", 1)
	GUI:setAnchorPoint(openBtn12, 0.00, 0.00)
	GUI:setTouchEnabled(openBtn12, true)
	GUI:setTag(openBtn12, 0)

	-- Create mask1
	local mask1 = GUI:Layout_Create(rightNode1, "mask1", 400, 270, 1136, 640, false)
	GUI:setAnchorPoint(mask1, 0.50, 0.50)
	GUI:setTouchEnabled(mask1, true)
	GUI:setMouseEnabled(mask1, true)
	GUI:setTag(mask1, 0)
	GUI:setVisible(mask1, false)

	-- Create openBox1
	local openBox1 = GUI:Image_Create(mask1, "openBox1", 603, 324, "res/public/1900000600.png")
	GUI:Image_setScale9Slice(openBox1, 45, 45, 59, 59)
	GUI:setContentSize(openBox1, 450, 240)
	GUI:setIgnoreContentAdaptWithSize(openBox1, false)
	GUI:setAnchorPoint(openBox1, 0.50, 0.50)
	GUI:setTouchEnabled(openBox1, true)
	GUI:setTag(openBox1, 0)

	-- Create openBoxText11
	local openBoxText11 = GUI:Text_Create(openBox1, "openBoxText11", 228, 190, 16, "#ffff00", [[每次开启宝藏需要祥瑞钥匙×1]])
	GUI:Text_enableOutline(openBoxText11, "#000000", 1)
	GUI:setAnchorPoint(openBoxText11, 0.50, 0.50)
	GUI:setTouchEnabled(openBoxText11, false)
	GUI:setTag(openBoxText11, 0)

	-- Create allKeyText1
	local allKeyText1 = GUI:Text_Create(openBox1, "allKeyText1", 228, 167, 16, "#00ff00", [[当前祥瑞钥匙剩余：0]])
	GUI:Text_enableOutline(allKeyText1, "#000000", 1)
	GUI:setAnchorPoint(allKeyText1, 0.50, 0.50)
	GUI:setTouchEnabled(allKeyText1, false)
	GUI:setTag(allKeyText1, 0)

	-- Create allLuckKeyText1
	local allLuckKeyText1 = GUI:Text_Create(openBox1, "allLuckKeyText1", 228, 143, 16, "#00ff00", [[当前祥瑞钥匙(福利)剩余：0]])
	GUI:Text_enableOutline(allLuckKeyText1, "#000000", 1)
	GUI:setAnchorPoint(allLuckKeyText1, 0.50, 0.50)
	GUI:setTouchEnabled(allLuckKeyText1, false)
	GUI:setTag(allLuckKeyText1, 0)

	-- Create todayOpenText1
	local todayOpenText1 = GUI:Text_Create(openBox1, "todayOpenText1", 228, 122, 16, "#ffffff", [[今日开启次数：0]])
	GUI:Text_enableOutline(todayOpenText1, "#000000", 1)
	GUI:setAnchorPoint(todayOpenText1, 0.50, 0.50)
	GUI:setTouchEnabled(todayOpenText1, false)
	GUI:setTag(todayOpenText1, 0)

	-- Create openBoxText12
	local openBoxText12 = GUI:Text_Create(openBox1, "openBoxText12", 228, 26, 16, "#ff00ff", [[每次开启宝藏可获得祥瑞积分×10(福利钥匙除外)]])
	GUI:Text_enableOutline(openBoxText12, "#000000", 1)
	GUI:setAnchorPoint(openBoxText12, 0.50, 0.50)
	GUI:setTouchEnabled(openBoxText12, false)
	GUI:setTag(openBoxText12, 0)

	-- Create openOneBtn1
	local openOneBtn1 = GUI:Button_Create(openBox1, "openOneBtn1", 162, 76, "res/custom/dayeqian2.png")
	GUI:Button_setScale9Slice(openOneBtn1, 11, 11, 14, 14)
	GUI:setContentSize(openOneBtn1, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(openOneBtn1, false)
	GUI:Button_setTitleText(openOneBtn1, [[开启一次]])
	GUI:Button_setTitleColor(openOneBtn1, "#e8dcbd")
	GUI:Button_setTitleFontSize(openOneBtn1, 16)
	GUI:Button_titleEnableOutline(openOneBtn1, "#000000", 1)
	GUI:setAnchorPoint(openOneBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(openOneBtn1, true)
	GUI:setTag(openOneBtn1, 0)

	-- Create openTenBtn1
	local openTenBtn1 = GUI:Button_Create(openBox1, "openTenBtn1", 300, 76, "res/custom/dayeqian2.png")
	GUI:Button_setScale9Slice(openTenBtn1, 11, 11, 14, 14)
	GUI:setContentSize(openTenBtn1, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(openTenBtn1, false)
	GUI:Button_setTitleText(openTenBtn1, [[开启十次]])
	GUI:Button_setTitleColor(openTenBtn1, "#e8dcbd")
	GUI:Button_setTitleFontSize(openTenBtn1, 16)
	GUI:Button_titleEnableOutline(openTenBtn1, "#000000", 1)
	GUI:setAnchorPoint(openTenBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(openTenBtn1, true)
	GUI:setTag(openTenBtn1, 0)

	-- Create closeOpenBtn1
	local closeOpenBtn1 = GUI:Button_Create(openBox1, "closeOpenBtn1", 466, 222, "res/custom/closeBtn.png")
	GUI:setContentSize(closeOpenBtn1, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeOpenBtn1, false)
	GUI:Button_setTitleText(closeOpenBtn1, [[]])
	GUI:Button_setTitleColor(closeOpenBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(closeOpenBtn1, 16)
	GUI:Button_titleEnableOutline(closeOpenBtn1, "#000000", 1)
	GUI:setAnchorPoint(closeOpenBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(closeOpenBtn1, true)
	GUI:setTag(closeOpenBtn1, 0)

	-- Create midNode2
	local midNode2 = GUI:Node_Create(FrameBG, "midNode2", 0, 0)
	GUI:setTag(midNode2, 0)
	GUI:setVisible(midNode2, false)

	-- Create rankList2
	local rankList2 = GUI:ListView_Create(midNode2, "rankList2", 296, 338, 442, 220, 1)
	GUI:setAnchorPoint(rankList2, 0.50, 0.50)
	GUI:setTouchEnabled(rankList2, true)
	GUI:setTag(rankList2, 0)

	-- Create rankBox21
	local rankBox21 = GUI:Image_Create(rankList2, "rankBox21", 0, 180, "res/custom/npc/71bz/2/listBox.png")
	GUI:setAnchorPoint(rankBox21, 0.00, 0.00)
	GUI:setTouchEnabled(rankBox21, false)
	GUI:setTag(rankBox21, 0)

	-- Create rankText21
	local rankText21 = GUI:Text_Create(rankBox21, "rankText21", 18, 8, 16, "#ffffff", [[第一名]])
	GUI:Text_enableOutline(rankText21, "#000000", 1)
	GUI:setAnchorPoint(rankText21, 0.00, 0.00)
	GUI:setTouchEnabled(rankText21, false)
	GUI:setTag(rankText21, 0)

	-- Create rankName21
	local rankName21 = GUI:Text_Create(rankBox21, "rankName21", 220, 20, 16, "#ffffff", [[我还是哇哇哇哇哇哇哇哇哇我1我我]])
	GUI:Text_enableOutline(rankName21, "#000000", 1)
	GUI:setAnchorPoint(rankName21, 0.50, 0.50)
	GUI:setTouchEnabled(rankName21, false)
	GUI:setTag(rankName21, 0)

	-- Create rankPoint21
	local rankPoint21 = GUI:Text_Create(rankBox21, "rankPoint21", 398, 20, 16, "#ffffff", [[2790]])
	GUI:Text_enableOutline(rankPoint21, "#000000", 1)
	GUI:setAnchorPoint(rankPoint21, 0.50, 0.50)
	GUI:setTouchEnabled(rankPoint21, false)
	GUI:setTag(rankPoint21, 0)

	-- Create awardNode21
	local awardNode21 = GUI:Node_Create(midNode2, "awardNode21", 296, 152)
	GUI:setTag(awardNode21, 0)

	-- Create loopBox21
	local loopBox21 = GUI:Image_Create(awardNode21, "loopBox21", 0, 0, "res/custom/npc/71bz/2/zzhh.png")
	GUI:setContentSize(loopBox21, 145, 171)
	GUI:setIgnoreContentAdaptWithSize(loopBox21, false)
	GUI:setAnchorPoint(loopBox21, 0.00, 0.00)
	GUI:setTouchEnabled(loopBox21, false)
	GUI:setTag(loopBox21, 0)

	-- Create loopEffect21
	local loopEffect21 = GUI:Effect_Create(loopBox21, "loopEffect21", -36, 110, 0, 22108, 0, 0, 0, 1)
	GUI:setTag(loopEffect21, 0)

	-- Create loopItem21
	local loopItem21 = GUI:ItemShow_Create(loopBox21, "loopItem21", 72, 98, {index = 10444, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(loopItem21, 0.50, 0.50)
	GUI:setTag(loopItem21, 0)

	-- Create loopRank21
	local loopRank21 = GUI:Text_Create(loopBox21, "loopRank21", 74, 14, 16, "#fc00fd", [[第一名获得]])
	GUI:Text_enableOutline(loopRank21, "#000000", 1)
	GUI:setAnchorPoint(loopRank21, 0.50, 0.50)
	GUI:setTouchEnabled(loopRank21, false)
	GUI:setTag(loopRank21, 0)

	-- Create loopBox22
	local loopBox22 = GUI:Image_Create(awardNode21, "loopBox22", 0, 0, "res/custom/npc/71bz/2/ryhh.png")
	GUI:setContentSize(loopBox22, 145, 171)
	GUI:setIgnoreContentAdaptWithSize(loopBox22, false)
	GUI:setAnchorPoint(loopBox22, 0.00, 0.00)
	GUI:setTouchEnabled(loopBox22, false)
	GUI:setTag(loopBox22, 0)

	-- Create loopEffect22
	local loopEffect22 = GUI:Effect_Create(loopBox22, "loopEffect22", -32, 116, 0, 22105, 0, 0, 0, 1)
	GUI:setScale(loopEffect22, 0.60)
	GUI:setTag(loopEffect22, 0)

	-- Create loopItem22
	local loopItem22 = GUI:ItemShow_Create(loopBox22, "loopItem22", 72, 98, {index = 10445, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(loopItem22, 0.50, 0.50)
	GUI:setTag(loopItem22, 0)

	-- Create loopRank22
	local loopRank22 = GUI:Text_Create(loopBox22, "loopRank22", 74, 14, 16, "#ffff00", [[第二名获得]])
	GUI:Text_enableOutline(loopRank22, "#000000", 1)
	GUI:setAnchorPoint(loopRank22, 0.50, 0.50)
	GUI:setTouchEnabled(loopRank22, false)
	GUI:setTag(loopRank22, 0)

	-- Create loopBox23
	local loopBox23 = GUI:Image_Create(awardNode21, "loopBox23", 0, 0, "res/custom/npc/71bz/2/wzhh.png")
	GUI:setContentSize(loopBox23, 145, 171)
	GUI:setIgnoreContentAdaptWithSize(loopBox23, false)
	GUI:setAnchorPoint(loopBox23, 0.00, 0.00)
	GUI:setTouchEnabled(loopBox23, false)
	GUI:setTag(loopBox23, 0)

	-- Create loopEffect23
	local loopEffect23 = GUI:Effect_Create(loopBox23, "loopEffect23", -27, 104, 0, 22104, 0, 0, 0, 1)
	GUI:setTag(loopEffect23, 0)

	-- Create loopItem23
	local loopItem23 = GUI:ItemShow_Create(loopBox23, "loopItem23", 72, 98, {index = 10446, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(loopItem23, 0.50, 0.50)
	GUI:setTag(loopItem23, 0)

	-- Create loopRank23
	local loopRank23 = GUI:Text_Create(loopBox23, "loopRank23", 74, 14, 16, "#00ff00", [[第三名获得]])
	GUI:Text_enableOutline(loopRank23, "#000000", 1)
	GUI:setAnchorPoint(loopRank23, 0.50, 0.50)
	GUI:setTouchEnabled(loopRank23, false)
	GUI:setTag(loopRank23, 0)

	-- Create explain2
	local explain2 = GUI:Text_Create(midNode2, "explain2", 290, 50, 16, "#ffff00", [[说明：榜单每次合区清理，3合之后每周5中午12点清理排行]])
	GUI:Text_enableOutline(explain2, "#000000", 1)
	GUI:setAnchorPoint(explain2, 0.50, 0.50)
	GUI:setTouchEnabled(explain2, false)
	GUI:setTag(explain2, 0)

	-- Create Rtext21
	local Rtext21 = GUI:RichText_Create(midNode2, "Rtext21", 536, 260, [[<font color='#FFFF00' size='16' >累计积分≥1880：</font><font color='#FF0000' size='16' >神念一现死一片</font><br><font color='#FFFF00' size='16' >累计积分≥1280：</font><font color='#FF0000' size='16' >九霄风云齐聚会</font><br><font color='#FFFF00' size='16' >累计积分≥580：</font><font color='#FF0000' size='16' >斩断红尘多情客</font><br><font color='#FFFF00' size='16' >今日积分≥200：</font><font color='#FF00FF' size='16' >绑定金刚石×20万</font><br><font color='#FFFF00' size='16' >今日积分≥50：</font><font color='#FF00FF' size='16' >绑定金刚石×5万</font><br><font color='#FFFF00' size='16' >今日积分≥20：</font><font color='#00FF00' size='16' >今日可进入祥瑞迷宫</font>]], 268, 16, "#ffffff", 4)
	GUI:setAnchorPoint(Rtext21, 0.00, 0.00)
	GUI:setTag(Rtext21, 0)

	-- Create awardNode22
	local awardNode22 = GUI:Node_Create(midNode2, "awardNode22", 662, 216)
	GUI:setTag(awardNode22, 0)

	-- Create awardItem21
	local awardItem21 = GUI:ItemShow_Create(awardNode22, "awardItem21", 0, 0, {index = 10497, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(awardItem21, 0.50, 0.50)
	GUI:setTag(awardItem21, 0)

	-- Create awardItem22
	local awardItem22 = GUI:ItemShow_Create(awardNode22, "awardItem22", 0, 0, {index = 10498, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(awardItem22, 0.50, 0.50)
	GUI:setTag(awardItem22, 0)

	-- Create awardItem23
	local awardItem23 = GUI:ItemShow_Create(awardNode22, "awardItem23", 0, 0, {index = 10499, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(awardItem23, 0.50, 0.50)
	GUI:setTag(awardItem23, 0)

	-- Create Rtext22
	local Rtext22 = GUI:RichText_Create(midNode2, "Rtext22", 546, 116, [[<font color='#FFFFFF' size='16' >排行说明：</font><font color='#FFFF00' size='16' >若出现同等积分情况下</font><br><font color='#FFFF00' size='16' >优先达到的玩家，积分排名靠上！</font>]], 250, 16, "#ffffff", 4)
	GUI:setAnchorPoint(Rtext22, 0.00, 0.00)
	GUI:setTag(Rtext22, 0)

	-- Create nowPoints2
	local nowPoints2 = GUI:Text_Create(midNode2, "nowPoints2", 540, 80, 16, "#ffffff", [[今日积分：0]])
	GUI:Text_enableOutline(nowPoints2, "#000000", 1)
	GUI:setAnchorPoint(nowPoints2, 0.00, 0.00)
	GUI:setTouchEnabled(nowPoints2, false)
	GUI:setTag(nowPoints2, 0)

	-- Create allPoints2
	local allPoints2 = GUI:Text_Create(midNode2, "allPoints2", 678, 80, 16, "#ffffff", [[累计积分：0]])
	GUI:Text_enableOutline(allPoints2, "#000000", 1)
	GUI:setAnchorPoint(allPoints2, 0.00, 0.00)
	GUI:setTouchEnabled(allPoints2, false)
	GUI:setTag(allPoints2, 0)

	-- Create rankPoints2
	local rankPoints2 = GUI:Text_Create(midNode2, "rankPoints2", 542, 47, 16, "#00ffff", [[榜单积分：0≥588时计入排行]])
	GUI:Text_enableOutline(rankPoints2, "#000000", 1)
	GUI:setAnchorPoint(rankPoints2, 0.00, 0.00)
	GUI:setTouchEnabled(rankPoints2, false)
	GUI:setTag(rankPoints2, 0)

	-- Create midNode3
	local midNode3 = GUI:Node_Create(FrameBG, "midNode3", 0, 0)
	GUI:setTag(midNode3, 0)
	GUI:setVisible(midNode3, false)

	-- Create upNode3
	local upNode3 = GUI:Node_Create(midNode3, "upNode3", 437, 298)
	GUI:setTag(upNode3, 0)

	-- Create upImg31
	local upImg31 = GUI:Image_Create(upNode3, "upImg31", 0, 0, "res/custom/npc/71bz/3/yslb.png")
	GUI:setContentSize(upImg31, 239, 250)
	GUI:setIgnoreContentAdaptWithSize(upImg31, false)
	GUI:setAnchorPoint(upImg31, 0.00, 0.00)
	GUI:setTouchEnabled(upImg31, false)
	GUI:setTag(upImg31, 0)

	-- Create item311
	local item311 = GUI:ItemShow_Create(upImg31, "item311", 120, 178, {index = 10480, count = 3, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item311, 0.50, 0.50)
	GUI:setTag(item311, 0)

	-- Create item312
	local item312 = GUI:ItemShow_Create(upImg31, "item312", 84, 110, {index = 20, count = 190, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item312, 0.50, 0.50)
	GUI:setTag(item312, 0)

	-- Create item313
	local item313 = GUI:ItemShow_Create(upImg31, "item313", 157, 110, {index = 10475, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item313, 0.50, 0.50)
	GUI:setTag(item313, 0)

	-- Create upText31
	local upText31 = GUI:Text_Create(upImg31, "upText31", 105, 64, 16, "#ffffff", [[售价：]])
	GUI:Text_enableOutline(upText31, "#000000", 1)
	GUI:setAnchorPoint(upText31, 0.50, 0.50)
	GUI:setTouchEnabled(upText31, false)
	GUI:setTag(upText31, 0)

	-- Create upPrice31
	local upPrice31 = GUI:Text_Create(upText31, "upPrice31", 47, 0, 16, "#ffff00", [[19元]])
	GUI:Text_enableOutline(upPrice31, "#000000", 1)
	GUI:setAnchorPoint(upPrice31, 0.00, 0.00)
	GUI:setTouchEnabled(upPrice31, false)
	GUI:setTag(upPrice31, 0)

	-- Create sellBtn31
	local sellBtn31 = GUI:Button_Create(upImg31, "sellBtn31", 122, 28, "res/custom/npc/71bz/3/buy.png")
	GUI:setContentSize(sellBtn31, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(sellBtn31, false)
	GUI:Button_setTitleText(sellBtn31, [[]])
	GUI:Button_setTitleColor(sellBtn31, "#ffffff")
	GUI:Button_setTitleFontSize(sellBtn31, 16)
	GUI:Button_titleEnableOutline(sellBtn31, "#000000", 1)
	GUI:setAnchorPoint(sellBtn31, 0.50, 0.50)
	GUI:setTouchEnabled(sellBtn31, true)
	GUI:setTag(sellBtn31, 0)

	-- Create upImg32
	local upImg32 = GUI:Image_Create(upNode3, "upImg32", 0, 0, "res/custom/npc/71bz/3/cflb.png")
	GUI:setContentSize(upImg32, 239, 250)
	GUI:setIgnoreContentAdaptWithSize(upImg32, false)
	GUI:setAnchorPoint(upImg32, 0.00, 0.00)
	GUI:setTouchEnabled(upImg32, false)
	GUI:setTag(upImg32, 0)

	-- Create item321
	local item321 = GUI:ItemShow_Create(upImg32, "item321", 120, 178, {index = 10481, count = 3, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item321, 0.50, 0.50)
	GUI:setTag(item321, 0)

	-- Create item322
	local item322 = GUI:ItemShow_Create(upImg32, "item322", 84, 110, {index = 20, count = 190, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item322, 0.50, 0.50)
	GUI:setTag(item322, 0)

	-- Create item323
	local item323 = GUI:ItemShow_Create(upImg32, "item323", 157, 110, {index = 10475, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item323, 0.50, 0.50)
	GUI:setTag(item323, 0)

	-- Create upText32
	local upText32 = GUI:Text_Create(upImg32, "upText32", 105, 64, 16, "#ffffff", [[售价：]])
	GUI:Text_enableOutline(upText32, "#000000", 1)
	GUI:setAnchorPoint(upText32, 0.50, 0.50)
	GUI:setTouchEnabled(upText32, false)
	GUI:setTag(upText32, 0)

	-- Create upPrice32
	local upPrice32 = GUI:Text_Create(upText32, "upPrice32", 47, 0, 16, "#ffff00", [[19元]])
	GUI:Text_enableOutline(upPrice32, "#000000", 1)
	GUI:setAnchorPoint(upPrice32, 0.00, 0.00)
	GUI:setTouchEnabled(upPrice32, false)
	GUI:setTag(upPrice32, 0)

	-- Create sellBtn32
	local sellBtn32 = GUI:Button_Create(upImg32, "sellBtn32", 123, 28, "res/custom/npc/71bz/3/buy.png")
	GUI:setContentSize(sellBtn32, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(sellBtn32, false)
	GUI:Button_setTitleText(sellBtn32, [[]])
	GUI:Button_setTitleColor(sellBtn32, "#ffffff")
	GUI:Button_setTitleFontSize(sellBtn32, 16)
	GUI:Button_titleEnableOutline(sellBtn32, "#000000", 1)
	GUI:setAnchorPoint(sellBtn32, 0.50, 0.50)
	GUI:setTouchEnabled(sellBtn32, true)
	GUI:setTag(sellBtn32, 0)

	-- Create upImg33
	local upImg33 = GUI:Image_Create(upNode3, "upImg33", 0, 0, "res/custom/npc/71bz/3/gylb.png")
	GUI:setContentSize(upImg33, 239, 250)
	GUI:setIgnoreContentAdaptWithSize(upImg33, false)
	GUI:setAnchorPoint(upImg33, 0.00, 0.00)
	GUI:setTouchEnabled(upImg33, false)
	GUI:setTag(upImg33, 0)

	-- Create item331
	local item331 = GUI:ItemShow_Create(upImg33, "item331", 120, 178, {index = 10479, count = 3, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item331, 0.50, 0.50)
	GUI:setTag(item331, 0)

	-- Create item332
	local item332 = GUI:ItemShow_Create(upImg33, "item332", 84, 110, {index = 20, count = 190, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item332, 0.50, 0.50)
	GUI:setTag(item332, 0)

	-- Create item333
	local item333 = GUI:ItemShow_Create(upImg33, "item333", 157, 110, {index = 10475, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item333, 0.50, 0.50)
	GUI:setTag(item333, 0)

	-- Create upText33
	local upText33 = GUI:Text_Create(upImg33, "upText33", 105, 64, 16, "#ffffff", [[售价：]])
	GUI:Text_enableOutline(upText33, "#000000", 1)
	GUI:setAnchorPoint(upText33, 0.50, 0.50)
	GUI:setTouchEnabled(upText33, false)
	GUI:setTag(upText33, 0)

	-- Create upPrice33
	local upPrice33 = GUI:Text_Create(upText33, "upPrice33", 47, 0, 16, "#ffff00", [[19元]])
	GUI:Text_enableOutline(upPrice33, "#000000", 1)
	GUI:setAnchorPoint(upPrice33, 0.00, 0.00)
	GUI:setTouchEnabled(upPrice33, false)
	GUI:setTag(upPrice33, 0)

	-- Create sellBtn33
	local sellBtn33 = GUI:Button_Create(upImg33, "sellBtn33", 122, 28, "res/custom/npc/71bz/3/buy.png")
	GUI:setContentSize(sellBtn33, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(sellBtn33, false)
	GUI:Button_setTitleText(sellBtn33, [[]])
	GUI:Button_setTitleColor(sellBtn33, "#ffffff")
	GUI:Button_setTitleFontSize(sellBtn33, 16)
	GUI:Button_titleEnableOutline(sellBtn33, "#000000", 1)
	GUI:setAnchorPoint(sellBtn33, 0.50, 0.50)
	GUI:setTouchEnabled(sellBtn33, true)
	GUI:setTag(sellBtn33, 0)

	-- Create downNode3
	local downNode3 = GUI:Node_Create(midNode3, "downNode3", 436, 104)
	GUI:setTag(downNode3, 0)

	-- Create downImg31
	local downImg31 = GUI:Image_Create(downNode3, "downImg31", 0, 0, "res/custom/npc/71bz/3/xlhs.png")
	GUI:setContentSize(downImg31, 359, 137)
	GUI:setIgnoreContentAdaptWithSize(downImg31, false)
	GUI:setAnchorPoint(downImg31, 0.00, 0.00)
	GUI:setTouchEnabled(downImg31, false)
	GUI:setTag(downImg31, 0)

	-- Create item34
	local item34 = GUI:ItemShow_Create(downImg31, "item34", 52, 50, {index = 10477, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item34, 0.50, 0.50)
	GUI:setTag(item34, 0)

	-- Create downText31
	local downText31 = GUI:Text_Create(downImg31, "downText31", 112, 48, 16, "#ffffff", [[售价：]])
	GUI:Text_enableOutline(downText31, "#000000", 1)
	GUI:setAnchorPoint(downText31, 0.50, 0.50)
	GUI:setTouchEnabled(downText31, false)
	GUI:setTag(downText31, 0)

	-- Create downPrice31
	local downPrice31 = GUI:Text_Create(downText31, "downPrice31", 47, 0, 16, "#ffff00", [[元宝×100万]])
	GUI:Text_enableOutline(downPrice31, "#000000", 1)
	GUI:setAnchorPoint(downPrice31, 0.00, 0.00)
	GUI:setTouchEnabled(downPrice31, false)
	GUI:setTag(downPrice31, 0)

	-- Create sellBtn34
	local sellBtn34 = GUI:Button_Create(downImg31, "sellBtn34", 288, 48, "res/custom/npc/71bz/3/buy.png")
	GUI:setContentSize(sellBtn34, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(sellBtn34, false)
	GUI:Button_setTitleText(sellBtn34, [[]])
	GUI:Button_setTitleColor(sellBtn34, "#ffffff")
	GUI:Button_setTitleFontSize(sellBtn34, 16)
	GUI:Button_titleEnableOutline(sellBtn34, "#000000", 1)
	GUI:setAnchorPoint(sellBtn34, 0.50, 0.50)
	GUI:setTouchEnabled(sellBtn34, true)
	GUI:setTag(sellBtn34, 0)

	-- Create downImg32
	local downImg32 = GUI:Image_Create(downNode3, "downImg32", 0, 0, "res/custom/npc/71bz/3/fyll.png")
	GUI:setContentSize(downImg32, 359, 137)
	GUI:setIgnoreContentAdaptWithSize(downImg32, false)
	GUI:setAnchorPoint(downImg32, 0.00, 0.00)
	GUI:setTouchEnabled(downImg32, false)
	GUI:setTag(downImg32, 0)

	-- Create item35
	local item35 = GUI:ItemShow_Create(downImg32, "item35", 52, 50, {index = 10478, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item35, 0.50, 0.50)
	GUI:setTag(item35, 0)

	-- Create downText32
	local downText32 = GUI:Text_Create(downImg32, "downText32", 112, 48, 16, "#ffffff", [[售价：]])
	GUI:Text_enableOutline(downText32, "#000000", 1)
	GUI:setAnchorPoint(downText32, 0.50, 0.50)
	GUI:setTouchEnabled(downText32, false)
	GUI:setTag(downText32, 0)

	-- Create downPrice32
	local downPrice32 = GUI:Text_Create(downText32, "downPrice32", 47, 0, 16, "#ffff00", [[灵符×100]])
	GUI:Text_enableOutline(downPrice32, "#000000", 1)
	GUI:setAnchorPoint(downPrice32, 0.00, 0.00)
	GUI:setTouchEnabled(downPrice32, false)
	GUI:setTag(downPrice32, 0)

	-- Create sellBtn35
	local sellBtn35 = GUI:Button_Create(downImg32, "sellBtn35", 288, 48, "res/custom/npc/71bz/3/buy.png")
	GUI:setContentSize(sellBtn35, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(sellBtn35, false)
	GUI:Button_setTitleText(sellBtn35, [[]])
	GUI:Button_setTitleColor(sellBtn35, "#ffffff")
	GUI:Button_setTitleFontSize(sellBtn35, 16)
	GUI:Button_titleEnableOutline(sellBtn35, "#000000", 1)
	GUI:setAnchorPoint(sellBtn35, 0.50, 0.50)
	GUI:setTouchEnabled(sellBtn35, true)
	GUI:setTag(sellBtn35, 0)

	-- Create mask3
	local mask3 = GUI:Layout_Create(midNode3, "mask3", 402, 268, 1136, 640, false)
	GUI:setAnchorPoint(mask3, 0.50, 0.50)
	GUI:setTouchEnabled(mask3, true)
	GUI:setTag(mask3, 0)
	GUI:setVisible(mask3, false)

	-- Create timeBox3
	local timeBox3 = GUI:Image_Create(mask3, "timeBox3", 620, 320, "res/public/1900000600.png")
	GUI:Image_setScale9Slice(timeBox3, 0, 0, 0, 0)
	GUI:setContentSize(timeBox3, 450, 200)
	GUI:setIgnoreContentAdaptWithSize(timeBox3, false)
	GUI:setAnchorPoint(timeBox3, 0.50, 0.50)
	GUI:setTouchEnabled(timeBox3, true)
	GUI:setTag(timeBox3, 0)

	-- Create copyText3
	local copyText3 = GUI:Text_Create(timeBox3, "copyText3", 224, 140, 18, "#ffff00", [[礼包价格：19元]])
	GUI:Text_enableOutline(copyText3, "#000000", 1)
	GUI:setAnchorPoint(copyText3, 0.50, 0.50)
	GUI:setTouchEnabled(copyText3, false)
	GUI:setTag(copyText3, 0)

	-- Create buyBtn3_1
	local buyBtn3_1 = GUI:Button_Create(timeBox3, "buyBtn3_1", 92, 52, "res/custom/bt_dz.png")
	GUI:setContentSize(buyBtn3_1, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(buyBtn3_1, false)
	GUI:Button_setTitleText(buyBtn3_1, [[购买1次]])
	GUI:Button_setTitleColor(buyBtn3_1, "#f8e6c6")
	GUI:Button_setTitleFontSize(buyBtn3_1, 16)
	GUI:Button_titleEnableOutline(buyBtn3_1, "#000000", 1)
	GUI:setAnchorPoint(buyBtn3_1, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn3_1, true)
	GUI:setTag(buyBtn3_1, 0)

	-- Create buyBtn3_2
	local buyBtn3_2 = GUI:Button_Create(timeBox3, "buyBtn3_2", 230, 52, "res/custom/bt_dz.png")
	GUI:setContentSize(buyBtn3_2, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(buyBtn3_2, false)
	GUI:Button_setTitleText(buyBtn3_2, [[购买10次]])
	GUI:Button_setTitleColor(buyBtn3_2, "#f8e6c6")
	GUI:Button_setTitleFontSize(buyBtn3_2, 16)
	GUI:Button_titleEnableOutline(buyBtn3_2, "#000000", 1)
	GUI:setAnchorPoint(buyBtn3_2, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn3_2, true)
	GUI:setTag(buyBtn3_2, 0)

	-- Create buyBtn3_3
	local buyBtn3_3 = GUI:Button_Create(timeBox3, "buyBtn3_3", 368, 52, "res/custom/bt_dz.png")
	GUI:setContentSize(buyBtn3_3, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(buyBtn3_3, false)
	GUI:Button_setTitleText(buyBtn3_3, [[购买100次]])
	GUI:Button_setTitleColor(buyBtn3_3, "#f8e6c6")
	GUI:Button_setTitleFontSize(buyBtn3_3, 16)
	GUI:Button_titleEnableOutline(buyBtn3_3, "#000000", 1)
	GUI:setAnchorPoint(buyBtn3_3, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn3_3, true)
	GUI:setTag(buyBtn3_3, 0)

	-- Create maskCloseBtn3
	local maskCloseBtn3 = GUI:Button_Create(timeBox3, "maskCloseBtn3", 484, 200, "res/custom/closeBtn.png")
	GUI:setContentSize(maskCloseBtn3, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(maskCloseBtn3, false)
	GUI:Button_setTitleText(maskCloseBtn3, [[]])
	GUI:Button_setTitleColor(maskCloseBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(maskCloseBtn3, 16)
	GUI:Button_titleEnableOutline(maskCloseBtn3, "#000000", 1)
	GUI:setAnchorPoint(maskCloseBtn3, 1.00, 1.00)
	GUI:setTouchEnabled(maskCloseBtn3, true)
	GUI:setTag(maskCloseBtn3, 0)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 818, 488, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.00, 0.00)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
