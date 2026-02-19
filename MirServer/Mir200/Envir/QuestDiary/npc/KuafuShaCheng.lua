local KuafuShaCheng = {}
--活动开始
function KuafuShaCheng:kfscStart(sysobj)
    release_print("活动开启！！！！！")
    if not hastimerex(99530) then
        sendmovemsg("0", 1, 250, 0, 180, 1,"【活动提示】:跨服沙城已开启！")
        setontimerex(99530,3,1)
    end
end
--活动结束
function KuafuShaCheng:KfscEnd(sysobj)
    setofftimerex(99530)
    release_print("结束！！！！！")
    sendmovemsg("0", 1, 250, 0, 180, 1,"【活动提示】:跨服沙城已结束！")
    local win_hanghui = getsysvar(VarEngine.KuafShaCheng) 
    local player_list = getplayerlst(1)
    for k, v in pairs(player_list) do
        setofftimer(v, 99531)
        if checkkuafu(v) and getbaseinfo(v,3) == "kfsc_kf" or getbaseinfo(v,3) == "kfhg_kf" then
            local guild_name = getbaseinfo(v, 36)
            if guild_name == win_hanghui and win_hanghui ~= "" then
                local userID = getbaseinfo(v, 2)
                --胜利方行会会长 奖励
                local hanghui_actor = findguild(1,guild_name)
                local name = getbaseinfo(v, 1)
                local is_chengzhu = getguildinfo(hanghui_actor,4) == name 
                kfbackcall(1,userID,"kuafu_sc_win",is_chengzhu and 1 or 0)
            end
        end
    end
    setsysvar(VarEngine.KuafShaCheng,"") 
end
--玩家进入跨服服务器
function KuafuShaCheng:Kflogin(actor)
    self:CheckChengZhu()
    if not hastimer(99531) then
        setontimer(actor, 99531, 10, 0,1)
    end
end
--玩家退出跨服服务器
function KuafuShaCheng:KfEnd(actor)
    setofftimer(actor, 99531)
end

--检测城主行会
function KuafuShaCheng:CheckChengZhu()
    local player_list = getplayerlst(1)
    local temp_guild_name = ""--getsysvar(VarEngine.KuafShaCheng)
    local is_set_chengzhu = true
    for k, actor in pairs(player_list) do
        local map_id = getbaseinfo(actor, 3)
        local guild_name = getbaseinfo(actor, 36)
        release_print(guild_name,map_id,map_id == "kfhg_kf" , guild_name ~= -1)
        if map_id == "kfhg_kf" and guild_name ~= -1 then
            if temp_guild_name == "" then
                temp_guild_name = guild_name
            end
            if guild_name ~= temp_guild_name then
                is_set_chengzhu = false
            end 
        end
    end
      release_print("设置行会",temp_guild_name)
    if is_set_chengzhu and temp_guild_name ~= "" then
        setsysvar(VarEngine.KuafShaCheng,temp_guild_name) 
    end
end
function ontimerex99530()
    local npc_class = IncludeNpcClass("KuafuShaCheng")
     if npc_class then
        npc_class:CheckChengZhu()
     end
end
--每秒获得奖励
function ontimer99531(actor)
    local userID = getbaseinfo(actor, 2)
    local map_id = getbaseinfo(actor, 3)
    if map_id == "kfhg_kf" then
        kfbackcall(1,userID,"kuafu_sc",3)
    elseif map_id == "kfsc_kf" then
        kfbackcall(1,userID,"kuafu_sc",1)
    end  
end
return KuafuShaCheng