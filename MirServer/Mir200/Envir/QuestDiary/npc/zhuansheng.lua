local zhuansheng = {}

zhuansheng.cfg = include("QuestDiary/config/zhuanshengCfg.lua")

function zhuansheng:upEvent(actor,param)
    local level = tonumber(getbaseinfo(actor,39))--#region 当前转生等级
    local layer = VarApi.getPlayerUIntVar(actor, "l_zhuansheng")--#region 当前表中layer
    local star = VarApi.getPlayerUIntVar(actor,"UL_zsStar") --#region 星
    local job = getbaseinfo(actor,7) --#region 角色职业

    if layer == #self.cfg and star == 0 then
        return Sendmsg9(actor,"ff0000","当前已转生至最高等级！",1)
    elseif (level >= 10 and getbaseinfo(actor,3) ~= "苍月岛") then
        return Sendmsg9(actor,"ff0000","请前往苍月岛继续转生突破！",1)
    end
    local infoTab = self.cfg[layer+1]
    if star ~= nil and star == 10 then infoTab = self.cfg[layer] end
    if layer >= 110 and star == 10 then --#region 3大陆突破判断
        for k, v in pairs(infoTab["upNeed_map1"] or {}) do
            if v > getbagitemcount(actor, k) then
                lualib:FlushNpcUi(actor, "zhuanshengOBJ", "不足#" .. k)
                return Sendmsg9(actor, "ff0000", "当前" .. k .. "材料不足！", 1)
            end
        end
        for k, v in pairs(infoTab["upNeed_map2"] or {}) do --#region 通用货币
            if v > getbindmoney(actor, k) then
                lualib:FlushNpcUi(actor, "zhuanshengOBJ", "不足#" .. k)
                return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足！", 1)
            end
        end
        for k, v in pairs(infoTab["upNeed_map1"] or {}) do
            if not takeitem(actor, k, v, 0) then
                return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
            end
        end
        for k, v in pairs(infoTab["upNeed_map2"] or {}) do --#region 通用货币
            if not consumebindmoney(actor, k, v, "转生通用货币扣除") then
                return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
            end
        end
    else
        for k, v in pairs(infoTab["needMaterials_map"] or {}) do
            if v > getbagitemcount(actor, k) then
                lualib:FlushNpcUi(actor, "zhuanshengOBJ", "不足#" .. k)
                return Sendmsg9(actor, "ff0000", "当前" .. k .. "材料不足！", 1)
            end
        end
        for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
            if v > querymoney(actor, getstditeminfo(k, 0)) then
                lualib:FlushNpcUi(actor, "zhuanshengOBJ", "不足#" .. k)
                return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足！", 1)
            end
        end
        for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
            if v > getbindmoney(actor, k) then
                lualib:FlushNpcUi(actor, "zhuanshengOBJ", "不足#" .. k)
                return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足！", 1)
            end
        end
        for k, v in pairs(infoTab["needMaterials_map"] or {}) do
            if not takeitem(actor, k, v, 0) then
                return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
            end
        end
        for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
            if not changemoney(actor, getstditeminfo(k, 0), "-", v, "转生非通用货币扣除", true) then
                return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
            end
        end
        for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
            if not consumebindmoney(actor, k, v, "转生通用货币扣除") then
                return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
            end
        end
    end


    if star~= 10 then --#region 升星
        VarApi.setPlayerUIntVar(actor, "l_zhuansheng", layer+1, true)
        VarApi.setPlayerUIntVar(actor, "UL_zsStar", star+1, true)
        --#region 加属性
        delbuff(actor, 20000)
        local buffTab = {}
        for k, v in pairs(infoTab["star_map" .. job] or {}) do
            buffTab[k] = v
        end
        addbuff(actor, 20000, 0, 1, actor, buffTab)
        Sendmsg9(actor, "00ff00", "当前转生进度：".. star+1 .."/10！", 1)
        lualib:FlushNpcUi(actor,"zhuanshengOBJ","升星")
    else --#region 转生下一阶
        VarApi.setPlayerUIntVar(actor, "UL_zsStar", 0, true)
        setbaseinfo(actor,39,tonumber(getbaseinfo(actor,39))+1)
        --#region 加属性
        delbuff(actor, 20001)
        local buffTab = {}
        for k, v in pairs(infoTab["up_map" .. job] or {}) do
            buffTab[k] = v
        end
        for key, value in pairs(infoTab["up_map3"] or {}) do
            buffTab[key] = value
        end
        addbuff(actor, 20001, 0, 1, actor, buffTab)
        sendmsgnew(actor,255,255,"转生境界ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功达成"
        .."<『".. tonumber(getbaseinfo(actor,39)) .."』转/FCOLOR=251>,获得属性提升！",1,5)
        return sendluamsg(actor, 1002, 0, 0, 0, "zhuanshengOBJ#进阶")
    end
end

function zhuansheng:logAddInfo(actor) --#region 登陆加属性(转职更改成长属性)
    local level = tonumber(getbaseinfo(actor,39))--#region 当前转生等级
    local layer = VarApi.getPlayerUIntVar(actor, "l_zhuansheng")--#region 当前表中layer
    local star = VarApi.getPlayerUIntVar(actor,"UL_zsStar") --#region 星
    local job = getbaseinfo(actor,7) --#region 角色职业
    local infoTab = self.cfg[layer]
    if not self.cfg[layer] then return end

    delbuff(actor, 20000)
    local buffTab = {}
    for k, v in pairs(infoTab["star_map" .. job] or {}) do
        buffTab[k] = v
    end
    addbuff(actor, 20000, 0, 1, actor, buffTab)
    if layer > 10 then
        delbuff(actor, 20001)
        buffTab = {}
    
        infoTab = self.cfg[layer - star]
        for k, v in pairs(infoTab["up_map" .. job] or {}) do
            buffTab[k] = v
        end
        for key, value in pairs(infoTab["up_map3"] or {}) do
            buffTab[key] = value
        end
        addbuff(actor, 20001, 0, 1, actor, buffTab)
    end
end

return zhuansheng