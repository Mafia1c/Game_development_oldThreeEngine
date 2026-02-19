local WxzlEquip_LookOBJ = {}
WxzlEquip_LookOBJ.Name = "WxzlEquip_LookOBJ"

function WxzlEquip_LookOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WxzlEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.equip_id_tab = SL:JsonDecode(sMsg)

    self:initEvent()
    self:showEquipInfo()
end

function WxzlEquip_LookOBJ:initEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
end

function WxzlEquip_LookOBJ:showEquipInfo()
    for i = 1, 5 do
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

return WxzlEquip_LookOBJ