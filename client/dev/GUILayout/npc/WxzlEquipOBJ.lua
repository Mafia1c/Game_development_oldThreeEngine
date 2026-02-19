local WxzlEquipOBJ = {}
WxzlEquipOBJ.Name = "WxzlEquipOBJ"
WxzlEquipOBJ.index_ids = {81, 82, 83, 84, 85}
WxzlEquipOBJ.RunDrag = true

function WxzlEquipOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WxzlEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initEvent()
    self:showEquipInfo()
end

function WxzlEquipOBJ:initEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
end

function WxzlEquipOBJ:showEquipInfo()
    for i = 1, 5 do
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

return WxzlEquipOBJ