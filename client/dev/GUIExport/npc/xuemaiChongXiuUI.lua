local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 560, 390, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create closeButton
	local closeButton = GUI:Button_Create(FrameLayout, "closeButton", 558, 339, "res/public/1900000510.png")
	GUI:setContentSize(closeButton, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeButton, false)
	GUI:Button_setTitleText(closeButton, [[]])
	GUI:Button_setTitleColor(closeButton, "#ffffff")
	GUI:Button_setTitleFontSize(closeButton, 16)
	GUI:Button_titleEnableOutline(closeButton, "#000000", 1)
	GUI:setAnchorPoint(closeButton, 0.00, 0.00)
	GUI:setTouchEnabled(closeButton, true)
	GUI:setTag(closeButton, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", -1, 0, "res/custom/npc/23xm/bg3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create cxKaPaiImg
	local cxKaPaiImg = GUI:Image_Create(Image_1, "cxKaPaiImg", 198, 112, "res/custom/npc/23xm/type_1.png")
	GUI:setContentSize(cxKaPaiImg, 170, 248)
	GUI:setIgnoreContentAdaptWithSize(cxKaPaiImg, false)
	GUI:setAnchorPoint(cxKaPaiImg, 0.00, 0.00)
	GUI:setTouchEnabled(cxKaPaiImg, false)
	GUI:setTag(cxKaPaiImg, 0)

	-- Create cxItem
	local cxItem = GUI:ItemShow_Create(cxKaPaiImg, "cxItem", 86, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(cxItem, 0.50, 0.50)
	GUI:setTag(cxItem, 0)

	-- Create flushKaPaiBox
	local flushKaPaiBox = GUI:Layout_Create(Image_1, "flushKaPaiBox", 14, 119, 532, 230, false)
	GUI:setAnchorPoint(flushKaPaiBox, 0.00, 0.00)
	GUI:setTouchEnabled(flushKaPaiBox, false)
	GUI:setTag(flushKaPaiBox, 0)

	-- Create kaPaiImg1
	local kaPaiImg1 = GUI:Image_Create(flushKaPaiBox, "kaPaiImg1", 0, -7, "res/custom/npc/23xm/type_1.png")
	GUI:setContentSize(kaPaiImg1, 170, 248)
	GUI:setIgnoreContentAdaptWithSize(kaPaiImg1, false)
	GUI:setAnchorPoint(kaPaiImg1, 0.00, 0.00)
	GUI:setTouchEnabled(kaPaiImg1, false)
	GUI:setTag(kaPaiImg1, 0)

	-- Create kpItem1
	local kpItem1 = GUI:ItemShow_Create(kaPaiImg1, "kpItem1", 86, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(kpItem1, 0.50, 0.50)
	GUI:setTag(kpItem1, 0)

	-- Create kpSelectBtn1
	local kpSelectBtn1 = GUI:Button_Create(kaPaiImg1, "kpSelectBtn1", 46, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(kpSelectBtn1, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(kpSelectBtn1, false)
	GUI:Button_setTitleText(kpSelectBtn1, [[]])
	GUI:Button_setTitleColor(kpSelectBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(kpSelectBtn1, 16)
	GUI:Button_titleEnableOutline(kpSelectBtn1, "#000000", 1)
	GUI:setAnchorPoint(kpSelectBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(kpSelectBtn1, true)
	GUI:setTag(kpSelectBtn1, 0)

	-- Create kaPaiImg2
	local kaPaiImg2 = GUI:Image_Create(flushKaPaiBox, "kaPaiImg2", 184, -7, "res/custom/npc/23xm/type_1.png")
	GUI:setContentSize(kaPaiImg2, 170, 248)
	GUI:setIgnoreContentAdaptWithSize(kaPaiImg2, false)
	GUI:setAnchorPoint(kaPaiImg2, 0.00, 0.00)
	GUI:setTouchEnabled(kaPaiImg2, false)
	GUI:setTag(kaPaiImg2, 0)

	-- Create kpItem2
	local kpItem2 = GUI:ItemShow_Create(kaPaiImg2, "kpItem2", 86, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(kpItem2, 0.50, 0.50)
	GUI:setTag(kpItem2, 0)

	-- Create kpSelectBtn2
	local kpSelectBtn2 = GUI:Button_Create(kaPaiImg2, "kpSelectBtn2", 46, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(kpSelectBtn2, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(kpSelectBtn2, false)
	GUI:Button_setTitleText(kpSelectBtn2, [[]])
	GUI:Button_setTitleColor(kpSelectBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(kpSelectBtn2, 16)
	GUI:Button_titleEnableOutline(kpSelectBtn2, "#000000", 1)
	GUI:setAnchorPoint(kpSelectBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(kpSelectBtn2, true)
	GUI:setTag(kpSelectBtn2, 0)

	-- Create kaPaiImg3
	local kaPaiImg3 = GUI:Image_Create(flushKaPaiBox, "kaPaiImg3", 358, -7, "res/custom/npc/23xm/type_1.png")
	GUI:setContentSize(kaPaiImg3, 170, 248)
	GUI:setIgnoreContentAdaptWithSize(kaPaiImg3, false)
	GUI:setAnchorPoint(kaPaiImg3, 0.00, 0.00)
	GUI:setTouchEnabled(kaPaiImg3, false)
	GUI:setTag(kaPaiImg3, 0)

	-- Create kpItem3
	local kpItem3 = GUI:ItemShow_Create(kaPaiImg3, "kpItem3", 86, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(kpItem3, 0.50, 0.50)
	GUI:setTag(kpItem3, 0)

	-- Create kpSelectBtn3
	local kpSelectBtn3 = GUI:Button_Create(kaPaiImg3, "kpSelectBtn3", 46, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(kpSelectBtn3, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(kpSelectBtn3, false)
	GUI:Button_setTitleText(kpSelectBtn3, [[]])
	GUI:Button_setTitleColor(kpSelectBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(kpSelectBtn3, 16)
	GUI:Button_titleEnableOutline(kpSelectBtn3, "#000000", 1)
	GUI:setAnchorPoint(kpSelectBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(kpSelectBtn3, true)
	GUI:setTag(kpSelectBtn3, 0)

	-- Create tm_kaipai_box
	local tm_kaipai_box = GUI:Layout_Create(Image_1, "tm_kaipai_box", 14, 119, 532, 230, false)
	GUI:setAnchorPoint(tm_kaipai_box, 0.00, 0.00)
	GUI:setTouchEnabled(tm_kaipai_box, false)
	GUI:setTag(tm_kaipai_box, 0)

	-- Create tm_kapai1
	local tm_kapai1 = GUI:Image_Create(tm_kaipai_box, "tm_kapai1", 59, -7, "res/custom/npc/23xm/type_1.png")
	GUI:setContentSize(tm_kapai1, 170, 248)
	GUI:setIgnoreContentAdaptWithSize(tm_kapai1, false)
	GUI:setAnchorPoint(tm_kapai1, 0.00, 0.00)
	GUI:setTouchEnabled(tm_kapai1, false)
	GUI:setTag(tm_kapai1, 0)

	-- Create tm_kpItem1
	local tm_kpItem1 = GUI:ItemShow_Create(tm_kapai1, "tm_kpItem1", 86, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(tm_kpItem1, 0.50, 0.50)
	GUI:setTag(tm_kpItem1, 0)

	-- Create tm_kpSelectBtn1
	local tm_kpSelectBtn1 = GUI:Button_Create(tm_kapai1, "tm_kpSelectBtn1", 46, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(tm_kpSelectBtn1, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(tm_kpSelectBtn1, false)
	GUI:Button_setTitleText(tm_kpSelectBtn1, [[]])
	GUI:Button_setTitleColor(tm_kpSelectBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(tm_kpSelectBtn1, 16)
	GUI:Button_titleEnableOutline(tm_kpSelectBtn1, "#000000", 1)
	GUI:setAnchorPoint(tm_kpSelectBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(tm_kpSelectBtn1, true)
	GUI:setTag(tm_kpSelectBtn1, 0)

	-- Create tm_kapai2
	local tm_kapai2 = GUI:Image_Create(tm_kaipai_box, "tm_kapai2", 298, -7, "res/custom/npc/23xm/type_1.png")
	GUI:setContentSize(tm_kapai2, 170, 248)
	GUI:setIgnoreContentAdaptWithSize(tm_kapai2, false)
	GUI:setAnchorPoint(tm_kapai2, 0.00, 0.00)
	GUI:setTouchEnabled(tm_kapai2, false)
	GUI:setTag(tm_kapai2, 0)

	-- Create tm_kpItem2
	local tm_kpItem2 = GUI:ItemShow_Create(tm_kapai2, "tm_kpItem2", 86, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(tm_kpItem2, 0.50, 0.50)
	GUI:setTag(tm_kpItem2, 0)

	-- Create tm_kpSelectBtn2
	local tm_kpSelectBtn2 = GUI:Button_Create(tm_kapai2, "tm_kpSelectBtn2", 46, 46, "res/custom/npc/23xm/an3.png")
	GUI:setContentSize(tm_kpSelectBtn2, 83, 35)
	GUI:setIgnoreContentAdaptWithSize(tm_kpSelectBtn2, false)
	GUI:Button_setTitleText(tm_kpSelectBtn2, [[]])
	GUI:Button_setTitleColor(tm_kpSelectBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(tm_kpSelectBtn2, 16)
	GUI:Button_titleEnableOutline(tm_kpSelectBtn2, "#000000", 1)
	GUI:setAnchorPoint(tm_kpSelectBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(tm_kpSelectBtn2, true)
	GUI:setTag(tm_kpSelectBtn2, 0)

	-- Create cueSelectText
	local cueSelectText = GUI:Text_Create(Image_1, "cueSelectText", 199, 96, 16, "#00ff00", [[当前选择重修天赋：强攻]])
	GUI:Text_enableOutline(cueSelectText, "#000000", 1)
	GUI:setAnchorPoint(cueSelectText, 0.00, 0.00)
	GUI:setTouchEnabled(cueSelectText, false)
	GUI:setTag(cueSelectText, 0)

	-- Create expendTip
	local expendTip = GUI:Text_Create(Image_1, "expendTip", 26, 16, 16, "#ffffff", [[花费：书页x199 或 灵符x100,即可刷新一次当前天赋(特权拥有免费次数)]])
	GUI:Text_enableOutline(expendTip, "#000000", 1)
	GUI:setAnchorPoint(expendTip, 0.00, 0.00)
	GUI:setTouchEnabled(expendTip, false)
	GUI:setTag(expendTip, 0)

	-- Create bookRebuildButton
	local bookRebuildButton = GUI:Button_Create(Image_1, "bookRebuildButton", 116, 43, "res/custom/npc/23xm/an21.png")
	GUI:setContentSize(bookRebuildButton, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(bookRebuildButton, false)
	GUI:Button_setTitleText(bookRebuildButton, [[]])
	GUI:Button_setTitleColor(bookRebuildButton, "#ffffff")
	GUI:Button_setTitleFontSize(bookRebuildButton, 16)
	GUI:Button_titleEnableOutline(bookRebuildButton, "#000000", 1)
	GUI:setAnchorPoint(bookRebuildButton, 0.00, 0.00)
	GUI:setTouchEnabled(bookRebuildButton, true)
	GUI:setTag(bookRebuildButton, 0)

	-- Create runeRebuildButton
	local runeRebuildButton = GUI:Button_Create(Image_1, "runeRebuildButton", 353, 44, "res/custom/npc/23xm/an20.png")
	GUI:setContentSize(runeRebuildButton, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(runeRebuildButton, false)
	GUI:Button_setTitleText(runeRebuildButton, [[]])
	GUI:Button_setTitleColor(runeRebuildButton, "#ffffff")
	GUI:Button_setTitleFontSize(runeRebuildButton, 16)
	GUI:Button_titleEnableOutline(runeRebuildButton, "#000000", 1)
	GUI:setAnchorPoint(runeRebuildButton, 0.00, 0.00)
	GUI:setTouchEnabled(runeRebuildButton, true)
	GUI:setTag(runeRebuildButton, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
