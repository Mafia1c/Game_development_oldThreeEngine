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
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 590, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/38cz/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create topNode
	local topNode = GUI:Node_Create(FrameBG, "topNode", 0, 0)
	GUI:setTag(topNode, 0)

	-- Create input
	local input = GUI:TextInput_Create(topNode, "input", 226, 436, 92, 24, 16)
	GUI:TextInput_setString(input, "")
	GUI:TextInput_setPlaceHolder(input, "输入金额")
	GUI:TextInput_setFontColor(input, "#ffffff")
	GUI:TextInput_setPlaceholderFontColor(input, "#a6a6a6")
	GUI:TextInput_setInputMode(input, 2)
	GUI:setAnchorPoint(input, 0.50, 0.50)
	GUI:setOpacity(input, 160)
	GUI:setTouchEnabled(input, true)
	GUI:setTag(input, 0)

	-- Create typeNode
	local typeNode = GUI:Node_Create(topNode, "typeNode", 450, 446)
	GUI:setTag(typeNode, 0)

	-- Create typeBtn1
	local typeBtn1 = GUI:Button_Create(typeNode, "typeBtn1", 0, 0, "res/public/bg_czzya_05.png")
	GUI:setContentSize(typeBtn1, 88, 33)
	GUI:setIgnoreContentAdaptWithSize(typeBtn1, false)
	GUI:Button_setTitleText(typeBtn1, [[]])
	GUI:Button_setTitleColor(typeBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn1, 16)
	GUI:Button_titleEnableOutline(typeBtn1, "#000000", 1)
	GUI:setAnchorPoint(typeBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn1, true)
	GUI:setTag(typeBtn1, 0)

	-- Create typeTag1
	local typeTag1 = GUI:Image_Create(typeBtn1, "typeTag1", 78, 22, "res/public/bg_czzya_05_1.png")
	GUI:setContentSize(typeTag1, 21, 21)
	GUI:setIgnoreContentAdaptWithSize(typeTag1, false)
	GUI:setAnchorPoint(typeTag1, 0.50, 0.50)
	GUI:setTouchEnabled(typeTag1, false)
	GUI:setTag(typeTag1, 0)

	-- Create typeBtn2
	local typeBtn2 = GUI:Button_Create(typeNode, "typeBtn2", 0, 0, "res/public/bg_czzya_06.png")
	GUI:setContentSize(typeBtn2, 88, 33)
	GUI:setIgnoreContentAdaptWithSize(typeBtn2, false)
	GUI:Button_setTitleText(typeBtn2, [[]])
	GUI:Button_setTitleColor(typeBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn2, 16)
	GUI:Button_titleEnableOutline(typeBtn2, "#000000", 1)
	GUI:setAnchorPoint(typeBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn2, true)
	GUI:setTag(typeBtn2, 0)

	-- Create typeTag2
	local typeTag2 = GUI:Image_Create(typeBtn2, "typeTag2", 78, 22, "res/public/bg_czzya_06_1.png")
	GUI:setContentSize(typeTag2, 17, 17)
	GUI:setIgnoreContentAdaptWithSize(typeTag2, false)
	GUI:setAnchorPoint(typeTag2, 0.50, 0.50)
	GUI:setTouchEnabled(typeTag2, false)
	GUI:setTag(typeTag2, 0)
	GUI:setVisible(typeTag2, false)

	-- Create typeBtn3
	local typeBtn3 = GUI:Button_Create(typeNode, "typeBtn3", 0, 0, "res/public/bg_czzya_04.png")
	GUI:setContentSize(typeBtn3, 88, 33)
	GUI:setIgnoreContentAdaptWithSize(typeBtn3, false)
	GUI:Button_setTitleText(typeBtn3, [[]])
	GUI:Button_setTitleColor(typeBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn3, 16)
	GUI:Button_titleEnableOutline(typeBtn3, "#000000", 1)
	GUI:setAnchorPoint(typeBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn3, true)
	GUI:setTag(typeBtn3, 0)

	-- Create typeTag3
	local typeTag3 = GUI:Image_Create(typeBtn3, "typeTag3", 78, 22, "res/public/bg_czzya_04_1.png")
	GUI:setContentSize(typeTag3, 20, 21)
	GUI:setIgnoreContentAdaptWithSize(typeTag3, false)
	GUI:setAnchorPoint(typeTag3, 0.50, 0.50)
	GUI:setTouchEnabled(typeTag3, false)
	GUI:setTag(typeTag3, 0)
	GUI:setVisible(typeTag3, false)

	-- Create buyBtn
	local buyBtn = GUI:Button_Create(topNode, "buyBtn", 746, 454, "res/custom/npc/38cz/cz.png")
	GUI:setContentSize(buyBtn, 82, 30)
	GUI:setIgnoreContentAdaptWithSize(buyBtn, false)
	GUI:Button_setTitleText(buyBtn, [[]])
	GUI:Button_setTitleColor(buyBtn, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn, 16)
	GUI:Button_titleEnableOutline(buyBtn, "#000000", 1)
	GUI:setAnchorPoint(buyBtn, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn, true)
	GUI:setTag(buyBtn, 0)

	-- Create midNode1
	local midNode1 = GUI:Node_Create(FrameBG, "midNode1", 436, 334)
	GUI:setTag(midNode1, 0)

	-- Create midBtn1
	local midBtn1 = GUI:Button_Create(midNode1, "midBtn1", 0, 0, "res/custom/npc/38cz/10.png")
	GUI:setContentSize(midBtn1, 230, 164)
	GUI:setIgnoreContentAdaptWithSize(midBtn1, false)
	GUI:Button_setTitleText(midBtn1, [[]])
	GUI:Button_setTitleColor(midBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(midBtn1, 16)
	GUI:Button_titleEnableOutline(midBtn1, "#000000", 1)
	GUI:setAnchorPoint(midBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(midBtn1, true)
	GUI:setTag(midBtn1, 0)

	-- Create giveImg1
	local giveImg1 = GUI:Image_Create(midBtn1, "giveImg1", 25, 38, "res/custom/npc/38cz/zs.png")
	GUI:setAnchorPoint(giveImg1, 0.50, 0.50)
	GUI:setTouchEnabled(giveImg1, false)
	GUI:setTag(giveImg1, 0)

	-- Create item11
	local item11 = GUI:ItemShow_Create(midBtn1, "item11", 75, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item11, 0.50, 0.50)
	GUI:setTag(item11, 0)

	-- Create item12
	local item12 = GUI:ItemShow_Create(midBtn1, "item12", 135, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item12, 0.50, 0.50)
	GUI:setTag(item12, 0)

	-- Create item13
	local item13 = GUI:ItemShow_Create(midBtn1, "item13", 195, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item13, 0.50, 0.50)
	GUI:setTag(item13, 0)

	-- Create midBtn2
	local midBtn2 = GUI:Button_Create(midNode1, "midBtn2", 0, 0, "res/custom/npc/38cz/38.png")
	GUI:setContentSize(midBtn2, 230, 164)
	GUI:setIgnoreContentAdaptWithSize(midBtn2, false)
	GUI:Button_setTitleText(midBtn2, [[]])
	GUI:Button_setTitleColor(midBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(midBtn2, 16)
	GUI:Button_titleEnableOutline(midBtn2, "#000000", 1)
	GUI:setAnchorPoint(midBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(midBtn2, true)
	GUI:setTag(midBtn2, 0)

	-- Create giveImg2
	local giveImg2 = GUI:Image_Create(midBtn2, "giveImg2", 25, 38, "res/custom/npc/38cz/zs.png")
	GUI:setAnchorPoint(giveImg2, 0.50, 0.50)
	GUI:setTouchEnabled(giveImg2, false)
	GUI:setTag(giveImg2, 0)

	-- Create item21
	local item21 = GUI:ItemShow_Create(midBtn2, "item21", 75, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item21, 0.50, 0.50)
	GUI:setTag(item21, 0)

	-- Create item22
	local item22 = GUI:ItemShow_Create(midBtn2, "item22", 135, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item22, 0.50, 0.50)
	GUI:setTag(item22, 0)

	-- Create item23
	local item23 = GUI:ItemShow_Create(midBtn2, "item23", 195, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item23, 0.50, 0.50)
	GUI:setTag(item23, 0)

	-- Create midBtn3
	local midBtn3 = GUI:Button_Create(midNode1, "midBtn3", 0, 0, "res/custom/npc/38cz/98.png")
	GUI:setContentSize(midBtn3, 230, 164)
	GUI:setIgnoreContentAdaptWithSize(midBtn3, false)
	GUI:Button_setTitleText(midBtn3, [[]])
	GUI:Button_setTitleColor(midBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(midBtn3, 16)
	GUI:Button_titleEnableOutline(midBtn3, "#000000", 1)
	GUI:setAnchorPoint(midBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(midBtn3, true)
	GUI:setTag(midBtn3, 0)

	-- Create giveImg3
	local giveImg3 = GUI:Image_Create(midBtn3, "giveImg3", 25, 38, "res/custom/npc/38cz/zs.png")
	GUI:setAnchorPoint(giveImg3, 0.50, 0.50)
	GUI:setTouchEnabled(giveImg3, false)
	GUI:setTag(giveImg3, 0)

	-- Create item31
	local item31 = GUI:ItemShow_Create(midBtn3, "item31", 75, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item31, 0.50, 0.50)
	GUI:setTag(item31, 0)

	-- Create item32
	local item32 = GUI:ItemShow_Create(midBtn3, "item32", 135, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item32, 0.50, 0.50)
	GUI:setTag(item32, 0)

	-- Create item33
	local item33 = GUI:ItemShow_Create(midBtn3, "item33", 195, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item33, 0.50, 0.50)
	GUI:setTag(item33, 0)

	-- Create midNode2
	local midNode2 = GUI:Node_Create(FrameBG, "midNode2", 436, 158)
	GUI:setTag(midNode2, 0)

	-- Create midBtn4
	local midBtn4 = GUI:Button_Create(midNode2, "midBtn4", 0, 0, "res/custom/npc/38cz/168.png")
	GUI:setContentSize(midBtn4, 230, 164)
	GUI:setIgnoreContentAdaptWithSize(midBtn4, false)
	GUI:Button_setTitleText(midBtn4, [[]])
	GUI:Button_setTitleColor(midBtn4, "#ffffff")
	GUI:Button_setTitleFontSize(midBtn4, 16)
	GUI:Button_titleEnableOutline(midBtn4, "#000000", 1)
	GUI:setAnchorPoint(midBtn4, 0.00, 0.00)
	GUI:setTouchEnabled(midBtn4, true)
	GUI:setTag(midBtn4, 0)

	-- Create giveImg4
	local giveImg4 = GUI:Image_Create(midBtn4, "giveImg4", 25, 38, "res/custom/npc/38cz/zs.png")
	GUI:setAnchorPoint(giveImg4, 0.50, 0.50)
	GUI:setTouchEnabled(giveImg4, false)
	GUI:setTag(giveImg4, 0)

	-- Create item41
	local item41 = GUI:ItemShow_Create(midBtn4, "item41", 75, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item41, 0.50, 0.50)
	GUI:setTag(item41, 0)

	-- Create item42
	local item42 = GUI:ItemShow_Create(midBtn4, "item42", 135, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item42, 0.50, 0.50)
	GUI:setTag(item42, 0)

	-- Create item43
	local item43 = GUI:ItemShow_Create(midBtn4, "item43", 195, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item43, 0.50, 0.50)
	GUI:setTag(item43, 0)

	-- Create midBtn5
	local midBtn5 = GUI:Button_Create(midNode2, "midBtn5", 0, 0, "res/custom/npc/38cz/328.png")
	GUI:setContentSize(midBtn5, 230, 164)
	GUI:setIgnoreContentAdaptWithSize(midBtn5, false)
	GUI:Button_setTitleText(midBtn5, [[]])
	GUI:Button_setTitleColor(midBtn5, "#ffffff")
	GUI:Button_setTitleFontSize(midBtn5, 16)
	GUI:Button_titleEnableOutline(midBtn5, "#000000", 1)
	GUI:setAnchorPoint(midBtn5, 0.00, 0.00)
	GUI:setTouchEnabled(midBtn5, true)
	GUI:setTag(midBtn5, 0)

	-- Create giveImg5
	local giveImg5 = GUI:Image_Create(midBtn5, "giveImg5", 25, 38, "res/custom/npc/38cz/zs.png")
	GUI:setAnchorPoint(giveImg5, 0.50, 0.50)
	GUI:setTouchEnabled(giveImg5, false)
	GUI:setTag(giveImg5, 0)

	-- Create item51
	local item51 = GUI:ItemShow_Create(midBtn5, "item51", 75, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item51, 0.50, 0.50)
	GUI:setTag(item51, 0)

	-- Create item52
	local item52 = GUI:ItemShow_Create(midBtn5, "item52", 135, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item52, 0.50, 0.50)
	GUI:setTag(item52, 0)

	-- Create item53
	local item53 = GUI:ItemShow_Create(midBtn5, "item53", 195, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item53, 0.50, 0.50)
	GUI:setTag(item53, 0)

	-- Create midBtn6
	local midBtn6 = GUI:Button_Create(midNode2, "midBtn6", 0, 0, "res/custom/npc/38cz/648.png")
	GUI:setContentSize(midBtn6, 230, 164)
	GUI:setIgnoreContentAdaptWithSize(midBtn6, false)
	GUI:Button_setTitleText(midBtn6, [[]])
	GUI:Button_setTitleColor(midBtn6, "#ffffff")
	GUI:Button_setTitleFontSize(midBtn6, 16)
	GUI:Button_titleEnableOutline(midBtn6, "#000000", 1)
	GUI:setAnchorPoint(midBtn6, 0.00, 0.00)
	GUI:setTouchEnabled(midBtn6, true)
	GUI:setTag(midBtn6, 0)

	-- Create giveImg6
	local giveImg6 = GUI:Image_Create(midBtn6, "giveImg6", 25, 38, "res/custom/npc/38cz/zs.png")
	GUI:setAnchorPoint(giveImg6, 0.50, 0.50)
	GUI:setTouchEnabled(giveImg6, false)
	GUI:setTag(giveImg6, 0)

	-- Create item61
	local item61 = GUI:ItemShow_Create(midBtn6, "item61", 75, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item61, 0.50, 0.50)
	GUI:setTag(item61, 0)

	-- Create item62
	local item62 = GUI:ItemShow_Create(midBtn6, "item62", 135, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item62, 0.50, 0.50)
	GUI:setTag(item62, 0)

	-- Create item63
	local item63 = GUI:ItemShow_Create(midBtn6, "item63", 195, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item63, 0.50, 0.50)
	GUI:setTag(item63, 0)

	-- Create allText
	local allText = GUI:Text_Create(FrameBG, "allText", 165, 50, 16, "#ffff00", [[0元]])
	GUI:Text_enableOutline(allText, "#000000", 1)
	GUI:setAnchorPoint(allText, 0.50, 0.50)
	GUI:setTouchEnabled(allText, false)
	GUI:setTag(allText, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 818, 488, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
