local FeiJian_LookObj = {}
FeiJian_LookObj.Name = "FeiJian_LookObj"
FeiJian_LookObj.RunAction = true
FeiJian_LookObj.index_ids = {71,72,73,74,117,118,119,120}
FeiJian_LookObj.RunDrag = true

function FeiJian_LookObj:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/FeiJianEquipLookUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.equip_id_tab = SL:JsonDecode(sMsg)
    self:initClickEvent()
end

function FeiJian_LookObj:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(FeiJian_LookObj.Name)
    end)
end


return FeiJian_LookObj