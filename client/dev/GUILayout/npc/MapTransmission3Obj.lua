local MapTransmission3Obj = {}
MapTransmission3Obj.Name = "MapTransmission3Obj"
MapTransmission3Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission3Obj.RunAction = true
MapTransmission3Obj.NpcId = {371,372,373,374,375,376}
--[[
    {60,91,92},{其他}               --　已完成待测试
    {257-262},{371-376},            --　缺资源
]]

function MapTransmission3Obj:main(...)
    local tab = {...}
    local id = tonumber(tab[1])
    local ui_path = "npc/GoToMap4UI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[id]
    self.map_cfg_id = id
    self.param_tab = tab

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
end

function MapTransmission3Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.enterGB1Btn, handler(self, self.enter1Map))
    GUI:addOnClickEvent(self.ui.enterGB2Btn, handler(self, self.enter2Map))
end

function MapTransmission3Obj:enter1Map()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id.."|1"
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap", sMsg)
end

function MapTransmission3Obj:enter2Map()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id.."|2"
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap", sMsg)
end

function MapTransmission3Obj:flushView(...)
    local tab = {...}

end

function MapTransmission3Obj:updateViewInfo()
    -- mini map
    local map_cfg = self.map_cfg
    local id = self.map_cfg_id - 370
    id = id * 10 + id
    GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/npc/54dt/bg"..id..".png")

    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map", -137, 27, map_cfg.mapLevel, 300, 16, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_mon", -137, -8, map_cfg.updateTime, 300, 16, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_boos", -137, -42, map_cfg.boosName, 300, 16, "#ffffff")

    GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_enter", -87, 16, map_cfg.joinValue, 600, 18, "#ffffff")

    local str1 = string.format("今日购买%s/5次黑市商人", self.param_tab[2] or 0)
    GUI:Text_Create(self.ui["bottomInfo"], "gaobao_1", -87, -15, 16, "#00ff00", str1)

    local str2 = string.format("今日购买%s/1次苍月赐福", self.param_tab[3] or 0)
    GUI:Text_Create(self.ui["bottomInfo"], "gaobao_2", -87, -46, 16, "#00ff00", str2)

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
    local info = MapTransmission3Obj.cfg[npc_info.index]
    if not isInTable(MapTransmission3Obj.NpcId, npc_info.index) then
        return
    end
    if info then
        SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission3Obj", onClickNpc)

return MapTransmission3Obj