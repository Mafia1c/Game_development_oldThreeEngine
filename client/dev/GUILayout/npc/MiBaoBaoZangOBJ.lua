local MiBaoBaoZangOBJ = {}
MiBaoBaoZangOBJ.Name = "MiBaoBaoZangOBJ"
MiBaoBaoZangOBJ.RunAction = true
local _cfg = SL:Require("GUILayout/config/MibaobaozangCfg",true)
local tmp_cfg = {}
for k, v in pairs(_cfg) do
    tmp_cfg[v.npcID] = v
end
MiBaoBaoZangOBJ.cfg = tmp_cfg

function MiBaoBaoZangOBJ:main(npc_id, state, count)
    local ui_path = "npc/MiBaoBaoZangUI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false, false, 9999999, 0)
    self._parent = parent
    GUI:LoadExport(parent, ui_path, function () end)
    self.ui = GUI:ui_delegate(parent)
    self.task_state = tonumber(state)
    self.npc_id = tonumber(npc_id)
    self.kill_mon_count = tonumber(count) or 0

    self.cur_npc_cfg = self.cfg[self.npc_id] or {}

    self:initClickEvent()
    self:updateTaskInfo()
    self:updateUi()
end

function MiBaoBaoZangOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.pickTaskBtn, handler(self, self.onPickTask))
end

function MiBaoBaoZangOBJ:onPickTask()
    SendMsgCallFunByNpc(self.npc_id, "BossSkullNpc", "onClickPickTask", self.npc_id)
end

function MiBaoBaoZangOBJ:updateTaskInfo()
    local task_type = self.cur_npc_cfg.type
    GUI:setVisible(self.ui.blInfo, task_type ~= 1)
    if task_type == 1 then
        local kill_str = string.format("<在本地图击杀任意怪物: /FCOLOR=250><%d/FCOLOR=251></%d/FCOLOR=249>", self.kill_mon_count, self.cur_npc_cfg.jindu)
        local kill = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_kill_str", 241, 283, kill_str, 400, 18, "#ffffff")
    else
        local str_tab = SL:Split(self.cur_npc_cfg.jindu, "&")
        for i = 1, 3 do
            local v = str_tab[i]
            if v then
                local _tab = SL:Split(v, "#")
                local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", _tab[1])
                local setData  = {}
                setData.index = index                 -- 物品Index
                setData.look  = true                  -- 是否显示tips
                setData.bgVisible = true              -- 是否显示背景框
                setData.count = 1                     -- 物品数量
                GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)

                GUI:Text_setString(self.ui["item_name_"..i], _tab[1])

                local count = SL:GetMetaValue("ITEM_COUNT", index)
                GUI:Text_setString(self.ui["info_"..i], count.."/".._tab[2])
            end
            GUI:setVisible(self.ui["ItemShow_"..i], v ~= nil)
        end
    end
    local tips_str = string.format("<%s/FCOLOR=243>", self.cur_npc_cfg.tips)
    local tsip = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_tips", 410, 133, tips_str, 700, 18, "#ffffff")
    GUI:setAnchorPoint(tsip, 0.5, 0)
end

function MiBaoBaoZangOBJ:updateUi()
    local str = "接收宝藏任务"
    if self.task_state == 1 then
        str = "提交宝藏任务"
    end
    GUI:Button_setTitleText(self.ui.pickTaskBtn, str)
    GUI:setVisible(self.ui.pickTaskBtn, self.task_state ~= 2)
    GUI:setVisible(self.ui.icon_tag, self.task_state == 2)
end

function MiBaoBaoZangOBJ:flushView(state)
    self.task_state = tonumber(state)
    self:updateUi()
end

function MiBaoBaoZangOBJ:onClose()
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    local cfg = MiBaoBaoZangOBJ.cfg[npc_info.index]
    if cfg then
        SendMsgCallFunByNpc(npc_info.index, "BossSkullNpc", "onClickNpc", npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, MiBaoBaoZangOBJ.Name, onClickNpc)

return MiBaoBaoZangOBJ