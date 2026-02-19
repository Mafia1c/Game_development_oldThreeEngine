local TalismanOBJ = {}
TalismanOBJ.Name = "TalismanOBJ"
TalismanOBJ.NPC = 390
TalismanOBJ.cfg = SL:Require("GUILayout/config/TalismanCfg",true)
TalismanOBJ.attr_str = {
    [1] = "功魔道: %s-%s",
    [2] = "防魔御: %s-%s",
    [3] = "功魔道伤: %s%%",
    [4] = "次元之力: %s",
}
TalismanOBJ.tips_str = {
    "解封<[异界:次元兵符]/FCOLOR=250>，需佩戴<满觉醒[宗师兵符]/FCOLOR=250>，使用<[次元魔石]/FCOLOR=250>唤醒异界之力",
    "佩戴<[异界:次元兵符]/FCOLOR=250>，在<[异界地图]/FCOLOR=250>中，每<[击杀1只]/FCOLOR=250>怪物，可获得<[1点成长值]/FCOLOR=250>",
    "异界:次元兵符<[成长值累计满]/FCOLOR=250>后，可使用<[次元魔石]/FCOLOR=250>进行次元属性唤醒",
}

function TalismanOBJ:main(count, value)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/TalismanUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_wakeUp_count = tonumber(count) or 0             -- 当前唤醒次数   0.未解封   >0 次数
    self.cur_collect_value = tonumber(value) or 0

    self:initClickEvent()
    self:showUiInfo()

	-- Create EquipShow_1
	local EquipShow_1 = GUI:EquipShow_Create(self.ui["FrameLayout"], "EquipShow_1", 450, 320, 9, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = true, lookPlayer = false, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_1)
	GUI:setAnchorPoint(EquipShow_1, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_1, false)
	GUI:setTag(EquipShow_1, 0)

    local y = 90
    for k, v in pairs(self.tips_str) do
        GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_tips_"..k, 75, y, v , 700, 17, "#ffffff")
        y = y - 27
    end

    GUI:Image_loadTexture(self.ui.bg_Image, "res/custom/npc/90cy/bg22.png")
end

function TalismanOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.startBtn, function()
        if self.cur_wakeUp_count <= 0 then
            SendMsgCallFunByNpc(TalismanOBJ.NPC, "TalismanNpc", "onClickUnseal", TalismanOBJ.NPC)           -- 解封
        else
            SendMsgCallFunByNpc(TalismanOBJ.NPC, "TalismanNpc", "onClickWakeUp", TalismanOBJ.NPC)           -- 唤醒
        end
    end)
end

function TalismanOBJ:showUiInfo()
    GUI:removeAllChildren(self.ui.attrList)
    GUI:removeAllChildren(self.ui.nextList)

    local icon_path = "res/custom/npc/90cy/t11.png"
    local btn_path = "res/custom/npc/90cy/an2.png"
    if self.cur_wakeUp_count > 0 then
        icon_path = "res/custom/npc/90cy/t22.png"
        btn_path = "res/custom/npc/90cy/an1.png"
    end
    GUI:Image_loadTexture(self.ui.iconImg, icon_path)
    GUI:Button_loadTextureNormal(self.ui.startBtn, btn_path)

    local _cfg = self.cfg[self.cur_wakeUp_count]
    local next_cfg = self.cfg[self.cur_wakeUp_count + 1]
    if nil == next_cfg then
        next_cfg = self.cfg[10]
    end

    for k, v in pairs(_cfg.needitem_map) do
        local color = 255
        local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
        local needValue = v
        if SL:GetMetaValue("ITEM_COUNT", item_id) < needValue then
            color = 249
        end
        GUI:ItemShow_updateItem(self.ui["ItemShow_1"], {index = item_id, look = true, bgVisible = true, count = v, color = color})
    end

    if self.cur_wakeUp_count > 0 then
        local key_names = {"att", "defense", "att1", "dimension_map"}
        local y = 83
        for k, v in ipairs(self.attr_str) do
            local str_1 = string.format(v, _cfg[key_names[k]], _cfg[key_names[k]])
            if k == 3 then
                str_1 = string.format(v, _cfg[key_names[k]] / 100, _cfg[key_names[k]] / 100)
            end
            local rich = GUI:RichTextFCOLOR_Create(self.ui["attrList"], "_attr_left_"..k, 78, y, str_1, 150, 18, "#ffffff")
            GUI:setAnchorPoint(rich, 0.5, 0)

            local str_2 = string.format(v, next_cfg[key_names[k]], next_cfg[key_names[k]])
            if k == 3 then
                str_2 = string.format(v, next_cfg[key_names[k]] / 100, next_cfg[key_names[k]] / 100)
            end
            local rich1 = GUI:RichTextFCOLOR_Create(self.ui["nextList"], "_attr_right_"..k, 78, y, str_2, 150, 18, "#00ff00")
            GUI:setAnchorPoint(rich1, 0.5, 0)
            y = y - 25
        end
        GUI:LoadingBar_setPercent(self.ui.LoadingBar_icon, self.cur_collect_value / _cfg.Progress * 100)
    else
        GUI:RichTextFCOLOR_Create(self.ui["attrList"], "_attr_left_", 48, 50, "未解封", 100, 18, "#ffffff")
        GUI:RichTextFCOLOR_Create(self.ui["nextList"], "_attr_right_", 48, 50, "未解封", 100, 18, "#ffffff")
    end

    GUI:setVisible(self.ui.node, self.cur_wakeUp_count > 0)
end

function TalismanOBJ:flushView(count, value)
    self.cur_wakeUp_count = tonumber(count) or 0
    self.cur_collect_value = tonumber(value) or 0

    self:showUiInfo()
end

local function onClickNpc(npc_info)
    if npc_info.index == TalismanOBJ.NPC then
        SendMsgClickNpc(npc_info.index.."#TalismanNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "TalismanOBJ", onClickNpc)

return TalismanOBJ