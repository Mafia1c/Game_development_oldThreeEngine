local FeiJianEquipObj = {}
FeiJianEquipObj.Name = "FeiJianEquipObj"
FeiJianEquipObj.RunAction = true
FeiJianEquipObj.index_ids = {71,72,73,74,117,118,119,120}
FeiJianEquipObj.RunDrag = true

function FeiJianEquipObj:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/FeiJianEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = 1

    self:initClickEvent()

end

function FeiJianEquipObj:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(FeiJianEquipObj.Name)
    end)
end


 
return FeiJianEquipObj