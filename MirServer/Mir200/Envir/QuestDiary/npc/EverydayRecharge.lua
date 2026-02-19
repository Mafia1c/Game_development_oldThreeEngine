local EverydayRecharge = {}
EverydayRecharge.cfg = {{"秘宝礼盒",1},{"书页",100},{"灵符",180},{"上品聚灵珠",5},{"五倍秘境卷轴",1},{"金刚石",888}}
function EverydayRecharge:BuyEverydayRecharge(actor)
    local is_buy = VarApi.getPlayerJIntVar(actor,VarIntDef.EverydayRecharge)
    if is_buy >= 1 then
       return Sendmsg9(actor,"ff0000","每日充值已领取",1) 
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_mrlb",1,"EverydayRechargeOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

return EverydayRecharge