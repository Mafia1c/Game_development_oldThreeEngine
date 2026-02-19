local RechargeTypeOBJ = {}

RechargeTypeOBJ.Name = "RechargeTypeOBJ"
RechargeTypeOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
RechargeTypeOBJ.npcId = 0
RechargeTypeOBJ.RunAction = true

function RechargeTypeOBJ:main(needMoney)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/RechargeTypeUI")
    self.ui = GUI:ui_delegate(parent)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("RechargeTypeOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("RechargeTypeOBJ")
    end)

    self:refreshInfo(needMoney)
end

function RechargeTypeOBJ:refreshInfo(needMoney)
    GUI:Text_setString(self.ui.numberText,"充值金额："..needMoney.."元")
    GUI:UserUILayout(self.ui.typeNode, {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["typeBtn"..i],function ()
            SendMsgClickMainBtn("0#Recharge#typeEvent#"..i)
        end)
    end
end

--#region 后端消息刷新ui
function RechargeTypeOBJ:flushView(...)
    local tab = {...}
    local functionTab = {

    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

--#region 关闭前回调
function RechargeTypeOBJ:onClose(...)
end

-- 点击npc触发(对应npcList表id)
-- local function onClickNpc(npc_info)
--     if npc_info.index == RechargeTypeOBJ.npcId then
--         ViewMgr.open(RechargeTypeOBJ.Name)
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, RechargeTypeOBJ.Name, onClickNpc)

return RechargeTypeOBJ