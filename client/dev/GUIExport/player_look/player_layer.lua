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
	local Panel_1 = GUI:Layout_Create(Scene, "Panel_1", 688, 340, 382, 571, false)
	GUI:setChineseName(Panel_1, "玩家面板_组合")
	GUI:setAnchorPoint(Panel_1, 0.00, 0.50)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 2)
	TAGOBJ["2"] = Panel_1

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_1, "Image_bg", 191, 285, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015000.png")
	GUI:setChineseName(Image_bg, "玩家面板_背景图")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 3)
	TAGOBJ["3"] = Image_bg

	-- Create Text_Name
	local Text_Name = GUI:Text_Create(Panel_1, "Text_Name", 191, 523, 18, "#ffe400", [[]])
	GUI:Text_enableOutline(Text_Name, "#0e0e0e", 1)
	GUI:setChineseName(Text_Name, "玩家面板_玩家昵称_文本")
	GUI:setAnchorPoint(Text_Name, 0.50, 0.50)
	GUI:setTouchEnabled(Text_Name, false)
	GUI:setTag(Text_Name, 75)
	TAGOBJ["75"] = Text_Name

	-- Create ButtonClose
	local ButtonClose = GUI:Button_Create(Panel_1, "ButtonClose", 397, 487, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(ButtonClose, "res/public/1900000511.png")
	GUI:Button_loadTextureDisabled(ButtonClose, "Default/Button_Disable.png")
	GUI:Button_setScale9Slice(ButtonClose, 8, 6, 12, 10)
	GUI:Button_setTitleText(ButtonClose, [[]])
	GUI:Button_setTitleColor(ButtonClose, "#414146")
	GUI:Button_setTitleFontSize(ButtonClose, 14)
	GUI:Button_titleDisableOutLine(ButtonClose)
	GUI:setChineseName(ButtonClose, "玩家面板_关闭按钮")
	GUI:setAnchorPoint(ButtonClose, 0.50, 0.50)
	GUI:setTouchEnabled(ButtonClose, true)
	GUI:setTag(ButtonClose, 29)
	TAGOBJ["29"] = ButtonClose

	-- Create Node_panel
	local Node_panel = GUI:Node_Create(Panel_1, "Node_panel", 17, 12)
	GUI:setChineseName(Node_panel, "玩家面板_节点")
	GUI:setTag(Node_panel, 26)
	TAGOBJ["26"] = Node_panel

	-- Create Panel_btnList
	local Panel_btnList = GUI:Layout_Create(Panel_1, "Panel_btnList", 382, 456, 32, 454, false)
	GUI:setChineseName(Panel_btnList, "玩家面板_侧边条组合")
	GUI:setAnchorPoint(Panel_btnList, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_btnList, true)
	GUI:setTag(Panel_btnList, 26)
	TAGOBJ["26"] = Panel_btnList

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Panel_btnList, "Button_1", 0, 454, "res/public/1900000641.png")
	GUI:Button_loadTexturePressed(Button_1, "res/public/1900000640.png")
	GUI:Button_loadTextureDisabled(Button_1, "res/public/1900000640.png")
	GUI:setContentSize(Button_1, 30, 87)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 14)
	GUI:Button_titleDisableOutLine(Button_1)
	GUI:setChineseName(Button_1, "玩家面板_装备_按钮")
	GUI:setAnchorPoint(Button_1, 0.00, 1.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, -1)

	-- Create Text_name
	local Text_name = GUI:Text_Create(Button_1, "Text_name", 13, 78, 16, "#807256", [[装
备]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_装备_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, -1)

	-- Create Button_6
	local Button_6 = GUI:Button_Create(Panel_btnList, "Button_6", 0, 382, "res/public/1900000641.png")
	GUI:Button_loadTexturePressed(Button_6, "res/public/1900000640.png")
	GUI:Button_loadTextureDisabled(Button_6, "res/public/1900000640.png")
	GUI:setContentSize(Button_6, 30, 87)
	GUI:setIgnoreContentAdaptWithSize(Button_6, false)
	GUI:Button_setTitleText(Button_6, [[]])
	GUI:Button_setTitleColor(Button_6, "#ffffff")
	GUI:Button_setTitleFontSize(Button_6, 14)
	GUI:Button_titleDisableOutLine(Button_6)
	GUI:setChineseName(Button_6, "玩家面板_称号_按钮")
	GUI:setAnchorPoint(Button_6, 0.00, 1.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, -1)

	-- Create Text_name
	Text_name = GUI:Text_Create(Button_6, "Text_name", 13, 78, 16, "#807256", [[称
号]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_称号_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, -1)

	-- Create Button_11
	local Button_11 = GUI:Button_Create(Panel_btnList, "Button_11", 0, 310, "res/public/1900000641.png")
	GUI:Button_loadTexturePressed(Button_11, "res/public/1900000640.png")
	GUI:Button_loadTextureDisabled(Button_11, "res/public/1900000640.png")
	GUI:setContentSize(Button_11, 30, 87)
	GUI:setIgnoreContentAdaptWithSize(Button_11, false)
	GUI:Button_setTitleText(Button_11, [[]])
	GUI:Button_setTitleColor(Button_11, "#ffffff")
	GUI:Button_setTitleFontSize(Button_11, 14)
	GUI:Button_titleDisableOutLine(Button_11)
	GUI:setChineseName(Button_11, "玩家面板_时装_按钮")
	GUI:setAnchorPoint(Button_11, 0.00, 1.00)
	GUI:setTouchEnabled(Button_11, true)
	GUI:setTag(Button_11, -1)

	-- Create Text_name
	Text_name = GUI:Text_Create(Button_11, "Text_name", 13, 78, 16, "#807256", [[时
装]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_时装_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, -1)

	-- Create Button_20
	local Button_20 = GUI:Button_Create(Panel_btnList, "Button_20", 0, 238, "res/public/1900000641.png")
	GUI:Button_loadTexturePressed(Button_20, "res/public/1900000640.png")
	GUI:Button_loadTextureDisabled(Button_20, "res/public/1900000640.png")
	GUI:setContentSize(Button_20, 30, 87)
	GUI:setIgnoreContentAdaptWithSize(Button_20, false)
	GUI:Button_setTitleText(Button_20, [[]])
	GUI:Button_setTitleColor(Button_20, "#ffffff")
	GUI:Button_setTitleFontSize(Button_20, 14)
	GUI:Button_titleEnableOutline(Button_20, "#000000", 1)
	GUI:setChineseName(Button_20, "玩家面板_buff_按钮")
	GUI:setAnchorPoint(Button_20, 0.00, 1.00)
	GUI:setTouchEnabled(Button_20, true)
	GUI:setTag(Button_20, -1)
	GUI:setVisible(Button_20, false)

	-- Create Text_name
	Text_name = GUI:Text_Create(Button_20, "Text_name", 13, 78, 16, "#807256", [[天
赋]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_buff_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, -1)

	-- Create Xm_Button
	local Xm_Button = GUI:Button_Create(Panel_1, "Xm_Button", -45, 143, "res/custom/npc/23xm/an1.png")
	GUI:setContentSize(Xm_Button, 48, 130)
	GUI:setIgnoreContentAdaptWithSize(Xm_Button, false)
	GUI:Button_setTitleText(Xm_Button, [[]])
	GUI:Button_setTitleColor(Xm_Button, "#ffffff")
	GUI:Button_setTitleFontSize(Xm_Button, 16)
	GUI:Button_titleEnableOutline(Xm_Button, "#000000", 1)
	GUI:setAnchorPoint(Xm_Button, 0.00, 0.00)
	GUI:setTouchEnabled(Xm_Button, true)
	GUI:setTag(Xm_Button, 0)

	-- Create Zs_Button
	local Zs_Button = GUI:Button_Create(Panel_1, "Zs_Button", -45, 8, "res/custom/npc/53slzs/an1.png")
	GUI:setContentSize(Zs_Button, 48, 130)
	GUI:setIgnoreContentAdaptWithSize(Zs_Button, false)
	GUI:Button_setTitleText(Zs_Button, [[]])
	GUI:Button_setTitleColor(Zs_Button, "#ffffff")
	GUI:Button_setTitleFontSize(Zs_Button, 16)
	GUI:Button_titleEnableOutline(Zs_Button, "#000000", 1)
	GUI:setAnchorPoint(Zs_Button, 0.00, 0.00)
	GUI:setTouchEnabled(Zs_Button, true)
	GUI:setTag(Zs_Button, 0)

	-- Create Ls_Button
	local Ls_Button = GUI:Button_Create(Panel_1, "Ls_Button", -45, 279, "res/custom/npc/70ah/an2.png")
	GUI:setContentSize(Ls_Button, 48, 130)
	GUI:setIgnoreContentAdaptWithSize(Ls_Button, false)
	GUI:Button_setTitleText(Ls_Button, [[]])
	GUI:Button_setTitleColor(Ls_Button, "#ffffff")
	GUI:Button_setTitleFontSize(Ls_Button, 16)
	GUI:Button_titleEnableOutline(Ls_Button, "#000000", 1)
	GUI:setAnchorPoint(Ls_Button, 0.00, 0.00)
	GUI:setTouchEnabled(Ls_Button, true)
	GUI:setTag(Ls_Button, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
