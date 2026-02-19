local ShaBaKeNpc = {}
ShaBaKeNpc.map_cfg = {
    [1] = {"3", 644, 288, 1},
    [2] = {"3", 635, 284, 1},
    [3] = {"3", 618, 261, 1},
    [4] = {"0150"},
}
function ShaBaKeNpc:click(actor, npc_id)
    local state = self:getCurState()
    local point = VarApi.getPlayerJIntVar(actor, "J_castlewar_point")
    lualib:ShowNpcUi(actor, "ShaBaKeOBJ", state.."#"..point)
end

function ShaBaKeNpc:onClickMapMove(actor, index)
    local state = self:getCurState()
    local tips_str = nil  
    if state == 0 then
        tips_str = "攻城未开始!"
    elseif state == 2 then
        tips_str = "攻城已结束!"
    end
    if tips_str then
        return Sendmsg9(actor, "ffffff", tips_str, 1)
    end
    local guild_name = getbaseinfo(actor, 36)
    if "" == guild_name then
        Sendmsg9(actor, "ffffff", "你未加入任何行会!", 1)
        return
    end
    index = tonumber(index)
    local cfg = self.map_cfg[index]
    if index == 4 then
        local dateInfo = os.date("*t")
        local min = dateInfo.min
        if min >= 50 then
            Sendmsg9(actor, "ffffff", "直飞皇宫时间已过!", 1)
            return
        end
        local value = getbindmoney(actor, "元宝")
        if value < 500 then
            return Sendmsg9(actor, "ffffff", "元宝不足!", 1)
        end
        if not consumebindmoney(actor, "元宝", 500, "沙巴克扣除") then
            return Sendmsg9(actor, "ffffff", "元宝扣除失败!", 1)
        end
        map(actor, cfg[1])
    else
        mapmove(actor, cfg[1], cfg[2], cfg[3], cfg[4])
    end
    lualib:CloseNpcUi(actor, "ShaBaKeOBJ")
end

function ShaBaKeNpc:onClickGetReward(actor)
    local end_time = getsysvar(VarEngine.CastEndTime)
    local run_time = os.time() - end_time
    if run_time > 180 then
        Sendmsg9(actor, "ffffff", "奖励已领取或未到领奖时间!", 1)
        return
    end
    if VarApi.getPlayerJIntVar(actor, "J_castlewar_reward") == 1 then
        Sendmsg9(actor, "ffffff", "你的奖励已领取!", 1)
        return
    end
    local point = VarApi.getPlayerJIntVar(actor, "J_castlewar_point")
    if castleidentity(actor) == 0 then
        if point >= 1200 then
            changemoney(actor, 7, "+", CastleWarTrigger.loser_reward, "攻沙奖励~~", true)
            Sendmsg9(actor, "ffffff", "获得攻沙奖励x"..CastleWarTrigger.loser_reward.."灵符", 1)
        end
    elseif castleidentity(actor) > 0 then
        changemoney(actor, 7, "+", CastleWarTrigger.winner_reward, "攻沙奖励~~", true)
        Sendmsg9(actor, "ffffff", "获得攻沙奖励x"..CastleWarTrigger.winner_reward.."灵符", 1)
        if castleidentity(actor) == 2 then
            confertitle(actor, "沙城主")
            changetitletime(actor, "沙城主", "=", os.time() + 86400)
        end
    end
    if point >= 1200 then
        giveitem(actor, "时装宝箱", 1, 307, "攻沙奖励!")
    end
    VarApi.setPlayerJIntVar(actor, "J_castlewar_reward", 1)
end

function ShaBaKeNpc:getCurState(actor)
    local state = 0
    local merge_count = getsysvar(VarEngine.HeFuCount)
    local dateInfo = os.date("*t")
    local dayOfWeek = dateInfo.wday
    local hour = dateInfo.hour
    local min = dateInfo.min
    local sec = dateInfo.sec
    if merge_count == 0 then
        state = 0
    else
        if dayOfWeek == 4 or dayOfWeek == 7 or merge_count == 1 then            -- 周三丶周六 首次合区
            if hour >= 20 and hour < 21 then
                state = 1
            end
            if hour >= 21 and (min >= 0 or sec >= 0) then
                state = 2
            end
        end
    end

    local merge_num = getsysvar(VarEngine.HeFuCount)
    if merge_num <= 0 then
        state = 0
    end
    if castleinfo(5) then
        state = 1
    end
    return state
end

return ShaBaKeNpc