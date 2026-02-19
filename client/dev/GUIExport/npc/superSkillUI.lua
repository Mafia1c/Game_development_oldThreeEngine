local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:Layout_setBackGroundColorType(CloseLayout, 1)
	GUI:Layout_setBackGroundColor(CloseLayout, "#000000")
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 76)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create test
	local test = GUI:Image_Create(parent, "test", 0, 0, "res/custom/npc/09jn/004cjjn.png")
	GUI:Image_setScale9Slice(test, 113, 113, 213, 213)
	GUI:setContentSize(test, 1136, 640)
	GUI:setIgnoreContentAdaptWithSize(test, false)
	GUI:setAnchorPoint(test, 0.00, 0.00)
	GUI:setTouchEnabled(test, false)
	GUI:setTag(test, -1)
	GUI:setVisible(test, false)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 553, 335, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/09jn/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create title
	local title = GUI:Image_Create(FrameLayout, "title", 458, 503, "res/custom/npc/09jn/cjjn_title.png")
	GUI:Image_setScale9Slice(title, 10, 10, 8, 8)
	GUI:setContentSize(title, 108, 26)
	GUI:setIgnoreContentAdaptWithSize(title, false)
	GUI:setAnchorPoint(title, 0.50, 0.50)
	GUI:setTouchEnabled(title, false)
	GUI:setTag(title, -1)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 838, 506, "res/custom/closeBtn.png")
	GUI:setContentSize(CloseButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.50, 0.50)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	-- Create midList
	local midList = GUI:ListView_Create(FrameLayout, "midList", 438, 294, 724, 360, 2)
	GUI:ListView_setGravity(midList, 3)
	GUI:ListView_setItemsMargin(midList, 6)
	GUI:setAnchorPoint(midList, 0.50, 0.50)
	GUI:setTouchEnabled(midList, true)
	GUI:setTag(midList, 0)

	-- Create box1
	local box1 = GUI:Image_Create(midList, "box1", 0, 0, "res/custom/npc/09jn/1.png")
	GUI:Image_setScale9Slice(box1, 23, 23, 120, 120)
	GUI:setContentSize(box1, 236, 360)
	GUI:setIgnoreContentAdaptWithSize(box1, false)
	GUI:setAnchorPoint(box1, 0.00, 0.00)
	GUI:setTouchEnabled(box1, false)
	GUI:setTag(box1, -1)

	-- Create person1
	local person1 = GUI:Effect_Create(box1, "person1", 90, 176, 4, 4, 0, 0, 4, 1)
	GUI:setScale(person1, 1.20)
	GUI:setTag(person1, 0)

	-- Create skill1
	local skill1 = GUI:Effect_Create(box1, "skill1", 104, 160, 0, 202, 0, 0, 4, 1)
	GUI:setScale(skill1, 0.70)
	GUI:setTag(skill1, 0)

	-- Create box1_1
	local box1_1 = GUI:Image_Create(midList, "box1_1", 242, 0, "res/custom/npc/09jn/1.png")
	GUI:Image_setScale9Slice(box1_1, 23, 23, 120, 120)
	GUI:setContentSize(box1_1, 236, 360)
	GUI:setIgnoreContentAdaptWithSize(box1_1, false)
	GUI:setAnchorPoint(box1_1, 0.00, 0.00)
	GUI:setTouchEnabled(box1_1, false)
	GUI:setTag(box1_1, -1)

	-- Create person1
	person1 = GUI:Effect_Create(box1_1, "person1", 90, 176, 4, 4, 0, 0, 4, 1)
	GUI:setScale(person1, 1.20)
	GUI:setTag(person1, 0)

	-- Create skill1
	skill1 = GUI:Effect_Create(box1_1, "skill1", 104, 160, 0, 202, 0, 0, 4, 1)
	GUI:setScale(skill1, 0.70)
	GUI:setTag(skill1, 0)

	-- Create downBox
	local downBox = GUI:Layout_Create(FrameLayout, "downBox", 436, 66, 730, 82, false)
	GUI:setAnchorPoint(downBox, 0.50, 0.50)
	GUI:setTouchEnabled(downBox, false)
	GUI:setTag(downBox, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(downBox, "upBtn", 630, 42, "res/custom/npc/09jn/lqjn1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/09jn/lqjn2.png")
	GUI:setContentSize(upBtn, 110, 42)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[]])
	GUI:Button_setTitleColor(upBtn, "#ffffff")
	GUI:Button_setTitleFontSize(upBtn, 10)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, -1)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
