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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 76)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 590, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/69mj/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create leftNode
	local leftNode = GUI:Node_Create(FrameBG, "leftNode", 130, 276)
	GUI:setTag(leftNode, 0)

	-- Create leftLayout1
	local leftLayout1 = GUI:Layout_Create(leftNode, "leftLayout1", -30, -25, 60, 60, false)
	GUI:setAnchorPoint(leftLayout1, 0.00, 0.00)
	GUI:setTouchEnabled(leftLayout1, true)
	GUI:setMouseEnabled(leftLayout1, true)
	GUI:setTag(leftLayout1, 0)

	-- Create leftBg1
	local leftBg1 = GUI:Image_Create(leftLayout1, "leftBg1", 31, -16, "res/custom/npc/69mj/d.png")
	GUI:Image_setScale9Slice(leftBg1, 9, 9, 8, 8)
	GUI:setContentSize(leftBg1, 98, 24)
	GUI:setIgnoreContentAdaptWithSize(leftBg1, false)
	GUI:setAnchorPoint(leftBg1, 0.50, 0.50)
	GUI:setTouchEnabled(leftBg1, false)
	GUI:setTag(leftBg1, 0)

	-- Create leftName1
	local leftName1 = GUI:Text_Create(leftBg1, "leftName1", 50, 12, 16, "#ff0000", [[紫气东来]])
	GUI:Text_enableOutline(leftName1, "#000000", 1)
	GUI:setAnchorPoint(leftName1, 0.50, 0.50)
	GUI:setTouchEnabled(leftName1, false)
	GUI:setTag(leftName1, 0)

	-- Create leftEquip1
	local leftEquip1 = GUI:ItemShow_Create(leftLayout1, "leftEquip1", 30, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(leftEquip1, 0.50, 0.50)
	GUI:setTag(leftEquip1, 0)

	-- Create leftLayout2
	local leftLayout2 = GUI:Layout_Create(leftNode, "leftLayout2", -30, -25, 60, 60, false)
	GUI:setAnchorPoint(leftLayout2, 0.00, 0.00)
	GUI:setTouchEnabled(leftLayout2, true)
	GUI:setMouseEnabled(leftLayout2, true)
	GUI:setTag(leftLayout2, 0)

	-- Create leftEquip2
	local leftEquip2 = GUI:ItemShow_Create(leftLayout2, "leftEquip2", 30, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(leftEquip2, 0.50, 0.50)
	GUI:setTag(leftEquip2, 0)

	-- Create leftBg2
	local leftBg2 = GUI:Image_Create(leftLayout2, "leftBg2", 31, -16, "res/custom/npc/69mj/d.png")
	GUI:Image_setScale9Slice(leftBg2, 9, 9, 8, 8)
	GUI:setContentSize(leftBg2, 98, 24)
	GUI:setIgnoreContentAdaptWithSize(leftBg2, false)
	GUI:setAnchorPoint(leftBg2, 0.50, 0.50)
	GUI:setTouchEnabled(leftBg2, false)
	GUI:setTag(leftBg2, 0)

	-- Create leftName2
	local leftName2 = GUI:Text_Create(leftBg2, "leftName2", 50, 12, 16, "#ff0000", [[兵临城下]])
	GUI:Text_enableOutline(leftName2, "#000000", 1)
	GUI:setAnchorPoint(leftName2, 0.50, 0.50)
	GUI:setTouchEnabled(leftName2, false)
	GUI:setTag(leftName2, 0)

	-- Create leftLayout3
	local leftLayout3 = GUI:Layout_Create(leftNode, "leftLayout3", -30, -25, 60, 60, false)
	GUI:setAnchorPoint(leftLayout3, 0.00, 0.00)
	GUI:setTouchEnabled(leftLayout3, true)
	GUI:setMouseEnabled(leftLayout3, true)
	GUI:setTag(leftLayout3, 0)

	-- Create leftBg3
	local leftBg3 = GUI:Image_Create(leftLayout3, "leftBg3", 31, -16, "res/custom/npc/69mj/d.png")
	GUI:Image_setScale9Slice(leftBg3, 9, 9, 8, 8)
	GUI:setContentSize(leftBg3, 98, 24)
	GUI:setIgnoreContentAdaptWithSize(leftBg3, false)
	GUI:setAnchorPoint(leftBg3, 0.50, 0.50)
	GUI:setTouchEnabled(leftBg3, false)
	GUI:setTag(leftBg3, 0)

	-- Create leftName3
	local leftName3 = GUI:Text_Create(leftBg3, "leftName3", 50, 12, 16, "#ff0000", [[金戈铁马]])
	GUI:Text_enableOutline(leftName3, "#000000", 1)
	GUI:setAnchorPoint(leftName3, 0.50, 0.50)
	GUI:setTouchEnabled(leftName3, false)
	GUI:setTag(leftName3, 0)

	-- Create leftEquip3
	local leftEquip3 = GUI:ItemShow_Create(leftLayout3, "leftEquip3", 30, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(leftEquip3, 0.50, 0.50)
	GUI:setTag(leftEquip3, 0)

	-- Create leftLayout4
	local leftLayout4 = GUI:Layout_Create(leftNode, "leftLayout4", -30, -25, 60, 60, false)
	GUI:setAnchorPoint(leftLayout4, 0.00, 0.00)
	GUI:setTouchEnabled(leftLayout4, true)
	GUI:setMouseEnabled(leftLayout4, true)
	GUI:setTag(leftLayout4, 0)

	-- Create leftEquip4
	local leftEquip4 = GUI:ItemShow_Create(leftLayout4, "leftEquip4", 30, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(leftEquip4, 0.50, 0.50)
	GUI:setTag(leftEquip4, 0)

	-- Create leftBg4
	local leftBg4 = GUI:Image_Create(leftLayout4, "leftBg4", 31, -16, "res/custom/npc/69mj/d.png")
	GUI:Image_setScale9Slice(leftBg4, 9, 9, 8, 8)
	GUI:setContentSize(leftBg4, 98, 24)
	GUI:setIgnoreContentAdaptWithSize(leftBg4, false)
	GUI:setAnchorPoint(leftBg4, 0.50, 0.50)
	GUI:setTouchEnabled(leftBg4, false)
	GUI:setTag(leftBg4, 0)

	-- Create leftName4
	local leftName4 = GUI:Text_Create(leftBg4, "leftName4", 50, 12, 16, "#ff0000", [[烽火连城]])
	GUI:Text_enableOutline(leftName4, "#000000", 1)
	GUI:setAnchorPoint(leftName4, 0.50, 0.50)
	GUI:setTouchEnabled(leftName4, false)
	GUI:setTag(leftName4, 0)

	-- Create leftTag
	local leftTag = GUI:Image_Create(leftLayout4, "leftTag", 0, 0, "res/public/1900000678_1.png")
	GUI:Image_setScale9Slice(leftTag, 8, 8, 28, 28)
	GUI:setContentSize(leftTag, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(leftTag, false)
	GUI:setAnchorPoint(leftTag, 0.00, 0.00)
	GUI:setTouchEnabled(leftTag, false)
	GUI:setTag(leftTag, 0)

	-- Create rightNode1
	local rightNode1 = GUI:Node_Create(FrameBG, "rightNode1", 0, 0)
	GUI:setTag(rightNode1, 0)

	-- Create rightBox11
	local rightBox11 = GUI:Image_Create(rightNode1, "rightBox11", 367, 421, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(rightBox11, 0.50, 0.50)
	GUI:setTouchEnabled(rightBox11, false)
	GUI:setTag(rightBox11, 0)

	-- Create item1_name1
	local item1_name1 = GUI:ItemShow_Create(rightBox11, "item1_name1", 32, 32, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(item1_name1, 0.50, 0.50)
	GUI:setTag(item1_name1, 0)

	-- Create rightBox12
	local rightBox12 = GUI:Image_Create(rightNode1, "rightBox12", 627, 421, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(rightBox12, 0.50, 0.50)
	GUI:setTouchEnabled(rightBox12, false)
	GUI:setTag(rightBox12, 0)

	-- Create item1_name2
	local item1_name2 = GUI:ItemShow_Create(rightBox12, "item1_name2", 32, 32, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(item1_name2, 0.50, 0.50)
	GUI:setTag(item1_name2, 0)

	-- Create rightBox13
	local rightBox13 = GUI:Image_Create(rightNode1, "rightBox13", 367, 285, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(rightBox13, 0.50, 0.50)
	GUI:setTouchEnabled(rightBox13, false)
	GUI:setTag(rightBox13, 0)

	-- Create item1_name3
	local item1_name3 = GUI:ItemShow_Create(rightBox13, "item1_name3", 32, 32, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(item1_name3, 0.50, 0.50)
	GUI:setTag(item1_name3, 0)

	-- Create rightBox14
	local rightBox14 = GUI:Image_Create(rightNode1, "rightBox14", 627, 285, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(rightBox14, 0.50, 0.50)
	GUI:setTouchEnabled(rightBox14, false)
	GUI:setTag(rightBox14, 0)

	-- Create item1_name4
	local item1_name4 = GUI:ItemShow_Create(rightBox14, "item1_name4", 32, 32, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(item1_name4, 0.50, 0.50)
	GUI:setTag(item1_name4, 0)

	-- Create equipNow1
	local equipNow1 = GUI:ItemShow_Create(rightNode1, "equipNow1", 498, 352, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(equipNow1, 0.50, 0.50)
	GUI:setTag(equipNow1, 0)

	-- Create needBox1
	local needBox1 = GUI:Layout_Create(rightNode1, "needBox1", 498, 210, 60, 60, false)
	GUI:setAnchorPoint(needBox1, 0.50, 0.50)
	GUI:setTouchEnabled(needBox1, false)
	GUI:setTag(needBox1, 0)

	-- Create nowName1
	local nowName1 = GUI:Text_Create(rightNode1, "nowName1", 500, 287, 16, "#ff0000", [[紫气东来]])
	GUI:Text_enableOutline(nowName1, "#000000", 1)
	GUI:setAnchorPoint(nowName1, 0.50, 0.50)
	GUI:setTouchEnabled(nowName1, false)
	GUI:setTag(nowName1, 0)

	-- Create upBtn1
	local upBtn1 = GUI:Button_Create(rightNode1, "upBtn1", 508, 137, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn1, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn1, false)
	GUI:Button_setTitleText(upBtn1, [[锻造魔戒]])
	GUI:Button_setTitleColor(upBtn1, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn1, 16)
	GUI:Button_titleEnableOutline(upBtn1, "#000000", 1)
	GUI:setAnchorPoint(upBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn1, true)
	GUI:setTag(upBtn1, 0)

	-- Create oddText11
	local oddText11 = GUI:Text_Create(rightNode1, "oddText11", 614, 136, 16, "#ffffff", [[成功几率：]])
	GUI:Text_enableOutline(oddText11, "#000000", 1)
	GUI:setAnchorPoint(oddText11, 0.50, 0.50)
	GUI:setTouchEnabled(oddText11, false)
	GUI:setTag(oddText11, 0)

	-- Create oddText12
	local oddText12 = GUI:Text_Create(oddText11, "oddText12", 74, 0, 16, "#ffff00", [[100%]])
	GUI:Text_enableOutline(oddText12, "#000000", 1)
	GUI:setAnchorPoint(oddText12, 0.00, 0.00)
	GUI:setTouchEnabled(oddText12, false)
	GUI:setTag(oddText12, 0)

	-- Create rightNode2
	local rightNode2 = GUI:Node_Create(FrameBG, "rightNode2", 0, 0)
	GUI:setTag(rightNode2, 0)
	GUI:setVisible(rightNode2, false)

	-- Create infoText21
	local infoText21 = GUI:Text_Create(rightNode2, "infoText21", 450, 467, 16, "#ffff00", [[合成龙神石]])
	GUI:Text_enableOutline(infoText21, "#000000", 1)
	GUI:setAnchorPoint(infoText21, 0.50, 0.50)
	GUI:setTouchEnabled(infoText21, false)
	GUI:setTag(infoText21, 0)

	-- Create number21
	local number21 = GUI:Text_Create(infoText21, "number21", 80, 0, 16, "#00ff00", [[×1个]])
	GUI:Text_enableOutline(number21, "#000000", 1)
	GUI:setAnchorPoint(number21, 0.00, 0.00)
	GUI:setTouchEnabled(number21, false)
	GUI:setTag(number21, 0)

	-- Create needNode21
	local needNode21 = GUI:Node_Create(infoText21, "needNode21", -78, -50)
	GUI:setTag(needNode21, 0)

	-- Create needItem2_11
	local needItem2_11 = GUI:ItemShow_Create(needNode21, "needItem2_11", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem2_11, 0.50, 0.50)
	GUI:setTag(needItem2_11, 0)

	-- Create needItem2_12
	local needItem2_12 = GUI:ItemShow_Create(needNode21, "needItem2_12", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem2_12, 0.50, 0.50)
	GUI:setTag(needItem2_12, 0)

	-- Create needItem2_13
	local needItem2_13 = GUI:ItemShow_Create(needNode21, "needItem2_13", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem2_13, 0.50, 0.50)
	GUI:setTag(needItem2_13, 0)

	-- Create resultItem21
	local resultItem21 = GUI:ItemShow_Create(infoText21, "resultItem21", 196, -50, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(resultItem21, 0.50, 0.50)
	GUI:setTag(resultItem21, 0)

	-- Create upBtn21
	local upBtn21 = GUI:Button_Create(infoText21, "upBtn21", 324, -50, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn21, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn21, false)
	GUI:Button_setTitleText(upBtn21, [[确定合成]])
	GUI:Button_setTitleColor(upBtn21, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn21, 16)
	GUI:Button_titleEnableOutline(upBtn21, "#000000", 1)
	GUI:setAnchorPoint(upBtn21, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn21, true)
	GUI:setTag(upBtn21, 0)

	-- Create infoText22
	local infoText22 = GUI:Text_Create(rightNode2, "infoText22", 450, 341, 16, "#ffff00", [[合成龙神石]])
	GUI:Text_enableOutline(infoText22, "#000000", 1)
	GUI:setAnchorPoint(infoText22, 0.50, 0.50)
	GUI:setTouchEnabled(infoText22, false)
	GUI:setTag(infoText22, 0)

	-- Create number22
	local number22 = GUI:Text_Create(infoText22, "number22", 80, 0, 16, "#00ff00", [[×10个]])
	GUI:Text_enableOutline(number22, "#000000", 1)
	GUI:setAnchorPoint(number22, 0.00, 0.00)
	GUI:setTouchEnabled(number22, false)
	GUI:setTag(number22, 0)

	-- Create needNode22
	local needNode22 = GUI:Node_Create(infoText22, "needNode22", -78, -50)
	GUI:setTag(needNode22, 0)

	-- Create needItem2_21
	local needItem2_21 = GUI:ItemShow_Create(needNode22, "needItem2_21", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem2_21, 0.50, 0.50)
	GUI:setTag(needItem2_21, 0)

	-- Create needItem2_22
	local needItem2_22 = GUI:ItemShow_Create(needNode22, "needItem2_22", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem2_22, 0.50, 0.50)
	GUI:setTag(needItem2_22, 0)

	-- Create needItem2_23
	local needItem2_23 = GUI:ItemShow_Create(needNode22, "needItem2_23", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem2_23, 0.50, 0.50)
	GUI:setTag(needItem2_23, 0)

	-- Create resultItem22
	local resultItem22 = GUI:ItemShow_Create(infoText22, "resultItem22", 196, -50, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(resultItem22, 0.50, 0.50)
	GUI:setTag(resultItem22, 0)

	-- Create upBtn22
	local upBtn22 = GUI:Button_Create(infoText22, "upBtn22", 324, -50, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn22, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn22, false)
	GUI:Button_setTitleText(upBtn22, [[确定合成]])
	GUI:Button_setTitleColor(upBtn22, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn22, 16)
	GUI:Button_titleEnableOutline(upBtn22, "#000000", 1)
	GUI:setAnchorPoint(upBtn22, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn22, true)
	GUI:setTag(upBtn22, 0)

	-- Create infoText23
	local infoText23 = GUI:Text_Create(rightNode2, "infoText23", 450, 214, 16, "#ffff00", [[合成龙神石]])
	GUI:Text_enableOutline(infoText23, "#000000", 1)
	GUI:setAnchorPoint(infoText23, 0.50, 0.50)
	GUI:setTouchEnabled(infoText23, false)
	GUI:setTag(infoText23, 0)

	-- Create number23
	local number23 = GUI:Text_Create(infoText23, "number23", 80, 0, 16, "#00ff00", [[×100个]])
	GUI:Text_enableOutline(number23, "#000000", 1)
	GUI:setAnchorPoint(number23, 0.00, 0.00)
	GUI:setTouchEnabled(number23, false)
	GUI:setTag(number23, 0)

	-- Create needNode23
	local needNode23 = GUI:Node_Create(infoText23, "needNode23", -78, -50)
	GUI:setTag(needNode23, 0)

	-- Create needItem2_31
	local needItem2_31 = GUI:ItemShow_Create(needNode23, "needItem2_31", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem2_31, 0.50, 0.50)
	GUI:setTag(needItem2_31, 0)

	-- Create needItem2_32
	local needItem2_32 = GUI:ItemShow_Create(needNode23, "needItem2_32", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem2_32, 0.50, 0.50)
	GUI:setTag(needItem2_32, 0)

	-- Create needItem2_33
	local needItem2_33 = GUI:ItemShow_Create(needNode23, "needItem2_33", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem2_33, 0.50, 0.50)
	GUI:setTag(needItem2_33, 0)

	-- Create resultItem23
	local resultItem23 = GUI:ItemShow_Create(infoText23, "resultItem23", 196, -50, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(resultItem23, 0.50, 0.50)
	GUI:setTag(resultItem23, 0)

	-- Create upBtn23
	local upBtn23 = GUI:Button_Create(infoText23, "upBtn23", 324, -50, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn23, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn23, false)
	GUI:Button_setTitleText(upBtn23, [[确定合成]])
	GUI:Button_setTitleColor(upBtn23, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn23, 16)
	GUI:Button_titleEnableOutline(upBtn23, "#000000", 1)
	GUI:setAnchorPoint(upBtn23, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn23, true)
	GUI:setTag(upBtn23, 0)

	-- Create changeBtn1
	local changeBtn1 = GUI:Button_Create(FrameBG, "changeBtn1", 666, 65, "res/custom/bt_dz.png")
	GUI:setContentSize(changeBtn1, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(changeBtn1, false)
	GUI:Button_setTitleText(changeBtn1, [[合成龙神石]])
	GUI:Button_setTitleColor(changeBtn1, "#E8DCBD")
	GUI:Button_setTitleFontSize(changeBtn1, 16)
	GUI:Button_titleEnableOutline(changeBtn1, "#000000", 1)
	GUI:setAnchorPoint(changeBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(changeBtn1, true)
	GUI:setTag(changeBtn1, 0)

	-- Create changeBtn2
	local changeBtn2 = GUI:Button_Create(FrameBG, "changeBtn2", 666, 65, "res/custom/bt_dz.png")
	GUI:setContentSize(changeBtn2, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(changeBtn2, false)
	GUI:Button_setTitleText(changeBtn2, [[锻造魔戒]])
	GUI:Button_setTitleColor(changeBtn2, "#E8DCBD")
	GUI:Button_setTitleFontSize(changeBtn2, 16)
	GUI:Button_titleEnableOutline(changeBtn2, "#000000", 1)
	GUI:setAnchorPoint(changeBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(changeBtn2, true)
	GUI:setTag(changeBtn2, 0)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 837, 504, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.50, 0.50)
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
