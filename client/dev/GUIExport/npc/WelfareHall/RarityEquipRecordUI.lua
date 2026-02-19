local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create ChildLayout
	local ChildLayout = GUI:Layout_Create(parent, "ChildLayout", 150, 31, 608, 441, false)
	GUI:setAnchorPoint(ChildLayout, 0.00, 0.00)
	GUI:setTouchEnabled(ChildLayout, false)
	GUI:setTag(ChildLayout, 0)

	-- Create record_equip_list
	local record_equip_list = GUI:ScrollView_Create(ChildLayout, "record_equip_list", 303, 337, 609, 284, 1)
	GUI:ScrollView_setBounceEnabled(record_equip_list, true)
	GUI:ScrollView_setInnerContainerSize(record_equip_list, 609.00, 285.00)
	GUI:setAnchorPoint(record_equip_list, 0.50, 1.00)
	GUI:setTouchEnabled(record_equip_list, true)
	GUI:setTag(record_equip_list, 0)

	-- Create last_btn
	local last_btn = GUI:Button_Create(ChildLayout, "last_btn", 234, 5, "res/custom/npc/20fl/017fldt4/left.png")
	GUI:setContentSize(last_btn, 32, 36)
	GUI:setIgnoreContentAdaptWithSize(last_btn, false)
	GUI:Button_setTitleText(last_btn, [[]])
	GUI:Button_setTitleColor(last_btn, "#ffffff")
	GUI:Button_setTitleFontSize(last_btn, 16)
	GUI:Button_titleEnableOutline(last_btn, "#000000", 1)
	GUI:setAnchorPoint(last_btn, 0.00, 0.00)
	GUI:setTouchEnabled(last_btn, true)
	GUI:setTag(last_btn, 0)

	-- Create next_btn
	local next_btn = GUI:Button_Create(ChildLayout, "next_btn", 346, 5, "res/custom/npc/20fl/017fldt4/right.png")
	GUI:setContentSize(next_btn, 32, 36)
	GUI:setIgnoreContentAdaptWithSize(next_btn, false)
	GUI:Button_setTitleText(next_btn, [[]])
	GUI:Button_setTitleColor(next_btn, "#ffffff")
	GUI:Button_setTitleFontSize(next_btn, 16)
	GUI:Button_titleEnableOutline(next_btn, "#000000", 1)
	GUI:setAnchorPoint(next_btn, 0.00, 0.00)
	GUI:setTouchEnabled(next_btn, true)
	GUI:setTag(next_btn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(ChildLayout, "Image_1", 267, 8, "res/custom/blackBg2.png")
	GUI:Image_setScale9Slice(Image_1, 5, 5, 10, 10)
	GUI:setContentSize(Image_1, 78, 30)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create page_text
	local page_text = GUI:Text_Create(Image_1, "page_text", 4, 3, 16, "#ffffff", [[第1444页]])
	GUI:setIgnoreContentAdaptWithSize(page_text, false)
	GUI:Text_setTextAreaSize(page_text, 71, 24)
	GUI:Text_setTextHorizontalAlignment(page_text, 1)
	GUI:Text_setTextVerticalAlignment(page_text, 1)
	GUI:Text_enableOutline(page_text, "#000000", 1)
	GUI:setAnchorPoint(page_text, 0.00, 0.00)
	GUI:setTouchEnabled(page_text, false)
	GUI:setTag(page_text, 0)

	ui.update(__data__)
	return ChildLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
