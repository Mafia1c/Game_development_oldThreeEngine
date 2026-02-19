local MapTransmission5Obj = {}
MapTransmission5Obj.Name = "MapTransmission5Obj"
MapTransmission5Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission5Obj.RunAction = true
MapTransmission5Obj.NpcId = {330}

MapTransmission5Obj.map_rule = {
    [330] = {
        "<个人副本地图/FCOLOR=243>",
        "可使用<【火龙珠】/FCOLOR=251>挑战副本",
        "随机刷新<【二大陆BOSSx3】、【卧龙守将x1】/FCOLOR=249>"
    },
}

function MapTransmission5Obj:main(npc_id)
    local id = tonumber(npc_id)
    local ui_path = "npc/GoToMap6UI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[id]
    self.map_cfg_id = id

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
    self:createRuleTxt()
end

function MapTransmission5Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.enterMapBtn, handler(self, self.enterMap))
    GUI:addOnClickEvent(self.ui.composeBtn, handler(self, self.onCompose))
end

function MapTransmission5Obj:enterMap()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id..""
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap4", sMsg)
end

function MapTransmission5Obj:onCompose()
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "onClickCompose", self.map_cfg_id.."")
end

function MapTransmission5Obj:flushView(...)
    self:updateViewInfo()
end

function MapTransmission5Obj:updateViewInfo()
    -- mini map
    local map_cfg = self.map_cfg

    -- reward item
    local reward_list = map_cfg.reward_arr or {}
    for k, v in pairs(reward_list) do
        local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v)
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], setData)
    end

    local tmp_list = {
        [6] = {"书页", 200, 10134},
        [7] = {"三倍秘境卷轴", 3, 10142},
        [8] = {"金刚石",10000, 5}
    }
    for i = 6, 8 do
        local v = tmp_list[i]
        local setData  = {}
        setData.index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v[1])
        setData.look  = true
        setData.bgVisible = true
        setData.count = v[2]
        local value = tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", v[3]))
        if v[3] > 100 then
            value = SL:GetMetaValue("ITEM_COUNT", v[3])
        end
        setData.color = value >= v[2] and 250 or 249
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)
    end
end

function MapTransmission5Obj:createRuleTxt()
    local map_cfg = self.map_cfg
    local rule = self.map_rule[self.map_cfg_id] or {}
    for i = 1, #rule do
        local v = rule[i]
        local y = (i - 1) * 30
        local rich = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map_rule"..i, 0, y * -1, v, 400, 18, "#ffffff")
        GUI:setAnchorPoint(rich, 0.5, 0.5)
    end

    if map_cfg.joinValue then
        local rich = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map_join", -10, -310, map_cfg.joinValue , 500, 18, "#ffffff")
        GUI:setAnchorPoint(rich, 0.5, 0.5)
    end
end

-- 点击npc触发
local function onClickNpc(npc_info)
    local info = MapTransmission5Obj.cfg[npc_info.index]
    if nil == info or not isInTable(MapTransmission5Obj.NpcId, npc_info.index) then
        return
    end
    SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission5Obj", onClickNpc)

return MapTransmission5Obj