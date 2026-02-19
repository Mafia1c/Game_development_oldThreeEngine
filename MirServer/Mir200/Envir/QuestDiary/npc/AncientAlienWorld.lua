local AncientAlienWorld = {}
AncientAlienWorld.cfg = include("QuestDiary/config/AncientAlienWorldCfg.lua")
function AncientAlienWorld:upEvent(actor)
    -- local currentWeek = AncientAlienWorld:GetCurrentWeekKey()
    -- local lastWeek = VarApi.getPlayerTStrVar(actor, "T_ygyj_cur_week")
    -- if currentWeek ~= lastWeek then
    --     VarApi.setPlayerTStrVar(actor, "T_ygyj_cur_week",currentWeek)
    -- end
end
function AncientAlienWorld:OpenCellInfoView(actor,index)
    local currentWeek = AncientAlienWorld:GetCurrentWeekKey()
    local lastWeek = VarApi.getPlayerTStrVar(actor, "T_ygyj_cur_week")
    if currentWeek ~= lastWeek then
        VarApi.setPlayerTStrVar(actor, "T_ygyj_cur_week",currentWeek)
        VarApi.setPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..index,0)
    end
    local total_num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_defeat_num"..index)
    local week_num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..index)
    lualib:ShowNpcUi(actor,"AncientAlienWorldTwoTip",index .. "#" .. total_num.."#"..week_num)
end
function AncientAlienWorld:GetCurrentWeekKey()
    local now = os.time()
    local year = os.date("%Y", now)
    local week = os.date("%V", now)  
    return year.."-W"..week
end
function AncientAlienWorld:GetWeekAward(actor,index)
    local cfg = AncientAlienWorld.cfg[tonumber(index)] 
    local week_num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..index)
    if week_num < cfg.week_pass_num then
        return  Sendmsg9(actor, "ffffff", string.format("每周通关【%s】次数不足！",cfg.Name) , 1)
    end

    if week_num > cfg.week_pass_num then
        return  Sendmsg9(actor, "ffffff", string.format("本周通关【%s】奖励已领取！",cfg.Name) , 1)
    end

    if giveitem(actor,cfg.award_item,cfg.award_item_num,0,"远古异界") then
        VarApi.setPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..index,cfg.week_pass_num+1)
    end
    local total_num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_defeat_num"..index)
    local num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..index)
    lualib:FlushNpcUi(actor,"AncientAlienWorldTwoTip",index .. "#" .. total_num.."#"..num)
end
function AncientAlienWorld:GetTotalAward(actor,index)
    local cfg = AncientAlienWorld.cfg[tonumber(index)] 
    local total_num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_defeat_num"..index)
    if total_num < cfg.total_pass_num then
        return  Sendmsg9(actor, "ffffff", string.format("累计通关【%s】次数不足！",cfg.Name) , 1)
    end

    if total_num > cfg.total_pass_num then
        return  Sendmsg9(actor, "ffffff", string.format("累计通关【%s】奖励已领取！",cfg.Name) , 1)
    end

    if confertitle(actor,cfg.award_title) then
        VarApi.setPlayerUIntVar(actor, "T_ygyj_defeat_num"..index,cfg.total_pass_num + 1)
    end

    local num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_defeat_num"..index)
    local week_num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..index)
    lualib:FlushNpcUi(actor,"AncientAlienWorldTwoTip","flush_info#".. index .. "#" .. num.."#"..week_num)
end
--进入地图
function AncientAlienWorld:EneterMap(actor,index)
    local cfg = AncientAlienWorld.cfg[tonumber(index)] 
    if getbagitemcount(actor, cfg.need_item) < cfg.need_num then
       return  Sendmsg9(actor, "ffffff",string.format("进入该团本需要：%sx%s",cfg.need_item,cfg.need_num), 1)
    end

    -- if getgroupmember(actor)==nil or  #getgroupmember(actor) < 3 then
    --    return  Sendmsg9(actor, "ffffff", "进入该团本需要：3人以上队伍，请先进行组队！" , 1)
    -- end
  
    -- local team_list =  getgroupmember(actor)
    -- if team_list[1] ~= actor  then
    --     return Sendmsg9(actor, "ffffff","您不是队长！" , 1)
    -- end
    local user_id = getbaseinfo(actor,2)
    local old_map = "dt091"
    local new_map = "dt091"..index.."|"..user_id
    delmirrormap(new_map)
    local result = addmirrormap(old_map,new_map,cfg.Name,120,3, 1, 333, 333)
    if result then
        if not takeitemex(actor,cfg.need_item,cfg.need_num) then
            return Sendmsg9(actor, "ffffff", cfg.need_item.."扣除失败" , 1)
        end
        genmon(new_map, cfg.pos_x, cfg.pos_y, cfg.boss_name, 1, 1)
        mapmove(actor,new_map,cfg.pos_x, cfg.pos_y,20)
        -- groupmapmove(actor,new_map,cfg.pos_x, cfg.pos_y,81,20)
    else
        return Sendmsg9(actor,"ff0000","副本创建失败！",1)
    end
    lualib:CloseNpcUi(actor,"AncientAlienWorldTwoTip")
    lualib:CloseNpcUi(actor,"AncientAlienWorldOBJ")
end

function AncientAlienWorld:SetKillBossCount(actor,bossName)
    for i,v in ipairs(AncientAlienWorld.cfg) do
        if v.boss_name == bossName then
            local num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_defeat_num"..v.key_name)
            local week_num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..v.key_name)
            local currentWeek = AncientAlienWorld:GetCurrentWeekKey()
            local lastWeek = VarApi.getPlayerTStrVar(actor, "T_ygyj_cur_week")
            if currentWeek ~= lastWeek then
                VarApi.setPlayerTStrVar(actor, "T_ygyj_cur_week",currentWeek)
                VarApi.setPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..v.key_name,0)
            end
            if  num < v.total_pass_num then
                VarApi.setPlayerUIntVar(actor, "T_ygyj_defeat_num"..v.key_name,num + 1)
            end
            if week_num < v.week_pass_num then
                VarApi.setPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..v.key_name,week_num + 1)
            end
        end
    end
end

-- local function groupKillmonCallBack(actor,bossName)
--     AncientAlienWorld:SetKillBossCount(actor,bossName)
-- end

-- GameEvent.add("groupkillmon", groupKillmonCallBack, "AncientAlienWorld")
return AncientAlienWorld
