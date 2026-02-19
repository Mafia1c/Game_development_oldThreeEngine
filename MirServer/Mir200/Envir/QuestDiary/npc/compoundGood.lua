local compoundGood = {}

compoundGood.cfg = include("QuestDiary/config/compoundGoodCfg.lua")

function compoundGood:upEvent(actor,...) --#region 背包合成
    local param = {...}
    local leftIndex1 = tonumber(param[1]) --#region 左侧index1
    local sonIndex = tonumber(param[2]) --#region midBoxIndex
    if not self.cfg[leftIndex1] or not self.cfg[leftIndex1]["item_arr"][sonIndex] then
        return Sendmsg9(actor, "ff0000", "当前选取物品数据异常！", 1)
    end
    local name = self.cfg[leftIndex1]["item_arr"][sonIndex]

    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if getbindmoney(actor, itemName) < value[2] then
                lualib:FlushNpcUi(actor, "compoundGoodOBJ", "不足#" .. itemName)
                return Sendmsg9(actor, "ff0000", "当前货币" .. itemName .. "数量少于" .. value[2] .. "！", 1)
            end
        elseif getbagitemcount(actor, itemName) < value[2] then
            lualib:FlushNpcUi(actor, "compoundGoodOBJ", "不足#" .. itemName)
            return Sendmsg9(actor, "ff0000", "当前背包" .. itemName .. "数量少于" .. value[2] .. "！", 1)
        end
    end
    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if not consumebindmoney(actor, itemName, value[2], "材料非通用货币扣除") then
                return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
            end
        else
            if not takeitem(actor, itemName, value[2], 0) then
                return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
            end
        end
    end
    local typeTab = {"材料合成","飞剑合成"}
    local str = typeTab[leftIndex1] or typeTab[2]
    if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
        giveitem(actor, name, 1, 0, str)
    else
        giveitem(actor, name, 1, 307, str)
    end
    Sendmsg9(actor, "FFFFFF", "【提示】："..str.."获得：" .. name .. "！", 1)
    return lualib:FlushNpcUi(actor, "compoundGoodOBJ", "获得")
end


return compoundGood