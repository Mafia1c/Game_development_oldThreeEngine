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

	-- Create recharge_list
	local recharge_list = GUI:ScrollView_Create(ChildLayout, "recharge_list", 0, 356, 609, 352, 1)
	GUI:ScrollView_setBounceEnabled(recharge_list, true)
	GUI:ScrollView_setInnerContainerSize(recharge_list, 609.00, 352.00)
	GUI:setAnchorPoint(recharge_list, 0.00, 1.00)
	GUI:setTouchEnabled(recharge_list, true)
	GUI:setTag(recharge_list, 0)

	-- Create today_recharge
	local today_recharge = GUI:Text_Create(ChildLayout, "today_recharge", 2, 356, 16, "#00ff00", [[今日充值金额：0元]])
	GUI:Text_enableOutline(today_recharge, "#000000", 1)
	GUI:setAnchorPoint(today_recharge, 0.00, 0.00)
	GUI:setTouchEnabled(today_recharge, false)
	GUI:setTag(today_recharge, 0)

	-- Create accumulate_recharge
	local accumulate_recharge = GUI:Text_Create(ChildLayout, "accumulate_recharge", 248, 356, 16, "#00ff00", [[今日充值金额：0元]])
	GUI:Text_enableOutline(accumulate_recharge, "#000000", 1)
	GUI:setAnchorPoint(accumulate_recharge, 0.00, 0.00)
	GUI:setTouchEnabled(accumulate_recharge, false)
	GUI:setTag(accumulate_recharge, 0)

	ui.update(__data__)
	return ChildLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
