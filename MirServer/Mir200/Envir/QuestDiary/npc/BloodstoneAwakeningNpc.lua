local BloodstoneAwakeningNpc = {}
local __cfg = include("QuestDiary/config/BloodstoneAwakeningCfg.lua")
BloodstoneAwakeningNpc.cfg = __cfg
BloodstoneAwakeningNpc.select_state = BloodstoneAwakeningNpc.select_state or {}
BloodstoneAwakeningNpc.restricted_number = BloodstoneAwakeningNpc.restricted_number or {}

function BloodstoneAwakeningNpc:click(actor, npc_id)
    self.select_state[actor] = {0, 0, 0}
    local id_tab = self:getAwakeningAttrId(actor)
    lualib:ShowNpcUi(actor, "BloodstoneAwakeningOBJ", tbl2json(id_tab))
end

function BloodstoneAwakeningNpc:onClickAwakening(actor, show_tips)
    local equip = linkbodyitem(actor, 12)
    if "0" == equip or string.find(getiteminfo(actor, equip, 7), "MAX") == nil then
        return  Sendmsg9(actor, "ffffff", "仅限 [魔血石·MAX] 可进行觉醒属性!", 1)
    end
    local id_tab = self:getAwakeningAttrId(actor)

    local tmp_list = self.select_state[actor] or {0, 0, 0}
    local lock_count = 0
    for k, v in ipairs(tmp_list) do
        lock_count = lock_count + v
    end

    local _list = {
        [0] = "nolock",
        [1] = "onelock",
        [2] = "twolock",
        [3] = "threelock"
    }
    local cfg = BloodstoneAwakeningNpc.cfg or {}
    local _cfg = cfg[_list[lock_count]]
    local need_data = _cfg.needitem_map
    for k, v in pairs(need_data) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."不足" , 1)
        end
    end
    for k, v in pairs(need_data) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v, "血石觉醒扣除!") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."血石觉醒扣除!") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        end
    end

    local v1 = self:getRandomAttr(actor, cfg)
    local v2 = self:getRandomAttr(actor, cfg)
    local v3 = self:getRandomAttr(actor, cfg)

    local gs_xueshi = VarApi.getPlayerTStrVar(actor,"T_gs_xueshijuexing")
    local gs_bichu_tab = strsplit(gs_xueshi,"#")
    release_print(gs_bichu_tab)
    local bichu_pos = tonumber(gs_bichu_tab[1]) or 0 
    local bichu_attr_type = tonumber(gs_bichu_tab[2]) 
    local sMsg = nil
    if tmp_list[1] == 1 then
        sMsg = "0"
    else
        if bichu_pos == 1 and bichu_attr_type then
            sMsg = bichu_attr_type
            id_tab[1] = bichu_attr_type
        else
            sMsg = v1.key_name
            id_tab[1] = v1.key_name
        end
    end
    if tmp_list[2] == 1 then
        sMsg = sMsg.."#0"
    else
        if bichu_pos == 2 then
            sMsg = sMsg.."#"..bichu_attr_type
            id_tab[2] = bichu_attr_type
        else
            sMsg = sMsg.."#"..v2.key_name
            id_tab[2] = v2.key_name
        end
    end
    if tmp_list[3] == 1 then
        sMsg = sMsg.."#0"
    else
        if bichu_pos == 3 then
            sMsg = sMsg.."#"..bichu_attr_type
            id_tab[3] = bichu_attr_type
        else
            sMsg = sMsg.."#"..v3.key_name
            id_tab[3] = v3.key_name
        end
    end
    if bichu_pos > 0 then
        VarApi.setPlayerTStrVar(actor,"T_gs_xueshijuexing","")
    end
    if lock_count >= 3 then
        return  Sendmsg9(actor, "ffffff", "觉醒成功!", 1)
    end
    lualib:FlushNpcUi(actor, "BloodstoneAwakeningOBJ", sMsg)
    self:giveReward(actor, sMsg)
    VarApi.setPlayerTStrVar(actor, "T_bloodstone_ids", tbl2json(id_tab))
    return Sendmsg9(actor, "ffffff", "觉醒成功!", 1)
end

function BloodstoneAwakeningNpc:getRandomAttr(actor, items)
    local user_id = getbaseinfo(actor, 2)
    self.restricted_number[user_id] = self.restricted_number[user_id] or nil

    -- 计算总权重
    local totalWeight = 0
    local tmp_items = {}
    for _, item in pairs(items) do
        if item.weight and tonumber(item.weight) ~= nil and self.restricted_number[user_id] ~= item.key_name then
            totalWeight = totalWeight + item.weight
            tmp_items[#tmp_items + 1] = item
        end
    end
    local ret = nil
    -- 生成随机数
    local randomValue = math.random() * totalWeight
    -- 选择对应的项目
    local currentWeight = 0
    for _, item in pairs(tmp_items) do
        if item.weight and tonumber(item.weight) ~= nil then
            currentWeight = currentWeight + item.weight
            if randomValue <= currentWeight then
                ret = item
                break
            end
        end
    end

    -- 如果所有检查都失败(理论上不应该发生)，返回最后一个项目
    if nil == ret then
        ret = tmp_items[#tmp_items]
    end
    if ret.key_name == 72 then
        self.restricted_number[user_id] = 72
    end
    return ret
end

function BloodstoneAwakeningNpc:onChangeLockState(actor, index, value)
    index = tonumber(index)
    value = tonumber(value)
    local id_tab = self:getAwakeningAttrId(actor)
    if nil == id_tab[index] or tonumber(id_tab[index]) == 0 then
        lualib:FlushNpcUi(actor, "BloodstoneAwakeningOBJ", "flushView#"..index.."#0")
        return Sendmsg9(actor, "ffffff", "该位置还未觉醒属性!", 1)
    end
    if nil == self.select_state[actor] then
        self.select_state[actor] = {}
    end
    self.select_state[actor][index] = value
    lualib:FlushNpcUi(actor, "BloodstoneAwakeningOBJ", "flushView#"..index.."#"..value)
end

function BloodstoneAwakeningNpc:giveReward(actor, reward_str)
    local id_tab = strsplit(reward_str, "#")
    local equip = linkbodyitem(actor, 12)
    local attr_str = getitemcustomabil(actor, equip)
    local attr_tab = json2tbl(attr_str)    
    local tmp_tab = {}
    if "" == attr_tab or nil == attr_tab then
        attr_tab = {
            ["abil"] = {}
        }
    end
    local last_change_level = 0
    local tmp_list = self:getAwakeningAttrId(actor)
    for k, v in pairs(tmp_list) do
        local index = tonumber(id_tab[k])
        if tonumber(v) == 72 and index ~= 0 then
            last_change_level = last_change_level + 1
        end
    end

    local tbl = {
        ["i"] = 0,
        ["t"] = "[觉醒属性]: ",
        ["c"] = 253,
        ["v"] = tmp_tab,
    }
    local add_level_value = 0
    for k, v in ipairs(id_tab) do
        local index = tonumber(v)
        if index ~= 0 then
            local cfg = self.cfg[index]
            for attrId, value in pairs(cfg.arrid_map) do
                local attr_type = 1
                if isInTable({16, 17, 20, 78, 13, 14, 71, 239, 240}, attrId) then
                    attr_type = 0
                end
                tmp_tab[k] = {cfg.color, attrId, value, attr_type, 0, k, k-1}
            end
            if index == 72 then
                add_level_value = add_level_value + 1
            end
        else
            tmp_tab[k] = attr_tab.abil[1].v[k]
        end
    end
    attr_tab.abil[1] = tbl
    setitemcustomabil(actor, equip, tbl2json(attr_tab))
    if last_change_level > 0 then
        changelevel(actor, "-", last_change_level)
    end
    if add_level_value > 0 then
        changelevel(actor, "+", add_level_value)
    end
end

function BloodstoneAwakeningNpc:getAwakeningAttrId(actor)
    local user_id = getbaseinfo(actor, 2)
    local tmp_tab = {0,0,0}
    local is_str = VarApi.getPlayerTStrVar(actor, "T_bloodstone_ids")
    if "" ~= is_str then
        tmp_tab = json2tbl(is_str)
    end
    for key, value in pairs(tmp_tab) do
        if value == 72 then
            self.restricted_number[user_id] = value
            break
        end
    end
    return tmp_tab
end

return BloodstoneAwakeningNpc