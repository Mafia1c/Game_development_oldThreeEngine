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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 174, 51, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/12bl/bg1.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 820, 482, "res/public/1900000510.png")
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

	-- Create startBtn1
	local startBtn1 = GUI:Button_Create(FrameLayout, "startBtn1", 575, 79, "res/public/1900000674.png")
	GUI:setContentSize(startBtn1, 92, 35)
	GUI:setIgnoreContentAdaptWithSize(startBtn1, false)
	GUI:Button_setTitleText(startBtn1, [[灵符启动]])
	GUI:Button_setTitleColor(startBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn1, 18)
	GUI:Button_titleEnableOutline(startBtn1, "#000000", 1)
	GUI:setAnchorPoint(startBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn1, true)
	GUI:setTag(startBtn1, 0)

	-- Create startBtn2
	local startBtn2 = GUI:Button_Create(FrameLayout, "startBtn2", 682, 79, "res/public/1900000674.png")
	GUI:setContentSize(startBtn2, 92, 35)
	GUI:setIgnoreContentAdaptWithSize(startBtn2, false)
	GUI:Button_setTitleText(startBtn2, [[免费启动]])
	GUI:Button_setTitleColor(startBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(startBtn2, 18)
	GUI:Button_titleEnableOutline(startBtn2, "#000000", 1)
	GUI:setAnchorPoint(startBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(startBtn2, true)
	GUI:setTag(startBtn2, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 360, 415, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 440, 350, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(FrameLayout, "ItemShow_3", 465, 245, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(FrameLayout, "ItemShow_4", 413, 151, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(FrameLayout, "ItemShow_5", 308, 112, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(FrameLayout, "ItemShow_6", 205, 150, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(FrameLayout, "ItemShow_7", 153, 242, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(FrameLayout, "ItemShow_8", 178, 349, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(FrameLayout, "ItemShow_9", 257, 414, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setTag(ItemShow_9, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 558, 358, 18, "#00ffe8", [[每次启动转盘随机获得神符
每天登录赠送一次开启转盘
首次开启后30分钟开启1次]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 558, 305, 18, "#00ff00", [[使用灵符x66必中2.0倍神符
灵符开启3次后,必中至尊神符]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 558, 280, 18, "#9b00ff", [[所有神符限时24小时后消失]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(FrameLayout, "select_img", 257, 414, "res/custom/npc/12bl/xz2.png")
	GUI:setAnchorPoint(select_img, 0.50, 0.50)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)

	-- Create tipsBtn
	local tipsBtn = GUI:Button_Create(FrameLayout, "tipsBtn", 498, 440, "res/custom/tips.png")
	GUI:Button_setTitleText(tipsBtn, [[]])
	GUI:Button_setTitleColor(tipsBtn, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn, 16)
	GUI:Button_titleEnableOutline(tipsBtn, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn, true)
	GUI:setTag(tipsBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
