local MapTransmission7Obj = {}
MapTransmission7Obj.Name = "MapTransmission7Obj"
MapTransmission7Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission7Obj.RunAction = true
MapTransmission7Obj.NpcId = {275, 277,278,279,280,281,282, 284}
MapTransmission7Obj.map_img = {
    [275] = "00mlc.png",
    [277] = "01smzl.png",
    [278] = "02gyzm.png",
    [279] = "03eyzd.png",
    [280] = "04jjzy.png",
    [281] = "05yhzs.png",
    [282] = "06zezd.png",
    [284] = "08lszm.png",
    [295] = "01smkj.png",
    [296] = "02gykj.png",
    [297] = "03eykj.png",
    [298] = "04jjkj.png",
    [299] = "05yhkj.png",
    [300] = "06zekj.png",
}

function MapTransmission7Obj:main(...)
    local tab = {...}
    local id = tonumber(tab[1])
    local ui_path = "npc/GoToMap8UI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[id]
    self.map_cfg_id = id

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
end

function MapTransmission7Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.joinBtn, handler(self, self.enterMap))
end

function MapTransmission7Obj:enterMap()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id.."|1"
    if self.map_cfg_id == 275 then
        SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap5", self.map_cfg_id)
    else
        SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap", sMsg)
    end
end

function MapTransmission7Obj:flushView(...)
    if self.map_cfg_id == 275 then
        if self.day_state_txt then
            GUI:removeFromParent(self.day_state_txt)
            self.day_state_txt = nil
        end
        local num = GameData.GetData("J_molongcheng_in_num",false) or 0
        local str = "今日状态: <未提交/FCOLOR=249>"
        if num >= 3 then
            str = "今日状态: <已提交/FCOLOR=250>"
        end
        self.day_state_txt = GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_nandu", 95, 10, str, 600, 18, "#ffffff")
    end
end

function MapTransmission7Obj:updateViewInfo()
    local pos = {x = 575, y = 85}
    if self.map_cfg_id == 275 then
        pos = {x = 400, y = 50}
    end
    GUI:setPosition(self.ui.joinBtn, pos.x, pos.y)

    -- mini map
    local map_cfg = self.map_cfg
    local img_path = self.map_img[self.map_cfg_id] or "00mlc.png"
    GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/npc/63mlc/"..img_path)

    local posx = -180
    if self.map_cfg_id == 275 then
        posx = -155
    end
    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map", posx, 27, map_cfg.mapLevel, 350, 18, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_mon", -180, -8, map_cfg.updateTime, 350, 18, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_boos", -165, -42, map_cfg.boosName, 350, 18, "#ffffff")

    local str = map_cfg.difficulty
    local x = -87
    local y = 10
    if self.map_cfg_id == 275 then
        x = 95
        y = 10
        local num = GameData.GetData("J_molongcheng_in_num",false) or 0
        str = "今日状态: <未提交/FCOLOR=249>"
        if num >= 3 then
            str = "今日状态: <已提交/FCOLOR=250>"
        end
    end
    self.day_state_txt = GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_nandu", x, y, str, 600, 18, "#ffffff")
    local x1 = -87
    local y1 = -22
    if self.map_cfg_id == 275 then
        x1 = -265
        y1 = 10
    end
    GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_enter", x1, y1, map_cfg.joinValue, 600, 18, "#ffffff")

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
    local info = MapTransmission7Obj.cfg[npc_info.index]
    if not isInTable(MapTransmission7Obj.NpcId, npc_info.index) then
        return
    end
    if info then
        SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission7Obj", onClickNpc)

return MapTransmission7Obj