local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/68fw/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create panel
	local panel = GUI:ListView_Create(FrameBG, "panel", 83, 49, 423, 422, 1)
	GUI:ListView_setBounceEnabled(panel, true)
	GUI:ListView_setGravity(panel, 2)
	GUI:setAnchorPoint(panel, 0.00, 0.00)
	GUI:setTouchEnabled(panel, true)
	GUI:setTag(panel, 0)

	-- Create ListView
	local ListView = GUI:Layout_Create(panel, "ListView", 211, 422, 422, 500, false)
	GUI:setAnchorPoint(ListView, 0.50, 1.00)
	GUI:setTouchEnabled(ListView, false)
	GUI:setTag(ListView, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameBG, "Text_1", 539, 311, 16, "#ffff00", [[首次解密符文之语，可获得：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create has_active_num
	local has_active_num = GUI:Text_Create(FrameBG, "has_active_num", 588, 144, 16, "#ff43ff", [[已解密数量：0件]])
	GUI:Text_enableOutline(has_active_num, "#000000", 1)
	GUI:setAnchorPoint(has_active_num, 0.00, 0.00)
	GUI:setTouchEnabled(has_active_num, false)
	GUI:setTag(has_active_num, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameBG, "Text_2", 564, 101, 16, "#ffff00", [[每次解密符文需要灵符x1000]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(FrameBG, "Text_4", 575, 46, 16, "#00ff00", [[重复解密奖励：
声望x100+金刚石x2000]])
	GUI:setIgnoreContentAdaptWithSize(Text_4, false)
	GUI:Text_setTextAreaSize(Text_4, 170, 48)
	GUI:Text_setTextHorizontalAlignment(Text_4, 1)
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(FrameBG, "Text_5", 540, 212, 16, "#00ff00", [[体力加成：2%
攻魔道伤：1%
防御加成：1%
魔御加成：1%]])
	GUI:setIgnoreContentAdaptWithSize(Text_5, false)
	GUI:Text_setTextAreaSize(Text_5, 107, 96)
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 819, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
