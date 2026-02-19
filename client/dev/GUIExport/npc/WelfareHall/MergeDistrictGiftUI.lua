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

	-- Create merge_district_list
	local merge_district_list = GUI:ScrollView_Create(ChildLayout, "merge_district_list", 4, 367, 604, 314, 1)
	GUI:ScrollView_setBounceEnabled(merge_district_list, true)
	GUI:ScrollView_setInnerContainerSize(merge_district_list, 604.00, 370.00)
	GUI:setAnchorPoint(merge_district_list, 0.00, 1.00)
	GUI:setTouchEnabled(merge_district_list, true)
	GUI:setTag(merge_district_list, 0)

	-- Create merge_end_time
	local merge_end_time = GUI:Text_Create(ChildLayout, "merge_end_time", 10, 10, 16, "#00ff00", [[限购倒计时:8时59分32秒]])
	GUI:Text_enableOutline(merge_end_time, "#000000", 1)
	GUI:setAnchorPoint(merge_end_time, 0.00, 0.00)
	GUI:setTouchEnabled(merge_end_time, false)
	GUI:setTag(merge_end_time, 0)

	ui.update(__data__)
	return ChildLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
