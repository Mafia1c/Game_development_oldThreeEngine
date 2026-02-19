local MapTransmission8Obj = {}
MapTransmission8Obj.Name = "MapTransmission8Obj"
MapTransmission8Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission8Obj.RunAction = true
MapTransmission8Obj.NpcId = {295, 296,297,298,299,300}
MapTransmission8Obj.map_img = {
    [295] = "01smkj.png",
    [296] = "02gykj.png",
    [297] = "03eykj.png",
    [298] = "04jjkj.png",
    [299] = "05yhkj.png",
    [300] = "06zekj.png",
}

function MapTransmission8Obj:main(...)
    local tab = {...}
    local id = tonumber(tab[1])
    local ui_path = "npc/GoToMap9UI"
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

function MapTransmission8Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.enterGB1Btn, handler(self, self.enter1Map))
    GUI:addOnClickEvent(self.ui.enterGB2Btn, handler(self, self.enter2Map))
end

function MapTransmission8Obj:enter1Map()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id.."|1"
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap", sMsg)
end

function MapTransmission8Obj:enter2Map()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id.."|2"
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap", sMsg)
end

function MapTransmission8Obj:flushView(...)
    local tab = {...}

end

function MapTransmission8Obj:updateViewInfo()
    -- mini map
    local map_cfg = self.map_cfg
    local img_path = self.map_img[self.map_cfg_id] or "00mlc.png"
    GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/npc/63mlc/"..img_path)

    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map", -137, 27, map_cfg.mapLevel, 300, 18, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_mon", -137, -8, map_cfg.updateTime, 300, 18, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_boos", -125, -42, map_cfg.boosName, 300, 18, "#ffffff")

    GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_nandu", -87, 10, map_cfg.difficulty, 600, 18, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_enter", -87, -22, map_cfg.joinValue, 600, 18, "#ffffff")

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
    local info = MapTransmission8Obj.cfg[npc_info.index]
    if not isInTable(MapTransmission8Obj.NpcId, npc_info.index) then
        return
    end
    if info then
        SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission8Obj", onClickNpc)

return MapTransmission8Obj