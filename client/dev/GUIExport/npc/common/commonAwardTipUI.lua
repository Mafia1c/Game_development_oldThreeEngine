local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create close_btn
	local close_btn = GUI:Layout_Create(parent, "close_btn", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setMouseEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 602, 279, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 68, 358, 0, 15213, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 1, 1, "res/custom/myui/tc/additem/additem_bg.png")
	GUI:Image_setScale9Slice(Image_1, 60, 60, 93, 93)
	GUI:setContentSize(Image_1, 602, 279)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 237, 184, "res/custom/myui/tc/additem/bag_text_1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create awardList
	local awardList = GUI:ScrollView_Create(FrameLayout, "awardList", 308, 122, 517, 98, 2)
	GUI:ScrollView_setInnerContainerSize(awardList, 710.00, 98.00)
	GUI:setAnchorPoint(awardList, 0.50, 0.50)
	GUI:setTouchEnabled(awardList, true)
	GUI:setTag(awardList, 0)

	-- Create closeText
	local closeText = GUI:Text_Create(FrameLayout, "closeText", 534, 8, 20, "#00ff00", [[4秒后自动关闭]])
	GUI:Text_enableOutline(closeText, "#000000", 1)
	GUI:setAnchorPoint(closeText, 1.00, 0.00)
	GUI:setTouchEnabled(closeText, false)
	GUI:setTag(closeText, 0)

	ui.update(__data__)
	return close_btn
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
