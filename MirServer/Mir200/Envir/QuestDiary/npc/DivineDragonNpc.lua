local DivineDragonNpc = {}
local __cfg = include("QuestDiary/config/DivineDragonCfg.lua")
DivineDragonNpc.cfg = __cfg
DivineDragonNpc.index_ids = {87,88,89,90,91,92,93,94}
DivineDragonNpc.equip_ids = {50989,50990,50991,50992,50993,50994,50995,50996}

function DivineDragonNpc:click(actor, npc_id)
    lualib:ShowNpcUi(actor, "DivineDragonOBJ", npc_id)
end

function DivineDragonNpc:onClickUnseal(actor, index)
    index = tonumber(index)
    local cfg = self.cfg[index]
    local equip_index = self.index_ids[index]
    local equip = linkbodyitem(actor, equip_index)
    if "0" == equip then
        return Sendmsg9(actor, "ffffff", "请先佩戴正确的装备!", 1)
    end
    local equip_id = getiteminfo(actor, equip, 2)
    if not isInTable(self.equip_ids, equip_id) then
        return Sendmsg9(actor, "ffffff", "请先佩戴正确的装备!", 1)
    end
   for k, v in pairs(cfg.nedd_map) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if isInTable(self.equip_ids, equip_id) then
            num = v
        elseif item_id <= 100 then    
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."不足" , 1)
        end
    end
    for k, v in pairs(cfg.nedd_map) do
        local item_id = getstditeminfo(k, 0)
        if isInTable(self.equip_ids, item_id) then
            if not delbodyitem(actor, equip_index, "神龙宗师扣除装备") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        elseif item_id <= 100 then
            if not consumebindmoney(actor, k, v) then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."神龙宗师扣除") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        end
    end
    local bind = 307
    if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
        bind = 0
    end
    if not giveonitem(actor, equip_index, cfg.Name, 1, bind) then
        sendmail(getbaseinfo(actor, 2), 1, cfg.Name.."合成补发", cfg.Name.."合成后穿戴失败, 请及时领取", cfg.Name.."#1")
        Sendmsg9(actor, "ffffff", cfg.Name.."穿戴失败, 请去邮箱领取!", 1)
    else
        local _equip = linkbodyitem(actor, equip_index)
        setthrowitemly2(actor, _equip, tbl2json({["map"] = getbaseinfo(actor, 3),["source"] = 2, ["player"] = getbaseinfo(actor, 1), ["time"] = os.time()}))
    end
end

function DivineDragonNpc:updateEquipBindType(actor)
    local bind = 307
    if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
        bind = 0
    end    
    local equip_id_list = {50997,50998,50999,51000,51001,51002,51003,51004}
    for key, v in pairs(self.index_ids) do
        local equip = linkbodyitem(actor, v)
        local id = getiteminfo(actor, equip, 2)
        if isInTable(equip_id_list, id) then
            setitemaddvalue(actor, equip, 2, 1, bind)
        end
    end
end

return DivineDragonNpc