local InlayingMasterNpc = {}
InlayingMasterNpc.hole_data = {
    [0] = 10121,
    [1] = 10122,
    [2] = 10123,
    [3] = 10124,
    [4] = 10125
}

function InlayingMasterNpc:click(actor, npc_id)
    local equip = linkbodyitem(actor, 1)
    local bs = getsocketableitem(actor, equip)
    lualib:ShowNpcUi(actor, "InlayingMasterOBJ", bs)
end

function InlayingMasterNpc:onSelectEquip(actor, index)
    local equip = linkbodyitem(actor, tonumber(index))
    local bs = getsocketableitem(actor, equip)
    lualib:FlushNpcUi(actor, "InlayingMasterOBJ", bs)
end

function InlayingMasterNpc:onOpEquip(actor, index, op_type, hole_index, item_id, makeIndex)
    op_type = tonumber(op_type)
    item_id = tonumber(item_id)
    hole_index = tonumber(hole_index)
    local equip = linkbodyitem(actor, tonumber(index))
    if op_type == -1 then
        local money = getbindmoney(actor, "元宝")
        if money < 1000000 then
            return Sendmsg9(actor, "ff0000", "元宝/绑定元宝不足！", 1)
        end
        if not consumebindmoney(actor, "元宝", 1000000, "_开孔扣除") then
            return Sendmsg9(actor, "ff0000", "元宝扣除失败！", 1)
        end        
        -- 装备打孔
        local _hole = {}
        _hole["hole"..(hole_index - 1)] = 1
        drillhole(actor, equip, tbl2json(_hole))
        refreshitem(actor, equip)
    elseif op_type == 0 then
        -- 镶嵌宝石
        if item_id <= 0 then
            return Sendmsg9(actor, "fffff", "请先选择需要镶嵌的宝石!", 1)
        end
        local id = self.hole_data[hole_index - 1]
        if id ~= item_id then
            return
        end
        local item_name = getiteminfo(actor, getitembymakeindex(actor, makeIndex), 7)
        if delitembymakeindex(actor, makeIndex, 1, "镶嵌宝石扣除~") then
            socketableitem(actor, equip, hole_index - 1, item_id)
        else
            Sendmsg9(actor, "ff0000", item_name.."镶嵌失败!", 1)
            return
        end
        refreshitem(actor, equip)
        Sendmsg9(actor, "ffffff", item_name.."镶嵌成功!", 1)
    else
        -- 取下宝石
        local data = json2tbl(getsocketableitem(actor, equip))
        local id = tonumber(data["socket"..(hole_index - 1)])
        local name = getstditeminfo(id, 1)
        local value = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
        local bind = 307
        if value >= 68 then
            bind = 0
        end
        giveitem(actor, name, 1, bind)
        socketableitem(actor, equip, hole_index - 1, 0)
        refreshitem(actor, equip)
    end
    self:onSelectEquip(actor, index)
end


return InlayingMasterNpc