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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 174, 51, 790, 418, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/24kb/bg1.png")
	GUI:setContentSize(bg_Image, 790, 418)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 633, 319, "res/public/btn_shouchong_06.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/btn_shouchong_06_1.png")
	GUI:setContentSize(closeBtn, 37, 38)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create lf_btn
	local lf_btn = GUI:Button_Create(FrameLayout, "lf_btn", 296, 27, "res/public/1900000662.png")
	GUI:setContentSize(lf_btn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(lf_btn, false)
	GUI:Button_setTitleText(lf_btn, [[灵符开启]])
	GUI:Button_setTitleColor(lf_btn, "#ffffff")
	GUI:Button_setTitleFontSize(lf_btn, 18)
	GUI:Button_titleEnableOutline(lf_btn, "#000000", 1)
	GUI:setAnchorPoint(lf_btn, 0.00, 0.00)
	GUI:setTouchEnabled(lf_btn, true)
	GUI:setTag(lf_btn, 0)

	-- Create jgs_btn
	local jgs_btn = GUI:Button_Create(FrameLayout, "jgs_btn", 478, 28, "res/public/1900000662.png")
	GUI:setContentSize(jgs_btn, 97, 32)
	GUI:setIgnoreContentAdaptWithSize(jgs_btn, false)
	GUI:Button_setTitleText(jgs_btn, [[金刚石开启]])
	GUI:Button_setTitleColor(jgs_btn, "#ffffff")
	GUI:Button_setTitleFontSize(jgs_btn, 18)
	GUI:Button_titleEnableOutline(jgs_btn, "#000000", 1)
	GUI:setAnchorPoint(jgs_btn, 0.00, 0.00)
	GUI:setTouchEnabled(jgs_btn, true)
	GUI:setTag(jgs_btn, 0)

	-- Create activation
	local activation = GUI:Image_Create(FrameLayout, "activation", 452, 31, "res/custom/tag/iconjh.png")
	GUI:setAnchorPoint(activation, 0.00, 0.00)
	GUI:setTouchEnabled(activation, false)
	GUI:setTag(activation, 0)
	GUI:setVisible(activation, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
