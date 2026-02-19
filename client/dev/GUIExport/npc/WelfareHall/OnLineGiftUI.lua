local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create ChildLayout
	local ChildLayout = GUI:Layout_Create(parent, "ChildLayout", 141, 29, 622, 444, false)
	GUI:setAnchorPoint(ChildLayout, 0.00, 0.00)
	GUI:setTouchEnabled(ChildLayout, false)
	GUI:setTag(ChildLayout, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(ChildLayout, "Image_3", 43, 378, "res/custom/npc/20fl/017fldt2/ljzxyx.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create online_list
	local online_list = GUI:ScrollView_Create(ChildLayout, "online_list", 1, 376, 621, 372, 1)
	GUI:ScrollView_setBounceEnabled(online_list, true)
	GUI:ScrollView_setInnerContainerSize(online_list, 621.00, 372.00)
	GUI:setAnchorPoint(online_list, 0.00, 1.00)
	GUI:setTouchEnabled(online_list, true)
	GUI:setTag(online_list, 0)

	-- Create online_text
	local online_text = GUI:Text_Create(ChildLayout, "online_text", 19, 380, 16, "#00ff00", [[今日在线时长：63分钟]])
	GUI:Text_enableOutline(online_text, "#000000", 1)
	GUI:setAnchorPoint(online_text, 0.00, 0.00)
	GUI:setTouchEnabled(online_text, false)
	GUI:setTag(online_text, 0)

	ui.update(__data__)
	return ChildLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
