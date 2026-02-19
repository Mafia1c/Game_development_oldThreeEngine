local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Node_Create(parent, "Scene", 0, 0)
	GUI:setChineseName(Scene, "玩家面板场景")
	GUI:setTag(Scene, -1)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(Scene, "Panel_1", 654, 166, 305, 428, false)
	GUI:setChineseName(Panel_1, "玩家面板_组合")
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 125)
	TAGOBJ["125"] = Panel_1

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_1, "Image_bg", 152, 214, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015000.png")
	GUI:setChineseName(Image_bg, "玩家面板_背景图")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 131)
	TAGOBJ["131"] = Image_bg

	-- Create Text_Name
	local Text_Name = GUI:Text_Create(Panel_1, "Text_Name", 150, 392, 18, "#ffe400", [[]])
	GUI:Text_enableOutline(Text_Name, "#0e0e0e", 1)
	GUI:setChineseName(Text_Name, "玩家面板_玩家昵称_文本")
	GUI:setAnchorPoint(Text_Name, 0.50, 0.50)
	GUI:setTouchEnabled(Text_Name, false)
	GUI:setTag(Text_Name, 132)
	TAGOBJ["132"] = Text_Name

	-- Create ButtonClose
	local ButtonClose = GUI:Button_Create(Panel_1, "ButtonClose", 312, 364, "res/public_win32/btn_02.png")
	GUI:Button_loadTextureDisabled(ButtonClose, "Default/Button_Disable.png")
	GUI:setContentSize(ButtonClose, 16, 27)
	GUI:setIgnoreContentAdaptWithSize(ButtonClose, false)
	GUI:Button_setTitleText(ButtonClose, [[]])
	GUI:Button_setTitleColor(ButtonClose, "#414146")
	GUI:Button_setTitleFontSize(ButtonClose, 14)
	GUI:Button_titleDisableOutLine(ButtonClose)
	GUI:setChineseName(ButtonClose, "玩家面板_关闭按钮")
	GUI:setAnchorPoint(ButtonClose, 0.50, 0.50)
	GUI:setTouchEnabled(ButtonClose, true)
	GUI:setTag(ButtonClose, 133)
	TAGOBJ["133"] = ButtonClose

	-- Create Node_panel
	local Node_panel = GUI:Node_Create(Panel_1, "Node_panel", 16, 14)
	GUI:setChineseName(Node_panel, "玩家面板_节点")
	GUI:setTag(Node_panel, 134)
	TAGOBJ["134"] = Node_panel

	-- Create Panel_btnList
	local Panel_btnList = GUI:Layout_Create(Panel_1, "Panel_btnList", 304, 348, 24, 340, false)
	GUI:setChineseName(Panel_btnList, "玩家面板_侧边条组合")
	GUI:setAnchorPoint(Panel_btnList, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_btnList, false)
	GUI:setTag(Panel_btnList, 130)
	TAGOBJ["130"] = Panel_btnList

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Panel_btnList, "Button_1", 0, 340, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_1, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTextureDisabled(Button_1, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_1, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#414146")
	GUI:Button_setTitleFontSize(Button_1, 14)
	GUI:Button_titleDisableOutLine(Button_1)
	GUI:setChineseName(Button_1, "玩家面板_装备_按钮")
	GUI:setAnchorPoint(Button_1, 0.00, 1.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 127)
	TAGOBJ["127"] = Button_1

	-- Create Text_name
	local Text_name = GUI:Text_Create(Button_1, "Text_name", 11, 62, 13, "#807256", [[装
备]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_装备_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Button_6
	local Button_6 = GUI:Button_Create(Panel_btnList, "Button_6", 0, 283, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_6, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:Button_loadTextureDisabled(Button_6, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_6, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_6, false)
	GUI:Button_setTitleText(Button_6, [[]])
	GUI:Button_setTitleColor(Button_6, "#414146")
	GUI:Button_setTitleFontSize(Button_6, 14)
	GUI:Button_titleDisableOutLine(Button_6)
	GUI:setChineseName(Button_6, "玩家面板_称号_按钮")
	GUI:setAnchorPoint(Button_6, 0.00, 1.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, 127)
	TAGOBJ["127"] = Button_6

	-- Create Text_name
	Text_name = GUI:Text_Create(Button_6, "Text_name", 11, 62, 13, "#807256", [[称
号]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_称号_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Button_11
	local Button_11 = GUI:Button_Create(Panel_btnList, "Button_11", 0, 226, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_11, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:Button_loadTextureDisabled(Button_11, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_11, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_11, false)
	GUI:Button_setTitleText(Button_11, [[]])
	GUI:Button_setTitleColor(Button_11, "#414146")
	GUI:Button_setTitleFontSize(Button_11, 14)
	GUI:Button_titleDisableOutLine(Button_11)
	GUI:setChineseName(Button_11, "玩家面板_时装_按钮")
	GUI:setAnchorPoint(Button_11, 0.00, 1.00)
	GUI:setTouchEnabled(Button_11, true)
	GUI:setTag(Button_11, 127)
	TAGOBJ["127"] = Button_11

	-- Create Text_name
	Text_name = GUI:Text_Create(Button_11, "Text_name", 11, 62, 13, "#807256", [[时
装]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_时装_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Button_20
	local Button_20 = GUI:Button_Create(Panel_btnList, "Button_20", 0, 170, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_20, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:Button_loadTextureDisabled(Button_20, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_20, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_20, false)
	GUI:Button_setTitleText(Button_20, [[]])
	GUI:Button_setTitleColor(Button_20, "#414146")
	GUI:Button_setTitleFontSize(Button_20, 14)
	GUI:Button_titleEnableOutline(Button_20, "#000000", 1)
	GUI:setChineseName(Button_20, "玩家面板_buff_按钮")
	GUI:setAnchorPoint(Button_20, 0.00, 1.00)
	GUI:setTouchEnabled(Button_20, true)
	GUI:setTag(Button_20, 127)
	GUI:setVisible(Button_20, false)
	TAGOBJ["127"] = Button_20

	-- Create Text_name
	Text_name = GUI:Text_Create(Button_20, "Text_name", 11, 62, 13, "#807256", [[天
赋]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_buff_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Ls_Button
	local Ls_Button = GUI:Button_Create(Panel_1, "Ls_Button", -23, 343, "res/public_win32/1900000683_1_f.png")
	GUI:Button_loadTexturePressed(Ls_Button, "res/public_win32/1900000683_f.png")
	GUI:Button_loadTextureDisabled(Ls_Button, "res/public_win32/1900000683_f.png")
	GUI:setContentSize(Ls_Button, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Ls_Button, false)
	GUI:Button_setTitleText(Ls_Button, [[]])
	GUI:Button_setTitleColor(Ls_Button, "#414146")
	GUI:Button_setTitleFontSize(Ls_Button, 14)
	GUI:Button_titleEnableOutline(Ls_Button, "#000000", 1)
	GUI:setAnchorPoint(Ls_Button, 0.00, 1.00)
	GUI:setTouchEnabled(Ls_Button, true)
	GUI:setTag(Ls_Button, 127)
	TAGOBJ["127"] = Ls_Button

	-- Create Text_name
	Text_name = GUI:Text_Create(Ls_Button, "Text_name", 14, 62, 13, "#807256", [[龙
神]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_buff_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Xm_Button
	local Xm_Button = GUI:Button_Create(Panel_1, "Xm_Button", -23, 275, "res/public_win32/1900000683_1_f.png")
	GUI:Button_loadTexturePressed(Xm_Button, "res/public_win32/1900000683_f.png")
	GUI:Button_loadTextureDisabled(Xm_Button, "res/public_win32/1900000683_f.png")
	GUI:setContentSize(Xm_Button, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Xm_Button, false)
	GUI:Button_setTitleText(Xm_Button, [[]])
	GUI:Button_setTitleColor(Xm_Button, "#414146")
	GUI:Button_setTitleFontSize(Xm_Button, 14)
	GUI:Button_titleEnableOutline(Xm_Button, "#000000", 1)
	GUI:setAnchorPoint(Xm_Button, 0.00, 1.00)
	GUI:setTouchEnabled(Xm_Button, true)
	GUI:setTag(Xm_Button, 127)
	TAGOBJ["127"] = Xm_Button

	-- Create Text_name
	Text_name = GUI:Text_Create(Xm_Button, "Text_name", 14, 62, 13, "#807256", [[血
脉]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_buff_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Zs_Button
	local Zs_Button = GUI:Button_Create(Panel_1, "Zs_Button", -23, 204, "res/public_win32/1900000683_1_f.png")
	GUI:Button_loadTexturePressed(Zs_Button, "res/public_win32/1900000683_f.png")
	GUI:Button_loadTextureDisabled(Zs_Button, "res/public_win32/1900000683_f.png")
	GUI:setContentSize(Zs_Button, 24, 67)
	GUI:setIgnoreContentAdaptWithSize(Zs_Button, false)
	GUI:Button_setTitleText(Zs_Button, [[]])
	GUI:Button_setTitleColor(Zs_Button, "#414146")
	GUI:Button_setTitleFontSize(Zs_Button, 14)
	GUI:Button_titleEnableOutline(Zs_Button, "#000000", 1)
	GUI:setAnchorPoint(Zs_Button, 0.00, 1.00)
	GUI:setTouchEnabled(Zs_Button, true)
	GUI:setTag(Zs_Button, 127)
	TAGOBJ["127"] = Zs_Button

	-- Create Text_name
	Text_name = GUI:Text_Create(Zs_Button, "Text_name", 14, 62, 13, "#807256", [[专
属]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_buff_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
