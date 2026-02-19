local ClickBloodFillingOBJ = {}
ClickBloodFillingOBJ.Name = "ClickBloodFillingOBJ"
ClickBloodFillingOBJ.NPC = 96

local function onClickNpc(npc_info)
    if npc_info.index == ClickBloodFillingOBJ.NPC then
        SendMsgCallFunByNpc(npc_info.index, "ClickBloodFillingNpc", "onClickBloodFilling", "")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ClickBloodFillingOBJ", onClickNpc)
return ClickBloodFillingOBJ