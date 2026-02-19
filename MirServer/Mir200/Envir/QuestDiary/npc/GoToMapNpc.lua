local mapNpc = {}
mapNpc.cfg = include("QuestDiary/config/mapMoveData.lua")
mapNpc.kf_map_id = {"zm_kf","jt_kf","sd_kf","fc_kf","mg_kf","jd_kf","sy_kf","4ldkf_1","4ldkf_2","4ldkf_3","4ldkf_4","4ldkf_5","4ldkf_6", "龙神之墓", "龙魂禁地",
"古老寺庙4", "永夜山谷3", "幽灵神舰6", "蛮荒禁地3", "迷惘洞窟4", "诅咒城堡6","卧龙祭坛"}
mapNpc.ahzc_cfg = include("QuestDiary/config/ahzcmonCfg.lua")

function mapNpc:click(actor, npc_id, msgStr)
    npc_id = tonumber(npc_id)
    local _cfg = self.cfg[npc_id]
    if isInTable({60, 91, 92}, npc_id) then
        _cfg = _cfg[1]
    end
    if _cfg then
        local merge_count = getsysvar(VarEngine.HeFuCount)       -- 合服次数
        local run_time = getsysvar(VarEngine.RunTime)
        local open_day = getsysvar(VarEngine.OpenDay)
        -- release_print("click npc ===== ", merge_count, open_day, _cfg.mapClose, npc_id, run_time)
        if _cfg.mapClose and _cfg.mapClose == 1 then                  -- 合区关闭
            if merge_count and merge_count > 0 then
                Sendmsg9(actor,"ffffff","该地图已关闭, 请前往新区体验!",1)
                return
            end
        elseif _cfg.mapClose and _cfg.mapClose > 1 then               -- 开启x天关闭
            if open_day >= _cfg.mapClose then
                Sendmsg9(actor,"ffffff","该地图已关闭, 请前往新区体验!",1)
                return
            end
        end
        local class_name = "MapTransmission1Obj"
        if isInTable({257,258,259,260,261,262}, npc_id) then
            class_name = "MapTransmission2Obj"
        elseif isInTable({371,372,373,374,375,376}, npc_id) then
            class_name = "MapTransmission3Obj"
            local hssr = VarApi.getPlayerJIntVar(actor, "J_today_buy_hssr")         -- 今日购买黑市商人
            local cycf = VarApi.getPlayerJIntVar(actor, "J_today_buy_cycf")         -- 今日购买苍月赐福

            npc_id = npc_id .. "#" .. hssr .. "#" .. cycf
        elseif isInTable({331,328,329,369,370}, npc_id) then
            class_name = "MapTransmission4Obj"
            if isInTable({328, 329, 331, 369}, npc_id) then
                
            else
                local count = VarApi.getPlayerUIntVar(actor,"U_wolong_open_count")
                npc_id = npc_id .. "#" .. count
            end
        elseif isInTable({330}, npc_id) then
            class_name = "MapTransmission5Obj"
        elseif isInTable({265,266,267,268,269,270}, npc_id) then
            class_name = "MapTransmission6Obj"
        elseif isInTable({275, 277,278,279,280,281,282, 284}, npc_id) then
            class_name = "MapTransmission7Obj"
        elseif isInTable({295, 296,297,298,299,300}, npc_id) then
            class_name = "MapTransmission8Obj"
        elseif isInTable({378, 379, 380, 381, 382, 383}, npc_id) then
            class_name = "MapTransmission9Obj"
        elseif isInTable({64,65,66,67,68,69,70,71}, npc_id) then
            map(actor, "zs_ydtg"..(npc_id - 62))
            return
        elseif isInTable({72,73,74,357,358,359,360,361,362,363,364,365,366,367,368}, npc_id) then
            map(actor, _cfg.mapId_arr[1])
            return
        elseif isInTable({403,406,411,394,396,401}, npc_id) then
            class_name = "MapTransmission10Obj"
            local tab = {403,406,411,394,396,401}               -- 这些地图限制次数
            local cfg_index = nil
            for k, v in pairs(tab) do
                if v == npc_id then
                    cfg_index = k
                    break
                end
            end
            local count_str = VarApi.getPlayerZStrVar(actor, "Z_map_join_count")
            if "" == count_str then
                count_str = {0,0,0,0,0,0}
            else
                count_str = json2tbl(count_str)
            end
            npc_id = npc_id .. "#"..count_str[cfg_index]
        elseif isInTable({392,393,395,397,398,399,400,402,404,405,407,408,409,410}, npc_id) then
            class_name = "MapTransmission11Obj"
        elseif isInTable({320,321,322,323,324}, npc_id) then
            local wddh_mon = getsysvar(VarEngine.WuDaoDaHuiBoss)
            local tmp_tab = strsplit(wddh_mon, "#")
            local name = ""
            for k, v in pairs({320,321,322,323,324}) do
                if npc_id == v then
                    name = tmp_tab[k] or ""
                    break
                end
            end
            npc_id = npc_id.."#"..name
            class_name = "MapTransmission12Obj"
        elseif npc_id == 263 then
            class_name = "ZhengMoTaOBJ"
            local level = VarApi.getPlayerUIntVar(actor, "U_zmt_challenge_level")
            npc_id = npc_id.."#"..level
        elseif npc_id == 377 then    
            local hand_in_num = VarApi.getPlayerJIntVar(actor, "J_yjcy_hand_in_num")
            if hand_in_num == 10 then
                npc_id = 1
            else
                npc_id = 0
            end
            class_name = "OtherDimensionOBJ"
        end
        lualib:ShowNpcUi(actor, class_name, npc_id)
        self._cur_class_name = class_name
    end
end

---地图传送
---@param actor string 玩家对象
---@param sMsg string 携带参数
function mapNpc:GotoMap(actor, sMsg, x, y)
    if nil == sMsg or sMsg == "" then
        return
    end
    local _tab = strsplit(sMsg, "|")
    local npc_id = tonumber(_tab[1])
    local npc_cfg = self.cfg[npc_id]
    if tonumber(_tab[3]) then
        npc_cfg = npc_cfg[tonumber(_tab[3])]
    end
    local level = getbaseinfo(actor, 6)                 -- 人物等级
    local zsLevel = getbaseinfo(actor, 39)              -- 人物转生等级
    local index = tonumber(_tab[2])                      -- 1.普通地图  2.高爆地图

    if nil == npc_cfg then
        return
    end
    local run_time = math.floor(getsysvar(VarEngine.RunTime)/60) 
    if npc_id == 319 then
        if run_time < 70 then
            return Sendmsg9(actor,"ffffff", "开区70分钟后开放",1)
        end
        if getsysvar(VarEngine.WuDaoDaHuiBossflag) > 0 then
            return Sendmsg9(actor,"ffffff", "新区仅开放一次",1)
        end
    end
    local merge_count = getsysvar(VarEngine.HeFuCount)       -- 合服次数
    if npc_id == 82 and merge_count <= 0 then
        Sendmsg9(actor,"ffffff", "合区后开启!!",1)
        return
    end
    if isInTable(self.kf_map_id, npc_cfg.mapId_arr[index]) and not checkkuafuconnect() then
        return Sendmsg9(actor, "ffffff", "跨服地图未连接!", 1)
    end

    if npc_cfg.needLevel and npc_cfg.needLevel > level then                   -- 等级不够
        Sendmsg9(actor,"ffffff","等级不足"..npc_cfg.needLevel.."级!",1)
        return
    end
    if npc_cfg.needZs and npc_cfg.needZs > zsLevel then                    -- 转生等级不够
        Sendmsg9(actor,"ffffff","转生等级不足"..npc_cfg.needZs.."转!",1)
        return
    end
    if type(npc_cfg.needItem_map) == "table" then       -- 需要道具
        for k, v in pairs(npc_cfg.needItem_map) do
            local item_id = getstditeminfo(k, 0)
            local value = getbindmoney(actor, k)
            if item_id > 100 then
                value = getbagitemcount(actor, k, 0)
            end            
            if v > value then
                Sendmsg9(actor,"ffffff", k.."数量不足!",1)
                return
            end
        end
    end

    if npc_cfg.needVar_map and type(npc_cfg.needVar_map) == "table" then
        if npc_id == 92 and tonumber(_tab[3]) > 1 then
            for k, list in pairs(npc_cfg.needVar_map) do
                for _k, _index in pairs(list) do
                    local equip = linkbodyitem(actor, _index)
                    local cur_level = getitemaddvalue(actor, equip, 2, 3, 0)
                    if cur_level < 15 then
                        Sendmsg9(actor,"ffffff", k, 1)
                        return
                    end
                end
            end
        elseif npc_id == 60 and tonumber(_tab[3]) == 4 then     -- 生肖    上古    传承
            for k, list in pairs(npc_cfg.needVar_map) do
                for _k, _index in pairs(list) do
                    local equip = linkbodyitem(actor, _index)
                    local name = getiteminfo(actor, equip, 7)
                    if equip == "0" then
                        Sendmsg9(actor,"ffffff", k, 1)
                        return
                    end
                    if string.find(name, "上古") ~= nil or string.find(name, "传承") ~= nil then
                    else
                        Sendmsg9(actor,"ffffff", k, 1)
                        return
                    end
                end
            end
        else
            for k, v in pairs(npc_cfg.needVar_map) do
                if VarApi.getPlayerUIntVar(actor, v[1]) < v[2] then
                    Sendmsg9(actor,"ffffff", k, 1)
                    return
                end
            end
        end
    end

    -- 检测装备佩戴     getstditeminfo(itemName, 2)     getposbystdmode(StdMode)
    local need_equip = npc_cfg.needEquip_map
    if type(need_equip) == "table" then
        if npc_id == 91 then
            local is_continue = false
            for k, list in ipairs(need_equip) do
                local count = 0
                for _k, v in pairs(list) do
                    local equip_index = getposbystdmode(getstditeminfo(v, 2))
                    local equip = linkbodyitem(actor, equip_index)
                    local name = getiteminfo(actor, equip, 7)
                    if isInTable(list, name) then
                        count = count + 1
                    end
                end
                if count >= 2 then
                    is_continue = true
                    break
                end
            end
            if not is_continue then
                return Sendmsg9(actor,"ffffff","请检查是否有佩戴要求装备!",1)
            end
        elseif npc_id == 90 then
            local count = 0
            for k, v in ipairs(need_equip) do
                local equip_index = getposbystdmode(getstditeminfo(v, 2))
                local equip = linkbodyitem(actor, equip_index)
                local name = getiteminfo(actor, equip, 7)
                if isInTable(need_equip, name) then
                    count = count + 1
                end
            end
            if count < 12 then
                return Sendmsg9(actor,"ffffff","需佩戴全套传承生肖!",1)
            end
        else
            for k, v in ipairs(need_equip) do
                local equip_index = getposbystdmode(getstditeminfo(v, 2))
                local equip = linkbodyitem(actor, equip_index)
                if equip == "0" then
                    return Sendmsg9(actor,"ffffff","请检查是否有佩戴要求装备!",1)
                end
                local name = getiteminfo(actor, equip, 7)
                if not isInTable(need_equip, name) then
                    return Sendmsg9(actor,"ffffff","请检查是否有佩戴要求装备!",1)
                end
                if npc_cfg.mapOpen and npc_cfg.mapOpen > 0 then
                    local _level = getitemaddvalue(actor, equip, 2, 3)
                    if _level < npc_cfg.mapOpen then
                        return Sendmsg9(actor,"ffffff","装备强化等级不足!",1)
                    end
                end
            end
        end
    end

    if npc_cfg.isOpenKB == 1 then                                 -- 是否开启狂暴
        local v = VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL)
        if v == 0 then
            Sendmsg9(actor,"ffffff","未开启狂暴!",1)
            return
        end
    end
        -- 高爆图
    if isInTable({371,372,373,374,375,376}, npc_id) then
        local hssr = VarApi.getPlayerJIntVar(actor, "J_today_buy_hssr")         -- 今日购买黑市商人
        local cycf = VarApi.getPlayerJIntVar(actor, "J_today_buy_cycf")         -- 今日购买苍月赐福
        if index == 2 then
            if cycf < 1 then
                return Sendmsg9(actor,"ffffff","进入高爆二层需要今日购买1次苍月赐福!",1)
            end
        else
            if hssr < 5 then
                return Sendmsg9(actor,"ffffff","进入高爆一层需要今日购买5次黑市商人!",1)
            end
        end
    end

    if index == 2 or npc_id == 75 then
        if npc_cfg.needGm == "终身特权" then                        -- 终身特权
            if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) == 0 then
                Sendmsg9(actor,"ffffff","未开启终身特权!!",1)
                return
            end
        end
        if npc_id ~= 75 and VarApi.getPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE) <= 0 then -- 今日充值金额
            Sendmsg9(actor,"ffffff","不满足进入条件, 今日充值金额为0!",1)
            return
        end
    end


    if type(npc_cfg.needItem_map) == "table" then       -- 扣除货币
        for k, v in pairs(npc_cfg.needItem_map) do
            local iten_id = getstditeminfo(k,0)
            if iten_id > 100 then
                if not takeitem(actor, k, v) then 
                    return Sendmsg9(actor,"ffffff", k.."扣除失败!", 1)
                end
            else
                if not consumebindmoney(actor, k, v, k.."扣除") then
                    return Sendmsg9(actor, "ffffff", k.."扣除失败！", 1)
                end
            end
        end
    end
    if npc_id == 319 then
        self:WDDHFlushMon(npc_id + 1)
    end

    self:onMapMove(actor, npc_cfg, index, x, y)
    if self._cur_class_name then
        lualib:CloseNpcUi(actor, self._cur_class_name)
    end
    self._cur_class_name = nil
end

-- 跳转地图
function mapNpc:onMapMove(actor, cfg, index, posx, posy)
    local mapId = cfg.mapId_arr[index]
    local x = tonumber(cfg.posx) or posx or 0
    local y = tonumber(cfg.posy) or posy or 0
    -- release_print("goto map ===== ", mapId, x, y, index)
    if x == 0 and y == 0 then
        map(actor, mapId)
    else
        mapmove(actor, mapId, x, y, 0)
    end
end

function mapNpc:GotoMap2(actor, mapName, x, y, reg)
    local map_names = {
        ["map_tc"] = {"3",330,330, 5},
        ["map_zy"] = {"zhuangyuan", 85, 93, 5},
        ["map_mlc"] = {"魔龙城", 122, 155, 5},
        ["map_bqcb"] = {"0", 331, 268, 5},
        ["map_fmsg"] = {"4", 237, 199, 5},
        ["map_yjzm"] = {"异界次元", 82, 81, 5},
        ["map_brm"] = {"11",181, 320, 5},
        ["map_cyd"] = {"苍月岛", 140, 334, 5},
        ["卧龙山庄"] = {"卧龙山庄", 71, 50, 5}
    }
    local map_mark = VarApi.getPlayerTStrVar(actor, "T_map_mark")
    map_mark = json2tbl(map_mark) or {}
    local cfg = map_names[mapName]
    if cfg then
        if isInTable({"魔龙城", "异界次元", "苍月岛", "4"}, cfg[1]) and ("" == map_mark or  not isInTable(map_mark, cfg[1])) then
            return Sendmsg9(actor, "ffffff", "地图未解锁, 需要手动进入一次!", 1)
        end
        if cfg[1] == "魔龙城" then
            if  VarApi.getPlayerJIntVar(actor, "J_molongcheng_in_num") >= 3 then
                cfg = map_names["map_mlc"]
            else
                cfg = map_names["map_cyd"]
            end
        end
        if cfg[1] == "异界次元" then
            if  VarApi.getPlayerJIntVar(actor, "J_yjcy_hand_in_num") >= 10 then
                cfg = map_names["map_yjzm"]
            else
                cfg = map_names["map_mlc"]
            end
        end
        if cfg[1] == "苍月岛" then
            return self:GotoMap3(actor, "")
        end
        if mapName == "卧龙山庄" then
            local merge_count = getsysvar(VarEngine.HeFuCount)
            if merge_count < 2 then
                Sendmsg9(actor, "ffffff", "两次合区开放！", 1)
                return
            end
        end
        mapmove(actor, cfg[1], x or cfg[2], y or cfg[3], reg or cfg[4])
    end
end

-- 传送苍月岛
function mapNpc:GotoMap3(actor, op_type)
    local sl_state = 1
    local equip = linkbodyitem(actor, 21)
    if "0" == equip then
        sl_state = 0
    end
    if op_type == "open" then
        lualib:ShowNpcUi(actor, "CangYueDaoOBJ", sl_state)
        return
    end
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count < 3 then
        return Sendmsg9(actor, "ffffff", " 三次合区才开启!", 1)
    end
    local reLevel = getbaseinfo(actor, 39)
    if reLevel < 10 then
        return Sendmsg9(actor, "ffffff", "转生等级不足10转!", 1)
    end
    if sl_state == 0 then
        return Sendmsg9(actor, "ffffff", "神龙之羽未激活!", 1)
    end
    lualib:CloseNpcUi(actor, "CangYueDaoOBJ")
    mapmove(actor, "苍月岛", 137, 333, 5)
end

-- 龙渊禁地 329   331 龙源地牢   369恶魔秘境
function mapNpc:GotoMap4(actor, npc_id)
    npc_id = tonumber(npc_id)
    local npc_cfg = self.cfg[npc_id]
    if isInTable(self.kf_map_id, npc_cfg.mapId_arr[1]) and not checkkuafuconnect() then
        return Sendmsg9(actor, "ffffff", "跨服地图未连接!", 1)
    end
    if npc_id == 370 then       -- 卧龙宝藏99次
        local count = VarApi.getPlayerUIntVar(actor,"U_wolong_open_count")
        if count < 99 then
            Sendmsg9(actor,"ffffff","不满足进入条件!",1)
            return
        end
    end

    local rate = 1
    if npc_id == 331 then
        if checktitle(actor, "卧龙1.1倍神力") then
            rate = 0.5
        end
    end

    if npc_cfg.isOpenKB == 1 then                                 -- 是否开启狂暴
        local v = VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL)
        if v == 0 then
            Sendmsg9(actor,"ffffff","未开启狂暴!",1)
            return
        end
    end

    if type(npc_cfg.needItem_map) == "table" then       -- 需要道具
        for k, v in pairs(npc_cfg.needItem_map) do
            local item_id = getstditeminfo(k, 0)
            local value = getbindmoney(actor, k)
            if item_id > 100 then
                value = getbagitemcount(actor, k, 0)
            end
            if v * rate > value then
                Sendmsg9(actor,"ffffff", k.."数量不足!",1)
                return
            end
        end
    end
   
    if isInTable({331,369,370}, npc_id) then
        for k, v in pairs(npc_cfg.needItem_map or {}) do
            if not takeitem(actor, k, v * rate) then
                return Sendmsg9(actor,"ffffff", k.."扣除失败!", 1)
            end
        end
        self:onMapMove(actor, npc_cfg, 1)

        if npc_id == 369 then
            local map_mon = {
                ["boss_arr"]={"巨魔·仙境真君","巨魔·神域武尊","巨魔·鬼蜮骑士","巨魔·峡谷先锋","巨魔·山庄头目","巨魔·神殿刀魔","巨魔·魔岛祭祀","巨魔·古镇法王","巨魔·石墓夜王","巨魔·遗迹牛魔","巨魔·洞窟炎魔","巨魔·祭坛神将","巨魔·幻境魔王","大魔王·仙境大将","大魔王·神域天君","大魔王·鬼蜮战神","大魔王·峡谷寨主","大魔王·山庄恶灵","大魔王·神殿刀圣","大魔王·魔岛剑灵","大魔王·古镇锤王","大魔王·石墓妖王","大魔王·遗迹妖妃","大魔王·洞窟狼王","大魔王·祭坛战神","大魔王·幻境死神","泰坦魔神·仙境天王","泰坦魔神·神域圣佛","泰坦魔神·鬼蜮神君","泰坦魔神·峡谷天王","泰坦魔神·山庄魔君","泰坦魔神·神殿修罗","泰坦魔神·魔岛女皇","泰坦魔神·古镇魔君","泰坦魔神·石墓君主","泰坦恶魔·遗迹圣君","泰坦恶魔·洞窟夜魔","泰坦恶魔·祭坛魔皇","泰坦恶魔·幻境夜神",},
                ["coordinate_arr"]={25,25},
            }
            local list = map_mon["boss_arr"]
            local pos = map_mon["coordinate_arr"]
            local idx = math.random(#list)
            genmon("guanka", pos[1], pos[2], list[idx], 3, 1, 249)
        end
    end

    -- 副本图
    if isInTable({330}, npc_id) then
        for k, v in pairs(npc_cfg.needItem_map or {}) do
            if not takeitem(actor, k, v * rate) then
                return Sendmsg9(actor,"ffffff", k.."扣除失败!", 1)
            end
        end

        self:onMapMove(actor, npc_cfg, 1)
        lualib:CloseNpcUi(actor, "MapTransmission5Obj")

        local mon = {
            ["monster_arr"]={"卧龙卫士(金)","卧龙卫士(木)","卧龙卫士(水)","卧龙卫士(火)","卧龙卫士(土)"},
            ["boss1_arr"]={"巨魔·仙境真君","巨魔·神域武尊","巨魔·鬼蜮骑士","巨魔·峡谷先锋","巨魔·山庄头目","巨魔·神殿刀魔","巨魔·魔岛祭祀","巨魔·古镇法王","巨魔·石墓夜王","巨魔·遗迹牛魔","巨魔·洞窟炎魔","巨魔·祭坛神将","巨魔·幻境魔王",},
            ["coordinate1_arr"]={222,166,},
            ["boss2_arr"]={"大魔王·仙境大将","大魔王·神域天君","大魔王·鬼蜮战神","大魔王·峡谷寨主","大魔王·山庄恶灵","大魔王·神殿刀圣","大魔王·魔岛剑灵","大魔王·古镇锤王","大魔王·石墓妖王","大魔王·遗迹妖妃","大魔王·洞窟狼王","大魔王·祭坛战神","大魔王·幻境死神",},
            ["coordinate2_arr"]={133,159,},
            ["boss3_arr"]={"泰坦魔神·仙境天王","泰坦魔神·神域圣佛","泰坦魔神·鬼蜮神君","泰坦魔神·峡谷天王","泰坦魔神·山庄魔君","泰坦魔神·神殿修罗","泰坦魔神·魔岛女皇","泰坦魔神·古镇魔君","泰坦魔神·石墓君主","泰坦恶魔·遗迹圣君","泰坦恶魔·洞窟夜魔","泰坦恶魔·祭坛魔皇","泰坦恶魔·幻境夜神",},
            ["coordinate3_arr"]={63,84,},
            ["boss4_arr"]={"【斩浪】卧龙守将","【青城】卧龙守将","【新月】卧龙守将","【御风】卧龙守将","【风云】卧龙守将",},
            ["coordinate4_arr"]={44,200,}, 
        }

        for i = 1, 4 do
            local list = mon["boss"..i.."_arr"]
            local pos = mon["coordinate"..i.."_arr"]
            local idx = math.random(#list)
            genmon("龙源秘境", pos[1], pos[2], list[idx], 3, 1, 249)
        end
        for k, v in pairs(mon["monster_arr"]) do
            genmon("龙源秘境", 0, 0, v, 1000, 100, 255)
        end
        return
    end
    -- 获取当前时间
    local currentTime = os.time()
    local timeTable = os.date("*t", currentTime)

    -- 武圣赐福     充值相关
    if npc_id == 328 then
        if checkkuafu(actor) then
            return Sendmsg9(actor,"ff0000","您已经在跨服地图！",1)
        end
        if getbaseinfo(actor, 36) == -1 or getbaseinfo(actor, 36) == "" then
            Sendmsg9(actor,"ffffff", "未加入行会!",1)
            return 
        end

        if timeTable.hour ~= 19 or timeTable.min > 20  then
            Sendmsg9(actor,"ffffff", "未开放!",1)
            return
        end
        local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
        if hasGift == "" then hasGift = {} end
        if not hasGift["gift_wscf"] then
            return Sendmsg9(actor,"ff0000","您还未激活武圣赐福，无法进入！",1)
        end
       
        KuaFuTrigger.bfbackcall(actor, "call_buff")
        self:onMapMove(actor, npc_cfg, 1)
    end

    if npc_id == 329 then
        if checkkuafu(actor) then
            return Sendmsg9(actor,"ff0000","您已经在跨服地图！",1)
        end
        local v = VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL)
        if v == 0 then
            Sendmsg9(actor,"ffffff","未开启狂暴!",1)
            return
        end        
        local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
        if hasGift == "" then hasGift = {} end
        if not hasGift["gift_wscf"] then
            return Sendmsg9(actor,"ff0000","您还未激活武圣赐福，无法进入！",1)
        end        
        -- 判断是否为偶数整点
        if timeTable.hour % 2 == 0 and timeTable.min < 10 then
            for k, v in pairs(npc_cfg.needItem_map or {}) do
                if not takeitem(actor, k, v) then
                    return Sendmsg9(actor,"ffffff", k.."扣除失败!", 1)
                end
            end
            KuaFuTrigger.bfbackcall(actor, "call_buff")
            self:onMapMove(actor, npc_cfg, 1)
        else
            Sendmsg9(actor,"ffffff", "未开放!",1)
            return
        end
    end

    if isInTable({328,329,331,369,370}, npc_id) then
        lualib:CloseNpcUi(actor, "MapTransmission4Obj")
    end
end

-- 龙源秘境合成  200书页   3张三倍秘境卷轴   1万金刚石
function mapNpc:onClickCompose(actor)
    local need_info = {
        ["书页"] = 200,
        ["三倍秘境卷轴"] = 3,
    }
    if type(need_info) == "table" then       -- 需要道具
        for k, v in pairs(need_info) do
            local item_id = getstditeminfo(k, 0)
            local value = getbindmoney(actor, item_id)
            if item_id > 100 then
                value = getbagitemcount(actor, k, 0)
            end
            if v > value then
                Sendmsg9(actor,"ffffff", k.."数量不足!",1)
                return
            end
        end
    end
    local jgs_value = getbindmoney(actor, "金刚石")
    if jgs_value < 10000 then
        return Sendmsg9(actor, "ffffff", "金刚石/绑定金刚石不足", 1)
    end

    for k, v in pairs(need_info) do
        if not takeitem(actor, k, v) then 
            return Sendmsg9(actor,"ff0000", k.."扣除失败!", 1)
        end
    end

    if not consumebindmoney(actor, "金刚石", 10000, "合成火龙珠金刚石扣除") then
        return Sendmsg9(actor,"ff0000", "扣除失败!", 1)
    end

    giveitem(actor, "火龙珠", 1)
    lualib:FlushNpcUi(actor, "MapTransmission5Obj", "")
end

-- 魔龙城
function mapNpc:GotoMap5(actor, npc_id)
    npc_id = tonumber(npc_id)
    local npc_cfg = self.cfg[npc_id]

    if npc_cfg.isOpenKB == 1 then                                 -- 是否开启狂暴
        local v = VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL)
        if v == 0 then
            Sendmsg9(actor,"ffffff","未开启狂暴!",1)
            return
        end
    end
    -- 合服次数
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count < 4 then
        return Sendmsg9(actor,"ffffff","四次合区才开启!",1)
    end
    local hand_in_num = VarApi.getPlayerJIntVar(actor, "J_molongcheng_in_num")
    if npc_id == 275 and  hand_in_num < 3 then
        local need_item = "恶魔挑战卷"
        local num = getbagitemcount(actor, need_item)
        if num < 3 then
            return Sendmsg9(actor, "ffffff", "恶魔挑战卷数量不足!", 1)
        end
        if not takeitem(actor, need_item, 3) then
            return Sendmsg9(actor, "ffffff", "恶魔挑战卷扣除失败!", 1)
        end
        VarApi.setPlayerJIntVar(actor, "J_molongcheng_in_num", 3,true)
        lualib:FlushNpcUi(actor,"MapTransmission7Obj")
        return
    end
    -- 陆地仙人
    local ldxr = VarApi.getPlayerUIntVar(actor, "UL_landGod")
    if ldxr ~= 1 then
        return Sendmsg9(actor,"ffffff","需要宗师境界达到陆地仙人才可进入!",1)
    end
    -- 霸王项羽时装
    local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_disguise"))
    if hastab == "" or (not hastab["1"]) or not isInTable(hastab["1"], "霸王项羽(SP装扮)") then
        return Sendmsg9(actor, "ffffff", "您还未激活霸王项羽时装!", 1)
    end 
    -- 人物转生等级
    local zsLevel = getbaseinfo(actor, 39)
    if zsLevel < 13 then
        return Sendmsg9(actor,"ffffff","转生等级不足13级!",1)
    end

    self:onMapMove(actor, npc_cfg, 1)
    lualib:CloseNpcUi(actor, "MapTransmission7Obj")
end

-- 点击暗黑之城NPC
function mapNpc:onClickAHZCNpc(actor, op_type)
    op_type = tonumber(op_type)
    local dateInfo = os.date("*t")
    local dayOfWeek = dateInfo.wday
    local hour = dateInfo.hour
    local min = dateInfo.min
    local map_state = 0
    if hour < 12 then
        map_state = 0
    else
        if dayOfWeek == 1 or dayOfWeek == 7 then        -- 周末
            if min < 10 then
                map_state = 1
            end
        else
            if hour % 2 == 0 and min < 10 then
                map_state = 1
            end
        end
    end
    if op_type == 0 then
        lualib:ShowNpcUi(actor, "AnHeiZhiChengOBJ", map_state)
    end
    return map_state
end
-- 暗黑之城传送
function mapNpc:GotoMap6(actor, map_id)
    if not checkkuafuconnect() then
        return Sendmsg9(actor, "ffffff", "跨服未连接!", 1)
    end
    if checkkuafu(actor) then
        lualib:CloseNpcUi(actor, "AHZCExtendOBJ")
        KuaFuTrigger.bfbackcall(actor, map_id, "")
        return
    end
    if isInTable({"暗黑之城2", "暗黑之城3", "暗黑之城4", "暗黑之城5", "暗黑之城6"}, map_id) then
        for i,v in ipairs( mapNpc.ahzc_cfg ) do
            if v.mapid == map_id and v.boss1_arr then
                for s,mon_name in ipairs(v.boss1_arr) do
                    local mon_count = getmoncount(map_id, getdbmonfieldvalue(mon_name, "idx"), true)
                    if mon_count > 0 then
                        Sendmsg9(actor, "ffffff", string.format("当前地图Boss未击杀, 击杀boss后可进入下一层!", mon_count), 1)
                        return
                    end
                end         
            end
        end
    end
    -- 开放状态
    local map_state = self:onClickAHZCNpc(actor, 1)
    if map_state == 0 then
        return Sendmsg9(actor,"ffffff","暂未开放或已结束!",1)
    end
    -- 陆地仙人
    local ldxr = VarApi.getPlayerUIntVar(actor, "UL_landGod")
    if ldxr ~= 1 then
        return Sendmsg9(actor,"ffffff","需要宗师境界达到陆地仙人才可进入!",1)
    end
    -- 人物转生等级
    local zsLevel = getbaseinfo(actor, 39)
    if zsLevel < 15 then
        return Sendmsg9(actor,"ffffff","转生等级不足15级!",1)
    end

    local need_item = "恶魔挑战卷"
    local value = getbagitemcount(actor, need_item, 0)
    if 3 > value then
        Sendmsg9(actor,"ffffff", need_item.."数量不足!",1)
        return
    end
    if not takeitem(actor, need_item, 3) then 
        return Sendmsg9(actor,"ffffff", need_item.."扣除失败!", 1)
    end

    KuaFuTrigger.bfbackcall(actor, "call_buff")
    lualib:CloseNpcUi(actor, "AnHeiZhiChengOBJ")
    map(actor, map_id)
end

function mapNpc:showAnHeiZhiChengReward(actor, map_id)
    if not isInTable({"暗黑之城1", "暗黑之城2", "暗黑之城3", "暗黑之城4", "暗黑之城5", "暗黑之城6"},  map_id) then
        return
    end
    local _cfg = nil
    for k, v in pairs(mapNpc.ahzc_cfg) do
        if v.mapid == map_id then
            _cfg = v
            break
        end
    end
    delbutton(actor, 110, "_123456")
    if _cfg then
        local info = [[
            <Text|x=30.0|y=10.0|color=243|size=16|text=《%s(跨服)》>
            <Text|x=40.0|y=38.0|color=250|size=16|text=当前地图爆出物品>
            <ItemShow|bgtype=1|x=0|y=120|itemid=%s|showtips=1>
            <ItemShow|bgtype=1|x=65|y=120|itemid=%s|showtips=1>
            <ItemShow|bgtype=1|x=135|y=120|itemid=%s|showtips=1>
            <ItemShow|bgtype=1|x=0|y=55|itemid=%s|showtips=1>
            <ItemShow|bgtype=1|x=65|y=55|itemid=%s|showtips=1>
            <ItemShow|bgtype=1|x=135|y=55|itemid=%s|showtips=1>
        ]]
        local tmp_ids = {}
        for k, v in pairs(_cfg.renwu_arr or {}) do
            tmp_ids[k] = getstditeminfo(v, 0)
        end
        info = string.format(info, map_id, tmp_ids[1] or 0, tmp_ids[2] or 0, tmp_ids[3] or 0, tmp_ids[4] or 0, tmp_ids[5] or 0, tmp_ids[6] or 0)
        addbutton(actor, 110, "_123456", info)
    end
end

function mapNpc:GotoMap7(actor, map_id)
    local map_cfg = {
        ["mryj2"] = {x = 205, y = 267},
        ["zs_hlxg2"] = {x = 26, y = 20},
        ["mryj2_jx"] = {x=253,y=219}
    }
    local pos = map_cfg[map_id]
    if pos then
        mapmove(actor, map_id, pos.x, pos.y, 1)
    else
        map(actor, map_id)
    end
end

-- 屠魔秘境
function mapNpc:GotoMapSlayer(actor, rate, index)
    release_print("GotoMapSlayer: ", actor)
    local chanese = {
        ["3"] = "三",
        ["5"] = "五",
        ["10"] = "十",
    }
    rate = chanese[rate] or rate
    local need_item = rate.."倍秘境卷轴"
    local value = getbagitemcount(actor, need_item, 0)
    if value <= 0 then
        return Sendmsg9(actor, "ffffff", "进入该秘境需要"..need_item.."!", 1)
    end
    local team_list = getgroupmember(actor)
    local op_type = 0
    local str = "当前挑战模式: 个人\\地图挑战时长: 30分钟\\是否确定进入"..rate.."倍屠魔秘境?"
    if nil ~= team_list then
        str = "当前挑战模式: 组队\\地图挑战时长: 30分钟\\说明: 只能队长发起挑战且队员在5格范围内\\是否确定进入"..rate.."倍屠魔秘境?"
        op_type = 1
    end
    messagebox(actor, str, "@_slayer_CallBack_ok,"..rate..","..op_type..","..index, "_slayer_CallBack_no")
end

function _slayer_CallBack_ok(actor, rate, op_type, index)
    index = tonumber(index)
    local team_list = getgroupmember(actor)
    local need_item = rate.."倍秘境卷轴"
    local tag = "个人"
    if op_type == "1" then
        tag = "组队"
        if team_list and team_list[1] ~= actor then
            return Sendmsg9(actor,"ffffff", "你不是队长!", 1)
        end
    end
    if not takeitem(actor, need_item, 1) then
        return Sendmsg9(actor,"ffffff", need_item.."扣除失败!", 1)
    end
    --地图
    local oldMapId  = "xdt125_4"
    local newMapId  = "xdt125_4" ..  getbaseinfo(actor,2)  --新地图
    local mapName   = string.format("%s倍秘境(%s)", rate, tag)
    local mapTime   = 1800   --地图持续时间
    local cfg = include("QuestDiary/config/SlayerMonCfg.lua")
    if cfg then
        cfg = cfg[index]
    else
        cfg = {}
    end
    --删除地图
    delmirrormap(newMapId)
    --创建镜像地图
    addmirrormap(oldMapId, newMapId, mapName, mapTime, 3, 1, 333, 333)
    --刷怪
    for key, value in pairs(cfg.monster_arr or {}) do     -- 小怪 100只
        genmon(newMapId, 148, 122, value, 500, 20)
    end
    if cfg.boss1_arr then
        local idx = math.random(1, #cfg.boss1_arr)
        local boss1_name = cfg.boss1_arr[idx]
        genmon(newMapId, cfg.coordinate1_arr[1], cfg.coordinate1_arr[2], boss1_name, 1000, 1)
    end
    if cfg.boss2_arr then
        local idx = math.random(1, #cfg.boss2_arr)
        local boss2_name = cfg.boss2_arr[idx]
        genmon(newMapId, cfg.coordinate2_arr[1], cfg.coordinate2_arr[2], boss2_name, 1000, 1)
    end
    if cfg.boss3_arr then
        local idx = math.random(1, #cfg.boss3_arr)
        local boss3_name = cfg.boss3_arr[idx]
        genmon(newMapId, cfg.coordinate3_arr[1], cfg.coordinate3_arr[2], boss3_name, 10, 1)
    end
    if cfg.bossmust then
        genmon(newMapId, cfg.coordinate4_arr[1], cfg.coordinate4_arr[2], cfg.bossmust, 10, 1)
    end

    if op_type == "1" then
        groupmapmove(actor, newMapId, 191, 183, nil, 5)
    else
        map(actor, newMapId)
    end
    -- 地图定时器存在
    if hasenvirtimer(newMapId, 54321) then
        setenvirofftimer(newMapId, 54321)
    end
    setenvirontimer(newMapId, 54321, 1, "@_slaye_map_jump,"..newMapId..",1")
    lualib:CloseNpcUi(actor, "SlayerRootOBJ")
end

function _slaye_map_jump(actor, map_id, value_type)
    local _type = tonumber(value_type)
    local remain_time = mirrormaptime(map_id)
    if remain_time <= 0 then
        if _type == 1 then
            setenvirofftimer(map_id, 54321)
            delmirrormap(map_id)
        elseif _type == 2 then
            setenvirofftimer(map_id, 12321)
            delmirrormap(map_id)
        end
        return
    end
end

-- 五大陆地图       join_type: 1.个人   2.跨服
function mapNpc:GotoWuMap(actor, npc_id, join_type)
    npc_id = tonumber(npc_id)
    join_type = tonumber(join_type)
    local npc_cfg = self.cfg[npc_id]
    local tab = {403,406,411,394,396,401}               -- 这些地图限制次数
    local cfg_index = nil
    for k, v in pairs(tab) do
        if v == npc_id then
            cfg_index = k
            break
        end
    end
    local map_id = npc_cfg.mapId_arr[join_type] or npc_cfg.mapId_arr[1]
    if isInTable(self.kf_map_id, map_id) and not checkkuafuconnect() then
        return Sendmsg9(actor, "ffffff", "跨服地图未连接!", 1)
    end
    local count_str = nil
    if nil ~= cfg_index and join_type == 1 then
        count_str = VarApi.getPlayerZStrVar(actor, "Z_map_join_count")
        if "" == count_str then
            count_str = {0,0,0,0,0,0}
        else
            count_str = json2tbl(count_str)
        end
        local count = tonumber(count_str[cfg_index])
        if count >= npc_cfg.numchallenge then
            return Sendmsg9(actor, "ffffff", "剩余挑战次数不足!",1)
        end
    end
    local need_item = npc_cfg.needItem2_map or npc_cfg.needItem_map
    if join_type == 2 then
        need_item = npc_cfg.needItem_map
    end
    for k, v in pairs(need_item) do
        local num = getbagitemcount(actor, k)
        if num < v then
            return Sendmsg9(actor, "ffffff", k.."数量不足!",1)
        end
    end
    for k, v in pairs(need_item) do
        if not takeitem(actor, k, v, 0, "传送地图扣除") then
            return Sendmsg9(actor, "ffffff", k.."扣除失败!",1)
        end
    end
    
    map(actor, map_id)
    if count_str and cfg_index then
        count_str[cfg_index] = tonumber(count_str[cfg_index]) + 1
        VarApi.setPlayerZStrVar(actor, "Z_map_join_count", tbl2json(count_str))
    end
    lualib:CloseNpcUi(actor, "MapTransmission10Obj")
    lualib:CloseNpcUi(actor, "MapTransmission11Obj")
end

-- 镇魔塔
function mapNpc:GotoZMTMap(actor, npc_id, join_type)
    npc_id = tonumber(npc_id)
    join_type = tonumber(join_type)
    local level = VarApi.getPlayerUIntVar(actor, "U_zmt_challenge_level")
    if level >= 100 and join_type == 1 then
        return Sendmsg9(actor, "ffffff", "个人挑战已全部通关, 请前往跨服挑战!",1)
    end
    if join_type == 2 and not checkkuafuconnect() then
        return Sendmsg9(actor, "ffffff", "跨服未连接!",1)
    end
    local cfg = self.cfg[npc_id]
    local join_map_id = cfg.mapId_arr[join_type]
    local need_item = cfg.needItem_map
    for k, v in pairs(need_item) do
        local num = getbagitemcount(actor, k)
        if num < v then
            return Sendmsg9(actor, "ffffff", k.."数量不足!",1)
        end
    end
    for k, v in pairs(need_item) do
        if not takeitem(actor, k, v, 0, "传送地图扣除") then
            return Sendmsg9(actor, "ffffff", k.."扣除失败!",1)
        end
    end
    level = level + 1
    local oldMapId  = join_map_id
    local newMapId  = join_map_id .. getbaseinfo(actor, 1) .. "_".. level
    local mapName   = string.format("镇魔塔%s层", level)
    local mapTime   = 3600
    if join_type == 1 then
        if checkmirrormap(newMapId) then
            --删除地图
            delmirrormap(newMapId)
        end
        --创建镜像地图
        addmirrormap(oldMapId, newMapId, mapName, mapTime, 3, 1, 333, 333)
        -- 镇魔塔初始1层100万血量，防御100-200，魔防100-200，攻击100-300。
        --血量每层增加100万，防御魔防增加10点，攻击增加5点。跨服刷新BOSS名为：
        --黑暗魔君，血量3000万，5%HP时只吃切割伤害，1%HP时，3*3范围内有非行会成员，BOSS触发无敌
        -- 刷怪 mon = genmon(newMapId, 24, 22, "黑暗魔君", 3, 1)
        local mon = genmon(newMapId, 24, 22, "魔界守卫", 3, 1, 249)
        -- setbaseinfo(mon, 10, hp)
        -- local attk1 = 100 + (level - 1) * 5
        -- local attk2 = 200 + (level - 1) * 5
        -- setbaseinfo(mon, 19, attk1)
        -- setbaseinfo(mon, 20, attk2)
        -- local def1 = 100 + (level - 1) * 10
        -- local def2 = 100 + (level - 1) * 10
        -- setbaseinfo(mon, 15, def1)
        -- setbaseinfo(mon, 16, def2)
        -- local m_def1 = 100 + (level - 1) * 10
        -- local m_def2 = 100 + (level - 1) * 10
        -- setbaseinfo(mon, 17, m_def1)
        -- setbaseinfo(mon, 18, m_def2)
        if mon then
            addbuff(mon[1], 50066, 0, level - 1)
            local hp = 1000000 * level
            setbaseinfo(mon[1], 9, hp)
        end
        map(actor, newMapId)
        if hasenvirtimer(newMapId, 12321) then
            setenvirofftimer(newMapId, 12321)
        end
        setenvirontimer(newMapId, 12321, 1, "@_slaye_map_jump,"..newMapId..",2")
    else
        map(actor, oldMapId)
    end
    lualib:CloseNpcUi(actor, "ZhengMoTaOBJ")
end

-- 帝王宝藏
function mapNpc:GotoDWBZMap(actor, npc_id)
    npc_id = tonumber(npc_id)
    local _cfg = self.cfg[npc_id]
    if nil == _cfg then
        return
    end
    local join_map = "tdfb"--_cfg.mapId_arr[1]
    local re_level = getbaseinfo(actor, 39)
    if re_level < 15 then
        return Sendmsg9(actor,"ffffff", "队伍成员转生等级不足15转!", 1)
    end
    
    local need_item = _cfg.needItem_map
    for k, v in pairs(need_item) do
        local num = getbagitemcount(actor, k)
        if num < v then
            return Sendmsg9(actor, "ffffff", k.."数量不足!",1)
        end
    end

    for k, v in pairs(need_item) do
        if not takeitem(actor, k, v, 0, "传送地图扣除") then
            return Sendmsg9(actor, "ffffff", k.."扣除失败!",1)
        end
    end

    local new_map_id = join_map .. getbaseinfo(actor, 2)
    if checkmirrormap(new_map_id) then
        delmirrormap(new_map_id)
    end
    addmirrormap(join_map, new_map_id, "帝王宝藏", 3600, 3, 1, 333, 333)
    mapmove(actor,new_map_id,20, 72,20)
    local mon_name = {"暗黑帝王(罗刹之体)", "暗黑帝王(修罗真身)"}
    local index = math.random(1, #mon_name)
    genmon(new_map_id, 51, 42, mon_name[index], 3, 1, 249)
    lualib:CloseNpcUi(actor, "ImperialTreasureOBJ")
end

-- 异界之门
function mapNpc:GotoYJZMMap(actor, npc_id, x, y)
    npc_id = tonumber(npc_id)
    local _cfg = self.cfg[npc_id]
    if nil == _cfg then
        return
    end
    local hand_in_num = VarApi.getPlayerJIntVar(actor, "J_yjcy_hand_in_num")
    if hand_in_num < 10 then
        local need_item = "恶魔挑战卷"
        local num = getbagitemcount(actor, need_item)
        if num < 10 then
            return Sendmsg9(actor, "ffffff", "恶魔挑战卷数量不足!", 1)
        end
        if not takeitem(actor, need_item, 10) then
            return Sendmsg9(actor, "ffffff", "恶魔挑战卷扣除失败!", 1)
        end
        lualib:FlushNpcUi(actor, "OtherDimensionOBJ", 1)
        VarApi.setPlayerJIntVar(actor, "J_yjcy_hand_in_num", 10)
        return
    end

    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count < 5 then
        return Sendmsg9(actor, "ffffff", "五次合区才开启!", 1)
    end
    local level = getbaseinfo(actor, 6)
    if level < 81 then
        return Sendmsg9(actor, "ffffff", "等级不足81级!", 1)
    end
    lualib:CloseNpcUi(actor,"OtherDimensionOBJ")
    mapmove(actor, "异界次元", x or 79, y or 79, 3)
end

-- 武道大会 ---
function mapNpc:GotoWDDHMap(actor, npc_id, op_type)
    npc_id = tonumber(npc_id)
    op_type = tonumber(op_type)
    local _cfg = self.cfg[npc_id]
    if nil == _cfg then
        return
    end
    if op_type == 1 then    -- 购买药剂
        local tips = "伽马药剂:\\价格:  灵符x99\\说明:  首刀斩杀本层boss90%血量\\说明:  只对使用药剂时的武道大会层数boss生效"
        messagebox(actor, tips, "@_on_buy_gamayaoji", "@_on__quxiao")
        return 
    end
    local map_id = getbaseinfo(actor, 3)
    local mon_count = getmoncount(map_id, -1, true)
    if mon_count > 0 then
        return Sendmsg9(actor, "ffffff", "当前boss未击杀!", 1)
    end

    if npc_id == 324 then
        local wddh_mon = getsysvar(VarEngine.WuDaoDaHuiBoss)
        local tmp_tab = {}
        if "" ~= wddh_mon then
            tmp_tab = strsplit(wddh_mon, "#")
        end
        local name = getbaseinfo(actor, 1)
        local kill_count = 0
        for k, v in pairs(tmp_tab) do
            if v == name then
                kill_count = kill_count + 1
            end
        end
        if kill_count < 5 or tonumber(tmp_tab[#tmp_tab]) == 111 then
            Sendmsg9(actor, "ffffff", "您不满足领取条件!", 1)
        else
            local center = "恭喜你成功领取武道大会通关奖励!\\您的活动奖励已经发放, 请查收!\\邮箱数据不定时清理, 为了保护您的权益, 请及时删除邮件!"
            local wuqi_name = {"天龙战刃", "天龙魔刃", "天龙道刃",}
            local index = getbaseinfo(actor,7) + 1
            local _name = wuqi_name[index]
            
            local reward = _name.."#1&惊喜魔盒#1&声望#200"
            sendmail(getbaseinfo(actor, 2), 1, "武道大会", center, reward)
            setsysvar(VarEngine.WuDaoDaHuiBoss, wddh_mon.."#111")
          
        end
    else
        self:WDDHFlushMon(npc_id + 1)
    end
    map(actor, _cfg.mapId_arr[1])
    lualib:CloseNpcUi(actor, "MapTransmission12Obj")
end
-- 武道大会刷怪
function mapNpc:WDDHFlushMon(npc_id)
    local index = npc_id - 319
    local map_id = "xin武道大会"..index
    local _cfg = self.cfg[npc_id]
    local mon_count = getmoncount(map_id, -1, true)
    local wddh_mon = getsysvar(VarEngine.WuDaoDaHuiBoss)
    local tmp_tab = {}
    if "" ~= wddh_mon then
        tmp_tab = strsplit(wddh_mon, "#")
    end
    local kill_mon_name = tmp_tab[index]
    if (kill_mon_name == "" or kill_mon_name == nil) and mon_count <= 0 then
        genmon(map_id, 16, 16, _cfg.thisboss, 3, 1, 249)
    end
end
function _on_buy_gamayaoji(actor)
    local lf_value = getbindmoney(actor, "灵符")
    if lf_value < 99 then
        return Sendmsg9(actor, "ffffff", "灵符/绑定灵符不足!", 1)
    end

    if not consumebindmoney(actor, "灵符", 99, "购买伽马药剂扣除") then
        return Sendmsg9(actor,"ff0000", "扣除失败!", 1)
    end
    giveitem(actor, "伽马药剂", 1)
end

local function _onKillPlayer(actor, killer)
    local map_id = getbaseinfo(actor, 3)
    if hasenvirtimer(map_id, 54321) then
        setenvirofftimer(map_id, 54321)
        delmirrormap(map_id)
    end
end
GameEvent.add("playdie", _onKillPlayer, "屠魔秘境")

return mapNpc
