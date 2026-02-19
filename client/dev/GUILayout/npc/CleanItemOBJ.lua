local CleanItemOBJ = {}
CleanItemOBJ.Name = "CleanItemOBJ"
CleanItemOBJ.NPC = 240
CleanItemOBJ.RunAction = true

function CleanItemOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/CleanItemUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self.ok_layout = GUI:ItemBox_Create(self.ui.imageBg, "123456", 442, -133, "res/public/1900000651_2.png", 10086, "*")
end

function CleanItemOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(CleanItemOBJ.Name)
    end)

    GUI:addOnClickEvent(self.ui.okBtn, function ()
        local item = GUI:ItemBox_GetItemData(self.ok_layout, 10086)
        SL:dump(item, "_item", 100)
        if item then
            SendMsgCallFunByNpc(CleanItemOBJ.NPC, "CleanItemNpc", "onCleanItem", item.MakeIndex)
        end
    end)
end

function CleanItemOBJ:flushView(ret)
    if ret == "true" then
        GUI:ItemBox_RemoveBoxData(self.ok_layout, 10086)
    end
end

local function onClickNpc(npc_info)
    if npc_info.index == CleanItemOBJ.NPC then
        SendMsgClickNpc(CleanItemOBJ.NPC.."#CleanItemNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "CleanItemOBJ", onClickNpc)

return CleanItemOBJ