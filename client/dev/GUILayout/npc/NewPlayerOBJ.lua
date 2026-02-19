
local NewPlayerOBJ = {}
NewPlayerOBJ.Name = "NewPlayerOBJ"
NewPlayerOBJ.RunAction = true

function NewPlayerOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/NewPlayerCardUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.state_txt = nil

    self:initClickEvent()
    self:showRewardItem()
end

function NewPlayerOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(NewPlayerOBJ.Name)
    end)
    GUI:addOnClickEvent(self.ui.startBtn, function ()
        self:getReward()
    end)
end

function NewPlayerOBJ:showRewardItem()
    local reward_list = {"自动经验", "自动回收", "自动拾取", "自动元宝", "背包全开", "远程仓库", "打怪经验","回收经验","一星魔血石", "祖玛斗笠","祖玛勋章", "祖玛兵符"}
    for k, v in pairs(reward_list) do
        local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v)
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], setData)
    end

    if self.state_txt then
        GUI:removeFromParent(self.state_txt)
        self.state_txt = nil
    end
    local state = GameData.GetData("T_new_player_card", false)
    local str = "<未输入/FCOLOR=255>"
    if state == 1 then
        str = "<已发放/FCOLOR=250>"
    end
    self.state_txt = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_state", 443, 77, str, 300, 18, "#ffffff")

    local actorID = SL:GetMetaValue("MAIN_ACTOR_ID")
    local name = SL:GetMetaValue("ACTOR_NAME", actorID)
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_name", 443, 114, name, 300, 18, "#ffffff")

    local server_name = SL:GetMetaValue("SERVER_NAME")
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "server_name", 443, 154, server_name, 300, 18, "#ffffff")
end

function NewPlayerOBJ:flushView(state)
    state = tonumber(state)
    if self.state_txt then
        GUI:removeFromParent(self.state_txt)
        self.state_txt = nil
    end
    local str = "<未输入/FCOLOR=255>"
    if state == 1 then
        str = "<已发放/FCOLOR=250>"
    end    
    self.state_txt = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_state", 443, 77, str, 300, 18, "#ffffff")
end

function NewPlayerOBJ:getReward()
    SendMsgClickSysBtn("_logingive#OtherSysFunc#onClickGetGmGive")
end

return NewPlayerOBJ