local OtherSysFunc = {}

-- 查看其他玩家信息     look_type:  1.查看专属装备   2.查看五行装备
function OtherSysFunc:lookPlayerInfo(actor, look_type)
    look_type = tonumber(look_type)
    local look_name = VarApi.getPlayerTStrVar(actor, "T_look_palyer_name")
    if "" == look_name then
        return
    end
    local player = getplayerbyname(look_name)
    if nil == player then
        return Sendmsg9(actor, "ffffff", "该玩家不在线!", 1)
    end
    local equip_index = {}
    local client_class_name = nil
    local sMsg = {}
    if look_type == 1 then
        equip_index = {87,88,89,90,91,92,93,94}
        client_class_name = "ExclusiveEquip_LookOBJ"
    elseif look_type == 2 then
        equip_index = {81, 82, 83, 84, 85}
        client_class_name = "WxzlEquip_LookOBJ"
    elseif look_type == 3 then --#region 魔戒
        equip_index = {100, 101, 102, 103}
        client_class_name = "magicRingEquip_LookOBJ"
    elseif look_type == 4 then --#region 福气装备
        equip_index = {104,105,106,107,108,109,110,111,112,113,114,115}
        client_class_name = "luckEquip_LookOBJ"
    elseif look_type == 5 then --#region 血脉
        client_class_name = "XueMai_LookOBJ"
        sMsg = {}
        sMsg.tianfu_data = json2tbl(VarApi.getPlayerTStrVar(player, VarStrDef.XMTF))
        sMsg.xuemai_data = json2tbl(VarApi.getPlayerTStrVar(player, "xuemaibuff"))
    elseif look_type == 6 then
        equip_index = {97,98,95,96,99}
        client_class_name = "DragonGodEquip_LookOBJ"
    elseif look_type == 7 then
        equip_index = {71,72,73,74,117,118,119,120}
        client_class_name = "FeiJian_LookObj"
    end
    for k, v in pairs(equip_index) do
        local equip = linkbodyitem(player, v)
        local equip_id = getiteminfo(player, equip, 1) or 0
        sMsg[k] = equip_id
    end
    if client_class_name then
        lualib:ShowNpcUi(actor, client_class_name, tbl2json(sMsg))
    end
end

function OtherSysFunc:onLoginGmGive(actor)
    if VarApi.getPlayerUIntVar(actor, "T_new_player_card") > 0 then
        return
    end    
    local source = 
    {
        ["map"] = getbaseinfo(actor, 3),
        ["source"] = 2,
        ["player"] = getbaseinfo(actor, 1),
        ["time"] = os.time()
    }
    source = tbl2json(source)

    local give_items = {
        [0] = {
            [1] = "炼狱",
            [2] = "祖玛勋章",
            [3] = "幽灵项链",
            [4] = "道士头盔",
            [5] = "死神手套",
            [6] = "死神手套",
            [7] = "龙之戒指",
            [8] = "龙之戒指",
            [9] = "祖玛兵符",
            [12] = "一星魔血石",
            [13] = "祖玛斗笠",
        },
        [1] = {
            [1] = "魔杖",
            [2] = "祖玛勋章",
            [3] = "生命项链",
            [4] = "道士头盔",
            [5] = "思贝儿手镯",
            [6] = "思贝儿手镯",
            [7] = "红宝石戒指",
            [8] = "红宝石戒指",
            [9] = "祖玛兵符",
            [12] = "一星魔血石",
            [13] = "祖玛斗笠",
        },
        [2] = {
            [1] = "银蛇",
            [2] = "祖玛勋章",
            [3] = "天珠项链",
            [4] = "道士头盔",
            [5] = "心灵手镯",
            [6] = "心灵手镯",
            [7] = "铂金戒指",
            [8] = "铂金戒指",
            [9] = "祖玛兵符",
            [12] = "一星魔血石",
            [13] = "祖玛斗笠",
        },
    }
    local yifu_equip = {
        [0] = {
            [0] = "重盔甲(男)",
            [1] = "重盔甲(女)"
        },
        [1] = {
            [0] = "魔法长袍(男)",
            [1] = "魔法长袍(女)"
        },
        [2] = {
            [0] = "灵魂战衣(男)",
            [1] = "灵魂战衣(女)"
        },
    }
    local job = getbaseinfo(actor, 7)
    local sex = getbaseinfo(actor, 8)
    local tmp_items = give_items[job]
    tmp_items[0] = yifu_equip[job][sex]
    for index, value in pairs(tmp_items) do
        giveonitem(actor, index, value, 1, 307)
        local equip = linkbodyitem(actor, index)
        setthrowitemly2(actor, equip, source)
    end
    TaskTrigger.onLoginGmGive(actor)
    lualib:CloseNpcUi(actor, "GmBaoZhangOBJ")
    VarApi.setPlayerUIntVar(actor, "T_new_player_card", 2, true)
    setontimer(actor, 977, 120, 1)
end

function ontimer977(actor)
    if VarApi.getPlayerUIntVar(actor, "T_new_player_card") == 1 then
        return
    end
    local email_item = {"祖玛兵符",  "祖玛斗笠",  "祖玛勋章",  "祖玛盾牌","新人体验卷","首充激活卡"}
    local item_str = ""
    for k, v in pairs(email_item) do
        item_str = item_str..v.."#1#307".."&"
    end
    sendmail(getbaseinfo(actor, 2), 1, "直播助力", "恭喜你, 成功获得直播助力!\\请查收道具!\\邮箱数据不定时清理, 为了保护您的权益. 请及时删除邮件!", item_str)
    VarApi.setPlayerUIntVar(actor, "T_new_player_card", 1, true)
end

function OtherSysFunc:onClickGetGmGive(actor)
    if VarApi.getPlayerUIntVar(actor, "T_new_player_card") == 1 then
        Sendmsg9(actor, "ffffff", "已发放!", 1)
        return
    end
    ontimer977(actor)
    lualib:FlushNpcUi(actor, "NewPlayerOBJ", "1")
end

-- 每日必看     兑换码 zs666
function OtherSysFunc:onClickBtn(actor, btn_type, sdk_code)
    if true then
        Sendmsg9(actor, "ffffff", "功能维护中, 敬请期待!", 1)
        return
    end
    local index = tonumber(sdk_code)
    btn_type = tonumber(btn_type)
    local state = tonumber(VarApi.getPlayerZStrVar(actor, "Z_one_day_look")) or 0
    if btn_type == 2 then
        if sdk_code ~= "zs666" then
            Sendmsg9(actor, "ffffff", "礼包码输入错误!", 1)
            return
        else
            if state ~= 0 then
                Sendmsg9(actor, "ffffff", "今日已兑换!", 1)
            else
                Sendmsg9(actor, "ffffff", "兑换成功!", 1)
                VarApi.setPlayerZStrVar(actor, "Z_one_day_look", 100)
            end
        end
        return
    end
    if state == 0 then
        Sendmsg9(actor, "ffffff", "请输入兑换码!", 1)
        return
    end

    if btn_type == 1 then           -- 每日抽取
        if (state % 100) >= 10 then
            Sendmsg9(actor, "ffffff", "今日已抽取!", 1)
            return
        end
        local list1 = {10, 25, 15, 35}
        local list2 = {10, 25, 15, 35}
        local index1 = math.random(4)
        local index2 = math.random(4)
        local attr1 = list1[index1]
        local attr2 = list2[index2]
        state = state + 10
        Sendmsg9(actor, "ffffff", "恭喜获得: 爆率+"..attr1.."%, 回收+"..attr2.."%", 1)

        VarApi.setPlayerJIntVar(actor, "J_add_attr_value", attr1)
        VarApi.setPlayerJIntVar(actor, "J_add_recycle_rate", attr2)
        self:addOneDayLookAttr(actor)
    end
    if btn_type == 3 then
        local remain_count = 3 - (state % 10)
        if remain_count <= 0 then
            Sendmsg9(actor, "ffffff", "今日已兑换完毕!", 1)
            return
        end
        local give_item_list = {
            {"五彩石", 10},
            {"书页", 10},
            {21, 100},
            {"上品聚灵珠", 1},
            {4, 50000},
            {15, 100},
            {"秘宝礼盒", 1},
            {"黄金骰子", 1},
        }
        local weight_str = "1#300|2#200|3#150|4#100|5#50|6#20|7#10|8#5"
        local tmp_list = getWeightedCfg(weight_str)
        local ret = weightedRandom(tmp_list)
        local reward = give_item_list[ret.value]
        if reward then
            local bag_count = getbagblank(actor)
            if bag_count < 5 then
                Sendmsg9(actor, "ffffff", "背包已满，请先确保背包内有足够空间！", 1)
                return
            end
            state = state + 1
            local name = reward[1]
            if type(reward[1]) == "number" then
                changemoney(actor, reward[1], "+", reward[2], "每日抽奖获得!", true)
                name = getstditeminfo(reward[1], 1)
            else
                giveitem(actor, reward[1], reward[2], 338, "每日抽奖获得!")
            end
            lualib:FlushNpcUi(actor, "OneDayLockOBJ", reward[1].."#"..reward[2].."#"..index)

            Sendmsg9(actor, "ffffff", "恭喜获得: "..name.."x"..reward[2], 1)
        end
    end
    VarApi.setPlayerZStrVar(actor, "Z_one_day_look", state)
end

function OtherSysFunc:addOneDayLookAttr(actor)
    -- 计算从当前时间到今晚12点的时间差（秒）
    local attr1 = VarApi.getPlayerJIntVar(actor, "J_add_attr_value")
    if attr1 ~= 0 then
        local currentHour = tonumber(os.date("%H"))
        local secondsToMidnight = (23 - currentHour) * 3600 + (59 - tonumber(os.date("%M"))) * 60 + (59 - tonumber(os.date("%S")))
        changehumnewvalue(actor, 65, attr1 * 100, secondsToMidnight)
    end
end

return OtherSysFunc