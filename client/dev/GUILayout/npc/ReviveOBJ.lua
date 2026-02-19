local ReviveOBJ = {}
ReviveOBJ.Name = "ReviveOBJ"
ReviveOBJ.RunAction = true
REVIVE_TIME = 5

function ReviveOBJ:main(name)
    local ui_path = "npc/DeathUI"
    self._schedule = nil

    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateUiInfo(name)

    GUI:setContentSize(self.ui["Scene"], SL:GetMetaValue("SCREEN_WIDTH"), SL:GetMetaValue("SCREEN_HEIGHT"))
end

function ReviveOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.reviveBtn1, function()
        -- 回城复活
        SendMsgClickSysBtn("_revive#DeathRevive#onClickReviveBtn#0")
    end)
    GUI:addOnClickEvent(self.ui.reviveBtn2, function()
        -- 原地复活
        -- SendMsgClickSysBtn("_revive#DeathRevive#onClickReviveBtn#1")
    end)
end

function ReviveOBJ:updateUiInfo(name)
    if self._schedule then
        return
    end
    local time = REVIVE_TIME
    GUI:Text_setString(self.ui.revive_txt1, time.."秒")

    GUI:Text_setString(self.ui.die_txt, string.format("你被 [%s] 杀死了!", name or ""))
    local function callback()
        time = time - 1
        if time < 0 then
            SendMsgClickSysBtn("_revive#DeathRevive#onClickReviveBtn#0")
        else
            GUI:Text_setString(self.ui.revive_txt1, time.."秒")
        end
    end
    self._schedule = SL:Schedule(callback, 1)
end

function ReviveOBJ:onClose()
    SL:UnSchedule(self._schedule)
    self._schedule = nil
end

return ReviveOBJ