local SlayerRootOBJ = {}
SlayerRootOBJ.Name = "SlayerRootOBJ"
SlayerRootOBJ.NPC = 62
SlayerRootOBJ.RunAction = true

function SlayerRootOBJ:main(state, point)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/SlayerRootUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:showRewardItem()

    GUI:setContentSize(self.ui.mask_layout, SL:GetMetaValue("SCREEN_WIDTH"), SL:GetMetaValue("SCREEN_HEIGHT"))
end

function SlayerRootOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.teamBtn, function ()
        SL:JumpTo(17)
    end)
    GUI:addOnClickEvent(self.ui.startBtn, function ()
        GUI:setVisible(self.ui.mask_layout, true)
    end)
    GUI:addOnClickEvent(self.ui.mask_layout, function ()
        GUI:setVisible(self.ui.mask_layout, false)
    end)

    local rate = {3,5,10,15,20,30,50}
    for i = 1, #rate do
        local v = rate[i]
        GUI:addOnClickEvent(self.ui["rateBtn"..v], function ()
            SendMsgCallFunByNpc(self.NPC, "GoToMapNpc", "GotoMapSlayer", v.."#"..i)
        end)
    end
end

function SlayerRootOBJ:showRewardItem()
    -- reward item
    local reward_list = {"火龙装备", "神龙装备", "天龙装备"}
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

local function onClickNpc(npc_info)
    if npc_info.index == SlayerRootOBJ.NPC then
        ViewMgr.open(SlayerRootOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "SlayerRootOBJ", onClickNpc)

return SlayerRootOBJ