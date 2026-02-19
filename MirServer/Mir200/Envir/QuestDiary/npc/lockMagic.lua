local lockMagic = {}
lockMagic.cfg={
    "龙之心#99#307&金刚锤#99#307&宝石碎片#58#307&绑定金刚石#1980#307","龙之心#99#307&金刚锤#99#307&宝石碎片#58#307&绑定金刚石#1980#307",
    "龙之心#99#307&金刚锤#99#307&宝石碎片#58#307&绑定金刚石#1980#307","龙之心#99#307&金刚锤#99#307&宝石碎片#58#307&绑定金刚石#1980#307",
    "龙之心#99#307&金刚锤#99#307&宝石碎片#58#307&绑定金刚石#1980#307","龙之心#99#307&金刚锤#99#307&宝石碎片#58#307&绑定金刚石#1980#307",
    "龙之心#99#307&金刚锤#99#307&宝石碎片#58#307&绑定金刚石#1980#307",
}

function lockMagic:buyEvent(actor) --#region 购买
    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
    if hasGift == "" then hasGift = {} end
    if hasGift["gift_fmcf"] then
        return Sendmsg9(actor, "ff0000", "当前封魔赐福已购买过！", 1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_fmcf",1,"lockMagicOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

function lockMagic:upEvent(actor,index) --#region 领取每日
    index = tonumber(index)
    if type(index) ~= "number" or index < 1 or index > 7 then
        return Sendmsg9(actor, "ff0000", "领取封魔赐福豪礼天数异常！", 1)
    end
    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
    if hasGift == "" then hasGift = {} end
    if not hasGift["gift_fmcf"] then
        return Sendmsg9(actor, "ff0000", "请先购买激活封魔赐福礼包！", 1)
    elseif index ~= 1 and VarApi.getPlayerUIntVar(actor,"UL_fmcf"..(index-1)) == 0 then
        return Sendmsg9(actor, "ff0000", "请先领取前一天的封魔赐福豪礼！", 1)
    elseif VarApi.getPlayerUIntVar(actor,"UL_fmcf"..index) > 0 then
        return Sendmsg9(actor, "ff0000", "已领取过当前封魔赐福豪礼！", 1)
    end
    if VarApi.getPlayerJIntVar(actor,"JL_fmcf_today") > 0 then
        return Sendmsg9(actor, "ff0000", "还未到当前封魔赐福豪礼的领取时间！", 1)
    end

    local username = getbaseinfo(actor,1) --#region 玩家名称
    VarApi.setPlayerJIntVar(actor,"JL_fmcf_today",1,true) --#region 今日领取封魔赐福豪礼
    VarApi.setPlayerUIntVar(actor,"UL_fmcf"..index,1,true)
    sendmail(getbaseinfo(actor,2),1,"封魔赐福","【封魔赐福每日豪礼】\\奖励已经发放，请查收您的邮件。\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",self.cfg[index])
    sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【封魔赐福每日豪礼】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
    sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【封魔赐福每日豪礼】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
    lualib:FlushNpcUi(actor, "lockMagicOBJ", "充值刷新")
end
function lockMagic:flushRedData(actor)
    local cf_state = VarApi.getPlayerUIntVar(actor,"UL_fmcf7")
    local mark_tow_map = VarApi.getPlayerUIntVar(actor,"U_enter_tow_map")
    if cf_state == 0 and mark_tow_map == 1 then
        local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
        if hasGift == "" then hasGift = {} end
        if not hasGift["gift_fmcf"] then
            return 1
        else
            if VarApi.getPlayerJIntVar(actor,"JL_fmcf_today") > 0 then
                return 0
            end
            for i,v in ipairs(lockMagic.cfg) do
                if VarApi.getPlayerUIntVar(actor,"UL_fmcf"..i) <= 0 then
                    return 1
                end
            end
        end
    end
    return 0
end
return lockMagic