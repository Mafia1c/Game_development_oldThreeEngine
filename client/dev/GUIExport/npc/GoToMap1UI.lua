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
	GUI:setMouseEnabled(Scene, true)
	GUI:setTag(Scene, -1)

	-- Create ImageBg
	local ImageBg = GUI:Image_Create(Scene, "ImageBg", 0, _V("SCREEN_HEIGHT"), "res/public/bg_npc_01.png")
	GUI:setContentSize(ImageBg, 546, 198)
	GUI:setIgnoreContentAdaptWithSize(ImageBg, false)
	GUI:setAnchorPoint(ImageBg, 0.00, 1.00)
	GUI:setTouchEnabled(ImageBg, false)
	GUI:setTag(ImageBg, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(ImageBg, "Image_1", 20, 143, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create map_tc
	local map_tc = GUI:Text_Create(ImageBg, "map_tc", 43, 140, 18, "#ffff00", [[盟重土城]])
	GUI:Text_enableOutline(map_tc, "#000000", 1)
	GUI:Text_enableUnderline(map_tc)
	GUI:setAnchorPoint(map_tc, 0.00, 0.00)
	GUI:setTouchEnabled(map_tc, true)
	GUI:setTag(map_tc, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(ImageBg, "Image_2", 173, 143, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create map_zy
	local map_zy = GUI:Text_Create(ImageBg, "map_zy", 43, 88, 18, "#ffff00", [[庄园]])
	GUI:Text_enableOutline(map_zy, "#000000", 1)
	GUI:Text_enableUnderline(map_zy)
	GUI:setAnchorPoint(map_zy, 0.00, 0.00)
	GUI:setTouchEnabled(map_zy, true)
	GUI:setTag(map_zy, 0)

	-- Create map_mlc
	local map_mlc = GUI:Text_Create(ImageBg, "map_mlc", 43, 33, 18, "#ffff00", [[魔龙城]])
	GUI:Text_enableOutline(map_mlc, "#000000", 1)
	GUI:Text_enableUnderline(map_mlc)
	GUI:setAnchorPoint(map_mlc, 0.00, 0.00)
	GUI:setTouchEnabled(map_mlc, true)
	GUI:setTag(map_mlc, 0)

	-- Create map_bqcb
	local map_bqcb = GUI:Text_Create(ImageBg, "map_bqcb", 194, 140, 18, "#ffff00", [[比奇城堡]])
	GUI:Text_enableOutline(map_bqcb, "#000000", 1)
	GUI:Text_enableUnderline(map_bqcb)
	GUI:setAnchorPoint(map_bqcb, 0.00, 0.00)
	GUI:setTouchEnabled(map_bqcb, true)
	GUI:setTag(map_bqcb, 0)

	-- Create map_fmsg
	local map_fmsg = GUI:Text_Create(ImageBg, "map_fmsg", 194, 88, 18, "#ffff00", [[封魔神谷]])
	GUI:Text_enableOutline(map_fmsg, "#000000", 1)
	GUI:Text_enableUnderline(map_fmsg)
	GUI:setAnchorPoint(map_fmsg, 0.00, 0.00)
	GUI:setTouchEnabled(map_fmsg, true)
	GUI:setTag(map_fmsg, 0)

	-- Create map_yjzm
	local map_yjzm = GUI:Text_Create(ImageBg, "map_yjzm", 194, 33, 18, "#ffff00", [[异界之门]])
	GUI:Text_enableOutline(map_yjzm, "#000000", 1)
	GUI:Text_enableUnderline(map_yjzm)
	GUI:setAnchorPoint(map_yjzm, 0.00, 0.00)
	GUI:setTouchEnabled(map_yjzm, true)
	GUI:setTag(map_yjzm, 0)

	-- Create map_brm
	local map_brm = GUI:Text_Create(ImageBg, "map_brm", 358, 140, 18, "#ffff00", [[白日门]])
	GUI:Text_enableOutline(map_brm, "#000000", 1)
	GUI:Text_enableUnderline(map_brm)
	GUI:setAnchorPoint(map_brm, 0.00, 0.00)
	GUI:setTouchEnabled(map_brm, true)
	GUI:setTag(map_brm, 0)

	-- Create map_cyd
	local map_cyd = GUI:Text_Create(ImageBg, "map_cyd", 358, 88, 18, "#ffff00", [[苍月岛]])
	GUI:Text_enableOutline(map_cyd, "#000000", 1)
	GUI:Text_enableUnderline(map_cyd)
	GUI:setAnchorPoint(map_cyd, 0.00, 0.00)
	GUI:setTouchEnabled(map_cyd, true)
	GUI:setTag(map_cyd, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(ImageBg, "Image_3", 335, 143, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(ImageBg, "Image_4", 20, 90, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(ImageBg, "Image_5", 173, 90, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(ImageBg, "Image_6", 335, 90, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create Image_7
	local Image_7 = GUI:Image_Create(ImageBg, "Image_7", 20, 36, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_7, 0.00, 0.00)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, 0)

	-- Create Image_8
	local Image_8 = GUI:Image_Create(ImageBg, "Image_8", 173, 36, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_8, 0.00, 0.00)
	GUI:setTouchEnabled(Image_8, false)
	GUI:setTag(Image_8, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(Scene, "closeBtn", 545, 597, "res/public/1900000510.png")
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

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
