local ExclusiveEquip_LookOBJ = {}
ExclusiveEquip_LookOBJ.Name = "ExclusiveEquip_LookOBJ"
ExclusiveEquip_LookOBJ.RunAction = true
ExclusiveEquip_LookOBJ.index_ids = {87,88,89,90,91,92,93,94}

function ExclusiveEquip_LookOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ExclusiveEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.equip_id_tab = SL:JsonDecode(sMsg)
    self:initClickEvent()
    self:showEquipInfo()
end

function ExclusiveEquip_LookOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(ExclusiveEquip_LookOBJ.Name)
    end)
end

function ExclusiveEquip_LookOBJ:showEquipInfo()
    for i = 1, 8 do
        local eq = SL:GetMetaValue("LOOKPLAYER_DATA_BY_MAKEINDEX", self.equip_id_tab[i])
        local setData  = {}
        setData.index = eq and eq.Index or 0
        setData.look  = true
        setData.bgVisible = false
        setData.count = 1
        setData.itemData = eq
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)
    end
end

return ExclusiveEquip_LookOBJ