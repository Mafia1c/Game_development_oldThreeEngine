local SwordArmorMasterOBJ = {}
SwordArmorMasterOBJ.Name = "SwordArmorMasterOBJ"
local name_list = {"战神系列", "火龙系列", "天龙系列", "神龙系列", "聖龍系列"}
local tmp_cfg1, tmp_cfg2 = {}, {}
local _cfg = SL:Require("GUILayout/config/sbChangeCfg",true)
for k, v in ipairs(_cfg) do
    tmp_cfg1[v.tpye] = tmp_cfg1[v.tpye] or {}
    table.insert(tmp_cfg1[v.tpye], v)
    tmp_cfg1[v.tpye].name = name_list[v.tpye]
end
name_list = {[1] = "神兵附魔", [2] = "神甲附魔"}
_cfg = SL:Require("GUILayout/config/JianJiaFuMoCfg",true)
for i = 0, #_cfg do
    local v = _cfg[i]
    tmp_cfg2[v.index] = tmp_cfg2[v.index] or {}
    table.insert(tmp_cfg2[v.index], v)
    tmp_cfg2[v.index].name = name_list[v.index]
end
SwordArmorMasterOBJ.cfg = {
    [1] = tmp_cfg1,
    [2] = tmp_cfg2,
    [3] = tmp_cfg2
}
SwordArmorMasterOBJ.RunAction = true
SwordArmorMasterOBJ.NPC = 118
SwordArmorMasterOBJ.rule_cfg = {
    [1] = {
        "神兵附魔规则：",
        "神兵附魔1次，获得属性，功魔道伤2%",
        "神兵附魔2次，获得属性，功魔道伤4%",
        "神兵附魔3次，获得属性，功魔道伤6%",
        "神兵附魔4次，获得属性，功魔道伤8%",
        "神兵附魔5次，获得属性，功魔道伤10%",
        "神兵附魔6次，获得属性，功魔道伤12%",
        "神兵附魔7次，获得属性，功魔道伤15%，攻击速度1-10点",
        "神兵附魔7次，获得一次攻速加成，之后可选择重新洗练攻击速度"
    },
    [2] = {
        "神甲附魔规则：",
        "神甲附魔1次，获得属性，物理、魔法伤害减少1%",
        "神甲附魔2次，获得属性，物理、魔法伤害减少2%",
        "神甲附魔3次，获得属性，物理、魔法伤害减少3%",
        "神甲附魔4次，获得属性，物理、魔法伤害减少5%",
        "神甲附魔5次，获得属性，物理、魔法伤害减少7%",
        "神甲附魔6次，获得属性，物理、魔法伤害减少9%",
        "神甲附魔7次，获得属性，物理、魔法伤害减少12%，所有伤害反弹1-10%",
        "神甲附魔7次，获得一次所有伤害反弹，之后可选择重新洗练伤害反弹"     
    }
}

function SwordArmorMasterOBJ:main(...)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/SwordArmorMasterUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_page_index = 1
    self.cur_select_index = 1
    self.col_2btn_list = {}
    self.equip_data_list = {}
    self.cur_select_equip = nil

    self:initClickEvent()
    self:onPageChange()

    local width = SL:GetMetaValue("SCREEN_WIDTH")
    local height = SL:GetMetaValue("SCREEN_HEIGHT")
    GUI:setContentSize(self.ui.mask_layout, width, height)
    GUI:setVisible(self.ui.mask_layout, false)
end

function SwordArmorMasterOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.mask_layout, function()
        GUI:setVisible(self.ui.mask_layout, false)
    end)    

    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            self:onPageChange(i)
        end)
    end
    -- 开始附魔
    GUI:addOnClickEvent(self.ui.startFMBtn, function()
        local index = 0
        if self.cur_select_index == 1 then
            index = 1
        end
        SendMsgCallFunByNpc(SwordArmorMasterOBJ.NPC, "SwordArmorMasterNpc", "onClickEquipEnchant", index.."")
    end)

    -- 转移附魔
    GUI:addOnClickEvent(self.ui.zhuanFMBtn, function()
        local data = self.cur_select_equip or {MakeIndex = -1}
        SendMsgCallFunByNpc(SwordArmorMasterOBJ.NPC, "SwordArmorMasterNpc", "onClickZhuanYi", data.MakeIndex.."#"..self.cur_select_index)
    end)

    -- 规则
    GUI:addOnClickEvent(self.ui.ruleBtn, function()
        local txt_cfg = self.rule_cfg[self.cur_select_index]
        for i = 3, 11 do
            local v = txt_cfg[i - 2]
            GUI:Text_setString(self.ui["Text_"..i], v)
        end
        GUI:setVisible(self.ui.mask_layout, true)
    end)

    for i = 1, 18 do
        GUI:addOnClickEvent(self.ui["Image_btn_"..i], function()
            local data = self.equip_data_list[i]
            if nil == data then
                return
            end
            self.cur_select_equip = data
            self:updateSelectEquipState(i)
        end)
    end
end

function SwordArmorMasterOBJ:updateSelectEquipState(index)
    for j = 1, 18 do
        GUI:ItemShow_setItemShowChooseState(self.ui["ItemShow_"..j],  index == j)
    end
    if index == nil then
        self.cur_select_equip = nil
    end
    local item_id = self.cur_select_equip and self.cur_select_equip.Index or 0
    GUI:ItemShow_updateItem(self.ui["ItemShow_20"], {index = item_id, look = true, bgVisible = false, count = 1})
end

-- 二级菜单
function SwordArmorMasterOBJ:createCol2Btn()
    GUI:ListView_removeAllItems(self.ui.btnList_2)
    self.col_2btn_list = {}
    local _btn_cfg = self.cfg[self.cur_page_index] or {}
    for k, v in ipairs(_btn_cfg) do
        local btn = GUI:Button_Create(self.ui.btnList_2, "_col2_cell"..k, 0, 0, "res/custom/sonBox.png")
        GUI:Button_setTitleFontSize(btn, 18)
        GUI:Button_setTitleText(btn, v.name)
        GUI:Button_setTitleColor(btn, 2 == self.cur_page_index and "#9b00ff" or "#ffffff")
        local img = GUI:Image_Create(btn, "_cell_img"..k, 0, 5, "res/public/1900000678.png")
        GUI:setVisible(img, k == self.cur_select_index)
        GUI:addOnClickEvent(btn, function()
            if k == self.cur_select_index then
                return
            end
            self.cur_select_index = k
            if self.cur_page_index == 1 then
                self:showEquipSwapCell()
            elseif self.cur_page_index == 2 then
                SendMsgCallFunByNpc(SwordArmorMasterOBJ.NPC, "SwordArmorMasterNpc", "onClickEnchantPage", self.cur_select_index)
            else
                SendMsgCallFunByNpc(SwordArmorMasterOBJ.NPC, "SwordArmorMasterNpc", "onEnchantTransferPage", self.cur_select_index)
            end
            for _k, _v in ipairs(self.col_2btn_list) do
                GUI:setVisible(GUI:getChildByName(_v, "_cell_img".._k), _k == self.cur_select_index)
            end
        end)
        self.col_2btn_list[k] = btn
    end
end

-- 神兵互换
function SwordArmorMasterOBJ:showEquipSwapCell()
    GUI:ListView_removeAllItems(self.ui.ListView_1)
    local need_info = nil
    local __cfg = self.cfg[1][self.cur_select_index]
    for k = 1, #__cfg do
        local v = __cfg[k]
        local cell = GUI:Image_Create(self.ui.ListView_1, "_cell"..k, 0, 0, "res/custom/npc/16jj/1/rq.png")
        local data = {
            index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v.name),
            look = true,
            bgVisible = true
        }
        local item = GUI:ItemShow_Create(cell, "_item"..k, 16, 13, data)
        local name = GUI:Text_Create(cell, "_txt"..k, 100, 29, 18, "#ffffff", v.name)
        local img = GUI:Image_Create(cell, "_img"..k, 188, 27, "res/custom/npc/16jj/1/icon.png")
        local str = string.format("<%s/FCOLOR=250>", "兑换: "..v.givename)
        local rich = GUI:RichTextFCOLOR_Create(cell, "_rich"..k, 236, 29, str, 300, 18)
        local btn = GUI:Button_Create(cell, "_cell_btn"..k, 385, 26, "res/public/1900000611.png")
        GUI:Button_setTitleFontSize(btn, 18)
        GUI:Button_setTitleText(btn, "互换")
        GUI:addOnClickEvent(btn, function()
            SendMsgCallFunByNpc(SwordArmorMasterOBJ.NPC, "SwordArmorMasterNpc", "onClickExchange", v.key_name)
        end)
        need_info = v.need_map
    end
    local money_id = 1
    local value = 1
    if need_info then
        for k, v in pairs(need_info) do
            local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
            if item_id <= 100 then
                money_id = item_id
                value = v
                break
            end
        end
    end
    GUI:Text_setString(self.ui.Text_1, __cfg.name .. "互换消耗: ")
    local color = 255
    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", money_id)) < value then
        color = 249
    end
    GUI:ItemShow_updateItem(self.ui["needItem_1"], {index = money_id, look = true, bgVisible = true, count = value, color = color})
end

-- 剑甲附魔
function SwordArmorMasterOBJ:showEquipEnchant(count)
    local __cfg = self.cfg[2][self.cur_select_index]
    local index = 0
    local txt_str = "衣服"
    if self.cur_select_index == 1 then
        index = 1
        txt_str = "武器"
    end
    local equip = SL:GetMetaValue("EQUIP_DATA", index) or {}
    GUI:ItemShow_updateItem(self.ui["equipItem"], {index = equip.Index, look = true, bgVisible = false, count = 1, itemData  = equip})
    GUI:Text_setString(self.ui.Text_1, txt_str .. "附魔消耗: ")

    local need_info = __cfg[count + 1] and __cfg[count + 1].need_map or __cfg[count].need_map
    local tmp_list = {}
    for k, v in pairs(need_info) do
        local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
        local value = v
        local data = {
            item_id,
            value
        }
        if item_id > 100 then
            table.insert(tmp_list, 1, data)
        else
            table.insert(tmp_list, data)
        end
    end
    for i = 1, #tmp_list do
        local v = tmp_list[i]
        local color = 255
        if v[1] <= 100 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", v[1])) < v[2] then
                color = 249
            end
        else
            if SL:GetMetaValue("ITEM_COUNT", v[1]) < v[2] then
                color = 249
            end
        end
        GUI:ItemShow_updateItem(self.ui["needItem_"..i], {index = v[1], look = true, bgVisible = true, count = v[2], color = color})
    end
    GUI:removeAllChildren(self.ui.Image_2)

    local equip_name = SL:GetMetaValue("ITEM_NAME", equip.Index)
    if equip.Index == nil then
        equip_name = ""
    end
    local str = string.format("<附魔装备: %s/FCOLOR=250>", equip_name)
    local rich = GUI:RichTextFCOLOR_Create(self.ui.Image_2, "_rich_name", 142, 110, str, 300, 18)
    GUI:setAnchorPoint(rich, 0.5, 0.5)

    str = string.format("<附魔次数: %d/FCOLOR=251>", (count - 1) < 8 and (count - 1) or 7)
    rich = GUI:RichTextFCOLOR_Create(self.ui.Image_2, "_rich_count", 142, 80, str, 300, 18)
    GUI:setAnchorPoint(rich, 0.5, 0.5)
    self.fumo_rich_txt = rich

    str = string.format("<成功几率: %d%%/FCOLOR=251>", __cfg[1].probability)
    rich = GUI:RichTextFCOLOR_Create(self.ui.Image_2, "_rich_jilv", 142, 50, str, 300, 18)
    GUI:setAnchorPoint(rich, 0.5, 0.5)

    str = "<附魔属性查看右上方附魔规则/FCOLOR=250>"
    rich = GUI:RichTextFCOLOR_Create(self.ui.Image_2, "_rich_rule", 142, 20, str, 300, 18)
    GUI:setAnchorPoint(rich, 0.5, 0.5)

end

-- 附魔转移
function SwordArmorMasterOBJ:showEnchantTransfer(cur_count)
    local str_txt = "当前衣服"
    local index = 0
    local std_mode = {10, 11}
    if self.cur_select_index == 1 then
        index = 1
        str_txt = "当前武器"
        std_mode = {5, 6}
    end
    self.cur_select_equip = nil
    local equip = SL:GetMetaValue("EQUIP_DATA", index) or {}
    GUI:ItemShow_updateItem(self.ui["ItemShow_19"], {index = equip.Index, look = true, bgVisible = false, count = 1, itemData = equip})
    GUI:ItemShow_updateItem(self.ui["ItemShow_20"], {index = 0, look = true, bgVisible = false, count = 1})
    
    GUI:removeAllChildren(self.ui.Image_3)
    local equip_name = SL:GetMetaValue("ITEM_NAME", equip.Index)
    if equip.Index == nil then
        equip_name = ""
    end
    local str = string.format("<%s: %s/FCOLOR=250>", str_txt, equip_name)
    local rich = GUI:RichTextFCOLOR_Create(self.ui.Image_3, "_rich_name", 142, 120, str, 300, 18)
    GUI:setAnchorPoint(rich, 0.5, 0.5)

    str = string.format("<附魔次数: %d/FCOLOR=251>", cur_count)
    rich = GUI:RichTextFCOLOR_Create(self.ui.Image_3, "_rich_count", 142, 95, str, 300, 18)
    GUI:setAnchorPoint(rich, 0.5, 0.5)

    str = string.format("<成功几率: %d%%/FCOLOR=251>", 100)
    rich = GUI:RichTextFCOLOR_Create(self.ui.Image_3, "_rich_jilv", 142, 70, str, 300, 18)
    GUI:setAnchorPoint(rich, 0.5, 0.5)

    str = "<附魔属性: 点击上方装备查看/FCOLOR=250>"
    rich = GUI:RichTextFCOLOR_Create(self.ui.Image_3, "_rich_rule", 142, 45, str, 300, 18)
    GUI:setAnchorPoint(rich, 0.5, 0.5)

    str = "<若有强化属性,需重新穿戴装备/FCOLOR=249>"
    rich = GUI:RichTextFCOLOR_Create(self.ui.Image_3, "_rich_tip", 142, 20, str, 300, 18)
    GUI:setAnchorPoint(rich, 0.5, 0.5)

    local money_id = 7
    local color = 255
    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", money_id)) < 100 then
        color = 249
    end
    GUI:ItemShow_updateItem(self.ui["needItem_1"], {index = money_id, look = true, bgVisible = true, count = 100, color = color})

    self.equip_data_list = {}
    local bag_list = SL:GetMetaValue("BAG_DATA")
    for k, v in pairs(bag_list) do
        if isInTable(std_mode, v.StdMode) then
            table.insert(self.equip_data_list, v)
        end
    end
    for i = 1, 18 do
        local v = self.equip_data_list[i] or {}
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], {index = v.Index, look = false, bgVisible = false, count = 1})
    end
    GUI:Text_setString(self.ui.Text_1, (self.cur_select_index == 1 and "武器" or "衣服") .. "附魔转移消耗: ")
end

-- 附魔转移成功
function SwordArmorMasterOBJ:transferSuccess(index)
    self:updateSelectEquipState()
    local equip = SL:GetMetaValue("EQUIP_DATA", index) or {}
    GUI:ItemShow_updateItem(self.ui["ItemShow_19"], {index = equip.Index, look = true, bgVisible = false, count = 1, itemData = equip})
end

function SwordArmorMasterOBJ:onPageChange(index)
    if index == self.cur_page_index then
        return
    end
    self.cur_select_index = 1
    self.cur_page_index = index or 1
    local btn = self.ui["Button_"..self.cur_page_index]
    GUI:Button_setTitleText(self.ui.colTopBtn, GUI:Button_getTitleText(btn))
    for i = 1, 3 do
        GUI:setVisible(self.ui["page_"..i], i == self.cur_page_index)
        GUI:setVisible(GUI:getChildByName(self.ui["Button_"..i], "Image_1"), i == self.cur_page_index)
    end
    local bg_path = "res/custom/npc/16jj/%d/bg.png"
    GUI:Image_loadTexture(self.ui.FrameBG, string.format(bg_path, self.cur_page_index))
    GUI:setVisible(self.ui.needItem_2, 2 == self.cur_page_index)

    self:createCol2Btn()
    if self.cur_page_index == 1 then
        self:showEquipSwapCell()
    elseif self.cur_page_index == 2 then
        SendMsgCallFunByNpc(SwordArmorMasterOBJ.NPC, "SwordArmorMasterNpc", "onClickEnchantPage", self.cur_select_index)
    else
        SendMsgCallFunByNpc(SwordArmorMasterOBJ.NPC, "SwordArmorMasterNpc", "onEnchantTransferPage", self.cur_select_index)
    end
end

function SwordArmorMasterOBJ:flushView(index, count, is_zhuanyi)
    index = tonumber(index)
    count = tonumber(count)
    
    if is_zhuanyi == "123" then
        self:showEnchantTransfer(count)
    elseif is_zhuanyi == "234" then
        self:transferSuccess(index)
    else
        local equip = SL:GetMetaValue("EQUIP_DATA", index) or {}
        GUI:ItemShow_updateItem(self.ui["equipItem"], {index = equip.Index, look = true, bgVisible = false, count = 1, itemData  = equip})
        self:showEquipEnchant(count + 1)
    end
end

local function onClickNpc(npc_info)
    if npc_info.index == SwordArmorMasterOBJ.NPC then
        SendMsgClickNpc(npc_info.index.."#SwordArmorMasterNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "SwordArmorMasterOBJ", onClickNpc)

return SwordArmorMasterOBJ