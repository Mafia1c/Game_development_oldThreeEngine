local BiaoJuMasterOBJ = {}
BiaoJuMasterOBJ.Name = "BiaoJuMasterOBJ"
BiaoJuMasterOBJ.RunAction = true
BiaoJuMasterOBJ.NPC = {98, 123}

function BiaoJuMasterOBJ:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/YaBiaoTaskUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_npc_id = npc_id

    self:initClickEvent()
end

function BiaoJuMasterOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(BiaoJuMasterOBJ.Name)
    end)

    GUI:addOnClickEvent(self.ui.complete_txt, function ()
        SendMsgCallFunByNpc(self.cur_npc_id , "EscortAgencyNpc", "onClickComplete", "")
    end)
end


local function onClickNpc(npc_info)
    if isInTable(BiaoJuMasterOBJ.NPC, npc_info.index) then
        ViewMgr.open(BiaoJuMasterOBJ.Name, npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "BiaoJuMasterOBJ", onClickNpc)

return BiaoJuMasterOBJ