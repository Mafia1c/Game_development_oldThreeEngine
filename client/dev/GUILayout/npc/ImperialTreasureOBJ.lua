local ImperialTreasureOBJ = {}
ImperialTreasureOBJ.Name = "ImperialTreasureOBJ"
ImperialTreasureOBJ.cfg = SL:Require("GUILayout/config/mapMoveData",true)
ImperialTreasureOBJ.NPC = 312
ImperialTreasureOBJ.RunAction = true

function ImperialTreasureOBJ:main(state, point)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ImperialTreasureUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:showRewardItem()
end

function ImperialTreasureOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.onTeamBtn, function ()
        -- SL:JumpTo(17)
    end)

    GUI:addOnClickEvent(self.ui.challengeBtn, function ()
        SendMsgCallFunByNpc(self.NPC, "GoToMapNpc", "GotoDWBZMap", self.NPC)
    end)
end

function ImperialTreasureOBJ:showRewardItem()
    -- reward item
    local _cfg = self.cfg[self.NPC]
    local reward_list = _cfg.reward_arr
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

function ImperialTreasureOBJ:flushView(index, level)

end

local function onClickNpc(npc_info)
    if npc_info.index == ImperialTreasureOBJ.NPC then
        ViewMgr.open(ImperialTreasureOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ImperialTreasureOBJ", onClickNpc)

return ImperialTreasureOBJ