local BloodstoneAwakeningOBJ = {}
BloodstoneAwakeningOBJ.Name = "BloodstoneAwakeningOBJ"
local __cfg = SL:Require("GUILayout/config/BloodstoneAwakeningCfg",true)
BloodstoneAwakeningOBJ.cfg = __cfg
BloodstoneAwakeningOBJ.NPC = 310
BloodstoneAwakeningOBJ.attr_tips_pos = {
    [1] = {x = 650, y = 410},
    [2] = {x = 650, y = 345},
    [3] = {x = 650, y = 275},
}
local special_ids = {}
for k, v in pairs(__cfg or {}) do
    if v.color == 249 then
        special_ids[#special_ids + 1] = v.key_name
    end
end
BloodstoneAwakeningOBJ.special_ids = special_ids

function BloodstoneAwakeningOBJ:main(id_str)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/BloodstoneAwakeningUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.attr_id_tab = SL:JsonDecode(id_str) or {}

    self:initClickEvent()
    self:showAttrData()
    self:showNeedItemData()

    local width = SL:GetMetaValue("SCREEN_WIDTH")
    local height = SL:GetMetaValue("SCREEN_HEIGHT")
    GUI:setContentSize(self.ui.maskLayout, width, height)
    GUI:setVisible(self.ui.maskLayout, false)
end

function BloodstoneAwakeningOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.ruleBtn, function()
        GUI:setVisible(self.ui.maskLayout, true)
    end)
    GUI:addOnClickEvent(self.ui.maskLayout, function()
        GUI:setVisible(self.ui.maskLayout, false)
    end)

    GUI:addOnClickEvent(self.ui.startBtn, function()
        local show_tips_pop = false
        for k, v in pairs(self.attr_id_tab) do
            if isInTable(self.special_ids, tonumber(v)) then
                show_tips_pop = true
                break
            end
        end
        if show_tips_pop then
            local data = {}
            data.str = "您有红色觉醒属性未锁定\n是否仍然继续重置"
            data.btnType = 2
            data.callback = function(atype, param)
                if atype == 1 then
                    SendMsgCallFunByNpc(self.NPC, "BloodstoneAwakeningNpc", "onClickAwakening", "")
                end
            end
            SL:OpenCommonTipsPop(data)
        else
            SendMsgCallFunByNpc(self.NPC, "BloodstoneAwakeningNpc", "onClickAwakening", "")
        end
    end)

    for i = 1, 3 do
        GUI:CheckBox_addOnEvent(self.ui["CheckBox_"..i], function (sender)
            local is_selected = GUI:CheckBox_isSelected(sender)
            local sMsg = is_selected and 1 or 0
            SendMsgCallFunByNpc(self.NPC, "BloodstoneAwakeningNpc", "onChangeLockState", i.."#"..sMsg)
        end)
    end
end

function BloodstoneAwakeningOBJ:showNeedItemData(index, value)
    if index then
        GUI:CheckBox_setSelected(self.ui["CheckBox_"..index], value == 1)
    end
    local lock_count = 0
    for i = 1, 3 do
        local is_selected = GUI:CheckBox_isSelected(self.ui["CheckBox_"..i])
        if is_selected then
            lock_count = lock_count + 1
        end
    end
    local _list = {
        [0] = "nolock",
        [1] = "onelock",
        [2] = "twolock",
        [3] = "threelock"
    }
    local key_name = _list[lock_count]
    local _cfg = self.cfg[key_name]
    local tmp_tab = {}
    for k, v in pairs(_cfg.needitem_map) do
        local color = 255
        local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
        local count = SL:GetMetaValue("ITEM_COUNT", item_id)
        if item_id <= 100 then
            count = tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", item_id))
        end
        if count < v then
            color = 249
        end
        local data = {
            index = item_id,
            value = v,
            color = color
        }
        tmp_tab[#tmp_tab + 1] = data
    end
    table.sort(tmp_tab, function(a, b) return a.index < b.index end)
    for k, v in pairs(tmp_tab) do
        GUI:ItemShow_updateItem(self.ui["needItem_"..k], {index = v.index, look = true, bgVisible = true, count = v.value, color = v.color})
    end
end

function BloodstoneAwakeningOBJ:flushView(id1, id2, id3)
    id2 = tonumber(id2)
    id3 = tonumber(id3)
    if id1 == "flushView" then
        self:showNeedItemData(id2, id3)
        return
    end
    id1 = tonumber(id1)
    if id1 and id1 ~= 0 then
        self:createAttrTxt(id1, 1)
        self.attr_id_tab[1] = id1
    end
    if id2 and id2 ~= 0 then
        self:createAttrTxt(id2, 2)
        self.attr_id_tab[2] = id2
    end
    if id3 and id3 ~= 0 then
        self:createAttrTxt(id3, 3)
        self.attr_id_tab[3] = id3
    end
end

function BloodstoneAwakeningOBJ:showAttrData()
    self.attr_txt_tab = {}
    for i = 1, 3 do
        local id = tonumber(self.attr_id_tab[i] or 0) or 0
        self:createAttrTxt(id, i)
    end
end

function BloodstoneAwakeningOBJ:createAttrTxt(id, index)
    local pos = self.attr_tips_pos[index]
    local node = self.attr_txt_tab[index]
    if node then
        GUI:removeFromParent(node)
        node = nil
    end
    local str = self:getAttrStr(id)
    node = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_attr_txt"..index, pos.x, pos.y, str, 500, 18, "#ffffff")
    GUI:setAnchorPoint(node, 0.5, 0)
    self.attr_txt_tab[index] = node
end

function BloodstoneAwakeningOBJ:getAttrStr(id)
    if nil == id or id == 0 then
        return "<未解锁觉醒属性/FCOLOR=7>"
    end
    local cfg = self.cfg[id]
    local str = "<%s/FCOLOR=%d>"
    return string.format(str, cfg.btnName, cfg.color)
end

function BloodstoneAwakeningOBJ:onClose()
    SL:CloseCommonTipsPop()
end

local function onClickNpc(npc_info)
    if npc_info.index == BloodstoneAwakeningOBJ.NPC then
        SendMsgClickNpc(npc_info.index.."#BloodstoneAwakeningNpc")
        -- ViewMgr.open(BloodstoneAwakeningOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "BloodstoneAwakeningOBJ", onClickNpc)

return BloodstoneAwakeningOBJ