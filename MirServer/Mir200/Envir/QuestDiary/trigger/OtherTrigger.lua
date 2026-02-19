-- 一些杂七杂八的触发 写到这里
OtherTrigger = {}
OtherTrigger.CompoundItemCfg = include("QuestDiary/config/MakeItemsCfg.lua")

-- 玩家跳转地图触发
function OtherTrigger.onMapChange(actor, map_id, x, y)
    setplaydef(actor, "D0", 0)
    local map_name = getbaseinfo(actor, 45)         -- 地图名字
    if map_name == "乐见城" then
        local account_id = getconst(actor, "<$USERACCOUNT>")
        if getgmlevel(actor) < 10 or not isInTable(VarGmWhitePlayer, account_id) then
            map(actor,3)
            return sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>不是管理员！</font>","Type":9}')
        end
    end
    local cur_map_id = VarApi.getPlayerTStrVar(actor, "T_curr_map_id")       -- 玩家当前所在的地图id  (使用随机传送石时也会触发这个跳转地图触发)
    -- 命运之门地图反复横跳
    if string.find(cur_map_id, "my") and string.find(map_id, "my") and not isInTable({"mysd1", "mysd2"}, cur_map_id) and not isInTable({"mysd1", "mysd2"}, map_id) then
        local last_level = tonumber(string.match(cur_map_id, "%-?%d+%.?%d*"))       -- 切换地图前所在层数
        local cur_level = tonumber(string.match(map_id, "%-?%d+%.?%d*"))
        
        if cur_level > last_level and cur_level - last_level <= 6 then
        else
            Sendmsg9(actor, "ff0000", "数据异常警告!", 1)
            map(actor, 3)
            return
        end
    end
    if nil == string.find(cur_map_id, "my") and string.find(map_id, "my") then
        local cur_level = tonumber(string.match(map_id, "%-?%d+%.?%d*"))
        if cur_level ~= 1 then
            Sendmsg9(actor, "ff0000", "数据异常, 封号警告!", 1)
            map(actor, 3)
            return
        end
    end

    if checkmirrormap(map_id) then
        local mapTime = mirrormaptime(map_id)
        senddelaymsg(actor, "<剩余挑战时间: %s后将自动离开地图!/FCOLOR=250>", mapTime, 255, 1, "@_timer_callback_test")
    end

    if map_id == "hd_sbyb" then
        gotonow(actor, 280, 280)
    end
    -- 双倍押镖提示
    local mon = VarApi.getPlayerTStrVar(actor, "T_biaoche_mon")
    local time = tonumber(VarApi.getPlayerTStrVar(actor, "T_biaoche_get_time")) or 0 
    if mon ~= "" and time > 0 then
        local remain_time = time - getsysvar(VarEngine.RunTime)
        senddelaymsg(actor, "<剩余押镖时间: %s后将自动离开地图!/FCOLOR=250>", remain_time, 255, 1, "@_run_time_callback")
    end

    local auto_fight_map_ids = {"3", "zhuangyuan", "魔龙城", "0", "4", "异界次元", "11", "苍月岛", "卧龙山庄", "hd_tjcb",
    "hd_sbyb", "hd_cfgc", "hd_hhzb", "txzl", "hd_jqdb", "hd_ldzw", "hd_kbzb", "乐见城", "迷失等待"}
    if not isInTable(auto_fight_map_ids, map_id) then
        startautoattack(actor)
    end

    if (map_id == "龙源秘境" or map_id == "guanka") and cur_map_id ~= map_id then
        senddelaymsg(actor, "<剩余挑战时间: %s后将自动离开地图!/FCOLOR=250>", 3600, 255, 1, "@_timer_callback_test")
    end

    -- 地图有隐藏入口可以进入二大陆 这里做下判断
    local merge_count = getsysvar(VarEngine.HeFuCount)       -- 合服次数
    local gm_level = getgmlevel(actor)
    if map_id == "4" and merge_count <= 0 and gm_level ~= 10 then
        mapmove(actor, 3, 331, 331, 3)
        Sendmsg9(actor, "ffffff", "不满足进入条件!", 1)
        return
    end
    
    local reLevel = getbaseinfo(actor, 39)
    local sl_state = 1
    local equip = linkbodyitem(actor, 21)
    if "0" == equip then
        sl_state = 0
    end
    if map_id == "苍月岛" and (merge_count < 3 or reLevel < 10 or sl_state == 0 ) then
        mapmove(actor, 3, 331, 331, 3)
        Sendmsg9(actor, "ffffff", "不满足进入条件!", 1)
        return
    end
    local ldxr = VarApi.getPlayerUIntVar(actor, "UL_landGod")
     -- 霸王项羽时装
    local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_disguise"))
    if map_id == "魔龙城" and (merge_count < 4 or ldxr ~=1 or reLevel <13 or sl_state == 0 or hastab == "" or (not hastab["1"]) or not isInTable(hastab["1"], "霸王项羽(SP装扮)")) then
        mapmove(actor, 3, 331, 331, 3)
        Sendmsg9(actor, "ffffff", "不满足进入条件!", 1)
        return
    end
    -- 标记一下第一次进入二大陆地图
    if map_id == "4" and VarApi.getPlayerUIntVar(actor, "U_enter_tow_map") == 0 then
        VarApi.setPlayerUIntVar(actor, "U_enter_tow_map", 1, true)
        navigation(actor, 102, "_cifu", "点击领取!")
    end

    if string.find(map_name, "高爆") and cur_map_id ~= map_id then
        senddelaymsg(actor, "<将在%s秒后自动退出该地图!/FCOLOR=251>", 3600, 255, 1, "@_timer_callback_test2")
    end

    if map_id == "祥瑞迷宫新区" and not checkkuafu(actor) then --#region 非跨服祥瑞迷宫新区刷新任务面板
        if IncludeNpcClass("luckTreasure") then
            IncludeNpcClass("luckTreasure"):refreshTask(actor)
        end
    elseif (map_id == "祥瑞迷宫合区" or map_id == "迷失之城") and checkkuafu(actor) then --#region 跨服祥瑞迷宫刷新任务面板
        KuaFuTrigger.luckTreasureTaskInfo(actor,map_id)
    end
    if (string.find(map_id,"hdzc_kf")  or string.find(map_id,"tlzc_kf")) and checkkuafu(actor) then 
        KuaFuTrigger.KfZCTaskInfo(actor,map_id)
    end
    if (map_id == "0004new" or map_id == "0002new") and cur_map_id ~= map_id then
        senddelaymsg(actor, "<剩余挑战时间: %s后将自动离开地图!/FCOLOR=250>", 1800, 255, 1, "@_timer_callback_test2")
    end
    if map_id == "迷失之城" and cur_map_id ~= map_id then
        senddelaymsg(actor, "<剩余挑战时间: %s后将自动离开地图!/FCOLOR=250>", 1800, 255, 1, "@_timer_callback_test2")
    end
    
    if checkkuafu(actor) then
        local npc_class = IncludeNpcClass("GoToMapNpc")
        if npc_class then
            npc_class:showAnHeiZhiChengReward(actor, map_id)
        end
    end

    VarApi.setPlayerTStrVar(actor, "T_curr_map_id", map_id)

    local xu_hang_map_id = VarApi.getPlayerTStrVar(actor,"can_xunhang_map_id")
    if map_id == xu_hang_map_id then
        VarApi.setPlayerUIntVar(actor, "U_in_xunhang", 1, true)
    end
    --#region 巡航状态判断
    if not checkkuafu(actor) and map_id == "3" and VarApi.getPlayerUIntVar(actor, "U_in_xunhang") == 1 then
        OtherTrigger:XunHangRandomMap(actor,true)
    end
    if map_id=="4" and VarApi.getPlayerUIntVar(actor,"U_bigMap2")==0 then --#region 进入过大陆的标识
        VarApi.setPlayerUIntVar(actor,"U_bigMap2",1,true)
    elseif map_id=="苍月岛" and VarApi.getPlayerUIntVar(actor,"U_bigMap3")==0 then
        VarApi.setPlayerUIntVar(actor,"U_bigMap3",1,true)
    elseif map_id=="魔龙城" and VarApi.getPlayerUIntVar(actor,"U_bigMap4")==0 then
        VarApi.setPlayerUIntVar(actor,"U_bigMap4",1,true)
    elseif map_id=="异界次元" and VarApi.getPlayerUIntVar(actor,"U_bigMap5")==0 then
        VarApi.setPlayerUIntVar(actor,"U_bigMap5",1,true)
    end

    -- 地图足迹放最下面
    if isInTable({"魔龙城", "异界次元", "苍月岛", "4"}, map_id) then
        local map_mark = VarApi.getPlayerTStrVar(actor, "T_map_mark")
        if "" == map_mark then
            map_mark = {}
        else
            map_mark = json2tbl(map_mark)
        end
        if not isInTable(map_mark, map_id) then
            map_mark[#map_mark + 1] = map_id
        end
        VarApi.setPlayerTStrVar(actor, "T_map_mark", tbl2json(map_mark))
    end
end

function _timer_callback_test(actor)
    mapmove(actor, 3, 333, 333, 1)
end

function _timer_callback_test2(actor)
    mapmove(actor, 3, 333, 333, 1)
end

-- 离开地图触发
function OtherTrigger.onLeaveMapChange(actor, map_id, x, y)
    local name = getmapname(map_id)
    if checkmirrormap(map_id) then
        local map = "xdt129_7"
        if string.find(map_id, map) or string.find(name, "镇魔塔") then            -- 判断是否离开镇魔塔
            local _cfg = include("QuestDiary/config/ZhenmotaCfg.lua")
            local center_str = "恭喜你成功击杀%s层魔界守卫\\击杀奖励已发放,请查收\\\\邮箱数据不定时清理,为了保护您的权益,请及时删除邮件!"
            local level = string.match(name, "%-?%d+%.?%d*")
            level = tonumber(level) or level
            local mon_count = getmoncount(map_id, -1, true)
            if mon_count <= 0 then
                local cfg = _cfg[level]
                local reward_str = ""
                for k, v in pairs(cfg.giveitem_map) do
                    reward_str = reward_str .. k .. "#"  .. v .. "&"
                end
                sendmail(getbaseinfo(actor, 2), 1, "镇魔塔", string.format(center_str, level), reward_str)
                VarApi.setPlayerUIntVar(actor, "U_zmt_challenge_level", level)

                if cfg and cfg.title then
                    for key, v in pairs(_cfg) do
                        if v and v.title then
                            deprivetitle(actor, v.title)
                        end
                    end
                    confertitle(actor, cfg.title)
                end
            end
        end
        delmirrormap(map_id)
        setenvirofftimer(map_id, 12321)
    end

    if map_id == "龙源秘境" or map_id == "guanka" then
        killmonsters(map_id, "*", 0, false)
    end
    if map_id == "祥瑞迷宫新区" then
        delbutton(actor, 110, "_123456")
    end
end
function OtherTrigger:XunHangRandomMap(actor,is_show_tip)
    local cur_mapid = getbaseinfo(actor,3)
    local info = VarApi.getPlayerTStrVar(actor, "T_map_xun_hang")
    if info ~= nil or info ~= "" then
        local tab = strsplit(info, "#")
        local map_id = strsplit(tab[1], "|")
        local tmp_map = {}
        for k, v in pairs(map_id) do
            if v ~= "-1" and cur_mapid ~= v then
                tmp_map[#tmp_map + 1] = v
            end
        end
        local random = math.random(1, #tmp_map)
        local id = tmp_map[random]
        if is_show_tip and id ~= nil and id ~= "" then
            senddelaymsg(actor,"你将会在%s后返回巡航地图，关闭巡航后不再自动返回！",9,250,0)
            delaygoto(actor,9000,"StartAutoCallBack,"..id,0)
        else
            StartAutoCallBack(actor,id)
        end
    end
end

function StartAutoCallBack(actor,mapId)
    local is_xh = VarApi.getPlayerUIntVar(actor, "U_in_xunhang")
    local gotoMap = {} --#region npcId|高爆|page
    if is_xh ~= 1 then
        return
    end
    OtherTrigger.xunhang_condition(actor,mapId)
    -- if is_xh == 1 then
    --     map(actor, mapId)
    --     -- setontimer(actor, 120, 0.3, 1)
    -- end
end
function OtherTrigger.xunhang_condition(actor,mapId) --#region 巡航开启和到点判断条件
    local cfg = include("QuestDiary/config/mapMoveData.lua")
    local not_in_cfg = include("QuestDiary/config/prohibitXhMapCfg.lua")
    if isInTable(not_in_cfg, mapId) then
        Sendmsg9(actor, "ffffff", "跨服地图不可续航", 1)
        return 
    end
    if isInTable({ "mryj2", "zs_hlxg2", "mryj2_jx" },mapId) then
        if IncludeNpcClass("GoToMapNpc") then
            IncludeNpcClass("GoToMapNpc"):GotoMap7(actor, mapId)
        end
        return
    end
    if mapId == "龙之巢穴" then
        if IncludeNpcClass("GoToMapNpc") then
            IncludeNpcClass("GoToMapNpc"):GotoMap4(actor, 370)
        end        
        return
    end
    for key, value in pairs(cfg) do
        if tostring(type(value[1])) == "table" then
            for i, v in ipairs(value) do
                if v["mapId_arr"][1] == mapId then
                    if IncludeNpcClass("GoToMapNpc") then
                        IncludeNpcClass("GoToMapNpc"):GotoMap(actor, key .. "|1|"..i)
                    end
                    return
                elseif v["mapId_arr"][2] == mapId then
                    if IncludeNpcClass("GoToMapNpc") then
                        IncludeNpcClass("GoToMapNpc"):GotoMap(actor, key .. "|2|"..i)
                    end
                    return
                end
            end
        else
            if value["mapId_arr"][1] == mapId then
                if IncludeNpcClass("GoToMapNpc") then
                    IncludeNpcClass("GoToMapNpc"):GotoMap(actor,key.."|1")
                end
                return
            elseif value["mapId_arr"][2] == mapId then
                if IncludeNpcClass("GoToMapNpc") then
                    IncludeNpcClass("GoToMapNpc"):GotoMap(actor,key.."|2")
                end
                return
            end
        end
    end
end

-- function ontimer120(actor)
--     startautoattack(actor)
-- end
function OtherTrigger.onCompoundItem10000(actor, idx)
    idx = tonumber(idx)
    local cfg = OtherTrigger.CompoundItemCfg[idx]
    if nil == cfg then
        return
    end
    local need_money = strsplit(cfg.CYquantity, "#")
    local money_id = tonumber(need_money[1])
    local money_value = tonumber(need_money[2])
    local value = getbindmoney(actor, getstditeminfo(money_id, 1))
    if value <= money_value then
        Sendmsg9(actor, "ffffff", getstditeminfo(money_id, 1).."不足!", 1)
        return
    end

    local need_item_list = strsplit(cfg.material, "&")
    for i,v in ipairs(need_item_list) do
        local need_item = strsplit(v, "#")
        local item_id = tonumber(need_item[1])
        local item_value = tonumber(need_item[2])
        local name = getstditeminfo(item_id, 1)
        if getbagitemcount(actor, name) < item_value then
            Sendmsg9(actor, "ffffff", name.."不足!", 1)
            return
        end
        -- 扣除道具
        if not takeitem(actor, name, item_value) then
           return Sendmsg9(actor, "ffffff", name.."扣除失败!", 1)
        end
    end

    -- 扣除货币
    if not consumebindmoney(actor, getstditeminfo(money_id, 1), money_value, "合成扣除!") then
        return Sendmsg9(actor,"ff0000", "扣除失败!", 1)
    end

    -- 发放合成道具
    local give_item = strsplit(cfg.product, "#")
    giveitem(actor, getstditeminfo(tonumber(give_item[1]), 1), tonumber(give_item[2]))
    sendmsg(actor, 1, '{"Msg":"<font color=\'#'.."ffffff"..'\'>'..cfg.CGmessage..'</font>","Type":9}')
    local data_json = string.format('{"action":"event","data":{"recog":%s,"param1":%s}}',"-2",idx)
    sendactionofjson(actor, idx, data_json)
end


function OtherTrigger.onKillMon(actor, monObj,killerType,monId,monName,mapID)
    if VarApi.getPlayerUIntVar(actor, "U_in_xunhang") == 1 then
        local info = VarApi.getPlayerTStrVar(actor, "T_map_xun_hang")
        if info == nil or info == "" then
            info = "-1|-1|-1#0|1|0|0"
        end
        local tab = strsplit(info, "#")
         local state = strsplit(tab[2], "|")

        local cur_mapid = getbaseinfo(actor,3)
        local find_monster_cd =  VarApi.getPlayerUIntVar(actor, "U_xunhang_cd"..4)
        if getmoncount(cur_mapid,-1,true) <= 0 and  tonumber(state[4]) > 0 and os.time() - find_monster_cd > 60 then
            OtherTrigger:XunHangRandomMap(actor)
            VarApi.setPlayerUIntVar(actor, "U_xunhang_cd"..4,os.time())
        end
    end
end
function OtherTrigger.dropitemfrontex(actor, item,itemName,model)
    if itemName == "撒旦宝箱" then
        clearplayeffect(actor,20451)
        if hastimer(actor,60000) then
            setofftimer(actor, 60000)
        end
        if hastimer(actor,60001) then
            setofftimer(actor, 60001)
        end
    end
end
function ontimer50023(actor)
    local max_hp = getbaseinfo(actor,10)
    local cur_hp = getbaseinfo(actor,9)
    if cur_hp >= max_hp * 0.8 then
        setofftimer(actor,50023)
    else
        local lossPercent = (max_hp - cur_hp) / max_hp * 100
        local unitsLost = math.floor(lossPercent / 5)
        humanhp(actor,"+",cur_hp * (unitsLost/100),4)
    end
end
function ontimer50050(actor)
    local skill_list = getallskills(actor)
    for k, v in pairs(skill_list or {}) do
        skillrestcd(actor,v,0)
    end
end