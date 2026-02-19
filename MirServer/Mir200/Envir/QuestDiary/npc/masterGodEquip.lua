local masterGodEquip = {}

masterGodEquip.cfg = include("QuestDiary/config/masterGodEquipCfg.lua")

function masterGodEquip:upEvent(actor,...)
    local param = {...}
    local nowIndex = tonumber(param[1])
    if not self.cfg[nowIndex] then
        return Sendmsg9(actor, "ff0000", "选取灵装数据异常！", 1)
    end
    local position = self.cfg[nowIndex]["position"]
    local equipObj = linkbodyitem(actor,position)
    local equipName = getiteminfo(actor,equipObj,7)
    if not self.cfg[equipName] then
        return Sendmsg9(actor, "ff0000", "当时装备位暂无灵装！", 1)
    elseif not self.cfg[equipName]["next"] then
        return Sendmsg9(actor, "ff0000", "当前灵装"..equipName.."已觉醒至最高等级！", 1)
    end

    local infoTab = self.cfg[equipName]
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if v > getbagitemcount(actor,k) then
            sendluamsg(actor, 1002, 0, 0, 0, "masterGodEquipOBJ#不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."材料不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
        if v > querymoney(actor, getstditeminfo(k,0)) then
            sendluamsg(actor, 1002, 0, 0, 0, "masterGodEquipOBJ#不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
        if v > getbindmoney(actor, k) then
            sendluamsg(actor, 1002, 0, 0, 0, "masterGodEquipOBJ#不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if not takeitem(actor,k,v,0) then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
        if not changemoney(actor,getstditeminfo(k,0),"-",v,"神装大师非通用货币扣除",true) then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
        if not consumebindmoney(actor,k,v,"神装大师通用货币扣除") then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end

    delbodyitem(actor,position,"神装大师扣装备")
    giveonitem(actor,position,self.cfg[equipName]["next"],1,307,"神装大师穿戴")
    Sendmsg9(actor, "00ff00", "灵装成功觉醒至：" .. self.cfg[equipName]["next"] .. "！", 1)
    sendmsgnew(actor,255,255,"神装大师：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功觉醒灵装获得"
    .."<『".. self.cfg[equipName]["next"] .."』/FCOLOR=251>,获得属性提升！",1,8)
    return sendluamsg(actor, 1002, 0, 0, 0, "masterGodEquipOBJ#觉醒")
end


return masterGodEquip