local OptionalFashionOBJ = {}
OptionalFashionOBJ.Name = "OptionalFashionOBJ"
OptionalFashionOBJ.RunAction = true
OptionalFashionOBJ.fashion_effect = {20210,20220,20230,20240,20250,20260,20270,20280,20290,20300,20310,20320,20330,20340,20350,20360,20370,20380,20390}

function OptionalFashionOBJ:main(id_tab)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/OptionalFashionUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = nil
    self.fashion_ids = SL:JsonDecode(id_tab)
    self.cur_play_eff = nil

    self:initClickEvent()
    self:showCellInfo()
    GUI:setVisible(self.ui.selectEffect, false)
end

function OptionalFashionOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.getBtn, function()
        if nil == self.cur_select_index then
            SL:ShowSystemTips("请选择物品!")
            return
        end
        SendMsgCallFunByNpc(0, "OptionalItemNpc", "onGetFashionReward", self.cur_select_index)
    end)
    for i = 1, 19 do
        GUI:addOnClickEvent(self.ui["Panel_"..i], function()
            if self.cur_select_index == i then
                return
            end
            self.cur_select_index = i
            local pos = GUI:getPosition(self.ui["ItemShow_"..i])
            GUI:setPosition(self.ui.selectEffect, pos.x, pos.y)
            GUI:setVisible(self.ui.selectEffect, true)
            self:updateSelectItem(i)
        end)
    end
end

function OptionalFashionOBJ:showCellInfo()
    for i = 1, 19 do
        local id = self.fashion_ids[i]
        local setData  = {}
        setData.index = tonumber(id) or 0                 -- 物品Index
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)
    end
end

function OptionalFashionOBJ:updateSelectItem(index)
    index = index or self.cur_select_index
    local setData  = {}
    setData.index = tonumber(self.fashion_ids[index]) or 0
    setData.bgVisible = true
    setData.look = true
    setData.count = 1
    GUI:ItemShow_updateItem(self.ui.curItem, setData)

    local name = SL:GetMetaValue("ITEM_NAME", setData.index)
    GUI:Text_setString(self.ui.Text_1, name)
    GUI:Text_setTextColor(self.ui.Text_1, "#00FF00")

    if self.cur_play_eff then
        GUI:removeFromParent(self.cur_play_eff)
        self.cur_play_eff = nil
    end
    local eff_id = self.fashion_effect[index]
    self.cur_play_eff = GUI:Effect_Create(self.ui.FrameLayout, "_sz_111", 110, 240, 0, eff_id, 0, 0, 0, 1)
end

return OptionalFashionOBJ