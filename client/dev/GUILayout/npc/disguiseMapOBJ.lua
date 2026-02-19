local disguiseMapOBJ = {}
disguiseMapOBJ.Name = "disguiseMapOBJ"
disguiseMapOBJ.cfg = {
    { {"幽影魔主·紫烬","金辉神骏(限定装扮)"},{"炽焰神将·燎天","耀金战骑(限定装扮)"},{"黯狱魔将·烬芒","独孤求败(称号)"},{"炽阳灵主·炎裳","盖世英雄(称号)"},{"战令*1","金刚石","声望","时装碎片"},{100,100,100,1}},
    { {"幽影魔主·紫烬1","暗金烈骑(限定装扮)"},{"炽焰神将·燎天1","苍云神骑(限定装扮)"},{"黯狱魔将·烬芒1","热血同行(称号)"},{"炽阳灵主·炎裳1","十步一殺(称号)"},{"战令*1","金刚石","声望","时装碎片"},{100,100,100,1}},
    { {"幽影魔主·紫烬2","霜华仙骑(限定装扮)"},{"炽焰神将·燎天2","晶蓝圣骑(限定装扮)"},{"黯狱魔将·烬芒2","唯我独有(称号)"},{"炽阳灵主·炎裳2","雪山孤剑鸣(称号)"},{"战令*1","金刚石","声望","时装碎片"},{100,100,100,1}},
    { {"幽影魔主·紫烬3","翠影灵骑(限定装扮)"},{"炽焰神将·燎天3","赤焰魔骑(限定装扮)"},{"黯狱魔将·烬芒3","一刀一个小朋友(称号)"},{"炽阳灵主·炎裳3","一骑当千(称号)"},{"战令*1","金刚石","声望","时装碎片"},{100,100,100,1}},
}
disguiseMapOBJ.npcId = 0

function disguiseMapOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/disguiseMapUI")
    self.ui = GUI:ui_delegate(parent)

    self.leftIndex = 0
    self:refreshLeftList()
    self:leftBtnEvent(1)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("disguiseMapOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("disguiseMapOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "disguiseMap", "gotoMap",self.leftIndex)
    end)
    GUI:Timeline_Window4(self.ui.FrameLayout)
end

--#region 刷新左侧list
function disguiseMapOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
        local btn = GUI:Button_Create(self.ui.leftList, "leftBtn" .. index, 0, 0, "res/custom/dayeqian1.png")
        GUI:Button_setTitleText(btn,"跨服装扮"..index.."层")
        GUI:Button_setTitleFontSize(btn,18)
        GUI:Button_setTitleColor(btn,"#F8E6C6")
        GUI:Button_loadTexturePressed(btn, "res/custom/dayeqian2.png")
        GUI:addOnClickEvent(btn,function ()
            self:leftBtnEvent(index)
        end)
        GUI:setVisible(btn,false)
        time = time +0.05
        GUI:runAction(btn,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(btn,true)
            GUI:setPositionX(btn,-114)
            GUI:runAction(btn,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(btn))))
        end)))
    end
end

--#region 左侧点击事件
function disguiseMapOBJ:leftBtnEvent(leftIndex)
    if leftIndex >1 and (GameData.GetData("U_bigMap"..leftIndex,false) or 0) ==0 then
        return SL:ShowSystemTips("<font color=\'#ff0000\'>请先前往"..leftIndex.."大陆一次！</font>")
    elseif leftIndex == self.leftIndex then
        return
    end
    SendMsgCallFunByNpc(self.npcId, "disguiseMap", "getTime",leftIndex)
    self.leftIndex = leftIndex --#region 1级列表index
    removeOBJ(self.ui.leftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..leftIndex],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/dayeqian1.png")
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..self.leftIndex],"res/custom/dayeqian2.png")
    for i = 1, 4 do
        GUI:Text_setString(self.ui["bossName"..i],self.cfg[leftIndex][i][1])
        ItemShow_updateItem(self.ui["itemShow_"..i],{look=true,bgVisible=true,index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[leftIndex][i][2])})
    end
    GUI:removeAllChildren(self.ui.itemNode)
    self.ui = GUI:ui_delegate(self._parent)
    for index, value in ipairs(self.cfg[leftIndex][5]) do
        local count = self.cfg[leftIndex][6][index]
        GUI:ItemShow_Create(self.ui.itemNode,"pageItem_"..index,0,0,{count=count,look=true,bgVisible=true,index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[leftIndex][5][index])})
    end
    local x_space = SL:GetMetaValue("WINPLAYMODE") and 30 or 4
    GUI:UserUILayout(self.ui.itemNode, {dir=2,addDir=2,interval=0.5,gap = {x=x_space},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    local time = GameData.GetData("J_disguiseMapTime",false) or 0
    if 6-time <=0 then
        time = 0
    else
        time = 6-time
    end
    GUI:Text_setString(self.ui.timeText,"今日剩余挑战次数："..(time).."次")
end

--#region 关闭前回调
function disguiseMapOBJ:onClose(...)

end

--#region 后端消息刷新ui
function disguiseMapOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["time"] = function ()
            local timeTab = SL:JsonDecode(tab[2])
            for i = 1, 4 do
                local bossName = self.cfg[self.leftIndex][i][1]
                for k, v in pairs(timeTab) do
                    if k == bossName then
                        if v == "0" then
                            removeOBJ(self.ui["bossTime"..i],self)
                            GUI:Text_Create(self.ui["bossBox"..i], "bossTime"..i, 64, -14, 16, "#00ff00", "已刷新")
                        else
                            removeOBJ(self.ui["bossTime"..i],self)
                            GUI:Text_Create(self.ui["bossBox"..i], "bossTime"..i, 64, -14, 16, "#ff0000", "")
                            GUI:Text_COUNTDOWN(self.ui["bossTime"..i], tonumber(v),nil,0)
                        end
                        GUI:setAnchorPoint(self.ui["bossTime"..i],0.5,0.5)
                        break
                    end
                end
            end
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

return disguiseMapOBJ
