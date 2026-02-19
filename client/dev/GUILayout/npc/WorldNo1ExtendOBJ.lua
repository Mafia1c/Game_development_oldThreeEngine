local WorldNo1ExtendOBJ = {}
WorldNo1ExtendOBJ.Name = "WorldNo1ExtendOBJ"
WorldNo1ExtendOBJ.NPC = {119,120,121}
WorldNo1ExtendOBJ.RunAction = true

function WorldNo1ExtendOBJ:main(npc_id, sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WorldNo1ExtendUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_npc_id = tonumber(npc_id)
    self.rank_info_txt = {}

    self.cfg = {
        No1Title = "<天下第一%s:/FCOLOR=249>     <%s/FCOLOR=250>",
        UpLevel = "<上榜等级:/FCOLOR=125>         <%s/FCOLOR=250>",
        Guild = "<所属工会:/FCOLOR=125>         <%s/FCOLOR=250>",
        UpTime = "<上榜时间/FCOLOR=125>          <%s/FCOLOR=250>"
    }
    if sMsg then
        sMsg = SL:JsonDecode(sMsg)
        sMsg.up_level = sMsg.up_level .. "级"
    else
        sMsg = {}
    end
    self.view_info = sMsg

    self:initClickEvent()
    self:showUiInfo()
end

function WorldNo1ExtendOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.up_rule_txt, function ()
        local data = {}
        data.str = "等级大于榜上人物即可\n若对象不在线也可立即申请\n榜单固定每4小时清空一次"
        data.btnType = 1
        SL:OpenCommonTipsPop(data)
    end)

    GUI:addOnClickEvent(self.ui.apply_txt, function ()
        SendMsgCallFunByNpc(self.cur_npc_id, "WorldNo1ExtendNpc", "onClickApplyBtn", self.cur_npc_id)
    end)
end

function WorldNo1ExtendOBJ:showUiInfo()
    for k, v in pairs(self.rank_info_txt) do
        GUI:removeFromParent(v)
    end

    local job = {[119] = "战", [120] = "法", [121] = "道"}
    local str = string.format(self.cfg.No1Title, job[self.cur_npc_id], self.view_info.up_name or "*暂无*")
    local rich_txt1 = GUI:RichTextFCOLOR_Create(self.ui.imageBg, "_rich_txt1", 30, 156, str, 500)
    str = string.format(self.cfg.UpLevel, self.view_info.up_level or "*暂无*")
    local rich_txt2 = GUI:RichTextFCOLOR_Create(self.ui.imageBg, "_rich_txt2", 30, 130, str, 500)
    str = string.format(self.cfg.Guild, self.view_info.up_guild or "*暂无*")
    local rich_txt3 = GUI:RichTextFCOLOR_Create(self.ui.imageBg, "_rich_txt3", 30, 105, str, 500)

    if self.view_info.up_time then
        local weekday = timeWeekdayStr(self.view_info.up_time)
        local t = os.date("*t", self.view_info.up_time)
        local _s = t.year.."年"..t.month.."月"..t.day.."日"..", ".. weekday..", "..t.hour..":"..t.min..":"..t.sec
        str = string.format(self.cfg.UpTime, _s)
    else
        str = string.format(self.cfg.UpTime, "*暂无*")
    end
    
    local rich_txt4 = GUI:RichTextFCOLOR_Create(self.ui.imageBg, "_rich_txt4", 30, 79, str, 500)

    self.rank_info_txt = {rich_txt1, rich_txt2, rich_txt3, rich_txt4}

    local rank_tips = "天下第一:  1.1倍神力"
    if self.cur_npc_id == 119 then
    elseif self.cur_npc_id == 120 then
        rank_tips = "天下第一:  生命加成5%"
    elseif self.cur_npc_id == 121 then
        rank_tips = "天下第一:  死亡掉装降低5%"
    end
    GUI:Text_setString(self.ui.title_txt2, rank_tips)
end

function WorldNo1ExtendOBJ:flushView(sMsg)
    if sMsg then
        sMsg = SL:JsonDecode(sMsg)
        sMsg.up_level = sMsg.up_level .. "级"
    else
        sMsg = {}
    end
    self.view_info = sMsg
    self:showUiInfo()
end

function WorldNo1ExtendOBJ:onClose()

end

local function onClickNpc(npc_info)
    if isInTable(WorldNo1ExtendOBJ.NPC, npc_info.index) then
        SendMsgClickNpc(npc_info.index .. "#WorldNo1ExtendNpc#" .. npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "WorldNo1ExtendOBJ", onClickNpc)

return WorldNo1ExtendOBJ