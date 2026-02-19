local LostCitiesNpc = {}

function LostCitiesNpc:onClickBuyBtn(actor)
    local value = getbindmoney(actor, "灵符")
    if value < 500 then
        Sendmsg9(actor, "ffffff", "灵符/绑定灵符不足!", 1)
        return
    end
    if not consumebindmoney(actor, "灵符", 500, "购买随机石扣除") then
        Sendmsg9(actor, "ffffff", "灵符/绑定灵符扣除失败!", 1)
        return
    end
    giveitem(actor, "迷失之城随机石", 1, 338, "购买传送石")
    Sendmsg9(actor, "ffffff", "购买迷失之城随机石成功!", 1)
end

function LostCitiesNpc:onClickEnterBtn(actor)
    if not checkkuafuconnect() then
        return Sendmsg9(actor, "ffffff", "跨服未连接!", 1)
    end 
    local tq = VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL)
    if tq <= 0 then
        Sendmsg9(actor, "ffffff", "未开通终身特权!", 1)
        return
    end
    local count = getbagitemcount(actor, "五倍秘境卷轴", 0)
    if count <= 0 then
        Sendmsg9(actor, "ffffff", "需要五倍秘境卷轴*1!", 1)
        return
    end
    if not takeitem(actor, "五倍秘境卷轴", 1) then
        Sendmsg9(actor, "ffffff", "扣除失败!", 1)
        return
    end
    map(actor, "迷失之城")
    lualib:CloseNpcUi(actor, "LostCitiesOBJ")
end

return LostCitiesNpc