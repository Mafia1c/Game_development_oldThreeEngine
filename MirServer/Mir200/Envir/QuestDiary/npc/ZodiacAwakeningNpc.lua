local ZodiacAwakeningNpc = {}
ZodiacAwakeningNpc.cfg = include("QuestDiary/config/ZodiacAwakeningCfg.lua")

function ZodiacAwakeningNpc:click(actor, npc_id, index)
    index = tonumber(index)
    local _cfg = self.cfg[index]
    local equip = linkbodyitem(actor, _cfg.location)
    local cur_value = getitemaddvalue(actor, equip, 2, 19, 0)
    lualib:ShowNpcUi(actor, "ZodiacAwakeningOBJ", cur_value)
end

function ZodiacAwakeningNpc:onChangeZodiac(actor, index)
    index = tonumber(index)
    local _cfg = self.cfg[index]
    local equip = linkbodyitem(actor, _cfg.location)
    local cur_value = getitemaddvalue(actor, equip, 2, 19, 0)
    lualib:FlushNpcUi(actor, "ZodiacAwakeningOBJ", cur_value)
end

function ZodiacAwakeningNpc:onStartAwakening(actor, index)
    local equip_index = tonumber(index)
    local _cfg = self.cfg[equip_index]
    local equip = linkbodyitem(actor, _cfg.location)
    if "0" == equip then
        return Sendmsg9(actor, "ffffff", "请将需要觉醒的生肖装备佩戴在身上!", 1)
    end
    local equip_name = getiteminfo(actor, equip, 7)
    if equip_name == 0 then
        return Sendmsg9(actor, "ffffff", "请将需要觉醒的生肖装备佩戴在身上!", 1)
    end
    if nil == string.find(equip_name, "传承") then
        return Sendmsg9(actor, "ffffff", "只能觉醒传承生肖!", 1)
    end

    for k, v in pairs(_cfg.needItem_map) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."不足" , 1)
        end
    end
    for k, v in pairs(_cfg.needItem_map) do
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
    local ret = math.random(1, 100)
    if ret > _cfg.Success then
        return Sendmsg9(actor,  "ffffff", "觉醒失败!" , 1)
    end

    local cur_value = 0
    local weight_tab = getWeightedCfg(_cfg.weight)
    cur_value = weightedRandom(weight_tab).value
    local attr_cfg = self.cfg["att"..cur_value]
    setaddnewabil(actor, -2, "=", attr_cfg.gmdfy, equip)
    setitemaddvalue(actor, equip, 2, 19, cur_value)
    lualib:FlushNpcUi(actor, "ZodiacAwakeningOBJ", cur_value)
    return Sendmsg9(actor,  "ffffff", "觉醒成功, 本次获得属性x" .. cur_value, 1)

end

function ZodiacAwakeningNpc:fenJieZodiacEquip(actor, type)
    type = tonumber(type)
    local box_str = "是否确定分解上古系列生肖\\点击确定将分解背包所有道具"
    if type == 2 then
        box_str = "是否确定分解传承系列生肖\\<font color='#ff0000' size='18' >分解时不会区分是否有觉醒属性</font> \\点击确定将分解背包所有道具"
    end
    messagebox(actor, box_str, "@_g_click_ok_fj,"..type, "@_g_click_no_fj")
end

function _g_click_ok_fj(actor, type)
    type = tonumber(type)
    local tmp_tab = {"reclaimsg", "reclaimcc"}
    local cfg = ZodiacAwakeningNpc.cfg[tmp_tab[type]]
    if nil == cfg then
        return
    end
    local count = 0
    local equip_names = strsplit(cfg.reclaimclb_map, "|")
    for k, v in pairs(equip_names) do
        local num = getbagitemcount(actor, v, 0)
        if num > 0 and takeitem(actor, v, num, 0, v.."扣除!") then
            count = count + num
        end
    end
    if count <= 0 then
        return Sendmsg9(actor,  "ffffff", "没有可分解的装备!" , 1)
    end
    local give_item_tips = ""
    for k, v in pairs(cfg.reclaimcl_map) do
        if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) < 68 then
            giveitem(actor, k, count * v,307)
        else
            giveitem(actor, k, count * v)
        end
        
        give_item_tips = k .. "x"..count * v
    end
    return Sendmsg9(actor, "ffffff", "分解成功, 获得" .. give_item_tips .. "!", 1)
end

return ZodiacAwakeningNpc