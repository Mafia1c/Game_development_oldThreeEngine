local BossSkullNpc = {}
local _cfg = include("QuestDiary/config/MibaobaozangCfg.lua")
local tmp_cfg = {}
for k, v in pairs(_cfg) do
    tmp_cfg[v.npcID] = v
end
BossSkullNpc.cfg = tmp_cfg

function BossSkullNpc:onClickNpc(actor, npc_id)
    npc_id = tonumber(npc_id)
    local state = VarApi.getPlayerUIntVar(actor, "U_mbbz_state_"..npc_id)
    local count = VarApi.getPlayerUIntVar(actor, "U_mbbz_kill_mon_"..npc_id)
    if state == 0 and self.cfg[npc_id].type == 2 then
        state = 1
        VarApi.setPlayerUIntVar(actor, "U_mbbz_state_"..npc_id, state)
    end

    lualib:ShowNpcUi(actor, "MiBaoBaoZangOBJ", npc_id.."#"..state.."#"..count)
end

function BossSkullNpc:onClickUiTask(actor, npc_id)
    npc_id = tonumber(npc_id)
    if BossSkullNpc.cfg[npc_id] then
        opennpcshowex(actor, npc_id, 1, 1)
    else
        Sendmsg9(actor, "ff0000", "收手吧阿祖, 外面全是成龙!", 1)
    end
end

function BossSkullNpc:onClickPickTask(actor, npc_id)
    npc_id = tonumber(npc_id)
    local cfg = BossSkullNpc.cfg[npc_id]
    local state = VarApi.getPlayerUIntVar(actor, "U_mbbz_state_"..npc_id)
    local count = VarApi.getPlayerUIntVar(actor, "U_mbbz_kill_mon_"..npc_id)
    local send_reward = false
    if state == 0 then
        state = 1
        local task_str = "点击前往接收秘宝任务"
        if state == 1 then
            if cfg.type == 2 then
                task_str = "点击前往提交秘宝任务"
            else
                task_str = "击杀本地图任意怪物: "..count.."/"..cfg.jindu.."只"
            end
        end
        local map_name = getbaseinfo(actor, 45)
        lualib:FlushNpcUi(actor, "MiBaoBZTaskObj", task_str.."#"..map_name.."#"..npc_id.."#"..state)
    elseif state == 1 then
        -- 领取奖励
        if cfg.type == 1 then
            if count >= cfg.jindu then
                send_reward = true
            end
        else
            local tmp_need = {}
            local str_tab = strsplit(cfg.jindu, "&")
            for k, v in pairs(str_tab) do
                local _tab = strsplit(v, "#")
                local value = getbagitemcount(actor, _tab[1], 0)
                local need_value = tonumber(_tab[2])
                if value < need_value then
                    Sendmsg9(actor, "ffffff", _tab[1].."不足!", 1)
                    return
                end
                tmp_need[_tab[1]] = need_value
            end
            for k, v in pairs(tmp_need) do
                if not takeitem(actor, k, v, "上缴秘宝宝藏任务") then
                    send_reward = false
                    return Sendmsg9(actor, "ffffff", k.."扣除失败!", 1)
                else
                    send_reward = true
                end
            end
        end
    end
    if send_reward then
        state = 2
        local exp = math.random(cfg.exp1_arr[1], cfg.exp1_arr[2])
        changeexp(actor, "+", exp, false)
        giveitem(actor, cfg.item, 1)
        changemoney(actor, 4, "+", cfg.bdyb, "秘宝宝藏任务获得!", true)
        lualib:CloseNpcUi(actor, "MiBaoBZTaskObj")
    end
    lualib:FlushNpcUi(actor, "MiBaoBaoZangOBJ", state)
    VarApi.setPlayerUIntVar(actor, "U_mbbz_state_"..npc_id, state)
end

local function _onKillMon(actor, monObj,killerType,monId,monName, mapID)
    local info = nil
    for k, v in pairs(BossSkullNpc.cfg) do
        if v.mapid == mapID then
            info = v
            break
        end
    end
    if not info then
        return
    end
    local state = VarApi.getPlayerUIntVar(actor, "U_mbbz_state_"..info.npcID)
    if type(info.jindu) == "number" and state == 1 then
        local count = VarApi.getPlayerUIntVar(actor, "U_mbbz_kill_mon_"..info.npcID)
        count = count + 1
        if count > info.jindu then
            count = info.jindu
        end
        VarApi.setPlayerUIntVar(actor, "U_mbbz_kill_mon_"..info.npcID, count)
        if state == 1 then
            local task_str = "击杀本地图任意怪物: "..count.."/"..info.jindu.."只"
            local map_name = getbaseinfo(actor, 45)
            lualib:FlushNpcUi(actor, "MiBaoBZTaskObj", task_str.."#"..map_name.."#"..info.npcID.."#"..state)
        end
    end
    return true
end
GameEvent.add("killmon", _onKillMon, "秘宝宝藏_kill_mon")

local function _onEnterMap(actor, map_id, x, y)
    local info = nil
    for k, v in pairs(BossSkullNpc.cfg) do
        if v.mapid == map_id then
            info = v
            break
        end
    end
    if info then
        local npc_id = info.npcID
        local state = VarApi.getPlayerUIntVar(actor, "U_mbbz_state_"..npc_id)
        local count = VarApi.getPlayerUIntVar(actor, "U_mbbz_kill_mon_"..npc_id)
        if state < 2 then
            if state == 0  then
                state = 1
                VarApi.setPlayerUIntVar(actor, "U_mbbz_state_"..npc_id, state)
            end
            local task_str = "点击前往接收秘宝任务"
            if state == 1 then
                if info.type == 2 then
                    task_str = "点击前往提交秘宝任务"
                else
                    task_str = "击杀本地图任意怪物: "..count.."/"..info.jindu.."只"
                end
            end
            local map_name = getbaseinfo(actor, 45)
            lualib:ShowNpcUi(actor, "MiBaoBZTaskObj", task_str.."#"..map_name.."#"..npc_id.."#"..state)
        end
    else
        lualib:CloseNpcUi(actor, "MiBaoBZTaskObj")
    end
    return true
end
GameEvent.add("entermap", _onEnterMap, "秘宝宝藏_enter_map")

return BossSkullNpc