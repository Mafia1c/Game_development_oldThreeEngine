-- 一些在角色登录时需要初始化的个人定时器在这里添加
PlayerTimer = {}
PlayerTimer.recycle_timer_id = 888          -- 回收
PlayerTimer.red_point_timer_id = 900    
PlayerTimer.check_other_timer_id = 901    --其他检查
function PlayerTimer.initPlayerTimer(actor)
    -- VarApi.setPlayerUIntVar(actor,"U_check_lhjd_tip",0)
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.recycle_timer_id, 3, 0, 0)                -- 回收
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.red_point_timer_id, 1, 0, 0)                    
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.check_other_timer_id, 2, 0, 1)                             
end

-- 玩家对象   定时器ID   执行间隔(秒)   执行次数    跨服是否继续执行
function PlayerTimer.addPlayerTimer(actor, timer_id, interval, time, kf)
    setontimer(actor, timer_id, interval, time, kf)
end

-- 回收
function ontimer888(actor)
    local _str = VarApi.getPlayerTStrVar(actor, "T_recycle_state")
    local tmp_tab = json2tbl(_str)
    if type(tmp_tab) ~= "table" then
        tmp_tab = {}
    end
    local auto_recycle = tmp_tab[1]
    local auto_use_exp = tmp_tab[2]
    local auto_use_yb = tmp_tab[3]
    local count = getbagblank(actor)
    if auto_recycle == "1" and count < 20 then
        local npc_class = IncludeNpcClass("RecycleNpc")
        if npc_class and npc_class.onRecycleItem then
            npc_class:onRecycleItem(actor)
        end
    end
    if auto_use_yb == "1" then
        local yb_names = {"5元宝","10元宝","20元宝","50元宝","100元宝","200元宝","500元宝","1000元宝","5000元宝","10000元宝","50000元宝","10万元宝","50万元宝","100万元宝"}
        for k, name in pairs(yb_names) do
            local num = getbagitemcount(actor, name)
            if num > 0 then
                eatitem(actor, name, num)
            end
        end
    end
    if auto_use_exp == "1" then
        local exp_names = {"1万经验","10万经验","百万经验","千万经验","一亿经验"}
        for k, name in pairs(exp_names) do
            local num = getbagitemcount(actor, name)
            if num > 0 then
                eatitem(actor, name, num)
            end
        end
    end
    
end

--红点数据检查
function ontimer900(actor)
    RedPointMgr:CheckRedPointCfg(actor)
    if checkkuafu(actor) then
        return
    end
    -- 道士自动召唤
    if VarApi.getPlayerUIntVar(actor, "U_auto_call") ==  1 then
        local ncount = getbaseinfo(actor, 38)
        local level = getskillinfo(actor, 55, 2)
        -- 召唤月灵
        local yue_ling_num = 0
        if level then
            yue_ling_num = 1
            if level >= 5 then
                yue_ling_num = 2
            end
        end
        -- 白虎
        local bai_hu_num = 1
        if ncount == 0 or ncount < yue_ling_num + bai_hu_num then
            if yue_ling_num > 0 then
                releasemagic_target(actor, 55, 1, level, actor, 1)
            end
            releasemagic_target(actor, 30, 1, 1, actor, 1)
        end
    end     
end
function ontimer901(actor)
    --封号
    local money_num = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    local server_Id = globalinfo(11)
    if server_Id > 10000 then
        if money_num <= 68 and querymoney(actor,7) >= 100000 then
            local ip = getconst(actor,"<$IPADDR>")
            gmexecute("0","DenyIPLogon",ip,1)
            openhyperlink(actor,34)
        end
    end

    if not checkkuafu(actor) and not checkspritelevel(actor,"拾取小精灵") then
        createsprite(actor, "拾取小精灵")
        pickupitems(actor, 0, 6, 0.5)
    end
    local time_min = getplaydef(actor,VarEngine.OnLine_TimeStamp)
    setplaydef(actor,VarEngine.OnLine_TimeStamp,time_min+2) 
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count < 2 then
        return
    end
    --检查地图tip
    local currentTime = os.time()
    local timeTable = os.date("*t", currentTime)
    -- 判断是否为偶数整点
    if timeTable.hour % 2 == 0 then
        if timeTable.min < 10 then
            if VarApi.getPlayerUIntVar(actor,"U_check_lhjd_tip") < 1  then
                VarApi.setPlayerUIntVar(actor,"U_check_lhjd_tip",1)
                lualib:ShowNpcUi(actor,"GoToMapTipObj",329)
            end
        else
            VarApi.setPlayerUIntVar(actor,"U_check_lhjd_tip",0)
        end
    end
    if timeTable.hour == 19 then
        if timeTable.min < 20 then
            if  VarApi.getPlayerUIntVar(actor,"U_check_wljt_tip") < 1  then
                VarApi.setPlayerUIntVar(actor,"U_check_wljt_tip",1)
                lualib:ShowNpcUi(actor,"GoToMapTipObj",328)
            end
        else
            VarApi.setPlayerUIntVar(actor,"U_check_wljt_tip",0)
        end
    end
end