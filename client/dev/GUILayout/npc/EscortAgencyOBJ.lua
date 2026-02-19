local EscortAgencyOBJ = {}
EscortAgencyOBJ.Name = "EscortAgencyOBJ"
EscortAgencyOBJ.RunAction = true
EscortAgencyOBJ.NPC = 97
EscortAgencyOBJ.cfg = SL:Require("GUILayout/config/EscortAgencyUICfg", true)

function EscortAgencyOBJ:main(state, npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/EscortAgencyUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_npc_id = tonumber(npc_id)
    self.cur_select_index = 1
    self.txt_list = {}
    -- --0.未开始   1.进行中   2.已结束
    self.cur_state = tonumber(state)

    self:initClickEvent()
    self:showBiaoCheInfo()
    self:createBiaoCheEff()

    local str = "未开放"
    local color = 249
    if self.cur_state == 1 then
        str = "进行中"
        color = 250
    elseif self.cur_state == 2 then
        str = "已结束"
        color = 251
    end

    str = string.format("<%s/FCOLOR=%d>", str, color)
    local rich1 = GUI:RichTextFCOLOR_Create(self.ui["rule_node"], "_map", -16, -150, str, 100, 18, "#ffffff")
end

function EscortAgencyOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(EscortAgencyOBJ.Name)
    end)

    GUI:addOnClickEvent(self.ui.enter_btn, function ()
        SendMsgCallFunByNpc(EscortAgencyOBJ.NPC, "EscortAgencyNpc", "onClickStartBtn", self.cur_select_index.."#"..self.cur_npc_id)
    end)

    for i = 1, 4 do
        GUI:addOnClickEvent(self.ui["biaoche_"..i], function ()
            if i == self.cur_select_index then
                return
            end
            self.cur_select_index = i
            local pos = GUI:getPosition(self.ui["biaoche_"..i])
            GUI:setPosition(self.ui.select_img, pos.x - 3, pos.y - 6)
            self:showBiaoCheInfo()
        end)
    end
end

function EscortAgencyOBJ:createBiaoCheEff()
    local pos_list = {
        {x = 105, y = 70, scale = 0.85},
        {x = 105, y = 66, scale = 0.8},
        {x = 97, y = 79, scale = 0.65},
        {x = 126, y = 38, scale = 0.65}
    }
    for i = 1, 4 do
        local _cfg = self.cfg[i]
        local v = pos_list[i]
        local parent = self.ui["biaoche_"..i]
        local eff = GUI:Effect_Create(parent, "_che_eff"..i, v.x, v.y, 2, _cfg.effect or 106, 0, 1, 3)
        GUI:setScale(eff, v.scale)
    end
end

function EscortAgencyOBJ:showBiaoCheInfo()
    for k, v in pairs(self.txt_list) do
        GUI:removeFromParent(v)
    end
    self.txt_list = {}

    local _cfg = self.cfg[self.cur_select_index]
    local str = "<[选择镖车]:/FCOLOR=250>  <%s/FCOLOR=251>"
    if self.cur_npc_id == 122 then
        str = string.format(str, "随机获得镖车")
    else
        str = string.format(str, _cfg.yb_level)
    end
    local rich_txt1 = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "rich_txt1", 90, 72, str, 300, 18, "#ffffff")

    str = "<[劫镖收益]:/FCOLOR=250>  <%s/FCOLOR=253>"
    if self.cur_npc_id == 122 then
        str = string.format(str, "禁止劫镖")
    else
        str = string.format(str, _cfg.jbIncome)
    end
    local rich_txt2 = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "rich_txt2", 320, 72, str, 200, 18, "#ffffff")

    str = "<[接镖押金]:/FCOLOR=250>  <%s/FCOLOR=251>"
    if self.cur_npc_id == 122 then
        str = string.format(str, "免费")
    else
        str = string.format(str, _cfg.xstj)
    end    
    local rich_txt3 = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "rich_txt3", 90, 42, str, 200, 18, "#ffffff")

    str = "<[押镖收益]:/FCOLOR=250>  <%s/FCOLOR=253>"
    if self.cur_npc_id == 122 then
        str = string.format(str, _cfg.doubleYb)
    else
        str = string.format(str, _cfg.ybIncome)
    end    
    local rich_txt4 = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "rich_txt4", 320, 42, str, 200, 18, "#ffffff")


    self.txt_list = {rich_txt1, rich_txt2, rich_txt3, rich_txt4}
end

local function onClickNpc(npc_info)
    if npc_info.index == EscortAgencyOBJ.NPC or npc_info.index == 122 then
        SendMsgClickNpc(npc_info.index.."#EscortAgencyNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "EscortAgencyOBJ", onClickNpc)

return EscortAgencyOBJ