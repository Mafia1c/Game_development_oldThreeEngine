local ui = {}
function ui.init(parent)
	-- Create Main_Panel
	local Main_Panel = GUI:Layout_Create(parent, "Main_Panel", 465.00, 176.00, 62.00, 62.00, false)
	GUI:setTouchEnabled(Main_Panel, true)
	GUI:setTag(Main_Panel, -1)

	-- Create targetBtn
	local targetBtn = GUI:Button_Create(Main_Panel, "targetBtn", 0.00, 0.00, "res/private/main/target_1.png")
	GUI:Button_loadTexturePressed(targetBtn, "res/private/main/target_2.png")
	GUI:Button_loadTextureDisabled(targetBtn, "res/private/main/target_2.png")
	GUI:Button_setTitleText(targetBtn, "")
	GUI:Button_setTitleColor(targetBtn, "#ffffff")
	GUI:Button_setTitleFontSize(targetBtn, 14)
	GUI:Button_titleEnableOutline(targetBtn, "#000000", 1)
	GUI:setTouchEnabled(targetBtn, true)
	GUI:setTag(targetBtn, -1)
end
return ui