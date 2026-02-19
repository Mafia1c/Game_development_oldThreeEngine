local RechargeCenterOBJ = {}

RechargeCenterOBJ.Name = "RechargeCenterOBJ"
RechargeCenterOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
RechargeCenterOBJ.cfg = SL:Require("GUILayout/config/rechargeGiftCfg",true) --#region 礼包表
RechargeCenterOBJ.npcId = 0
RechargeCenterOBJ.RunAction = true

function RechargeCenterOBJ:main(money)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/RechargeCenterUI")
    self.ui = GUI:ui_delegate(parent)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("RechargeCenterOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("RechargeCenterOBJ")
    end)

    if money and type(tonumber(money)) == "number" then
        self:refreshInfo2(money)
    else
        self:refreshInfo()
    end
    
end

function RechargeCenterOBJ:refreshInfo()
    local giftTab = SL:Split(GameData.GetData("TL_Recharge_gift",false), "|") --#region 礼包名|次数|前端obj
    local typeName = self.cfg[giftTab[1]]["typeText"]
    local money = self.cfg[giftTab[1]]["money"] * tonumber(giftTab[2])
    local hasMoney = SL:GetMetaValue("MONEY", 23)
    GUI:Text_setString(self.ui.typeText1,"充值项目："..typeName.."×"..giftTab[2])
    GUI:Text_setString(self.ui.needMoney2,"本次项目金额："..money.."元")
    GUI:Text_setString(self.ui.hasMoney3,"当前直购点余额："..hasMoney)
    GUI:UserUILayout(self.ui.textNode, {dir=1,addDir=2,interval=0.5,gap = {y=14},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:addOnClickEvent(self.ui.buyBtn,function ()
        SendMsgClickMainBtn("0#Recharge#takeMoney")
    end)
end

function RechargeCenterOBJ:refreshInfo2(money) --#自定义充值
    local hasMoney = SL:GetMetaValue("MONEY", 23)
    GUI:Text_setString(self.ui.typeText1,"充值项目：自定义金额"..money.."×1")
    GUI:Text_setString(self.ui.needMoney2,"本次项目金额："..money.."元")
    GUI:Text_setString(self.ui.hasMoney3,"当前直购点余额："..hasMoney)
    GUI:UserUILayout(self.ui.textNode, {dir=1,addDir=2,interval=0.5,gap = {y=14},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:addOnClickEvent(self.ui.buyBtn,function ()
        SendMsgClickMainBtn("0#Recharge#takeCustomMoney")
    end)
end

--#region 后端消息刷新ui
function RechargeCenterOBJ:flushView(...)
    local tab = {...}
    local functionTab = {

    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

--#region 关闭前回调
function RechargeCenterOBJ:onClose(...)
end

-- 点击npc触发(对应npcList表id)
-- local function onClickNpc(npc_info)
--     if npc_info.index == RechargeCenterOBJ.npcId then
--         ViewMgr.open(RechargeCenterOBJ.Name)
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, RechargeCenterOBJ.Name, onClickNpc)

return RechargeCenterOBJ