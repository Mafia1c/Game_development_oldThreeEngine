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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 114, 50, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create LayoutBg
	local LayoutBg = GUI:Image_Create(FrameLayout, "LayoutBg", 0, 0, "res/custom/npc/67qh/bg.png")
	GUI:setAnchorPoint(LayoutBg, 0.00, 0.00)
	GUI:setTouchEnabled(LayoutBg, true)
	GUI:setMouseEnabled(LayoutBg, true)
	GUI:setTag(LayoutBg, 0)

	-- Create leftNode
	local leftNode = GUI:Node_Create(LayoutBg, "leftNode", 0, 0)
	GUI:setTag(leftNode, 0)

	-- Create allStarText
	local allStarText = GUI:Text_Create(leftNode, "allStarText", 280, 425, 18, "#00ff00", [[0级]])
	GUI:Text_enableOutline(allStarText, "#000000", 1)
	GUI:setAnchorPoint(allStarText, 0.00, 0.00)
	GUI:setTouchEnabled(allStarText, false)
	GUI:setTag(allStarText, 0)

	-- Create buffText
	local buffText = GUI:Text_Create(leftNode, "buffText", 240, 408, 16, "#ff0000", [[等级BUFF为79级生效]])
	GUI:Text_setTextHorizontalAlignment(buffText, 1)
	GUI:Text_enableOutline(buffText, "#000000", 1)
	GUI:setAnchorPoint(buffText, 0.50, 0.50)
	GUI:setTouchEnabled(buffText, false)
	GUI:setTag(buffText, 0)

	-- Create equipListNode1
	local equipListNode1 = GUI:Node_Create(leftNode, "equipListNode1", 116, 240)
	GUI:setTag(equipListNode1, 0)

	-- Create equipBox1
	local equipBox1 = GUI:Image_Create(equipListNode1, "equipBox1", 0, 0, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(equipBox1, 0.50, 0.50)
	GUI:setTouchEnabled(equipBox1, true)
	GUI:setTag(equipBox1, 0)

	-- Create equipBox2
	local equipBox2 = GUI:Image_Create(equipListNode1, "equipBox2", 0, 0, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(equipBox2, 0.50, 0.50)
	GUI:setTouchEnabled(equipBox2, true)
	GUI:setTag(equipBox2, 0)

	-- Create equipBox3
	local equipBox3 = GUI:Image_Create(equipListNode1, "equipBox3", 0, 0, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(equipBox3, 0.50, 0.50)
	GUI:setTouchEnabled(equipBox3, true)
	GUI:setTag(equipBox3, 0)

	-- Create equipBox4
	local equipBox4 = GUI:Image_Create(equipListNode1, "equipBox4", 0, 0, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(equipBox4, 0.50, 0.50)
	GUI:setTouchEnabled(equipBox4, true)
	GUI:setTag(equipBox4, 0)

	-- Create equipListNode2
	local equipListNode2 = GUI:Node_Create(leftNode, "equipListNode2", 378, 240)
	GUI:setTag(equipListNode2, 0)

	-- Create equipBox5
	local equipBox5 = GUI:Image_Create(equipListNode2, "equipBox5", 0, 0, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(equipBox5, 0.50, 0.50)
	GUI:setTouchEnabled(equipBox5, true)
	GUI:setTag(equipBox5, 0)

	-- Create equipBox6
	local equipBox6 = GUI:Image_Create(equipListNode2, "equipBox6", 0, 0, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(equipBox6, 0.50, 0.50)
	GUI:setTouchEnabled(equipBox6, true)
	GUI:setTag(equipBox6, 0)

	-- Create equipBox7
	local equipBox7 = GUI:Image_Create(equipListNode2, "equipBox7", 0, 0, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(equipBox7, 0.50, 0.50)
	GUI:setTouchEnabled(equipBox7, true)
	GUI:setTag(equipBox7, 0)

	-- Create equipBox8
	local equipBox8 = GUI:Image_Create(equipListNode2, "equipBox8", 0, 0, "res/custom/itemBox2.png")
	GUI:setAnchorPoint(equipBox8, 0.50, 0.50)
	GUI:setTouchEnabled(equipBox8, true)
	GUI:setTag(equipBox8, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(LayoutBg, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create nowName
	local nowName = GUI:Text_Create(rightNode, "nowName", 616, 376, 16, "#ffff00", [[]])
	GUI:Text_enableOutline(nowName, "#000000", 1)
	GUI:setAnchorPoint(nowName, 0.50, 0.50)
	GUI:setTouchEnabled(nowName, false)
	GUI:setTag(nowName, 0)

	-- Create tipsBtn
	local tipsBtn = GUI:Button_Create(rightNode, "tipsBtn", 800, 483, "res/custom/suitBtn1.png")
	GUI:setContentSize(tipsBtn, 65, 51)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn, false)
	GUI:Button_setTitleText(tipsBtn, [[]])
	GUI:Button_setTitleColor(tipsBtn, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn, 16)
	GUI:Button_titleEnableOutline(tipsBtn, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn, 1.00, 1.00)
	GUI:setTouchEnabled(tipsBtn, true)
	GUI:setTag(tipsBtn, 0)

	-- Create infoNode1
	local infoNode1 = GUI:Node_Create(rightNode, "infoNode1", 514, 300)
	GUI:setTag(infoNode1, 0)

	-- Create infoText11
	local infoText11 = GUI:Text_Create(infoNode1, "infoText11", 16, 12, 16, "#ffffff", [[暂无：0%]])
	GUI:Text_enableOutline(infoText11, "#000000", 1)
	GUI:setAnchorPoint(infoText11, 0.50, 0.50)
	GUI:setTouchEnabled(infoText11, false)
	GUI:setTag(infoText11, 0)

	-- Create infoText12
	local infoText12 = GUI:Text_Create(infoNode1, "infoText12", 16, 12, 16, "#ffffff", [[暂无：0%]])
	GUI:Text_enableOutline(infoText12, "#000000", 1)
	GUI:setAnchorPoint(infoText12, 0.50, 0.50)
	GUI:setTouchEnabled(infoText12, false)
	GUI:setTag(infoText12, 0)

	-- Create infoText13
	local infoText13 = GUI:Text_Create(infoNode1, "infoText13", 16, 12, 16, "#ffffff", [[暂无：0%]])
	GUI:Text_enableOutline(infoText13, "#000000", 1)
	GUI:setAnchorPoint(infoText13, 0.50, 0.50)
	GUI:setTouchEnabled(infoText13, false)
	GUI:setTag(infoText13, 0)

	-- Create infoNode2
	local infoNode2 = GUI:Node_Create(rightNode, "infoNode2", 714, 300)
	GUI:setTag(infoNode2, 0)

	-- Create infoText21
	local infoText21 = GUI:Text_Create(infoNode2, "infoText21", 16, 12, 16, "#ff00ff", [[暂无：0%]])
	GUI:Text_enableOutline(infoText21, "#000000", 1)
	GUI:setAnchorPoint(infoText21, 0.50, 0.50)
	GUI:setTouchEnabled(infoText21, false)
	GUI:setTag(infoText21, 0)

	-- Create infoText22
	local infoText22 = GUI:Text_Create(infoNode2, "infoText22", 16, 12, 16, "#ff00ff", [[暂无：0%]])
	GUI:Text_enableOutline(infoText22, "#000000", 1)
	GUI:setAnchorPoint(infoText22, 0.50, 0.50)
	GUI:setTouchEnabled(infoText22, false)
	GUI:setTag(infoText22, 0)

	-- Create infoText23
	local infoText23 = GUI:Text_Create(infoNode2, "infoText23", 16, 12, 16, "#ff00ff", [[暂无：0%]])
	GUI:Text_enableOutline(infoText23, "#000000", 1)
	GUI:setAnchorPoint(infoText23, 0.50, 0.50)
	GUI:setTouchEnabled(infoText23, false)
	GUI:setTag(infoText23, 0)

	-- Create oddsText
	local oddsText = GUI:Text_Create(rightNode, "oddsText", 608, 244, 16, "#ffffff", [[本次强化成功率：]])
	GUI:Text_enableOutline(oddsText, "#000000", 1)
	GUI:setAnchorPoint(oddsText, 0.50, 0.50)
	GUI:setTouchEnabled(oddsText, false)
	GUI:setTag(oddsText, 0)

	-- Create oddsNumber
	local oddsNumber = GUI:Text_Create(oddsText, "oddsNumber", 126, 0, 16, "#00ff00", [[100%]])
	GUI:Text_enableOutline(oddsNumber, "#000000", 1)
	GUI:setAnchorPoint(oddsNumber, 0.00, 0.00)
	GUI:setTouchEnabled(oddsNumber, false)
	GUI:setTag(oddsNumber, 0)

	-- Create needBox
	local needBox = GUI:Layout_Create(rightNode, "needBox", 618, 196, 60, 60, false)
	GUI:setAnchorPoint(needBox, 0.50, 0.50)
	GUI:setTouchEnabled(needBox, false)
	GUI:setTag(needBox, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightNode, "upBtn", 616, 136, "res/custom/bt_dz.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始强化]])
	GUI:Button_setTitleColor(upBtn, "#e8dcbd")
	GUI:Button_setTitleFontSize(upBtn, 16)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create checkBtn
	local checkBtn = GUI:Button_Create(rightNode, "checkBtn", 470, 82, "res/public/1900000550.png")
	GUI:setContentSize(checkBtn, 29, 28)
	GUI:setIgnoreContentAdaptWithSize(checkBtn, false)
	GUI:Button_setTitleText(checkBtn, [[]])
	GUI:Button_setTitleColor(checkBtn, "#ffffff")
	GUI:Button_setTitleFontSize(checkBtn, 16)
	GUI:Button_titleEnableOutline(checkBtn, "#000000", 1)
	GUI:setAnchorPoint(checkBtn, 0.00, 0.00)
	GUI:setTouchEnabled(checkBtn, true)
	GUI:setTag(checkBtn, 0)

	-- Create checkTips
	local checkTips = GUI:Text_Create(checkBtn, "checkTips", 30, 0, 16, "#ffff00", [[勾选使用幸运符，可增加10%的几率]])
	GUI:Text_enableOutline(checkTips, "#000000", 1)
	GUI:setAnchorPoint(checkTips, 0.00, 0.00)
	GUI:setTouchEnabled(checkTips, false)
	GUI:setTag(checkTips, 0)

	-- Create tipsText1
	local tipsText1 = GUI:Text_Create(LayoutBg, "tipsText1", 192, 52, 16, "#ffff00", [[提示：仅解封神器可进行强化，]])
	GUI:Text_enableOutline(tipsText1, "#000000", 1)
	GUI:setAnchorPoint(tipsText1, 0.50, 0.50)
	GUI:setTouchEnabled(tipsText1, false)
	GUI:setTag(tipsText1, 0)

	-- Create tipsText2
	local tipsText2 = GUI:Text_Create(tipsText1, "tipsText2", 224, 0, 16, "#00ff00", [[强化失败时等级降低1级(使用幸运符可不掉级)！]])
	GUI:Text_enableOutline(tipsText2, "#000000", 1)
	GUI:setAnchorPoint(tipsText2, 0.00, 0.00)
	GUI:setTouchEnabled(tipsText2, false)
	GUI:setTag(tipsText2, 0)

	-- Create buyBtn
	local buyBtn = GUI:Button_Create(LayoutBg, "buyBtn", 728, 53, "res/custom/yeqian1.png")
	GUI:setContentSize(buyBtn, 114, 36)
	GUI:setIgnoreContentAdaptWithSize(buyBtn, false)
	GUI:Button_setTitleText(buyBtn, [[快捷购买]])
	GUI:Button_setTitleColor(buyBtn, "#e8dcbd")
	GUI:Button_setTitleFontSize(buyBtn, 16)
	GUI:Button_titleEnableOutline(buyBtn, "#000000", 1)
	GUI:setAnchorPoint(buyBtn, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn, true)
	GUI:setTag(buyBtn, 0)

	-- Create mask
	local mask = GUI:Layout_Create(LayoutBg, "mask", 456, 268, 1136, 640, false)
	GUI:setAnchorPoint(mask, 0.50, 0.50)
	GUI:setTouchEnabled(mask, true)
	GUI:setTag(mask, 0)
	GUI:setVisible(mask, false)

	-- Create copyMapBox
	local copyMapBox = GUI:Image_Create(mask, "copyMapBox", 560, 322, "res/public/1900000600.png")
	GUI:setAnchorPoint(copyMapBox, 0.50, 0.50)
	GUI:setTouchEnabled(copyMapBox, true)
	GUI:setTag(copyMapBox, 0)

	-- Create copyText1
	local copyText1 = GUI:Text_Create(copyMapBox, "copyText1", 110, 116, 16, "#ffff00", [[强化增益包]])
	GUI:Text_enableOutline(copyText1, "#000000", 1)
	GUI:setAnchorPoint(copyText1, 0.00, 0.00)
	GUI:setTouchEnabled(copyText1, false)
	GUI:setTag(copyText1, 0)

	-- Create copyText2
	local copyText2 = GUI:Text_Create(copyMapBox, "copyText2", 110, 96, 16, "#00ff00", [[价格：20元]])
	GUI:Text_enableOutline(copyText2, "#000000", 1)
	GUI:setAnchorPoint(copyText2, 0.00, 0.00)
	GUI:setTouchEnabled(copyText2, false)
	GUI:setTag(copyText2, 0)

	-- Create copyItem1
	local copyItem1 = GUI:ItemShow_Create(copyMapBox, "copyItem1", 108, 58, {index = 10468, count = 5, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(copyItem1, 0.50, 0.50)
	GUI:setTag(copyItem1, 0)

	-- Create copyItem2
	local copyItem2 = GUI:ItemShow_Create(copyMapBox, "copyItem2", 186, 58, {index = 10378, count = 10, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(copyItem2, 0.50, 0.50)
	GUI:setTag(copyItem2, 0)

	-- Create buyBtn1
	local buyBtn1 = GUI:Button_Create(copyMapBox, "buyBtn1", 352, 138, "res/custom/buyBtn1.png")
	GUI:setContentSize(buyBtn1, 124, 50)
	GUI:setIgnoreContentAdaptWithSize(buyBtn1, false)
	GUI:Button_setTitleText(buyBtn1, [[]])
	GUI:Button_setTitleColor(buyBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn1, 16)
	GUI:Button_titleEnableOutline(buyBtn1, "#000000", 1)
	GUI:setAnchorPoint(buyBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn1, true)
	GUI:setTag(buyBtn1, 0)

	-- Create buyBtn10
	local buyBtn10 = GUI:Button_Create(copyMapBox, "buyBtn10", 352, 88, "res/custom/buyBtn10.png")
	GUI:setContentSize(buyBtn10, 124, 50)
	GUI:setIgnoreContentAdaptWithSize(buyBtn10, false)
	GUI:Button_setTitleText(buyBtn10, [[]])
	GUI:Button_setTitleColor(buyBtn10, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn10, 16)
	GUI:Button_titleEnableOutline(buyBtn10, "#000000", 1)
	GUI:setAnchorPoint(buyBtn10, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn10, true)
	GUI:setTag(buyBtn10, 0)

	-- Create buyBtn100
	local buyBtn100 = GUI:Button_Create(copyMapBox, "buyBtn100", 352, 40, "res/custom/buyBtn100.png")
	GUI:setContentSize(buyBtn100, 124, 50)
	GUI:setIgnoreContentAdaptWithSize(buyBtn100, false)
	GUI:Button_setTitleText(buyBtn100, [[]])
	GUI:Button_setTitleColor(buyBtn100, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn100, 16)
	GUI:Button_titleEnableOutline(buyBtn100, "#000000", 1)
	GUI:setAnchorPoint(buyBtn100, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn100, true)
	GUI:setTag(buyBtn100, 0)

	-- Create maskCloseBtn
	local maskCloseBtn = GUI:Button_Create(copyMapBox, "maskCloseBtn", 484, 178, "res/custom/closeBtn.png")
	GUI:setContentSize(maskCloseBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(maskCloseBtn, false)
	GUI:Button_setTitleText(maskCloseBtn, [[]])
	GUI:Button_setTitleColor(maskCloseBtn, "#ffffff")
	GUI:Button_setTitleFontSize(maskCloseBtn, 16)
	GUI:Button_titleEnableOutline(maskCloseBtn, "#000000", 1)
	GUI:setAnchorPoint(maskCloseBtn, 1.00, 1.00)
	GUI:setTouchEnabled(maskCloseBtn, true)
	GUI:setTag(maskCloseBtn, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(LayoutBg, "closeBtn", 854, 522, "res/custom/closeBtn.png")
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
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
