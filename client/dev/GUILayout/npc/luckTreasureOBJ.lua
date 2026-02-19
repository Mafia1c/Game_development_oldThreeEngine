local luckTreasureOBJ = {}

luckTreasureOBJ.Name = "luckTreasureOBJ"
luckTreasureOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
luckTreasureOBJ.cfg1 = {{"龙神坐骑(限定装扮)",1},{"灵符",190},{"金刚石",1900},{"声望",200},{"十转凭证",2},{"龙之心",3},{"龙之血",3},{"龙神石",1},{"觉醒宝石",1},{"连环明珠",1}
,{"暗黑水晶",1},{"灵魂水晶",1},{"魔界残魂",1},{"帝王之心",1},{"圣诞天使(限时装扮)",1},{"屠尽天下又何妨(称号)",1},{"头颅根骨",2},{"身躯根骨",2},{"左臂根骨",2},{"左手根骨",2},{"右臂根骨",2}
,{"右手根骨",2},{"左腿根骨",2},{"左脚根骨",2},{"右腿根骨",2},{"右脚根骨",2},{"头号玩家(称号)",1},{"全服最靓的仔(称号)",1},{"劳动先锋(限定装扮)",1},}--#region 祥瑞宝藏(奖励预览)
luckTreasureOBJ.cfg11 = {["0"]={"屠尽天下又何妨(称号)",1,"圣诞天使(限时装扮)",1,},["1"]={"宝石碎片",888,"步步高升(足迹)",1,},
["2"]={"卧龙钥匙",10,"一路长虹(限定魂环)",1,},["3"]={"十转凭证",10,"小恶魔(时装精灵)",1,},["4"]={"龙神石",10,"洛丽塔(女仆)",1,},} --#region 每日奖励轮换
luckTreasureOBJ.npcId = 0
luckTreasureOBJ.RunAction = true
local tips1 ={
    "<开启祥瑞宝藏概率公布：/FCOLOR=251>\\灵符×190：<3%/FCOLOR=254>\\金刚石×1900：<4%/FCOLOR=254>\\声望×200：<3%/FCOLOR=254>\\十转凭证×2：<7%/FCOLOR=254>\\龙之心×3：<4%/FCOLOR=254>"
    .."\\龙之血×3：<4%/FCOLOR=254>\\龙神石×1：<3%/FCOLOR=254>\\觉醒宝石×1：<3%/FCOLOR=254>\\连环明珠×1：<3%/FCOLOR=254>\\暗黑水晶×1：<3%/FCOLOR=254>\\灵魂水晶×1：<3%/FCOLOR=254>"
    .."\\魔界残魂×1：<3%/FCOLOR=254>\\帝王之心×1：<3%/FCOLOR=254>\\圣诞天使(限时装扮)×1：<1%/FCOLOR=254>\\屠尽天下又何妨(称号)×1：<1%/FCOLOR=254>\\头号玩家(称号)×1：<1%/FCOLOR=254>"
    .."\\劳动先锋(限定装扮)×1：<1%/FCOLOR=254>\\全服最靓的仔(称号)×1：<1%/FCOLOR=254>\\魂骨×2：<46%/FCOLOR=254>\\福字×1：<2%/FCOLOR=254>\\龙神坐骑×1：<1%/FCOLOR=254>",
}

function luckTreasureOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/luckTreasureUI")
    self.ui = GUI:ui_delegate(parent)

    if sMsg then
        sMsg = SL:JsonDecode(sMsg)
    else
        sMsg = {}
    end
    self.rankTab = sMsg --#region 积分榜

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("luckTreasureOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("luckTreasureOBJ")
    end)
    GUI:addOnClickEvent(self.ui.leftBtn1,function () --#region 祥瑞宝藏
        self:leftBtnEvent(1)
        self:refreshMidNode1()
    end)
    GUI:addOnClickEvent(self.ui.leftBtn2,function () --#region 宝藏奖励
        self:leftBtnEvent(2)
        self:refreshMidNode2()
    end)
    GUI:addOnClickEvent(self.ui.leftBtn3,function () --#region 新春祥瑞
        self:leftBtnEvent(3)
        self:refreshMidNode3()
    end)
    self:leftBtnEvent(1)
    self:refreshMidNode1()
end
function luckTreasureOBJ:leftBtnEvent(leftIndex)
    self.leftIndex = leftIndex
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/71bz/"..leftIndex.."/bg"..leftIndex..".png")
    for i = 1, 3 do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..i], "res/custom/npc/71bz/btn"..i.."2.png")
        GUI:setVisible(self.ui["midNode"..i], i == leftIndex)
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex], "res/custom/npc/71bz/btn"..leftIndex.."1.png")
end
function luckTreasureOBJ:refreshMidNode1() --#region 祥瑞宝藏
    GUI:setVisible(self.ui.leftNode12, false)
    GUI:setVisible(self.ui.leftNode11, true)
    local x_space = SL:GetMetaValue("WINPLAYMODE") and 30 or 4
    for i = 1, 3 do
        GUI:UserUILayout(self.ui["keyItemNode1"..i], {dir=2,addDir=2,interval=0.5,gap = {x=x_space},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    for i = 1, 2 do
        GUI:UserUILayout(self.ui["btnNode1"..i], {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    GUI:addOnClickEvent(self.ui.tipsBtn11,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn11)
        GUI:ShowWorldTips(tips1[1], worldPos, GUI:p(1, 1))
    end)

    local time = tonumber(GameData.GetData("HeFuCount",false)) or 0 --#region 合服次数
    time = time%5
    GUI:ItemShow_updateItem(self.ui.todayItem11,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg11[tostring(time)][1]),look=true,bgVisible=true
    ,count=self.cfg11[tostring(time)][2],color=251})
    GUI:ItemShow_updateItem(self.ui.todayItem12,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg11[tostring(time)][3]),look=true,bgVisible=true
    ,count=self.cfg11[tostring(time)][4],color=251})
    local number = tonumber(GameData.GetData("UL_treasureOpenAll",false)) or 0 --#region 累计开启次数
    if number >= 99 then number = 99 end
    GUI:Text_setString(self.ui.openText12, "累计开启"..number.."/99次后必出！")
    GUI:addOnClickEvent(self.ui.tqBtn1,function ()
        SendMsgCallFunByNpc(self.npcId, "luckTreasure", "todayGet", "")
    end)
    GUI:removeAllChildren(self.ui.awardList1)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg1) do
        local item = GUI:ItemShow_Create(self.ui.awardList1,"rewardItem1_"..index,0,0,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]),look=true,bgVisible=true,count=value[2]})
    end
    GUI:UserUILayout(self.ui.awardList1, {
        dir=2,
        addDir=1,
        interval=0.05,
        gap={x = 20,l=10},

    })
    GUI:addOnClickEvent(self.ui.mapBtn11,function () --#region 祥瑞宝阁
        SendMsgCallFunByNpc(self.npcId, "luckTreasure", "goMap1", "")
    end)
    GUI:addOnClickEvent(self.ui.mapBtn12,function () --#region 祥瑞迷宫
        SendMsgCallFunByNpc(self.npcId, "luckTreasure", "goMap2", "")
    end)
    GUI:addOnClickEvent(self.ui.openBtn11,function () --#region 回收饰品
        if GUI:getVisible(self.ui.leftNode12) then
            GUI:setVisible(self.ui.leftNode12, false)
            GUI:setVisible(self.ui.leftNode11, true)
            GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/71bz/1/bg1.png")
        else
            GUI:setVisible(self.ui.leftNode12, true)
            GUI:setVisible(self.ui.leftNode11, false)
            self:refreshMidNode11()
        end
    end)
    GUI:addOnClickEvent(self.ui.openBtn12,function () --#region 开启祥瑞
        self:openTreasureBox()
    end)
end
function luckTreasureOBJ:openTreasureBox() --#region 开启祥瑞box
    GUI:setVisible(self.ui.mask1, true)
    local todayTime = GameData.GetData("JL_treasureOpen",false) or 0
    GUI:Text_setString(self.ui.allKeyText1, "当前祥瑞钥匙剩余："..SL:GetMetaValue("ITEM_COUNT", "祥瑞钥匙"))
    GUI:Text_setString(self.ui.allLuckKeyText1, "当前祥瑞钥匙(福利)剩余："..SL:GetMetaValue("ITEM_COUNT", "祥瑞钥匙(福利)"))
    GUI:Text_setString(self.ui.todayOpenText1, "今日开启次数："..todayTime)
    GUI:addOnClickEvent(self.ui.mask1,function ()
        GUI:setVisible(self.ui.mask1,false)
    end)
    GUI:addOnClickEvent(self.ui.closeOpenBtn1,function ()
        GUI:setVisible(self.ui.mask1,false)
    end)
    GUI:addOnClickEvent(self.ui.openOneBtn1,function ()
        SendMsgCallFunByNpc(self.npcId, "luckTreasure", "open1", "")
    end)
    GUI:addOnClickEvent(self.ui.openTenBtn1,function ()
        SendMsgCallFunByNpc(self.npcId, "luckTreasure", "open10", "")
    end)
end
function luckTreasureOBJ:refreshMidNode11()--#region 回收饰品
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/71bz/1/bg11.png")
    for i = 1, 3 do
        GUI:UserUILayout(self.ui["recycleItemNode1"..i], {dir=2,addDir=2,interval=0.5,gap = {x=30},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    for i = 1, 12 do
        GUI:addOnClickEvent(self.ui["recycleBtn"..i],function ()
            SendMsgCallFunByNpc(self.npcId, "luckTreasure", "recycle", i)
        end)
    end
end
function luckTreasureOBJ:refreshMidNode2()--#region 宝藏奖励
    GUI:UserUILayout(self.ui.awardNode21, {dir=2,addDir=2,interval=0.5,gap = {x=4},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:UserUILayout(self.ui.awardNode22, {dir=2,addDir=2,interval=0.5,gap = {x= SL:GetMetaValue("WINPLAYMODE") and 30 or 10},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    local todayPoint = GameData.GetData("JL_treasureTodayPoint",false) or 0 --#region 今日积分
    local allPoint = GameData.GetData("UL_treasureAllPoint",false) or 0 --#region 累计积分
    GUI:Text_setString(self.ui.nowPoints2,"今日积分："..todayPoint)
    GUI:Text_setString(self.ui.allPoints2,"累计积分："..allPoint)
    GUI:Text_setString(self.ui.rankPoints2,"榜单积分："..allPoint.."≥588时计入排行")
    GUI:removeAllChildren(self.ui.rankList2)
    self.ui = GUI:ui_delegate(self._parent)
    local function createBox(index,box,name,point)
        local colorTab={"#FF00FF","#FF00FF","#FF00FF","#00FF00","#00FF00",}
        local textTab = {"第一名","第二名","第三名","第四名","第五名",}
        GUI:Text_Create(box,"rankText2"..index,18,8,16,colorTab[index],textTab[index])
        GUI:Text_Create(box,"rankName2"..index,220,20,16,colorTab[index],name)
        GUI:setAnchorPoint(self.ui["rankName2"..index],0.5,0.5)
        GUI:Text_Create(box,"rankPoint2"..index,398,20,16,colorTab[index],point)
        GUI:setAnchorPoint(self.ui["rankPoint2"..index],0.5,0.5)
    end
    local time = 0
    for i = 1, 5 do
        local box = GUI:Image_Create(self.ui.rankList2,"rankBox2"..i,0,0,"res/custom/npc/71bz/2/listBox.png")
        if self.rankTab ~= nil and self.rankTab[i] then
            createBox(i,box,self.rankTab[i]["actorName"],self.rankTab[i]["allPoint"])
        else
            createBox(i,box,"暂无玩家上榜",0)
        end
        GUI:setVisible(box,false)
        time = time +0.05
        GUI:runAction(box,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(box,true)
            GUI:setPositionX(box,-732)
            GUI:runAction(box,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(box))))
        end)))
    end
end
function luckTreasureOBJ:refreshMidNode3()--#region 新春祥瑞
    GUI:UserUILayout(self.ui.upNode3, {dir=2,addDir=2,interval=0.5,gap = {x=4},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:UserUILayout(self.ui.downNode3, {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})

    GUI:addOnClickEvent(self.ui.mask3,function ()
        GUI:setVisible(self.ui.mask3,false)
    end)
    GUI:addOnClickEvent(self.ui.maskCloseBtn3,function ()
        GUI:setVisible(self.ui.mask3,false)
    end)
    local type = 0 --#region 类别
    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["sellBtn3"..i],function ()
            type = i
            GUI:setVisible(self.ui.mask3,true)
        end)
        GUI:addOnClickEvent(self.ui["buyBtn3_"..i],function ()
            local time = 1
            if i == 2 then
                time = 10
            elseif i == 3 then
                time = 100
            end
            SendMsgCallFunByNpc(self.npcId, "luckTreasure", "buyEvent"..type, time)
        end)
    end
    GUI:addOnClickEvent(self.ui.sellBtn34,function ()
        SendMsgCallFunByNpc(self.npcId, "luckTreasure", "sellEvent1", "")
    end)
    GUI:addOnClickEvent(self.ui.sellBtn35,function ()
        SendMsgCallFunByNpc(self.npcId, "luckTreasure", "sellEvent2", "")
    end)
end
--#region 后端消息刷新ui
function luckTreasureOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["开宝箱"] = function ()
            GUI:setVisible(self.ui.mask1, false)
            local number = tonumber(GameData.GetData("UL_treasureOpenAll",false)) or 0 --#region 累计开启次数
            if number >= 99 then number = 99 end
            GUI:Text_setString(self.ui.openText12, "累计开启"..number.."/99次后必出！")
        end,
        ["积分榜"] = function ()
            self.rankTab = SL:JsonDecode(tab[2]) --#region 积分榜
        end,
        ["充值刷新"] = function ()
            GUI:setVisible(self.ui.mask3,false)
        end
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

--#region 关闭前回调
function luckTreasureOBJ:onClose(...)

end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == luckTreasureOBJ.npcId then
        ViewMgr.open(luckTreasureOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, luckTreasureOBJ.Name, onClickNpc)

return luckTreasureOBJ