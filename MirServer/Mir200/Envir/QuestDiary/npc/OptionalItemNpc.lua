local OptionalItemNpc = {}
-- 时装
OptionalItemNpc.fashion_cfg = {
    {"社团风云", 10207, 50918},
    {"海盗船长", 10208, 50919},
    {"海军大将", 10209, 50920},
    {"大内密探", 10210, 50921},
    {"月光宝盒", 10211, 50922},
    {"三国の群英", 10212, 50923},
    {"乘风の破浪", 10213, 50924},
    {"仙侠の剑灵", 10214, 50925},
    {"假面の舞会", 10215, 50926},
    {"西洋の剑客", 10216, 50927},
    {"社团の街霸", 10217, 50928},
    {"九五の之尊", 10218, 50929},
    {"诛仙の剑尊", 10219, 50930},
    {"三国の武圣", 10220, 50931},
    {"西楚の霸王", 10221, 50932},
    {"御剑の圣者", 10222, 50933},
    {"大漠の侠客", 10223, 50934},
    {"江湖の剑客", 10224, 50935},
    {"玄门の正宗", 10225, 50936}
}
-- 绝配
OptionalItemNpc.treasure1_cfg = {
    {50633,	"龙骨天书"},
    {50634,	"青铜面具"},
    {50635,	"蛇眉铜鱼"},
    {50636,	"六角铃铛"},
    {50637,	"战国帛书"},
    {50638,	"龙鱼鬼玺"}
}
-- 孤品
OptionalItemNpc.treasure2_cfg = {
    {50639,	"风水秘术"},
    {50640,	"龙纹石盒"},
    {50641,	"月光宝珠"},
    {50642,	"紫玉宝匣"},
    {50643,	"金缕玉衣"},
    {50644,	"雮尘珠"}
}

-- 自选时装
function OptionalItemNpc:showSelectFashionUI(actor)
    local tmp_tab = {}
    for k, v in pairs(self.fashion_cfg) do
        tmp_tab[#tmp_tab + 1] = v[3]
    end
    lualib:ShowNpcUi(actor, "OptionalFashionOBJ", tbl2json(tmp_tab))
end
-- 获取自选时装
function OptionalItemNpc:onGetFashionReward(actor, select_id)
    select_id = tonumber(select_id)
    if nil == select_id then
        Sendmsg9(actor, "ffffff", "请选择物品!", 1)
        return
    end
    local count = getbagitemcount(actor, "时装自选宝箱", 0)
    if count <= 0 then
        return Sendmsg9(actor, "ffffff", "需要时装自选宝箱！", 1)
    end
    local item_id = self.fashion_cfg[select_id][2]
    local name = getstditeminfo(item_id, 1)
    takeitem(actor, "时装自选宝箱", 1)
    giveitem(actor, name, 1)
    lualib:CloseNpcUi(actor, "OptionalFashionOBJ")
end
-- 自选秘宝     _type: 1.绝品   2.孤品
function OptionalItemNpc:showSelectTreasureUI(actor, _type)
    local cfg = self.treasure1_cfg
    if _type == 2 then
        cfg = self.treasure2_cfg
    end
    local tmp_tab = {}
    for k, v in pairs(cfg) do
        tmp_tab[#tmp_tab + 1] = v[1]
    end
    lualib:ShowNpcUi(actor, "OptionalTreasureOBJ", tbl2json(tmp_tab).."#".._type)
end
-- 获取自选秘宝     _type: 1.绝品   2.孤品
function OptionalItemNpc:onGetTreasureReward(actor,  _type, select_id)
    _type = tonumber(_type)
    select_id = tonumber(select_id)
    local need_item = "绝品秘宝自选宝箱"
    local give_cfg = self.treasure1_cfg
    if _type == 2 then
        need_item = "孤品秘宝自选宝箱"
        give_cfg = self.treasure2_cfg
    end
    local count = getbagitemcount(actor, need_item, 0)
    if count <= 0 then
        return Sendmsg9(actor, "ffffff", "需要"..need_item, 1)
    end
    local cfg = give_cfg[select_id]
    if nil == cfg then
        return Sendmsg9(actor, "ffffff", "未知错误!", 1)
    end
    takeitem(actor, need_item, 1)
    giveitem(actor, cfg[2], 1)
    lualib:CloseNpcUi(actor, "OptionalTreasureOBJ")
end

return OptionalItemNpc