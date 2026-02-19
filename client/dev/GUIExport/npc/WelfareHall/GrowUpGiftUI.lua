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
	local Image_3 = GUI:Image_Create(ChildLayout, "Image_3", 43, 378, "res/custom/npc/20fl/017fldt3/nlwwls.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create grow_up_list
	local grow_up_list = GUI:ScrollView_Create(ChildLayout, "grow_up_list", 9, 356, 501, 352, 2)
	GUI:ScrollView_setBounceEnabled(grow_up_list, true)
	GUI:ScrollView_setInnerContainerSize(grow_up_list, 621.00, 352.00)
	GUI:setAnchorPoint(grow_up_list, 0.00, 1.00)
	GUI:setTouchEnabled(grow_up_list, true)
	GUI:setTag(grow_up_list, 0)

	-- Create grow_up_text
	local grow_up_text = GUI:Text_Create(ChildLayout, "grow_up_text", 11, 356, 16, "#00ff00", [[开启首冲【等级奖励双倍赠送】，开启特权【境界奖励双倍赠送】]])
	GUI:Text_enableOutline(grow_up_text, "#000000", 1)
	GUI:setAnchorPoint(grow_up_text, 0.00, 0.00)
	GUI:setTouchEnabled(grow_up_text, false)
	GUI:setTag(grow_up_text, 0)

	-- Create special_box
	local special_box = GUI:Image_Create(ChildLayout, "special_box", 509, -1, "res/custom/npc/20fl/017fldt3/tag14.png")
	GUI:setAnchorPoint(special_box, 0.00, 0.00)
	GUI:setTouchEnabled(special_box, false)
	GUI:setTag(special_box, 0)

	ui.update(__data__)
	return ChildLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
