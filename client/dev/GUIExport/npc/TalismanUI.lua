local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setMouseEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 141, 43, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/90cy/bg11.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 819, 481, "res/public/1900000510.png")
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

	-- Create startBtn
	local startBtn = GUI:Button_Create(FrameLayout, "startBtn", 676, 53, "res/custom/npc/90cy/an2.png")
	GUI:setContentSize(startBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(startBtn, false)
	GUI:Button_setTitleText(startBtn, [[]])
	GUI:Button_setTitleColor(startBtn, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn, 18)
	GUI:Button_titleEnableOutline(startBtn, "#000000", 1)
	GUI:setAnchorPoint(startBtn, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn, true)
	GUI:setTag(startBtn, 0)

	-- Create iconImg
	local iconImg = GUI:Image_Create(FrameLayout, "iconImg", 340, 150, "res/custom/npc/90cy/t11.png")
	GUI:setContentSize(iconImg, 82, 46)
	GUI:setIgnoreContentAdaptWithSize(iconImg, false)
	GUI:setAnchorPoint(iconImg, 0.00, 0.00)
	GUI:setTouchEnabled(iconImg, false)
	GUI:setTag(iconImg, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 464, 171, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create attrList
	local attrList = GUI:Layout_Create(FrameLayout, "attrList", 107, 270, 156, 110, false)
	GUI:setAnchorPoint(attrList, 0.00, 0.00)
	GUI:setTouchEnabled(attrList, false)
	GUI:setTag(attrList, 0)

	-- Create nextList
	local nextList = GUI:Layout_Create(FrameLayout, "nextList", 607, 270, 156, 110, false)
	GUI:setAnchorPoint(nextList, 0.00, 0.00)
	GUI:setTouchEnabled(nextList, false)
	GUI:setTag(nextList, 0)

	-- Create node
	local node = GUI:Node_Create(FrameLayout, "node", 55, 22)
	GUI:setTag(node, 0)

	-- Create LoadingBar_bg
	local LoadingBar_bg = GUI:Image_Create(node, "LoadingBar_bg", 366, 189, "res/custom/npc/90cy/jdt1.png")
	GUI:setAnchorPoint(LoadingBar_bg, 0.00, 0.00)
	GUI:setTouchEnabled(LoadingBar_bg, false)
	GUI:setTag(LoadingBar_bg, 0)

	-- Create LoadingBar_icon
	local LoadingBar_icon = GUI:LoadingBar_Create(node, "LoadingBar_icon", 366, 189, "res/custom/npc/90cy/jdt2.png", 0)
	GUI:LoadingBar_setPercent(LoadingBar_icon, 58)
	GUI:setAnchorPoint(LoadingBar_icon, 0.00, 0.00)
	GUI:setTouchEnabled(LoadingBar_icon, false)
	GUI:setTag(LoadingBar_icon, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(node, "Image_1", 244, 192, "res/custom/npc/90cy/t3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
