local MainTopBtn = {}
MainTopBtn.cfg = include("QuestDiary/config/prohibitXhMapCfg.lua")
-- 接收客户端点击主界面top按钮
function MainTopBtn:onClickGameActivity(actor, formName)
    local sMsg = ""
    if formName == "GameActivityOBJ" then
        for i = 1, 8 do
            if sMsg == "" then
                sMsg =  ActivityMapLogic:GetActiveIsOpen(i)..""
            else
                sMsg = sMsg .. "#" ..  ActivityMapLogic:GetActiveIsOpen(i)
            end
        end
    elseif formName == "MapXunHangOBJ" then
        if checkkuafu(actor) then
            return Sendmsg9(actor, "ffffff", "跨服禁止使用", 1)
        end
        local info = VarApi.getPlayerTStrVar(actor, "T_map_xun_hang")
        if info == nil or info == "" then
            info = "-1|-1|-1#0|1|0|0"
        end
        local tab = strsplit(info, "#")
        local map_id = tab[1]
        local state = tab[2]
        if map_id then
            tab = strsplit(tab[1], "|")
        end
        local names = nil
        for k, v in pairs(tab) do
            local n = getmapname(v)
            if nil == n or "" == n then
                n = "未记录地图"
            end
            if names == nil then
                names = n
            else
                names = names .. "|" .. n
            end
        end
        sMsg = map_id .. "#" .. names .. "#" .. state
    elseif formName == "WelfareHallOBJ" then
        local class = IncludeNpcClass("WelfareHall")
        if class then 
            class:FlushSigleRedData(actor)
        end
        if VarApi.getPlayerUIntVar(actor, "U_navigation_task_step") == 1 then
            return class:upEvent(actor,0,5,true)
        else
            return class:upEvent(actor,0,1,true)
        end
    
    elseif formName == "CrossRealmBattlefieldOBJ" then
        local merge_num = getsysvar(VarEngine.HeFuCount)
        if merge_num == nil or merge_num < 1 then
            return Sendmsg9(actor, "ffffff", "跨服系统合区后开放！", 1)
        end
    elseif formName == "luckTreasureOBJ" then
        sMsg = getsysvar(VarEngine.luckTreasure)
    elseif formName == "OpenServerGiftObj" then
        local is_buy = VarApi.getPlayerUIntVar(actor,"U_open_server_gift")
        sMsg = is_buy
    elseif formName == "CrossShopObj" then 
        if not checkkuafuconnect() then
            return Sendmsg9(actor, "ff0000", "跨服未连接，等待开放！", 1)
        end
    end
    -- release_print("onClickGameActivity: " .. sMsg)
    lualib:ShowNpcUi(actor, formName, sMsg)
end

function MainTopBtn:onClickJumpTo(actor,id)
    openhyperlink(actor,tonumber(id))
end

-- ================================================================== 狂暴之力 start  ============================================================
function MainTopBtn:onClickOpenRage(actor, type)
    local item_id = 7
    local need_value = 40
    local name = "灵符"
    if type == "jgs" then
        item_id = 5
        need_value = 400
        name = "金刚石"
    end
    local value = querymoney(actor, item_id)
    if value >= need_value then
        if not changemoney(actor, item_id, "-", need_value, "_扣除"..name, true) then
            return Sendmsg9(actor, "ff0000", name.."扣除失败！", 1)
        end
        addbuff(actor, 50007)
        confertitle(actor, "宗师狂暴", 1)
        VarApi.setPlayerUIntVar(actor, VarIntDef.KB_LEVEL, item_id)
        local str = "玩家["..getbaseinfo(actor, 1).."]".."开启宗师狂暴, 请大家小心此人物!"
        local sJson = '{"Msg":"' .. str .. '","FColor":' .. 255 .. ',"BColor":' .. 249 .. ',"Type":1' ..'}'
        sendmsg(actor, 2, sJson)
        if item_id == 7 then
            changemoney(actor, 15, "+", 10, "灵符开启狂暴赠送10点声望", true)
        end
    else
        return Sendmsg9(actor, "ff0000", name.."数量不足", 1)
    end
end

local function _onKillPlayer(actor, killer)
    local map_ids = {"0150", "3", "hd_jqdb", "hd_ldzw"}
    if not getbaseinfo(killer, -1) then
        -- 非玩家击杀
        return
    end
    local mapId = getbaseinfo(actor, 3)
    if isInTable(map_ids, mapId) then
        return
    end
    if getbaseinfo(actor, 60) then
        return
    end
    local money_id = VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL)
    if hasbuff(actor, 50007) or money_id > 0 then          -- 变量 buff二选一
        delbuff(actor, 50007)
        deprivetitle(actor, "宗师狂暴")
        local reward = {
            [5] = 200,
            [7] = 20
        }
        changemoney(killer, money_id, "+", reward[money_id], "_加钱!", true)
        VarApi.setPlayerUIntVar(actor, VarIntDef.KB_LEVEL, 0)
        local count = getsysvar(VarEngine.KuangBaoDieCount)
        count = count + 1
        if count >= 99 then
            local activity_state_map = json2tbl(getsysvar(VarEngine.ActivityState))
            if activity_state_map == "" then
                activity_state_map = {}
            end
            if activity_state_map["狂暴争霸1"] and tonumber(activity_state_map["狂暴争霸1"]) ~= 1 then
                ActivityMgr:SetSpecialActiveState("狂暴争霸1", true)
            end
            count = 0
        end
        setsysvar(VarEngine.KuangBaoDieCount, count)
    end
end

GameEvent.add("playdie", _onKillPlayer, "狂暴之力")


function MainTopBtn:GetGameActiveRed(actor)
    for i = 1, 8 do
        if tonumber(ActivityMapLogic:GetActiveIsOpen(i)) == 1 then
           return 1 
        end
    end
    return 0
end
-- ================================================================== 挂机巡航 start  ============================================================
function MainTopBtn:onClickStartXunHang(actor, mapId, states)
    release_print("开始挂机************",getbaseinfo(actor,1), mapId, states)
    local map_ids = strsplit(mapId, "|")
    local s = strsplit(states, "|")             --　勾选状态
    local tmp_map = {}
    for k, v in pairs(map_ids) do
        if v ~= "-1" then
            tmp_map[#tmp_map + 1] = v
        end
    end
    local is_xh = VarApi.getPlayerUIntVar(actor, "U_in_xunhang")
    if #tmp_map > 0 and is_xh ~= 1 then
        if isInTable(self.cfg, mapId) then
            return Sendmsg9(actor,"ffffff","该地图禁止使用巡航!", 1)
        end
        local map_id = getbaseinfo(actor, 3)
        if isInTable(tmp_map, map_id) then
            startautoattack(actor)
            VarApi.setPlayerUIntVar(actor, "U_in_xunhang", 1, true)
        else
            local random = math.random(1, #tmp_map)
            local id_map = tmp_map[random]
            VarApi.setPlayerTStrVar(actor, "can_xunhang_map_id", id_map)
            OtherTrigger.xunhang_condition(actor,id_map)
            -- map(actor, id_map)
            delaygoto(actor,2000,"clear_xunhang_map_id",0)
        end
        -- setontimer(actor, 120, 0.3, 1)
    end
    if is_xh == 1 then
        VarApi.setPlayerUIntVar(actor, "U_in_xunhang", 0, true)
        stopautoattack(actor)
    end
end

function clear_xunhang_map_id(actor)
    VarApi.setPlayerTStrVar(actor, "can_xunhang_map_id", 0)
end

function MainTopBtn:onSelectXunHangMap(actor, mapId)
    if isInTable(self.cfg, mapId) then
        Sendmsg9(actor,"ffffff","该地图禁止使用巡航!", 1)
    end
end

function MainTopBtn:onRecordXunHangInfo(actor, mapId, state)
    VarApi.setPlayerTStrVar(actor, "T_map_xun_hang", mapId .. "#" .. state, false)
end

-- =================================================================== 首充豪礼 =======================================================================
function MainTopBtn:onGetRechargeReward(actor)
    if VarApi.getPlayerUIntVar(actor, VarIntDef.FirstRecharge) ~= 0 then
        Sendmsg9(actor, "ffffff", "你已领取首充豪礼!!", 1)
        return
    end
    local money_num = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    local count = getbagitemcount(actor, "首充激活卡")
    if count > 0 and money_num <= 0 then
        messagebox(actor, "系统检测到你拥有首充激活卡\\点击确定可免费激活首充", "@_on_get_recharge_reward", "@_____on_callback")
        return
    end
    if money_num <= 0 then
        -- lualib:ShowNpcUi(actor, "RechargeOBJ", "")
        lualib:CloseNpcUi(actor,"FirstRechargeRewardOBJ")
        local class = IncludeNpcClass("WelfareHall")
        if class then 
            class:FlushSigleRedData(actor)
        end
        class:openLimitView(actor)
        return
    end

    __givefirstreward(actor)
end

function _on_get_recharge_reward(actor)
    local level = getbaseinfo(actor, 6)
    if level < 50 then
        Sendmsg9(actor, "ffffff", "首充激活卡需要达到50级时可以使用!", 1)
        return
    end
    local count = getbagitemcount(actor, "首充激活卡")
    if not takeitem(actor, "首充激活卡", count) then
        Sendmsg9(actor, "ffffff", "充值任意金额, 即可领取首充豪礼!", 1)
        return
    end
    __givefirstreward(actor)
end
function _____on_callback(actor)  
end

function __givefirstreward(actor)
    local reward_list = {"五星魔血石", "幸运小红剑", "10万元宝", "1000声望", "三倍经验卷(30分钟)"}
    local job = getbaseinfo(actor, 7)
    local skill_book = "开天斩"
    if job == 0 then
        skill_book = "开天斩"
    elseif job == 1 then
        skill_book = "流星火雨"
    elseif job == 2 then
        skill_book = "召唤月灵"
    end
    reward_list[#reward_list + 1] = skill_book    
    for k, v in pairs(reward_list) do
        giveitem(actor, v, 1, 338)
    end
    VarApi.setPlayerUIntVar(actor, VarIntDef.FirstRecharge, 1, true)
    lualib:FlushNpcUi(actor, "FirstRechargeRewardOBJ", 1)
    confertitle(actor, "首充玩家", 1)    
end

return MainTopBtn