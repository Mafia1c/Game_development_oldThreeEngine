local RageOBJ = {}
RageOBJ.Name = "RageOBJ"
RageOBJ.RunAction = true

function RageOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent

    GUI:LoadExport(parent, "npc/RageUI", function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateBtnShow()
    self:addClickNpcTrigger()
end

function RageOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.lf_btn, function()
        self:LFOpen()
    end)

    GUI:addOnClickEvent(self.ui.jgs_btn, function()
        self:JGSOpen()
    end)
end

function RageOBJ:updateBtnShow()
    local actorID = SL:GetMetaValue("MAIN_ACTOR_ID")
    local buff = SL:GetMetaValue("ACTOR_HAS_ONE_BUFF", actorID, 50007)
    GUI:setVisible(self.ui.lf_btn, not buff)
    GUI:setVisible(self.ui.jgs_btn, not buff)
    GUI:setVisible(self.ui.activation, buff)
end

function RageOBJ:LFOpen()
    SendMsgClickMainBtn("0#MainTopBtn#onClickOpenRage#lingfu")
end
function RageOBJ:JGSOpen()
    SendMsgClickMainBtn("0#MainTopBtn#onClickOpenRage#jgs")
end

function RageOBJ:addClickNpcTrigger()
    -- 刷新buff
    --table — {actorID = 玩家id, buffID = buffID, type = 类型(0: 删除 1: 新增 2: 刷新)}
    local function onBuffUpdate(info)
        local buff_id = info.buffID
        if buff_id == 50007 then
            RageOBJ:updateBtnShow()
        end
    end
    SL:RegisterLUAEvent(LUA_EVENT_MAINBUFFUPDATE, "RageOBJ", onBuffUpdate)
end

function RageOBJ:onClose()
    SL:UnRegisterLUAEvent(LUA_EVENT_MAINBUFFUPDATE, "RageOBJ")
end

return RageOBJ