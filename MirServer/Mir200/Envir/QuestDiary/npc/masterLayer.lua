local masterLayer = {}

masterLayer.cfg = include("QuestDiary/config/masterLayerCfg.lua")

function masterLayer:upEvent(actor,...)
    local level1 = VarApi.getPlayerUIntVar(actor, "l_masterLayer")--#region 当前宗师境界
    local level2 = tonumber(getbaseinfo(actor,6))--#region 当前等级

    if level1 == #self.cfg then
        return Sendmsg9(actor,"ff0000","当前宗师境界已提升至最高等级！",1)
    end
    local infoTab = self.cfg[level1+1]
    -- if level2 < infoTab["level"] then
    --     return Sendmsg9(actor,"ff0000","当前境界提升所需等级为"..infoTab["level"].."级！",1)
    -- end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if v > getbagitemcount(actor,k) then
            lualib:FlushNpcUi(actor,"masterLayerOBJ","不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
        if v > querymoney(actor, getstditeminfo(k,0)) then
            lualib:FlushNpcUi(actor,"masterLayerOBJ","不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
        if v > getbindmoney(actor, k) then
            lualib:FlushNpcUi(actor,"masterLayerOBJ","不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if not takeitem(actor,k,v,0) then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
        if not changemoney(actor,getstditeminfo(k,0),"-",v,"宗师境界提升非通用货币扣除",true) then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
        if not consumebindmoney(actor,k,v,"宗师境界提升通用货币扣除") then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end

    --#region 加属性
    -- delbuff(actor, 20003)
    -- local buffTab = {}
    -- for i = 1, 3 do
    --     for k, v in pairs(masterLayer.masterLayerCfg[level1 + 1]["up_map" .. i] or {}) do
    --         buffTab[k] = v
    --     end
    -- end
    -- addbuff(actor, 20003, 0, 1, actor, buffTab)
    if level1 > 0 then
        deprivetitle(actor,self.cfg[level1]["name"])
    end
    confertitle(actor,self.cfg[level1+1]["name"],1)
    VarApi.setPlayerUIntVar(actor, "l_masterLayer", level1+1, true)
    sendmsgnew(actor,255,255,"宗师境界：恭喜玩家<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功达成"
    .."<『".. self.cfg[level1+1]["name"] .."』/FCOLOR=251>,获得属性提升！",1,8)
    return lualib:FlushNpcUi(actor,"masterLayerOBJ","进阶")
end


return masterLayer