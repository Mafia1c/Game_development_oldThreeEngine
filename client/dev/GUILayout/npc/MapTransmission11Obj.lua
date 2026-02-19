local MapTransmission11Obj = {}
MapTransmission11Obj.Name = "MapTransmission11Obj"
MapTransmission11Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission11Obj.RunAction = true
MapTransmission11Obj.NpcId = {392,393,395,397,398,399,400,402,404,405,407,408,409,410}

function MapTransmission11Obj:main(...)
    local tab = {...}
    local id = tonumber(tab[1])
    local ui_path = "npc/GoToMap12UI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[id]
    self.map_cfg_id = id

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
end

function MapTransmission11Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.enterBtn, handler(self, self.enterMap))
end

function MapTransmission11Obj:enterMap()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoWuMap", sMsg.."#1")
end

function MapTransmission11Obj:flushView(...)
    local tab = {...}
end

function MapTransmission11Obj:updateViewInfo()
    -- mini map
    local map_cfg = self.map_cfg
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_enter_map", 304, 150, "<地图:  /FCOLOR=251>"..map_cfg.map, 600, 18, "#00ff00")
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_enter_level", 304, 120, "<下层:  /FCOLOR=251>"..map_cfg.next, 600, 18, "#00ff00")
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_enter_need", 304, 90, "进入条件:  "..map_cfg.joinValue, 600, 18, "#ffff00")
end

-- 点击npc触发
local function onClickNpc(npc_info)
    local info = MapTransmission11Obj.cfg[npc_info.index]
    if info and isInTable(MapTransmission11Obj.NpcId, npc_info.index) then
        SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission11Obj", onClickNpc)

return MapTransmission11Obj