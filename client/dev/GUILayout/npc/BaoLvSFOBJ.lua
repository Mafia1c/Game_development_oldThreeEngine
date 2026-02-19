local BaoLvSFOBJ = {}
BaoLvSFOBJ.Name = "BaoLvSFOBJ"
BaoLvSFOBJ.NPC = 107
BaoLvSFOBJ.RunAction = true

BaoLvSFOBJ.title = {
    "<灵符启动次数:/FCOLOR=250> <%s次/FCOLOR=251>",
    "<开启转盘冷却:/FCOLOR=250> <%s/FCOLOR=251>"
}
local tips ={
    "<神符爆率展示：/FCOLOR=250>\\<爆率神符1.3倍：20%/FCOLOR=251>\\<爆率神符1.4倍：18%/FCOLOR=251>"
    .."\\<爆率神符1.5倍：16%/FCOLOR=251>\\<爆率神符1.6倍：14%/FCOLOR=251>".."\\<爆率神符1.7倍：12%/FCOLOR=251>\\<爆率神符1.8倍：8%/FCOLOR=251>"
    .."\\<爆率神符1.9倍：6%/FCOLOR=251>\\<爆率神符2.0倍：4%/FCOLOR=251>".."\\<爆率神符·尊：2%/FCOLOR=251>",
}

function BaoLvSFOBJ:main(...)
    local _tab = {...}
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/BaoLvSFUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cfg = SL:JsonDecode(_tab[1])                   -- 奖池道具
    self.lf_open_count = tonumber(_tab[2] or 0)         -- 灵符摇奖次数
    self.remain_time = tonumber(_tab[3] or 0)           -- 剩余免费摇奖时间
    self.old_idx = 0
    self.is_running = false

    self:initClickEvent()

    self:showUIRewardItem()
    self:showOpenInfo()
end

function BaoLvSFOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.tipsBtn, function()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn)
        GUI:ShowWorldTips(tips[1], worldPos, GUI:p(1, 1))
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        if self.is_running then
            return
        end
        ViewMgr.close(BaoLvSFOBJ.Name)
    end)
    GUI:addOnClickEvent(self.ui.startBtn1, function ()
        if self.is_running then
            return
        end
        SendMsgCallFunByNpc(BaoLvSFOBJ.NPC, "baoLvShenFuNpc", "onClickStartBtn", 1)
    end)
    GUI:addOnClickEvent(self.ui.startBtn2, function ()
        if self.is_running then
            return
        end
        SendMsgCallFunByNpc(BaoLvSFOBJ.NPC, "baoLvShenFuNpc", "onClickStartBtn", 0)
    end)
end

function BaoLvSFOBJ:showUIRewardItem()
    for k, v in pairs(self.cfg) do
        local index = tonumber(v)
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = false              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], setData)
    end
end

function BaoLvSFOBJ:showOpenInfo()
    if nil == self.rich_list then
        self.rich_list = {}
    end
    for k, v in pairs(self.rich_list) do
        GUI:removeFromParent(v)
    end
    local str = string.format(self.title[1], self.lf_open_count)
    local rich1 = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_lf_count", 558, 225, str, 400, 18, "#ffffff")

    str = string.format(self.title[2], FormatSecond2CN_DHMS2(self.remain_time))
    if self.red_width then
        GUI:removeFromParent(self.red_width)  
        self.red_width = nil
    end
    if self.remain_time == 0 then
        str = string.format(self.title[2], "已恢复")
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.startBtn2)
        end
    end
    local rich2 = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_lf_time", 558, 200, str, 400, 18, "#ffffff")
    self.rich_list = {rich1, rich2}

    self:updateRemainTime()
end

function BaoLvSFOBJ:flushView(index, lf_count, time)
    self.lf_open_count = tonumber(lf_count)
    self.remain_time = tonumber(time)
    self:showOpenInfo()
    self:lotteryAnim(tonumber(index))
    self:updateRemainTime()
end

function BaoLvSFOBJ:updateRemainTime()
    if self.remain_time > 0 then
        self:unSchedule()
        local function callback()
            self.remain_time = self.remain_time - 1
            if self.remain_time < 0 then
                self:unSchedule()
            else
                self:showOpenInfo()
            end
        end
        self._schedule_id = SL:Schedule(callback, 1)
    else
        self:unSchedule()
    end
end

function BaoLvSFOBJ:onClose()
    self:unSchedule()
    self.rich_list = {}
    if self.red_width then
        GUI:removeFromParent(self.red_width)  
        self.red_width = nil
    end
end

function BaoLvSFOBJ:unSchedule()
    if self._schedule_id then
        SL:UnSchedule(self._schedule_id)
        self._schedule_id = nil
    end
end

function BaoLvSFOBJ:lotteryAnim(gift_idx)
    self.is_running = true
    self.old_idx = self.old_idx or 1
    GUI:setEnabled(self.ui.startBtn1,false)
    GUI:setEnabled(self.ui.startBtn2,false)
    local maxNum = 9        --奖励道具上限
    local turnsNum = 2      --轮盘空转圈数
    local start_idx = self.old_idx
    local randomNum = turnsNum * maxNum
    local anim_num = randomNum - ((self.old_idx + randomNum) % maxNum - gift_idx) --动画次数
    local actionList = {}
    for i = 1,anim_num do
        start_idx = (self.old_idx + i) % maxNum
        local cur_idx = start_idx == 0 and maxNum or start_idx
        local delayTime = 0.05
        if i <= 3 then
            --变快
            delayTime = 0.4 - 0.1 * i
        elseif i >= anim_num - 3 then
            --变慢
            delayTime = 0.1 + 0.1 * (i + 3 - anim_num)
        end
        actionList[#actionList + 1] = GUI:DelayTime(delayTime)
        actionList[#actionList + 1] = GUI:CallFunc(function()
            local pos = GUI:getPosition(self.ui["ItemShow_"..cur_idx])
            GUI:setPosition(self.ui.select_img, pos.x, pos.y)
        end)
        if i == anim_num then
            actionList[#actionList + 1] = GUI:CallFunc(function ()
                GUI:setEnabled(self.ui.startBtn1,true)
                GUI:setEnabled(self.ui.startBtn2,true)
                self.is_running = false
            end)
        end
    end
    self.old_idx = gift_idx
    GUI:runAction(self._parent, GUI:ActionSequence(actionList))
end

local function onClickNpc(npc_info)
    if npc_info.index == BaoLvSFOBJ.NPC then
        SendMsgClickNpc(BaoLvSFOBJ.NPC.."#baoLvShenFuNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "BaoLvSFOBJ", onClickNpc)

return BaoLvSFOBJ