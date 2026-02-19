local Recharge = {}
Recharge.giftCfg = include("QuestDiary/config/rechargeGiftCfg.lua") --#region 礼包表

function Recharge:custom(actor,...) --#region 自定义充值
    local param = {...}
    local typeIndex = tonumber(param[1]) --#region 充值方式(1:支付宝2:花呗3:微信)
    local money = tonumber(param[2]) --#region 金额
    if not isInTable({1,2,3},typeIndex) then
        return Sendmsg9(actor,"ff0000","充值方式异常！",1)
    end
    if money == nil or "number" ~= type(money) or money <= 0 then
        return Sendmsg9(actor,"ff0000","请输入正确充值金额！",1)
    elseif money > 20000 then
        return Sendmsg9(actor,"ff0000","当前充值金额超过最大金额！",1)
    end

    if querymoney(actor,23) < money then --#region 拉取充值界面
        VarApi.setPlayerUIntVar(actor,"U_LcustomMoney",money,false)
        pullpay(actor,money,typeIndex,7)
    else --#region 打开充值中心
        VarApi.setPlayerUIntVar(actor,"U_LcustomMoney",money,false)
        lualib:ShowNpcUi(actor, "RechargeCenterOBJ", money)
    end
end

function Recharge:customGift(actor,...)--#region 在线充值礼包
    local param = {...}
    local giftName = param[1] --#region 礼包名
    Recharge:gift(actor,giftName,1,"RechargeOBJ") --#region 礼包名#次数#前端obj
end
function Recharge:gift(actor,...) --#region 礼包
    local param = {...}
    local giftName = param[1] --#region 礼包名
    local number = tonumber(param[2]) --#region 购买次数
    local objName = param[3] --#region 类名
    if not Recharge.giftCfg[giftName] then
        return Sendmsg9(actor,"ff0000","非法礼包请求！",1)
    end
    local needMoney = Recharge.giftCfg[giftName]["money"] * number
    VarApi.setPlayerTStrVar(actor,"TL_Recharge_gift",giftName.."|"..number.."|"..objName,true) --#region 礼包名|次数|前端obj
    if querymoney(actor,23) < needMoney then --#region 拉取充值界面
        lualib:ShowNpcUi(actor, "RechargeTypeOBJ", needMoney)
        -- pullpay(actor,needMoney,1,10)
    else --#region 打开充值中心
        lualib:ShowNpcUi(actor, "RechargeCenterOBJ", "")
    end

end

function Recharge:takeCustomMoney(actor) --#region 自定义充值扣除货币(充值中心)
    local Gold = VarApi.getPlayerUIntVar(actor,"U_LcustomMoney")
    if Gold <= 0 then
        return Sendmsg9(actor, "ff0000", "充值金额异常充值中心自定义1", 1)
    elseif querymoney(actor,23) < Gold then
        return Sendmsg9(actor, "ff0000", "充值金额异常充值中心自定义2", 1)
    end
    RechargeTrigger.custom(actor,Gold,1)
end

function Recharge:takeMoney(actor,...) --#region 礼包充值扣除货币(充值中心)
    local giftTab = strsplit(VarApi.getPlayerTStrVar(actor, "TL_Recharge_gift"),"|") --#region 礼包名|次数|前端obj
    local Gold = self.giftCfg[giftTab[1]]["money"] * tonumber(giftTab[2])
    if Gold <= 0 then
        return Sendmsg9(actor, "ff0000", "充值金额异常充值中心礼包1", 1)
    elseif querymoney(actor,23) < Gold then
        return Sendmsg9(actor, "ff0000", "充值金额异常充值中心礼包2", 1)
    end
    RechargeTrigger.gift(actor, Gold,1)
end

function Recharge:typeEvent(actor,type) --#region 拉取充值界面
    type = tonumber(type)
    if not isInTable({1,2,3},type) then
        return Sendmsg9(actor,"ff0000","充值方式异常！",1)
    end
    local giftTab = strsplit(VarApi.getPlayerTStrVar(actor, "TL_Recharge_gift"),"|") --#region 礼包名|次数|前端obj
    if not self.giftCfg[giftTab[1]] then
        return Sendmsg9(actor,"ff0000","拉取充值界面礼包不存在！",1)
    end
    local Gold = self.giftCfg[giftTab[1]]["money"] * tonumber(giftTab[2])
    pullpay(actor,Gold,type,10)
end

return Recharge