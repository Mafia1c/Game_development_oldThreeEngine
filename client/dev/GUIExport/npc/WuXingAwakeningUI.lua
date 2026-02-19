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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/55wx/bg2.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 822, 482, "res/public/1900000510.png")
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

	-- Create btnList_1
	local btnList_1 = GUI:ListView_Create(FrameLayout, "btnList_1", 74, 40, 114, 440, 1)
	GUI:setAnchorPoint(btnList_1, 0.00, 0.00)
	GUI:setTouchEnabled(btnList_1, true)
	GUI:setTag(btnList_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(btnList_1, "Button_1", 0, 398, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_1, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[坚韧之躯]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Button_1, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(btnList_1, "Button_2", 0, 356, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_2, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[狂怒之心]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_2, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(btnList_1, "Button_3", 0, 314, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_3, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[制裁之殇]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_3, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(btnList_1, "Button_4", 0, 272, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_4, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[荆棘之力]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_4, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(btnList_1, "Button_5", 0, 230, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_5, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[宗师之威]])
	GUI:Button_setTitleColor(Button_5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_5, 18)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_5, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_6
	local Button_6 = GUI:Button_Create(btnList_1, "Button_6", 0, 188, "res/custom/dayeqian2.png")
	GUI:setContentSize(Button_6, 114, 42)
	GUI:setIgnoreContentAdaptWithSize(Button_6, false)
	GUI:Button_setTitleText(Button_6, [[魂石合成]])
	GUI:Button_setTitleColor(Button_6, "#ffffff")
	GUI:Button_setTitleFontSize(Button_6, 18)
	GUI:Button_titleEnableOutline(Button_6, "#000000", 1)
	GUI:setAnchorPoint(Button_6, 0.00, 0.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_6, "Image_1", -6, 6, "res/public/jiantou.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create awakening
	local awakening = GUI:Node_Create(FrameLayout, "awakening", 45, 25)
	GUI:setTag(awakening, 0)
	GUI:setVisible(awakening, false)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(awakening, "Image_2", 200, 395, "res/custom/npc/35jx/word_125.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(awakening, "Image_3", 570, 395, "res/custom/npc/35jx/word_126.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(awakening, "Image_4", 172, 286, "res/custom/npc/35jx/bg_hhzy_01_1.png")
	GUI:Image_setScale9Slice(Image_4, 13, 13, 11, 11)
	GUI:setContentSize(Image_4, 181, 113)
	GUI:setIgnoreContentAdaptWithSize(Image_4, false)
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(awakening, "Image_5", 535, 286, "res/custom/npc/35jx/bg_hhzy_01_1.png")
	GUI:Image_setScale9Slice(Image_5, 13, 13, 11, 11)
	GUI:setContentSize(Image_5, 181, 113)
	GUI:setIgnoreContentAdaptWithSize(Image_5, false)
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(awakening, "Image_6", 237, 182, "res/custom/npc/35jx/bg_tbqb_2.png")
	GUI:Image_setScale9Slice(Image_6, 40, 40, 42, 42)
	GUI:setContentSize(Image_6, 408, 95)
	GUI:setIgnoreContentAdaptWithSize(Image_6, false)
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create equipShow_1
	local equipShow_1 = GUI:ItemShow_Create(awakening, "equipShow_1", 451, 327, {index = 0, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(equipShow_1, 0.50, 0.50)
	GUI:setTag(equipShow_1, 0)

	-- Create iconNode
	local iconNode = GUI:Node_Create(awakening, "iconNode", 446, 230)
	GUI:setTag(iconNode, 0)

	-- Create activation_img_1
	local activation_img_1 = GUI:Image_Create(iconNode, "activation_img_1", -160, 0, "res/custom/npc/55wx/icon/0_1.png")
	GUI:setAnchorPoint(activation_img_1, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_1, true)
	GUI:setTag(activation_img_1, 0)

	-- Create activation_img_2
	local activation_img_2 = GUI:Image_Create(iconNode, "activation_img_2", -80, 0, "res/custom/npc/55wx/icon/0_2.png")
	GUI:setAnchorPoint(activation_img_2, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_2, true)
	GUI:setTag(activation_img_2, 0)

	-- Create activation_img_3
	local activation_img_3 = GUI:Image_Create(iconNode, "activation_img_3", 0, 0, "res/custom/npc/55wx/icon/0_3.png")
	GUI:setAnchorPoint(activation_img_3, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_3, true)
	GUI:setTag(activation_img_3, 0)

	-- Create activation_img_4
	local activation_img_4 = GUI:Image_Create(iconNode, "activation_img_4", 80, 0, "res/custom/npc/55wx/icon/0_4.png")
	GUI:setAnchorPoint(activation_img_4, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_4, true)
	GUI:setTag(activation_img_4, 0)

	-- Create activation_img_5
	local activation_img_5 = GUI:Image_Create(iconNode, "activation_img_5", 160, 0, "res/custom/npc/55wx/icon/0_5.png")
	GUI:setAnchorPoint(activation_img_5, 0.50, 0.50)
	GUI:setTouchEnabled(activation_img_5, true)
	GUI:setTag(activation_img_5, 0)

	-- Create text
	local text = GUI:RichText_Create(awakening, "text", 294, 160, [[<font color='#ff0000' size='16' >提示:   </font><font color='#00ffe8' size='16' >五行觉醒到一定等级可获得额外提升! </font>]], 320, 16, "#ffffff", 1)
	GUI:setAnchorPoint(text, 0.00, 0.00)
	GUI:setTag(text, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(awakening, "ItemShow_1", 375, 119, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(awakening, "ItemShow_2", 449, 119, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(awakening, "ItemShow_3", 520, 118, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create startBtn
	local startBtn = GUI:Button_Create(awakening, "startBtn", 397, 43, "res/public/1900000612.png")
	GUI:setContentSize(startBtn, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(startBtn, false)
	GUI:Button_setTitleText(startBtn, [[开始觉醒]])
	GUI:Button_setTitleColor(startBtn, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn, 18)
	GUI:Button_titleEnableOutline(startBtn, "#000000", 1)
	GUI:setAnchorPoint(startBtn, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn, true)
	GUI:setTag(startBtn, 0)

	-- Create left_txt
	local left_txt = GUI:Text_Create(awakening, "left_txt", 254, 333, 18, "#ffffff", [[防御加成: 6%]])
	GUI:Text_enableOutline(left_txt, "#000000", 1)
	GUI:setAnchorPoint(left_txt, 0.50, 0.00)
	GUI:setTouchEnabled(left_txt, false)
	GUI:setTag(left_txt, 0)

	-- Create right_txt
	local right_txt = GUI:Text_Create(awakening, "right_txt", 627, 333, 18, "#00ff00", [[防御加成: 7%]])
	GUI:Text_enableOutline(right_txt, "#000000", 1)
	GUI:setAnchorPoint(right_txt, 0.50, 0.00)
	GUI:setTouchEnabled(right_txt, false)
	GUI:setTag(right_txt, 0)

	-- Create compoundBtn
	local compoundBtn = GUI:Button_Create(awakening, "compoundBtn", 564, 103, "res/public/1900000612.png")
	GUI:setContentSize(compoundBtn, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(compoundBtn, false)
	GUI:Button_setTitleText(compoundBtn, [[魂石合成]])
	GUI:Button_setTitleColor(compoundBtn, "#ffffff")
	GUI:Button_setTitleFontSize(compoundBtn, 18)
	GUI:Button_titleEnableOutline(compoundBtn, "#000000", 1)
	GUI:setAnchorPoint(compoundBtn, 0.00, 0.00)
	GUI:setTouchEnabled(compoundBtn, true)
	GUI:setTag(compoundBtn, 0)

	-- Create compound
	local compound = GUI:Node_Create(FrameLayout, "compound", 45, 21)
	GUI:setTag(compound, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(compound, "RichText_1", 385, 428, [[<font color='#ffff00' size='18' >合成五魂石 </font><font color='#00ff00' size='18' >x1个</font>]], 150, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(compound, "RichText_2", 382, 322, [[<font color='#ffff00' size='18' >合成五魂石 </font><font color='#00ff00' size='18' >x10个</font>]], 150, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(compound, "RichText_3", 382, 211, [[<font color='#ffff00' size='18' >合成五魂石 </font><font color='#00ff00' size='18' >x50个</font>]], 150, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(compound, "RichText_4", 379, 97, [[<font color='#ffff00' size='18' >合成五魂石 </font><font color='#00ff00' size='18' >x100个</font>]], 160, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.00, 0.00)
	GUI:setTag(RichText_4, 0)

	-- Create award_1
	local award_1 = GUI:ItemShow_Create(compound, "award_1", 570, 386, {index = 10404, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_1, 0.50, 0.50)
	GUI:setTag(award_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(award_1, "Text_1", 44, 2, 16, "#00ff00", [[1]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create award_2
	local award_2 = GUI:ItemShow_Create(compound, "award_2", 570, 280, {index = 10404, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_2, 0.50, 0.50)
	GUI:setTag(award_2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(award_2, "Text_1", 38, 1, 16, "#00ff00", [[10]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create award_3
	local award_3 = GUI:ItemShow_Create(compound, "award_3", 572, 166, {index = 10404, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_3, 0.50, 0.50)
	GUI:setTag(award_3, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(award_3, "Text_1", 38, 2, 16, "#00ff00", [[50]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create award_4
	local award_4 = GUI:ItemShow_Create(compound, "award_4", 571, 56, {index = 10404, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_4, 0.50, 0.50)
	GUI:setTag(award_4, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(award_4, "Text_1", 30, 2, 16, "#00ff00", [[100]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create cailiao_1
	local cailiao_1 = GUI:ItemShow_Create(compound, "cailiao_1", 240, 385, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(cailiao_1, 0.50, 0.50)
	GUI:setTag(cailiao_1, 0)

	-- Create cailiao_2
	local cailiao_2 = GUI:ItemShow_Create(compound, "cailiao_2", 330, 385, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(cailiao_2, 0.50, 0.50)
	GUI:setTag(cailiao_2, 0)

	-- Create cailiao_3
	local cailiao_3 = GUI:ItemShow_Create(compound, "cailiao_3", 240, 278, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(cailiao_3, 0.50, 0.50)
	GUI:setTag(cailiao_3, 0)

	-- Create cailiao_4
	local cailiao_4 = GUI:ItemShow_Create(compound, "cailiao_4", 330, 278, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(cailiao_4, 0.50, 0.50)
	GUI:setTag(cailiao_4, 0)

	-- Create cailiao_5
	local cailiao_5 = GUI:ItemShow_Create(compound, "cailiao_5", 242, 165, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(cailiao_5, 0.50, 0.50)
	GUI:setTag(cailiao_5, 0)

	-- Create cailiao_6
	local cailiao_6 = GUI:ItemShow_Create(compound, "cailiao_6", 332, 165, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(cailiao_6, 0.50, 0.50)
	GUI:setTag(cailiao_6, 0)

	-- Create cailiao_7
	local cailiao_7 = GUI:ItemShow_Create(compound, "cailiao_7", 241, 52, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(cailiao_7, 0.50, 0.50)
	GUI:setTag(cailiao_7, 0)

	-- Create cailiao_8
	local cailiao_8 = GUI:ItemShow_Create(compound, "cailiao_8", 331, 52, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(cailiao_8, 0.50, 0.50)
	GUI:setTag(cailiao_8, 0)

	-- Create ok_btn_1
	local ok_btn_1 = GUI:Button_Create(compound, "ok_btn_1", 629, 370, "res/public/1900000673.png")
	GUI:setContentSize(ok_btn_1, 92, 35)
	GUI:setIgnoreContentAdaptWithSize(ok_btn_1, false)
	GUI:Button_setTitleText(ok_btn_1, [[确定合成]])
	GUI:Button_setTitleColor(ok_btn_1, "#ffffff")
	GUI:Button_setTitleFontSize(ok_btn_1, 16)
	GUI:Button_titleEnableOutline(ok_btn_1, "#000000", 1)
	GUI:setAnchorPoint(ok_btn_1, 0.00, 0.00)
	GUI:setTouchEnabled(ok_btn_1, true)
	GUI:setTag(ok_btn_1, 0)

	-- Create ok_btn_2
	local ok_btn_2 = GUI:Button_Create(compound, "ok_btn_2", 630, 262, "res/public/1900000673.png")
	GUI:setContentSize(ok_btn_2, 92, 35)
	GUI:setIgnoreContentAdaptWithSize(ok_btn_2, false)
	GUI:Button_setTitleText(ok_btn_2, [[确定合成]])
	GUI:Button_setTitleColor(ok_btn_2, "#ffffff")
	GUI:Button_setTitleFontSize(ok_btn_2, 16)
	GUI:Button_titleEnableOutline(ok_btn_2, "#000000", 1)
	GUI:setAnchorPoint(ok_btn_2, 0.00, 0.00)
	GUI:setTouchEnabled(ok_btn_2, true)
	GUI:setTag(ok_btn_2, 0)

	-- Create ok_btn_3
	local ok_btn_3 = GUI:Button_Create(compound, "ok_btn_3", 631, 150, "res/public/1900000673.png")
	GUI:setContentSize(ok_btn_3, 92, 35)
	GUI:setIgnoreContentAdaptWithSize(ok_btn_3, false)
	GUI:Button_setTitleText(ok_btn_3, [[确定合成]])
	GUI:Button_setTitleColor(ok_btn_3, "#ffffff")
	GUI:Button_setTitleFontSize(ok_btn_3, 16)
	GUI:Button_titleEnableOutline(ok_btn_3, "#000000", 1)
	GUI:setAnchorPoint(ok_btn_3, 0.00, 0.00)
	GUI:setTouchEnabled(ok_btn_3, true)
	GUI:setTag(ok_btn_3, 0)

	-- Create ok_btn_4
	local ok_btn_4 = GUI:Button_Create(compound, "ok_btn_4", 630, 40, "res/public/1900000673.png")
	GUI:setContentSize(ok_btn_4, 92, 35)
	GUI:setIgnoreContentAdaptWithSize(ok_btn_4, false)
	GUI:Button_setTitleText(ok_btn_4, [[确定合成]])
	GUI:Button_setTitleColor(ok_btn_4, "#ffffff")
	GUI:Button_setTitleFontSize(ok_btn_4, 16)
	GUI:Button_titleEnableOutline(ok_btn_4, "#000000", 1)
	GUI:setAnchorPoint(ok_btn_4, 0.00, 0.00)
	GUI:setTouchEnabled(ok_btn_4, true)
	GUI:setTag(ok_btn_4, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
