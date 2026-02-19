local EscortAgencyNpc = {}
EscortAgencyNpc.cfg = include("QuestDiary/config/EscortAgencyUICfg.lua")
EscortAgencyNpc.car_level = 0
EscortAgencyNpc._active_start = nil                        -- 押镖活动开始or结束标记
EscortAgencyNpc.role_list = {}
EscortAgencyNpc.double_reward = false
EscortAgencyNpc.weight_tab = {
    [1] = {
        weight = 400,
        value = 1
    },
    [2] = {
        weight = 300,
        value = 2
    },
    [3] = {
        weight = 200,
        value = 3
    },
    [4] = {
        weight = 50,
        value = 4
    },
}

function EscortAgencyNpc:click(actor, npc_id)
    npc_id = tonumber(npc_id)
    local cur_time = os.time()
    local run_time = getsysvar(VarEngine.RunTime)
    local open_day = getsysvar(VarEngine.OpenDay)
    local state = 2
    if self._active_start then
        state = 1
    elseif nil == self._active_start then
        state = 0
    end
    if npc_id == 97 and open_day < 1 and run_time < 86400 then   -- 新区
        state = 0
    end
    lualib:ShowNpcUi(actor, "EscortAgencyOBJ", state.."#"..npc_id)       --0.未开始   1.进行中   2.已结束
end

-- 开始押镖
function EscortAgencyNpc:onClickStartBtn(actor, index, npc_id)
    index = tonumber(index)
    npc_id = tonumber(npc_id)
    -- local cur_time = os.time()
    -- local open_time = gettimestamp(20, 0, 0)
    -- local open_day = getsysvar(VarEngine.OpenDay)
    if not EscortAgencyNpc._active_start then
        return Sendmsg9(actor, "ffffff", "押镖活动未开始!", 1)
    end
    if self.double_reward and npc_id == 97 then
        return Sendmsg9(actor, "ffffff", "押镖活动未开始!", 1)
    end
    if hastimer(actor, 1900) then
        return Sendmsg9(actor, "ffffff", "你已领取押镖任务!", 1)
    end
    if self.double_reward then
        index = weightedRandom(self.weight_tab).value
    end

    self.car_level = index
    local _cfg = self.cfg[index]
    local money_id = tonumber(getstditeminfo(_cfg["yb_tj"], 0))
    local money = querymoney(actor, money_id)
    local need_money = _cfg.tjNum
    local count = VarApi.getPlayerJIntVar(actor, "J__yabiaocishu")
    if self.double_reward then
        if count >= 1 then
            return Sendmsg9(actor, "ffffff", "你的押镖次数(双倍)已用完!", 1)
        end
    else
        if count >= 3 then
            return Sendmsg9(actor, "ffffff", "你的押镖次数已用完!", 1)
        end
    end

    if not self.double_reward and money < need_money then
        return Sendmsg9(actor,"ffffff", _cfg["yb_tj"].."数量不足!", 1)
    end
    if not self.double_reward and need_money > 0 and not changemoney(actor, money_id, "-", need_money, _cfg["yb_tj"].."扣除", true) then
        return Sendmsg9(actor, "ff0000", _cfg["yb_tj"].."扣除失败！", 1)
    end
    
    count = count + 1
    local mon = recallmob(actor, _cfg["yb_level"], 0, 3600)
    VarApi.setPlayerTStrVar(actor, "T_biaoche_mon", mon)
    darttime(actor, 900, 0)
    if self.double_reward then
        dartmap(actor, 30, 84, 7)
        local remain_time = self.active_name == "双倍押镖活动1" and 30*60 or 70 * 60 
        remain_time = remain_time 
        senddelaymsg(actor, "<剩余押镖时间: %s后将自动离开地图!/FCOLOR=250>", remain_time - getsysvar(VarEngine.RunTime), 255, 1, "@_run_time_callback")
        VarApi.setPlayerTStrVar(actor, "T_biaoche_get_time", remain_time)
    else
        dartmap(actor, 407, 326, 7)
    end

    VarApi.setPlayerJIntVar(actor, "J__yabiaocishu", count)
    VarApi.setPlayerUIntVar(actor, "U__in_task",  self.car_level)
    lualib:CloseNpcUi(actor, "EscortAgencyOBJ")

    if self.double_reward then
    else
        setontimer(actor, 1900, 600)
    end
    local data = {
        userId = getbaseinfo(actor, 2),
        is_complete = false
    }
    EscortAgencyNpc.role_list[actor] = data
    EscortAgencyNpc.role_actor = actor
end

function ontimer1900(actor)
    setofftimer(actor, 1900)
    local in_task = VarApi.getPlayerUIntVar(actor, "U__in_task")
    local _cfg = EscortAgencyNpc.cfg[in_task]
    if in_task > 0 then
        VarApi.setPlayerUIntVar(actor, "U__in_task",  0)
        local mon = VarApi.getPlayerTStrVar(actor, "T_biaoche_mon")
        killmonbyobj(actor, mon, false, false, false)
        VarApi.setPlayerTStrVar(actor, "T_biaoche_mon", "")
        messagebox(actor, "押镖时间超时, 本次押镖失败!", "@_yb_CallBack_ok", "")
    end
    EscortAgencyNpc.role_list[actor] = nil
end

function EscortAgencyNpc:onClickComplete(actor)
    local in_task = VarApi.getPlayerUIntVar(actor, "U__in_task")
    if 0 == in_task then
        return Sendmsg9(actor,"ffffff", "这位少侠, 你的镖车呢?", 1)
    end

    local data = EscortAgencyNpc.role_list[actor]
    if not data or not data.is_complete then
        return Sendmsg9(actor,"ffffff", "镖车距离我太远了, 叫我如何检查货物呢?", 1)
    end
    local _cfg = self.cfg[in_task]
    local exp = _cfg["ybExp"]               -- 只有经验
    local open_day = getsysvar(VarEngine.OpenDay)
    if self.double_reward then
        exp = exp * 2
        VarApi.setPlayerTStrVar(actor, "T_biaoche_get_time", 0)
    end
    changeexp(actor, "+", exp, false)
    setofftimer(actor, 1900)
    local money_id = tonumber(getstditeminfo(_cfg["yb_tj"], 0))
    local need_money = _cfg.tjNum
    if changemoney(actor, money_id, "+", need_money, _cfg["yb_tj"].."增加", true) then
        release_print("货币返还!")
    end

    self.car_level = 0
    lualib:CloseNpcUi(actor, "BiaoJuMasterOBJ")
    VarApi.setPlayerUIntVar(actor, "U__in_task",  self.car_level)
    local mon = VarApi.getPlayerTStrVar(actor, "T_biaoche_mon")
    killmonbyobj(actor, mon, false, false, false)
    VarApi.setPlayerTStrVar(actor, "T_biaoche_mon", "")
    senddelaymsg(actor, "", 0, 255, 0)

    EscortAgencyNpc.role_list[actor] = nil
    if self.double_reward then
        mapmove(actor, 3, 330, 330, 3)
    end
    return Sendmsg9(actor, "ffffff", "恭喜完成押镖, 奖励已发放！", 1)
end

function EscortAgencyNpc:activeStart(cfg)
    self.active_name = cfg.key_name 
    delscheduled(cfg.key_name .. "_start")
    EscortAgencyNpc._active_start = true
    if cfg.double then
        EscortAgencyNpc.double_reward = cfg.double
        for k, v in pairs(EscortAgencyNpc.role_list) do     -- 双倍押镖开始后重置押镖次数
            local actor = getplayerbyid(v.userId)
            if actor and isnotnull(actor) then
                VarApi.setPlayerJIntVar(actor, "J__yabiaocishu", 0)
            end
        end
        if EscortAgencyNpc.role_actor and isnotnull(EscortAgencyNpc.role_actor) then
            VarApi.setPlayerJIntVar(EscortAgencyNpc.role_actor, "J__yabiaocishu", 0)
            EscortAgencyNpc.role_actor = nil
        end
    else
        EscortAgencyNpc.double_reward = false
    end
end

function EscortAgencyNpc:activeStop(cfg)
    delscheduled(cfg.key_name .. "_stop")
    EscortAgencyNpc._active_start = false
    EscortAgencyNpc.double_reward = false
    for k, v in pairs(EscortAgencyNpc.role_list) do
        local actor = getplayerbyid(v.userId)
        if actor and isnotnull(actor) then
            -- if hastimer(actor, 1900) then
            ontimer1900(actor)
            senddelaymsg(actor, "", 0, 255, 0)
            -- end
        end
    end
end

function _run_time_callback(actor)
    local in_task = VarApi.getPlayerUIntVar(actor, "U__in_task")
    if in_task == 0 then
        messagebox(actor, "押镖时间超时, 本次押镖失败!", "@_yb_CallBack_ok", "")
    end
    ontimer1900(actor)
    VarApi.setPlayerTStrVar(actor, "T_biaoche_get_time", 0)
end

function _yb_CallBack_ok(actor)

end

-- 镖车进入自动寻路范围触发
local function _onCarfindmaster(actor)
    release_print("_onCarfindmaster ****")
end
-- 丢失镖车触发
local function _onLosercar(actor, car)
    release_print("_onLosercar ****")
    -- ontimer1900(actor)
end
-- 镖车到达指定位置触发
local function _onCarpathend(actor)
    if EscortAgencyNpc.role_list[actor] then
        EscortAgencyNpc.role_list[actor].is_complete = true
    end
end
-- 镖车死亡触发
local function _onCardie(killActor, car)
    release_print("_onCardie ****")
end
-- 镖车被攻击触发
local function _onslavedamage(actor, hiter, car)
    release_print("_onslavedamage ****")
    Sendmsg9(actor, "ffffff", "你的镖车正在被攻击!", 1)
end

GameEvent.add("carfindmaster", _onCarfindmaster, "EscortAgencyNpc")
GameEvent.add("losercar", _onLosercar, "EscortAgencyNpc")
GameEvent.add("carpathend", _onCarpathend, "EscortAgencyNpc")
GameEvent.add("cardie", _onCardie, "EscortAgencyNpc")
GameEvent.add("slavedamage", _onslavedamage, "EscortAgencyNpc")

return EscortAgencyNpc