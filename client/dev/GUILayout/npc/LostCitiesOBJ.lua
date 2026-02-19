local LostCitiesOBJ = {}
LostCitiesOBJ.Name = "LostCitiesOBJ"
LostCitiesOBJ.NPC = 314
LostCitiesOBJ.RunAction = true
LostCitiesOBJ.HideMain = true

function LostCitiesOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LostCitiesUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:showRewardItem()
end

function LostCitiesOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.buyBtn, function ()
        SendMsgCallFunByNpc(LostCitiesOBJ.NPC, "LostCitiesNpc", "onClickBuyBtn", 1)
    end)    
    GUI:addOnClickEvent(self.ui.joinBtn, function ()
        SendMsgCallFunByNpc(LostCitiesOBJ.NPC, "LostCitiesNpc", "onClickEnterBtn", 1)
    end)
end

function LostCitiesOBJ:showRewardItem()
    -- reward item
    local reward_list = {"「乾坤圈」","「混天绫」","「风火轮」","「神火罩」","魔童降世(限定装扮)"}
    for k, v in pairs(reward_list) do
        local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v)
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], setData)
    end
    local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", "迷失之城随机石")
    local setData  = {}
    setData.index = index                 -- 物品Index
    setData.look  = true                  -- 是否显示tips
    setData.bgVisible = true              -- 是否显示背景框
    setData.count = 1                     -- 物品数量
    GUI:ItemShow_updateItem(self.ui["buyItem"], setData)    
end

local function onClickNpc(npc_info)
    if npc_info.index == LostCitiesOBJ.NPC then
        ViewMgr.open(LostCitiesOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "LostCitiesOBJ", onClickNpc)

return LostCitiesOBJ