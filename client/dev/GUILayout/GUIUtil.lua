function SLMainError(errinfo)
    if errinfo then
        SL:Print("--------------------error-----------------------")
        SL:Print("--------------------error-----------------------")
        SL:Print("--------------------error-----------------------")
        SL:Print("--------------------error-----------------------")
        SL:Print(errinfo)
        SL:Print("--------------------error-------------------------")
        SL:Print("--------------------error-------------------------")
        SL:Print("--------------------error-------------------------")
        SL:Print("--------------------error-------------------------")
    end
end

local function init()
    SL:Require("GUILayout/LoadAllFile", true)
end

local game_id = SL:GetMetaValue("GAME_ID")
local server_id = tonumber(SL:GetMetaValue("SERVER_ID")) or 0
SL:release_print("GUIUtil: ", game_id, server_id)
if server_id <= 1000 then
    local function ReloadScript()
        ViewMgr.CloseAll()
        init()
    end
    GUI:addKeyboardEvent({"KEY_CTRL","KEY_TAB"}, ReloadScript)
end

init()


