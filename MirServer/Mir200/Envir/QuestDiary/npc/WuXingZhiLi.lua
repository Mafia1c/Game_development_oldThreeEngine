local WuXingZhiLi = {}
WuXingZhiLi.cfg = include("QuestDiary/config/wuxingzhiliCfg.lua")
WuXingZhiLi.attrIds = {1, 35, 76, 77, 75}

function WuXingZhiLi:click(actor, npc_id)
    local sMsg = self:GetEquipStar(actor)
    lualib:ShowNpcUi(actor, "WuXingZhiLiOBJ", sMsg)
end

function WuXingZhiLi:onClickImprove(actor, index)
    index = tonumber(index)
    local equip = linkbodyitem(actor, 80 + index)
    local level = getitemaddvalue(actor, equip, 2, 3)           --　当前等级
    if level <= 0 then
        level = 0
    end
    if level >= 50 then
        return Sendmsg9(actor,"ffffff","以达到满级!", 1)
    end
    local _cfg = self.cfg[level]

    local wcs_num = getbagitemcount(actor, _cfg["needItem_wcs"], 0)
    local money = getbindmoney(actor, _cfg["needItem_cl"])

    local need_wcs = _cfg["itemNum1"]
    local need_money = _cfg["itemNum2"]
    if wcs_num < need_wcs  then
        return Sendmsg9(actor,"ffffff","五彩石数量不足!", 1)
    end
    if money < need_money then
        return Sendmsg9(actor,"ffffff", _cfg["needItem_cl"].."数量不足!", 1)
    end

    if not takeitem(actor, _cfg["needItem_wcs"], need_wcs) then
        return Sendmsg9(actor,"ff0000","扣除失败!", 1)
    end
    if not consumebindmoney(actor, _cfg["needItem_cl"], need_money, "_货币扣除") then
        return Sendmsg9(actor,"ff0000","扣除失败!", 1)
    end

    local equip_names = {"坚韧之躯", "狂怒之心", "制裁之殇", "荆棘之力", "宗师之威"}
    if 0 == equip or equip == "0" or nil == equip then
        local ret = giveonitem(actor, 80 + index, equip_names[index])
        if not ret then
            giveitem(actor, _cfg["needItem_wcs"], need_wcs, 307)
            local money_id = getstditeminfo(_cfg["needItem_cl"], 0)
            changemoney(actor, money_id, "+", need_money, "升级"..equip_names[index].."失败返还货币", true)
            messagebox(actor, equip_names[index] .. " 升级失败, 材料已返还, 请注意查收!", "@________", "@________")
            return
        end
        level = 0
    end
    equip = linkbodyitem(actor, 80 + index)
    setitemaddvalue(actor, equip, 2, 3, level + 1)
    setthrowitemly2(actor, equip, tbl2json({["map"] = getbaseinfo(actor, 3),["source"] = 2, ["player"] = getbaseinfo(actor, 1), ["time"] = os.time()}))
    
    -- 加属性
    _cfg = self.cfg[level + 1]
    local job = getbaseinfo(actor, 7)
    local keys = {[0] = "zhanHp", [1] = "faHp", [2] = "daoHP"}
    local attrId = self.attrIds[index]
    local attr_str = job .. "#" .. attrId .. "#" .. _cfg["special_sx"]
    if index == 1 then
        attr_str = job .. "#" .. attrId .. "#" .. _cfg[keys[job]] .. "|" .. job .. "#2#" .. _cfg[keys[job]]
    end
    setaddnewabil(actor, -2, "=", attr_str,  equip)

    VarApi.setPlayerUIntVar(actor, "U_wxzl_level_"..index, level + 1)
    lualib:FlushNpcUi(actor, "WuXingZhiLiOBJ", self:GetEquipStar(actor))
    newcompletetask(actor, 106)
    local tab1 = json2tbl(VarApi.getPlayerTStrVar(actor,"TL_awakeRoad"))--#region 觉醒之路
    if tab1 == "" then;tab1 = {} end
    if level+1 == 5 and not tab1[tostring(index).."3"] then
        tab1[tostring(index).."3"] = 5
        tab1 = tbl2json(tab1)
        VarApi.setPlayerTStrVar(actor,"TL_awakeRoad",tab1,true)
    end
end

function WuXingZhiLi:loginUpdateWXZLAttr(actor)
    local equip_index = {81, 82, 83, 84, 85}
    for key, index in pairs(equip_index) do
        local equip = linkbodyitem(actor, index)
        local level = getitemaddvalue(actor, equip, 2, 3)           --　当前等级
        if level >= 0 then
            local _cfg = self.cfg[level]
            local job = getbaseinfo(actor, 7)
            local keys = {[0] = "zhanHp", [1] = "faHp", [2] = "daoHP"}
            local attrId = self.attrIds[key]
            local attr_str = job .. "#" .. attrId .. "#" .. _cfg["special_sx"]
            if key == 1 then
                attr_str = job .. "#" .. attrId .. "#" .. _cfg[keys[job]] .. "|" .. job .. "#2#" .. _cfg[keys[job]]
            end
            setaddnewabil(actor, -2, "=", attr_str,  equip)
        end
    end
end

function WuXingZhiLi:GetEquipStar(actor)
    local equip_index = {81,82,83,84,85}
    local sMsg = nil
    for k, v in pairs(equip_index) do
        local equip = linkbodyitem(actor, v)
        local value = 0
        if equip == 0 or equip == "0" then
        else
            value = getitemaddvalue(actor, equip, 2, 3)
        end
        if nil == sMsg then
            sMsg = value
        else
            sMsg = sMsg.."#"..value
        end
    end
    return sMsg or "0#0#0#0#0"
end

return WuXingZhiLi