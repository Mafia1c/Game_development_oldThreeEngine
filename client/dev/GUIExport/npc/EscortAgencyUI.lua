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
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/11yb/bg.png")
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 818, 481, "res/public/1900000510.png")
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

	-- Create enter_btn
	local enter_btn = GUI:Button_Create(FrameLayout, "enter_btn", 696, 61, "res/public/1900000661.png")
	GUI:setContentSize(enter_btn, 106, 40)
	GUI:setIgnoreContentAdaptWithSize(enter_btn, false)
	GUI:Button_setTitleText(enter_btn, [[开始押镖]])
	GUI:Button_setTitleColor(enter_btn, "#ffffff")
	GUI:Button_setTitleFontSize(enter_btn, 18)
	GUI:Button_titleEnableOutline(enter_btn, "#000000", 1)
	GUI:setAnchorPoint(enter_btn, 0.50, 0.50)
	GUI:setTouchEnabled(enter_btn, true)
	GUI:setTag(enter_btn, 0)

	-- Create biaoche_1
	local biaoche_1 = GUI:Image_Create(FrameLayout, "biaoche_1", 80, 305, "res/custom/npc/11yb/rq.png")
	GUI:setAnchorPoint(biaoche_1, 0.00, 0.00)
	GUI:setTouchEnabled(biaoche_1, true)
	GUI:setTag(biaoche_1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(biaoche_1, "Image_1", 170, 123, "res/custom/npc/11yb/1.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create biaoche_2
	local biaoche_2 = GUI:Image_Create(FrameLayout, "biaoche_2", 330, 307, "res/custom/npc/11yb/rq.png")
	GUI:setAnchorPoint(biaoche_2, 0.00, 0.00)
	GUI:setTouchEnabled(biaoche_2, true)
	GUI:setTag(biaoche_2, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(biaoche_2, "Image_1", 170, 123, "res/custom/npc/11yb/2.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create biaoche_3
	local biaoche_3 = GUI:Image_Create(FrameLayout, "biaoche_3", 80, 125, "res/custom/npc/11yb/rq.png")
	GUI:setAnchorPoint(biaoche_3, 0.00, 0.00)
	GUI:setTouchEnabled(biaoche_3, true)
	GUI:setTag(biaoche_3, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(biaoche_3, "Image_1", 170, 123, "res/custom/npc/11yb/3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create biaoche_4
	local biaoche_4 = GUI:Image_Create(FrameLayout, "biaoche_4", 330, 125, "res/custom/npc/11yb/rq.png")
	GUI:setAnchorPoint(biaoche_4, 0.00, 0.00)
	GUI:setTouchEnabled(biaoche_4, true)
	GUI:setTag(biaoche_4, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(biaoche_4, "Image_1", 170, 123, "res/custom/npc/11yb/4.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create select_img
	local select_img = GUI:Image_Create(FrameLayout, "select_img", 77, 300, "res/custom/npc/11yb/xz.png")
	GUI:setContentSize(select_img, 240, 174)
	GUI:setIgnoreContentAdaptWithSize(select_img, false)
	GUI:setAnchorPoint(select_img, 0.00, 0.00)
	GUI:setTouchEnabled(select_img, false)
	GUI:setTag(select_img, 0)

	-- Create rule_node
	local rule_node = GUI:Node_Create(FrameLayout, "rule_node", 688, 281)
	GUI:setTag(rule_node, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(rule_node, "Text_1", -110, 131, 18, "#ff9b00", [==========[[开放时间]:]==========])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(rule_node, "Text_2", -110, 83, 18, "#ffffc3", [[新区第二天每晚20点,持续
1小时, 每天可押镖0/3次!]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(rule_node, "Text_3", -110, 60, 18, "#ff9b00", [==========[[镖车时长]:]==========])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(rule_node, "Text_4", -110, -17, 18, "#ffffc3", [[押镖时间为10分钟,期间下
线丶超时丶镖车死亡,均视
为押镖失败]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(rule_node, "Text_5", -110, -45, 18, "#ff9b00", [==========[[镖车收益]:]==========])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(rule_node, "Text_7", -110, -150, 18, "#ff9b00", [==========[[活动状态]:]==========])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.00, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
