KillmonTrigger = {}
KillmonTrigger.bossAwardCfg = include("QuestDiary/config/bossAwardCfg.lua")
KillmonTrigger.awakeRoad = include("QuestDiary/config/awakeRoadKillMonCfg.lua")
KillmonTrigger.cy_map_ids = {
    "蛮荒禁地1",
    "迷惘洞窟1",
    "诅咒城堡1",
    "古老寺庙1",
    "永夜山谷1",
    "幽灵神舰1",
    "古老寺庙2",
    "古老寺庙3",
    "dt138",
    "古老寺庙4",
    "永夜山谷2",
    "dyx01",
    "永夜山谷3",
    "幽灵神舰2",
    "幽灵神舰3",
    "幽灵神舰4",
    "幽灵神舰5",
    "dt079",
    "幽灵神舰6",
    "蛮荒禁地2",
    "dt097",
    "蛮荒禁地3",
    "迷惘洞窟2",
    "迷惘洞窟3",
    "dt068",
    "迷惘洞窟4",
    "诅咒城堡2",
    "诅咒城堡3",
    "诅咒城堡4",
    "诅咒城堡5",
    "dt062",
    "诅咒城堡6",
}
KillmonTrigger.monDropCfg = include("QuestDiary/config/monDropCfg.lua")

--#region 任意地图杀死怪物触发(攻击者对象，怪物对象，凶手类型[0=宝宝,1=英雄,2=人物,4=全局触发]，对象唯一id，怪物名称，当前地图编号)
function KillmonTrigger.onKillMon(actor, monObj,killerType,monId,monName,mapID)
    TaskTrigger.onKillAnyMon(actor, monObj)
    local buff_list = getallbuffid(actor)
    if checkkuafu(actor) then
        buff_list = {}
        local buff_str = VarApi.getPlayerTStrVar(actor, "T_kuafu_buff_info")
        local tmp_list = strsplit(buff_str, "#")
        if type(tmp_list) == "table" then
            for k, v in pairs(tmp_list) do
                buff_list[k] = tonumber(v)
            end
        end
    end
    if KillmonTrigger.bossAwardCfg[monName] then --#region boss悬赏
        local tab = VarApi.getPlayerTStrVar(actor,"l_bossAward")
        tab = json2tbl(tab)
        if tab == "" or next(tab) == nil then
            tab = {}
            tab[monName] = 1
            VarApi.setPlayerTStrVar(actor,"l_bossAward",tbl2json(tab),true)
        elseif not tab[monName] then
            tab[monName] = 1
            VarApi.setPlayerTStrVar(actor,"l_bossAward",tbl2json(tab),true)
        end
    end

    if  isInTable(buff_list,50025) then
        local rand_number = math.random(100) --#region 随机数
        if rand_number <= 1 then
            monitems(actor,1)
            sendattackeff(actor,126)
            sendmsg(actor, 1, '{"Msg":"BUFF【献祭】触发：怪物再爆一次！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        end
    end
     if isInTable(buff_list,50026) then
        local rand_number = math.random(100) --#region 随机数
        if rand_number <= 1 then
            sendattackeff(actor,124)
            changemoney(actor,4,"+",2000,"50026buff触发",true)
            sendmsg(actor, 1, '{"Msg":"BUFF【贪婪】触发：获得元宝*2000！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        end
    end

    if isInTable(buff_list,50030) and KillmonTrigger.yibian_baby ==nil then
        local rand_number = math.random(100) --#region 随机数
        if rand_number <= 1 then
            local mon_name = getbaseinfo(monObj,1)
            local pos_x = getbaseinfo(actor,4) 
            local pos_y = getbaseinfo(actor,5) 
            local mon =  genmon(mapID,pos_x,pos_y,mon_name,10,1)
            setmonmaster(mon[1],actor)
            sendattackeff(actor,127)
            KillmonTrigger.yibian_baby = mon[1]
            local str = string.format('{"Msg":"BUFF【异变】触发：将%s变为宝宝！","FColor":251,"BColor":0,"Type":6,"Time":1}',mon_name) 
            sendmsg(actor, 1, str)
        end
    end
    -- 次元地图杀怪
    if isInTable(KillmonTrigger.cy_map_ids,  mapID) then
        local fu_equip = linkbodyitem(actor, 9)
        local fu_str = getcustomitemprogressbar(actor, fu_equip, 0)
        local fu_tab = json2tbl(fu_str)
        if fu_tab.open == 1 then
            fu_tab.cur = tonumber(fu_tab.cur) + 1
            if fu_tab.cur > tonumber(fu_tab.max) then
                fu_tab.cur = fu_tab.max
            end
            setcustomitemprogressbar(actor, fu_equip, 0, tbl2json(fu_tab))
            refreshitem(actor, fu_equip)
        end

        local dun_equip = linkbodyitem(actor, 16)
        local dun_str = getcustomitemprogressbar(actor, dun_equip, 0)
        local dun_tab = json2tbl(dun_str)
        if dun_tab.open == 1 then
            dun_tab.cur = tonumber(dun_tab.cur) + 1
            if dun_tab.cur > tonumber(dun_tab.max) then
                dun_tab.cur = dun_tab.max
            end
            setcustomitemprogressbar(actor, dun_equip, 0, tbl2json(dun_tab))
            refreshitem(actor, dun_equip)
        end
    end

    local wlszBossTab = {["【斩浪】卧龙守将"]=1,["【青城】卧龙守将"]=2,["【新月】卧龙守将"]=3,["【御风】卧龙守将"]=4,["【风云】卧龙守将"]=5}
    if wlszBossTab[monName] and ( getsysvar(VarEngine["WlsxBossTime"..wlszBossTab[monName]])~=tonumber(os.date("%Y%m%d",os.time())) ) then --#region 卧龙山庄boss首杀奖励
        setsysvar(VarEngine["WlsxBossTime"..wlszBossTab[monName]],tonumber(os.date("%Y%m%d",os.time())) )
        changemoney(actor,21,"+",18888,"卧龙山庄"..monName.."首杀奖励",true)
    end
    --#region 觉醒之路(任务记录)
    if KillmonTrigger.awakeRoad[mapID] then
        local tempTab = json2tbl(VarApi.getPlayerTStrVar(actor,"TL_awakeRoad"))--#region 变量存储
        if tempTab == "" then;tempTab = {} end
        if not tempTab[tostring(KillmonTrigger.awakeRoad[mapID]["index"]).."1"] or tempTab[tostring(KillmonTrigger.awakeRoad[mapID]["index"]).."1"] < KillmonTrigger.awakeRoad[mapID]["number"] then
            local nextNumber = (tempTab[tostring(KillmonTrigger.awakeRoad[mapID]["index"]).."1"] or 0) +1
            tempTab[tostring(KillmonTrigger.awakeRoad[mapID]["index"]).."1"] = nextNumber
            tempTab = tbl2json(tempTab)
            VarApi.setPlayerTStrVar(actor,"TL_awakeRoad",tempTab,true)
            local msgTab = {
                ["Msg"] = "觉醒之路杀怪进度：".. nextNumber .."/"..KillmonTrigger.awakeRoad[mapID]["number"],
                ["FColor"] = 219,["BColor"] = 255,["Type"] = 8,
            }
            if getconst(actor,"<$CLIENTFLAG>") == "1" then
                msgTab = {
                    ["Msg"] = "觉醒之路杀怪进度：".. nextNumber .."/"..KillmonTrigger.awakeRoad[mapID]["number"],
                    ["FColor"] = 250,["BColor"] = 255,["Type"] = 8,
                }
            end
            sendmsg(actor, 1, tbl2json(msgTab))
        end
    end
    --#region 祥瑞迷宫任务面板刷新
    if mapID == "祥瑞迷宫新区" and not checkkuafuserver() then --#region 非跨服
        local players = getplaycount(mapID, 1, 1)
        if players == "0" then
        else
            for index, player in ipairs(type(players) == "table" and players or {}) do
                if IncludeNpcClass("luckTreasure") then
                    IncludeNpcClass("luckTreasure"):refreshTask(player) --#region 刷新祥瑞迷宫新区任务面板
                end
            end
        end
    elseif (mapID == "祥瑞迷宫合区" or mapID == "迷失之城") and checkkuafuserver() then --#region 跨服
        local players = getplaycount(mapID,1,1)
        if players == "0" then
        else
            for index, player in ipairs(type(players) == "table" and players or {}) do
                KuaFuTrigger.luckTreasureTaskInfo(player, mapID) --#region 刷新祥瑞迷宫跨服任务面板
            end
        end
    end

   if (string.find(mapID,"hdzc_kf")  or string.find(mapID,"tlzc_kf")) and checkkuafuserver() then --#region 跨服
        local players = getplaycount(mapID,1,1)
        if players == "0" then
        else
            for index, player in ipairs(type(players) == "table" and players or {}) do
                KuaFuTrigger.KfZCTaskInfo(player, mapID) 
            end
        end
    end

    local _mon_tab = {"铁锤", "双头恶魔", "冰猿帝王", "墨菲特", "策划老白"}
    if isInTable(_mon_tab,  monName) then
        local name = getbaseinfo(actor, 1)
        local wddh_mon = getsysvar(VarEngine.WuDaoDaHuiBoss)
        if nil == wddh_mon or "" == wddh_mon then
            wddh_mon = name
        else
            wddh_mon = wddh_mon .. "#" .. name
        end
        setsysvar(VarEngine.WuDaoDaHuiBoss, wddh_mon)
    end
    if monName == "策划老白" then
        setsysvar(VarEngine.WuDaoDaHuiBossflag, 1)
    end
    if monName == "魔界守卫" and checkmirrormap(mapID) then
        senddelaymsg(actor, "<%s秒后将自动离开地图!/FCOLOR=250>", 15, 255, 1, "@on_timer_callback")
    end
    if string.find(mapID,"hdzc_kf") or string.find(mapID,"tlzc_kf") then
        local player_list = getplaycount(mapID,1)
        local guid_name = getbaseinfo(actor,36)  
        if player_list ~= "0" then
            for k, v in pairs(player_list) do
                if getbaseinfo(v,36) == guid_name then
                    local userID = getbaseinfo(v, 2)
                    kfbackcall(1,userID,"kuafu_zc")
                end
            end
        end
        
    end

    -- 迷失地图击杀怪物
    -- release_print("击杀怪物 **** ", mapID)
    if (mapID == "0004new" or mapID == "0002new") then
        local npc_class = IncludeNpcClass("LostAbyssNpc")
        if npc_class then
            npc_class:updateMonster(mapID)
        end
    end

    if isInTable({"暗黑之城1", "暗黑之城2", "暗黑之城3", "暗黑之城4", "暗黑之城5", "暗黑之城6"},  mapID) then
        local mon_count = getmoncount(mapID, -1, true)
        local str = string.format("当前地图剩余怪物%s只!", mon_count)
        Sendmsg9(actor, "ffff00", str, 1)
    end
    local certainly_drop = json2tbl(VarApi.getPlayerTStrVar(actor,"T_set_target_drop_equip")) 
    if certainly_drop ~= "" then
        if monName == certainly_drop.monster_name then
            additemtodroplist(actor,monObj,certainly_drop.equip_list_str)
            VarApi.setPlayerTStrVar(actor,"T_set_target_drop_equip","")
        end
    end
    if string.find(mapID,"fjdt_kf")   then
        local npc_class = IncludeNpcClass("CrossRealmBattlefield")
        if npc_class then
            npc_class:KillMonSendAward(actor,mapID)
        end
    end
    if string.find(mapID,"sss11") then
        if  checkkuafu(actor)  and string.find(getbaseinfo(actor,3),"sss11") then
            local kill_hanghui = getbaseinfo(actor,36)
            local players = getplaycount(mapID,1,1)
            for index, player in ipairs(type(players) == "table" and players or {}) do
                local user_id = getbaseinfo(player,2)
                local hanghui_name = getbaseinfo(player,36)
                if kill_hanghui == hanghui_name then
                    local layer = string.sub(mapID, -1)
                    -- local time = VarApi.getPlayerJIntVar(player,"J_disguiseMapTime")
                    -- VarApi.setPlayerJIntVar(player,"J_disguiseMapTime",time+1,false)
                    kfbackcall(1,user_id,"disguise_map",layer)
                end
            end
        end
    end
    if isInTable({"异界★军团长·泰拉尔","异界★★虚空之主·卡赞","异界★★★恶魔使者·路西法","异界★★★★迷雾主宰·撒旦","异界★★★★★天空之神·宙斯"},monName) then
        local npc_class = IncludeNpcClass("AncientAlienWorld")
        if npc_class then
            npc_class:SetKillBossCount(actor,monName)
        end
    end
    
    KillmonTrigger.monDropJGS(actor, monObj, monName, mapID)
    KillmonTrigger.monDropItem(actor, monObj, monName, mapID)
    KillmonTrigger.TodayKillMonTask(actor, monObj, monName, mapID)
end


-- 怪物掉落金刚石 2025.10.12 新需求
function KillmonTrigger.monDropJGS(actor, monObj, monName, mapID)
    if KillmonTrigger.monDropCfg and KillmonTrigger.monDropCfg[monName] then
        local rand_number = math.random(100) --#region 随机数
        local rate = getsysvar(VarEngine.MonDropRate)
        if rate <= 0 then
            rate = 10
        end
        if rand_number <= rate then
            local x = getbaseinfo(monObj, 4)
            local y = getbaseinfo(monObj, 5)
            local weight = "1#100|2#50|3#10"
            local ret = weightedRandom(getWeightedCfg(weight))
            if ret then
                local index = ret.value
                local reward = {
                    [1] = {
                        ["5金刚石"] = 1,
                    },
                    [2] = {
                        ["10金刚石"] = 1,
                    },
                    [3] = {
                        ["10金刚石"] = 2,
                    },
                }
                local items = reward[index]
                local data = {
                    ["map"] =  mapID, --地图号
                    ["source"] =  5,  --来源：1-GM生成，2-NPC，3-商城，4-NPC商店, 5-怪物掉落，6-系统给["与，7-挖矿，8-批量生成，9-宝箱
                    ["mon"] = monName,  --掉落的怪物
                    ["player"] = getbaseinfo(actor, 1),
                }
                local itemList = gendropitem(mapID,actor, x, y, tbl2json(items), tbl2json(data), 5, 0)
            end
        end
    end
end
-- 衣服boss地图 or 武器boss地图必掉圣龙首饰
function KillmonTrigger.monDropItem(actor, monObj, monName, mapID)
    local drop_item = {"聖龍战盔","聖龍战链","聖龍战镯","聖龍战戒","聖龍战带","聖龍战靴","聖龍魔盔","聖龍魔链","聖龍魔镯","聖龍魔戒","聖龍魔带","聖龍魔靴","聖龍道盔","聖龍道链","聖龍道镯","聖龍道戒","聖龍道带","聖龍道靴"}
    if monName == "黄金泰坦巨人" or monName == "赤月老祖" then
        local x = getbaseinfo(monObj, 4)
        local y = getbaseinfo(monObj, 5)
        local index = math.random(#drop_item)
        local name = drop_item[index]
        local items = {
            [name] = 1
        }
        local data = {
            ["map"] =  mapID, --地图号
            ["source"] =  5,  --来源：1-GM生成，2-NPC，3-商城，4-NPC商店, 5-怪物掉落，6-系统给["与，7-挖矿，8-批量生成，9-宝箱
            ["mon"] = monName,  --掉落的怪物
            ["player"] = getbaseinfo(actor, 1),
        }
        local itemList = gendropitem(mapID,actor, x, y, tbl2json(items), tbl2json(data), 5, 0)
    end
end

-- 每日杀怪任务  隐藏任务
local kill_mon_reward = {
    [300] = "绑定金刚石#50&绑定元宝#10000",
    [500] = "绑定金刚石#100&绑定元宝#15000",
    [1000] = "绑定金刚石#150&绑定元宝#20000",
    [2000] = "绑定金刚石#200&绑定元宝#30000"
}
function KillmonTrigger.TodayKillMonTask(actor, monObj, monName, mapID)
    local kill_count = VarApi.getPlayerJIntVar(actor, "J_kill_mon_count")
    kill_count = kill_count + 1
    local reward = kill_mon_reward[kill_count]
    if reward then
        local str = string.format("恭喜完成每日隐藏任务, 击杀任意怪物: %s只", kill_count)
        sendmail(getbaseinfo(actor, 2), 1, "每日隐藏任务", str, reward)
        Sendmsg9(actor, "ffffff", str, 1)
    end

    VarApi.setPlayerJIntVar(actor, "J_kill_mon_count", kill_count, false)
end


function on_timer_callback(actor)
    mapmove(actor, "苍月岛", 140, 334, 3)
end