local luckForceOBJ = {}

luckForceOBJ.Name = "luckForceOBJ"
luckForceOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
luckForceOBJ.itemCfg = { {"金刚石",3888},{"声望",200},{"黄金骰子",3},{"神灵石",8},{"灵石",8}, }
luckForceOBJ.npcId = 276

function luckForceOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/luckForceUI")
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("luckForceOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("luckForceOBJ")
    end)

    self:refreshInfo()
end

function luckForceOBJ:refreshInfo()
    for index, value in ipairs(self.itemCfg) do
        GUI:ItemShow_updateItem(self.ui["item"..index]
        ,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]),look=true,bgVisible=true,count=value[2],color=251,})
    end
    local giftTab = GameData.GetData("TL_Recharge_hasGift",true) or {} --#region 充值过的礼包
    if not giftTab["gift_wscf"] then
        GUI:setVisible(self.ui.downBtn1,true)
        GUI:setVisible(self.ui.downBtn2,false)
        GUI:addOnClickEvent(self.ui.downBtn1,function ()
            SendMsgCallFunByNpc(self.npcId,"luckForce","buyEvent1","") --#region 首次购买
        end)
    else
        GUI:setVisible(self.ui.downBtn1,false)
        GUI:setVisible(self.ui.downBtn2,true)
        GUI:addOnClickEvent(self.ui.downBtn2,function ()
            SendMsgCallFunByNpc(self.npcId,"luckForce","buyEvent2","") --#region 领取礼包
        end)
    end

    for i = 1, 2 do
        GUI:UserUILayout(self.ui["itemNode"..i], {dir=2,addDir=2,interval=0.5,gap = {x=8},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    local number = tonumber(GameData.GetData("UL_luckForceTimes",false)) or 0
    GUI:Text_setString(self.ui.tipsText, string.format("激活武圣赐福礼包：可免费领取%d/30天礼包奖励",number))
end

--#region 后端消息刷新ui
function luckForceOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["充值刷新"] = function ()
            self:refreshInfo()
        end,
        ["refresh"] = function ()
            self:refreshInfo()
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

--#region 关闭前回调
function luckForceOBJ:onClose(...)
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == luckForceOBJ.npcId then
        ViewMgr.open(luckForceOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, luckForceOBJ.Name, onClickNpc)

return luckForceOBJ