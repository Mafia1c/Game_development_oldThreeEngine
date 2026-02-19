local LostAbyssObj = {}
LostAbyssObj.Name = "LostAbyssObj"
LostAbyssObj.NPC = 317
LostAbyssObj.RunAction = true
LostAbyssObj.HideMain = true

function LostAbyssObj:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LostAbyssUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:showRewardItem()
    self:showTxt()
    GUI:setVisible(self.ui.Panel_mask, false)
end

function LostAbyssObj:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.exchange1_btn, function ()
        SendMsgCallFunByNpc(LostAbyssObj.NPC, "LostAbyssNpc", "onClickViewBtn", 1)
    end)
    GUI:addOnClickEvent(self.ui.exchange2_btn, function ()
        SendMsgCallFunByNpc(LostAbyssObj.NPC, "LostAbyssNpc", "onClickViewBtn", 2)
    end)
    GUI:addOnClickEvent(self.ui.buy_btn, function ()
        GUI:setVisible(self.ui.Panel_mask, true)
    end)
    GUI:addOnClickEvent(self.ui.Button_1, function ()
        GUI:setVisible(self.ui.Panel_mask, false)
    end)           
    GUI:addOnClickEvent(self.ui.joinBtn_1, function ()
        SendMsgCallFunByNpc(LostAbyssObj.NPC, "LostAbyssNpc", "onClickViewBtn", 4)
    end)
    GUI:addOnClickEvent(self.ui.joinBtn_2, function ()
        SendMsgCallFunByNpc(LostAbyssObj.NPC, "LostAbyssNpc", "onClickViewBtn", 5)
    end)    
    GUI:addOnClickEvent(self.ui.buy1_btn, function ()
        SendMsgCallFunByNpc(LostAbyssObj.NPC, "LostAbyssNpc", "onClickBuyBtn", 1)
    end)
    GUI:addOnClickEvent(self.ui.buy10_btn, function ()
        SendMsgCallFunByNpc(LostAbyssObj.NPC, "LostAbyssNpc", "onClickBuyBtn", 10)
    end)         
end

function LostAbyssObj:showRewardItem()
    -- reward item
    local reward_list = {"恶魔挑战卷", "龙之血", "龙之心"}
    for i = 2, 4 do
        local v = reward_list[i - 1]
        local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v)
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 9                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)        
    end

    local reward_list2 = {{"绑定灵符", 290}, {"恶魔令", 3}, {"魔童降世碎片", 1}}
    local id = 5
    for k, v in pairs(reward_list2) do
        local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v[1])
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = v[2]                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..id], setData)        
        id = id + 1 
    end   
    
    local count = 99
    local hastab = GameData.GetData("TL_disguise",true) or {} --#region 装扮表
    hastab["1"] = hastab["1"] or {}
    if not isInTable(hastab["1"], "魔童降世(限定装扮)") then
        GUI:setVisible(self.ui.Effect_1, true)
        GUI:setVisible(self.ui.Node_1, false)
    else
        GUI:setVisible(self.ui.Effect_1, false)
        GUI:setVisible(self.ui.Node_1, true)
        count = 3
    end

    local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", "魔童降世碎片")
    local setData  = {}
    setData.index = index                 -- 物品Index
    setData.look  = true                  -- 是否显示tips
    setData.bgVisible = true              -- 是否显示背景框
    setData.count = count                     -- 物品数量
    GUI:ItemShow_updateItem(self.ui["ItemShow_1"], setData)       
end

function LostAbyssObj:flushView()
    self:showTxt()
end

function LostAbyssObj:showTxt()
    local count = GameData.GetData("J_exchange_eml_count", false)
    if nil == count then
        count = 0
    end
    local str = string.format("每日:  %s/3次", count)
    GUI:Text_setString(self.ui.Text_2, str)
end

local function onClickNpc(npc_info)
    if npc_info.index == LostAbyssObj.NPC then
        ViewMgr.open(LostAbyssObj.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "LostAbyssObj", onClickNpc)

return LostAbyssObj