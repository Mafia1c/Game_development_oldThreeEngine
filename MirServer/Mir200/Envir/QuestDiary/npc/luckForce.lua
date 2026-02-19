local luckForce = {}
luckForce.itemCfg = "金刚石#3888#307&声望#200#307&黄金骰子#3#307&神灵石#8#307&灵石#8#307"

function luckForce:buyEvent1(actor) --#region 首次购买
    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
    if hasGift == "" then hasGift = {} end
    if hasGift["gift_wscf"] then
        return Sendmsg9(actor, "ff0000", "当前武圣赐福已购买过！", 1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_wscf",1,"luckForceOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

function luckForce:buyEvent2(actor) --#region 领取礼包
    local time = VarApi.getPlayerJIntVar(actor,"JL_luckForce")
    if time >= 1 then
        return Sendmsg9(actor,"ff0000","今日武圣赐福1次领取次数已用尽！",1)
    elseif VarApi.getPlayerUIntVar(actor,"UL_luckForceTimes") >= 30 then
        return Sendmsg9(actor,"ff0000","当前武圣赐福礼包领取天数已用尽！",1)
    end

    VarApi.setPlayerJIntVar(actor,"JL_luckForce",time+1,true)
    VarApi.setPlayerUIntVar(actor,"UL_luckForceTimes",VarApi.getPlayerUIntVar(actor,"UL_luckForceTimes")+1,true) --#region 累计领取次数
    local username = getbaseinfo(actor,1) --#region 玩家名称
    Sendmsg9(actor, "ffffff", "领取成功，奖励已通过邮箱发送！", 1)
    sendmail(getbaseinfo(actor,2),1,"武圣赐福","【武圣赐福每日礼包】奖励已经发放\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",self.itemCfg)
    sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【武圣赐福每日礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
    sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功领取了{【武圣赐福每日礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
    lualib:FlushNpcUi(actor, "luckForceOBJ", "refresh")
end


return luckForce