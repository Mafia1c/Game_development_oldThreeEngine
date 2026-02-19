local RecycleOBJ = {}
RecycleOBJ.Name = "RecycleOBJ"
local __cfg = SL:Require("GUILayout/config/recycleCfg", true)
local tmp = {}
local btn_names = {
    ["普通"] = 1,
    ["特殊"] = 2,
    ["高级"] = 3,
    ["灵符"] = 4,
}
for k, v in ipairs(__cfg) do
    local index = btn_names[v.tab]
    tmp[index] = tmp[index] or {}
    table.insert(tmp[index], v)
end
RecycleOBJ.cfg = tmp
RecycleOBJ.RunAction = true

function RecycleOBJ:main(sMsg, state)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/RecycleUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    if "" ~= sMsg then
        self.recycle_info = SL:JsonDecode(sMsg) or {}
    else
        self.recycle_info = {}
    end
    if "" ~= state then
        self.state_info = SL:JsonDecode(state) or {}
    else
        self.state_info = {}
    end
    self.cur_select_page = 1

    self:initClickEvent()
    self:updateBtnShow()

    for i = 1, 3 do
        local value = self.state_info[i] or "0"
        GUI:CheckBox_setSelected(self.ui["CheckBox_"..i], tonumber(value) == 1)
    end
end

function RecycleOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    for i = 1, 4 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            if i == self.cur_select_page then
                return
            end
            self:updateBtnShow(i)
        end)
    end
    GUI:addOnClickEvent(self.ui.allOkBtn, function()
        for k, v in pairs(self.check_box_list) do
            local index = GUI:getName(v)
            GUI:CheckBox_setSelected(v, true)
            SendMsgCallFunByNpc(0, "RecycleNpc", "onClickCheckBox", index.."#1")
            self.recycle_info[tonumber(index)] = "1"
        end
    end)
    GUI:addOnClickEvent(self.ui.allNoBtn, function()
        for k, v in pairs(self.check_box_list) do
            local index = GUI:getName(v)
            GUI:CheckBox_setSelected(v, false)
            SendMsgCallFunByNpc(0, "RecycleNpc", "onClickCheckBox", index.."#0")
            self.recycle_info[tonumber(index)] = "0"
        end
    end)
    GUI:addOnClickEvent(self.ui.clickBtn, function()
        SendMsgCallFunByNpc(0, "RecycleNpc", "onRecycleItem", self.cur_select_page)
    end)

    for i = 1, 3 do
        GUI:CheckBox_addOnEvent(self.ui["CheckBox_"..i], function (sender)
            local is_selected = GUI:CheckBox_isSelected(sender)
            local sMsg = i .. "#" .. (is_selected and 1 or 0)
            SendMsgCallFunByNpc(0, "RecycleNpc", "onClickAutoBtn", sMsg)
        end)
    end
end

function RecycleOBJ:updateBtnShow(index)
    self.cur_select_page = index or self.cur_select_page
    for i = 1, 4 do
        GUI:Button_loadTextureNormal(self.ui["Button_"..i], i == self.cur_select_page and "res/custom/npc/17hs/c.png" or "res/custom/npc/17hs/c1.png")
    end
    self:showRecycleInfo()
end

function RecycleOBJ:showRecycleInfo()
    GUI:ListView_removeAllItems(self.ui.infoList)
    self.check_box_list = {}
    local info = self.cfg[self.cur_select_page]
    for k, v in pairs(info) do
        local cell = GUI:Layout_Create(self.ui.infoList, "_cell"..k, 0, 0, 414, 46, true)
        local line = GUI:Image_Create(cell, "_line", 63, 0, "res/public/fengexian.png")
        local icon = GUI:Image_Create(cell, "_icon", 80, 13, "res/public/btn_npcfh_03.png")
        local txt = GUI:Text_Create(cell, "_txt", 104, 10, 18, "#FFFF00", v.type)
        GUI:Text_enableUnderline(txt)
        GUI:setTouchEnabled(txt, true)
        GUI:addOnClickEvent(txt, function ()
            local pos = GUI:getWorldPosition(txt)
            local data = {}
            data.str = string.format("<%s/FCOLOR=250>", v.totals)
            data.width = 224
            data.worldPos = {x = pos.x, y = pos.y + 20}
            data.anchorPoint = {x = 0, y = 0}
            SL:OpenCommonDescTipsPop(data)
        end)

        local type = GUI:Text_Create(cell, "_type", 258, 10, 18, "#FFFF00", v.tab)
        GUI:Text_enableUnderline(type)
        local check_box = GUI:CheckBox_Create(cell, v.key_name, 300, 8, "res/public/1900000550.png", "res/public/1900000551.png")
        GUI:CheckBox_addOnEvent(check_box, function (sender)
            local is_selected = GUI:CheckBox_isSelected(sender)
            local index = v.key_name
            SendMsgCallFunByNpc(0, "RecycleNpc", "onClickCheckBox", index.."#".. (is_selected and 1 or 0))
            self.recycle_info[tonumber(index)] = is_selected and 1 or 0
        end)
        self.check_box_list[k] = check_box
        local value = self.recycle_info[v.key_name] or 0
        GUI:CheckBox_setSelected(check_box, tonumber(value) == 1)
    end
end

return RecycleOBJ