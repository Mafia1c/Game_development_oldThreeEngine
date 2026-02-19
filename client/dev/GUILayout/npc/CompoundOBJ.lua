local CompoundOBJ = {}
CompoundOBJ.Name = "CompoundOBJ"
CompoundOBJ.NPC = 241

local function onClickNpc(npc_info) 
    if npc_info.index == CompoundOBJ.NPC then
        SL:JumpTo(2201)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "CompoundOBJ", onClickNpc)
return CompoundOBJ