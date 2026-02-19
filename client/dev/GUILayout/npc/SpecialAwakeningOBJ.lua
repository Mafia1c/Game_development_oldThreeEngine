local SpecialAwakeningOBJ = {}
SpecialAwakeningOBJ.Name = "SpecialAwakeningOBJ"
SpecialAwakeningOBJ.NPC = 116
local _cfg = SL:Require("GUILayout/config/SpecialAwakeningCfg",true)
SpecialAwakeningOBJ.cfg = _cfg
SpecialAwakeningOBJ.equip_cfg = {
    [1] = 13,
    [2] = 2,
    [3] = 9,
    [4] = 16
}
SpecialAwakeningOBJ.icon_path = "res/custom/npc/35jx/icon/%d_%d.png"
SpecialAwakeningOBJ.awakening_tips = {
    [1] = _cfg["斗笠"],
    [2] = _cfg["勋章"],
    [3] = _cfg["兵符"],
    [4] = _cfg["盾牌"]
}

function SpecialAwakeningOBJ:main(count)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/SpecialAwakeningUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_page_index = 1
    self.cur_equip_awakening_count = tonumber(count) or 0

    self:initClickEvent()
    self:updatePageBtnIconShow()
    self:showEquipData()
end

function SpecialAwakeningOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.startBtn, function()
        SendMsgCallFunByNpc(self.NPC, "SpecialAwakeningNpc", "onStartAwakening", self.equip_cfg[self.cur_page_index])
    end)

    for i = 1, 4 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            if i == self.cur_page_index then
                return
            end
            self.cur_page_index = i
            self:updatePageBtnIconShow()
            SendMsgCallFunByNpc(self.NPC, "SpecialAwakeningNpc", "onUiPageChange", self.equip_cfg[self.cur_page_index])
        end)
    end

    for i = 1, 5 do
        GUI:addOnClickEvent(self.ui["activation_img_"..i], function(type)
            local worldPos = GUI:convertToWorldSpace(self.ui["activation_img_"..i], 0, 0)
            worldPos.y = worldPos.y + 15
            local tips_cfg = self.awakening_tips[self.cur_page_index]
            GUI:ShowWorldTips(tips_cfg[i], worldPos, GUI:p(0.2, -1))
        end)
    end
end

function SpecialAwakeningOBJ:updatePageBtnIconShow()
    for i = 1, 4 do
        local btn = self.ui["Button_"..i]
        GUI:setVisible(GUI:getChildByName(btn, "Image_1"), self.cur_page_index == i)
    end
end

function SpecialAwakeningOBJ:showEquipData()
    local equip = SL:GetMetaValue("EQUIP_DATA", self.equip_cfg[self.cur_page_index]) or {}
    GUI:ItemShow_updateItem(self.ui["equipShow_1"], {index = equip.Index, look = true, bgVisible = false, count = 1, itemData  = equip, starLv = true})

    local __cfg = self.cfg[self.cur_equip_awakening_count]
    local tmp_list = {}
    if __cfg then
        for k, v in pairs(__cfg.need_map) do
            local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
            local data = {}
            data.index = item_id
            data.value = v
            local num = SL:GetMetaValue("ITEM_COUNT", k)
            data.color = 255
            if num < v then
                data.color = 249
            end
            tmp_list[#tmp_list + 1] = data
        end
        table.sort(tmp_list, function (a, b)
            return a.index > b.index
        end)
    end

    for i = 1, 2 do
        local v = tmp_list[i] or {}
        ItemShow_updateItem(self.ui["ItemShow_"..i], {index = v.index or 0, look = true, bgVisible = true, count = v.value or 1, showCount = true, color = v.color or 255})
    end

    local index = math.floor(self.cur_equip_awakening_count / 5)
    for i = 1, 5 do
        local img = self.ui["activation_img_"..i]
        local path = string.format(self.icon_path, self.cur_page_index - 1, i)
        GUI:Image_loadTexture(img, path)
        local is_grey = true
        if index >= i then
            is_grey = false
        end
        GUI:Image_setGrey(img, is_grey)
    end
    local prefix, key_name, suffix = self:getKeyName()
    local cur_attr_str = self.cfg[self.cur_equip_awakening_count][key_name]
    local next_attr_str = self.cfg[self.cur_equip_awakening_count + 1] and self.cfg[self.cur_equip_awakening_count + 1][key_name] or nil
    local _cur_tab = {}
    if cur_attr_str then
        _cur_tab = SL:Split(cur_attr_str, "#")
        cur_attr_str = prefix .. (_cur_tab[2] or 0) .. suffix
    else
        cur_attr_str = "未知错误!"
    end
    GUI:Text_setString(self.ui.left_txt, cur_attr_str)
    local _next_tab = {}
    if next_attr_str then
        _next_tab = SL:Split(next_attr_str, "#")
        next_attr_str = prefix .. (_next_tab[2] or 0) .. suffix
    else
        next_attr_str = "觉醒等级已满!"
    end
    GUI:Text_setString(self.ui.right_txt, next_attr_str)
end

function SpecialAwakeningOBJ:flushView(count)
    self.cur_equip_awakening_count = tonumber(count)
    self:showEquipData()
end

function SpecialAwakeningOBJ:getKeyName()
    local prefix = ""
    local key = "defense"
    local suffix = "%"
    if self.cur_page_index == 1 then
        prefix = "防御加成:  "
        key = "defense"
    end
    if self.cur_page_index == 2 then
        prefix = "生命加成:  "
        key = "hp"
    end
    if self.cur_page_index == 3 then
        prefix = "护甲穿透:  "
        key = "armor"
        suffix = ""
    end
    if self.cur_page_index == 4 then
        prefix = "魔御加成:  "
        key = "magicdef"
    end    
    return prefix, key, suffix
end

local function onClickNpc(npc_info)
    if npc_info.index == SpecialAwakeningOBJ.NPC then
        SendMsgClickNpc(npc_info.index.."#SpecialAwakeningNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "SpecialAwakeningOBJ", onClickNpc)

return SpecialAwakeningOBJ