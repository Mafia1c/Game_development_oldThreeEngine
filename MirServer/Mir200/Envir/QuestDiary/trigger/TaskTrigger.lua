-- 任务系统
TaskTrigger = {}

-- 登录时接任务
function TaskTrigger.onLogin(actor, callback)
    setpickitemtobag(actor,104,7)
    local _step = VarApi.getPlayerUIntVar(actor, "U_navigation_task_step")
    -- release_print("TaskTrigger.onLogin: ".._step, globalinfo(8))
    if _step ~= 0 then
        give_role_data(actor)
    end

    if _step == 0 then
        newpicktask(actor, 100)
    elseif _step == 1 then
        newpicktask(actor, 101)
        navigation(actor, 102, "_benefit", "点击领取")
    elseif _step == 2 then
        newpicktask(actor, 102)
        navigation(actor, 110, 102, "点击查看任务")
    elseif _step == 3 then
        newpicktask(actor, 103)
        navigation(actor, 110, 103, "点击查看任务")
    elseif _step == 4 then
        newpicktask(actor, 104)
        newchangetask(actor, 104, VarApi.getPlayerUIntVar(actor, "U_kill_any_mon_cont"))
        navigation(actor, 110, 104, "点击查看任务")
    elseif _step == 5 then
        newpicktask(actor, 105)
    elseif _step == 6 then
        newpicktask(actor, 106)
    elseif _step == 7 then
        newpicktask(actor, 107)
    elseif _step < 10 then
        newpicktask(actor, 108)
        newpicktask(actor, 109)
    end
    if callback then
        callback()
    end
end

-- 任意地图杀死怪物触发
function TaskTrigger.onKillAnyMon(actor, monObj)
    local count = VarApi.getPlayerUIntVar(actor, "U_kill_any_mon_cont") + 1
    VarApi.setPlayerUIntVar(actor, "U_kill_any_mon_cont", count)
    if VarApi.getPlayerUIntVar(actor, "U_navigation_task_step") == 4 then
        local kill_count = VarApi.getPlayerUIntVar(actor, "U_kill_any_mon_cont")
        newchangetask(actor, 104, kill_count)
        if count >= 10 then
            navigation(actor, 110, 104, "点击完成任务")
        end
    end
end

-- 接取任务触发
function TaskTrigger.onPickTask(actor, task_id)
end

-- 点击任务触发
function TaskTrigger.onClickTask(actor, task_id)
    local _step = VarApi.getPlayerUIntVar(actor, "U_navigation_task_step")
    if task_id == 101 and _step == 1 then
        navigation(actor, 102, "_benefit", "点击领取")
    end
    if task_id == 102 and _step == 2 then
        lualib:ShowNpcUi(actor, "GameStrategyOBJ", "")
        newcompletetask(actor, 102)
        newpicktask(actor, 103)
        navigation(actor, 110, 103, "点击查看任务")
        VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 3, true)
    end
    if task_id == 103 and _step == 3 then
        openhyperlink(actor, 1, 0)
        navigation(actor, 202, "Xm_Button", "点击查看血脉")
    end
    if task_id == 104 and _step == 4 then
        local kill_count = VarApi.getPlayerUIntVar(actor, "U_kill_any_mon_cont")
        if kill_count >= 10 then
            newcompletetask(actor, 104)
            newpicktask(actor, 105)
            navigation(actor, 110, 105, "点击查看任务")
            VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 5, true)
        else
            newchangetask(actor, 104, kill_count)
            opennpcshowex(actor, 2, 1, 1)
        end
    end
    if task_id == 105 and _step == 5 then
        opennpcshowex(actor, 101, 1, 1)
        lualib:ShowNpcUi(actor, "fourCellOBJ", "1")
    end
    if task_id == 106 and _step == 6 then
        local npc_class = IncludeNpcClass("WuXingZhiLi")
        if npc_class then
            npc_class:click(actor)
        end
    end
    if task_id == 107 and _step == 7 then
        local npc_class = IncludeNpcClass("baoLvShenFuNpc")
        if npc_class then
            npc_class:click(actor)
        end
    end
    if task_id == 108 then
        lualib:ShowNpcUi(actor, "awakeRoadOBJ", "")
    end
    if task_id == 109 then
        lualib:ShowNpcUi(actor, "bossAwardOBJ", "")
    end
end

-- 刷新任务触发
function TaskTrigger.onChangeTask(actor, task_id)
end

-- 完成任务触发
function TaskTrigger.onCompleteTask(actor, task_id)
    newdeletetask(actor, task_id)
    local _step = VarApi.getPlayerUIntVar(actor, "U_navigation_task_step")
    if task_id == 101 and _step == 1 then
        newpicktask(actor, 102)
        navigation(actor, 110, 102, "点击查看任务")
        VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 2, true)
    end
    if task_id == 102 then
        changemoney(actor, 4, "+", 10000, "完成102任务活得!")
    end
    if task_id == 103 and _step == 3 then
        changemoney(actor, 4, "+", 10000, "完成102任务活得!")
        newpicktask(actor, 104)
        navigation(actor, 110, 104, "点击去完成")
        VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 4, true)
    end
    if task_id == 104 then
        giveitem(actor, "一星魔血石", 1)
        giveitem(actor, "五彩石", 1)
    end    
    if task_id == 105 and _step == 5 then
        newpicktask(actor, 106)
        navigation(actor, 110, 106, "点击去完成")
        VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 6, true)
    end
    if task_id == 106 and _step == 6 then
        newpicktask(actor, 107)
        navigation(actor, 110, 107, "点击去完成")
        VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 7, true)
    end
    if task_id == 107 and _step == 7 then
        newpicktask(actor, 108)
        navigation(actor, 110, 108, "点击去完成")
        newpicktask(actor, 109)
        VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 8, true)
    end
    if task_id == 108 and _step == 8 then
        VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 9, true)
    end
    if task_id == 109 and _step == 9 then
        VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 10, true)
    end
end

-- 删除任务触发
function TaskTrigger.onDeleteTask(actor, task_id)
end

-- 登录就送
function TaskTrigger.onLoginGmGive(actor)
    newcompletetask(actor, 100)
    setsndaitembox(actor, 1)
    changelevel(actor, "=", 40)         --  调整人物等级   
    give_role_data(actor)
    giveitem(actor, "盟重传送石", 1, 0, "首次登陆送盟重传送石")
    giveitem(actor, "随机传送石", 1, 0, "首次登陆送随机传送石")
    giveitem(actor, "万年雪霜", 100, 0, "首次登陆送万年雪霜")
    local tab = {
        [1] = "1",
        [2] = "1",
        [3] = "1"
    }
    VarApi.setPlayerTStrVar(actor, "T_recycle_state", tbl2json(tab))
    VarApi.setPlayerUIntVar(actor, "U_navigation_task_step", 1, true)
    newpicktask(actor, 101)
    navigation(actor, 110, 101, "点击查看任务")

    local value = getconst(actor, "<$PLAYERPOWER>")
    VarApi.setPlayerUIntVar(actor, "战斗力", math.ceil(value / 100))
end

function give_role_data(actor)
    setautogetexp(actor, 1, 1000, 0, "*", 0, 2100000, 50)                                   -- 泡点经验
    createsprite(actor, "拾取小精灵")
    pickupitems(actor, 0, 6, 0.5)

    -- setgmlevel(actor, 10)               --　设置最高ｇｍ权限
end
