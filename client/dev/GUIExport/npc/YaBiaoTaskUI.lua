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
	GUI:setContentSize(imageBg, 546, 179)
	GUI:setIgnoreContentAdaptWithSize(imageBg, false)
	GUI:setAnchorPoint(imageBg, 0.00, 1.00)
	GUI:setTouchEnabled(imageBg, false)
	GUI:setTag(imageBg, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(imageBg, "closeBtn", 545, 137, "res/public/1900000510.png")
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
	local title_txt1 = GUI:Text_Create(imageBg, "title_txt1", 29, 80, 18, "#ffffff", [[嗯, 是从福威镖局送过来的吧?
一路幸苦啦, 我来点点看东西少了没!
稍等给你丰厚的报酬! 嘿嘿]])
	GUI:Text_enableOutline(title_txt1, "#000000", 1)
	GUI:setAnchorPoint(title_txt1, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt1, false)
	GUI:setTag(title_txt1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(imageBg, "Image_1", 417, 24, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create complete_txt
	local complete_txt = GUI:Text_Create(imageBg, "complete_txt", 440, 23, 18, "#ffff00", [[完成任务]])
	GUI:Text_enableOutline(complete_txt, "#000000", 1)
	GUI:Text_enableUnderline(complete_txt)
	GUI:setAnchorPoint(complete_txt, 0.00, 0.00)
	GUI:setTouchEnabled(complete_txt, true)
	GUI:setTag(complete_txt, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
