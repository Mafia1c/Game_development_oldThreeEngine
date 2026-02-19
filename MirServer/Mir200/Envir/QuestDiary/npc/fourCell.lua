local fourCell = {}

fourCell.cfg = include("QuestDiary/config/fourCellCfg.lua")

function four_cell_open(actor) --#region 打开
    lualib:CloseNpcUi(actor,"fourCellOBJ")
    opennpcshowex(actor,109,0,1)
end
function four_cell_close(actor) --#region 关闭
end

function fourCell:upEvent1(actor,...) --#region 背包合成
    local level1 = tonumber(getbaseinfo(actor,6))--#region 当前等级
    local level2 = tonumber(getbaseinfo(actor,39))--#region 当前转生等级
    local param = {...}
    local leftIndex1 = tonumber(param[1]) --#region 左侧index1
    local sonIndex = tonumber(param[2]) --#region midBoxIndex
    local position = self.cfg[leftIndex1]["position"] --#region 装备位
    local name = self.cfg[leftIndex1]["equip_arr"][sonIndex]
    if self.cfg[name]["level1"] and level1 < self.cfg[name]["level1"] then
        return Sendmsg9(actor, "ff0000", "当前角色等级不足"..self.cfg[name]["level1"].."！", 1)
    end
    if self.cfg[name]["level2"] and level2 < self.cfg[name]["level2"] then
        return Sendmsg9(actor, "ff0000", "当前角色转生等级不足"..self.cfg[name]["level2"].."！", 1)
    end


    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if getbindmoney(actor, itemName) < value[2] then
                lualib:FlushNpcUi(actor, "fourCellOBJ", "不足#" .. itemName)
                return Sendmsg9(actor, "ff0000", "当前货币" .. itemName .. "数量少于" .. value[2] .. "！", 1)
            end
        elseif getbagitemcount(actor, itemName) < value[2] then
            lualib:FlushNpcUi(actor, "fourCellOBJ", "不足#" .. itemName)
            Sendmsg9(actor, "ff0000", "当前背包" .. itemName .. "数量少于" .. value[2] .. "！", 1)
            if (leftIndex1 == 4 or leftIndex1 == 5) and index == 1 then
                messagebox(actor, "盾牌与兵符可在命运之门获取，是否前往命运之门？", "@four_cell_open", "@four_cell_close")
            end
            return
        end
    end
    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if not consumebindmoney(actor, itemName, value[2], "四格通用货币扣除", true) then
                return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
            end
        else
            if not takeitem(actor, itemName, value[2], 0) then
                return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
            end
        end
    end
    if getbagblank(actor) < 5 then
        sendmail(getbaseinfo(actor, 2), 1, "特殊四格合成", "您的背包已满, 道具已发放至邮箱, 请及时领取!", name.."#1#307")
    else
        local accumulate_recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
        if accumulate_recharge >= 68 then
            giveitem(actor,name,1,0,"四格合成") --#region 给予物品
        else
            giveitem(actor,name,1,307,"四格合成") --#region 给予物品
        end
    end    
    Sendmsg9(actor, "FFFFFF", "合成获得：" .. name .. "！", 1)
    sendmsgnew(actor,255,255,"特殊四格：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>合成<『"
    ..name.."』/FCOLOR=245>获得强力属性提升！",1,10)
    if VarApi.getPlayerUIntVar(actor, "U_navigation_task_step") == 5 then
        newcompletetask(actor, 105)
    end
    lualib:FlushNpcUi(actor, "fourCellOBJ", "获得")
    self:awakeRoad(actor,name)
end

function fourCell:upEvent2(actor,...) --#region 身上合成
    local level1 = tonumber(getbaseinfo(actor,6))--#region 当前等级
    local level2 = tonumber(getbaseinfo(actor,39))--#region 当前转生等级
    local param = {...}
    local leftIndex1 = tonumber(param[1]) --#region 左侧index1
    local sonIndex = tonumber(param[2]) --#region midBoxIndex
    local name = self.cfg[leftIndex1]["equip_arr"][sonIndex]
    if self.cfg[name]["level1"] and level1 < self.cfg[name]["level1"] then
        return Sendmsg9(actor, "ff0000", "当前角色等级不足"..self.cfg[name]["level1"].."！", 1)
    end
    if self.cfg[name]["level2"] and level2 < self.cfg[name]["level2"] then
        return Sendmsg9(actor, "ff0000", "当前角色转生等级不足"..self.cfg[name]["level2"].."！", 1)
    end

    local position = self.cfg[leftIndex1]["position"] --#region 装备位
    local equipObj = linkbodyitem(actor,position)
    local needEquipName = getiteminfo(actor,equipObj,7) --#region 需要装备名
    if needEquipName ~= self.cfg[name]["need_config"][1][1] then
        return Sendmsg9(actor, "ff0000", "当前装备位置没有穿戴" .. self.cfg[name]["need_config"][1][1] .. "！", 1)
    end
    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if getbindmoney(actor, itemName) < value[2] then
                lualib:FlushNpcUi(actor, "fourCellOBJ", "不足#" .. itemName)
                return Sendmsg9(actor, "ff0000", "当前货币" .. itemName .. "数量少于" .. value[2] .. "！", 1)
            end
        else
            if index == 1 then
                if getbagitemcount(actor, itemName) < value[2]-1 then
                    lualib:FlushNpcUi(actor, "fourCellOBJ", "不足#" .. itemName)
                    Sendmsg9(actor, "ff0000", "当前" .. itemName .. "数量少于" .. value[2]-1 .. "！", 1)
                    if (leftIndex1 == 4 or leftIndex1 == 5) then
                        messagebox(actor, "盾牌与兵符可在命运之门获取，是否前往命运之门？", "@four_cell_open", "@four_cell_close")
                    end
                    return
                end
            else
                if getbagitemcount(actor, itemName) < value[2] then
                    lualib:FlushNpcUi(actor, "fourCellOBJ", "不足#" .. itemName)
                    return Sendmsg9(actor, "ff0000", "当前" .. itemName .. "数量少于" .. value[2] .. "！", 1)
                end
            end
        end
    end
    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if not consumebindmoney(actor, itemName, value[2], "四格通用货币扣除", true) then
                return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
            end
        else
            if index == 1 then
                if not delbodyitem(actor,position,"合成四格扣除") then
                    return Sendmsg9(actor, "ff0000", itemName .. "装备扣除失败！", 1)
                end
                if value[2]-1 > 0 and not takeitem(actor, itemName, value[2]-1, 0) then
                    return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
                end
            else
                if not takeitem(actor, itemName, value[2], 0) then
                    return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
                end
            end
        end
    end
    local accumulate_recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    if accumulate_recharge >= 68 then
         giveonitem(actor,position,name,1,0,"四格合成") --#region 给予物品
    else
        giveonitem(actor,position,name,1,307,"四格合成") --#region 给予物品
    end
    
    Sendmsg9(actor, "FFFFFF", "合成获得：" .. name .. "！", 1)
    sendmsgnew(actor,255,255,"特殊四格：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>合成<『"
    ..name.."』/FCOLOR=245>获得强力属性提升！",1,10)
    if VarApi.getPlayerUIntVar(actor, "U_navigation_task_step") == 5 then
        newcompletetask(actor, 105)
    end
    lualib:FlushNpcUi(actor, "fourCellOBJ", "获得")
    self:awakeRoad(actor,name)
end

function fourCell:awakeRoad(actor,name) --#region 觉醒之路
    local tab1 = json2tbl(VarApi.getPlayerTStrVar(actor,"TL_awakeRoad"))--#region 觉醒之路
    if tab1 == "" then;tab1 = {} end
    local roadTab = {
        ["二星魔血石"] = function ()
            if not tab1["14"] then
                tab1["14"] = 1
                tab1 = tbl2json(tab1)
                VarApi.setPlayerTStrVar(actor,"TL_awakeRoad",tab1,true)
            end
        end,
        ["赤月斗笠"] = function ()
            if not tab1["24"] then
                tab1["24"] = 1
                tab1 = tbl2json(tab1)
                VarApi.setPlayerTStrVar(actor,"TL_awakeRoad",tab1,true)
            end
        end,
        ["赤月勋章"] = function ()
            if not tab1["34"] then
                tab1["34"] = 1
                tab1 = tbl2json(tab1)
                VarApi.setPlayerTStrVar(actor,"TL_awakeRoad",tab1,true)
            end
        end,
        ["赤月盾牌"] = function ()
            if not tab1["44"] then
                tab1["44"] = 1
                tab1 = tbl2json(tab1)
                VarApi.setPlayerTStrVar(actor,"TL_awakeRoad",tab1,true)
            end
        end,
        ["赤月兵符"] = function ()
            if not tab1["54"] then
                tab1["54"] = 1
                tab1 = tbl2json(tab1)
                VarApi.setPlayerTStrVar(actor,"TL_awakeRoad",tab1,true)
            end
        end,
    }
    if roadTab[name] then
        roadTab[name]()
    end
end

return fourCell