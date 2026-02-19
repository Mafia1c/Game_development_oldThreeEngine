local MapTransmission4Obj = {}
MapTransmission4Obj.Name = "MapTransmission4Obj"
MapTransmission4Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission4Obj.RunAction = true
MapTransmission4Obj.NpcId = {331,328,329,369,370}
MapTransmission4Obj.HideMain = true            -- 打开时隐藏主界面

MapTransmission4Obj.map_rule = {
    [328] = {
        "<跨服行会争夺地图/FCOLOR=243>",
        "每天<【19点开放】/FCOLOR=251>入口，<【19点20关闭】/FCOLOR=251>入口",
        "当祭坛仅剩余<【唯一行会成员】/FCOLOR=249>获得胜利",
        "胜方行会获得<【卧龙1.1倍神力】/FCOLOR=250>限时12小时",
        "活动奖励仅在跨服地图<【卧龙祭坛】/FCOLOR=251>内开放",
    },
    [329] = {
        "<跨服世界BOSS/FCOLOR=243>",
        "每偶数整点<【限时10分钟开放】/FCOLOR=251>入口",
        "刷新<【卧龙夫人】/FCOLOR=249>世界BOSS",
        "<【攻击】/FCOLOR=250>世界BOSS可获得<【卧龙令】/FCOLOR=251>",
    },
    [331] = {
        "<高爆专属地图/FCOLOR=243>",
        "每次进入<【限时1小时】/FCOLOR=251>自动退出",
        "刷新<【二大陆所有BOSS】、【卧龙山庄BOSS】/FCOLOR=249>",
        "拥有<【卧龙1.1倍神力】/FCOLOR=250>进入费用减半",
    },
    [369] = {
        "<个人副本地图/FCOLOR=243>",
        "可使用<【黄金骰子】/FCOLOR=251>挑战副本",
        "进入随机刷新<【二大陆BOSSx1】/FCOLOR=249>",
        "地图限时<【1小时】/FCOLOR=251>超时自动退出",
    },
    [370] = {
        "<高爆专属地图/FCOLOR=243>",
        "地图内<【刷新时间】/FCOLOR=251>减半",
        "刷新<【二大陆所有BOSS】、【卧龙山庄BOSS】/FCOLOR=249>",
        "开启<【卧龙宝藏*99次】/FCOLOR=250>可进入",
        "合区清理需重新开启",
    }
}

function MapTransmission4Obj:main(npc_id, count)
    local id = tonumber(npc_id)
    local ui_path = "npc/GoToMap5UI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[id]
    self.map_cfg_id = id
    self.count = tonumber(count)

    self.map_id_map = {
        [331] = "2",
        [329] = "3",
        [328] = "4",
        [369] = "5",
        [370] = "6"
    }

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
end

function MapTransmission4Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.enterMapBtn, handler(self, self.enterMap))
end

function MapTransmission4Obj:enterMap()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id..""
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap4", sMsg)
end

function MapTransmission4Obj:flushView(...)
    local tab = {...}

end

function MapTransmission4Obj:updateViewInfo()
    -- mini map
    local map_cfg = self.map_cfg
    local id = self.map_id_map[self.map_cfg_id]
    GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/npc/79wldt/bg"..id..".png")

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

    local rule = self.map_rule[self.map_cfg_id] or {}
    for i = 1, #rule do
        local v = rule[i]
        local y = (i - 1) * 30 + 20
        local rich = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map_rule"..i, 0, y * -1, v, 500, 18, "#ffffff")
        GUI:setAnchorPoint(rich, 0.5, 0.5)
    end

    local str = "进入条件：<未达到进入条件/FCOLOR=249>"
    if map_cfg.joinValue then
        str = map_cfg.joinValue
    else
        str = "进入条件：<已达到进入条件/FCOLOR=250>"
    end
    if self.count then
        if self.count < 99 then
            str = "进入条件：<未达到进入条件, 累计已开启次数: "..self.count.."次/FCOLOR=249>"
        else
            str = "进入条件：<已达到进入条件, 累计已开启次数: "..self.count.."次/FCOLOR=250>"
        end
    end
    local rich = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map_join", -30, -310, str, 500, 18, "#ffffff")
    GUI:setAnchorPoint(rich, 0.5, 0.5)
end

-- 点击npc触发
local function onClickNpc(npc_info)
    local info = MapTransmission4Obj.cfg[npc_info.index]
    if nil == info or not isInTable(MapTransmission4Obj.NpcId, npc_info.index) then
        return
    end
    SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission4Obj", onClickNpc)

return MapTransmission4Obj