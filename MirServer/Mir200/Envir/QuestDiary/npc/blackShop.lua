local blackShop = {}
blackShop.cfg = {
    [315] = { { "根骨福袋", 999, 10, 48, 10 }, { "神龙福袋", 999, 10, 48, 10 }, { "飞升福袋", 999, 10, 48, 10 } },
    [316] = { { "帝王福袋", 1299, 10, 58, 10 }, { "龙神福袋", 1299, 10, 58, 10 }, { "符文福袋", 1299, 10, 58, 10 }, },
}
blackShop.cfg2 = { [315]={"JL_ggfd","JL_slfd","JL_fsfd"}, [316]={"JL_dwfd","JL_lsfd","JL_fwfd"}, } --#region rmb购买次数

function blackShop:buyEvent1(actor,npcId,btnIndex) --#region 灵符购买
    npcId = tonumber(npcId)
    btnIndex = tonumber(btnIndex)
    if not self.cfg[npcId] then
        return Sendmsg9(actor, "ff0000",  "当前npcId异常" , 1)
    elseif btnIndex < 1 or btnIndex > 3 or "number" ~= type(btnIndex) then
        return Sendmsg9(actor, "ff0000",  "当前数据异常" , 1)
    end

    local time = VarApi.getPlayerJIntVar(actor,"JL_blackShop"..npcId..btnIndex) --#region 灵符今日购买次数
    if time >= self.cfg[npcId][btnIndex][3] then
        return Sendmsg9(actor,"ff0000","今日灵符购买"..self.cfg[npcId][btnIndex][1].."次数已用尽！",1)
    elseif getbindmoney(actor,"灵符") < self.cfg[npcId][btnIndex][2] then
        return Sendmsg9(actor,"ff0000","当前灵符不足×"..self.cfg[npcId][btnIndex][2].."！",1)
    end
    if not consumebindmoney(actor,"灵符",self.cfg[npcId][btnIndex][2],"黑市商人"..npcId.."扣灵符") then
        return Sendmsg9(actor,"ff0000","灵符扣除失败！",1)
    end
    giveitem(actor,self.cfg[npcId][btnIndex][1],1,307,"黑市商人灵符买"..self.cfg[npcId][btnIndex][1])
    VarApi.setPlayerJIntVar(actor,"JL_blackShop"..npcId..btnIndex,time+1,true)
    local hssr = VarApi.getPlayerJIntVar(actor, "J_today_buy_hssr")
    VarApi.setPlayerJIntVar(actor, "J_today_buy_hssr", hssr + 1, true)    --#region 今日购买黑市商人次数
    Sendmsg9(actor, "ffffff", "恭喜您成功购买" .. self.cfg[npcId][btnIndex][1] .. "！", 1)

    lualib:FlushNpcUi(actor,"blackShopOBJ","lf")
end

function blackShop:buyEvent2(actor,npcId,btnIndex,time) --#region rmb购买
    npcId = tonumber(npcId)
    btnIndex = tonumber(btnIndex)
    time = tonumber(time) --#region 购买次数
    if not self.cfg[npcId] then
        return Sendmsg9(actor, "ff0000",  "当前npcId异常" , 1)
    elseif btnIndex < 1 or btnIndex > 3 or "number" ~= type(btnIndex) then
        return Sendmsg9(actor, "ff0000",  "当前数据异常" , 1)
    elseif time ~= 1 and time ~= 10 then
        return Sendmsg9(actor, "ff0000",  "当前购买次数异常" , 1)
    end
    local number = VarApi.getPlayerJIntVar(actor,self.cfg2[npcId][btnIndex]) --#region 限制购买次数
    if number >= 10 then
        return Sendmsg9(actor, "ff0000",  "今日购买"..self.cfg[npcId][btnIndex][1].."次数已用尽！" , 1)
    elseif number+time > 10 then
        return Sendmsg9(actor, "ff0000",  self.cfg[npcId][btnIndex][1].."购买次数超过今日限额！" , 1)
    end

    local giftTab = {[315]={"gift_ggfd","gift_slfd","gift_fsfd",},[316]={"gift_dwfd","gift_lsfd","gift_fwfd",},}
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,giftTab[npcId][btnIndex],time,"blackShopOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

return blackShop