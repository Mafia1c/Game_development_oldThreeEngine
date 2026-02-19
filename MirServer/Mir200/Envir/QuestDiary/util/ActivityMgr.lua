ActivityMgr = {}
ActivityMgr.cfg = include("QuestDiary/config/ActivityCfg.lua")
local function addActiveTrigger(key, runType, time,  name,  tag)
    if hasscheduled(key) then
        delscheduled(key)
    end
    local call_back = "@_active_scheduled_callback,".. name .. ","..tag
    addscheduled(key, runType, time, call_back);
end
function ActivityMgr.initActive()
    if nil == ActivityMgr.cfg then
        return
    end
    local activity_state_map = json2tbl(getsysvar(VarEngine.ActivityState)) 
    if activity_state_map == "" then
        activity_state_map = {}
    end

    for k, v in pairs(ActivityMgr.cfg[2]) do
        if k ~= "狂暴争霸1" then
            addActiveTrigger(v.key_name .. "_start", v.runType,  tostring(v.starttime), k,  "start")
            addActiveTrigger(v.key_name .. "_stop", v.runType, tostring(v.stoptime) , k,  "stop")
            ActivityMgr:OpenServerRunDaySetActivity(v,activity_state_map)
        end
    end
    ActivityMgr.initRunMinActive()
end
function ActivityMgr.initRunMinActive()
    ActivityMgr.FlushRunMinActivityState()
end
--服务器启动时检查一下活动是否需要打开或者关闭
function ActivityMgr:OpenServerRunDaySetActivity(data,activity_state_map)
    local open_day = getsysvar(VarEngine.OpenDay)
    if data.openDay and  open_day < data.openDay   then
        ActivityMgr:CompelActivityState(data.key_name,false)
    else
        if data and data.openDay and data.openDay > 0 then
            local timeTable = os.date("*t",  os.time())
            local start_str_list = strsplit(data.starttime,":") 
            local end_str_list = strsplit(data.stoptime,":") 
            if activity_state_map[data.key_name] == nil or tonumber(activity_state_map[data.key_name]) ~= 1 then  --未开启
                if timeTable.hour >= tonumber(start_str_list[1]) and timeTable.hour <= tonumber(end_str_list[1])
                and timeTable.min >= tonumber(start_str_list[2]) and timeTable.min < tonumber(end_str_list[2]) then
                    ActivityMgr:SetSpecialActiveState(data.key_name,true)
                end
            else  --已开启
                if timeTable.hour >= tonumber(end_str_list[1]) and timeTable.min >= tonumber(end_str_list[2]) then
                    ActivityMgr:CompelActivityState(data.key_name,false)
                elseif timeTable.hour < tonumber(end_str_list[1]) or timeTable.min < tonumber(end_str_list[2]) then
                    ActivityMgr:CompelActivityState(data.key_name,false)
                end
            end 
        end
    end
end
function ActivityMgr.FlushRunMinActivityState()
    local activity_state_map = json2tbl(getsysvar(VarEngine.ActivityState)) 
    if activity_state_map == "" then
        activity_state_map = {}
    end
    local open_day = getsysvar(VarEngine.OpenDay)
    for k, v in pairs(ActivityMgr.cfg[1]) do
        if k ~= "狂暴争霸1" then
            if open_day <= 0 then  --开服当天
                local run_time = math.floor(getsysvar(VarEngine.RunTime) / 60) 
                if activity_state_map[k] == nil or tonumber(activity_state_map[k]) ~= 1  then
                    if run_time < v.starttime then
                        ActivityMgr:SetActivityRobot(v.key_name,v.starttime - run_time ,v.stoptime-run_time)
                    elseif run_time >= v.starttime and run_time < v.stoptime then
                        ActivityMgr:SetActivityRobot(v.key_name,0 ,v.stoptime - run_time)
                    end
                else
                    if run_time >= v.starttime and run_time < v.stoptime then
                        ActivityMgr:SetActivityRobot(v.key_name,0 ,v.stoptime - run_time)
                    elseif run_time >= v.stoptime or run_time < v.starttime then 
                        ActivityMgr:SetActivityRobot(v.key_name,nil,0)
                    end
                end
            else
                ActivityMgr:SetActivityRobot(v.key_name,nil,0)
            end
        end
    end
    for k, v in pairs(ActivityMgr.cfg[2]) do
        if activity_state_map[k]  and  tonumber(activity_state_map[k]) == 1  then
            ActivityMgr:OpenServerRunDaySetActivity(v,activity_state_map)
        end
    end
end

function ActivityMgr:SetActivityRobot(key_name,starttime,stoptime)
    if starttime  then
        if tonumber(starttime) <= 0 then
            ActivityMgr:SetSpecialActiveState(key_name,true)
        else
            addActiveTrigger(key_name .. "_start", "MIN",  tostring(starttime), key_name,  "start")
        end
    end
    if stoptime then
        if tonumber(stoptime) <= 0 then
            ActivityMgr:CompelActivityState(key_name,false)
        else
            addActiveTrigger(key_name .. "_stop", "MIN", tostring(stoptime) , key_name,  "stop")
        end 
    end
end

function ActivityMgr:SetSpecialActiveState(name,is_open)
    local tag =  is_open and "start" or "stop" 
    _active_scheduled_callback(nil,name,tag)
end
function ActivityMgr:CompelActivityState(name,is_open)
local tag =  is_open and "start" or "stop" 
_active_scheduled_callback(nil,name,tag,true)
end
function _active_scheduled_callback(sys, name, tag,is_compel)
    local v = ActivityMgr.cfg[1][name] or ActivityMgr.cfg[2][name]
    if nil == v then
        return
    end
    local class = NpcClassCache[v.class or ""]
    -- 活动开放次数
    if v.openTimes then
        if getsysvar(v.sys_var) > v.openTimes then
            return
        end
        setsysvar(v.sys_var, getsysvar(v.sys_var) + 1)
    end
    local open_day = getsysvar(VarEngine.OpenDay)
    -- 开区天数
    if v.openDay and not is_compel then
        if open_day < v.openDay then
            return
        end
    end
    -- 新区
    if v.openDay == 0 and not is_compel then
        if open_day > v.openDay then
            return
        end
    end
    -- 合服次数
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if v.mergeCount and not is_compel then
        if merge_count < v.mergeCount then
            return
        end
    end
    
    if tag == "start" then
        if class and class.activeStart then
            local activity_state_map = json2tbl(getsysvar(VarEngine.ActivityState)) 
            if activity_state_map == "" then
                activity_state_map = {}
            end
            
            activity_state_map[name] = 1
            setsysvar(VarEngine.ActivityState,tbl2json(activity_state_map))
            class:activeStart(v)
        end
        if v.tip_desc ~= nil and type(v.tip_desc) == "string" then
            for i = 1, 3 do
                sendmovemsg("0", 1, 250, 0, 60+(i - 1 )*30, 1,"【活动提示】:"..v.tip_desc)
            end
            local str = string.format("【系统】:全服活动→%s",v.tip_desc) 
            local msg = string.format('{"Msg":"%s","FColor":255,"BColor":249,"Type":1}',str)
            sendmsg("0", 2,msg)
        end
    else
        if class and class.activeStop then
            local activity_state_map = json2tbl(getsysvar(VarEngine.ActivityState)) 
            if activity_state_map == "" then
                activity_state_map = {}
            end
            
            activity_state_map[name] = 2
            setsysvar(VarEngine.ActivityState,tbl2json(activity_state_map))
            class:activeStop(v)
        end
        -- for i = 1, 3 do
        --     sendmovemsg("0", 1, 249, 0, 60+(i - 1) * 30, 1, (v.activeName or name) .. "活动已结束,期待各位玩家的下次参与！")
        -- end
    end
end