local InlayingMasterOBJ = {}
InlayingMasterOBJ.Name = "InlayingMasterOBJ"
InlayingMasterOBJ.NPC = 113
InlayingMasterOBJ.RunAction = true

function InlayingMasterOBJ:main(hole)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/InlayingMasterUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.equip_index_list = {1,4,5,7,10,0,3,6,8,11}
    self.cur_select_equip_index = 1
    self.cur_select_gemstone = nil
    self.red_width_list = {}
    self.cur_equip_hole_data = SL:JsonDecode(hole) or {}              -- 开孔数据及宝石数据

    self:initClickEvent()

    self:showEquipList()
    self:initBagGemstoneList()
    self:updateHoleData()

    self:updateSelectData()
    self:showSelectEquipImg()
end

function InlayingMasterOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(InlayingMasterOBJ.Name)
    end)

    for i = 1, 5 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function ()
            local equip = SL:GetMetaValue("EQUIP_DATA", self.cur_select_equip_index)
            if nil == equip then                -- 没有装备
                SL:ShowSystemTips("请先选择装备!")
                return
            end
            local item_id = 0
            local makeIndex = 0
            if self.cur_select_gemstone then
                item_id = self.gemstone_data_list[self.cur_select_gemstone].index
                makeIndex = self.gemstone_data_list[self.cur_select_gemstone]._MakeIndex
            end
            -- -1.开孔  0.镶嵌  >0 取下
            local _op_type = self.ui["Button_"..i].__op_type
            SendMsgCallFunByNpc(InlayingMasterOBJ.NPC, "InlayingMasterNpc", "onOpEquip", self.cur_select_equip_index.."#".._op_type.."#"..i.."#"..item_id.."#"..makeIndex)
        end)
    end

    for k, v in pairs(self.equip_index_list) do
        GUI:addOnClickEvent(self.ui["touch_item_"..v], function ()
            if v ~= self.cur_select_equip_index then
                -- GUI:ItemShow_setItemShowChooseState(self.ui["ItemShow_"..v], true)
                -- GUI:ItemShow_setItemShowChooseState(self.ui["ItemShow_"..self.cur_select_equip_index], false)
                self.cur_select_equip_index = v
                self:showSelectEquipImg()
                self:updateSelectData()
                SendMsgCallFunByNpc(InlayingMasterOBJ.NPC, "InlayingMasterNpc", "onSelectEquip", tostring(v))
            end
        end)
    end

    for i = 1, 20 do
        GUI:addOnClickEvent(self.ui["Panel_"..i], function ()
            if i == self.cur_select_gemstone then
                return
            end
            if nil == self.ui["bag_item_"..i].___data then
                return
            end
            if self.cur_select_gemstone then
                GUI:ItemShow_setItemShowChooseState(self.ui["bag_item_"..self.cur_select_gemstone], false)
                local item_id = self.gemstone_data_list[self.cur_select_gemstone].index
                local _op_type = self.ui["Button_"..(item_id - 10120)].__op_type
                local index = self:getBaoShiIndex(item_id)
                if _op_type == 0 then
                    if self.red_width_list[index] then 
                        GUI:removeFromParent(self.red_width_list[index])
                        self.red_width_list[index] = nil
                    end 
                    GUI:ItemShow_updateItem(self.ui["baoshi_"..index], {index = 0, look = true})
                end
            end
            GUI:ItemShow_setItemShowChooseState(self.ui["bag_item_"..i], true)
            local item_id = self.gemstone_data_list[i].index
            local _op_type = self.ui["Button_"..(item_id - 10120)].__op_type
            local index = self:getBaoShiIndex(item_id)
            if _op_type == 0 then
                if self.red_width_list[index] == nil then 
                    self.red_width_list[index] = SL:CreateRedPoint(self.ui["Button_"..index])
                end 
                GUI:ItemShow_updateItem(self.ui["baoshi_"..index], {index = item_id, look = true})
            end
            self.cur_select_gemstone = i
        end)
    end
    self:updateGemstoneData()
end

function InlayingMasterOBJ:getBaoShiIndex(item_id)
    local ids = {10121, 10122, 10123, 10124, 10125}
    local index = 1
    for i = 1, #ids do
        if item_id == ids[i] then
            index = i
            break
        end
    end
    return index
end

function InlayingMasterOBJ:showSelectEquipImg()
    if self.cur_select_equip_index then
        local pos = GUI:getPosition(self.ui["ItemShow_"..self.cur_select_equip_index])
        GUI:setPosition(self.ui.select_equip_img, pos.x, pos.y)
    end
    GUI:setVisible(self.ui.select_equip_img, nil ~= self.cur_select_equip_index)
end

function InlayingMasterOBJ:initBagGemstoneList()
    local ids = {10121, 10122, 10123, 10124, 10125}
    local bag_items = SL:GetMetaValue("BAG_DATA")
    local tmp_list = {}
    for k, v in pairs(bag_items) do
        if isInTable(ids, v.Index) then
            local data = {}
            data.index = v.Index
            data.count = v.OverLap
            data.look = false
            data.bgVisible = false
            data._MakeIndex = v.MakeIndex
            tmp_list[#tmp_list + 1] = data
        end
    end
    table.sort(tmp_list, function (a,b)
        return a.index < b.index
    end)
    self.gemstone_data_list = tmp_list
    for i = 1, 20 do
        local v = tmp_list[i]
        local item = self.ui["bag_item_"..i]
        item.___data = v
        GUI:ItemShow_updateItem(item, v or {index = 0, bgVisible = false})
    end
    if self.cur_select_gemstone then
        GUI:ItemShow_setItemShowChooseState(self.ui["bag_item_"..self.cur_select_gemstone], false)
        self.cur_select_gemstone = nil
    end
    if #tmp_list <= 0 then
        self.cur_select_gemstone = nil
    end
end

function InlayingMasterOBJ:updateHoleData()
    local img_path1 = "res/custom/npc/14xq/k1.png"
    local img_path2 = "res/custom/npc/14xq/k2.png"
    for i = 1, 5 do
        local v = tonumber(self.cur_equip_hole_data["socket"..(i-1)] or -1)
        GUI:Image_loadTexture(self.ui["Image_"..i], v < 0 and img_path2 or img_path1)
        if self.red_width_list[i] then 
            GUI:removeFromParent(self.red_width_list[i])
            self.red_width_list[i] = nil
        end 
        GUI:ItemShow_updateItem(self.ui["baoshi_"..i], {index = v <= 0 and 0 or v, look = true})

        local title = "取下"
        if v == -1 then
            title = "开孔"
        elseif v == 0 then
            title = "镶嵌"
        end
        self.ui["Button_"..i].__op_type = v
        GUI:Button_setTitleText(self.ui["Button_"..i], title)
    end
end

function InlayingMasterOBJ:updateGemstoneData()
    local function _onItemChange(info)
        if info.opera == 1 or info.opera == 2 or info.opera == 3 then
            self:initBagGemstoneList()
        end
    end
    SL:RegisterLUAEvent(LUA_EVENT_BAG_ITEM_CHANGE, "InlayingMasterOBJ", _onItemChange)
end

function InlayingMasterOBJ:updateSelectData()
    local equip = SL:GetMetaValue("EQUIP_DATA", self.cur_select_equip_index)
    local setData  = {}
    setData.index = equip and equip.Index or 0
    setData.look  = true
    setData.bgVisible = false
    setData.itemData = equip
    setData.count = 1
    GUI:ItemShow_updateItem(self.ui.SelectEquip, setData)
end

function InlayingMasterOBJ:showEquipList()
    local equip_index = self.equip_index_list
    for k, v in pairs(equip_index) do
        local equip = SL:GetMetaValue("EQUIP_DATA", v) or {}
        local setData  = {}
        setData.index = equip.Index or 0
        setData.look  = false
        setData.bgVisible = true
        setData.count = 1
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..v], setData)
    end
end

function InlayingMasterOBJ:flushView(hole)
    self.cur_equip_hole_data = SL:JsonDecode(hole) or {}
    self:updateHoleData()
    self:updateSelectData()
    if self.cur_select_gemstone then
        local item_id = self.gemstone_data_list[self.cur_select_gemstone].index
        local index = self:getBaoShiIndex(item_id)
        local _op_type = self.ui["Button_"..index].__op_type
        if _op_type == 0 then
            if self.red_width_list[index] then
               GUI:removeFromParent(self.red_width_list[index])
               self.red_width_list[index] = nil
            end
            self.red_width_list[index] = SL:CreateRedPoint(self.ui["Button_"..index])
            GUI:ItemShow_updateItem(self.ui["baoshi_"..index], {index = item_id, look = true})
        end
    end
end

function InlayingMasterOBJ:onClose()
   for k,v in pairs(self.red_width_list) do
        if v then
            GUI:removeFromParent(v)
        end
    end
    self.red_width_list = {}
    SL:UnRegisterLUAEvent(LUA_EVENT_BAG_ITEM_CHANGE, "InlayingMasterOBJ")
end

local function onClickNpc(npc_info)
    if npc_info.index == InlayingMasterOBJ.NPC then
        SendMsgClickNpc(InlayingMasterOBJ.NPC .. "#InlayingMasterNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "InlayingMasterOBJ", onClickNpc)

return InlayingMasterOBJ