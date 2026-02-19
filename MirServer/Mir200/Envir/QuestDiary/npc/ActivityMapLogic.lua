ActivityMapLogic = {}
ActivityMapLogic.cfg = include("QuestDiary/config/ActivityCfg.lua")
ActivityMapLogic.jqdb_boss_drop_cd = 0
local activity_list = {
    "天降财宝",
    "福威镖局",
    "财富广场",
    "行会争霸",
    "天下第一",
    "激情夺宝",
    "乱斗之王",
    "狂暴争霸",
    "普通押镖",
}
local mail_desc = "您的活动奖励已经发放，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时删除邮件！"
local tjcb_drop_list = {
    ["100元宝"] = 50,
    ["10金刚石"] = 50,
    ["10灵符"] = 50,
    ["百万经验"] = 2,
    ["上品聚灵珠"] = 2,
    ["聚灵珠"] = 5,
}
local jqdb_drop_list = {
    ["100元宝"] = 40,
    ["10金刚石"] = 10,
    ["10灵符"] = 10,
    ["10万经验"] = 10,
    ["百万经验"] = 3,
}

-- 点击进入全服某个活动
---@param actor string 玩家对象
---@param index any  要进入的活动标签
function ActivityMapLogic:onEnterGameActivity(actor, index)
    index = tonumber(index)
    local state = ActivityMapLogic:GetActiveIsOpen(index)
    if index == 1 then              --1.天降财宝
    elseif index == 2 then          --2.押镖之路    
    elseif index == 3 then          --3.财富广场
    elseif index == 4 then          --4.行会争霸
        if "0" == getmyguild(actor) then
            state = 3
        end
    elseif index == 5 then          --5.天下第一
        local level = getbaseinfo(actor, 6)
        if level < 45 then
            state = 4
        end
    elseif index == 6 then          --6.激情夺宝
    elseif index == 7 then          --7.乱斗之王
        if VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL) < 1 then
            return  Sendmsg9(actor,"ffffff","未开启狂暴", 1)
        end
    elseif index == 8 then          --8.狂暴争霸
    end
    -- 未开启
    if state == 0 then
        Sendmsg9(actor,"ffffff","活动未开始, 请留意活动时间!", 1)
    end
    -- 进行中
    if state == 1 then
        -- 传送到对于地图
        local map_info = {
            {"hd_tjcb"},
            {"hd_sbyb"},
            {"hd_cfgc"},
            {"hd_hhzb"},
            {"txzl", 49, 80, 0},
            {"hd_jqdb"},
            {"hd_ldzw"},
            {"hd_kbzb"}
        }
        local _map = map_info[index]
        if #_map > 1 then
            mapmove(actor, _map[1], _map[2], _map[3], _map[4])
        else
            map(actor, _map[1])
        end
        lualib:CloseNpcUi(actor,"GameActivityOBJ")
    end
    -- 已经结束
    if state == 2 then
        Sendmsg9(actor,"ffffff","活动未开始或已结束, 请留意活动时间!", 1)
    end
    if state == 3 then
        Sendmsg9(actor,"ffffff","您未加入行会!", 1)
    end
    if state == 4 then
        Sendmsg9(actor,"ffffff","等级不足45级!", 1)
    end
end


function ActivityMapLogic:activeStart(cfg)
    if cfg.is_release and cfg.is_release == 1 then
        delscheduled(cfg.key_name .. "_start")
    end
    ActivityMapLogic.openActivityMap(cfg.map_id)
end

function ActivityMapLogic:activeStop(cfg)
    if cfg.is_release and cfg.is_release == 1 then
        delscheduled(cfg.key_name .. "_stop")
    end
    ActivityMapLogic.closeActivityMap(cfg.map_id)

end
--活动是否开启
function ActivityMapLogic:GetActiveIsOpen(index)
    local name =  activity_list[index]
    local activity_state_map = json2tbl(getsysvar(VarEngine.ActivityState)) 
    if activity_state_map == "" then
        activity_state_map = {}
    end
    local run_time = math.floor(getsysvar(VarEngine.RunTime)/60)  
    for i = 1, 2 do
        for k, v in pairs(ActivityMapLogic.cfg[i]) do
            if v.activeName == name and activity_state_map[k] and tonumber(activity_state_map[k]) == 1 then
                return 1
            end
        end 
    end
    for i = 1, 2 do
        for k, v in pairs(ActivityMapLogic.cfg[i]) do
            if v.activeName == name  then
                if v.runType ~= "MIN" then
                    return 0
                elseif v.runType == "MIN" and run_time < v.starttime then
                    return 0
                end
            end
        end 
    end
    return 2
end
function ActivityMapLogic.openActivityMap(map_id)
    if map_id == "hd_tjcb" then
        local cur_time = os.time()
        local run_time = getsysvar(VarEngine.RunTime)
        if run_time >= (10*60) and run_time <= (10 + 10)*60  then
            setsysvar(VarEngine.TjcbStartTime,10 * 60 ) 
        elseif run_time >= 45*60 and run_time <= (45 + 10) * 60  then
            setsysvar(VarEngine.TjcbStartTime,45 * 60 ) 
        else
            setsysvar(VarEngine.TjcbStartTime,run_time) 
        end 
    elseif map_id == "hd_hhzb" then
        local count = getmoncount(map_id,-1,true)
        if count < 1 then
            genmon(map_id,19,21,"宗师神龙",1,1)
        end
    elseif map_id == "hd_cfgc" then
        genmon(map_id,38,39,"金鸡",30,99)
        genmon(map_id,38,39,"鸡王",30,1)
    elseif map_id == "hd_jqdb" then
        local count = getmoncount(map_id,-1,true)
        if count < 1 then
            genmon(map_id,25,27,"撒旦魔王",1,1)
        end
    elseif map_id == "hd_kbzb" then
        local count = getmoncount(map_id,-1,true)
        if count < 1 then
            genmon(map_id,26,26,"狂暴神龙",1,1)
        end
    elseif map_id == "txzl" then                -- 天下第一
        local npc_class = IncludeNpcClass("WorldNo1ExtendNpc")
        if npc_class then
            npc_class:UpdateWoldRankList()
        end
    elseif map_id == "hd_ldzw" then
        local cur_time = os.time()
        local run_time =  getsysvar(VarEngine.RunTime)
        local open_day =  getsysvar(VarEngine.OpenDay)
        if open_day > 0 then
            if cur_time >= gettimestamp(23, 0, 0)  then
                setsysvar(VarEngine.LdzwEndTime,gettimestamp(23, 15, 0) - os.time()) 
            elseif cur_time >= gettimestamp(17, 0, 0) then
                setsysvar(VarEngine.LdzwEndTime,gettimestamp(17, 15, 0)-os.time()) 
            end
        else
            setsysvar(VarEngine.LdzwEndTime,15300 - run_time)
        end
    end

    if not hasenvirtimer(map_id, 54322) then
        setenvirontimer(map_id, 54322, 1, "@_active_map_jumpname,"..map_id)
    end
end
function ActivityMapLogic.returnMainCity(map_id)
    local player_list = getplayerlst(1)
    for k, actor in pairs(player_list) do
        if getbaseinfo(actor,3) == map_id then
            movemapplay(actor,map_id,"3",333,333,5)
        end
    end
end
function ActivityMapLogic.closeActivityMap(map_id)
    if map_id == "hd_hhzb" then
        if getmoncount(map_id,-1,true) > 0 then
            ActivityMapLogic.returnMainCity(map_id)
        end
        killmonsters(map_id,"宗师神龙",0,false)
    elseif map_id == "hd_tjcb" then
        setsysvar(VarEngine.TjcbStartTime,0)
        setsysvar(VarEngine.TjcbActivity,0) 
        clearitemmap("hd_tjcb",24,25,30,"*")
    elseif map_id == "hd_cfgc" then
        killmonsters(map_id,"*",0,false)
    elseif map_id == "hd_jqdb" then
        if getplaycount("hd_jqdb",0,1) == "0" then
            killmonsters(map_id,"*",0,false)
        end
    elseif map_id == "hd_ldzw" then
        local player_list = getplayerlst(0)
        for i, player in ipairs(player_list or {}) do
            if getbaseinfo(player,3) == "hd_ldzw" then
                local survival = querymoney(player,22)
                local in_rank,rank = ActivityMapLogic.getLdzwInRankByRoleName(getbaseinfo(player,1))
                if survival >= 500 then
                    if in_rank then
                        local award = "绑定元宝#88888&五彩石#58&书页#58"
                        sendmail(getbaseinfo(player,2),1,"乱斗之王", string.format("恭喜你在乱斗之王胜出,获得：第%s名！",rank)..mail_desc,award)
                    else
                        local award = "绑定元宝#22222&五彩石#28&书页#28"
                        sendmail(getbaseinfo(player,2),1,"乱斗之王", "恭喜你参与乱斗之王"..mail_desc,award)
                    end
                end
                if in_rank and rank <= 3 and survival >= 1000 then
                    confertitle(player,"乱斗之王")
                end
            end
        end
        for i, player in ipairs(player_list or {}) do
            changemoney(player,22,"=",0,"乱斗之王结束清空",true)
        end
        setsysvar(VarEngine.LdzwEndTime,0)
        ActivityMapLogic.returnMainCity(map_id)
    end
    setenvirofftimer(map_id,54322)
end
--进入
function ActivityMapLogic.onMapChange(actor, map_id, x, y)
    local is_activity_map,map_name = ActivityMapLogic.IsActivityMap(map_id) 
    if is_activity_map then
     
        if map_id == "hd_tjcb" then
            if checkhumanstate(actor,7) == false then
                makeposion(actor,12,65535)
            end
            local wave_num,time_list = ActivityMapLogic.getCurTjcbBoCi()
            ActivityMapLogic.flushTjcbPanel(actor,wave_num,time_list)
            -- lualib:ShowNpcUi(actor,"ActivityTjcbOBJ",wave_num .."#" .. time1.."#"..time2.."#"..time3)
        elseif map_id == "txzl" then
            gotonow(actor,75,50)
        elseif map_id == "hd_ldzw" then
            local rank_list = ActivityMapLogic.getldzwRankList()
            local end_time = ActivityMapLogic.getLdzwEndTime()
            lualib:ShowNpcUi(actor,"ActivityLdzwOBJ",tbl2json(rank_list).."#"..end_time)
            -- if hastimer(actor,998877) == false then
            --     setontimer(actor, 998877, 10, 1,1)
            -- end
        end
        if ActivityMapLogic.cur_map_id ~= map_id then
            local player_name = getbaseinfo(actor,1)
            local str = string.format("【活动提示】:玩家【%s】进入了《%s》活动地图，奖励多多，惊喜不断",player_name,map_name) 
            local msg = string.format('{"Msg":"%s","FColor":255,"BColor":249,"Type":1}',str)
            sendmsg("0", 2,msg )
            ActivityMapLogic.cur_map_id = map_id
        end
        addbutton(actor, 102,99999, "<Button|a=0|x=-950|y=190|nimg=public/btn_fubenan_01.png|color=255|size=18|link=@call_quit_func>")
    end
    if map_id ~= "hd_tjcb" then
        detoxifcation(actor,6)
    end
end

function ActivityMapLogic.flushTjcbPanel(actor,wave,time_list)
    delbutton(actor, 110, "999999")
    local info = [[
        <Text|x=13.0|y=15.0|color=243|size=18|text=《天降财宝活动介绍》>
        <Text|x=20.0|y=45.0|color=250|size=18|text=每次活动持续十分钟>
        <Text|x=15.0|y=75|color=250|size=18|text=每次活动发放3波奖励>
        <Text|x=28.0|y=105|color=251|size=18|text=当前发放：第%s波>
        <Text|x=15.0|y=135|color=251|size=18|text=下拨倒计时：>
        <COUNTDOWN|x=150|a=4|y=145|time=%s|count=1|size=18|color=251|showWay=1|link=@tjcb_wave_time_end,%s,%s,%s,%s>
    ]]

    addbutton(actor, 110, "999999",  string.format(info,wave,tonumber(time_list[wave]),wave,unpack(time_list)))
end
function tjcb_wave_time_end(actor,index,time1,time2,time3)
    local list= {time1,time2,time3}
    if index+1 <= 3 then
        ActivityMapLogic.flushTjcbPanel(actor,index+1,list)
    end
end

--离开
function ActivityMapLogic.onLeaveMapChange(actor, map_id, x, y)
    if map_id == "hd_tjcb" then  --天降财宝
        -- setofftimer(actor,998889)
        -- lualib:CloseNpcUi(actor,"ActivityTjcbOBJ")
        delbutton(actor, 110, "999999")
    elseif map_id == "hd_jqdb" then  --激情夺宝
        if hastimer(actor,60000) then
            setofftimer(actor, 60000)
        end
        if hastimer(actor,60001) then
            setofftimer(actor, 60001)
        end
        if getbagitemcount(actor,"撒旦宝箱") > 0 then
            throwitem(actor,"hd_jqdb", x, y,5,"撒旦宝箱",1)
            takeitemex(actor,"撒旦宝箱",1,0)
            clearplayeffect(actor,20451)
            local player_list = getplaycount("hd_jqdb",0,1)
            local x = getbaseinfo(actor,4) 
            local y = getbaseinfo(actor,5) 
            local str = string.format("宝箱掉落在[%s:%s]",x,y) 
            if type(player_list) == "table" then
                for k, v in pairs(player_list) do
                    senddelaymsg(v,  str.."快去拾取！",5,168,1)
                end
            end 
        end
    elseif map_id == "hd_ldzw" then
        lualib:CloseNpcUi(actor,"ActivityLdzwOBJ")
    elseif not ActivityMapLogic.IsActivityMap(map_id)  then
        ActivityMapLogic.cur_map_id = nil
        detoxifcation(actor,6)
    end
    delbutton(actor,102,99999)
end 
function ActivityMapLogic.playdie(actor,killer)
    local map_id = getbaseinfo(actor,3)
    if map_id == "hd_ldzw" then
        changemoney(actor,22,"+",20,"死亡获得",true)
        changemoney(killer,22,"+",50,"击杀玩家获得",true)
        realive(actor)
        map(actor,"hd_ldzw")
        return true
    end
    return false
end
function call_quit_func(actor)
   showprogressbardlg(actor,3,"@succ_fun","正在退出中,进度%s%%",1,"@fail_fun")
end
function succ_fun(actor)
    mapmove(actor, 3, 333, 333, 0)      --　跳转到盟重省333，333
end
function fail_fun(actor)
    
end
-- function ontimer998889(actor)
--     local wave_num ,time = ActivityMapLogic.getCurTjcbBoCi()
--     lualib:FlushNpcUi(actor,"ActivityTjcbOBJ",wave_num .."#".. GetClockShow(time,true)) 
-- end
-- function ontimer998877(actor)
    -- local survival = querymoney(actor,22)
    -- local in_rank,rank = ActivityMapLogic.getLdzwInRankByRoleName(getbaseinfo(actor,1))
    -- if survival >= 500 then
    --     if in_rank then
    --         local award = "绑定元宝#88888&五彩石#58&书页#58"
    --         sendmail(getbaseinfo(actor,2),1,"乱斗之王", string.format("恭喜你在乱斗之王胜出,获得：第%s名！",rank)..mail_desc,award)
    --     else
    --         local award = "绑定元宝#22222&五彩石#28&书页#28"
    --         sendmail(getbaseinfo(actor,2),1,"乱斗之王", "恭喜你参与乱斗之王"..mail_desc,award)
    --     end
    -- end
    -- release_print(in_rank,rank,survival)
    -- if in_rank and rank <= 3 and survival >= 1000 then
    --     confertitle(actor,"乱斗之王")
    -- end
    -- changemoney(actor,22,"=",0,"乱斗之王结束清空",true)
-- end
function _active_map_jumpname(actor,map_id)
    if map_id == "hd_tjcb" then
        local cur_time = os.time()
        local run_time = getsysvar(VarEngine.RunTime)
        local start_time = getsysvar(VarEngine.TjcbStartTime) 
        if start_time  > 0 then
            local flush_time1,flush_time2 = start_time + 120,start_time + 240
            local wave_num = getsysvar(VarEngine.TjcbActivity)
            if run_time >= start_time and run_time < flush_time1 and wave_num ~= 1 then
                for k, v in pairs(tjcb_drop_list) do
                    throwitem(actor,map_id,24,25,20,k,v,60,false,false,false,false,false,false)
                end
                setsysvar(VarEngine.TjcbActivity,1)  
            elseif run_time >= flush_time1 and run_time < flush_time2 and wave_num ~= 2  then
                --发放第二波
                for k, v in pairs(tjcb_drop_list) do
                    throwitem(actor,map_id,24,25,20,k,v,60,false,false,false,false,false,false)
                end
                setsysvar(VarEngine.TjcbActivity,2)
                for i = 1, 3 do
                    sendmovemsg("0", 1, 250, 0, 60+(i - 1 )*30, 1, "【活动提示】:【天降财宝】，第二波天降财宝已经发放，海量道具免费获得!")
                end
            elseif run_time >= flush_time2 and wave_num ~= 3 then
                --发放第三波
                for k, v in pairs(tjcb_drop_list) do
                    throwitem(actor,map_id,24,25,20,k,v,60,false,false,false,false,false,false)
                end
                setsysvar(VarEngine.TjcbActivity,3)
                for i = 1, 3 do
                    sendmovemsg("0", 1, 250, 0, 60+(i - 1 )*30, 1, "【活动提示】:【天降财宝】，第三波天降财宝已经发放，海量道具免费获得!")
                end
            end
        end
    elseif map_id == "hd_jqdb" then
        ActivityMapLogic.jqdb_boss_drop_cd = ActivityMapLogic.jqdb_boss_drop_cd + 1
        if ActivityMapLogic.jqdb_boss_drop_cd > 180 and getmoncount(map_id,991,true) > 0 then
            for k, v in pairs(jqdb_drop_list) do
                throwitem(actor,map_id,25,27,10,k,v,10,false,false,false,false,false,false)
            end
            ActivityMapLogic.jqdb_boss_drop_cd = 0
        end
    elseif map_id == "hd_kbzb" then
        local count = getmoncount(map_id,-1,true)
        if count < 1 then
            ActivityMgr:SetSpecialActiveState("狂暴争霸1",false)
        end
    end
end
function ActivityMapLogic.IsActivityMap(map_id)
    for i = 1, 2 do
        for k,v in pairs(ActivityMapLogic.cfg[i]) do
            if v.map_id == map_id then
                return true,v.activeName
            end
        end
    end
    return false,""
end

--天降财宝波次
function ActivityMapLogic.getCurTjcbBoCi()
    local run_time = getsysvar(VarEngine.RunTime)
    local start_time =  getsysvar(VarEngine.TjcbStartTime) 
    local flush_time1,flush_time2 = start_time + 120,start_time + 240
    if start_time > 0 then
        local tab = {flush_time1 - run_time,flush_time2 - run_time,start_time + 600 - run_time}
        if run_time > flush_time2 then
            return 3 ,{0,0,start_time + 600 - run_time}
        elseif run_time >= flush_time1 then
            return 2 ,{0,flush_time2 - run_time,300}
        elseif  run_time >= start_time then
            return 1,{flush_time1 - run_time,120,300}
        end
    end
    return 3,{0,0,0}
end

function ActivityMapLogic.getLdzwEndTime()
    local cur_time = os.time()
    local run_time =  getsysvar(VarEngine.RunTime)
    local open_day =  getsysvar(VarEngine.OpenDay)
    if open_day > 0 then
        if cur_time >= gettimestamp(23, 0, 0)  then
            setsysvar(VarEngine.LdzwEndTime,gettimestamp(23, 15, 0) - os.time()) 
        elseif cur_time >= gettimestamp(17, 0, 0) then
            setsysvar(VarEngine.LdzwEndTime,gettimestamp(17, 15, 0)-os.time()) 
        end
    else
        setsysvar(VarEngine.LdzwEndTime,15300 - run_time)
    end
    return  getsysvar(VarEngine.LdzwEndTime)
end
function ActivityMapLogic.getLdzwInRankByRoleName(role_name)
    local rank_list = ActivityMapLogic.getldzwRankList()
    for i,v in ipairs(rank_list) do
        if v.name == role_name then
           return true ,i
        end
    end
    return false,0
end
function ActivityMapLogic.getldzwRankList()
    local player_list = getplaycount("hd_ldzw",0,1)
    local rank_list = {}
    if type(player_list) == "table" then
        for k, v in pairs(player_list) do
            if v and isnotnull(v) then
                table.insert(rank_list,{["name"] = getbaseinfo(v,1),["value"] =  querymoney(v,22)}) 
            end
        end
    end 
    table.sort(rank_list,function(a,b)
        return a.value > b.value
    end)
    return rank_list
end
function ActivityMapLogic.flushLdzwView(actor)
    local rank_list = ActivityMapLogic.getldzwRankList()
    lualib:FlushNpcUi(actor,"ActivityLdzwOBJ",tbl2json(rank_list))
end
return ActivityMapLogic