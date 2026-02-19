local ExclusiveEquipOBJ = {}
ExclusiveEquipOBJ.Name = "ExclusiveEquipOBJ"
ExclusiveEquipOBJ.RunAction = true
ExclusiveEquipOBJ.index_ids = {87,88,89,90,91,92,93,94}
ExclusiveEquipOBJ.RunDrag = true

function ExclusiveEquipOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ExclusiveEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = 1

    self:initClickEvent()
    self:showEquipInfo()
end

function ExclusiveEquipOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(ExclusiveEquipOBJ.Name)
    end)
end

function ExclusiveEquipOBJ:showEquipInfo()
    for i = 1, 8 do
        local v = self.index_ids[i]
        local eq = SL:GetMetaValue("EQUIP_DATA", v)
        local setData  = {}
        setData.index = eq and eq.Index or 0
        setData.look  = true
        setData.bgVisible = false
        setData.count = 1
        setData.itemData = eq
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)
    end
end

return ExclusiveEquipOBJ