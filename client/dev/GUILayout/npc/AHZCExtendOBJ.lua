local AHZCExtendOBJ = {}
AHZCExtendOBJ.Name = "AHZCExtendOBJ"
AHZCExtendOBJ.RunAction = true
AHZCExtendOBJ.HideMain = true            -- 打开时隐藏主界面

function AHZCExtendOBJ:main(npc_id, map_id)
    local ui_path = "npc/AHZCExtendUI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, ui_path, function () end)
    self.ui = GUI:ui_delegate(parent)
    self.NpcId = npc_id
    self.map_id = map_id

    self:initClickEvent()
end

function AHZCExtendOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.joinBtn, handler(self, self.enterMap))
end

function AHZCExtendOBJ:enterMap()
    SendMsgCallFunByNpc(self.NpcId, "GoToMapNpc", "GotoMap6", self.map_id)
end

function AHZCExtendOBJ:onClose()
end

return AHZCExtendOBJ