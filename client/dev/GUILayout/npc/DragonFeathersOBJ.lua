local DragonFeathersOBJ = {}
DragonFeathersOBJ.Name = "DragonFeathersOBJ"
DragonFeathersOBJ.NPC = 333
DragonFeathersOBJ.cfg = SL:Require("GUILayout/config/DragonFeathersCfg",true)
-- StdMode = 78

local format = "<%s:  /FCOLOR=254><%s%%/FCOLOR=250><(1-10%%)/FCOLOR=243>"
local str_txt_tab = {
    "生命加成",
    "攻魔道伤",
    "暴击伤害",
    "物伤减少",
    "魔伤减少"
}

function DragonFeathersOBJ:main(attr_str)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/DragonFeathersUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.attr_tab = SL:JsonDecode(attr_str)

    self:initClickEvent()
    self:updateItemData()
end

function DragonFeathersOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.activationBtn, function()
        SendMsgCallFunByNpc(self.NPC, "DragonFeathersNpc", "onClickActivation", "1")
    end)

    for i = 1, 5 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            SendMsgCallFunByNpc(self.NPC, "DragonFeathersNpc", "onClickHuanYu", ""..i)
        end)
    end
end

function DragonFeathersOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.activationBtn)
        end
    end
end

function DragonFeathersOBJ:updateItemData()
    local _cfg = self.cfg[1]

    local is_show_red = true
    -- 激活材料
    local tmp_tab = {}
    for k, v in pairs(_cfg.nedd_map) do
        local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
        local data = {}
        data.index = item_id
        data.value = v
        data.name = k
        tmp_tab[#tmp_tab + 1] = data
    end
    table.sort(tmp_tab, function(a,b) return a.index > b.index end)
    for i = 1, 2 do
        local v = tmp_tab[i] or {}
        local num = SL:GetMetaValue("ITEM_COUNT", v.name)
        local color = 250
        if num < v.value then
            is_show_red = false
            color = 249
        end
        GUI:ItemShow_updateItem(self.ui["NeedItem_"..i], {index = v.index or 0, look = true, bgVisible = true, count = v.value or 1, color = color})
    end
    -- 幻羽材料
    for i = 1, 5 do
        local __cfg = self.cfg[i+1]
        local tmp = {}
        for k, v in pairs(__cfg.nedd_map) do
            local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
            local data = {}
            data.index = item_id
            data.value = v
            data.name = k
            tmp[#tmp + 1] = data
        end 
        table.sort(tmp, function(a, b) return a.index > b.index end)
        for k, v in pairs(tmp) do
            local num = SL:GetMetaValue("ITEM_COUNT", v.name)
            local color = 250
            if num < v.value then
                color = 249
            end
            local index = (i - 1) * 2 + k
            ItemShow_updateItem(self.ui["ItemShow_"..index], {index = v.index or 0, look = true, bgVisible = true, count = v.value or 1, color = color, showCount = true})
        end
    end

    self:createAttrTxt()
    self:flushRed(is_show_red and  equip == nil)
    local equip = SL:GetMetaValue("EQUIP_DATA", 21)
    GUI:setVisible(self.ui.activationBtn, equip == nil)
    GUI:setVisible(self.ui.activationIcon, equip ~= nil)
end

function DragonFeathersOBJ:createAttrTxt()
    if nil == self.attr_txt_list then
        self.attr_txt_list = {}
    end
    for k, v in pairs(self.attr_txt_list) do
        GUI:removeFromParent(v)
    end
    self.attr_txt_list = {}
    for k, v in ipairs(str_txt_tab) do
        local value = tonumber(self.attr_tab[k])
        if k < 3 then
            value = value / 100
        end
        local str = string.format(format, v, value)
        local rich = GUI:RichTextFCOLOR_Create(self.ui["itemCell_"..k], "_attr_txt"..k, 18, 17, str, 210, 16, "#ffffff")
        self.attr_txt_list[k] = rich
    end
end

function DragonFeathersOBJ:flushView(attr_str)
    self.attr_tab = SL:JsonDecode(attr_str)
    local equip = SL:GetMetaValue("EQUIP_DATA", 21)
     self:flushRed(equip == nil)
    GUI:setVisible(self.ui.activationBtn, equip == nil)
    GUI:setVisible(self.ui.activationIcon, equip ~= nil)

    self:createAttrTxt()
end

function DragonFeathersOBJ:onClose()
    self.attr_txt_list = {}
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

local function onClickNpc(npc_info)
    if npc_info.index == DragonFeathersOBJ.NPC then
        SendMsgClickNpc(npc_info.index.."#DragonFeathersNpc")
        -- ViewMgr.open(DragonFeathersOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "DragonFeathersOBJ", onClickNpc)

return DragonFeathersOBJ