local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Layout_Create(parent, "Scene", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, _V("SCREEN_WIDTH"), _V("SCREEN_HEIGHT"), false)
	GUI:setAnchorPoint(Scene, 0.50, 0.50)
	GUI:setTouchEnabled(Scene, true)
	GUI:setTag(Scene, -1)

	-- Create imageBg
	local imageBg = GUI:Image_Create(Scene, "imageBg", 0, _V("SCREEN_HEIGHT"), "res/public/bg_npc_01.png")
	GUI:Image_setScale9Slice(imageBg, 20, 20, 20, 20)
	GUI:setContentSize(imageBg, 546, 276)
	GUI:setIgnoreContentAdaptWithSize(imageBg, false)
	GUI:setAnchorPoint(imageBg, 0.00, 1.00)
	GUI:setTouchEnabled(imageBg, false)
	GUI:setTag(imageBg, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(imageBg, "closeBtn", 546, 233, "res/public/1900000510.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/1900000511.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create title_txt1
	local title_txt1 = GUI:Text_Create(imageBg, "title_txt1", 21, 206, 18, "#ff9b00", [[国王有令:  为天下最强的勇士树立雕像, 彰显他们的地位
若你是群雄中的最强者, 从此以后你就可以名扬天下了!]])
	GUI:Text_enableOutline(title_txt1, "#000000", 1)
	GUI:setAnchorPoint(title_txt1, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt1, false)
	GUI:setTag(title_txt1, 0)

	-- Create line_txt1
	local line_txt1 = GUI:Text_Create(imageBg, "line_txt1", 20, 188, 16, "#9b00ff", [[..................................................................................................]])
	GUI:Text_enableOutline(line_txt1, "#000000", 1)
	GUI:setAnchorPoint(line_txt1, 0.00, 0.00)
	GUI:setTouchEnabled(line_txt1, false)
	GUI:setTag(line_txt1, 0)

	-- Create line_txt2
	local line_txt2 = GUI:Text_Create(imageBg, "line_txt2", 20, 55, 16, "#9b00ff", [[..................................................................................................]])
	GUI:Text_enableOutline(line_txt2, "#000000", 1)
	GUI:setAnchorPoint(line_txt2, 0.00, 0.00)
	GUI:setTouchEnabled(line_txt2, false)
	GUI:setTag(line_txt2, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(imageBg, "Image_1", 25, 22, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create up_rule_txt
	local up_rule_txt = GUI:Text_Create(imageBg, "up_rule_txt", 45, 20, 16, "#ffff00", [[上榜规则]])
	GUI:Text_enableOutline(up_rule_txt, "#000000", 1)
	GUI:Text_enableUnderline(up_rule_txt)
	GUI:setAnchorPoint(up_rule_txt, 0.00, 0.00)
	GUI:setTouchEnabled(up_rule_txt, true)
	GUI:setTag(up_rule_txt, 0)

	-- Create title_txt2
	local title_txt2 = GUI:Text_Create(imageBg, "title_txt2", 233, 20, 16, "#ff0000", [[天下第一:  1.1倍神力]])
	GUI:Text_enableOutline(title_txt2, "#000000", 1)
	GUI:setAnchorPoint(title_txt2, 0.50, 0.00)
	GUI:setTouchEnabled(title_txt2, false)
	GUI:setTag(title_txt2, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(imageBg, "Image_2", 360, 22, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create apply_txt
	local apply_txt = GUI:Text_Create(imageBg, "apply_txt", 382, 20, 16, "#ffff00", [[立刻申请]])
	GUI:Text_enableOutline(apply_txt, "#000000", 1)
	GUI:Text_enableUnderline(apply_txt)
	GUI:setAnchorPoint(apply_txt, 0.00, 0.00)
	GUI:setTouchEnabled(apply_txt, true)
	GUI:setTag(apply_txt, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
