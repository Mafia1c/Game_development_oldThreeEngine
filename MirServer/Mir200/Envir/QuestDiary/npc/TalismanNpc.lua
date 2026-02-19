local TalismanNpc = {}
TalismanNpc.cfg = include("QuestDiary/config/TalismanCfg.lua")

function TalismanNpc:click(actor, npc_id)
    npc_id = tonumber(npc_id)
    local client_class_name = "GodShieldOBJ"
    local equip_index = 16
    if npc_id == 390 then
        equip_index = 9
        client_class_name = "TalismanOBJ"
    end
    local equip = linkbodyitem(actor, equip_index)
    local tab = self:getEquipData(actor, equip)
    if type(tab) ~= "table" then
        tab = {}
        tab.level = "0"
        tab.cur = "0"
    end
    lualib:ShowNpcUi(actor, client_class_name, tab.level.."#"..tab.cur)
end

function TalismanNpc:onClickUnseal(actor, npc_id)
    npc_id = tonumber(npc_id)
    local equip_index = 16
    local _tips1 = "需要佩戴宗师盾牌!"
    local dh_name = "次元神符"
    local giveItem_name = "异界:次元之盾"
    if npc_id == 390 then
        equip_index = 9
        _tips1 = "需要佩戴宗师兵符!"
        dh_name = "次元神盾"
        giveItem_name = "异界:次元兵符"
    end
    local equip = linkbodyitem(actor, equip_index)
    if "0" == equip then
        return Sendmsg9(actor, "ffffff", _tips1, 1)
    end
    local name = getiteminfo(actor, equip, 7)
    if nil == name or "" == nil or string.find(name, "宗师") == nil then
        return Sendmsg9(actor, "ffffff", _tips1, 1)
    end
    local cur_level = getitemaddvalue(actor, equip, 2, 3, 0)
    if cur_level < 25 then
        return Sendmsg9(actor, "ffffff", "觉醒等级未满!", 1)
    end
    local tab = self:getEquipData(actor, equip)
    if tab.open == "0" or tab.open == 0 then     -- 激活
        tab.open = 1
        tab.show = 2
        tab.name = dh_name
        tab.imgcount = 1
        tab.cur = 0
        tab.max = 3000
        tab.level = 0
        tab.color = 255
    end
    local _cfg = self.cfg[tab.level]
    for k, v in pairs(_cfg.needitem_map) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."不足" , 1)
        end
    end
    for k, v in pairs(_cfg.needitem_map) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v) then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."扣除") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        end
    end
    local add_attr_str = getitemcustomabil(actor, equip)
    delbodyitem(actor, equip_index, "___扣除装备"..equip_index)
    giveonitem(actor, equip_index, giveItem_name, 1,307)
    equip = linkbodyitem(actor, equip_index)
    tab.level = 1
    _cfg = self.cfg[tab.level]
    tab.max = _cfg.Progress
    tab.cur = 0
    local attr_str = _cfg.attrStr2
    if npc_id == 390 then
        attr_str = _cfg.attrStr
    end
    setitemcustomabil(actor, equip, add_attr_str)
    setitemaddvalue(actor, equip, 2, 3, cur_level)
    setaddnewabil(actor, equip_index, "=", attr_str)
    setcustomitemprogressbar(actor, equip, 0, tbl2json(tab))
    refreshitem(actor,equip)
    lualib:FlushNpcUi(actor, "TalismanOBJ", tab.level.."#"..tab.cur)
    return Sendmsg9(actor,  "ffffff", "恭喜你, 解封成功" , 1)
end

function TalismanNpc:onClickWakeUp(actor, npc_id)
    npc_id = tonumber(npc_id)
    local equip_index = 16
    local _tips = "次元之盾成长值未满!"
    if npc_id == 390 then
        equip_index = 9
        _tips = "次元兵符成长值未满!"
    end
    local equip = linkbodyitem(actor, equip_index)
    local tab = self:getEquipData(actor, equip)
    if tab.open == "0" or tab.open == 0 then     -- 激活
        return Sendmsg9(actor, "ffffff", "未佩戴宗师装备!", 1)
    else
        tab.level = tonumber(tab.level)
        tab.cur = tonumber(tab.cur)
        if tab.cur < tab.max then
            return Sendmsg9(actor, "ffffff", _tips, 1)
        end
    end
    if tab.level >= 11 then
        return Sendmsg9(actor, "ffffff", "已满级！", 1)
    end
    local _cfg = self.cfg[tab.level]
    for k, v in pairs(_cfg.needitem_map) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."不足" , 1)
        end
    end
    for k, v in pairs(_cfg.needitem_map) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v) then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."扣除") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        end
    end
    tab.level = tab.level + 1
    _cfg = self.cfg[tab.level]
    tab.max = _cfg.Progress
    tab.cur = 0
    local attr_str = _cfg.attrStr
    if npc_id == 390 then
        attr_str = _cfg.attrStr
    end
    setaddnewabil(actor, equip_index, "=", attr_str)
    setcustomitemprogressbar(actor, equip, 0, tbl2json(tab))
    refreshitem(actor,equip)
    lualib:FlushNpcUi(actor, "TalismanOBJ", tab.level.."#"..tab.cur)
    lualib:FlushNpcUi(actor, "GodShieldOBJ", tab.level.."#"..tab.cur)
    return Sendmsg9(actor,  "ffffff", "恭喜你, 唤醒成功" , 1)
end

function TalismanNpc:getEquipData(actor, equip)
    local str = getcustomitemprogressbar(actor, equip, 0)
    return json2tbl(str)
end

return TalismanNpc
