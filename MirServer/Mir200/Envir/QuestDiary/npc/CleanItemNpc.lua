local CleanItemNpc = {}

function CleanItemNpc:click(actor, npc_id)
    lualib:ShowNpcUi(actor, "CleanItemOBJ", npc_id)
end

function CleanItemNpc:onCleanItem(actor, makeIndex)
    if delitembymakeindex(actor, makeIndex) then
        lualib:FlushNpcUi(actor, "CleanItemOBJ", "true")
    end
end

return CleanItemNpc