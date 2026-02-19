
local CallServiceOBJ = {}
CallServiceOBJ.Name = "CallServiceOBJ"
CallServiceOBJ.RunAction = true

function CallServiceOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/CallServiceUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
end

function CallServiceOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(CallServiceOBJ.Name)
    end)
end

return CallServiceOBJ