local MapTransmission2Obj = {}
MapTransmission2Obj.Name = "MapTransmission2Obj"
MapTransmission2Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission2Obj.RunAction = true
MapTransmission2Obj.NpcId = {257, 258, 259, 260, 261, 262}
--[[
    {60,91,92},{其他}               --　已完成待测试
    {257-262},{371-376},            --　缺资源
]]

function MapTransmission2Obj:main(id)
    id = tonumber(id)
    local ui_path = "npc/GoToMap3UI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[id]
    self.map_cfg_id = id

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
end

function MapTransmission2Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.enterMapBtn, handler(self, self.enterMap))
end

function MapTransmission2Obj:enterMap()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id.."|1"
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap", sMsg)
end

function MapTransmission2Obj:flushView(...)
    local tab = {...}

end

function MapTransmission2Obj:updateViewInfo()
    -- mini map
    local map_cfg = self.map_cfg

    GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/npc/54dt/bg"..(self.map_cfg_id - 256)..".png")

    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map", -136, 26, map_cfg.mapLevel, 300, 16, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_mon", -136, -8, map_cfg.updateTime, 300, 16, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_boos", -136, -41, map_cfg.boosName, 300, 16, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_enter", -71, -30, map_cfg.joinValue, 300, 18, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_nandu", -71, 3, map_cfg.difficulty, 300, 18, "#ffffff")

    -- reward item
    local reward_list = map_cfg.reward_arr
    for k, v in pairs(reward_list) do
        local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v)
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], setData)
    end
end

-- 点击npc触发
local function onClickNpc(npc_info) 
    local info = MapTransmission2Obj.cfg[npc_info.index]
    if not isInTable(MapTransmission2Obj.NpcId, npc_info.index) then
        return
    end
    if info then
        SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission2Obj", onClickNpc)

return MapTransmission2Obj