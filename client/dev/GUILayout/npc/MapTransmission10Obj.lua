local MapTransmission10Obj = {}
MapTransmission10Obj.Name = "MapTransmission10Obj"
MapTransmission10Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission10Obj.RunAction = true
MapTransmission10Obj.NpcId = {403,406,411,394,396,401}
MapTransmission10Obj.map_img = {
    [403] = {
        bg_img = "bg2_2.png",
        icon = "icon2_2.png"
    },
    [406] = {
        bg_img = "bg4_2.png",
        icon = "icon4_2.png"
    },
    [411] = {
        bg_img = "bg6_2.png",
        icon = "icon6_2.png"
    },
    [394] = {
        bg_img = "bg1_2.png",
        icon = "icon1_2.png"
    },
    [396] = {
        bg_img = "bg3_2.png",
        icon = "icon3_2.png"
    },
    [401] = {
        bg_img = "bg5_2.png",
        icon = "icon5_2.png"
    }
}

function MapTransmission10Obj:main(...)
    local tab = {...}
    local id = tonumber(tab[1])
    local ui_path = "npc/GoToMap11UI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[id]
    self.map_cfg_id = id
    self.cur_count = tonumber(tab[2] or 0)

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
end

function MapTransmission10Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.enterBtn, handler(self, self.enterMap))
    GUI:addOnClickEvent(self.ui.enterKfBtn, handler(self, self.enterMapKf))
end

function MapTransmission10Obj:enterMap()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoWuMap", sMsg.."#1")
end

function MapTransmission10Obj:enterMapKf()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoWuMap", sMsg.."#2")
end

function MapTransmission10Obj:flushView(...)
    local tab = {...}

end

function MapTransmission10Obj:updateViewInfo()
    -- mini map
    local map_cfg = self.map_cfg
    local img_cfg = self.map_img[self.map_cfg_id]
    GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/npc/94dt/"..img_cfg.bg_img)
    GUI:Image_loadTexture(self.ui.iconImg, "res/custom/npc/94dt/"..img_cfg.icon)

    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_enter1", 220, 100, map_cfg.joinValue, 650, 18, "#ffffff")

    local str = "每日限制挑战"..self.cur_count.."/3次"
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_enter2", 290, 70, string.format(map_cfg.challenge, str), 600, 18, "#ffffff")

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
    local info = MapTransmission10Obj.cfg[npc_info.index]
    if info and isInTable(MapTransmission10Obj.NpcId, npc_info.index) then
        SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission10Obj", onClickNpc)

return MapTransmission10Obj