local WuXingAwakeningOBJ = {}
WuXingAwakeningOBJ.Name = "WuXingAwakeningOBJ"
WuXingAwakeningOBJ.NPC = 250
local _cfg = SL:Require("GUILayout/config/WuXingAwakeningCfg",true)
WuXingAwakeningOBJ.cfg = _cfg
WuXingAwakeningOBJ.equip_cfg = {
    [1] = 81,
    [2] = 82,
    [3] = 83,
    [4] = 84,
    [5] = 85
}
WuXingAwakeningOBJ.icon_path = "res/custom/npc/55wx/icon/%d_%d.png"
WuXingAwakeningOBJ.awakening_tips = {
    [1] = _cfg["坚韧之躯"],
    [2] = _cfg["狂怒之心"],
    [3] = _cfg["制裁之殇"],
    [4] = _cfg["荆棘之力"],
    [5] = _cfg["宗师之威"]
}

function WuXingAwakeningOBJ:main(count)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WuXingAwakeningUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_page_index = 1
    self.cur_equip_awakening_count = tonumber(count) or 0

    self:initClickEvent()
    self:updatePageBtnIconShow(true)
    self:showEquipData()
end

function WuXingAwakeningOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.startBtn, function()
        SendMsgCallFunByNpc(WuXingAwakeningOBJ.NPC, "WuXingAwakeningNpc", "onStartAwakening", self.equip_cfg[self.cur_page_index])
    end)

    GUI:addOnClickEvent(self.ui.compoundBtn, function()
        self.cur_page_index = 6
        self:updatePageBtnIconShow()
    end)

    for i = 1, 6 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            if i == self.cur_page_index then
                return
            end
            self.cur_page_index = i
            self:updatePageBtnIconShow()
            
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

    for i = 1, 4 do
        GUI:addOnClickEvent(self.ui["ok_btn_"..i], function()
            SendMsgCallFunByNpc(WuXingAwakeningOBJ.NPC, "WuXingAwakeningNpc", "onClickCompound", i)
        end)
    end
end

function WuXingAwakeningOBJ:updatePageBtnIconShow(sendMsg)
    for i = 1, 6 do
        local btn = self.ui["Button_"..i]
        GUI:setVisible(GUI:getChildByName(btn, "Image_1"), self.cur_page_index == i)
    end
    local bg_path = "res/custom/npc/55wx/bg1.png"
    if self.cur_page_index == 6 then
        bg_path = "res/custom/npc/55wx/bg2.png"
    end
    GUI:Image_loadTexture(self.ui.FrameBG, bg_path)
    GUI:setVisible(self.ui.awakening, self.cur_page_index ~= 6)
    GUI:setVisible(self.ui.compound, self.cur_page_index == 6)
    if self.cur_page_index < 6 and not sendMsg then
        SendMsgCallFunByNpc(self.NPC, "WuXingAwakeningNpc", "onUiPageChange", self.equip_cfg[self.cur_page_index])
    else
        self:updateCompoundData()
    end
end

function WuXingAwakeningOBJ:showEquipData()
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
            tmp_list[#tmp_list + 1] = data
        end
        table.sort(tmp_list, function (a, b)
            return a.index > b.index
        end)
    end
    local is_show_red  = true
    for i = 1, 3 do
        local v = tmp_list[i] or {}
        local color = 255
        if v.index <= 100 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", v.index)) < v.value then
                color = 249
                is_show_red = false
            end
        else
            if SL:GetMetaValue("ITEM_COUNT", v.index) < v.value then
                color = 249
                is_show_red = false
            end
        end        
        ItemShow_updateItem(self.ui["ItemShow_"..i], {index = v.index or 0, look = true, bgVisible = true, count = v.value or 1, color = color, showCount = true})
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
        next_attr_str = "当前觉醒已满级!"
        is_show_red = false
    end
    SL:Print(self.cur_equip_awakening_count)
   self:flushRed(is_show_red)
    GUI:Text_setString(self.ui.right_txt, next_attr_str)
end

function WuXingAwakeningOBJ:flushView(count)
    self.cur_equip_awakening_count = tonumber(count)
    self:showEquipData()
end

function WuXingAwakeningOBJ:updateCompoundData()
    local index = 1
    for i = 1, 4 do
        local __cfg = self.cfg["compound"..i]
        local tmp_tab = {}
        for k, v in pairs(__cfg.needitem_map) do
            local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
            local color = 255
            if item_id <= 100 then
                if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", item_id)) < v then
                    color = 249
                end
            else
                if SL:GetMetaValue("ITEM_COUNT", item_id) < v then
                    color = 249
                end
            end
            local data = {
                item_id = item_id,
                value = v,
                color = color
            }
            tmp_tab[#tmp_tab + 1] = data
        end
        table.sort(tmp_tab, function(a, b) return a.item_id > b.item_id end)
        for j = 1, 2 do
            local v = tmp_tab[j]
            GUI:ItemShow_updateItem(self.ui["cailiao_"..index], {index = v.item_id, look = true, bgVisible = true, count = v.value, color = v.color})
            index = index + 1
        end
    end
end

function WuXingAwakeningOBJ:getKeyName()
    local prefix = ""
    local key = "Physical"
    local suffix = "%"
    if self.cur_page_index == 1 then
        prefix = "体力加成:  "
        key = "Physical"
    end
    if self.cur_page_index == 2 then
        prefix = "攻魔道伤加成:  "
        key = "gmd"
    end
    if self.cur_page_index == 3 then
        prefix = "受战减伤:  "
        key = "zhanshi"
    end
    if self.cur_page_index == 4 then
        prefix = "受法减伤:  "
        key = "fashi"
    end
    if self.cur_page_index == 5 then
        prefix = "受道减伤:  "
        key = "daoshi"
    end    
    return prefix, key, suffix
end

function WuXingAwakeningOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.startBtn)
        end
    end
end

function WuXingAwakeningOBJ:onClose( ... )
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end
local function onClickNpc(npc_info)
    if npc_info.index == WuXingAwakeningOBJ.NPC then
        SendMsgClickNpc(npc_info.index.."#WuXingAwakeningNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "WuXingAwakeningOBJ", onClickNpc)

return WuXingAwakeningOBJ