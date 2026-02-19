local ZodiacAwakeningOBJ = {}
ZodiacAwakeningOBJ.Name = "ZodiacAwakeningOBJ"
ZodiacAwakeningOBJ.NPC = 274
local _cfg = SL:Require("GUILayout/config/ZodiacAwakeningCfg",true)
ZodiacAwakeningOBJ.cfg = _cfg or {}

function ZodiacAwakeningOBJ:main(value)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ZodiacAwakeningUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = 1
    self.cur_awakening_attr_value = tonumber(value)

    self:initClickEvent()
    self:createZodiacBtnCell()
    self:showEquipData()
    self:updateNeedItemData()

    if self.cur_awakening_attr_value < 0 then
        GUI:Text_setString(self.ui.attrValue, "")
    else
        GUI:Text_setString(self.ui.attrValue, self.cur_awakening_attr_value)
    end
    local rich = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_title_tips1", 500, 178, "本次觉醒成功率: <20%/FCOLOR=250>", 200, 18, "#ffffff")
    GUI:setAnchorPoint(rich, 0.5, 0)

    GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_title_tips2", 200, 35, self.cfg.tipsStr, 550, 16, "#ffffff")
end

function ZodiacAwakeningOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.startBtn, function()
        SendMsgCallFunByNpc(ZodiacAwakeningOBJ.NPC, "ZodiacAwakeningNpc", "onStartAwakening", self.cur_select_index.."")
    end)

    for i = 1, 2 do
        GUI:addOnClickEvent(self.ui["fj_Btn_"..i], function()
            self:fenJieZodiacEquip(i)
        end)
    end
end

function ZodiacAwakeningOBJ:createZodiacBtnCell()
    GUI:ListView_removeAllItems(self.ui.btnList)
    self.col_btn_list = {}
    for i= 1, 12 do
        local v = self.cfg[i]
        local btn = GUI:Button_Create(self.ui.btnList, "_col2_cell"..i, 0, 0, "res/custom/sonBox.png")
        GUI:Button_setTitleFontSize(btn, 16)
        GUI:Button_setTitleText(btn, v.name)
        GUI:Button_setTitleColor(btn, 2 == self.cur_select_index and "#9b00ff" or "#ffffff")
        local img = GUI:Image_Create(btn, "_cell_img"..i, 0, 5, "res/public/1900000678.png")
        GUI:setVisible(img, i == self.cur_select_index)
        GUI:addOnClickEvent(btn, function()
            if i == self.cur_select_index then
                return
            end
            self.cur_select_index = i
            self:showEquipData(i)
            self:updateNeedItemData()
            for _k, _v in ipairs(self.col_btn_list) do
                GUI:setVisible(GUI:getChildByName(_v, "_cell_img".._k), _k == self.cur_select_index)
            end
            SendMsgCallFunByNpc(ZodiacAwakeningOBJ.NPC, "ZodiacAwakeningNpc", "onChangeZodiac", self.cur_select_index.."")
        end)
        self.col_btn_list[i] = btn
    end
end

function ZodiacAwakeningOBJ:fenJieZodiacEquip(type)
    SendMsgCallFunByNpc(ZodiacAwakeningOBJ.NPC, "ZodiacAwakeningNpc", "fenJieZodiacEquip", type)
end

function ZodiacAwakeningOBJ:flushView(value)
    self.cur_awakening_attr_value = tonumber(value)
    if self.cur_awakening_attr_value < 0 then
        GUI:Text_setString(self.ui.attrValue, "")
    else
        GUI:Text_setString(self.ui.attrValue, self.cur_awakening_attr_value)
    end
    self:showEquipData()
end

function ZodiacAwakeningOBJ:showEquipData(index)
    index = index or self.cur_select_index
    local cfg = self.cfg[index]
    local equip = SL:GetMetaValue("EQUIP_DATA", cfg.location) or {}
    GUI:ItemShow_updateItem(self.ui["equipShow_1"], {index = equip.Index, look = true, bgVisible = false, count = 1, itemData  = equip})
end

function ZodiacAwakeningOBJ:updateNeedItemData()
    local cfg = self.cfg[self.cur_select_index]
    local tmp_list = {}
    local is_show_red = true
    if cfg then
        local equip = SL:GetMetaValue("EQUIP_DATA", cfg.location)
        if equip == nil then
            is_show_red = false
        end 
        for k, v in pairs(cfg.needItem_map) do
            local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
            local data = {}
            data.index = item_id
            data.value = v
            local color = 255
            if item_id <= 100 then
                if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", item_id)) < v then
                    color = 249
                    is_show_red = false
                end
            else
                if SL:GetMetaValue("ITEM_COUNT", item_id) < v then
                    color = 249
                    is_show_red = false
                end
            end
            data.color = color
            tmp_list[#tmp_list + 1] = data
        end
        table.sort(tmp_list, function (a, b)
            return a.index > b.index
        end)
    end

    for i = 1, 2 do
        local v = tmp_list[i] or {}
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], {index = v.index or 0, look = true, bgVisible = true, count = v.value or 1, color = v.color or 249})
    end

    self:flushRed(is_show_red)
end

function ZodiacAwakeningOBJ:flushRed(is_show_red)
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
function ZodiacAwakeningOBJ:onClose( ... )
     if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

local function onClickNpc(npc_info)
    if npc_info.index == ZodiacAwakeningOBJ.NPC then
        SendMsgClickNpc(npc_info.index.."#ZodiacAwakeningNpc#1")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ZodiacAwakeningOBJ", onClickNpc)

return ZodiacAwakeningOBJ