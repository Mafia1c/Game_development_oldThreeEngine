local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Layout_Create(parent, "Scene", 0, 0, _V("SCREEN_WIDTH"), _V("SCREEN_HEIGHT"), false)
	GUI:setAnchorPoint(Scene, 0.00, 0.00)
	GUI:setTouchEnabled(Scene, true)
	GUI:setMouseEnabled(Scene, true)
	GUI:setTag(Scene, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Image_Create(Scene, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, "res/public/1900000665.png")
	GUI:setContentSize(FrameLayout, 324, 199)
	GUI:setIgnoreContentAdaptWithSize(FrameLayout, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create title_text
	local title_text = GUI:Text_Create(FrameLayout, "title_text", 113, 152, 18, "#00ff00", [["战斗死亡"]])
	GUI:Text_enableOutline(title_text, "#000000", 1)
	GUI:setAnchorPoint(title_text, 0.00, 0.00)
	GUI:setTouchEnabled(title_text, false)
	GUI:setTag(title_text, 0)

	-- Create die_txt
	local die_txt = GUI:Text_Create(FrameLayout, "die_txt", 158, 98, 16, "#00ffe8", [==========[你被[- -]杀死了!]==========])
	GUI:Text_enableOutline(die_txt, "#000000", 1)
	GUI:setAnchorPoint(die_txt, 0.50, 0.00)
	GUI:setTouchEnabled(die_txt, false)
	GUI:setTag(die_txt, 0)

	-- Create reviveBtn1
	local reviveBtn1 = GUI:Button_Create(FrameLayout, "reviveBtn1", 122, 50, "res/public/1900000653.png")
	GUI:setContentSize(reviveBtn1, 82, 29)
	GUI:setIgnoreContentAdaptWithSize(reviveBtn1, false)
	GUI:Button_setTitleText(reviveBtn1, [[回城复活]])
	GUI:Button_setTitleColor(reviveBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(reviveBtn1, 14)
	GUI:Button_titleEnableOutline(reviveBtn1, "#000000", 1)
	GUI:setAnchorPoint(reviveBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(reviveBtn1, true)
	GUI:setTag(reviveBtn1, 0)

	-- Create reviveBtn2
	local reviveBtn2 = GUI:Button_Create(FrameLayout, "reviveBtn2", 190, 50, "res/public/1900000653.png")
	GUI:setContentSize(reviveBtn2, 82, 29)
	GUI:setIgnoreContentAdaptWithSize(reviveBtn2, false)
	GUI:Button_setTitleText(reviveBtn2, [[原地复活]])
	GUI:Button_setTitleColor(reviveBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(reviveBtn2, 16)
	GUI:Button_titleEnableOutline(reviveBtn2, "#000000", 1)
	GUI:setAnchorPoint(reviveBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(reviveBtn2, true)
	GUI:setTag(reviveBtn2, 0)
	GUI:setVisible(reviveBtn2, false)

	-- Create revive_txt1
	local revive_txt1 = GUI:Text_Create(FrameLayout, "revive_txt1", 162, 30, 14, "#ff0000", [[5秒]])
	GUI:Text_enableOutline(revive_txt1, "#000000", 1)
	GUI:setAnchorPoint(revive_txt1, 0.50, 0.00)
	GUI:setTouchEnabled(revive_txt1, false)
	GUI:setTag(revive_txt1, 0)

	-- Create revive_txt2
	local revive_txt2 = GUI:Text_Create(FrameLayout, "revive_txt2", 233, 30, 14, "#9b00ff", [["50灵符"]])
	GUI:Text_enableOutline(revive_txt2, "#000000", 1)
	GUI:setAnchorPoint(revive_txt2, 0.50, 0.00)
	GUI:setTouchEnabled(revive_txt2, false)
	GUI:setTag(revive_txt2, 0)
	GUI:setVisible(revive_txt2, false)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
