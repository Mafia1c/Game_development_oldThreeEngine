local skyMaster = {}
skyMaster.cfg = include("QuestDiary/config/skyMasterCfg.lua")

function skyMaster:click(actor)
    local level = getbaseinfo(actor,39)
    if level < 18 then
        return Sendmsg9(actor, "ff0000", "请先提升至18转！", 1)
    end
    lualib:ShowNpcUi(actor, "skyMasterOBJ", "")
end

function skyMaster:upEvent(actor,...)
    local level = getbaseinfo(actor,39)
    local layer = VarApi.getPlayerUIntVar(actor, "UL_skyMaster")--#region 当前圣灵境界
    if layer == 25 or level >= 25 then
        return Sendmsg9(actor, "ff0000", "当前龙虎天师已突破转生至最高等级！", 1)
    elseif level < 18 then
        return Sendmsg9(actor, "ff0000", "当前角色转生等级不足18级！", 1)
    end

    if layer == 0 then layer = 18 end
    local infoTab = self.cfg[layer+1]
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do     --#region 非通用货币
        if v > querymoney(actor, getstditeminfo(k, 0)) then
            lualib:FlushNpcUi(actor, "skyMasterOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do     --#region 通用货币
        if v > getbindmoney(actor, k) then
            lualib:FlushNpcUi(actor, "skyMasterOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if v > getbagitemcount(actor, k) then
            lualib:FlushNpcUi(actor, "skyMasterOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "材料不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if not takeitem(actor, k, v, 0) then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do     --#region 非通用货币
        if not changemoney(actor, getstditeminfo(k, 0), "-", v, "龙虎天师非通用货币扣除", true) then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do     --#region 通用货币
        if not consumebindmoney(actor, k, v, "龙虎天师通用货币扣除") then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end

    setbaseinfo(actor,39,level+1)
    changelevel(actor,"+",1)
    VarApi.setPlayerUIntVar(actor,"UL_skyMaster",layer+1,true)
    delbuff(actor,20009)
    addbuff(actor,20009,0,1,actor,self.cfg[layer+1]["buff_map1"])
    Sendmsg9(actor, "00ff00", "恭喜成功转生至".. level+1 .."转！", 1)
    sendmsgnew(actor,255,255,"龙虎天师ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功突破转生至"
    .."<『".. level+1 .."』/FCOLOR=251>转,全服顶礼膜拜！",1,8)
    lualib:FlushNpcUi(actor,"skyMasterOBJ","提升")
end

return skyMaster
