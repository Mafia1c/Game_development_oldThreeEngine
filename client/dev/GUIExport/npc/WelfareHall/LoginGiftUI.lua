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
	local Image_3 = GUI:Image_Create(ChildLayout, "Image_3", 43, 393, "res/custom/npc/20fl/017fldt1/lxmrdl.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create common_list
	local common_list = GUI:ScrollView_Create(ChildLayout, "common_list", 9, 376, 342, 372, 1)
	GUI:ScrollView_setBounceEnabled(common_list, true)
	GUI:ScrollView_setInnerContainerSize(common_list, 342.00, 372.00)
	GUI:setAnchorPoint(common_list, 0.00, 1.00)
	GUI:setTouchEnabled(common_list, true)
	GUI:setTag(common_list, 0)

	-- Create privilege_list
	local privilege_list = GUI:ScrollView_Create(ChildLayout, "privilege_list", 352, 376, 262, 372, 1)
	GUI:ScrollView_setInnerContainerSize(privilege_list, 262.00, 372.00)
	GUI:setAnchorPoint(privilege_list, 0.00, 1.00)
	GUI:setTouchEnabled(privilege_list, true)
	GUI:setTag(privilege_list, 0)

	ui.update(__data__)
	return ChildLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
