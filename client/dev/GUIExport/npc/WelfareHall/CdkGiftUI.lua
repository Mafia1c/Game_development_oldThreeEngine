local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create ChildLayout
	local ChildLayout = GUI:Layout_Create(parent, "ChildLayout", 149, 29, 610, 444, false)
	GUI:setAnchorPoint(ChildLayout, 0.00, 0.00)
	GUI:setTouchEnabled(ChildLayout, false)
	GUI:setTag(ChildLayout, 0)

	-- Create get_btn
	local get_btn = GUI:Button_Create(ChildLayout, "get_btn", 380, 126, "res/custom/npc/20fl/cdk/an.png")
	GUI:setContentSize(get_btn, 166, 50)
	GUI:setIgnoreContentAdaptWithSize(get_btn, false)
	GUI:Button_setTitleText(get_btn, [[]])
	GUI:Button_setTitleColor(get_btn, "#ffffff")
	GUI:Button_setTitleFontSize(get_btn, 16)
	GUI:Button_titleDisableOutLine(get_btn)
	GUI:setAnchorPoint(get_btn, 0.00, 0.00)
	GUI:setTouchEnabled(get_btn, true)
	GUI:setTag(get_btn, 0)

	-- Create TextInput
	local TextInput = GUI:TextInput_Create(ChildLayout, "TextInput", 393, 220, 134, 37, 16)
	GUI:TextInput_setString(TextInput, "")
	GUI:TextInput_setFontColor(TextInput, "#ffffff")
	GUI:TextInput_setPlaceholderFontColor(TextInput, "#a6a6a6")
	GUI:TextInput_setTextVerticalAlignment(TextInput, 1)
	GUI:TextInput_setInputMode(TextInput, 0)
	GUI:setAnchorPoint(TextInput, 0.00, 0.00)
	GUI:setTouchEnabled(TextInput, true)
	GUI:setTag(TextInput, 0)

	ui.update(__data__)
	return ChildLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
