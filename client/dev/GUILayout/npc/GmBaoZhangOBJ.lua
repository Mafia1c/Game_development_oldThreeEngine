
local GmBaoZhangOBJ = {}
GmBaoZhangOBJ.Name = "GmBaoZhangOBJ"
GmBaoZhangOBJ.RunAction = true

function GmBaoZhangOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GmBaoZhangUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:showRewardItem()

    local function callback()
        self:getReward()
    end
    local data = {}
    data.dir           = 1                -- 方向（1~8）从左按瞬时针
    data.guideWidget   = self.ui["getBtn"]        -- 当前节点
    data.guideParent   = self._parent          -- 父窗口
    data.guideDesc     = "点击领取"           -- 文本描述
    data.clickCB       = callback         -- 回调
    data.autoExcute    = 86400            -- 自动执行秒数
    data.isForce       = true             -- 强制引导
    data.hideMask      = true             -- 隐藏蒙版 [仅不强制引导时有效]
    SL:StartGuide(data)
end

function GmBaoZhangOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(GmBaoZhangOBJ.Name)
    end)
    GUI:addOnClickEvent(self.ui.getBtn, function ()
        self:getReward()
    end)
end

function GmBaoZhangOBJ:showRewardItem()
    local reward_list = {"自动经验", "自动回收", "自动拾取", "自动元宝", "背包全开", "远程仓库", "一星魔血石", "祖玛勋章", "祖玛斗笠", "祖玛兵符"}
    for k, v in pairs(reward_list) do
        local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v)
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = false                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], setData)
    end
end

function GmBaoZhangOBJ:getReward()
    SendMsgClickSysBtn("_logingive#OtherSysFunc#onLoginGmGive")
end

return GmBaoZhangOBJ