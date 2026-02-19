CastleWarTrigger = {}
CastleWarTrigger.winner_reward = 0
CastleWarTrigger.loser_reward = 0

-- 攻城开始触发
function CastleWarTrigger.CastleWarStart(sysobj)

    CastleWarTrigger.winner_reward = 0
    CastleWarTrigger.loser_reward = 0
    setontimerex(99527, 1)
    setontimerex(99528, 1)

end
function CastleWarTrigger.CastleWarEnd(sysobj)
    setofftimerex(99527)
    setofftimerex(99528)
    setontimerex(99529, 180)
   
    local player_list = getplayerlst(1)
    local winner_num = 0
    local loser_num = 0
    for k, v in pairs(player_list) do
        local guild_name = getbaseinfo(v, 36)
        if guild_name ~= "" then
            if castleidentity(v) > 0 then
                winner_num = winner_num + 1
            else
                local point = VarApi.getPlayerJIntVar(v, "J_castlewar_point")
                if point >= 1200 then
                    loser_num = loser_num + 1
                end
            end
        end
    end
    if winner_num == 0 then
        winner_num = 1
    end
    if loser_num == 0 then
        loser_num = 1
    end
    CastleWarTrigger.winner_reward = math.floor(5000 / winner_num)
    CastleWarTrigger.loser_reward = math.floor(5000 / loser_num)
    -- end
    setsysvar(VarEngine.CastEndTime, os.time())
end

function ontimerex99527()
    local player_list = getplayerlst(1)
    for k, actor in pairs(player_list) do
        local is_fight = getbaseinfo(actor, 60)
        local guild_name = getbaseinfo(actor, 36)
        local map_id = getbaseinfo(actor, 3)
        if is_fight and guild_name ~= "" and map_id == "3" then
            VarApi.setPlayerJIntVar(actor, "J_castlewar_point", VarApi.getPlayerJIntVar(actor, "J_castlewar_point") + 1)
            local str = string.format('{"Msg":"沙城区域, 每秒活跃值+1, 当前活跃值: %s","FColor":219,"BColor":255,"Type":1}', VarApi.getPlayerJIntVar(actor, "J_castlewar_point"))
            sendmsg(actor, 1, str)
        end
    end
end

function ontimerex99528()
    local player_list = getplayerlst(1)
    for k, actor in pairs(player_list) do
        local is_fight = getbaseinfo(actor, 60)
        local guild_name = getbaseinfo(actor, 36)
        local map_id = getbaseinfo(actor, 3)
        if is_fight and guild_name ~= "" and map_id == "0150" then
            VarApi.setPlayerJIntVar(actor, "J_castlewar_point", VarApi.getPlayerJIntVar(actor, "J_castlewar_point") + 2)
            local str = string.format('{"Msg":"沙城皇宫, 每秒活跃值+2, 当前活跃值: %s","FColor":219,"BColor":255,"Type":1}', VarApi.getPlayerJIntVar(actor, "J_castlewar_point"))
            sendmsg(actor, 1, str)
        end
    end
end

function ontimerex99529()
    setofftimerex(99529)
    local player_list = getplayerlst(1)
    for k, actor in pairs(player_list) do
        VarApi.setPlayerJIntVar(actor, "J_castlewar_reward", 1)
    end
end