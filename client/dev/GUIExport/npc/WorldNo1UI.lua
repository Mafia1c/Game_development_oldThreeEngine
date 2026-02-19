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
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/10dy/bg.png")
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

	-- Create GotoBtn
	local GotoBtn = GUI:Button_Create(FrameLayout, "GotoBtn", 653, 45, "res/public/zynpc.png")
	GUI:setContentSize(GotoBtn, 115, 37)
	GUI:setIgnoreContentAdaptWithSize(GotoBtn, false)
	GUI:Button_setTitleText(GotoBtn, [[前往申请]])
	GUI:Button_setTitleColor(GotoBtn, "#ffffff")
	GUI:Button_setTitleFontSize(GotoBtn, 18)
	GUI:Button_titleEnableOutline(GotoBtn, "#000000", 1)
	GUI:setAnchorPoint(GotoBtn, 0.00, 0.00)
	GUI:setTouchEnabled(GotoBtn, true)
	GUI:setTag(GotoBtn, 0)

	-- Create title_txt1
	local title_txt1 = GUI:Text_Create(FrameLayout, "title_txt1", 79, 69, 18, "#ff9b00", [==========[[申请规则]:]==========])
	GUI:Text_enableOutline(title_txt1, "#000000", 1)
	GUI:setAnchorPoint(title_txt1, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt1, false)
	GUI:setTag(title_txt1, 0)

	-- Create title_txt2
	local title_txt2 = GUI:Text_Create(FrameLayout, "title_txt2", 79, 39, 18, "#ff0000", [[上榜人物属性:]])
	GUI:Text_enableOutline(title_txt2, "#000000", 1)
	GUI:setAnchorPoint(title_txt2, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt2, false)
	GUI:setTag(title_txt2, 0)

	-- Create title_txt3
	local title_txt3 = GUI:Text_Create(FrameLayout, "title_txt3", 502, 39, 18, "#ff0000", [[每4小时清理一次]])
	GUI:Text_enableOutline(title_txt3, "#000000", 1)
	GUI:setAnchorPoint(title_txt3, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt3, false)
	GUI:setTag(title_txt3, 0)

	-- Create No1_zhan
	local No1_zhan = GUI:Text_Create(FrameLayout, "No1_zhan", 201, 39, 18, "#ffff00", [[天下第一战]])
	GUI:Text_enableOutline(No1_zhan, "#000000", 1)
	GUI:Text_enableUnderline(No1_zhan)
	GUI:setAnchorPoint(No1_zhan, 0.00, 0.00)
	GUI:setTouchEnabled(No1_zhan, true)
	GUI:setTag(No1_zhan, 0)

	-- Create No1_fa
	local No1_fa = GUI:Text_Create(FrameLayout, "No1_fa", 307, 39, 18, "#ffff00", [[天下第一法]])
	GUI:Text_enableOutline(No1_fa, "#000000", 1)
	GUI:Text_enableUnderline(No1_fa)
	GUI:setAnchorPoint(No1_fa, 0.00, 0.00)
	GUI:setTouchEnabled(No1_fa, true)
	GUI:setTag(No1_fa, 0)

	-- Create No1_dao
	local No1_dao = GUI:Text_Create(FrameLayout, "No1_dao", 407, 39, 18, "#ffff00", [[天下第一道]])
	GUI:Text_enableOutline(No1_dao, "#000000", 1)
	GUI:Text_enableUnderline(No1_dao)
	GUI:setAnchorPoint(No1_dao, 0.00, 0.00)
	GUI:setTouchEnabled(No1_dao, true)
	GUI:setTag(No1_dao, 0)

	-- Create look_btn1
	local look_btn1 = GUI:Button_Create(FrameLayout, "look_btn1", 160, 119, "res/public/1900000611.png")
	GUI:setContentSize(look_btn1, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(look_btn1, false)
	GUI:Button_setTitleText(look_btn1, [[查看]])
	GUI:Button_setTitleColor(look_btn1, "#ff9b00")
	GUI:Button_setTitleFontSize(look_btn1, 16)
	GUI:Button_titleEnableOutline(look_btn1, "#000000", 1)
	GUI:setAnchorPoint(look_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(look_btn1, true)
	GUI:setTag(look_btn1, 0)

	-- Create look_btn2
	local look_btn2 = GUI:Button_Create(FrameLayout, "look_btn2", 398, 119, "res/public/1900000611.png")
	GUI:setContentSize(look_btn2, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(look_btn2, false)
	GUI:Button_setTitleText(look_btn2, [[查看]])
	GUI:Button_setTitleColor(look_btn2, "#ff9b00")
	GUI:Button_setTitleFontSize(look_btn2, 16)
	GUI:Button_titleEnableOutline(look_btn2, "#000000", 1)
	GUI:setAnchorPoint(look_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(look_btn2, true)
	GUI:setTag(look_btn2, 0)

	-- Create look_btn3
	local look_btn3 = GUI:Button_Create(FrameLayout, "look_btn3", 650, 119, "res/public/1900000611.png")
	GUI:setContentSize(look_btn3, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(look_btn3, false)
	GUI:Button_setTitleText(look_btn3, [[查看]])
	GUI:Button_setTitleColor(look_btn3, "#ff9b00")
	GUI:Button_setTitleFontSize(look_btn3, 16)
	GUI:Button_titleEnableOutline(look_btn3, "#000000", 1)
	GUI:setAnchorPoint(look_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(look_btn3, true)
	GUI:setTag(look_btn3, 0)

	-- Create title_img1
	local title_img1 = GUI:Image_Create(FrameLayout, "title_img1", 80, 406, "res/public/1900000676.png")
	GUI:Image_setScale9Slice(title_img1, 7, 7, 10, 10)
	GUI:setContentSize(title_img1, 233, 66)
	GUI:setIgnoreContentAdaptWithSize(title_img1, false)
	GUI:setAnchorPoint(title_img1, 0.00, 0.00)
	GUI:setTouchEnabled(title_img1, false)
	GUI:setTag(title_img1, 0)

	-- Create name_txt1
	local name_txt1 = GUI:Text_Create(title_img1, "name_txt1", 8, 36, 16, "#ff0000", [[天下第一战:  暂无]])
	GUI:Text_enableOutline(name_txt1, "#000000", 1)
	GUI:setAnchorPoint(name_txt1, 0.00, 0.00)
	GUI:setTouchEnabled(name_txt1, false)
	GUI:setTag(name_txt1, 0)

	-- Create tip_txt1
	local tip_txt1 = GUI:Text_Create(title_img1, "tip_txt1", 8, 10, 16, "#ffff00", [[申请等级:  0级]])
	GUI:Text_enableOutline(tip_txt1, "#000000", 1)
	GUI:setAnchorPoint(tip_txt1, 0.00, 0.00)
	GUI:setTouchEnabled(tip_txt1, false)
	GUI:setTag(tip_txt1, 0)

	-- Create title_img2
	local title_img2 = GUI:Image_Create(FrameLayout, "title_img2", 320, 406, "res/public/1900000676.png")
	GUI:Image_setScale9Slice(title_img2, 7, 7, 10, 10)
	GUI:setContentSize(title_img2, 233, 66)
	GUI:setIgnoreContentAdaptWithSize(title_img2, false)
	GUI:setAnchorPoint(title_img2, 0.00, 0.00)
	GUI:setTouchEnabled(title_img2, false)
	GUI:setTag(title_img2, 0)

	-- Create name_txt2
	local name_txt2 = GUI:Text_Create(title_img2, "name_txt2", 8, 36, 16, "#ff0000", [[天下第一法:  暂无]])
	GUI:Text_enableOutline(name_txt2, "#000000", 1)
	GUI:setAnchorPoint(name_txt2, 0.00, 0.00)
	GUI:setTouchEnabled(name_txt2, false)
	GUI:setTag(name_txt2, 0)

	-- Create tip_txt2
	local tip_txt2 = GUI:Text_Create(title_img2, "tip_txt2", 8, 10, 16, "#ffff00", [[申请等级:  0级]])
	GUI:Text_enableOutline(tip_txt2, "#000000", 1)
	GUI:setAnchorPoint(tip_txt2, 0.00, 0.00)
	GUI:setTouchEnabled(tip_txt2, false)
	GUI:setTag(tip_txt2, 0)

	-- Create title_img3
	local title_img3 = GUI:Image_Create(FrameLayout, "title_img3", 563, 406, "res/public/1900000676.png")
	GUI:Image_setScale9Slice(title_img3, 7, 7, 10, 10)
	GUI:setContentSize(title_img3, 233, 66)
	GUI:setIgnoreContentAdaptWithSize(title_img3, false)
	GUI:setAnchorPoint(title_img3, 0.00, 0.00)
	GUI:setTouchEnabled(title_img3, false)
	GUI:setTag(title_img3, 0)

	-- Create name_txt3
	local name_txt3 = GUI:Text_Create(title_img3, "name_txt3", 8, 36, 16, "#ff0000", [[天下第一道:  暂无]])
	GUI:Text_enableOutline(name_txt3, "#000000", 1)
	GUI:setAnchorPoint(name_txt3, 0.00, 0.00)
	GUI:setTouchEnabled(name_txt3, false)
	GUI:setTag(name_txt3, 0)

	-- Create tip_txt3
	local tip_txt3 = GUI:Text_Create(title_img3, "tip_txt3", 8, 10, 16, "#ffff00", [[申请等级:  0级]])
	GUI:Text_enableOutline(tip_txt3, "#000000", 1)
	GUI:setAnchorPoint(tip_txt3, 0.00, 0.00)
	GUI:setTouchEnabled(tip_txt3, false)
	GUI:setTag(tip_txt3, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
