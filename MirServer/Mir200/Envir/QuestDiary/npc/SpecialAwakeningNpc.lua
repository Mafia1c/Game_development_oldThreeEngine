local SpecialAwakeningNpc = {}
SpecialAwakeningNpc.cfg = include("QuestDiary/config/SpecialAwakeningCfg.lua")

function SpecialAwakeningNpc:click(actor, npc_id)
    local equip = linkbodyitem(actor, 13)
    local cur_level = getitemaddvalue(actor, equip, 2, 3, 0)
    if cur_level < 0 then
        cur_level = 0
    end
    lualib:ShowNpcUi(actor, "SpecialAwakeningOBJ", cur_level)
end

function SpecialAwakeningNpc:onUiPageChange(actor, equip_index)
    equip_index = tonumber(equip_index)
    local equip = linkbodyitem(actor, equip_index)
    local cur_level = getitemaddvalue(actor, equip, 2, 3, 0)
    if cur_level < 0 then
        cur_level = 0
    end
    lualib:FlushNpcUi(actor, "SpecialAwakeningOBJ", cur_level)
end

function SpecialAwakeningNpc:onStartAwakening(actor, equip_index)
    equip_index = tonumber(equip_index)
    local equip = linkbodyitem(actor, equip_index)
    local cur_level = getitemaddvalue(actor, equip, 2, 3, 0)
    if cur_level >= 25 then
        return Sendmsg9(actor, "ffffff", "觉醒等级已满!", 1)
    end
    if "0" == equip then
        return Sendmsg9(actor, "ffffff", "请将需要觉醒的特殊装备佩戴在身上!", 1)
    end
    local equip_name = getiteminfo(actor, equip, 7)
    if nil == string.find(equip_name, "宗师") then
        return Sendmsg9(actor, "ffffff", "请检查是否佩戴宗师装备!", 1)
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
    if attr_type == 1 then
        add_value = add_value * 100
    end
    tmp_tab[#tmp_tab + 1] = {250, tonumber(_tab[1]), add_value, attr_type, 0, #tmp_tab + 1, #tmp_tab}
    for k, v in pairs({5, 10, 15, 20, 25}) do
        if cur_level >= v then
            local _add_str = self.cfg[name]["stage"..v]
            local add_tab = strsplit(_add_str, "#")
            tmp_tab[#tmp_tab + 1] = {253, tonumber(add_tab[1]), tonumber(add_tab[2]), 1, 0, #tmp_tab + 1, #tmp_tab}
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
    setitemaddvalue(actor, equip, 2, 3, cur_level)
    lualib:FlushNpcUi(actor, "SpecialAwakeningOBJ", cur_level)
    return Sendmsg9(actor,  "ffffff", "觉醒成功!" , 1)
end

function SpecialAwakeningNpc:getAttrKeyName(index)
    local key = "defense"
    local attr_type = 1
    local equip_name = "斗笠"
    if index == 13 then
        key = "defense"
        equip_name = "斗笠"
    end
    if index == 2 then
        key = "hp"
        equip_name = "勋章"
    end
    if index == 9 then
        key = "armor"
        attr_type = 0
        equip_name = "兵符"
    end
    if index == 16 then
        key = "magicdef"
        equip_name = "盾牌"
    end
    return key, attr_type, equip_name
end

return SpecialAwakeningNpc