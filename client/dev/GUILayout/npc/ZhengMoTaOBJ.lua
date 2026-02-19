local ZhengMoTaOBJ = {}
ZhengMoTaOBJ.Name = "ZhengMoTaOBJ"
ZhengMoTaOBJ.cfg = SL:Require("GUILayout/config/mapMoveData",true)
ZhengMoTaOBJ.RunAction = true
ZhengMoTaOBJ.NpcId = 263
ZhengMoTaOBJ.HideMain = true            -- 打开时隐藏主界面

function ZhengMoTaOBJ:main(npc_id, level)
    local ui_path = "npc/ZhengMoTaUI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[263]
    self.map_cfg_id = 263
    self.cur_level = tonumber(level) or 0
    GUI:LoadExport(parent, ui_path, function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
end

function ZhengMoTaOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.enterBtn, handler(self, self.enterMap))
    GUI:addOnClickEvent(self.ui.enterKfBtn, handler(self, self.enterKfMap))
    GUI:addOnClickEvent(self.ui.rewardBtn, handler(self, self.showReward))
end

function ZhengMoTaOBJ:enterMap()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoZMTMap", sMsg.."#1")
end

function ZhengMoTaOBJ:enterKfMap()
    local map_cfg = self.map_cfg
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoZMTMap", sMsg.."#2")
end

function ZhengMoTaOBJ:showReward()
    local str = "<个人挑战奖励/FCOLOR=251>\\<初次通过指定层数获得【称号】/FCOLOR=250>\\<称号晋升逐级替换/FCOLOR=250>\\<第10层   奖励   无知的初心/FCOLOR=253>\\<第15层   奖励   敬畏的黑夜/FCOLOR=253>\\<第20层   奖励   荆棘的宁静/FCOLOR=253>\\<第25层   奖励   迷失的国度/FCOLOR=253>\\<第30层   奖励   堕落的天使/FCOLOR=253>\\<第35层   奖励   秩序的混乱/FCOLOR=253>\\<第40层   奖励   信仰的秘密/FCOLOR=253>\\<第45层   奖励   无尽的雷鸣/FCOLOR=253>\\<第50层   奖励   魔神的召唤/FCOLOR=253>\\<第55层   奖励   众神的覆灭/FCOLOR=253>\\<第60层   奖励   宿命的羁绊/FCOLOR=253>\\<第65层   奖励   命运的抉择/FCOLOR=253>\\<第70层   奖励   黎明的前夕/FCOLOR=253>\\<第75层   奖励   无尽的挑战/FCOLOR=253>\\<第80层   奖励   极限的突破/FCOLOR=253>\\<第85层   奖励   重生·复仇女神/FCOLOR=253>\\<第90层   奖励   觉醒·毕方之炎/FCOLOR=253>\\<第95层   奖励   史诗·超越征程/FCOLOR=253>\\<第99层   奖励   宗师·开山立派/FCOLOR=253>"
    local pos = GUI:getWorldPosition(self.ui.rewardBtn)
    local data = {}
    data.str = str
    data.width = 224
    data.worldPos = {x = pos.x, y = pos.y - 70}
    data.anchorPoint = {x = 1, y = 1}
    SL:OpenCommonDescTipsPop(data)
end

function ZhengMoTaOBJ:flushView(...)
    local tab = {...}
end

function ZhengMoTaOBJ:updateViewInfo()
    local title = {
        {"玛法<【三英雄】/FCOLOR=243>最强的修行之地<【镇魔塔】/FCOLOR=250>", 350, 340},
        {"通关可获得<【声望】/FCOLOR=251>与超强<【修行称号】/FCOLOR=245>",360,308},
        {"个人挑战不限时间,跨服调整每1个小时准点刷新",329,275}
    }
    for k, v in pairs(title) do
        GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_title"..k, v[2], v[3], v[1], 600, 18, "#ffffff")
    end

    -- mini map
    local map_cfg = self.map_cfg
    local str = string.format("<挑战层数:  /FCOLOR=255><%s层/FCOLOR=250>", self.cur_level)
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_enter", 340, 100, str, 300, 18, "#00ff00")
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_tiaozhan", 500, 100, "挑战所需:  "..map_cfg.joinValue, 300, 18, "#ffffff")

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
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if ZhengMoTaOBJ.NpcId == npc_info.index then
        SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
        -- ViewMgr.open(ZhengMoTaOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ZhengMoTaOBJ", onClickNpc)

return ZhengMoTaOBJ