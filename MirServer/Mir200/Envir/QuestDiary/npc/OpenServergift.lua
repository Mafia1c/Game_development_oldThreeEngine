local OpenServerGift = {}
OpenServerGift.cfg = include("QuestDiary/config/OpenServerGiftCfg.lua")
function OpenServerGift:GetOpenServerAward(actor,index)
    index = tonumber(index)
    if index == nil then
        return Sendmsg9(actor, "ffffff",  "数据异常", 1)   
    end
    local cfg = OpenServerGift.cfg[index]
    if cfg == nil then
        return Sendmsg9(actor, "ffffff",  "数据异常", 1)   
    end
    local award_day = VarApi.getPlayerJIntVar(actor,"J_open_server_gift")
    local day = VarApi.getPlayerUIntVar(actor,"U_open_server_gift")
    if day == cfg.key_name  and award_day < 1 then
        local list = {}
        for k, v in pairs(cfg.award1_map) do
            table.insert(list,{name = v[1],count = v[2]})
        end
        for i,v in ipairs(list) do
            local stdmode =  getstditeminfo(v.name,2)
            local count = v.count
            if stdmode == 41 then  --货币
                changemoney(actor,getstditeminfo(v.name, 0),"+",count,"开服特惠",true)
            else
                giveitem(actor,v.name,count,307)
            end
        end
        lualib:ShowAwardTipUi(actor, list)
        VarApi.setPlayerJIntVar(actor,"J_open_server_gift",1,true)
        VarApi.setPlayerUIntVar(actor,"U_open_server_gift",day + 1,true)
        lualib:FlushNpcUi(actor,"OpenServerGiftObj","flush_sigle_open_server#"..award_day .. "#" ..index)
    else
        return Sendmsg9(actor, "ffffff",  "今日奖励已领取过", 1) 
    end
    
end
function OpenServerGift:BuyOpenServerGift(actor)
    if querymoney(actor,7) < 580 then
        return Sendmsg9(actor, "ffffff",  "灵符不足", 1) 
    end
    
    if  VarApi.getPlayerUIntVar(actor,"U_open_server_gift") > 0 then
        return Sendmsg9(actor, "ffffff",  "礼包不可购买！", 1) 
    end
    if changemoney(actor,7,"-",580,"开服特惠购买",true) then
        giveitem(actor,"时装自选宝箱",1,307) 
        giveitem(actor,"书页",188,307) 
        VarApi.setPlayerUIntVar(actor,"U_open_server_gift",1,true)
        lualib:FlushNpcUi(actor,"OpenServerGiftObj","flush_buy#"..1)
    end
end
function OpenServerGift:flushRedData(actor)
    local award_day = VarApi.getPlayerJIntVar(actor,"J_open_server_gift")
    local day = VarApi.getPlayerUIntVar(actor,"U_open_server_gift")
    if day <= 0 then
        return 1
    end
    for k, v in pairs(OpenServerGift.cfg) do
        if day == v.key_name  and award_day < 1 then
            return 1
        end
    end
    return 0
end
return OpenServerGift
---------------------------------------------------------end-------------------------------------------