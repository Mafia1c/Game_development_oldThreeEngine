local LostAbyssNpc = {}
LostAbyssNpc.cfg = {
    [1] = {
        ["魔童降世碎片"] = 99,
    },
    [2] = {
        ["恶魔挑战卷"] = 9,
        ["龙之血"] = 9,
        ["龙之心"] = 9
    },
    [3] = {
        ["绑定灵符"] = 290,
        ["恶魔令"] = 3,
        ["魔童降世碎片"] = 1
    },
    [4] = {
        "0004", 20, 72
    },
    [5] = {
        "0002", 20, 72
    }
}
LostAbyssNpc.mon_config = {
	[1] = {
 		["key_name"]=1,
		["hequ_num"]=3,
		["boss1_arr"]={"撒旦·烛九阴","撒旦·黑无常","撒旦·变异骷髅","撒旦·形单影只","撒旦·冰封野人","撒旦·恶魔将军",},
		["coordinate1_arr"]={40,40,},
		["boss2_arr"]={"罗刹王·地府判官","罗刹王·青眼狐尸","罗刹王·骷髅鬼将","罗刹王·九世妖姬","罗刹王·血饮狂刀","罗刹王·暗夜修罗",},
		["coordinate2_arr"]={40,40,},
		["boss3_arr"]={"地狱恶魔·万奴王[真身]","地狱恶魔·阎罗王[真身]","地狱恶魔·骷髅王[真身]","地狱恶魔·骷髅王[真身]","地狱恶魔·舔狗王[真身]","地狱恶魔·雪人王[真身]","地狱恶魔·夜叉王[真身]",},
		["coordinate3_arr"]={40,40,},
		["boss4_arr"]={"魔童哪吒(真身之体)","魔童哪吒(元神之体)","魔童哪吒(魔化之体)","魔童哪吒(狂暴之体)",},
		["coordinate4_arr"]={40,40,},
		["map_arr"]={"真身之地","元神之地","魔化之地","狂暴之地",},
        ["weight"] = "1#500|2#250|3#150|4#100"
	},
	[2] = {
 		["key_name"]=2,
		["hequ_num"]=4,
		["boss1_arr"]={"神秘·巨镰金刚","诡异·地牢教主","厄运·混沌祭祀","禁忌·鲲鹏巨兽","怨恨·魔族骑士","罪恶·伏虎尊者",},
		["coordinate1_arr"]={40,40,},
		["boss2_arr"]={"修罗王·神秘海妖","修罗王·上古剑圣","修罗王·天蓬魔眼","修罗王·嗜血兽王","修罗王·麒麟将军","修罗王·幽冥厉鬼",},
		["coordinate2_arr"]={40,40,},
		["boss3_arr"]={"地狱魔神·神秘之主[真身]","地狱魔神·诡异之主[真身]","地狱魔神·厄运之主[真身]","地狱魔神·禁忌之主[真身]","地狱魔神·怨恨之主[真身]","地狱魔神·罪恶之主[真身]",},
		["coordinate3_arr"]={40,40,},
		["boss4_arr"]={"魔童哪吒(真身之体)","魔童哪吒(元神之体)","魔童哪吒(魔化之体)","魔童哪吒(狂暴之体)",},
		["coordinate4_arr"]={40,40,},
		["map_arr"]={"真身之地","元神之地","魔化之地","狂暴之地"},
		["weight"] = "1#500|2#250|3#150|4#100"
	},  
}
LostAbyssNpc.mon_count = 0

function LostAbyssNpc:enterMSZC(actor)
    local tq = VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL)
    if tq <= 0 then
        Sendmsg9(actor, "ffffff", "未开通终身特权!", 1)
        return
    end
    local count = getbagitemcount(actor, "黄金骰子", 0)
    if count <= 0 then
        Sendmsg9(actor, "ffffff", "需要黄金骰子*1!", 1)
        return
    end
    if not takeitem(actor, "黄金骰子", 1) then
        Sendmsg9(actor, "ffffff", "扣除失败!", 1)
        return
    end
    mapmove(actor, "迷失等待", 23, 31, 2)
    lualib:CloseNpcUi(actor, "LostCities2OBJ")
end

-- 1/2 进背包  3 进邮箱
function LostAbyssNpc:onClickViewBtn(actor, btn_id)
    btn_id = tonumber(btn_id)
    local _cfg = self.cfg[btn_id]
    local close_ui = false
    if btn_id == 1 then
        local count = getbagitemcount(actor, "魔童降世碎片", 0)
        local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_disguise"))
        if hastab == "" then hastab = {} end
        hastab["1"] = hastab["1"] or {}
        local need_count = 99
        local give_item = "魔童降世(限定装扮)"
        if not isInTable(hastab["1"], "魔童降世(限定装扮)") then            -- 没有
            need_count = 99
            give_item = "魔童降世(限定装扮)"
        else
            need_count = 3
            give_item = "恶魔令"
        end
        if count < need_count then
            Sendmsg9(actor, "ffffff", "魔童降世碎片不足!", 1)
            return
        end
        if not takeitem(actor, "魔童降世碎片", count) then
            Sendmsg9(actor, "ffffff", "扣除失败!", 1)
            return
        end
        giveitem(actor, give_item, 1, 338, "魔童降世碎片兑换")
    elseif btn_id == 2 then
        local count = VarApi.getPlayerJIntVar(actor, "J_exchange_eml_count")
        if count >= 3 then
            Sendmsg9(actor, "ffffff", "今日兑换次数已用完!", 1)
            return 
        end
        for k, v in pairs(_cfg) do
            local num = getbagitemcount(actor, k, 0)
            if num < v then
                Sendmsg9(actor, "ffffff", k.."不足!", 1)
                return
            end
        end
        for k, v in pairs(_cfg) do
            if not takeitem(actor, k, v) then
                Sendmsg9(actor, "ffffff", k.."扣除失败!", 1)
                return
            end
        end
        count = count + 1
        VarApi.setPlayerJIntVar(actor, "J_exchange_eml_count", count, true)
        lualib:FlushNpcUi(actor, "LostAbyssObj", "")
        giveitem(actor, "恶魔令", 1, 338, "消耗材料兑换恶魔令")
    elseif btn_id == 4 then
        local count = getbagitemcount(actor, "恶魔令", 0)
        if count <= 0 then
            Sendmsg9(actor, "ffffff", "恶魔令不足!", 1)
            return
        end
        if not takeitem(actor, "恶魔令", 1) then
            Sendmsg9(actor, "ffffff", "恶魔令扣除失败!", 1)
            return
        end
        self:enterMap(actor, _cfg[1], 1)
        close_ui = true
    elseif btn_id == 5 then
        messagebox(actor, "进入地图需要：恶魔令x2(根据队伍人数)\\地图挑战时长：30分钟\\说明：只能队长发起挑战\\是否确定进入深渊副本？", "@_on_ok_callback", "@_on_no_callback")
    else
        return
    end

    if close_ui then
        lualib:CloseNpcUi(actor, "LostAbyssObj")
    end
end

-- 进入地图
function LostAbyssNpc:enterMap(actor, map_id, enter_type)
    local merge_count = getsysvar(VarEngine.HeFuCount)
    local mon_cfg = LostAbyssNpc.mon_config[1]
    if merge_count > 3 then
        mon_cfg = LostAbyssNpc.mon_config[2]
    end
    local items = getWeightedCfg(mon_cfg["weight"])
    local ret = weightedRandom(items)
    local oldMapId  = map_id
    local newMapId  = map_id ..  "new" ..getbaseinfo(actor,2) --新地图
    local mapName   = mon_cfg.map_arr[ret.value] or mon_cfg.map_arr[4]
    local mapTime   = 1800   --地图持续时间    
    if checkmirrormap(newMapId) then
        delmirrormap(newMapId)
    end
    addmirrormap(oldMapId, newMapId, mapName, mapTime, "迷失等待", 1, 23, 33)
    LostAbyssNpc.mon_count = 0
    if enter_type == 1 then
        mapmove(actor, newMapId, 20, 72, 1)
    else
        groupmapmove(actor, newMapId, 20, 72, nil, 1)
    end
    self:updateMonster(newMapId)
    local str = "<Img|show=4|bg=1|img=custom/npc/73mszc/sy.png|esc=0|link=@Exit>"
    say(actor, str)
end

function LostAbyssNpc:updateMonster(map_id)
    if LostAbyssNpc.mon_count >= 4 then
        return
    end
    LostAbyssNpc.mon_count = LostAbyssNpc.mon_count + 1
    local merge_count = getsysvar(VarEngine.HeFuCount)
    local mon_cfg = LostAbyssNpc.mon_config[1]
    if merge_count > 3 then
        mon_cfg = LostAbyssNpc.mon_config[2]
    end
    local mon_key = string.format("boss%s_arr", LostAbyssNpc.mon_count)
    local mon_list = mon_cfg[mon_key]
    local index = math.random(#mon_list)
    local mon_name = mon_list[index]
    genmon(map_id, 40, 40, mon_name, 1, 1, 249)
end

function _on_ok_callback(actor)
    local team_member = getgroupmember(actor)
    if nil == team_member or #team_member < 2 then
        Sendmsg9(actor, "ffffff", "你还未组队或队伍人数少于2人!", 1)
        return
    end
    local team_count = #team_member
    if team_member[1] ~= actor then
        Sendmsg9(actor, "ffffff", "你不是队长!", 1)
        return
    end
    local cur_map_id = getbaseinfo(actor, 3)
    for k, member in pairs(team_member) do
        local map_id = getbaseinfo(member, 3)
        if cur_map_id ~= map_id then
            Sendmsg9(actor, "ffffff", "队员不在身边, 无法传送!", 1)
            return
        end
    end
    local count = getbagitemcount(actor, "恶魔令", 0)
    if count < team_count * 2 then
        Sendmsg9(actor, "ffffff", "恶魔令不足!", 1)
        return
    end
    if not takeitem(actor, "恶魔令", team_count * 2) then
        Sendmsg9(actor, "ffffff", "恶魔令扣除失败!", 1)
        return
    end
    local npc_class = IncludeNpcClass("LostAbyssNpc")
    if npc_class then
        npc_class:enterMap(actor, "0002", 0)
    end
end

function _on_no_callback(actor)
end

-- 点击购买  count: 1.购买一个   10.购买10个
function LostAbyssNpc:onClickBuyBtn(actor, count)
    count = tonumber(count)
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_emllb",count,"LostAbyssObj") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

return LostAbyssNpc