
local FirstRechargeRewardOBJ = {}
FirstRechargeRewardOBJ.Name = "FirstRechargeRewardOBJ"
FirstRechargeRewardOBJ.RunAction = true

function FirstRechargeRewardOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/FirstRechargeUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:showRewardItem()

    local state = GameData.GetData("U_firstRecharge", false)
    GUI:setVisible(self.ui.getBtn, state ~= 1)
    GUI:setVisible(self.ui.iconTag, state == 1)
    self:flushRed(state ~= 1)
end

function FirstRechargeRewardOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(FirstRechargeRewardOBJ.Name)
    end)
    GUI:addOnClickEvent(self.ui.getBtn, function ()
        self:getReward()
    end)
end

function FirstRechargeRewardOBJ:showRewardItem()
    local reward_list = {"幸运小红剑", "10万元宝", "1000声望", "三倍经验卷(30分钟)", "自动巡航", "打怪爆率", "打怪经验", "回收经验", "五星魔血石"}
    local actorId = SL:GetMetaValue("MAIN_ACTOR_ID")
    local job = SL:GetMetaValue("ACTOR_JOB_ID", actorId)
    local skill_book = "开天斩"
    if job == 0 then
        skill_book = "开天斩"
    elseif job == 1 then
        skill_book = "流星火雨"
    elseif job == 2 then
        skill_book = "召唤月灵"
    end
    table.insert(reward_list, 5, skill_book)
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

function FirstRechargeRewardOBJ:getReward()
    SendMsgClickSysBtn("_firstRecharge#MainTopBtn#onGetRechargeReward")
end

function FirstRechargeRewardOBJ:flushView(state)
    state = tonumber(state)
    if state then
        GUI:setVisible(self.ui.getBtn, state ~= 1)
        GUI:setVisible(self.ui.iconTag, state == 1)
        self:flushRed(state ~= 1)
    end
end

function FirstRechargeRewardOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.getBtn,{x = 0,y = 12})
        end
    end
end

function FirstRechargeRewardOBJ:onClose()
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

return FirstRechargeRewardOBJ