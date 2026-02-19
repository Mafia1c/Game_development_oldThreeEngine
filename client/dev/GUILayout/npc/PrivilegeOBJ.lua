local PrivilegeOBJ = {}
PrivilegeOBJ.Name = "PrivilegeOBJ"
PrivilegeOBJ.npcId = 0
PrivilegeOBJ.RunAction = true

function PrivilegeOBJ:main(...)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent

    GUI:LoadExport(parent, "npc/PrivilegeUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateUiShow()
end

function PrivilegeOBJ:initClickEvent()


    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.activationBtn, function()
        SendMsgCallFunByNpc(self.npcId, "Privilege", "buyEvent", "")
    end) 
    GUI:addOnClickEvent(self.ui.todayBtn, function()
        SendMsgCallFunByNpc(self.npcId, "Privilege", "today", "")
    end)
    self:FlushRedShow()
end

function PrivilegeOBJ:updateUiShow()
    local active = GameData.GetData("U_zstq",false) or 0 --#region 是否激活终身特权
    GUI:setVisible(self.ui.activationBtn, active==0)
    GUI:setVisible(self.ui.todayBtn, active>0)
end

function PrivilegeOBJ:FlushRedShow()
    GUI:removeAllChildren(self.ui.todayBtn)
    local active = GameData.GetData("U_zstq",false) or 0 --#region 是否激活终身特权
    if active > 0 and (GameData.GetData("J_today_zstq",false) or 0) <= 0  then
        SL:CreateRedPoint(self.ui.todayBtn)
    end
end

function PrivilegeOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["充值刷新"] = function ()
            self:updateUiShow()
        end,
        ["领取刷新"] = function ()
            self:FlushRedShow()
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

return PrivilegeOBJ