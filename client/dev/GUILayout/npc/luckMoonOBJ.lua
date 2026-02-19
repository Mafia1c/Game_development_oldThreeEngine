local luckMoonOBJ = {}

luckMoonOBJ.Name = "luckMoonOBJ"
luckMoonOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
luckMoonOBJ.itemCfg = { {"龙之心",99},{"龙之血",99},{"五魂石",38},{"神灵石",28},{"恶魔挑战卷",9}, }
luckMoonOBJ.npcId = 272

function luckMoonOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/luckMoonUI")
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("luckMoonOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("luckMoonOBJ")
    end)
    GUI:addOnClickEvent(self.ui.goMapBtn1,function ()
        SendMsgCallFunByNpc(self.npcId, "luckMoon", "goMap1","")
    end)
    GUI:addOnClickEvent(self.ui.goMapBtn2,function ()
        SendMsgCallFunByNpc(self.npcId, "luckMoon", "goMap2","")
    end)

    self:refreshInfo()
end

function luckMoonOBJ:refreshInfo()
    for index, value in ipairs(self.itemCfg) do
        GUI:ItemShow_updateItem(self.ui["item"..index]
        ,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]),look=true,bgVisible=true,count=value[2],color=251,})
    end
    local giftTab = GameData.GetData("TL_Recharge_hasGift",true) or {} --#region 充值过的礼包
    if not giftTab["gift_cycf"] then
        GUI:setVisible(self.ui.buyNode1,true)
        GUI:setVisible(self.ui.buyNode2,false)
        GUI:addOnClickEvent(self.ui.buyBtn1,function ()
            SendMsgCallFunByNpc(self.npcId,"luckMoon","buyEvent","") --#region 首次购买
        end)
    else
        GUI:setVisible(self.ui.buyNode1,false)
        GUI:setVisible(self.ui.buyNode2,true)
        GUI:addOnClickEvent(self.ui.buyBtn21,function ()
            SendMsgCallFunByNpc(self.npcId,"luckMoon","buyGift1","") --#region 购1次
        end)
        GUI:addOnClickEvent(self.ui.buyBtn22,function ()
            SendMsgCallFunByNpc(self.npcId,"luckMoon","buyGift10","") --#region 购10次
        end)
    end
    local x_space = SL:GetMetaValue("WINPLAYMODE") and 30 or 4

    GUI:UserUILayout(self.ui.itemNode, {dir=2,addDir=2,interval=0.5,gap = {x=x_space},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:UserUILayout(self.ui.btnNode2, {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:UserUILayout(self.ui.priceNode2, {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})

end

--#region 后端消息刷新ui
function luckMoonOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["充值刷新"] = function ()
            self:refreshInfo()
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

--#region 关闭前回调
function luckMoonOBJ:onClose(...)
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == luckMoonOBJ.npcId then
        ViewMgr.open(luckMoonOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, luckMoonOBJ.Name, onClickNpc)

return luckMoonOBJ