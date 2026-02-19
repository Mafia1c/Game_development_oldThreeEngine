KuaFuTrigger = {}
KuaFuTrigger.open_kf_update_mon = false
KuaFuTrigger.feijian_cfg = include("QuestDiary/config/kfFeiJianMapCfg.lua")

--#region 跨服成功跨服qf触发
function KuaFuTrigger.kflogin(actor)
    LoginTrigger.changeSkillEffect(actor)
    local btn_str = "<Button|a=0|x=250|y=180|nimg=public/btn_npcfh_01.png|pimg=public/btn_npcfh_02.png|color=255|size=18|link=@kuafu_back_func>"
    addbutton(actor, 101, 110, btn_str)
    VarApi.setPlayerTStrVar(actor, "T_kuafu_buff_info", "", false)

    local map_id = getbaseinfo(actor, 3)
    local kf_map_ids = {"古老寺庙4", "永夜山谷3", "幽灵神舰6", "蛮荒禁地3", "迷惘洞窟4", "诅咒城堡6"}
    -- 跨服图
    if isInTable(kf_map_ids, map_id) then
        local map_name = getbaseinfo(actor, 45)
        local txt_str = [[
            <RText|x=25.0|y=70.0|color=255|size=16|text=<BOSS每偶数整点刷新/FCOLOR=250>>
            <RText|x=25.0|y=90.0|color=255|size=16|text=<若刷新时BOSS未死亡/FCOLOR=250>>
            <RText|x=40.0|y=110.0|color=255|size=16|text=<则等待下次刷新/FCOLOR=251>>
        ]]
        local map_txt = "<RText|x=25.0|y=50.0|color=255|size=16|text=<《%s》/FCOLOR=243>>"
        map_txt = string.format(map_txt, map_name)
        addbutton(actor, 110, "_123456", map_txt..txt_str)
    elseif map_id == "祥瑞迷宫合区" or map_id == "迷失之城" then
        KuaFuTrigger.luckTreasureTaskInfo(actor, map_id)
    elseif string.find(map_id,"sss11") then
        delbutton(actor, 110, "_1234568")
        local npc_class = IncludeNpcClass("disguiseMap")
        if npc_class then
            npc_class:showDisguiseReward(actor)
        end
    elseif string.find(map_id,"fjdt_kf") then
        delbutton(actor, 110, "_1234567")
        local npc_class = IncludeNpcClass("CrossRealmBattlefield")
        if npc_class then
            npc_class:showFeiJianReward(actor, map_id)
        end
    else
        delbutton(actor, 110, "_123456")
        local npc_class = IncludeNpcClass("GoToMapNpc")
        if npc_class then
            npc_class:showAnHeiZhiChengReward(actor, map_id)
        end
    end
    if map_id == "kfhg_kf" or map_id == "kfsc_kf" then
        local npc_class = IncludeNpcClass("KuafuShaCheng")
        if npc_class then
            npc_class:Kflogin(actor)
        end
    end
    if hasscheduled("update_通灵战场机器人2") then
        delscheduled("update_通灵战场机器人2")
    end
    if hasscheduled("update_混沌战场机器人2") then
        delscheduled("update_混沌战场机器人2")
    end

    if not hasscheduled("update_跨服混沌战场机器人") then
        _update_hdzc_mon()
        addscheduled("update_跨服混沌战场机器人",'RunOnDay','15:00:00','@_update_hdzc_mon',1)
    end

    if not hasscheduled("update_跨服通灵战场机器人") then
        _update_tlzc_mon()
        addscheduled("update_跨服通灵战场机器人",'RunOnDay','22:00:00','@_update_tlzc_mon',1)
    end
   
    if string.find(map_id,"hdzc_kf")  or string.find(map_id,"tlzc_kf") then
       KuaFuTrigger.KfZCTaskInfo(actor,map_id)
    end
    if hasscheduled("update_跨服_机器人_龙魂禁地") then
        _update_wolongfuren_mon()
    else
        addscheduled("update_跨服_机器人_龙魂禁地",'MIN', '1', '@_update_wolongfuren_mon', 1)
        _update_wolongfuren_mon()
    end

    if hasscheduled("update_跨服_机器人_镇魔塔") then
    else
        _update_zhenmota_mon(actor, true)
        addscheduled("update_跨服_机器人_镇魔塔",'SEC', '1', '@_update_zhenmota_mon', 1)
    end

    if hasscheduled("update_跨服_机器人_暗黑之城") then
    else
        _update_ahzc_mon(actor, true)
        addscheduled("update_跨服_机器人_暗黑之城",'SEC', '1', '@_update_ahzc_mon', 1)
    end
    setontimer(actor, 33333, 1, 0)
    releasesprite(actor)
    lualib:CallFuncByClient(actor, "HiedMainTopBtn", nil)
    kfbackcall(1,getbaseinfo(actor, 2),"","buffStr") --#region buff传递
    kfbackcall(1,getbaseinfo(actor, 2),"","varTab") --#region 自定义变量传递
    kfbackcall(1,getbaseinfo(actor, 2),"kf_recharge")
end
function ontimer33333(actor)

    local level = getskillinfo(actor, 31, 2)
    if level and level >= 5 then
        local cur_hp = getbaseinfo(actor, 9)
        local max_hp = getbaseinfo(actor, 10)
        local bool, endTime = checkhumanstate(actor,1)
        if bool then
            local rate = (max_hp - cur_hp) / (max_hp * 0.05)
            kfbackcall(1,getbaseinfo(actor, 2),"skill_attr_change", rate * 100 .. "|".. endTime)
        else
            kfbackcall(1,getbaseinfo(actor, 2),"skill_attr_change", 0 .. "|".. endTime)
        end
    end
end
function _update_hdzc_mon()
    for i = 1, 8 do
        local mon_name = "混沌异兽"
        if i > 3 then
            mon_name = "混沌异兽3" 
        elseif i == 1 then
            mon_name = "混沌异兽"
        else
            mon_name = "混沌异兽" .. i
        end
        local map_name = "hdzc_kf"
        if i > 8 then
            map_name = "hdzc_kf8"
        elseif i == 1 then
            map_name = "hdzc_kf"
        else
            map_name = "hdzc_kf" ..i
        end
        if getmoncount(map_name, -1, true) <= 0 then
            genmon(map_name, 47, 47, mon_name, 3, 1, 249)
        end
    end
end

function _update_tlzc_mon()
    for i = 1, 8 do
        local mon_name = "通灵异兽"
        if i > 3 then
            mon_name = "通灵异兽3" 
        elseif i == 1 then
            mon_name = "通灵异兽"
        else
            mon_name = "通灵异兽" .. i
        end
        local map_name = "tlzc_kf"
        if i > 8 then
            map_name = "tlzc_kf8"
        elseif i == 1 then
            map_name = "tlzc_kf"
        else
            map_name = "tlzc_kf" ..i
        end
        if getmoncount(map_name, -1, true) <= 0 then
            genmon(map_name, 73, 70, mon_name, 3, 1, 249)
        end
    end
end
function _update_wolongfuren_mon()
    local timeTable = os.date("*t", os.time())
    if timeTable.hour == 19 and timeTable.min < 20 then  --卧龙祭坛活动开始
    elseif timeTable.hour == 19 and timeTable.min == 20 then  --卧龙祭坛活动结束
        if not hastimerex(99532) then
            setontimerex(99532,3,1)
        end
    end
    if timeTable.hour % 2 == 0 and timeTable.min <= 1 then         --偶数整点
        local mon_count = getmoncount("龙魂禁地", -1, true)
        if mon_count <= 0 then
            genmon("龙魂禁地", 32, 40, "卧龙夫人", 100, 1, 249)
        end
    end
    if timeTable.hour % 2 == 0 and timeTable.min >= 11 then
        -- randomkillmon("龙魂禁地", "卧龙夫人", 1, 0)
        killmonsters("龙魂禁地","*",0,false)
        local players = getplaycount("龙魂禁地",1,1)
        for index, player in ipairs(type(players) == "table" and players or {}) do
            mapmove(player, 3, 330, 330, 5)
        end
        -- kuafuusergohome()
    end
    if timeTable.hour== 0 and timeTable.min <= 1 then --#region 飞剑跨服地图24.传回
        for i = 1, 8, 1 do
            local players = getplaycount("fjdt_kf"..i,1,1)
            for index, player in ipairs(type(players) == "table" and players or {}) do
                mapmove(player,3,330,330,5)
            end
        end
    end
end
function _update_zhenmota_mon(sysobj, is_genmon)
    if is_genmon then
        if getmoncount("zm_kf", -1, true) <= 0 then
            genmon("zm_kf", 24, 22, "黑暗魔君", 3, 1, 249)
        end
        if getmoncount("jt_kf", -1, true) <= 0 then
            genmon("jt_kf", 28, 26, "魔界苍龙", 3, 1, 249)
        end   
        if getmoncount("sd_kf", -1, true) <= 0 then
            genmon("sd_kf", 46, 56, "魔界邪龙", 3, 1, 249)
        end 
        if getmoncount("fc_kf", -1, true) <= 0 then
            genmon("fc_kf", 42, 45, "魔界天龙", 3, 1, 249)
        end   
        if getmoncount("mg_kf", -1, true) <= 0 then
            genmon("mg_kf", 24, 26, "魔界暗龙", 3, 1, 249)
        end 
        if getmoncount("jd_kf", -1, true) <= 0 then
            genmon("jd_kf", 73, 70, "魔界飞龙", 3, 1, 249)
        end   
        if getmoncount("sy_kf", -1, true) <= 0 then
            genmon("sy_kf", 28, 32, "魔界神龙", 3, 1, 249)
        end   

        if getmoncount("4ldkf_1", -1, true) <= 0 then
            genmon("4ldkf_1", 51, 48, "地狱魔神·神秘之主[真身]1", 3, 1, 249)
        end 
        if getmoncount("4ldkf_2", -1, true) <= 0 then
            genmon("4ldkf_2", 23, 27, "地狱魔神·诡异之主[真身]1", 3, 1, 249)
        end   
        if getmoncount("4ldkf_3", -1, true) <= 0 then
            genmon("4ldkf_3", 15, 13, "地狱魔神·厄运之主[真身]1", 3, 1, 249)
        end 
        if getmoncount("4ldkf_4", -1, true) <= 0 then
            genmon("4ldkf_4", 73, 70, "地狱魔神·禁忌之主[真身]1", 3, 1, 249)
        end   
        if getmoncount("4ldkf_5", -1, true) <= 0 then
            genmon("4ldkf_5", 50, 50, "地狱魔神·怨恨之主[真身]1", 3, 1, 249)
        end   
        if getmoncount("4ldkf_6", -1, true) <= 0 then
            genmon("4ldkf_6", 25, 30, "地狱魔神·罪恶之主[真身]1", 3, 1, 249)
        end    
    else
        local dateInfo = os.date("*t")
        local min = dateInfo.min
        local sec = dateInfo.sec
        if min < 1 and sec < 3 then
            local count = getmoncount("zm_kf", -1, true)
            if count <= 0 then
                genmon("zm_kf", 24, 22, "黑暗魔君", 3, 1, 249)
            end
            count = getmoncount("jt_kf", -1, true)
            if count <= 0 then
                genmon("jt_kf", 28, 26, "魔界苍龙", 3, 1, 249)
            end
            count = getmoncount("sd_kf", -1, true)
            if count <= 0 then
                genmon("sd_kf", 46, 56, "魔界邪龙", 3, 1, 249)
            end
            count = getmoncount("fc_kf", -1, true)
            if count <= 0 then
                genmon("fc_kf", 42, 45, "魔界天龙", 3, 1, 249)
            end
            count = getmoncount("mg_kf", -1, true)
            if count <= 0 then
                genmon("mg_kf", 24, 26, "魔界暗龙", 3, 1, 249)
            end
            count = getmoncount("jd_kf", -1, true)
            if count <= 0 then
                genmon("jd_kf", 73, 70, "魔界飞龙", 3, 1, 249)
            end
            count = getmoncount("sy_kf", -1, true)
            if count <= 0 then
                genmon("sy_kf", 28, 32, "魔界神龙", 3, 1, 249)
            end
            count = getmoncount("4ldkf_1", -1, true)
            if count <= 0 then
                genmon("4ldkf_1", 51, 48, "地狱魔神·神秘之主[真身]1", 3, 1, 249)
            end 
            count = getmoncount("4ldkf_2", -1, true)
            if count <= 0 then
                genmon("4ldkf_2", 23, 27, "地狱魔神·诡异之主[真身]1", 3, 1, 249)
            end   
            count = getmoncount("4ldkf_3", -1, true)
            if count <= 0 then
                genmon("4ldkf_3", 15, 13, "地狱魔神·厄运之主[真身]1", 3, 1, 249)
            end 
            count = getmoncount("4ldkf_4", -1, true)
            if count <= 0 then
                genmon("4ldkf_4", 73, 70, "地狱魔神·禁忌之主[真身]1", 3, 1, 249)
            end   
            count = getmoncount("4ldkf_5", -1, true)
            if count <= 0 then
                genmon("4ldkf_5", 50, 50, "地狱魔神·怨恨之主[真身]1", 3, 1, 249)
            end   
            count = getmoncount("4ldkf_6", -1, true)
            if count <= 0 then
                genmon("4ldkf_6", 25, 30, "地狱魔神·罪恶之主[真身]1", 3, 1, 249)
            end   
        end
    end
end

function _update_ahzc_mon(sysobj, is_genmon)
    local dateInfo = os.date("*t")
    local dayOfWeek = dateInfo.wday
    local hour = dateInfo.hour
    local min = dateInfo.min
    local sec = dateInfo.sec
    local map_state = 0
    if dayOfWeek == 1 or dayOfWeek == 7 then        -- 周末
        if min == 0 and sec <= 1 then
            map_state = 1
        end
    else
        if hour % 2 == 0 and min == 0 and sec <= 1 then
            map_state = 1
        end
    end
    if hour < 12 then
        map_state = 0
    end
    local ahzc_cfg = include("QuestDiary/config/ahzcmonCfg.lua")
    if is_genmon then
        for _, cfg in pairs(ahzc_cfg) do
            killmonsters(cfg.mapid, "*", 0, false)
        end
        for _, cfg in pairs(ahzc_cfg) do
            -- 小怪  
            for k, v in pairs(cfg.monster_arr or {}) do
                local count = 100
                if k == 1 then
                    count = 99
                end
                genmon(cfg.mapid, 0, 0, v, 1000, count, 255)
            end
            -- boss
            local pos = cfg.coordinate1_arr or {50, 50}
            for k, v in pairs(cfg.boss1_arr or {}) do
                genmon(cfg.mapid, pos[1], pos[2], v, 1, 1, 249)
            end
        end
    else
        if map_state == 1 then
            for i = 1, 6, 1 do
                local players = getplaycount("暗黑之城"..i,1,1)
                for index, player in ipairs(type(players) == "table" and players or {}) do
                    mapmove(player,3,330,330,5)
                end
            end
            for _, cfg in pairs(ahzc_cfg) do
                killmonsters(cfg.mapid, "*", 0, false)
            end
            for _, cfg in pairs(ahzc_cfg) do
                -- 小怪  
                for k, v in pairs(cfg.monster_arr or {}) do
                    local count = 100
                    if k == 1 then
                        count = 99
                    end
                    genmon(cfg.mapid, 0, 0, v, 1000, count, 255)
                end
                -- boss
                local pos = cfg.coordinate1_arr or {50, 50}
                for k, v in pairs(cfg.boss1_arr or {}) do
                    genmon(cfg.mapid, pos[1], pos[2], v, 1, 1, 249)
                end
            end
        end
    end
end

function ontimerex99532()
    local temp_guild_name = ""
    local players = getplaycount("卧龙祭坛",1,1)
    if players == "0" then
        return
    end
    temp_guild_name = getbaseinfo(players[1], 36) 
    for index, player in ipairs(players) do
        local guild_name = getbaseinfo(player, 36)
        if guild_name ~= temp_guild_name then
            return 
        end
    end
    if temp_guild_name then
        for i,v in ipairs(players) do
            if checkkuafu(v) then
                local guild_name = getbaseinfo(v, 36)
                local userID = getbaseinfo(v, 2)
                kfbackcall(1,userID,"wolongjitan")
            end
        end
        setofftimerex(99532)
    end
end

--#region 跨服结束本服qf触发
function KuaFuTrigger.kuafuend(actor)
    delbutton(actor, 101, 110)
    delbutton(actor, 110, "_123456")
    createsprite(actor, "拾取小精灵")
    pickupitems(actor, 0, 6, 0.5)
    VarApi.setPlayerTStrVar(actor, "T_kuafu_buff_info", "", false)

    local npc_class = IncludeNpcClass("KuafuShaCheng")
    if npc_class then
        npc_class:KfEnd(actor)
    end
  
    KuaFuTrigger.bfbackcall(actor, "kf_bf_var_tab")
    lualib:CallFuncByClient(actor, "ShowMainTopBtn", nil)
 
end

--跨服通知本服触发qf  发起函数（发送方）
function KuaFuTrigger.kfbackcall99(actor, param1, param2)
    kfbackcall(99, getbaseinfo(actor, 2), param1, param2)
end

--跨服通知本服触发qf  回调函数（接收方）
function KuaFuTrigger.kfsyscall99(actor, param1, param2)
    if param1 == "卧龙令*1" then
        giveitem(actor, param1, 1, 307, "攻击卧龙夫人获得")
    end
end

--本服通知触发跨服QF  发起函数
function KuaFuTrigger.bfbackcall(actor, param1, param2)
    local str1 = param1 or ""
    local str2 = param2 or ""
    if param1 == "call_buff" then
        local buff = getallbuffid(actor)
        for key, buffid in pairs(buff) do
            str1 = buffid .. "#" .. str1
        end
    end
    bfbackcall(99, getbaseinfo(actor, 2), str1, str2)
end

--#region 本服通知触发跨服QF(传递的字符串1(字符串),传递的字符串2(字符串))
function KuaFuTrigger.bfsyscall99(actor, param1, param2)
    local itemName = param1
    local pos_x = getbaseinfo(actor, 4)
    local pos_y = getbaseinfo(actor, 5)
    if itemName == "祥龙贺岁炮" then
        rangeharm(actor, pos_x, pos_y, 3, 0, 6, 100000, 0, 2)
        playeffect(actor, 86, 0, 0, 1, 0, 0)
    elseif itemName == "福运连年炮" then
        rangeharm(actor, pos_x, pos_y, 3, 0, 6, 500000, 0, 2)
        playeffect(actor, 86, 0, 0, 1, 0, 0)
    elseif itemName == "盛世华章炮" then
        rangeharm(actor, pos_x, pos_y, 3, 0, 6, 1000000, 0, 2)
        playeffect(actor, 86, 0, 0, 1, 0, 0)
    elseif itemName == "瑞彩缤纷炮" then
        rangeharm(actor, pos_x, pos_y, 3, 0, 2, 60, 0, 2)
        playeffect(actor, 86, 0, 0, 1, 0, 0)
    elseif itemName == "喜乐年华炮" then
        rangeharm(actor, pos_x, pos_y, 3, 0, 12, 1, 0, 2)
        playeffect(actor, 86, 0, 0, 1, 0, 0)
    elseif param2 == "buffStr" then --#region 接受本服buff
        local buff_list = strsplit(param1, "#")
        if type(buff_list) == "table" then
            -- for key, id in pairs(buff_list) do
            --     release_print("跨服",id)
            --     addbuff(actor, tonumber(id))
            -- end
            -- release_print("跨服buff: ", param1)
            VarApi.setPlayerTStrVar(actor, "T_kuafu_buff_info", param1, false)
        end
    elseif param2 == "varTab" then --#region 接受本服自定义变量
        local varTab = json2tbl(param1)
        if varTab == "" then varTab = {} end
        VarApi.setPlayerUIntVar(actor,"UL_treasureAwake12",varTab[1],false)
        VarApi.setPlayerUIntVar(actor,"UL_luckEquip",varTab[2],false)
        VarApi.setPlayerUIntVar(actor,"UL_godPerson",varTab[3],false)
        VarApi.setPlayerUIntVar(actor,"UL_landGod",varTab[4],false)
        VarApi.setPlayerUIntVar(actor,"l_masterLayer",varTab[5],false)
        VarApi.setPlayerUIntVar(actor,"U_50027_buff_cd_timestamp",varTab[6],false)
        VarApi.setPlayerUIntVar(actor,"U_bawangXY",varTab[7],false)
        VarApi.setPlayerUIntVar(actor,"U_feijian_suit_state",varTab[8],false)
    elseif param1 =="kf_recharge" then
        VarApi.setPlayerUIntVar(actor, "U_kf_recharge", tonumber(param2) )
    elseif param1 == "crittrigger" then -- 暴击触发
        local mon_obj = getmonbyuserid(getbaseinfo(actor, 3), param2)
        if mon_obj then
            makeposion(mon_obj, 12, 1)
            sendmsg(actor, 1, '{"Msg":"BUFF【神龙专属】神龙专属BUFF触发：将目标冰冻1秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        end
    elseif param1 == "kf_bf_var_tab" then 
        local varTab = { 
            ["U_50027_buff_cd_timestamp"]={VarApi.getPlayerUIntVar(actor, "U_50027_buff_cd_timestamp"),"U"},
            ["U_feijian_suit_state"]={VarApi.getPlayerUIntVar(actor, "U_feijian_suit_state"),"U"},
        }
        kfbackcall(1,getbaseinfo(actor, 2),"kf_bf_var_tab",tbl2json(varTab) ) --#region 自定义变量传递
    elseif string.find(param1,"get_fj_boss_time") or string.find(param1,"init_get_fj_boss_time") then
        local boss_time = {}
        local str_list = strsplit(param1,"|")
        local info = mapbossinfo(str_list[2],"*",1)
        local layer = str_list[3]
        for k, v in pairs(info) do
            local boss_info =  strsplit(v,"#")
            boss_time[boss_info[1]] = boss_info[3]
        end
        if string.find(param1,"init_get_fj_boss_time") then
            kfbackcall(1,param2,"init_set_bf_boss_time|"..layer,tbl2json(boss_time) ) --#region 自定义变量传递
        else
            kfbackcall(1,param2,"set_bf_boss_time|"..layer,tbl2json(boss_time) ) --#region 自定义变量传递
        end
     elseif string.find(param1,"get_zb_boss_time") then
        local boss_time = {}
        local str_list = strsplit(param1,"|")
        local info = mapbossinfo(str_list[2],"*",1)
        for k, v in pairs(info) do
            local boss_info =  strsplit(v,"#")
            boss_time[boss_info[1]] = boss_info[3]
        end
        kfbackcall(1,param2,"set_zb_boss_time",tbl2json(boss_time) ) --#region 自定义变量传递
    elseif string.find(param1, "暗黑之城") then
        -- local cur_map = getbaseinfo(actor, 3)
        -- local mon_count = getmoncount(cur_map, -1, true)
        -- if mon_count > 0 then
        --     Sendmsg9(actor, "ffffff", string.format("当前地图剩余怪物%s只!", mon_count), 1)
        -- else
        --     map(actor, param1)
        -- end
        map(actor, param1)
    else
        -- local buff_list = strsplit(param1, "#")
        -- if type(buff_list) == "table" then
        --     for key, id in pairs(buff_list) do
        --         addbuff(actor, tonumber(id))
        --     end
        -- end
    end    
end

--#region 跨服通知本服
function KuaFuTrigger.kfsyscall1(actor,parama,paramb)
    if paramb == "buffStr" then --#region buff传递到跨服
        local str1 = ""
        local buff = getallbuffid(actor)
        for key, buffid in pairs(buff) do
            str1 = buffid .. "#" .. str1
            -- release_print("本服",buffid)
        end
        bfbackcall(99, getbaseinfo(actor, 2), str1, "buffStr")
    elseif paramb == "varTab" then --#region 变量传递到跨服(变量名=变量值，变量类型)
        local varTab = { --#region (变量名=变量值，变量类型)
            VarApi.getPlayerUIntVar(actor, "UL_treasureAwake12"),
            VarApi.getPlayerUIntVar(actor, "UL_luckEquip"),
            VarApi.getPlayerUIntVar(actor, "UL_godPerson"),
            VarApi.getPlayerUIntVar(actor, "UL_landGod"),
            VarApi.getPlayerUIntVar(actor, "l_masterLayer"),
            VarApi.getPlayerUIntVar(actor, "U_50027_buff_cd_timestamp"),
            VarApi.getPlayerUIntVar(actor, "U_bawangXY"),
            VarApi.getPlayerUIntVar(actor, "U_feijian_suit_state"),
        }
        bfbackcall(99, getbaseinfo(actor, 2), tbl2json(varTab), "varTab")
    elseif parama == "kf_bf_var_tab" then --#region 接受本服自定义变量
        local varTab = json2tbl(paramb)
        for key, value in pairs(varTab) do
            if value[2] == "U" then
                VarApi.setPlayerUIntVar(actor,key,value[1],false)
            elseif value[2] == "T" then
                VarApi.setPlayerTStrVar(actor,key,value[1],false)
            elseif value[2] == "J" then
                VarApi.setPlayerJIntVar(actor,key,value[1],false)
            elseif value[2] == "Z" then
                VarApi.setPlayerZStrVar(actor,key,value[1],false)
            end
        end
        local class = IncludeNpcClass("xuemai")
        if class then 
            class:flushBuffRevive(actor)
        end
    elseif string.find(parama,"set_bf_boss_time") or string.find(parama,"init_set_bf_boss_time") then --#region 跨服发到本服boss刷新信息
        local class = IncludeNpcClass("CrossRealmBattlefield")
        if class then 
            local layer = string.match(parama, "%-?%d+%.?%d*")
            class:flushFJBossInfo(actor,paramb,string.find(parama,"init_set_bf_boss_time") ~= nil,layer)
        end
    elseif parama == "set_zb_boss_time" then --#region 装扮倒计时
        if IncludeNpcClass("disguiseMap") then
            IncludeNpcClass("disguiseMap"):flushBossInfo(actor,paramb)
        end
    end
    if parama == "kuafu_zc" then
        sendmail(getbaseinfo(actor,2),1,"跨服战场","跨服战场击杀BOSS奖励","战令#200&金刚石#500&声望#500")
    elseif parama == "kuafu_sc" then
        giveitem(actor, "战令*1", tonumber(paramb), 307, "跨服沙城每秒获得")
        -- changemoney(actor,25,"+",tonumber(paramb))
    elseif parama == "kuafu_sc_win" then
        local str = "绑定灵符#200&战令#500&绑定金刚石#1000&声望#100"
        if tonumber(paramb) == 1 then
            str = str.."&城主专属足迹(足迹)#1"
            sendmail(getbaseinfo(actor,2),1,"跨服沙城","跨服沙城城主奖励",str)    
        else
            sendmail(getbaseinfo(actor,2),1,"跨服沙城","跨服沙城胜利方奖励",str)
        end
    elseif parama == "wolongjitan" then
         sendmail(getbaseinfo(actor,2),1,"卧龙祭坛","卧龙祭坛奖励","卧龙1.1倍神力(称号)#1")  
    elseif parama == "kf_recharge" then
        local recharge_value = VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE)  
        bfbackcall(99, getbaseinfo(actor, 2), "kf_recharge", recharge_value)
    elseif parama == "feijian_map" then
        local layer = tonumber(paramb) 
        local cfg =  KuaFuTrigger.feijian_cfg[layer]
        if cfg == nil then
            return Sendmsg9(actor, "ffffff", "未找到层数配置！", 1) 
        end
        local str = cfg.kill_award
        local enter_num = VarApi.getPlayerJIntVar(actor,"J_enter_num")
        VarApi.setPlayerJIntVar(actor,"J_enter_num",enter_num+1)
        if enter_num +1 > 12 then
            senddelaymsg(actor, "<今日击杀飞剑跨服BOSS次数用尽: %s后将自动离开地图!/FCOLOR=250>", 15, 255, 1, "@_zbkf_map")
        elseif enter_num+1 == 12 then
            senddelaymsg(actor, "<今日击杀飞剑跨服BOSS次数用尽: %s后将自动离开地图!/FCOLOR=250>", 15, 255, 1, "@_zbkf_map")
            sendmail(getbaseinfo(actor,2),1,"飞剑地图","击杀飞剑地图BOSS奖励",str)
        else
            sendmail(getbaseinfo(actor,2),1,"飞剑地图","击杀飞剑地图BOSS奖励",str)  
        end
    elseif parama == "disguise_map" then
        local time = VarApi.getPlayerJIntVar(actor,"J_disguiseMapTime")
        VarApi.setPlayerJIntVar(actor,"J_disguiseMapTime",time+1,true)
        local layer = tonumber(paramb)
        local disguiseMapCfg = {
            { {"幽影魔主·紫烬","金辉神骏(限定装扮)"},{"炽焰神将·燎天","耀金战骑(限定装扮)"},{"黯狱魔将·烬芒","独孤求败(称号)"},{"炽阳灵主·炎裳","盖世英雄(称号)"},{"战令*1","金刚石","声望","时装碎片"},{"sss111",50,54},{100,100,100,1}},
            { {"幽影魔主·紫烬1","金辉神骏(限定装扮)"},{"炽焰神将·燎天1","耀金战骑(限定装扮)"},{"黯狱魔将·烬芒1","独孤求败(称号)"},{"炽阳灵主·炎裳1","盖世英雄(称号)"},{"战令*1","金刚石","声望","时装碎片"},{"sss112",50,54},{100,100,100,1}},
            { {"幽影魔主·紫烬2","金辉神骏(限定装扮)"},{"炽焰神将·燎天2","耀金战骑(限定装扮)"},{"黯狱魔将·烬芒2","独孤求败(称号)"},{"炽阳灵主·炎裳2","盖世英雄(称号)"},{"战令*1","金刚石","声望","时装碎片"},{"sss113",50,54},{100,100,100,1}},
            { {"幽影魔主·紫烬3","金辉神骏(限定装扮)"},{"炽焰神将·燎天3","耀金战骑(限定装扮)"},{"黯狱魔将·烬芒3","独孤求败(称号)"},{"炽阳灵主·炎裳3","盖世英雄(称号)"},{"战令*1","金刚石","声望","时装碎片"},{"sss114",50,54},{100,100,100,1}},
        }
        if not disguiseMapCfg[layer] then
            return Sendmsg9(actor, "ffffff", "未找到层数配置！", 1) 
        end
        local emailItemStr = ""
        for i = 1, #disguiseMapCfg[layer][5] do
            emailItemStr = emailItemStr.."&"..disguiseMapCfg[layer][5][i].."#"..disguiseMapCfg[layer][7][i].."#307"
        end
        emailItemStr = emailItemStr:sub(2)
        if time+1 >= 7 then
            senddelaymsg(actor, "<今日击杀装扮跨服BOSS次数用尽: %s后将自动离开地图!/FCOLOR=250>", 15, 255, 1, "@_zbkf_map")
        elseif time+1 >= 6 then
            senddelaymsg(actor, "<今日击杀装扮跨服BOSS次数用尽: %s后将自动离开地图!/FCOLOR=250>", 15, 255, 1, "@_zbkf_map")
            sendmail(getbaseinfo(actor,2),1,"装扮地图","击杀装扮地图BOSS行会成员奖励",emailItemStr)
        else
            sendmail(getbaseinfo(actor,2),1,"装扮地图","击杀装扮地图BOSS行会成员奖励",emailItemStr)
        end
        -- if IncludeNpcClass("disguiseMap") then 
        --     IncludeNpcClass("disguiseMap"):SendKillBossAward(actor,paramb)
        -- end
    elseif parama == "addbuff" then
        addbuff(actor,60013,10)
    elseif parama  == "skill_attr_change" then
        local str_list =  strsplit(paramb,"|")
        changehumnewvalue(actor, 77, tonumber(str_list[1]),tonumber(str_list[2]) )
    end
        
end
function _zbkf_map(actor)
    mapmove(actor,3,333,333,3)
end

function kuafu_back_func(actor)
    showprogressbardlg(actor, 3, "@kf_go_back_func1", "正在退出跨服服务器..", 0, "@kf_go_back_func2")
end


function kf_go_back_func1(actor)
    -- 返回
    mapmove(actor, 3, 333, 333, 1)
end

function kf_go_back_func2(actor)
    -- 打断
end

-- 跨服地图刷怪
function KuaFuTrigger.updateKFMon()
    if not checkkuafuconnect() then             -- 检查以下跨服地图是否连接
        return
    end
    if KuaFuTrigger.open_kf_update_mon then
        return
    end
    local map_ids = {"古老寺庙4", "永夜山谷3", "幽灵神舰6", "蛮荒禁地3", "迷惘洞窟4", "诅咒城堡6"}

    local timer_id = 60000
    for k, v in pairs(map_ids) do
        local id = timer_id + k
        if hasenvirtimer(v, id) then
            setenvirofftimer(v, id)
        end
        setenvirontimer(v, id, 1, "@_update_kfmap_mon,"..v..","..k)
    end

    if hasenvirtimer("祥瑞迷宫合区", 70000) then --#region 祥瑞迷宫
        setenvirofftimer("祥瑞迷宫合区", 70000)
    end
    _lucktreasure_kfmap_mon()
    setenvirontimer("祥瑞迷宫合区", 70000, 3600, "@_lucktreasure_kfmap_mon")

    KuaFuTrigger.open_kf_update_mon = true
end

function _update_kfmap_mon(sysObj, map_id, index)
    index = tonumber(index)
    local mon_list = {"异界★★★·轮回佛陀", "异界★★★★·永夜主宰", "异界★★★★★·寂灭方舟", "异界★★★·不朽屠穹", "异界★★★★·混沌之主", "异界★★★★★·时空之主"}
    -- 获取当前时间
    local currentTime = os.time()
    local timeTable = os.date("*t", currentTime)
    if timeTable.hour % 2 == 0 and timeTable.min == 0 and timeTable.sec <= 1 then       -- 偶数点刷怪
        local mon_count = getmoncount(map_id, -1, true)
        local mon_name = mon_list[index]
        if mon_count <= 0 and mon_name then
            genmon(map_id, 0, 0, mon_name, 300, 1, 249)
        end
    end
end

function KuaFuTrigger.KfZCTaskInfo(actor,map_id)
    delbutton(actor, 110, "_123456")
    local ishdzc = string.find(map_id,"hdzc_kf")
    local map_name = ishdzc and "混沌战场" or "通灵战场"
    local close_time = ishdzc and 16 or 23
    local state_text = "<Text|x=30.0|y=34.0|color=250|size=16|text=BOSS状态：存活中>"

    local merge_count = string.match(map_id, "%-?%d+%.?%d*")
    if merge_count == nil then
        merge_count=""
    elseif tonumber(merge_count) > 3 then
        merge_count = 3
    end
    local boss_name = ishdzc and "混沌异兽" or "通灵异兽"
    local mon_name = boss_name .. merge_count
    if getmoncount(map_id,getdbmonfieldvalue(mon_name, "idx"),true) <= 0 then
        state_text = "<Text|x=30.0|y=34.0|color=249|size=16|text=BOSS状态：已死亡>"
    end
    local info = [[
        <Text|x=15.0|y=58.0|color=251|size=16|text=击杀BOSS行会全体奖励>
        <Text|x=70.0|y=82.0|color=241|size=16|text=战令x200>
        <Text|x=60.0|y=106.0|color=241|size=16|text=金刚石x500>
        <Text|x=70.0|y=130.0|color=241|size=16|text=声望x500>
    ]]

    local map_txt = "<Text|x=55.0|y=10.0|color=243|size=16|text=《%s》>"
    local tip_txt = "<Text|x=5.0|y=160.0|color=254|size=16|text=%s入口将在%s点关闭>"
    map_txt = string.format(map_txt, map_name)
    tip_txt = string.format(tip_txt, map_name,close_time)
    addbutton(actor, 110, "_123456", map_txt..state_text..info..tip_txt)
end

function KuaFuTrigger.luckTreasureTaskInfo(actor, map_id) --#region 祥瑞迷宫跨服更新任务面板
    local mon_list = {"子鼠启运兽", "丑牛耕耘兽", "寅虎驱邪兽", "卯兔捣药兽", "辰龙赐福兽", "巳蛇蜕厄兽","午马奔腾兽","未羊护生兽","申猴闹春兽","酉鸡报喜兽","戌狗守岁兽","亥猪纳福兽",}
    if map_id == "迷失之城" then
        mon_list = {"魔童哪吒(真身之体)", "魔童哪吒(元神之体)", "魔童哪吒(魔化之体)", "魔童哪吒(狂暴之体)"}
    end
    local infoList = {}
    for index, value in ipairs(mon_list) do
        if getmoncount(map_id, getdbmonfieldvalue(value, "idx"), true) > 0 then
            table.insert(infoList, "<存活中/FCOLOR=250>")
        else
            table.insert(infoList, "<已阵亡/FCOLOR=249>")
        end
    end
    delbutton(actor, 110, "_123456")
    local info = [[
        <Text|x=30.0|y=10.0|color=243|size=16|text=《祥瑞迷宫(跨服)》>
        <Text|x=2.0|y=34.0|color=250|size=16|text=BOSS存活状态(可下滑查看)>
        <ListView|children={2,3,4,5,6,7,8,9,10,11,12,13}|x=36|y=60|width=220|height=120|direction=1|bounce=1|margin=2|reload=1>
        <RText|id=2|x=0.0|y=0.0|color=250|size=16|text=<子鼠启运兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=3|x=0.0|y=0.0|color=250|size=16|text=<丑牛耕耘兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=4|x=0.0|y=0.0|color=250|size=16|text=<寅虎驱邪兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=5|x=0.0|y=0.0|color=250|size=16|text=<卯兔捣药兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=6|x=0.0|y=0.0|color=250|size=16|text=<辰龙赐福兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=7|x=0.0|y=0.0|color=250|size=16|text=<巳蛇蜕厄兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=8|x=0.0|y=0.0|color=250|size=16|text=<午马奔腾兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=9|x=0.0|y=0.0|color=250|size=16|text=<未羊护生兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=10|x=0.0|y=0.0|color=250|size=16|text=<申猴闹春兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=11|x=0.0|y=0.0|color=250|size=16|text=<酉鸡报喜兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=12|x=0.0|y=0.0|color=250|size=16|text=<戌狗守岁兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=13|x=0.0|y=0.0|color=250|size=16|text=<亥猪纳福兽/FCOLOR=253><-/FCOLOR=250>%s>
    ]]
    if map_id == "迷失之城" then
        info = [[
            <Text|x=30.0|y=10.0|color=243|size=16|text=《迷失之城(跨服)》>
            <Text|x=25.0|y=34.0|color=250|size=16|text=地图BOSS存活状态>
            <ListView|children={2,3,4,5,6,7,8,9,10,11,12,13}|x=6|y=60|width=220|height=120|direction=1|bounce=1|margin=10|reload=1>
            <RText|id=2|x=0.0|y=0.0|color=250|size=16|text=<魔童哪吒(真身之体)/FCOLOR=253><-/FCOLOR=250>%s>
            <RText|id=3|x=0.0|y=0.0|color=250|size=16|text=<魔童哪吒(元神之体)/FCOLOR=253><-/FCOLOR=250>%s>
            <RText|id=4|x=0.0|y=0.0|color=250|size=16|text=<魔童哪吒(魔化之体)/FCOLOR=253><-/FCOLOR=250>%s>
            <RText|id=5|x=0.0|y=0.0|color=250|size=16|text=<魔童哪吒(狂暴之体)/FCOLOR=253><-/FCOLOR=250>%s>
        ]]
    end
    info = string.format(info, infoList[1], infoList[2], infoList[3], infoList[4], infoList[5], infoList[6], infoList[7], infoList[8], infoList[9], infoList[10], infoList[11], infoList[12])

    addbutton(actor, 110, "_123456", info)
end

function _lucktreasure_kfmap_mon() --#region 祥瑞宝藏跨服地图刷怪
    local mon_list = {"子鼠启运兽", "丑牛耕耘兽", "寅虎驱邪兽", "卯兔捣药兽", "辰龙赐福兽", "巳蛇蜕厄兽","午马奔腾兽","未羊护生兽","申猴闹春兽","酉鸡报喜兽","戌狗守岁兽","亥猪纳福兽",}
    for index, value in ipairs(mon_list) do
        if getmoncount("祥瑞迷宫合区", getdbmonfieldvalue(value, "idx"), true) < 1 then
            genmon("祥瑞迷宫合区",0,0,value,1000,1,249) --#region 刷怪
        end
    end
end