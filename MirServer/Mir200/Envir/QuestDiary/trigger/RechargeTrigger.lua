-- 充值触发
RechargeTrigger = {}
RechargeTrigger.cfg = { --#region 自定义充值首次赠送
    [10]="绑定灵符#10#307&秘宝礼盒#1#307&五彩石#50#307", [38]="绑定灵符#38#307&书页#100#307&战神兵符#1#307", [98]="绑定灵符#98#307&五彩石#100#307&横扫全服(称号)#1#307",
    [168]="绑定灵符#168#307&书页#200#307&绝品秘宝自选宝箱#1#307", [328]="绑定灵符#328#307&五彩石#500#307&孤品秘宝自选宝箱#1#307", [648]="绑定灵符#648#307&书页#500#307&斩尽天下不收刀(称号)#1#307",
}
RechargeTrigger.giftCfg = include("QuestDiary/config/rechargeGiftCfg.lua") --#region 礼包表

--#region 充值触发(玩家对象，充值金额，产品id，货币id，1=真充0=扶持，订单时间，实际到账货币金额，额外赠送金额，开启积分金额)
function RechargeTrigger.onRecharge(actor, Gold, ProductId, MoneyId, isReal, orderTime, rechargeAmount, giftAmount, refundAmount)
    if not actor or not Gold or Gold <= 0 then
        return Sendmsg9(actor, "ff0000", "非法请求", 1)
    elseif not MoneyId then
        return Sendmsg9(actor, "ff0000", "非法商品或货币ID", 1)
    elseif isReal ~= 0 and isReal ~= 1 then
        return Sendmsg9(actor, "ff0000", "非法充值类型", 1)
    elseif Gold < 0 or Gold > 200000 then
        return Sendmsg9(actor, "ff0000", "充值金额异常1", 1)
    end

    if MoneyId == 7 then --#region 自定义充值
        RechargeTrigger.custom(actor,Gold)
    elseif MoneyId == 10 then --#region 礼包
        RechargeTrigger.gift(actor,Gold)
    end

end

function RechargeTrigger.custom(actor,Gold,temp) --#region 自定义充值(玩家对象，充值金额,是否充值中心扣货币)
    local username = getbaseinfo(actor,1) --#region 玩家名称
    if not actor or not Gold or Gold <= 0 then
        return Sendmsg9(actor, "ff0000", "非法请求", 1)
    elseif tostring(type(Gold)) ~= "number" and Gold < 0 or Gold > 200000 then
        return Sendmsg9(actor, "ff0000", "充值金额异常2", 1)
    elseif temp ==1 and VarApi.getPlayerUIntVar(actor,"U_LcustomMoney") <= 0 then --#regon 充值中心 
        return Sendmsg9(actor, "ff0000", "充值金额异常3", 1)
    elseif temp ==1 and querymoney(actor,23) < Gold then
        return Sendmsg9(actor, "ff0000", "充值金额异常4", 1) --#region 充值中心
    end
    VarApi.setPlayerUIntVar(actor,"U_LcustomMoney",0,false)
    local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_zdy")) --#region 自定义金额有首次赠送
    if hastab == "" then hastab = {} end
    if RechargeTrigger.cfg[Gold] and not isInTable(hastab, Gold) then
        sendmail(getbaseinfo(actor,2),1,"在线充值","【"..Gold.."元首充礼包】首次充值奖励已经发放\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",RechargeTrigger.cfg[Gold])
        sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
        sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
        table.insert(hastab,Gold)
        hastab = tbl2json(hastab)
        VarApi.setPlayerTStrVar(actor,"TL_Recharge_zdy",hastab,true)
    end
    if not changemoney(actor,7,"+",Gold*10,"自定义充值送灵符",true) then
        return Sendmsg9(actor, "ff0000", "充值灵符到账失败！", 1)
    end

    if temp == 1 then --#region 充值中心调用扣直购
        changemoney(actor,23,"-",Gold,"充值中心自定义扣直购",true)
        lualib:CloseNpcUi(actor, "RechargeCenterOBJ")
    end

    VarApi.setPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE,VarApi.getPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE) + Gold,true)        -- 今日充值
    VarApi.setPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE, VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) + Gold,true)     -- 总充值
    changemoney(actor,11,"=",VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE),"灵符设置11货币总充值",true)
    lualib:FlushNpcUi(actor, "RechargeOBJ", "refresh")
end

function RechargeTrigger.gift(actor, Gold,temp) --#region 礼包赠送(玩家对象,充值金额,是否充值中心扣货币)
    local username = getbaseinfo(actor,1) --#region 玩家名称
    local giftTab = strsplit(VarApi.getPlayerTStrVar(actor, "TL_Recharge_gift"),"|") --#region 礼包名|次数|前端obj
    VarApi.setPlayerTStrVar(actor,"TL_Recharge_gift","",true)
    if giftTab == "" then
        return Sendmsg9(actor, "ff0000", "当前礼包信息非法请求", 1)
    elseif not RechargeTrigger.giftCfg[giftTab[1]] then
        return Sendmsg9(actor, "ff0000", "当前礼包信息非法请求", 1)
    elseif Gold ~= RechargeTrigger.giftCfg[giftTab[1]]["money"] * tonumber(giftTab[2]) then
        return Sendmsg9(actor, "ff0000", "当前礼包金额异常请求", 1)
    end
    --#region 发奖励邮件
    local emailTab = RechargeTrigger.giftCfg[giftTab[1]]["email_arr"]
    local emailItemStr = ""
    for i = 1, #RechargeTrigger.giftCfg[giftTab[1]]["reward_arr1"] do
        local infoTab = RechargeTrigger.giftCfg[giftTab[1]]
        emailItemStr = emailItemStr.."&"..infoTab["reward_arr1"][i].."#"..infoTab["reward_arr2"][i]*tonumber(giftTab[2]).."#307"
    end
    if giftTab[1] == "gift_xsfl1" then
        local limit_end_time = VarApi.getPlayerUIntVar(actor,"U_limit_effect_end_time")
        if limit_end_time - os.time() > 0 then
            emailItemStr = emailItemStr.."&".."战神盾牌#1"
        end
        VarApi.setPlayerUIntVar(actor,"U_limit_effect_end_time", os.time() + 1800)
    end
    if giftTab[1] == "gift_xsfl2" then
        local limit_end_time = VarApi.getPlayerUIntVar(actor,"U_limit_effect_end_time")
        if limit_end_time - os.time() > 0 then
            emailItemStr = emailItemStr.."&".."战神兵符#1"
        end
    end
    emailItemStr = emailItemStr:sub(2)
    Sendmsg9(actor, "ffffff", "购买成功，奖励已通过邮箱发送！", 1)
    sendmail(getbaseinfo(actor,2),1,emailTab[1],emailTab[2],emailItemStr)
    sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【"..RechargeTrigger.giftCfg[giftTab[1]]["typeText"].."】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
    sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【"..RechargeTrigger.giftCfg[giftTab[1]]["typeText"].."】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)

    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包 
    if hasGift == "" then hasGift = {} end
    if not hasGift[giftTab[1]] then
        hasGift[giftTab[1]] = 1
        local str = tbl2json(hasGift)
        VarApi.setPlayerTStrVar(actor,"TL_Recharge_hasGift",str,true)
    end
    --#region 特殊判断(首次或给予变量)
    local fucTab = {
        ["gift_cycf"] = function () --#region 首次充值苍月赐福
            local time = VarApi.getPlayerJIntVar(actor, "J_today_buy_cycf")
            VarApi.setPlayerJIntVar(actor,"J_today_buy_cycf",time+tonumber(giftTab[2]),true)
        end,
        ["gift_cycf1"] = function () --#region 非首次充值苍月赐福
            local time = VarApi.getPlayerJIntVar(actor, "J_today_buy_cycf")
            VarApi.setPlayerJIntVar(actor,"J_today_buy_cycf",time+tonumber(giftTab[2]),true)
            VarApi.setPlayerJIntVar(actor,"JL_cycf"..giftTab[2],1,true)
        end,
        ["gift_ggfd"] = function () --#region 黑市商人根骨福袋
            local time = VarApi.getPlayerJIntVar(actor,"JL_ggfd")
            VarApi.setPlayerJIntVar(actor,"JL_ggfd",time+tonumber(giftTab[2]),true)
            local hssr = VarApi.getPlayerJIntVar(actor, "J_today_buy_hssr")
            VarApi.setPlayerJIntVar(actor,"J_today_buy_hssr",hssr+tonumber(giftTab[2]),true) --#region 今日购买黑市商人次数
        end,
        ["gift_slfd"] = function () --#region 黑市商人神龙福袋
            local time = VarApi.getPlayerJIntVar(actor,"JL_slfd")
            VarApi.setPlayerJIntVar(actor,"JL_slfd",time+tonumber(giftTab[2]),true)
            local hssr = VarApi.getPlayerJIntVar(actor, "J_today_buy_hssr")
            VarApi.setPlayerJIntVar(actor,"J_today_buy_hssr",hssr+tonumber(giftTab[2]),true) --#region 今日购买黑市商人次数
        end,
        ["gift_fsfd"] = function () --#region 黑市商人飞升福袋
            local time = VarApi.getPlayerJIntVar(actor,"JL_fsfd")
            VarApi.setPlayerJIntVar(actor,"JL_fsfd",time+tonumber(giftTab[2]),true)
            local hssr = VarApi.getPlayerJIntVar(actor, "J_today_buy_hssr")
            VarApi.setPlayerJIntVar(actor,"J_today_buy_hssr",hssr+tonumber(giftTab[2]),true) --#region 今日购买黑市商人次数
        end,
        ["gift_dwfd"] = function () --#region 黑市商人帝王福袋
            local time = VarApi.getPlayerJIntVar(actor,"JL_dwfd")
            VarApi.setPlayerJIntVar(actor,"JL_dwfd",time+tonumber(giftTab[2]),true)
            local hssr = VarApi.getPlayerJIntVar(actor, "J_today_buy_hssr")
            VarApi.setPlayerJIntVar(actor,"J_today_buy_hssr",hssr+tonumber(giftTab[2]),true) --#region 今日购买黑市商人次数
        end,
        ["gift_lsfd"] = function () --#region 黑市商人龙神福袋
            local time = VarApi.getPlayerJIntVar(actor,"JL_lsfd")
            VarApi.setPlayerJIntVar(actor,"JL_lsfd",time+tonumber(giftTab[2]),true)
            local hssr = VarApi.getPlayerJIntVar(actor, "J_today_buy_hssr")
            VarApi.setPlayerJIntVar(actor,"J_today_buy_hssr",hssr+tonumber(giftTab[2]),true) --#region 今日购买黑市商人次数
        end,
        ["gift_fwfd"] = function () --#region 黑市商人符文福袋
            local time = VarApi.getPlayerJIntVar(actor,"JL_fwfd")
            VarApi.setPlayerJIntVar(actor,"JL_fwfd",time+tonumber(giftTab[2]),true)
            local hssr = VarApi.getPlayerJIntVar(actor, "J_today_buy_hssr")
            VarApi.setPlayerJIntVar(actor,"J_today_buy_hssr",hssr+tonumber(giftTab[2]),true) --#region 今日购买黑市商人次数
        end,
        ["gift_thlb"] = function(gift_index) --#region 特惠礼包
            local hefu_count = getsysvar(VarEngine.HeFuCount)
            --超过五合都是用五合的礼包 转换一下   
            if hefu_count >= 5 then
                gift_index = hefu_count .. (gift_index - 50)
            end
            local list = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_gift_thlb")) 
            if list == "" or list == nil then
                list = {}
            end
            list[tostring(gift_index)] = (list[tostring(gift_index)] or 0) + tonumber(giftTab[2])
            VarApi.setPlayerZStrVar(actor,"Z_gift_thlb",tbl2json(list),true)
        end,
        ["gift_zstq"] = function () --#region 终身特权
            confertitle(actor,"终身特权",1)
            VarApi.setPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL, 1, true) --#region 设置终身特权
        end,
        ["gift_mrlb"] = function () --#region 每日直购
            VarApi.setPlayerJIntVar(actor, VarIntDef.EverydayRecharge, 1, true) --#region 每日之后礼包
        end,
        ["gift_xsfl2"] = function()
            delbutton(actor, 103, 10005)
        end,
        ["gift_zdy10"] = function ()
            local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_zdy")) --#region 自定义金额有首次赠送
            if hastab == "" then hastab = {} end
            if RechargeTrigger.cfg[Gold] and not isInTable(hastab, Gold) then
                sendmail(getbaseinfo(actor,2),1,"在线充值","【"..Gold.."元首充礼包】首次充值奖励已经发放\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",RechargeTrigger.cfg[Gold])
                sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                table.insert(hastab,Gold)
                hastab = tbl2json(hastab)
                VarApi.setPlayerTStrVar(actor,"TL_Recharge_zdy",hastab,true)
            end
        end,
        ["gift_zdy38"] = function ()
            local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_zdy")) --#region 自定义金额有首次赠送
            if hastab == "" then hastab = {} end
            if RechargeTrigger.cfg[Gold] and not isInTable(hastab, Gold) then
                sendmail(getbaseinfo(actor,2),1,"在线充值","【"..Gold.."元首充礼包】首次充值奖励已经发放\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",RechargeTrigger.cfg[Gold])
                sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                table.insert(hastab,Gold)
                hastab = tbl2json(hastab)
                VarApi.setPlayerTStrVar(actor,"TL_Recharge_zdy",hastab,true)
            end
        end,
        ["gift_zdy98"] = function ()
            local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_zdy")) --#region 自定义金额有首次赠送
            if hastab == "" then hastab = {} end
            if RechargeTrigger.cfg[Gold] and not isInTable(hastab, Gold) then
                sendmail(getbaseinfo(actor,2),1,"在线充值","【"..Gold.."元首充礼包】首次充值奖励已经发放\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",RechargeTrigger.cfg[Gold])
                sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                table.insert(hastab,Gold)
                hastab = tbl2json(hastab)
                VarApi.setPlayerTStrVar(actor,"TL_Recharge_zdy",hastab,true)
            end
        end,
        ["gift_zdy168"] = function ()
            local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_zdy")) --#region 自定义金额有首次赠送
            if hastab == "" then hastab = {} end
            if RechargeTrigger.cfg[Gold] and not isInTable(hastab, Gold) then
                sendmail(getbaseinfo(actor,2),1,"在线充值","【"..Gold.."元首充礼包】首次充值奖励已经发放\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",RechargeTrigger.cfg[Gold])
                sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                table.insert(hastab,Gold)
                hastab = tbl2json(hastab)
                VarApi.setPlayerTStrVar(actor,"TL_Recharge_zdy",hastab,true)
            end
        end,
        ["gift_zdy328"] = function ()
            local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_zdy")) --#region 自定义金额有首次赠送
            if hastab == "" then hastab = {} end
            if RechargeTrigger.cfg[Gold] and not isInTable(hastab, Gold) then
                sendmail(getbaseinfo(actor,2),1,"在线充值","【"..Gold.."元首充礼包】首次充值奖励已经发放\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",RechargeTrigger.cfg[Gold])
                sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                table.insert(hastab,Gold)
                hastab = tbl2json(hastab)
                VarApi.setPlayerTStrVar(actor,"TL_Recharge_zdy",hastab,true)
            end
        end,
        ["gift_zdy648"] = function ()
            local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_zdy")) --#region 自定义金额有首次赠送
            if hastab == "" then hastab = {} end
            if RechargeTrigger.cfg[Gold] and not isInTable(hastab, Gold) then
                sendmail(getbaseinfo(actor,2),1,"在线充值","【"..Gold.."元首充礼包】首次充值奖励已经发放\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",RechargeTrigger.cfg[Gold])
                sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【"..Gold.."元首充礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
                table.insert(hastab,Gold)
                hastab = tbl2json(hastab)
                VarApi.setPlayerTStrVar(actor,"TL_Recharge_zdy",hastab,true)
            end
        end,
    }
    local gift_name = giftTab[1]
    local result = string.match(giftTab[1],"gift_thlb(.*)")
    if result ~= nil and result ~= "" then
        gift_name = "gift_thlb"
    end
    if fucTab[gift_name] then
        fucTab[gift_name](result)
    end

    if temp == 1 then --#region 充值中心调用扣直购
        changemoney(actor,23,"-",Gold,"充值中心"..giftTab[1].."礼包扣直购",true)
        lualib:CloseNpcUi(actor, "RechargeCenterOBJ")
    end

    VarApi.setPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE,VarApi.getPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE) + Gold,true)        -- 今日充值
    VarApi.setPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE, VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) + Gold,true)     -- 总充值
    changemoney(actor,11,"=",VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE),"礼包设置11货币总充值",true)

    local limit_end_time = VarApi.getPlayerUIntVar(actor,"U_limit_effect_end_time")
    limit_end_time = limit_end_time - os.time()
    if limit_end_time < 0 then
        limit_end_time = 0
    end    
    lualib:FlushNpcUi(actor, giftTab[3], "充值刷新#"..limit_end_time)
end