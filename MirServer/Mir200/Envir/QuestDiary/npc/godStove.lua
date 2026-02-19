local godStove = {}
godStove.cfg = include("QuestDiary/config/godStoveCfg.lua")

function godStove:click(actor)

end

function godStove:upEvent1(actor,...) --#region 熔炼一次
    local param = {...}
    local leftIndex = tonumber(param[1])
    if not self.cfg[leftIndex] then
        return Sendmsg9(actor, "ff0000", "当前选取熔炼数据异常！", 1)
    end
    local itemIndex = tonumber(param[2])
    if leftIndex == 5 and itemIndex == 0 then
        return Sendmsg9(actor, "ff0000", "请先选取背包中拥有的任意魂骨！", 1)
    end

    local infoTab = self.cfg[leftIndex]
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do     --#region 非通用货币
        if v > querymoney(actor, getstditeminfo(k, 0)) then
            lualib:FlushNpcUi(actor, "godStoveOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do     --#region 通用货币
        if v > getbindmoney(actor, k) then
            lualib:FlushNpcUi(actor, "godStoveOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if v > getbagitemcount(actor, k) then
            lualib:FlushNpcUi(actor, "godStoveOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "材料不足！", 1)
        end
    end
    if itemIndex > 0 then
        if 99 > getbagitemcount(actor, getstditeminfo(itemIndex,1)) then
            lualib:FlushNpcUi(actor, "godStoveOBJ", "不足#need53")
            return Sendmsg9(actor, "ff0000", "当前" .. getstditeminfo(itemIndex,1) .. "材料不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do     --#region 非通用货币
        if not changemoney(actor, getstditeminfo(k, 0), "-", v, "次元神炉非通用货币扣除", true) then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do     --#region 通用货币
        if not consumebindmoney(actor, k, v, "次元神炉通用货币扣除") then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if not takeitem(actor, k, v, 0) then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    if itemIndex > 0 then
        if not takeitem(actor, getstditeminfo(itemIndex,1), 99, 0) then
            return Sendmsg9(actor, "ff0000", getstditeminfo(itemIndex,1) .. "扣除失败！", 1)
        end
    end
    giveitem(actor,infoTab["name"],1,307,"熔炼一次")
    Sendmsg9(actor, "00ff00", "恭喜成功熔炼获得"..infoTab["name"].."×1！", 1)
    lualib:FlushNpcUi(actor,"godStoveOBJ","熔炼")
end

function godStove:upEvent10(actor,...) --#region 熔炼十次
    local param = {...}
    local leftIndex = tonumber(param[1])
    if not self.cfg[leftIndex] then
        return Sendmsg9(actor, "ff0000", "当前选取熔炼数据异常！", 1)
    end
    local itemIndex = tonumber(param[2])
    if leftIndex == 5 and itemIndex == 0 then
        return Sendmsg9(actor, "ff0000", "请先选取背包中拥有的任意魂骨！", 1)
    end

    local infoTab = self.cfg[leftIndex]
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do     --#region 非通用货币
        if v*10 > querymoney(actor, getstditeminfo(k, 0)) then
            lualib:FlushNpcUi(actor, "godStoveOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足熔炼十次！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do     --#region 通用货币
        if v*10 > getbindmoney(actor, k) then
            lualib:FlushNpcUi(actor, "godStoveOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足熔炼十次！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if v*10 > getbagitemcount(actor, k) then
            lualib:FlushNpcUi(actor, "godStoveOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "材料不足熔炼十次！", 1)
        end
    end
    if itemIndex > 0 then
        if 990 > getbagitemcount(actor, getstditeminfo(itemIndex,1)) then
            lualib:FlushNpcUi(actor, "godStoveOBJ", "不足#need53")
            return Sendmsg9(actor, "ff0000", "当前" .. getstditeminfo(itemIndex,1) .. "材料不足熔炼十次！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do     --#region 非通用货币
        if not changemoney(actor, getstditeminfo(k, 0), "-", v*10, "次元神炉十次非通用货币扣除", true) then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do     --#region 通用货币
        if not consumebindmoney(actor, k, v*10, "次元神炉十次通用货币扣除") then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if not takeitem(actor, k, v*10, 0) then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    if itemIndex > 0 then
        if not takeitem(actor, getstditeminfo(itemIndex,1), 990, 0) then
            return Sendmsg9(actor, "ff0000", getstditeminfo(itemIndex,1) .. "扣除失败！", 1)
        end
    end
    giveitem(actor,infoTab["name"],10,307,"熔炼十次")
    Sendmsg9(actor, "00ff00", "恭喜成功熔炼获得"..infoTab["name"].."×10！", 1)
    lualib:FlushNpcUi(actor,"godStoveOBJ","熔炼")
end

return godStove
