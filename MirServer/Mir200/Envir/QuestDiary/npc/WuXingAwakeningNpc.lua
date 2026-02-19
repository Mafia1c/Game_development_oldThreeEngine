local WuXingAwakeningNpc = {}
WuXingAwakeningNpc.cfg = include("QuestDiary/config/WuXingAwakeningCfg.lua")

function WuXingAwakeningNpc:click(actor, npc_id)
    local equip_index = {81,82,83,84,85}
    for k, v in pairs(equip_index) do
        local _eq = linkbodyitem(actor, v)
        local star = getitemaddvalue(actor, _eq, 2, 3)
        if star < 50 then
            return Sendmsg9(actor, "ffffff", "需要五行之力全部提升至Lv50方可进行觉醒!", 1)
        end
    end
    local equip = linkbodyitem(actor, 80)
    local cur_level = getitemaddvalue(actor, equip, 2, 19, 0)
    if cur_level < 0 then
        cur_level = 0
    end
    lualib:ShowNpcUi(actor, "WuXingAwakeningOBJ", cur_level)
end

function WuXingAwakeningNpc:onUiPageChange(actor, equip_index)
    equip_index = tonumber(equip_index)
    local equip = linkbodyitem(actor, equip_index)
    local cur_level = getitemaddvalue(actor, equip, 2, 19, 0)
    if cur_level < 0 then
        cur_level = 0
    end
    lualib:FlushNpcUi(actor, "WuXingAwakeningOBJ", cur_level)
end

function WuXingAwakeningNpc:onStartAwakening(actor, equip_index)
    equip_index = tonumber(equip_index)
    local equip = linkbodyitem(actor, equip_index)
    local cur_level = getitemaddvalue(actor, equip, 2, 19, 0)
    if cur_level >= 25 then
        return Sendmsg9(actor, "ffffff", "觉醒等级已满!", 1)
    end
    if "0" == equip then
        return Sendmsg9(actor, "ffffff", "请将需要觉醒的特殊装备佩戴在身上!", 1)
    end
    if cur_level < 0 then
        cur_level = 0
    end
    local cfg = self.cfg[cur_level]
    if nil == cfg then
        return
    end
    for k, v in pairs(cfg.need_map) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."不足" , 1)
        end
    end
    for k, v in pairs(cfg.need_map) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v) then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."神兵互换扣除") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        end
    end
    cur_level = cur_level + 1
    local tmp_tab = {}
    local attr_str = getitemcustomabil(actor, equip)
    local attr_tab = json2tbl(attr_str)
    if "" == attr_tab or nil == attr_tab then
        attr_tab = {
            ["abil"] = {}
        }
    end
    local key_name, attr_type, name = self:getAttrKeyName(equip_index)
    local add_attr_str = self.cfg[cur_level][key_name]
    local _tab = strsplit(add_attr_str, "#")
    local add_value = tonumber(_tab[2])
    -- 扩大100倍
    local tmp_list = {35,55,57,59,36,37,77,76,67,90}
    if isInTable(tmp_list, tonumber(_tab[1])) then
        add_value = add_value * 100
    end

    tmp_tab[#tmp_tab + 1] = {250, tonumber(_tab[1]), add_value, attr_type, 0, #tmp_tab + 1, #tmp_tab}
    for k, v in pairs({5, 10, 15, 20, 25}) do
        if cur_level >= v then
            local _add_str = self.cfg[name]["stage"..v]
            local add_tab = strsplit(_add_str, "#")
            local attr_id = tonumber(add_tab[1])
            local attr_value = tonumber(add_tab[2])
            -- 扩大100倍
            if isInTable(tmp_list, attr_id) then
                attr_value = attr_value * 100
            end
            tmp_tab[#tmp_tab + 1] = {253, attr_id, attr_value, 1, 0, #tmp_tab + 1, #tmp_tab}
        end
    end

    local tbl = {
        ["i"] = 2,
        ["t"] = "[觉醒属性]: ",
        ["c"] = 251,
        ["v"] = tmp_tab,
    }
    attr_tab.abil[3] = tbl
    setitemcustomabil(actor, equip, tbl2json(attr_tab))
    setitemaddvalue(actor, equip, 2, 19, cur_level)
    lualib:FlushNpcUi(actor, "WuXingAwakeningOBJ", cur_level)
    return Sendmsg9(actor,  "ffffff", "觉醒成功!" , 1)
end

function WuXingAwakeningNpc:onClickCompound(actor, index)
    local cfg_key = "compound"..index
    local _cfg = self.cfg[cfg_key]
    if nil == _cfg then
        return
    end
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
            if not takeitem(actor, k, v, 0, k.."神兵互换扣除") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        end
    end
    for k, v in pairs(_cfg.giveitem_map) do
        if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) < 68 then
            giveitem(actor, k, v,307)
        else
            giveitem(actor, k, v)
        end
        Sendmsg9(actor, "ffffff", "合成成功, 获得"..k.."x"..v, 1)
    end
end

function WuXingAwakeningNpc:getAttrKeyName(index)
    local key = "Physical"
    local attr_type = 1
    local equip_name = "坚韧之躯"
    if index == 81 then
        key = "Physical"
        equip_name = "坚韧之躯"
    end
    if index == 82 then
        key = "gmd"
        equip_name = "狂怒之心"
    end
    if index == 83 then
        key = "zhanshi"
        equip_name = "制裁之殇"
    end
    if index == 84 then
        key = "fashi"
        equip_name = "荆棘之力"
    end
    if index == 85 then
        key = "daoshi"
        equip_name = "宗师之威"
    end    
    return key, attr_type, equip_name
end

return WuXingAwakeningNpc