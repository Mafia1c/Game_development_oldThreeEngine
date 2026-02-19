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
	local Panel_1 = GUI:Layout_Create(Node, "Panel_1", 0, 0, 272, 349, false)
	GUI:setChineseName(Panel_1, "玩家装备_组合")
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 137)
	TAGOBJ["137"] = Panel_1

	-- Create Image_equippanel
	local Image_equippanel = GUI:Image_Create(Panel_1, "Image_equippanel", 136, 174, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015001_1.jpg")
	GUI:setChineseName(Image_equippanel, "玩家装备_背景图")
	GUI:setAnchorPoint(Image_equippanel, 0.50, 0.50)
	GUI:setTouchEnabled(Image_equippanel, false)
	GUI:setTag(Image_equippanel, 62)
	TAGOBJ["62"] = Image_equippanel

	-- Create Node_playerModel
	local Node_playerModel = GUI:Node_Create(Panel_1, "Node_playerModel", 140, 138)
	GUI:setChineseName(Node_playerModel, "玩家装备_裸模")
	GUI:setTag(Node_playerModel, 139)
	TAGOBJ["139"] = Node_playerModel

	-- Create Panel_pos0
	local Panel_pos0 = GUI:Layout_Create(Panel_1, "Panel_pos0", 136, 120, 80, 144, false)
	GUI:setChineseName(Panel_pos0, "玩家装备_裸模位置")
	GUI:setAnchorPoint(Panel_pos0, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos0, true)
	GUI:setTag(Panel_pos0, 140)
	TAGOBJ["140"] = Panel_pos0

	-- Create Panel_pos1
	local Panel_pos1 = GUI:Layout_Create(Panel_1, "Panel_pos1", 80, 190, 60, 120, false)
	GUI:setChineseName(Panel_pos1, "玩家装备_武器位置")
	GUI:setAnchorPoint(Panel_pos1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos1, true)
	GUI:setTag(Panel_pos1, 141)
	TAGOBJ["141"] = Panel_pos1

	-- Create Panel_pos16
	local Panel_pos16 = GUI:Layout_Create(Panel_1, "Panel_pos16", 183, 132, 43, 71, false)
	GUI:setChineseName(Panel_pos16, "玩家装备_盾牌")
	GUI:setAnchorPoint(Panel_pos16, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos16, true)
	GUI:setTag(Panel_pos16, 142)
	TAGOBJ["142"] = Panel_pos16

	-- Create Panel_pos4
	local Panel_pos4 = GUI:Layout_Create(Panel_1, "Panel_pos4", 138, 207, 42, 42, false)
	GUI:setChineseName(Panel_pos4, "玩家装备_头盔_组合")
	GUI:setAnchorPoint(Panel_pos4, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos4, true)
	GUI:setTag(Panel_pos4, 143)
	TAGOBJ["143"] = Panel_pos4

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_pos4, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_头盔_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 205)
	GUI:setVisible(Image_bg, false)
	TAGOBJ["205"] = Image_bg

	-- Create Image_icon
	local Image_icon = GUI:Image_Create(Panel_pos4, "Image_icon", 21, 21, "Default/ImageFile.png")
	GUI:setChineseName(Image_icon, "玩家装备_头盔_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 206)
	GUI:setVisible(Image_icon, false)
	TAGOBJ["206"] = Image_icon

	-- Create Panel_pos13
	local Panel_pos13 = GUI:Layout_Create(Panel_1, "Panel_pos13", 138, 207, 42, 42, false)
	GUI:setChineseName(Panel_pos13, "玩家装备_斗笠_组合")
	GUI:setAnchorPoint(Panel_pos13, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos13, true)
	GUI:setTag(Panel_pos13, 207)
	GUI:setVisible(Panel_pos13, false)
	TAGOBJ["207"] = Panel_pos13

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos13, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_斗笠_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 208)
	GUI:setVisible(Image_bg, false)
	TAGOBJ["208"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos13, "Image_icon", 21, 21, "Default/ImageFile.png")
	GUI:setChineseName(Image_icon, "玩家装备_斗笠_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 209)
	GUI:setVisible(Image_icon, false)
	TAGOBJ["209"] = Image_icon

	-- Create Panel_pos55
	local Panel_pos55 = GUI:Layout_Create(Panel_1, "Panel_pos55", 138, 207, 42, 42, false)
	GUI:setChineseName(Panel_pos55, "玩家装备_面巾_触摸位")
	GUI:setAnchorPoint(Panel_pos55, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos55, true)
	GUI:setTag(Panel_pos55, 145)
	TAGOBJ["145"] = Panel_pos55

	-- Create Panel_pos1001
	local Panel_pos1001 = GUI:Layout_Create(Panel_1, "Panel_pos1001", 24, 205, 42, 42, false)
	GUI:setChineseName(Panel_pos1001, "玩家装备_武器_组合")
	GUI:setAnchorPoint(Panel_pos1001, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos1001, true)
	GUI:setTag(Panel_pos1001, 144)
	GUI:setVisible(Panel_pos1001, false)
	TAGOBJ["144"] = Panel_pos1001

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos1001, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_武器_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 145)
	TAGOBJ["145"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos1001, "Image_icon", 21, 21, "res/public/0.png")
	GUI:setChineseName(Image_icon, "玩家装备_武器_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 146)
	TAGOBJ["146"] = Image_icon

	-- Create Panel_pos1000
	local Panel_pos1000 = GUI:Layout_Create(Panel_1, "Panel_pos1000", 24, 160, 42, 42, false)
	GUI:setChineseName(Panel_pos1000, "玩家装备_衣服_组合")
	GUI:setAnchorPoint(Panel_pos1000, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos1000, true)
	GUI:setTag(Panel_pos1000, 144)
	GUI:setVisible(Panel_pos1000, false)
	TAGOBJ["144"] = Panel_pos1000

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos1000, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_衣服_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 145)
	TAGOBJ["145"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos1000, "Image_icon", 21, 21, "res/public/0.png")
	GUI:setChineseName(Image_icon, "玩家装备_衣服_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 146)
	TAGOBJ["146"] = Image_icon

	-- Create Panel_pos6
	local Panel_pos6 = GUI:Layout_Create(Panel_1, "Panel_pos6", 24, 114, 42, 42, false)
	GUI:setChineseName(Panel_pos6, "玩家装备_左手镯_组合")
	GUI:setAnchorPoint(Panel_pos6, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos6, true)
	GUI:setTag(Panel_pos6, 144)
	TAGOBJ["144"] = Panel_pos6

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos6, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_左手镯_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 145)
	TAGOBJ["145"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos6, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015034.png")
	GUI:setChineseName(Image_icon, "玩家装备_左手镯_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 146)
	TAGOBJ["146"] = Image_icon

	-- Create Panel_pos8
	local Panel_pos8 = GUI:Layout_Create(Panel_1, "Panel_pos8", 24, 69, 42, 42, false)
	GUI:setChineseName(Panel_pos8, "玩家装备_左戒指_组合")
	GUI:setAnchorPoint(Panel_pos8, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos8, true)
	GUI:setTag(Panel_pos8, 148)
	TAGOBJ["148"] = Panel_pos8

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos8, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_左戒指_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 149)
	TAGOBJ["149"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos8, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015035.png")
	GUI:setChineseName(Image_icon, "玩家装备_左戒指_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 150)
	TAGOBJ["150"] = Image_icon

	-- Create Panel_pos7
	local Panel_pos7 = GUI:Layout_Create(Panel_1, "Panel_pos7", 248, 69, 42, 42, false)
	GUI:setChineseName(Panel_pos7, "玩家装备_右戒指_组合")
	GUI:setAnchorPoint(Panel_pos7, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos7, true)
	GUI:setTag(Panel_pos7, 152)
	TAGOBJ["152"] = Panel_pos7

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos7, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_右戒指_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 153)
	TAGOBJ["153"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos7, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015035.png")
	GUI:setChineseName(Image_icon, "玩家装备_右戒指_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 154)
	TAGOBJ["154"] = Image_icon

	-- Create Panel_pos5
	local Panel_pos5 = GUI:Layout_Create(Panel_1, "Panel_pos5", 248, 114, 42, 42, false)
	GUI:setChineseName(Panel_pos5, "玩家装备_右手镯_组合")
	GUI:setAnchorPoint(Panel_pos5, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos5, true)
	GUI:setTag(Panel_pos5, 156)
	TAGOBJ["156"] = Panel_pos5

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos5, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_右手镯_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 157)
	TAGOBJ["157"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos5, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015034.png")
	GUI:setChineseName(Image_icon, "玩家装备_右手镯_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 158)
	TAGOBJ["158"] = Image_icon

	-- Create Panel_pos2
	local Panel_pos2 = GUI:Layout_Create(Panel_1, "Panel_pos2", 248, 160, 42, 42, false)
	GUI:setChineseName(Panel_pos2, "玩家装备_勋章_组合")
	GUI:setAnchorPoint(Panel_pos2, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos2, true)
	GUI:setTag(Panel_pos2, 160)
	TAGOBJ["160"] = Panel_pos2

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos2, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_勋章_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 161)
	TAGOBJ["161"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos2, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015033.png")
	GUI:setChineseName(Image_icon, "玩家装备_勋章_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 162)
	TAGOBJ["162"] = Image_icon

	-- Create Panel_pos3
	local Panel_pos3 = GUI:Layout_Create(Panel_1, "Panel_pos3", 248, 205, 42, 42, false)
	GUI:setChineseName(Panel_pos3, "玩家装备_项链_组合")
	GUI:setAnchorPoint(Panel_pos3, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos3, true)
	GUI:setTag(Panel_pos3, 164)
	TAGOBJ["164"] = Panel_pos3

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos3, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_项链_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 165)
	TAGOBJ["165"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos3, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015032.png")
	GUI:setChineseName(Image_icon, "玩家装备_项链_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 166)
	TAGOBJ["166"] = Image_icon

	-- Create Panel_pos14
	local Panel_pos14 = GUI:Layout_Create(Panel_1, "Panel_pos14", 24, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos14, "玩家装备_战鼓_组合")
	GUI:setAnchorPoint(Panel_pos14, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos14, true)
	GUI:setTag(Panel_pos14, 201)
	TAGOBJ["201"] = Panel_pos14

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos14, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_战鼓_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 202)
	TAGOBJ["202"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos14, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015040.png")
	GUI:setChineseName(Image_icon, "玩家装备_战鼓_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 203)
	TAGOBJ["203"] = Image_icon

	-- Create Panel_pos15
	local Panel_pos15 = GUI:Layout_Create(Panel_1, "Panel_pos15", 248, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos15, "玩家装备_坐骑_组合")
	GUI:setAnchorPoint(Panel_pos15, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos15, true)
	GUI:setTag(Panel_pos15, 205)
	TAGOBJ["205"] = Panel_pos15

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos15, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_坐骑_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 206)
	TAGOBJ["206"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos15, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015041.png")
	GUI:setChineseName(Image_icon, "玩家装备_坐骑_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 207)
	TAGOBJ["207"] = Image_icon

	-- Create Panel_pos12
	local Panel_pos12 = GUI:Layout_Create(Panel_1, "Panel_pos12", 204, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos12, "玩家装备_魔血石_组合")
	GUI:setAnchorPoint(Panel_pos12, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos12, true)
	GUI:setTag(Panel_pos12, 168)
	TAGOBJ["168"] = Panel_pos12

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos12, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_魔血石_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 169)
	TAGOBJ["169"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos12, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015039.png")
	GUI:setChineseName(Image_icon, "玩家装备_魔血石_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 170)
	TAGOBJ["170"] = Image_icon

	-- Create Panel_pos11
	local Panel_pos11 = GUI:Layout_Create(Panel_1, "Panel_pos11", 159, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos11, "玩家装备_靴子_组合")
	GUI:setAnchorPoint(Panel_pos11, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos11, true)
	GUI:setTag(Panel_pos11, 172)
	TAGOBJ["172"] = Panel_pos11

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos11, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_靴子_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 173)
	TAGOBJ["173"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos11, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015037.png")
	GUI:setChineseName(Image_icon, "玩家装备_靴子_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 174)
	TAGOBJ["174"] = Image_icon

	-- Create Panel_pos10
	local Panel_pos10 = GUI:Layout_Create(Panel_1, "Panel_pos10", 115, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos10, "玩家装备_腰带_组合")
	GUI:setAnchorPoint(Panel_pos10, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos10, true)
	GUI:setTag(Panel_pos10, 176)
	TAGOBJ["176"] = Panel_pos10

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos10, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_腰带_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 177)
	TAGOBJ["177"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos10, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015038.png")
	GUI:setChineseName(Image_icon, "玩家装备_腰带_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 178)
	TAGOBJ["178"] = Image_icon

	-- Create Panel_pos9
	local Panel_pos9 = GUI:Layout_Create(Panel_1, "Panel_pos9", 69, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos9, "玩家装备_护身符_组合")
	GUI:setAnchorPoint(Panel_pos9, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos9, true)
	GUI:setTag(Panel_pos9, 180)
	TAGOBJ["180"] = Panel_pos9

	-- Create Image_bg
	Image_bg = GUI:Image_Create(Panel_pos9, "Image_bg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(Image_bg, "玩家装备_护身符_物品框")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 181)
	TAGOBJ["181"] = Image_bg

	-- Create Image_icon
	Image_icon = GUI:Image_Create(Panel_pos9, "Image_icon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015036.png")
	GUI:setChineseName(Image_icon, "玩家装备_护身符_图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 182)
	TAGOBJ["182"] = Image_icon

	-- Create Node_1001
	local Node_1001 = GUI:Node_Create(Panel_1, "Node_1001", 24, 205)
	GUI:setChineseName(Node_1001, "玩家装备_武器_位置")
	GUI:setTag(Node_1001, 175)
	GUI:setVisible(Node_1001, false)
	TAGOBJ["175"] = Node_1001

	-- Create Node_1000
	local Node_1000 = GUI:Node_Create(Panel_1, "Node_1000", 24, 160)
	GUI:setChineseName(Node_1000, "玩家装备_衣服_位置")
	GUI:setTag(Node_1000, 179)
	GUI:setVisible(Node_1000, false)
	TAGOBJ["179"] = Node_1000

	-- Create Node_6
	local Node_6 = GUI:Node_Create(Panel_1, "Node_6", 24, 114)
	GUI:setChineseName(Node_6, "玩家装备_左手镯_位置")
	GUI:setTag(Node_6, 147)
	TAGOBJ["147"] = Node_6

	-- Create Node_8
	local Node_8 = GUI:Node_Create(Panel_1, "Node_8", 24, 69)
	GUI:setChineseName(Node_8, "玩家装备_左戒指_位置")
	GUI:setTag(Node_8, 151)
	TAGOBJ["151"] = Node_8

	-- Create Node_7
	local Node_7 = GUI:Node_Create(Panel_1, "Node_7", 248, 69)
	GUI:setChineseName(Node_7, "玩家装备_右戒指_位置")
	GUI:setTag(Node_7, 155)
	TAGOBJ["155"] = Node_7

	-- Create Node_5
	local Node_5 = GUI:Node_Create(Panel_1, "Node_5", 248, 114)
	GUI:setChineseName(Node_5, "玩家装备_右手镯_位置")
	GUI:setTag(Node_5, 159)
	TAGOBJ["159"] = Node_5

	-- Create Node_2
	local Node_2 = GUI:Node_Create(Panel_1, "Node_2", 248, 160)
	GUI:setChineseName(Node_2, "玩家装备_勋章_位置")
	GUI:setTag(Node_2, 163)
	TAGOBJ["163"] = Node_2

	-- Create Node_3
	local Node_3 = GUI:Node_Create(Panel_1, "Node_3", 248, 205)
	GUI:setChineseName(Node_3, "玩家装备_项链_位置")
	GUI:setTag(Node_3, 167)
	TAGOBJ["167"] = Node_3

	-- Create Node_4
	local Node_4 = GUI:Node_Create(Panel_1, "Node_4", 138, 207)
	GUI:setChineseName(Node_4, "玩家装备_头盔_位置")
	GUI:setTag(Node_4, 210)
	TAGOBJ["210"] = Node_4

	-- Create Node_13
	local Node_13 = GUI:Node_Create(Panel_1, "Node_13", 138, 207)
	GUI:setChineseName(Node_13, "玩家装备_斗笠_位置")
	GUI:setTag(Node_13, 211)
	TAGOBJ["211"] = Node_13

	-- Create Node_55
	local Node_55 = GUI:Node_Create(Panel_1, "Node_55", 138, 207)
	GUI:setChineseName(Node_55, "玩家装备_面巾_位置(只能放头上)")
	GUI:setTag(Node_55, 146)
	TAGOBJ["146"] = Node_55

	-- Create Node_14
	local Node_14 = GUI:Node_Create(Panel_1, "Node_14", 24, 24)
	GUI:setChineseName(Node_14, "玩家装备_战鼓_位置")
	GUI:setTag(Node_14, 204)
	TAGOBJ["204"] = Node_14

	-- Create Node_15
	local Node_15 = GUI:Node_Create(Panel_1, "Node_15", 248, 24)
	GUI:setChineseName(Node_15, "玩家装备_坐骑_位置")
	GUI:setTag(Node_15, 208)
	TAGOBJ["208"] = Node_15

	-- Create Node_12
	local Node_12 = GUI:Node_Create(Panel_1, "Node_12", 204, 24)
	GUI:setChineseName(Node_12, "玩家装备_魔血石_位置")
	GUI:setTag(Node_12, 171)
	TAGOBJ["171"] = Node_12

	-- Create Node_11
	local Node_11 = GUI:Node_Create(Panel_1, "Node_11", 159, 24)
	GUI:setChineseName(Node_11, "玩家装备_靴子_位置")
	GUI:setTag(Node_11, 175)
	TAGOBJ["175"] = Node_11

	-- Create Node_10
	local Node_10 = GUI:Node_Create(Panel_1, "Node_10", 115, 24)
	GUI:setChineseName(Node_10, "玩家装备_腰带_位置")
	GUI:setTag(Node_10, 179)
	TAGOBJ["179"] = Node_10

	-- Create Node_9
	local Node_9 = GUI:Node_Create(Panel_1, "Node_9", 69, 24)
	GUI:setChineseName(Node_9, "玩家装备_护身符_位置")
	GUI:setTag(Node_9, 183)
	TAGOBJ["183"] = Node_9

	-- Create Text_guildinfo
	local Text_guildinfo = GUI:Text_Create(Panel_1, "Text_guildinfo", 9, 335, 18, "#ffffff", [[]])
	GUI:Text_enableOutline(Text_guildinfo, "#0e0e0e", 1)
	GUI:setChineseName(Text_guildinfo, "玩家装备_行会信息")
	GUI:setAnchorPoint(Text_guildinfo, 0.00, 0.50)
	GUI:setTouchEnabled(Text_guildinfo, false)
	GUI:setTag(Text_guildinfo, 138)
	TAGOBJ["138"] = Text_guildinfo

	-- Create Best_ringBox
	local Best_ringBox = GUI:Layout_Create(Panel_1, "Best_ringBox", 224, 233, 46, 36, false)
	GUI:setChineseName(Best_ringBox, "玩家装备_首饰盒组合")
	GUI:setAnchorPoint(Best_ringBox, 0.00, 0.00)
	GUI:setTouchEnabled(Best_ringBox, true)
	GUI:setTag(Best_ringBox, 184)
	TAGOBJ["184"] = Best_ringBox

	-- Create Image_box
	local Image_box = GUI:Image_Create(Best_ringBox, "Image_box", 22, 20, "res/private/player_best_rings_ui/player_best_rings_ui_win32/btn_jewelry_1_0.png")
	GUI:setChineseName(Image_box, "玩家装备_首饰盒")
	GUI:setAnchorPoint(Image_box, 0.50, 0.50)
	GUI:setTouchEnabled(Image_box, false)
	GUI:setTag(Image_box, 185)
	TAGOBJ["185"] = Image_box

	-- Create magicRingBtn
	local magicRingBtn = GUI:Button_Create(Panel_1, "magicRingBtn", 0, 188, "res/custom/npc/69mj/an.png")
	GUI:setContentSize(magicRingBtn, 60, 28)
	GUI:setIgnoreContentAdaptWithSize(magicRingBtn, false)
	GUI:Button_setTitleText(magicRingBtn, [[]])
	GUI:Button_setTitleColor(magicRingBtn, "#ffffff")
	GUI:Button_setTitleFontSize(magicRingBtn, 16)
	GUI:Button_titleDisableOutLine(magicRingBtn)
	GUI:setAnchorPoint(magicRingBtn, 0.00, 0.00)
	GUI:setScale(magicRingBtn, 0.80)
	GUI:setTouchEnabled(magicRingBtn, true)
	GUI:setTag(magicRingBtn, 0)

	-- Create Wx_Btn
	local Wx_Btn = GUI:Button_Create(Panel_1, "Wx_Btn", 0, 157, "res/custom/play_model/wx_bt.png")
	GUI:setContentSize(Wx_Btn, 60, 27)
	GUI:setIgnoreContentAdaptWithSize(Wx_Btn, false)
	GUI:Button_setTitleText(Wx_Btn, [[]])
	GUI:Button_setTitleColor(Wx_Btn, "#ffffff")
	GUI:Button_setTitleFontSize(Wx_Btn, 16)
	GUI:Button_titleDisableOutLine(Wx_Btn)
	GUI:setAnchorPoint(Wx_Btn, 0.00, 0.00)
	GUI:setScale(Wx_Btn, 0.80)
	GUI:setTouchEnabled(Wx_Btn, true)
	GUI:setTag(Wx_Btn, 0)

	-- Create FeiJianBtn
	local FeiJianBtn = GUI:Button_Create(Panel_1, "FeiJianBtn", 223, 282, "res/custom/npc/111kfsc/fjbtn.png")
	GUI:Button_setTitleText(FeiJianBtn, [[]])
	GUI:Button_setTitleColor(FeiJianBtn, "#ffffff")
	GUI:Button_setTitleFontSize(FeiJianBtn, 16)
	GUI:Button_titleDisableOutLine(FeiJianBtn)
	GUI:setAnchorPoint(FeiJianBtn, 0.00, 0.00)
	GUI:setScale(FeiJianBtn, 0.80)
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
