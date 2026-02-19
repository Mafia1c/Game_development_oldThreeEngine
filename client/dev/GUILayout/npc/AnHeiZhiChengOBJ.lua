local AnHeiZhiChengOBJ = {}
AnHeiZhiChengOBJ.Name = "AnHeiZhiChengOBJ"
AnHeiZhiChengOBJ.RunAction = true
AnHeiZhiChengOBJ.NpcId = 283
AnHeiZhiChengOBJ.HideMain = true            -- 打开时隐藏主界面

function AnHeiZhiChengOBJ:main(map_state)
    local ui_path = "npc/AnHeiZhiChengUI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, ui_path, function () end)
    self.ui = GUI:ui_delegate(parent)
    self.map_state = tonumber(map_state)

    self:initClickEvent()
    self:updateViewInfo()
end

function AnHeiZhiChengOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.joinBtn, handler(self, self.enterMap))
end

function AnHeiZhiChengOBJ:enterMap()
    SendMsgCallFunByNpc(self.NpcId, "GoToMapNpc", "GotoMap6", "暗黑之城1")
end

function AnHeiZhiChengOBJ:flushView(...)

end

function AnHeiZhiChengOBJ:updateViewInfo()
    local str = "入口状态: <未开放/FCOLOR=249>"
    if self.map_state == 1 then
        str = "入口状态: <已开启/FCOLOR=250>"
    end
    local rich = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_mon", 659, 105, str, 350, 18, "#ffffff")
    GUI:setAnchorPoint(rich, 0.5, 0)
    -- reward item
    local reward_list = {"诅咒龙之戒","邪恶龙之戒","嗜血龙之手","弑杀龙之爪","残暴龙之链"}
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

function AnHeiZhiChengOBJ:onClose()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if npc_info.index == AnHeiZhiChengOBJ.NpcId then
        SendMsgCallFunByNpc(AnHeiZhiChengOBJ.NpcId, "GoToMapNpc", "onClickAHZCNpc", "0")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "AnHeiZhiChengOBJ", onClickNpc)

return AnHeiZhiChengOBJ