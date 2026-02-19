local OtherDimensionOBJ = {}
OtherDimensionOBJ.Name = "OtherDimensionOBJ"
OtherDimensionOBJ.cfg = SL:Require("GUILayout/config/mapMoveData",true)
OtherDimensionOBJ.NPC = 377
OtherDimensionOBJ.RunAction = true
OtherDimensionOBJ.HideMain = true            -- 打开时隐藏主界面

function OtherDimensionOBJ:main(state)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/OtherDimensionUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_state = tonumber(state) or 0
    self.day_state_txt = nil

    self:initClickEvent()
    self:showRewardItem()
end

function OtherDimensionOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.challengeBtn, function ()
        SendMsgCallFunByNpc(self.NPC, "GoToMapNpc", "GotoYJZMMap", self.NPC.."")
    end)
end

function OtherDimensionOBJ:showRewardItem()
    if self.day_state_txt then
        GUI:removeFromParent(self.day_state_txt)
        self.day_state_txt = nil
    end
    local str = "今日状态: <%s/FCOLOR=%d>"
    if self.cur_state == 0 then
        str = string.format(str, "未提交", 249)
    else
        str = string.format(str, "已提交", 250)
    end
    self.day_state_txt = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_state", 365, 60, str, 300, 18, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_open", 210, 35, "<开放条件:  /FCOLOR=250><五次合区开启+81级+每日提交10个恶魔挑战卷/FCOLOR=251>", 700, 18, "#ffffff")
    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_tips", 180, 10, "受异界之力影响:  <异界地图所有攻击伤害降低50%(除副本以外地图)/FCOLOR=249>", 700, 18, "#ffffff")

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

function OtherDimensionOBJ:flushView(state)
    self.cur_state = tonumber(state) or 0
    if self.day_state_txt then
        GUI:removeFromParent(self.day_state_txt)
        self.day_state_txt = nil
    end
    local str = "今日状态: <%s/FCOLOR=%d>"
    if self.cur_state == 0 then
        str = string.format(str, "未提交", 249)
    else
        str = string.format(str, "已提交", 250)
    end
    self.day_state_txt = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_state", 340, 60, str, 300, 18, "#ffffff")
end

function OtherDimensionOBJ:onClose()
end

local function onClickNpc(npc_info)
    if npc_info.index == OtherDimensionOBJ.NPC then
        SendMsgClickNpc(OtherDimensionOBJ.NPC.."#GoToMapNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "OtherDimensionOBJ", onClickNpc)

return OtherDimensionOBJ