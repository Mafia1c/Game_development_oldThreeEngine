local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 574, 320, 816, 582, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/public/1900000610.png")
	GUI:Image_setScale9Slice(FrameBG, 272, 272, 194, 194)
	GUI:setContentSize(FrameBG, 816, 582)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create img_line
	local img_line = GUI:Image_Create(FrameBG, "img_line", 348, 32, "res/public/bg_yyxsz_02.png")
	GUI:Image_setScale9Slice(img_line, 1, 0, 201, 202)
	GUI:setContentSize(img_line, 2, 445)
	GUI:setIgnoreContentAdaptWithSize(img_line, false)
	GUI:setAnchorPoint(img_line, 0.00, 0.00)
	GUI:setTouchEnabled(img_line, false)
	GUI:setTag(img_line, -1)

	-- Create img_line_1
	local img_line_1 = GUI:Image_Create(FrameBG, "img_line_1", 178, 32, "res/public/bg_yyxsz_02.png")
	GUI:Image_setScale9Slice(img_line_1, 1, 0, 201, 202)
	GUI:setContentSize(img_line_1, 2, 408)
	GUI:setIgnoreContentAdaptWithSize(img_line_1, false)
	GUI:setAnchorPoint(img_line_1, 0.00, 0.00)
	GUI:setTouchEnabled(img_line_1, false)
	GUI:setTag(img_line_1, -1)

	-- Create img_line_1_1
	local img_line_1_1 = GUI:Image_Create(FrameBG, "img_line_1_1", 51, 439, "res/public/bg_yyxsz_01.png")
	GUI:Image_setScale9Slice(img_line_1_1, 244, 244, 1, 0)
	GUI:setContentSize(img_line_1_1, 295, 2)
	GUI:setIgnoreContentAdaptWithSize(img_line_1_1, false)
	GUI:setAnchorPoint(img_line_1_1, 0.00, 0.00)
	GUI:setTouchEnabled(img_line_1_1, false)
	GUI:setTag(img_line_1_1, -1)

	-- Create TitleText
	local TitleText = GUI:Text_Create(FrameLayout, "TitleText", 145, 487, 20, "#d8c8ae", [[GMBOX]])
	GUI:Text_enableOutline(TitleText, "#000000", 1)
	GUI:setAnchorPoint(TitleText, 0.00, 0.00)
	GUI:setTouchEnabled(TitleText, false)
	GUI:setTag(TitleText, -1)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 828, 560, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(CloseButton, "res/public/1900000511.png")
	GUI:setContentSize(CloseButton, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.50, 0.50)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 59, 435, 110, 400, 1)
	GUI:ListView_setBackGroundColorType(ListView_1, 1)
	GUI:ListView_setBackGroundColor(ListView_1, "#9696ff")
	GUI:ListView_setBackGroundColorOpacity(ListView_1, 0)
	GUI:ListView_setItemsMargin(ListView_1, 3)
	GUI:setAnchorPoint(ListView_1, 0.00, 1.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 92)
	TAGOBJ["92"] = ListView_1

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(FrameLayout, "ListView_2", 183, 435, 150, 400, 1)
	GUI:ListView_setBackGroundColorType(ListView_2, 1)
	GUI:ListView_setBackGroundColor(ListView_2, "#9696ff")
	GUI:ListView_setBackGroundColorOpacity(ListView_2, 0)
	GUI:setAnchorPoint(ListView_2, 0.00, 1.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 92)
	TAGOBJ["92"] = ListView_2

	-- Create template_1
	local template_1 = GUI:Button_Create(FrameLayout, "template_1", 60, 19, "res/public/1900000663.png")
	GUI:Button_loadTextureDisabled(template_1, "res/public/1900000662.png")
	GUI:Button_setScale9Slice(template_1, 38, 39, 12, 13)
	GUI:setContentSize(template_1, 110, 36)
	GUI:setIgnoreContentAdaptWithSize(template_1, false)
	GUI:Button_setTitleText(template_1, [[]])
	GUI:Button_setTitleColor(template_1, "#d2b48c")
	GUI:Button_setTitleFontSize(template_1, 14)
	GUI:Button_titleEnableOutline(template_1, "#000000", 1)
	GUI:setAnchorPoint(template_1, 0.50, 0.50)
	GUI:setTouchEnabled(template_1, true)
	GUI:setTag(template_1, 214)
	TAGOBJ["214"] = template_1

	-- Create template_2
	local template_2 = GUI:Button_Create(FrameLayout, "template_2", 60, 19, "res/public/bg_hhzy_01_3.png")
	GUI:Button_loadTextureDisabled(template_2, "res/public/bg_hhzy_01_1.png")
	GUI:Button_setScale9Slice(template_2, 50, 49, 10, 11)
	GUI:setContentSize(template_2, 150, 30)
	GUI:setIgnoreContentAdaptWithSize(template_2, false)
	GUI:Button_setTitleText(template_2, [[]])
	GUI:Button_setTitleColor(template_2, "#d2b48c")
	GUI:Button_setTitleFontSize(template_2, 13)
	GUI:Button_titleEnableOutline(template_2, "#000000", 1)
	GUI:setAnchorPoint(template_2, 0.50, 0.50)
	GUI:setTouchEnabled(template_2, true)
	GUI:setTag(template_2, 214)
	TAGOBJ["214"] = template_2

	-- Create Image_Input_bg
	local Image_Input_bg = GUI:Image_Create(FrameLayout, "Image_Input_bg", 59, 445, "res/public/1900000668.png")
	GUI:Image_setScale9Slice(Image_Input_bg, 52, 52, 10, 11)
	GUI:setContentSize(Image_Input_bg, 220, 28)
	GUI:setIgnoreContentAdaptWithSize(Image_Input_bg, false)
	GUI:setAnchorPoint(Image_Input_bg, 0.00, 0.00)
	GUI:setTouchEnabled(Image_Input_bg, false)
	GUI:setTag(Image_Input_bg, -1)

	-- Create selectButton
	local selectButton = GUI:Button_Create(FrameLayout, "selectButton", 314, 460, "res/public/btn_1.png")
	GUI:setContentSize(selectButton, 60, 24)
	GUI:setIgnoreContentAdaptWithSize(selectButton, false)
	GUI:Button_setTitleText(selectButton, [[]])
	GUI:Button_setTitleColor(selectButton, "#d6c6ad")
	GUI:Button_setTitleFontSize(selectButton, 18)
	GUI:Button_titleEnableOutline(selectButton, "#000000", 1)
	GUI:setAnchorPoint(selectButton, 0.50, 0.50)
	GUI:setTouchEnabled(selectButton, true)
	GUI:setTag(selectButton, 214)
	TAGOBJ["214"] = selectButton

	-- Create template_Command
	local template_Command = GUI:Layout_Create(FrameLayout, "template_Command", 10, 9, 350, 30, true)
	GUI:setAnchorPoint(template_Command, 0.00, 0.00)
	GUI:setTouchEnabled(template_Command, false)
	GUI:setTag(template_Command, -1)

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(template_Command, "Image_bg", 168, 1, "res/public/1900000668.png")
	GUI:setContentSize(Image_bg, 156, 28)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setAnchorPoint(Image_bg, 0.00, 0.00)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, -1)

	-- Create Layout_RichText2
	local Layout_RichText2 = GUI:Layout_Create(template_Command, "Layout_RichText2", 0, 0, 165, 30, false)
	GUI:setAnchorPoint(Layout_RichText2, 0.00, 0.00)
	GUI:setTouchEnabled(Layout_RichText2, false)
	GUI:setTag(Layout_RichText2, -1)

	-- Create Button_List
	local Button_List = GUI:Button_Create(template_Command, "Button_List", 326, 2, "res/public/1900000624.png")
	GUI:setContentSize(Button_List, 22, 26)
	GUI:setIgnoreContentAdaptWithSize(Button_List, false)
	GUI:Button_setTitleText(Button_List, [[]])
	GUI:Button_setTitleColor(Button_List, "#ffffff")
	GUI:Button_setTitleFontSize(Button_List, 14)
	GUI:Button_titleEnableOutline(Button_List, "#000000", 1)
	GUI:setAnchorPoint(Button_List, 0.00, 0.00)
	GUI:setTouchEnabled(Button_List, true)
	GUI:setTag(Button_List, -1)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(FrameLayout, "Panel_1", 355, 36, 425, 435, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, -1)

	-- Create img_title
	local img_title = GUI:Image_Create(Panel_1, "img_title", 33, 401, "res/public/bg_hhzy_01_2.png")
	GUI:Image_setScale9Slice(img_title, 186, 186, 12, 11)
	GUI:setContentSize(img_title, 350, 30)
	GUI:setIgnoreContentAdaptWithSize(img_title, false)
	GUI:setAnchorPoint(img_title, 0.00, 0.00)
	GUI:setTouchEnabled(img_title, false)
	GUI:setTag(img_title, -1)

	-- Create SendGMButton
	local SendGMButton = GUI:Button_Create(Panel_1, "SendGMButton", 361, 25, "res/public/1900000663.png")
	GUI:Button_loadTextureDisabled(SendGMButton, "res/public/1900000662.png")
	GUI:Button_setScale9Slice(SendGMButton, 38, 39, 12, 13)
	GUI:setContentSize(SendGMButton, 110, 36)
	GUI:setIgnoreContentAdaptWithSize(SendGMButton, false)
	GUI:Button_setTitleText(SendGMButton, [[发送命令]])
	GUI:Button_setTitleColor(SendGMButton, "#d6c6ad")
	GUI:Button_setTitleFontSize(SendGMButton, 18)
	GUI:Button_titleEnableOutline(SendGMButton, "#000000", 1)
	GUI:setAnchorPoint(SendGMButton, 0.50, 0.50)
	GUI:setTouchEnabled(SendGMButton, true)
	GUI:setTag(SendGMButton, 214)
	GUI:setVisible(SendGMButton, false)
	TAGOBJ["214"] = SendGMButton

	-- Create Button_send
	local Button_send = GUI:Button_Create(Panel_1, "Button_send", 383, 24, "res/private/chat/1900012823.png")
	GUI:Button_loadTexturePressed(Button_send, "res/private/chat/1900012824.png")
	GUI:setContentSize(Button_send, 68, 40)
	GUI:setIgnoreContentAdaptWithSize(Button_send, false)
	GUI:Button_setTitleText(Button_send, [[]])
	GUI:Button_setTitleColor(Button_send, "#f8e6c6")
	GUI:Button_setTitleFontSize(Button_send, 18)
	GUI:Button_titleEnableOutline(Button_send, "#111111", 2)
	GUI:setChineseName(Button_send, "聊天_发送_按钮")
	GUI:setAnchorPoint(Button_send, 0.50, 0.50)
	GUI:setTouchEnabled(Button_send, true)
	GUI:setTag(Button_send, 155)
	TAGOBJ["155"] = Button_send

	-- Create Image_send
	local Image_send = GUI:Image_Create(Button_send, "Image_send", 34, 20, "res/private/chat/1900012835.png")
	GUI:setChineseName(Image_send, "聊天_发送_文本图片")
	GUI:setAnchorPoint(Image_send, 0.50, 0.50)
	GUI:setTouchEnabled(Image_send, false)
	GUI:setTag(Image_send, 78)
	TAGOBJ["78"] = Image_send

	-- Create Button_input_5
	local Button_input_5 = GUI:Button_Create(Panel_1, "Button_input_5", 326, 25, "res/private/chat/1900012861.png")
	GUI:Button_loadTexturePressed(Button_input_5, "res/private/chat/1900012860.png")
	GUI:setContentSize(Button_input_5, 39, 41)
	GUI:setIgnoreContentAdaptWithSize(Button_input_5, false)
	GUI:Button_setTitleText(Button_input_5, [[]])
	GUI:Button_setTitleColor(Button_input_5, "#f8e6c6")
	GUI:Button_setTitleFontSize(Button_input_5, 18)
	GUI:Button_titleEnableOutline(Button_input_5, "#111111", 2)
	GUI:setChineseName(Button_input_5, "聊天_上一次内容_按钮")
	GUI:setAnchorPoint(Button_input_5, 0.50, 0.50)
	GUI:setTouchEnabled(Button_input_5, true)
	GUI:setTag(Button_input_5, 41)
	TAGOBJ["41"] = Button_input_5

	-- Create Layout_RichText
	local Layout_RichText = GUI:Layout_Create(Panel_1, "Layout_RichText", 14, 39, 400, 30, true)
	GUI:setAnchorPoint(Layout_RichText, 0.00, 0.00)
	GUI:setTouchEnabled(Layout_RichText, false)
	GUI:setTag(Layout_RichText, -1)

	-- Create Layout_Command
	local Layout_Command = GUI:Layout_Create(Panel_1, "Layout_Command", 10, 68, 405, 320, false)
	GUI:setAnchorPoint(Layout_Command, 0.00, 0.00)
	GUI:setTouchEnabled(Layout_Command, false)
	GUI:setTag(Layout_Command, -1)

	-- Create star
	local star = GUI:Button_Create(Panel_1, "star", 380, 394, "res/public/1900000656.png")
	GUI:setContentSize(star, 40, 40)
	GUI:setIgnoreContentAdaptWithSize(star, false)
	GUI:Button_setTitleText(star, [[]])
	GUI:Button_setTitleColor(star, "#ffffff")
	GUI:Button_setTitleFontSize(star, 14)
	GUI:Button_titleEnableOutline(star, "#000000", 1)
	GUI:setAnchorPoint(star, 0.00, 0.00)
	GUI:setTouchEnabled(star, true)
	GUI:setTag(star, -1)

	-- Create Image_sendInput_bg
	local Image_sendInput_bg = GUI:Image_Create(Panel_1, "Image_sendInput_bg", 13, 9, "res/public/1900000668.png")
	GUI:Image_setScale9Slice(Image_sendInput_bg, 52, 52, 10, 11)
	GUI:setContentSize(Image_sendInput_bg, 290, 28)
	GUI:setIgnoreContentAdaptWithSize(Image_sendInput_bg, false)
	GUI:setAnchorPoint(Image_sendInput_bg, 0.00, 0.00)
	GUI:setTouchEnabled(Image_sendInput_bg, false)
	GUI:setTag(Image_sendInput_bg, -1)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
