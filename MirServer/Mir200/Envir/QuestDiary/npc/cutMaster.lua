local cutMaster = {}
cutMaster.cfg = include("QuestDiary/config/cutMasterCfg.lua")

function cutMaster:obtain(actor,...) --#region 当前分解
    local param = {...}
    local leftIndex = tonumber(param[1]) --#region 左侧index
    local boxIndex = tonumber(param[2]) --#region midBoxIndex
    if self.cfg[leftIndex]["special_arr"..boxIndex] then
        local number = 0
        for index, value in ipairs(self.cfg[leftIndex]["special_arr"..boxIndex]) do
            if getbagitemcount(actor,value) > 0 then
                number = number + getbagitemcount(actor,value)
                if not takeitem(actor,value,getbagitemcount(actor,value),0) then
                    return Sendmsg9(actor, "ff0000", "当前背包"..value.."扣除失败！", 1)
                end
            end
        end
        if number == 0 then
            return Sendmsg9(actor, "ff0000", "当前背包"..self.cfg[leftIndex]["equip_arr"][boxIndex].."系列数量都少于1！", 1)
        end
        for key, value in pairs(self.cfg[leftIndex]["award_map"]) do
            if getstditeminfo(key,0) < 10000 then
                changemoney(actor,getstditeminfo(key,0),"+",value*number,"分解大师给系列货币",true)
            else
                if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
                    giveitem(actor,key,value*number,0,"分解大师给系列物品")
                else
                    giveitem(actor,key,value*number,307,"分解大师给系列物品")
                end
            end
        end
        Sendmsg9(actor, "00FF00", "分解成功！", 1)
        lualib:FlushNpcUi(actor, "cutMasterOBJ", "系列#"..number)
    else --#region 单个分解
        local equipName = self.cfg[leftIndex]["equip_arr"][boxIndex]
        local number = getbagitemcount(actor,equipName)
        if 1 > number then
            return Sendmsg9(actor, "ff0000", "当前背包"..equipName.."数量少于1！", 1)
        end
        if not takeitem(actor,equipName,number,0) then
            return Sendmsg9(actor, "ff0000", "当前背包"..equipName.."扣除失败！", 1)
        end
        for key, value in pairs(self.cfg[leftIndex]["award_map"]) do
            if getstditeminfo(key,0) < 10000 then
                changemoney(actor,getstditeminfo(key,0),"+",value*number,"分解大师给货币",true)
            else
                if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
                    giveitem(actor,key,value*number,0,"分解大师给系列物品")
                else
                    giveitem(actor,key,value*number,307,"分解大师给系列物品")
                end
            end
        end
        Sendmsg9(actor, "00FF00", "分解成功！", 1)
        lualib:FlushNpcUi(actor, "cutMasterOBJ", "单件#"..number)
    end

end


function cutMaster:all(actor,...) --#region 本页分解
    local param = {...}
    local leftIndex = tonumber(param[1]) --#region 左侧index
    local number = 0
    for index, value in ipairs(self.cfg[leftIndex]["all_arr"]) do
        if getbagitemcount(actor, value) > 0 then
            number = number + getbagitemcount(actor, value)
            if not takeitem(actor, value, getbagitemcount(actor, value), 0) then
                return Sendmsg9(actor, "ff0000", "当前背包" .. value .. "扣除失败！", 1)
            end
        end
    end
    if number == 0 then
        return Sendmsg9(actor, "ff0000", "当前背包本页系列数量都少于1！", 1)
    end
    for key, value in pairs(self.cfg[leftIndex]["award_map"]) do
        if getstditeminfo(key, 0) < 10000 then
            changemoney(actor, getstditeminfo(key, 0), "+", value * number, "分解大师给本页货币", true)
        else
            if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
                giveitem(actor,key,value*number,0,"分解大师给本页物品")
            else
                giveitem(actor,key,value*number,307,"分解大师给本页物品")
            end
        end
    end
    Sendmsg9(actor, "00FF00", "一键分解成功！", 1)
    lualib:FlushNpcUi(actor, "cutMasterOBJ", "本页#" .. number)
end

return cutMaster