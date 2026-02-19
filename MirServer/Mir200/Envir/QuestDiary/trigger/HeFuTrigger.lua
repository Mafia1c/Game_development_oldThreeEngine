HeFuTrigger = {}
local clearKeyList = { --#region 合服需要清理的个人变量(祥瑞宝藏今日开启次数，累计开启次数，今日积分，累计积分，累计捐献数量)
    "JL_treasureOpen","UL_treasureOpenAll","JL_treasureTodayPoint","UL_treasureAllPoint","l_donate"
}

--#region 服务器启动触发
function HeFuTrigger.updateInfo()
    local hf_count = tonumber(getconst("0", "<$HFCOUNT>"))
    if hf_count ~= getsysvar(VarEngine.HeFuCount) then --#region 当前为合服后服务器首次启动 
        setsysvar(VarEngine.HeFuCount, hf_count) --#region 设置合服次数
        setsysvar(VarEngine.donate, "") --#region 清除捐献表
        if hf_count >1 then
            setsysvar(VarEngine.luckTreasure, "") --#region 清除祥瑞宝藏积分表
        end
        -- for index, value in ipairs(clearKeyList) do
        --     clearhumcustvar("*", value)                       -- 合服需要清理的个人变量
        -- end
    end
end

--#region 玩家登录触发

function HeFuTrigger.userLogin(actor)
    local bool = tonumber(getconst("0", "<$HFDAYS>")) --#region 合服第一天(第二天变为0)
    local time = getsysvar(VarEngine.HeFuCount) --#region 合服次数
    if bool > 0 and VarApi.getPlayerUIntVar(actor,"UL_hfBool"..time) == 0 then --#region 合服后玩家第一次登录
        VarApi.setPlayerUIntVar(actor,"UL_hfBool"..time,1,false) --#region 合服标记

        if time > 1 then
            VarApi.setPlayerJIntVar(actor,"JL_treasureOpen",0,true) --#region 今日开启次数(祥瑞宝藏)
            VarApi.setPlayerUIntVar(actor,"UL_treasureOpenAll",0,true) --#region 累计开启次数(祥瑞宝藏)
            VarApi.setPlayerJIntVar(actor,"JL_treasureTodayPoint",0,true) --#region 今日积分(祥瑞宝藏)
            VarApi.setPlayerUIntVar(actor,"UL_treasureAllPoint",0,true) --#region 累计积分(祥瑞宝藏)            
        end
        VarApi.setPlayerUIntVar(actor,"l_donate",0,true) --#region 累计捐献数量(捐献)
        VarApi.setPlayerUIntVar(actor,"U_wolong_open_count",0)
        local account_id = getconst(actor, "<$USERACCOUNT>")
        deliniitem('QuestDiary/zhuanqu.ini', "zq", account_id)
        local mainServiceId = getconst(actor, "<$MAINTONGSERVER>")
        updatemaintongfile(mainServiceId, '..\\QuestDiary\\zhuanqu.ini', '..\\QuestDiary\\zhuanqu.ini')
        if VarApi.getPlayerTStrVar(actor,"zhuanqu_data") then
            local zq_data = {}
            zq_data.can_get_all_num = 0
            zq_data.already_get_num =  0
            zq_data.zhuanqu_id = globalinfo(11)
            VarApi.setPlayerTStrVar(actor,"zhuanqu_data",tbl2json(zq_data))
        end
    end
end

-- gm后台手动修改合服次数   合服次数变化 非常规流程
function HeFuTrigger.CleanSysVar()
    setsysvar(VarEngine.luckTreasure, "") --#region 清除祥瑞宝藏积分表
    setsysvar(VarEngine.donate, "") --#region 清除捐献表
    for index, value in ipairs(clearKeyList) do
        clearhumcustvar("*", value)
    end
    local player_list = getplayerlst(0)
    for i, player in ipairs(player_list or {}) do
        for index, var in ipairs(clearKeyList) do
            if string.find(var, "U") == 1 or string.find(var, "l") == 1 then
                VarApi.setPlayerUIntVar(player, var, 0, true)
            else
                VarApi.setPlayerJIntVar(player, var, 0, true)
            end
        end
        lualib:CallFuncByClient(player, "HeFuCount", getsysvar(VarEngine.HeFuCount))
    end
end