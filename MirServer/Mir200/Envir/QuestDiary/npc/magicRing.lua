local magicRing = {}
magicRing.cfg = include("QuestDiary/config/magicRingCfg.lua")
magicRing.cfg2 = {
    [1] = { ["give_arr"]={"龙神石",1},["need_config"]={{"龙之血",1},{"龙之心",1},{"金刚石",20000},}, },
    [2] = { ["give_arr"]={"龙神石",10},["need_config"]={{"龙之血",10},{"龙之心",10},{"金刚石",200000},}, },
    [3] = { ["give_arr"]={"龙神石",100},["need_config"]={{"龙之血",100},{"龙之心",100},{"金刚石",2000000},}, },
}

function magicRing:click(actor)

end

function magicRing:upEvent(actor,...) --#region 锻造魔戒
    local param = {...}
    local leftIndex = tonumber(param[1]) --#region 左侧index
    if not self.cfg[leftIndex] then
        return Sendmsg9(actor, "ff0000", "当前选取魔戒数据异常！", 1)
    end
    local name = self.cfg[leftIndex]["name"]
    local infoTab = self.cfg[leftIndex]
    for index, value in ipairs(infoTab["need_config"]) do
        if value[2] > getbagitemcount(actor,value[1]) then
            lualib:FlushNpcUi(actor,"magicRingOBJ","不足11#name"..index)
            return Sendmsg9(actor, "ff0000", "当前"..value[1].."材料不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if v > getbagitemcount(actor,k) then
            lualib:FlushNpcUi(actor,"magicRingOBJ","不足12#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."材料不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
        if v > querymoney(actor, getstditeminfo(k,0)) then
            lualib:FlushNpcUi(actor,"magicRingOBJ","不足12#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
        if v > getbindmoney(actor, k) then
            lualib:FlushNpcUi(actor,"magicRingOBJ","不足12#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for index, value in ipairs(infoTab["need_config"]) do
        if not takeitem(actor,value[1],value[2],0) then
            return Sendmsg9(actor, "ff0000", value[1].."扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if not takeitem(actor,k,v,0) then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
        if not changemoney(actor,getstditeminfo(k,0),"-",v,"神龙秘宝觉醒非通用货币扣除",true) then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
        if not consumebindmoney(actor,k,v,"神龙秘宝觉醒通用货币扣除") then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    if math.random(100) > self.cfg[leftIndex]["odd"] then
        Sendmsg9(actor, "ff0000", "当前"..name.."锻造失败！", 1)
        return lualib:FlushNpcUi(actor,"magicRingOBJ","失败")
    end
    giveonitem(actor,infoTab["position"],name,1,307,"上古魔戒锻造")
    sendmsgnew(actor,255,255,"上古魔戒ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功锻造出魔戒"
    .."<『".. name .."』/FCOLOR=251>,全服起立顶礼膜拜！",1,8)
    Sendmsg9(actor, "ff0000", "成功锻造获得上古魔戒："..name.."！", 1)
    lualib:FlushNpcUi(actor, "magicRingOBJ", "锻造")
end

function magicRing:compound(actor,...) --#region 合成龙神石
    local param = {...}
    local boxIndex = tonumber(param[1])
    for index, value in ipairs(self.cfg2[boxIndex]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if getbindmoney(actor, itemName) < value[2] then
                lualib:FlushNpcUi(actor, "magicRingOBJ", "不足21#" .. index)
                return Sendmsg9(actor, "ff0000", "当前货币" .. itemName .. "数量少于" .. value[2] .. "！", 1)
            end
        elseif getbagitemcount(actor, itemName) < value[2] then
            lualib:FlushNpcUi(actor, "magicRingOBJ", "不足21#" .. index)
            return Sendmsg9(actor, "ff0000", "当前背包" .. itemName .. "数量少于" .. value[2] .. "！", 1)
        end
    end
    for index, value in ipairs(self.cfg2[boxIndex]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if not consumebindmoney(actor, itemName, value[2], "合成龙神石通用货币扣除") then
                return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
            end
        else
            if not takeitem(actor, itemName, value[2], 0) then
                return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
            end
        end
    end
    if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) >= 68 then
        giveitem(actor, self.cfg2[boxIndex]["give_arr"][1], self.cfg2[boxIndex]["give_arr"][2], 0, "合成龙神石")
    else
        giveitem(actor, self.cfg2[boxIndex]["give_arr"][1], self.cfg2[boxIndex]["give_arr"][2], 307, "合成龙神石")
    end
    Sendmsg9(actor, "#FFFFFF", "成功合成获得："..self.cfg2[boxIndex]["give_arr"][1].."×"..self.cfg2[boxIndex]["give_arr"][2].."！", 1)
    return lualib:FlushNpcUi(actor, "magicRingOBJ", "龙神石")
end

return magicRing