local TianMingRootBoneOBJ = {}
TianMingRootBoneOBJ.Name = "TianMingRootBoneOBJ"
local __cfg = SL:Require("GUILayout/config/TianMingRootBoneCfg",true)
local tmp_tab = {}
for k, v in ipairs(__cfg) do
    tmp_tab[v.num] = tmp_tab[v.num] or {}
    table.insert(tmp_tab[v.num], v)
end
TianMingRootBoneOBJ.cfg = tmp_tab
TianMingRootBoneOBJ.RunAction = true
TianMingRootBoneOBJ.NPC = 256
TianMingRootBoneOBJ.effect_pos = {
    [1] = {x = -45, y = -7},
    [2] = {x = -64, y = -46},
    [3] = {x = -7, y = -54},
    [4] = {x = 27, y = -55},
    [5] = {x = -74, y = -48},
    [6] = {x = -103, y = -65},
    [7] = {x = -19, y = -129},
    [8] = {x = -20, y = -194},
    [9] = {x = -66, y = -130},
    [10] = {x = -61, y = -202}
}
TianMingRootBoneOBJ.rewardData = {
    [1] = 51023,
    [2] = 51024,
    [3] = 51025,
    [4] = 51026,
    [5] = 51027,
    [6] = 51028,
}

function TianMingRootBoneOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/TianmingRootBoneUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = nil
    self.level_tab = SL:JsonDecode(sMsg)
    self.cur_success_rate = 0

    self:initClickEvent()
    self:showRootBoneEffect()
    self:showRewardItem()

    GUI:ItemShow_updateItem(self.ui["needItem_1"], {index = 0, look = true, bgVisible = true, count = 0, color = 255})
    GUI:ItemShow_updateItem(self.ui["needItem_2"], {index = 0, look = true, bgVisible = true, count = 0, color = 255})
    GUI:Text_setString(self.ui.successRate, "")
end

function TianMingRootBoneOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.AwakeningBtn, function()
        if nil == self.cur_select_index then
            return
        end
        local cur_level = self.level_tab[self.cur_select_index]
        SendMsgCallFunByNpc(TianMingRootBoneOBJ.NPC, "TianMingRootBoneNpc", "onClickAwakening", self.cur_select_index.."#"..cur_level)
    end)

    for i = 1, 10 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            if i == self.cur_select_index then
                return
            end
            if self.cur_select_index then
                GUI:Button_setTitleColor(self.ui["Button_"..self.cur_select_index], "#ffffff")
            end
            GUI:Button_setTitleColor(self.ui["Button_"..i], "#ff0000")
            self.cur_select_index = i
            self:updateNeedItem(i)
            local cur_level = self.level_tab[i]
            local _cfg = self.cfg[cur_level][i]
            local success = _cfg.success
            self.cur_success_rate = success
            local is_selected = GUI:CheckBox_isSelected(self.ui.CheckBox_1)
            if is_selected then
                success = success + 10
            end
            GUI:Text_setString(self.ui.successRate, "成功几率: "..success.."%")
        end)
    end

    GUI:CheckBox_addOnEvent(self.ui.CheckBox_1, function (sender)
        local is_selected = GUI:CheckBox_isSelected(sender)
        local param = 0
        local rate = self.cur_success_rate
        if is_selected then
            param = 1
            rate = self.cur_success_rate + 10
        end
        GUI:Text_setString(self.ui.successRate, "成功几率: "..rate.."%")
        SendMsgCallFunByNpc(TianMingRootBoneOBJ.NPC, "TianMingRootBoneNpc", "onChangeSelectedState", param)
    end)
end

function TianMingRootBoneOBJ:updateNeedItem(i)
    local cur_level = self.level_tab[i]
    local _cfg = self.cfg[cur_level][i]
    local color1 = 255
    local item_id1 = SL:GetMetaValue("ITEM_INDEX_BY_NAME", _cfg.needitem1)
    local needValue1 = _cfg.itemnum1
    if SL:GetMetaValue("ITEM_COUNT", item_id1) < needValue1 then
        color1 = 249
    end
    GUI:ItemShow_updateItem(self.ui["needItem_1"], {index = item_id1, look = true, bgVisible = true, count = needValue1, color = color1})

    local color2 = 255
    local item_id2 = SL:GetMetaValue("ITEM_INDEX_BY_NAME", _cfg.needitem2)
    local needValue2 = _cfg.itemnum2
    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", item_id2)) < needValue2 then
        color2 = 249
    end
    GUI:ItemShow_updateItem(self.ui["needItem_2"], {index = item_id2, look = true, bgVisible = true, count = needValue2, color = color2})
end

function TianMingRootBoneOBJ:showRootBoneEffect()
    GUI:removeAllChildren(self.ui.effNode)
    local eff_id = 32100
    for i = 1, 10 do
        local level = tonumber(self.level_tab[i]) or 0
        if level > 6 then
            level = 6
        end
        local pos = self.effect_pos[i]
        local eff = GUI:Effect_Create(self.ui.effNode, "_eff_"..i, pos.x, pos.y, 0, eff_id + level * 10)
        eff_id = eff_id + 1
        local _cfg = self.cfg[level][i]
        GUI:Button_setTitleText(self.ui["Button_"..i], _cfg.btnName)
    end
end

function TianMingRootBoneOBJ:flushView(sMsg)
    if tonumber(sMsg) then
        GUI:CheckBox_setSelected(self.ui.CheckBox_1, false)
        if self.cur_select_index then
            GUI:Text_setString(self.ui.successRate, "成功几率: ".. self.cur_success_rate .."%")
        end
        return
    end
    self.level_tab = SL:JsonDecode(sMsg) or sMsg
    self:showRootBoneEffect()
    self:showRewardItem()
    self:updateNeedItem(self.cur_select_index)
end

function TianMingRootBoneOBJ:showRewardItem()
    local low_level = 6
    for k, v in pairs(self.level_tab) do
        if low_level > tonumber(v) then
            low_level = tonumber(v)
        end
    end
    local item_id = self.rewardData[low_level + 1] or self.rewardData[low_level]
    GUI:ItemShow_updateItem(self.ui["giveItem"], {index = item_id, look = true, bgVisible = true, count = 1})
end

local function onClickNpc(npc_info)
    if npc_info.index == TianMingRootBoneOBJ.NPC then
        SendMsgClickNpc(npc_info.index.."#TianMingRootBoneNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "TianMingRootBoneOBJ", onClickNpc)

return TianMingRootBoneOBJ