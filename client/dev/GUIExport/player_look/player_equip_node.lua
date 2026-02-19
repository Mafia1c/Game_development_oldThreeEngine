local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Node
	local Node = GUI:Node_Create(parent, "Node", 0, 0)
	GUI:setChineseName(Node, "玩家装备_场景")
	GUI:setTag(Node, -1)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(Node, "Panel_1", 0, 0, 348, 478, false)
	GUI:setChineseName(Panel_1, "玩家装备_组合")
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 31)
	TAGOBJ["31"] = Panel_1

	-- Create Image_20
	local Image_20 = GUI:Image_Create(Panel_1, "Image_20", 174, 239, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/bg_juese_03.png")
	GUI:setChineseName(Image_20, "玩家装备_背景图")
	GUI:setAnchorPoint(Image_20, 0.50, 0.50)
	GUI:setTouchEnabled(Image_20, false)
	GUI:setTag(Image_20, 213)
	TAGOBJ["213"] = Image_20

	-- Create Node_playerModel
	local Node_playerModel = GUI:Node_Create(Panel_1, "Node_playerModel", 174, 219)
	GUI:setChineseName(Node_playerModel, "玩家装备_裸模")
	GUI:setTag(Node_playerModel, 48)
	TAGOBJ["48"] = Node_playerModel

	-- Create Panel_pos0
	local Panel_pos0 = GUI:Layout_Create(Panel_1, "Panel_pos0", 174, 197, 180, 240, false)
	GUI:setChineseName(Panel_pos0, "玩家装备_裸模位置")
	GUI:setAnchorPoint(Panel_pos0, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos0, true)
	GUI:setTag(Panel_pos0, 32)
	TAGOBJ["32"] = Panel_pos0

	-- Create Panel_pos1
	local Panel_pos1 = GUI:Layout_Create(Panel_1, "Panel_pos1", 67, 306, 120, 206, false)
	GUI:setChineseName(Panel_pos1, "玩家装备_武器位置")
	GUI:setAnchorPoint(Panel_pos1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos1, true)
	GUI:setTag(Panel_pos1, 31)
	TAGOBJ["31"] = Panel_pos1

	-- Create Panel_pos16
	local Panel_pos16 = GUI:Layout_Create(Panel_1, "Panel_pos16", 244, 208, 85, 140, false)
	GUI:setChineseName(Panel_pos16, "玩家装备_盾牌")
	GUI:setAnchorPoint(Panel_pos16, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos16, true)
	GUI:setTag(Panel_pos16, 82)
	TAGOBJ["82"] = Panel_pos16

	-- Create Panel_pos4
	local Panel_pos4 = GUI:Layout_Create(Panel_1, "Panel_pos4", 174, 322, 50, 50, false)
	GUI:setChineseName(Panel_pos4, "玩家装备_头盔_组合")
	GUI:setAnchorPoint(Panel_pos4, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos4, true)
	GUI:setTag(Panel_pos4, 33)
	TAGOBJ["33"] = Panel_pos4

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_pos4, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_头盔_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 141)
	GUI:setVisible(Image_bg, false)
	TAGOBJ["141"] = Image_bg

	-- Create Image_icon
	local Image_icon = GUI:Image_Create(Panel_pos4, "Image_icon", 25, 25, "Default/ImageFile.png")
	GUI:setChineseName(Image_icon, "玩家装备_头盔_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 142)
	GUI:setVisible(Image_icon, false)
	TAGOBJ["142"] = Image_icon

	-- Create Panel_pos13
	local Panel_pos13 = GUI:Layout_Create(Panel_1, "Panel_pos13", 174, 322, 50, 50, false)
	GUI:setChineseName(Panel_pos13, "玩家装备_斗笠_组合")
	GUI:setAnchorPoint(Panel_pos13, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos13, true)
	GUI:setTag(Panel_pos13, 143)
	GUI:setVisible(Panel_pos13, false)
	TAGOBJ["143"] = Panel_pos13

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos13, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_斗笠_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 144)
	GUI:setVisible(Image_bg, false)
	TAGOBJ["144"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos13, "Image_icon", 25, 25, "Default/ImageFile.png")
	GUI:setChineseName(Image_icon, "玩家装备_斗笠_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 145)
	GUI:setVisible(Image_icon, false)
	TAGOBJ["145"] = Image_icon

	-- Create Panel_pos55
	local Panel_pos55 = GUI:Layout_Create(Panel_1, "Panel_pos55", 174, 322, 50, 50, false)
	GUI:setChineseName(Panel_pos55, "玩家装备_面巾_触摸位")
	GUI:setAnchorPoint(Panel_pos55, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos55, true)
	GUI:setTag(Panel_pos55, 78)
	TAGOBJ["78"] = Panel_pos55

	-- Create Panel_pos1001
	local Panel_pos1001 = GUI:Layout_Create(Panel_1, "Panel_pos1001", 36, 275, 51, 51, false)
	GUI:setChineseName(Panel_pos1001, "玩家装备_武器_组合")
	GUI:setAnchorPoint(Panel_pos1001, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos1001, true)
	GUI:setTag(Panel_pos1001, 34)
	GUI:setVisible(Panel_pos1001, false)
	TAGOBJ["34"] = Panel_pos1001

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos1001, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 0, 0, 0, 0)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_武器_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 50)
	TAGOBJ["50"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos1001, "Image_icon", 25, 25, "res/public/0.png")
	GUI:setChineseName(Image_icon, "玩家装备_武器_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 72)
	TAGOBJ["72"] = Image_icon

	-- Create Panel_pos1000
	local Panel_pos1000 = GUI:Layout_Create(Panel_1, "Panel_pos1000", 36, 215, 51, 51, false)
	GUI:setChineseName(Panel_pos1000, "玩家装备_衣服_组合")
	GUI:setAnchorPoint(Panel_pos1000, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos1000, true)
	GUI:setTag(Panel_pos1000, 34)
	GUI:setVisible(Panel_pos1000, false)
	TAGOBJ["34"] = Panel_pos1000

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos1000, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 0, 0, 0, 0)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_衣服_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 50)
	TAGOBJ["50"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos1000, "Image_icon", 25, 25, "res/public/0.png")
	GUI:setChineseName(Image_icon, "玩家装备_衣服_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 72)
	TAGOBJ["72"] = Image_icon

	-- Create Panel_pos6
	local Panel_pos6 = GUI:Layout_Create(Panel_1, "Panel_pos6", 36, 156, 51, 51, false)
	GUI:setChineseName(Panel_pos6, "玩家装备_左手镯_组合")
	GUI:setAnchorPoint(Panel_pos6, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos6, true)
	GUI:setTag(Panel_pos6, 34)
	TAGOBJ["34"] = Panel_pos6

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos6, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_左手镯_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 50)
	TAGOBJ["50"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos6, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015034.png")
	GUI:setContentSize(Image_icon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_左手镯_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 72)
	TAGOBJ["72"] = Image_icon

	-- Create Panel_pos8
	local Panel_pos8 = GUI:Layout_Create(Panel_1, "Panel_pos8", 36, 95, 51, 51, false)
	GUI:setChineseName(Panel_pos8, "玩家装备_左戒指_组合")
	GUI:setAnchorPoint(Panel_pos8, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos8, true)
	GUI:setTag(Panel_pos8, 39)
	TAGOBJ["39"] = Panel_pos8

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos8, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_左戒指_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 49)
	TAGOBJ["49"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos8, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015035.png")
	GUI:setContentSize(Image_icon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_左戒指_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 73)
	TAGOBJ["73"] = Image_icon

	-- Create Panel_pos7
	local Panel_pos7 = GUI:Layout_Create(Panel_1, "Panel_pos7", 314, 95, 51, 51, false)
	GUI:setChineseName(Panel_pos7, "玩家装备_右戒指_组合")
	GUI:setAnchorPoint(Panel_pos7, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos7, true)
	GUI:setTag(Panel_pos7, 40)
	TAGOBJ["40"] = Panel_pos7

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos7, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_右戒指_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 48)
	TAGOBJ["48"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos7, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015035.png")
	GUI:setContentSize(Image_icon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_右戒指_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 74)
	TAGOBJ["74"] = Image_icon

	-- Create Panel_pos5
	local Panel_pos5 = GUI:Layout_Create(Panel_1, "Panel_pos5", 314, 156, 51, 51, false)
	GUI:setChineseName(Panel_pos5, "玩家装备_右手镯_组合")
	GUI:setAnchorPoint(Panel_pos5, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos5, true)
	GUI:setTag(Panel_pos5, 41)
	TAGOBJ["41"] = Panel_pos5

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos5, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_右手镯_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 46)
	TAGOBJ["46"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos5, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015034.png")
	GUI:setContentSize(Image_icon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_右手镯_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 75)
	TAGOBJ["75"] = Image_icon

	-- Create Panel_pos2
	local Panel_pos2 = GUI:Layout_Create(Panel_1, "Panel_pos2", 314, 216, 51, 51, false)
	GUI:setChineseName(Panel_pos2, "玩家装备_勋章_组合")
	GUI:setAnchorPoint(Panel_pos2, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos2, true)
	GUI:setTag(Panel_pos2, 42)
	TAGOBJ["42"] = Panel_pos2

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos2, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_勋章_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 45)
	TAGOBJ["45"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos2, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015033.png")
	GUI:setContentSize(Image_icon, 47, 43)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_勋章_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 76)
	TAGOBJ["76"] = Image_icon

	-- Create Panel_pos3
	local Panel_pos3 = GUI:Layout_Create(Panel_1, "Panel_pos3", 314, 277, 51, 51, false)
	GUI:setChineseName(Panel_pos3, "玩家装备_项链_组合")
	GUI:setAnchorPoint(Panel_pos3, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos3, true)
	GUI:setTag(Panel_pos3, 43)
	TAGOBJ["43"] = Panel_pos3

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos3, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_项链_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 44)
	TAGOBJ["44"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos3, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015032.png")
	GUI:setContentSize(Image_icon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_项链_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 77)
	TAGOBJ["77"] = Image_icon

	-- Create Panel_pos14
	local Panel_pos14 = GUI:Layout_Create(Panel_1, "Panel_pos14", 36, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos14, "玩家装备_战鼓_组合")
	GUI:setAnchorPoint(Panel_pos14, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos14, true)
	GUI:setTag(Panel_pos14, 179)
	TAGOBJ["179"] = Panel_pos14

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos14, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_战鼓_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 180)
	TAGOBJ["180"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos14, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015040.png")
	GUI:setChineseName(Image_icon, "玩家装备_战鼓_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 181)
	TAGOBJ["181"] = Image_icon

	-- Create Panel_pos15
	local Panel_pos15 = GUI:Layout_Create(Panel_1, "Panel_pos15", 314, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos15, "玩家装备_坐骑_组合")
	GUI:setAnchorPoint(Panel_pos15, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos15, true)
	GUI:setTag(Panel_pos15, 175)
	TAGOBJ["175"] = Panel_pos15

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos15, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_坐骑_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 176)
	TAGOBJ["176"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos15, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015041.png")
	GUI:setChineseName(Image_icon, "玩家装备_坐骑_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 177)
	TAGOBJ["177"] = Image_icon

	-- Create Panel_pos12
	local Panel_pos12 = GUI:Layout_Create(Panel_1, "Panel_pos12", 257, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos12, "玩家装备_魔血石_组合")
	GUI:setAnchorPoint(Panel_pos12, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos12, true)
	GUI:setTag(Panel_pos12, 60)
	TAGOBJ["60"] = Panel_pos12

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos12, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_魔血石_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 61)
	TAGOBJ["61"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos12, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015039.png")
	GUI:setContentSize(Image_icon, 47, 43)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_魔血石_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 78)
	TAGOBJ["78"] = Image_icon

	-- Create Panel_pos11
	local Panel_pos11 = GUI:Layout_Create(Panel_1, "Panel_pos11", 203, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos11, "玩家装备_靴子_组合")
	GUI:setAnchorPoint(Panel_pos11, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos11, true)
	GUI:setTag(Panel_pos11, 63)
	TAGOBJ["63"] = Panel_pos11

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos11, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_靴子_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 64)
	TAGOBJ["64"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos11, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015037.png")
	GUI:setContentSize(Image_icon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_靴子_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 79)
	TAGOBJ["79"] = Image_icon

	-- Create Panel_pos10
	local Panel_pos10 = GUI:Layout_Create(Panel_1, "Panel_pos10", 147, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos10, "玩家装备_腰带_组合")
	GUI:setAnchorPoint(Panel_pos10, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos10, true)
	GUI:setTag(Panel_pos10, 66)
	TAGOBJ["66"] = Panel_pos10

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos10, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_腰带_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 67)
	TAGOBJ["67"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos10, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015038.png")
	GUI:setContentSize(Image_icon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_腰带_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 80)
	TAGOBJ["80"] = Image_icon

	-- Create Panel_pos9
	local Panel_pos9 = GUI:Layout_Create(Panel_1, "Panel_pos9", 92, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos9, "玩家装备_护身符_组合")
	GUI:setAnchorPoint(Panel_pos9, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos9, true)
	GUI:setTag(Panel_pos9, 69)
	TAGOBJ["69"] = Panel_pos9

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos9, "Image_bg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(Image_bg, 17, 17, 16, 14)
	GUI:setContentSize(Image_bg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家装备_护身符_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 70)
	TAGOBJ["70"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos9, "Image_icon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015036.png")
	GUI:setContentSize(Image_icon, 47, 43)
	GUI:setIgnoreContentAdaptWithSize(Image_icon, false)
	GUI:setChineseName(Image_icon, "玩家装备_护身符_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 81)
	TAGOBJ["81"] = Image_icon

	-- Create Node_1001
	local Node_1001 = GUI:Node_Create(Panel_1, "Node_1001", 36, 275)
	GUI:setChineseName(Node_1001, "玩家装备_武器_位置")
	GUI:setTag(Node_1001, 51)
	GUI:setVisible(Node_1001, false)
	TAGOBJ["51"] = Node_1001

	-- Create Node_1000
	local Node_1000 = GUI:Node_Create(Panel_1, "Node_1000", 36, 215)
	GUI:setChineseName(Node_1000, "玩家装备_衣服_位置")
	GUI:setTag(Node_1000, 51)
	GUI:setVisible(Node_1000, false)
	TAGOBJ["51"] = Node_1000

	-- Create Node_6
	local Node_6 = GUI:Node_Create(Panel_1, "Node_6", 36, 156)
	GUI:setChineseName(Node_6, "玩家装备_左手镯_位置")
	GUI:setTag(Node_6, 51)
	TAGOBJ["51"] = Node_6

	-- Create Node_8
	local Node_8 = GUI:Node_Create(Panel_1, "Node_8", 36, 95)
	GUI:setChineseName(Node_8, "玩家装备_左戒指_位置")
	GUI:setTag(Node_8, 52)
	TAGOBJ["52"] = Node_8

	-- Create Node_7
	local Node_7 = GUI:Node_Create(Panel_1, "Node_7", 314, 95)
	GUI:setChineseName(Node_7, "玩家装备_右戒指_位置")
	GUI:setTag(Node_7, 53)
	TAGOBJ["53"] = Node_7

	-- Create Node_5
	local Node_5 = GUI:Node_Create(Panel_1, "Node_5", 314, 156)
	GUI:setChineseName(Node_5, "玩家装备_右手镯_位置")
	GUI:setTag(Node_5, 54)
	TAGOBJ["54"] = Node_5

	-- Create Node_2
	local Node_2 = GUI:Node_Create(Panel_1, "Node_2", 314, 216)
	GUI:setChineseName(Node_2, "玩家装备_勋章_位置")
	GUI:setTag(Node_2, 55)
	TAGOBJ["55"] = Node_2

	-- Create Node_3
	local Node_3 = GUI:Node_Create(Panel_1, "Node_3", 314, 277)
	GUI:setChineseName(Node_3, "玩家装备_项链_位置")
	GUI:setTag(Node_3, 56)
	TAGOBJ["56"] = Node_3

	-- Create Node_4
	local Node_4 = GUI:Node_Create(Panel_1, "Node_4", 174, 322)
	GUI:setChineseName(Node_4, "玩家装备_头盔_位置")
	GUI:setTag(Node_4, 212)
	TAGOBJ["212"] = Node_4

	-- Create Node_13
	local Node_13 = GUI:Node_Create(Panel_1, "Node_13", 174, 322)
	GUI:setChineseName(Node_13, "玩家装备_斗笠_位置")
	GUI:setTag(Node_13, 213)
	TAGOBJ["213"] = Node_13

	-- Create Node_55
	local Node_55 = GUI:Node_Create(Panel_1, "Node_55", 174, 322)
	GUI:setChineseName(Node_55, "玩家装备_面巾_位置(只能放头上)")
	GUI:setTag(Node_55, 147)
	TAGOBJ["147"] = Node_55

	-- Create Node_14
	local Node_14 = GUI:Node_Create(Panel_1, "Node_14", 36, 35)
	GUI:setChineseName(Node_14, "玩家装备_战鼓_位置")
	GUI:setTag(Node_14, 182)
	TAGOBJ["182"] = Node_14

	-- Create Node_15
	local Node_15 = GUI:Node_Create(Panel_1, "Node_15", 314, 35)
	GUI:setChineseName(Node_15, "玩家装备_坐骑_位置")
	GUI:setTag(Node_15, 178)
	TAGOBJ["178"] = Node_15

	-- Create Node_12
	local Node_12 = GUI:Node_Create(Panel_1, "Node_12", 257, 35)
	GUI:setChineseName(Node_12, "玩家装备_魔血石_位置")
	GUI:setTag(Node_12, 62)
	TAGOBJ["62"] = Node_12

	-- Create Node_11
	local Node_11 = GUI:Node_Create(Panel_1, "Node_11", 203, 35)
	GUI:setChineseName(Node_11, "玩家装备_靴子_位置")
	GUI:setTag(Node_11, 65)
	TAGOBJ["65"] = Node_11

	-- Create Node_10
	local Node_10 = GUI:Node_Create(Panel_1, "Node_10", 147, 35)
	GUI:setChineseName(Node_10, "玩家装备_腰带_位置")
	GUI:setTag(Node_10, 68)
	TAGOBJ["68"] = Node_10

	-- Create Node_9
	local Node_9 = GUI:Node_Create(Panel_1, "Node_9", 92, 35)
	GUI:setChineseName(Node_9, "玩家装备_护身符_位置")
	GUI:setTag(Node_9, 71)
	TAGOBJ["71"] = Node_9

	-- Create Text_guildinfo
	local Text_guildinfo = GUI:Text_Create(Panel_1, "Text_guildinfo", 10, 460, 18, "#ffe400", [[]])
	GUI:Text_enableOutline(Text_guildinfo, "#0e0e0e", 1)
	GUI:setChineseName(Text_guildinfo, "玩家装备_行会信息")
	GUI:setAnchorPoint(Text_guildinfo, 0.00, 0.50)
	GUI:setTouchEnabled(Text_guildinfo, false)
	GUI:setTag(Text_guildinfo, 72)
	TAGOBJ["72"] = Text_guildinfo

	-- Create Best_ringBox
	local Best_ringBox = GUI:Layout_Create(Panel_1, "Best_ringBox", 287, 308, 54, 43, false)
	GUI:setChineseName(Best_ringBox, "玩家装备_首饰盒组合")
	GUI:setAnchorPoint(Best_ringBox, 0.00, 0.00)
	GUI:setTouchEnabled(Best_ringBox, true)
	GUI:setTag(Best_ringBox, 75)
	TAGOBJ["75"] = Best_ringBox

	-- Create Image_box
	local Image_box = GUI:Image_Create(Best_ringBox, "Image_box", 25, 22, "res/private/player_best_rings_ui/player_best_rings_ui_mobile/btn_jewelry_1_0.png")
	GUI:setChineseName(Image_box, "玩家装备_首饰盒")
	GUI:setAnchorPoint(Image_box, 0.50, 0.50)
	GUI:setTouchEnabled(Image_box, false)
	GUI:setTag(Image_box, 74)
	TAGOBJ["74"] = Image_box

	-- Create Wx_Btn
	local Wx_Btn = GUI:Button_Create(Panel_1, "Wx_Btn", 4, 246, "res/custom/play_model/wx_bt.png")
	GUI:setContentSize(Wx_Btn, 60, 27)
	GUI:setIgnoreContentAdaptWithSize(Wx_Btn, false)
	GUI:Button_setTitleText(Wx_Btn, [[]])
	GUI:Button_setTitleColor(Wx_Btn, "#ffffff")
	GUI:Button_setTitleFontSize(Wx_Btn, 16)
	GUI:Button_titleEnableOutline(Wx_Btn, "#000000", 1)
	GUI:setAnchorPoint(Wx_Btn, 0.00, 0.00)
	GUI:setTouchEnabled(Wx_Btn, true)
	GUI:setTag(Wx_Btn, 0)

	-- Create magicRingBtn
	local magicRingBtn = GUI:Button_Create(Panel_1, "magicRingBtn", 4, 284, "res/custom/npc/69mj/an.png")
	GUI:setContentSize(magicRingBtn, 60, 28)
	GUI:setIgnoreContentAdaptWithSize(magicRingBtn, false)
	GUI:Button_setTitleText(magicRingBtn, [[]])
	GUI:Button_setTitleColor(magicRingBtn, "#ffffff")
	GUI:Button_setTitleFontSize(magicRingBtn, 16)
	GUI:Button_titleEnableOutline(magicRingBtn, "#000000", 1)
	GUI:setAnchorPoint(magicRingBtn, 0.00, 0.00)
	GUI:setTouchEnabled(magicRingBtn, true)
	GUI:setTag(magicRingBtn, 0)

	-- Create FeiJianBtn
	local FeiJianBtn = GUI:Button_Create(Panel_1, "FeiJianBtn", 285, 427, "res/custom/npc/111kfsc/fjbtn.png")
	GUI:Button_setTitleText(FeiJianBtn, [[]])
	GUI:Button_setTitleColor(FeiJianBtn, "#ffffff")
	GUI:Button_setTitleFontSize(FeiJianBtn, 16)
	GUI:Button_titleEnableOutline(FeiJianBtn, "#000000", 1)
	GUI:setAnchorPoint(FeiJianBtn, 0.00, 0.00)
	GUI:setTouchEnabled(FeiJianBtn, true)
	GUI:setTag(FeiJianBtn, 0)

	ui.update(__data__)
	return Node
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
