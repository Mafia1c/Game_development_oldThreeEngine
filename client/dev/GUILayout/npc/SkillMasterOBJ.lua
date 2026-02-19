local SkillMasterOBJ = {}
SkillMasterOBJ.Name = "SkillMasterOBJ"
SkillMasterOBJ.NPC = 125
SkillMasterOBJ.RunAction = true
SkillMasterOBJ.cfg = SL:Require("GUILayout/config/skillMasterCfg", true)

SkillMasterOBJ.skill_info = {
    {26, "<烈火剑法强化5重/FCOLOR=239><觉醒印记：/FCOLOR=251><炎魔印/FCOLOR=245><效果：几率灼烧目标10秒，(自身攻击力*10%)/FCOLOR=250>"},
    {39, "<开天斩强化5重/FCOLOR=239>  <觉醒印记：/FCOLOR=251><冰魔印/FCOLOR=245><效果：几率冰冻目标1秒/FCOLOR=250>"},
    {34, "<逐日剑法强化5重/FCOLOR=239><觉醒印记：/FCOLOR=251><血魔印/FCOLOR=245><效果：几率吸取目标10%当前血量回复自身/FCOLOR=250>"},
    {22, "<火墙强化5重/FCOLOR=239>    <觉醒印记：/FCOLOR=251><魔咒印/FCOLOR=245><效果：几率使目标感染红绿毒，持续30秒/FCOLOR=254>"},
    {31, "<魔法盾强化5重/FCOLOR=239>  <觉醒印记：/FCOLOR=251><金刚印/FCOLOR=245><效果：开盾状态下，每损失5%血量，增加减伤1%/FCOLOR=254>"},
    {37, "<流星火雨强化5重/FCOLOR=239><觉醒印记：/FCOLOR=251><飞龙印/FCOLOR=245><效果：几率召唤流星，在3*3范围造成10%HP真伤/FCOLOR=254>"},
    {13, "<灵魂火符强化5重/FCOLOR=239><觉醒印记：/FCOLOR=251><修罗印/FCOLOR=245><效果：几率对目标造成定身效果，持续1秒/FCOLOR=243>"},
    {55, "<召唤月灵强化5重/FCOLOR=239><觉醒印记：/FCOLOR=251><契约印/FCOLOR=245><效果：召唤月灵最大召唤数量+1/FCOLOR=243>"},
    {51, "<飓风破强化5重/FCOLOR=239>  <觉醒印记：/FCOLOR=251><暴风印/FCOLOR=245><效果：几率在3*3范围释放飓风伤害(道术*120%)/FCOLOR=243>"}
}

function SkillMasterOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/SkillMasterUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_page_index = 1
    self.skill_name_list = {}
    self.cur_select_skill = nil
    self.skill_rich_list = nil
    self.skill_level_info = SL:JsonDecode(sMsg, true)

    self:initClickEvent()
    self:initSkillData()
    self:createRuleItemCells()
    self:onPageChange()

    for i = 1, 2 do
        local setData  = {}
        setData.index = 0                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)
    end
    GUI:setVisible(self.ui.select_img, self.cur_select_skill ~= nil)
end

function SkillMasterOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(SkillMasterOBJ.Name)
    end)

    GUI:addOnClickEvent(self.ui.upBtn, function ()
        if nil == self.cur_select_skill then
            return
        end
        SendMsgCallFunByNpc(SkillMasterOBJ.NPC, "SkillMasterNpc", "onClickUpBtn", self.cur_select_skill)
    end)

    for i = 1, 2 do
        GUI:addOnClickEvent(self.ui["pageBtn_"..i], function ()
            self:onPageChange(i)
        end)
    end

    for i = 1, 3 do
        for j = 1, 4 do
            GUI:addOnClickEvent(self.ui["skill_img_"..i.."_"..j], function ()
                local index = (i - 1) * 4 + j
                if self.cur_select_skill == index then
                    return
                end
                self.cur_select_skill = (i - 1) * 4 + j
                self:showSkillInfo(self.cur_select_skill)

                local pos = GUI:getPosition(self.ui["skill_img_"..i.."_"..j])
                GUI:setPosition(self.ui.select_img, pos.x, pos.y)
                GUI:setVisible(self.ui.select_img, self.cur_select_skill ~= nil)
            end)
        end
    end
end

function SkillMasterOBJ:initSkillData()
    local icon_path = "res/custom/npc/27jnds/icon/"
    local job = SL:GetMetaValue("JOB")
    local format = "<%s/FCOLOR=255><Lv.%s/FCOLOR=%d>"
    local index = 1
    for i = 1, 3 do
        local v = self.cfg[i]
        local skill_id_tab = SL:Split(v.skillid_def, "#")
        local job_skill = v.skillid_pow[job + 1]
        skill_id_tab[#skill_id_tab + 1] = job_skill
        for j = 1, 4 do
            local skill_id = skill_id_tab[j]
            local cfg = SL:GetMetaValue("SKILL_CONFIG", tonumber(skill_id))
            local path = icon_path..cfg.icon
            GUI:Image_loadTexture(self.ui["skill_img_"..i.."_"..j], path..".png")
            local level = self.skill_level_info[index] or 0
            local name = SL:GetMetaValue("SKILL_NAME", tonumber(skill_id_tab[j]))
            local str = string.format(format, name, level, j == 4 and 253 or 250)
            local name_rich = GUI:RichTextFCOLOR_Create(self.ui["name_bg_"..index], "_skill_name"..index, 0, 5, str, 110, 16, "#ffffff")
            local data = {}
            data.node = name_rich
            data.name = name
            self.skill_name_list[index] = data
            index = index + 1
        end
    end
end

function SkillMasterOBJ:onPageChange(page)
    if page == self.cur_page_index then
        return
    end
    self.cur_page_index = page or 1
    GUI:setVisible(self.ui.page_node1, self.cur_page_index == 1)
    GUI:setVisible(self.ui.page_node2, self.cur_page_index == 2)
    GUI:Image_loadTexture(self.ui.bg_Image, self.cur_page_index == 1 and "res/custom/npc/27jnds/bg1.png" or "res/custom/npc/27jnds/bg3.png")
end

function SkillMasterOBJ:flushView(index, level)
    local _index = tonumber(index) or index
    self.skill_level_info[_index] = level
    local data = self.skill_name_list[_index]
    if data and data.node then
        GUI:removeFromParent(data.node)
        data.node = nil
    end
    local name = string.format("<%s/FCOLOR=255><Lv.%s/FCOLOR=%d>", data.name, level, _index % 4 == 0 and 253 or 250)
    local new_rich = GUI:RichTextFCOLOR_Create(self.ui["name_bg_"..index], "_skill_name"..index, 0, 5, name, 110, 16, "#ffffff")
    data.node = new_rich
    self:showSkillInfo(_index)
end

function SkillMasterOBJ:showSkillInfo(index)
    if self.skill_rich_list then
        for k, v in pairs(self.skill_rich_list) do
            GUI:removeFromParent(v)
        end
        self.skill_rich_list = nil
    end
    local data = self.skill_name_list[index]
    local level = self.skill_level_info[index] or 0
    local name = "<" .. data.name .. "/FCOLOR=242>"
    local str1 = "<技能防御: %s%%/FCOLOR=251>"
    local str2 = "<技能防御: %s%%/FCOLOR=249>"
    local str3 = nil
    local str4 = nil
    local _pos1 = {{x = 628, y = 387}, {x = 626, y = 363}}
    local _pos2 = {{x = 628, y = 235}, {x = 626, y = 210}}
    if self.cur_select_skill % 4 == 0 then
        str1 = "<技能威力: %s%%/FCOLOR=251>"
        str2 = "<技能威力: %s%%/FCOLOR=249>"
        str3 = "<强化至3级时提升技能效果/FCOLOR=251>"
        str4 = "<强化至5级时觉醒技能印记/FCOLOR=253>"
        _pos2 = {{x = 628, y = 255}, {x = 626, y = 232}, {x = 626, y = 205}, {x = 626, y = 182}}
    end
    local _list1 = {name, str1}
    local _list2 = {name, str2, str3, str4}
    local tmp_list = {}
    local function createRichTxt(parent, tab, tab2, value)
        local _cfg = self.cfg.attribute_def
        if self.cur_select_skill % 4 == 0 then
            _cfg = self.cfg.attribute_pow
        end
        _cfg = SL:Split(_cfg, "#")
        value = value + level
        if value >= 5 then
            value = 5
        end
        for k, v in pairs(tab) do
            local pos = tab2[k]
            local str = string.format(v, _cfg[value + 1])
            local rich = GUI:RichTextFCOLOR_Create(parent, "_rich"..#tmp_list + 1, pos.x, pos.y, str, 400, 18, "#ffffff")
            GUI:setAnchorPoint(rich, 0.5, 0.5)
            tmp_list[#tmp_list + 1] = rich
        end
    end
    createRichTxt(self.ui.page_node1, _list1, _pos1, 0)
    createRichTxt(self.ui.page_node1, _list2, _pos2, 1)
    self.skill_rich_list = tmp_list

    local need_sy = self.cfg.needitem_sy[level + 1] or self.cfg.needitem_sy[#self.cfg.needitem_sy]
    local need_jgs = self.cfg.needitem_jgs[level + 1] or self.cfg.needitem_jgs[#self.cfg.needitem_jgs]
    local color1 = 249
    local color2 = 249
    local money_value = SL:GetMetaValue("MONEY_ASSOCIATED", 5)
    if tonumber(money_value or 0) >= need_jgs then
        color2 = 250
    end
    if SL:GetMetaValue("ITEM_COUNT", 10134) >= need_sy then
        color1 = 250
    end
    local _money = {
        {10134, need_sy, color1},
        {5, need_jgs, color2}
    }
    for i = 1, 2 do
        local v = _money[i]
        local index = v[1]
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = v[2]                     -- 物品数量
        setData.color = v[3]
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)
    end
end

function SkillMasterOBJ:createRuleItemCells()
    self.item_cells = {}
    local str = "<>"
    for i = 1, #self.skill_info do
        local cfg = self.skill_info[i]
        local cell = GUI:Image_Create(self.ui.ListView_1, "_cell"..i, 0, 0, "res/custom/npc/27jnds/rq1.png")
        local icon = GUI:Image_Create(cell, "_icon"..i, 17, 8, "res/custom/npc/27jnds/icon/"..cfg[1]..".png")
        local rich = GUI:RichTextFCOLOR_Create(cell, "_rich"..i, 90, 25, cfg[2], 650, 16, "#ffffff")
        self.item_cells[i] = cell
    end
end

local function onClickNpc(npc_info)
    if npc_info.index == SkillMasterOBJ.NPC then
        SendMsgClickNpc(SkillMasterOBJ.NPC .. "#SkillMasterNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "SkillMasterOBJ", onClickNpc)

return SkillMasterOBJ