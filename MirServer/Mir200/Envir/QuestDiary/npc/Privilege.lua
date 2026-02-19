local Privilege = {}

function Privilege:buyEvent(actor) --#region 购买
    if VarApi.getPlayerUIntVar(actor,VarIntDef.ZSTQ_LEVEL) > 0 then
        return Sendmsg9(actor, "ff0000", "您已拥有终身特权！", 1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_zstq",1,"PrivilegeOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

function Privilege:today(actor) --#region 今日特权
    local time = VarApi.getPlayerJIntVar(actor, "J_today_zstq")
    if time > 0 then
        return Sendmsg9(actor, "ff0000", "今日特权福利已领取过！", 1)
    end
    local username = getbaseinfo(actor,1) --#region 玩家名称
    VarApi.setPlayerJIntVar(actor, "J_today_zstq", 1, true) --#region 今日领取特权标记
    sendmail(getbaseinfo(actor,2),1,"终身特权","【特权福利】今日福利奖励已经发放\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！"
    ,"秘宝礼盒#1#307&黄金骰子#1#307")
    sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【今日特权福利礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
    sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【今日特权福利礼包】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
    VarApi.setPlayerJIntVar(actor,"tqfwcx",3,true)
    VarApi.setPlayerJIntVar(actor,"J_flush_myzm_count", 1)
    lualib:FlushNpcUi(actor,"PrivilegeOBJ","领取刷新")
end

return Privilege