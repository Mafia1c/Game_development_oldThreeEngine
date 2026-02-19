local WuXingZhiLiOBJ = {}
WuXingZhiLiOBJ.Name = "WuXingZhiLiOBJ"
WuXingZhiLiOBJ.cfg = SL:Require("GUILayout/config/wuxingzhiliCfg",true)
WuXingZhiLiOBJ.RunAction = true
WuXingZhiLiOBJ.NPC = 102
--[[
装备名  界面特效  装备位置 附加属性  属性ID
坚韧之心    15001   81  HP/MP       1
狂怒之心    15005   82  攻魔道伤    35
制裁之刃    15008   83  PK增伤      76
荆棘之力    15009   84  PK减伤      77
宗师之威    15010   85  对怪增伤    75
]]
local _page_cfg = {
    [1] = {
        id = 50615,
        name = "坚韧之躯",
        effect = 15001,
        equipPos = 81,
        attrTxt = "HP/MP",
        attrId = 1
    },
    [2] = {
        id = 50616,
        name = "狂怒之心",
        effect = 15005,
        equipPos = 82,
        attrTxt = "攻魔道伤",
        attrId = 35
    },
    [3] = {
        id = 50617,
        name = "制裁之殇",
        effect = 15008,
        equipPos = 83,
        attrTxt = "PK增伤",
        attrId = 76
    },
    [4] = {
        id = 50618,
        name = "荆棘之力",
        effect = 15009,
        equipPos = 84,
        attrTxt = "PK减伤",
        attrId = 77
    },
    [5] = {
        id = 50619,
        name = "宗师之威",
        effect = 15010,
        equipPos = 81,
        attrTxt = "对怪增伤",
        attrId = 75
    }
}
function WuXingZhiLiOBJ:main(...)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WuXingZhiLiUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = 1
    self.curr_play_eff = nil
    self.page_cfg = _page_cfg
    self.table = {...}
    self.red_width_list = {}

    self:initClickEvent()

    self:showCellInfo()
    self:updateUiInfo()
    self:FlushListRed()
end

function WuXingZhiLiOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.startBtn, function()
        SendMsgCallFunByNpc(WuXingZhiLiOBJ.NPC, "WuXingZhiLi", "onClickImprove", self.cur_select_index)
    end)

    for i = 1, 5 do
        GUI:addOnClickEvent(self.ui["cell_"..i], function()
            if i == self.cur_select_index then
                return
            end
            self.cur_select_index = i
            self:updateUiInfo()
        end)
    end
end

function WuXingZhiLiOBJ:showCellInfo()
    for k, v in pairs(self.page_cfg) do
        local setData  = {}
        setData.index = v.id                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], setData)

        GUI:Text_setString(self.ui["item_name"..k], v.name .. "Lv" .. self.table[k])

        local pos_y = 500 - k * 82 - (k - 1) * 2
        GUI:setPositionY(self.ui["cell_"..k], pos_y)
    end
end

function WuXingZhiLiOBJ:flushView(...)
    self.table = {...}
    for k, v in pairs(self.page_cfg) do
        GUI:Text_setString(self.ui["item_name"..k], v.name .. "Lv" .. self.table[k])
    end
    self:showNeedItem()
    self:showAttrInfo()
    self:FlushListRed()
end

function WuXingZhiLiOBJ:updateUiInfo()
    local cfg = self.page_cfg[self.cur_select_index]
    if self.curr_play_eff then
        GUI:removeFromParent(self.curr_play_eff)
        self.curr_play_eff = nil
    end
    local effect = GUI:Effect_Create(self.ui.effect_node, cfg.effect, -200, 256, 0, cfg.effect)
    GUI:setScale(effect, 0.8)
    self.curr_play_eff = effect

    local pos_y = GUI:getPositionY(self.ui["cell_"..self.cur_select_index])
    GUI:setPosition(self.ui.select_img, 0, pos_y)

    self:showNeedItem()
    self:showAttrInfo()
end

function WuXingZhiLiOBJ:showNeedItem()
    local level = tonumber(self.table[self.cur_select_index])
    local _cfg = self.cfg[level]

    local wcs_num = SL:GetMetaValue("ITEM_COUNT", _cfg["needItem_wcs"])
    local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", _cfg["needItem_cl"])
    local yb_num = tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", item_id))
    
    local setData  = {}
    setData.index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", _cfg["needItem_wcs"])
    setData.look  = true                  -- 是否显示tips
    setData.bgVisible = true              -- 是否显示背景框
    setData.count = _cfg["itemNum1"]                     -- 物品数量
    setData.color = wcs_num < setData.count and 249 or 250                   -- 数量文本颜色
    setData.showCount = true
    ItemShow_updateItem(self.ui["ItemShow_"..6], setData)
    setData.index = item_id
    setData.count = _cfg["itemNum2"]
    setData.color = yb_num < setData.count and 249 or 250
    ItemShow_updateItem(self.ui["ItemShow_"..7], setData)
    self:flushBtnRed(wcs_num >= _cfg["itemNum1"]   and yb_num >= _cfg["itemNum2"] and level < 50)
end
function WuXingZhiLiOBJ:flushBtnRed(is_show_red)
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

function WuXingZhiLiOBJ:FlushListRed()
    for i=1,5 do
        local level = tonumber(self.table[i])
        local _cfg = self.cfg[level]
        local wcs_num = SL:GetMetaValue("ITEM_COUNT", _cfg["needItem_wcs"])
        local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", _cfg["needItem_cl"])
        local yb_num = tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", item_id))
        local is_show = wcs_num >= _cfg["itemNum1"] and yb_num >= _cfg["itemNum2"] and level < 50
        if is_show then
            if self.red_width_list[i] == nil then
                self.red_width_list[i] = SL:CreateRedPoint(self.ui["cell_"..i],{x = 10,y=10})
            end
        else
            removeOBJ(self.red_width_list[i],self)
            self.red_width_list[i] = nil
        end
    end
end

function WuXingZhiLiOBJ:showAttrInfo()
    local _cfg = self.page_cfg[self.cur_select_index]
    local level = tonumber(self.table[self.cur_select_index])
    local job = SL:GetMetaValue("JOB")                      -- 0.战  1.法  2.道
    local _cur_cfg = self.cfg[level]
    local _next_cfg = self.cfg[level + 1] or self.cfg[50]
    local keys = {[0] = "zhanHp", [1] = "faHp", [2] = "daoHP"}
    local cur_value = _cur_cfg["display_sx"]                -- 当前属性
    local next_value = _next_cfg["display_sx"]              -- 升级属性
    local suffix = "%"
    if self.cur_select_index == 1 then
        local key = keys[job]
        cur_value = _cur_cfg[key]
        next_value = _next_cfg[key]
        suffix = ""
    end

    GUI:Text_setString(self.ui.cur_att_txt, _cfg.attrTxt..": " .. cur_value .. suffix)
    GUI:Text_setString(self.ui.next_attr_txt, _cfg.attrTxt..": " .. next_value .. suffix)
end

function WuXingZhiLiOBJ:onClose()
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    for k,v in pairs(self.red_width_list) do
        removeOBJ(v,self)
    end 
    self.red_width_list = {}
end

local function onClickNpc(npc_info)
    if npc_info.index == WuXingZhiLiOBJ.NPC then
        SendMsgClickNpc(npc_info.index.."#".."WuXingZhiLi")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "WuXingZhiLiOBJ", onClickNpc)

return WuXingZhiLiOBJ