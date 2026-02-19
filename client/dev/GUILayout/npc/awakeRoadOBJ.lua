local awakeRoadOBJ = {}

awakeRoadOBJ.Name = "awakeRoadOBJ"
awakeRoadOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
awakeRoadOBJ.cfg = SL:Require("GUILayout/config/awakeRoadCfg",true)
awakeRoadOBJ.npcId = 0

function awakeRoadOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/awakeRoadUI")
    self.ui = GUI:ui_delegate(parent)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("awakeRoadOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("awakeRoadOBJ")
    end)

    self.tab1 = GameData.GetData("TL_awakeRoad",true) or {} --#region 变量数值表1(杀怪数,境界,合成)
    self.tab2 = GameData.GetData("TL_awakeRoadNode",true) or {} --#region 节点是否领取
    self.tab3 = GameData.GetData("TL_awakeRoadPage",true) or {} --#region 本章是否领取
    self:refreshLeftList()
    for index, value in ipairs(self.cfg) do
        if not self.tab3[tostring(index)] then
            self:leftBtnEvent(index)
            GUI:ListView_jumpToItem(self.ui.leftList,index)
            break
        elseif index == #self.cfg then
            self:leftBtnEvent(index)
            GUI:ListView_jumpToItem(self.ui.leftList,index)
        end
    end

end


--#region 刷新左侧list
function awakeRoadOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    if self.tab3["8"] then
        for index, value in ipairs(self.cfg) do
            local btn = GUI:Button_Create(self.ui.leftList, "leftBtn" .. index, 0, 0, "res/custom/dayeqian1.png")
            GUI:Button_setTitleText(btn, value["type"])
            GUI:Button_setTitleFontSize(btn, 18)
            GUI:Button_setTitleColor(btn, "#F8E6C6")
            GUI:Button_loadTexturePressed(btn, "res/custom/dayeqian2.png")
            GUI:addOnClickEvent(btn, function()
                if self.leftIndex == index then
                    return
                end
                self:leftBtnEvent(index)
            end)
            GUI:setVisible(btn, false)
            time = time + 0.05
            GUI:runAction(btn, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
                GUI:setVisible(btn, true)
                GUI:setPositionX(btn, -114)
                GUI:runAction(btn, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(btn))))
            end)))
        end
    else
        for index = 1, 9 do
            local btn = GUI:Button_Create(self.ui.leftList, "leftBtn" .. index, 0, 0, "res/custom/dayeqian1.png")
            GUI:Button_setTitleText(btn, self.cfg[index]["type"])
            GUI:Button_setTitleFontSize(btn, 18)
            GUI:Button_setTitleColor(btn, "#F8E6C6")
            GUI:Button_loadTexturePressed(btn, "res/custom/dayeqian2.png")
            GUI:addOnClickEvent(btn, function()
                if self.leftIndex == index then
                    return
                end
                self:leftBtnEvent(index)
            end)
            GUI:setVisible(btn, false)
            time = time + 0.05
            GUI:runAction(btn, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
                GUI:setVisible(btn, true)
                GUI:setPositionX(btn, -114)
                GUI:runAction(btn, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(btn))))
            end)))
        end
    end
    self:flushOneListRed()
end

function awakeRoadOBJ:flushOneListRed()
    for index, value in ipairs(self.cfg) do
        if self.ui["leftBtn" .. index] then
            GUI:removeAllChildren(self.ui["leftBtn" .. index])
            if index > 1 and not self.tab3[tostring(index-1)] then
                break
            end
            if self:GetDownBtnRedShow(index) or self:GetSingleRed(index) then
                SL:CreateRedPoint(self.ui["leftBtn" .. index],{x = 10,y = 10})
            end
        end 
    end
end

--#region 左侧按钮点击事件
function awakeRoadOBJ:leftBtnEvent(leftIndex)
    if leftIndex > 1 and not self.tab3[tostring(leftIndex-1)] then
        return SL:ShowSystemTips("<font color=\'#ff0000\'>请先完成上一级任务！</font>")
    end
    self.leftIndex = leftIndex --#region 1级列表index
    removeOBJ(self.ui.leftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..leftIndex],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)
    for index, value in ipairs(awakeRoadOBJ.cfg) do
        if self.ui["leftBtn"..index] then
            GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/dayeqian1.png")
        end
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..self.leftIndex],"res/custom/dayeqian2.png")
    local red_show_list = {false,false,false,false} 
    if not self.tab1[tostring(leftIndex).."1"] then --#region 目标1
        GUI:Text_setString(self.ui["progress1"], "0/" .. self.cfg[leftIndex]["number_arr1"][1])
        GUI:Text_setTextColor(self.ui["progress1"], "#FF0000")
    elseif self.tab1[tostring(leftIndex).."1"] < self.cfg[leftIndex]["number_arr1"][1] then
        GUI:Text_setString(self.ui["progress1"],self.tab1[tostring(leftIndex).."1"] .. "/" .. self.cfg[leftIndex]["number_arr1"][1])
        GUI:Text_setTextColor(self.ui["progress1"], "#FF0000")
    else
        GUI:Text_setString(self.ui["progress1"],self.cfg[leftIndex]["number_arr1"][1] .. "/" .. self.cfg[leftIndex]["number_arr1"][1])
        GUI:Text_setTextColor(self.ui["progress1"], "#00FF00")
        red_show_list[1] = true
    end
    if SL:GetMetaValue("LEVEL") < self.cfg[leftIndex]["number_arr1"][2] then --#region 目标2
        GUI:Text_setString(self.ui["progress2"],"未完成")
        GUI:Text_setTextColor(self.ui["progress2"], "#FF0000")
    else
        GUI:Text_setString(self.ui["progress2"],"已完成")
        GUI:Text_setTextColor(self.ui["progress2"], "#00FF00")
        red_show_list[2] = true
    end
    if self.cfg[leftIndex]["number_arr2"][1] == "五行" then --#region 目标3
        if not self.tab1[tostring(leftIndex).."3"] then
            GUI:Text_setString(self.ui["progress3"],"未完成")
            GUI:Text_setTextColor(self.ui["progress3"], "#FF0000")
        else
            GUI:Text_setString(self.ui["progress3"],"已完成")
            GUI:Text_setTextColor(self.ui["progress3"], "#00FF00")
            red_show_list[3] = true
        end
    elseif self.cfg[leftIndex]["number_arr2"][1] == "转生" then
        if SL:GetMetaValue("RELEVEL") < self.cfg[leftIndex]["number_arr2"][2] then
            GUI:Text_setString(self.ui["progress3"],"未完成")
            GUI:Text_setTextColor(self.ui["progress3"], "#FF0000")
        else
            GUI:Text_setString(self.ui["progress3"],"已完成")
            GUI:Text_setTextColor(self.ui["progress3"], "#00FF00")
            red_show_list[3] = true
        end
    elseif self.cfg[leftIndex]["number_arr2"][1] == "宗师" then
        local layer = tonumber(GameData.GetData("l_masterLayer",false)) or 0 --#region 宗师境界
        if layer < self.cfg[leftIndex]["number_arr2"][2] then
            GUI:Text_setString(self.ui["progress3"],"未完成")
            GUI:Text_setTextColor(self.ui["progress3"], "#FF0000")
        else
            GUI:Text_setString(self.ui["progress3"],"已完成")
            GUI:Text_setTextColor(self.ui["progress3"], "#00FF00")
            red_show_list[3] = true
        end
    end
    if self.cfg[leftIndex]["number_arr2"][3] == "变量" then --#region 目标4
        if not self.tab1[tostring(leftIndex).."4"] then
            GUI:Text_setString(self.ui["progress4"],"未完成")
            GUI:Text_setTextColor(self.ui["progress4"], "#FF0000")
        else
            GUI:Text_setString(self.ui["progress4"],"已完成")
            GUI:Text_setTextColor(self.ui["progress4"], "#00FF00")
            red_show_list[4] = true
        end
    else
        if SL:GetMetaValue("ITEM_COUNT", self.cfg[leftIndex]["number_arr2"][3]) < self.cfg[leftIndex]["number_arr2"][4] and not self.tab1[tostring(leftIndex).."4"] then
            GUI:Text_setString(self.ui["progress4"],"未完成")
            GUI:Text_setTextColor(self.ui["progress4"], "#FF0000")
        else
            GUI:Text_setString(self.ui["progress4"],"已完成")
            GUI:Text_setTextColor(self.ui["progress4"], "#00FF00")
            red_show_list[4] = true
        end
    end

    for i = 1, 4 do
        GUI:Text_setString(self.ui["point"..i],self.cfg[leftIndex]["text_arr"][i])
        GUI:removeAllChildren(self.ui["rewardNode"..i])
        self.ui = GUI:ui_delegate(self._parent)
        local number = 0
        for key, value in pairs(self.cfg[leftIndex]["award_config1"][i]) do
            number = number+1
            GUI:ItemShow_Create(self.ui["rewardNode"..i],"rewardItem"..i..number,0,0
            ,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", key),look=true,bgVisible=true,count=value,color=251})
        end
        GUI:UserUILayout(self.ui["rewardNode"..i], {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
        GUI:removeAllChildren(self.ui["nodeBtn"..i])
        if red_show_list[i] and not (self.tab2[tostring(leftIndex)..tostring(i)] and true) then
            SL:CreateRedPoint(self.ui["nodeBtn"..i])
        end
        GUI:setVisible(self.ui["nodeBtn"..i], not (self.tab2[tostring(leftIndex)..tostring(i)] and true))
        GUI:setVisible(self.ui["activeImg"..i], (self.tab2[tostring(leftIndex)..tostring(i)] or false) and true)
        GUI:addOnClickEvent(self.ui["nodeBtn"..i],function ()
            SendMsgCallFunByNpc(self.npcId, "awakeRoad", "rewardNode", leftIndex.."#"..i)
        end)

    end
    for i = 1, 2 do
        GUI:UserUILayout(self.ui["taskNode"..i], {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    GUI:removeAllChildren(self.ui.awardNode)
    self.ui = GUI:ui_delegate(self._parent)
    for index, value in ipairs(self.cfg[leftIndex]["award_config2"]) do
        GUI:ItemShow_Create(self.ui["awardNode"],"awardItem"..index,0,0
        ,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]),look=true,bgVisible=true,count=value[2],color=251})
    end
    GUI:UserUILayout(self.ui["awardNode"], {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:setVisible(self.ui["rewardBtn"], not (self.tab3[tostring(leftIndex)] and true))
    GUI:setVisible(self.ui["pageActiveImg"], (self.tab3[tostring(leftIndex)] or false) and true)
    local is_shor_page_red = true
    
    for i=1,4 do
        if not self.tab2[tostring(leftIndex)..tostring(i)] and not self.tab3[tostring(leftIndex)] then
            is_shor_page_red = false
        end
    end
    if is_shor_page_red then
        SL:CreateRedPoint(self.ui.rewardBtn)
    else
        GUI:removeAllChildren(self.ui.rewardBtn)
    end
    GUI:addOnClickEvent(self.ui.rewardBtn,function ()
        SendMsgCallFunByNpc(self.npcId, "awakeRoad", "rewardPage", leftIndex)
    end)
end

function awakeRoadOBJ:GetSingleRed(leftIndex)
    for i=1,4 do
        if self.tab2[tostring(leftIndex)..tostring(i)] == nil and self.tab3[tostring(leftIndex)] == nil then
            if i == 1 then
                if self.tab1[tostring(leftIndex).."1"] and self.tab1[tostring(leftIndex).."1"] >= self.cfg[leftIndex]["number_arr1"][1] then
                    return true
                end
            elseif i == 2 then
                if SL:GetMetaValue("LEVEL") >= self.cfg[leftIndex]["number_arr1"][2] then --#region 目标2
                    return true
                end
            elseif i == 3 then
                if self.cfg[leftIndex]["number_arr2"][1] == "五行" then --#region 目标3
                    if self.tab1[tostring(leftIndex).."3"] then
                        return true
                    end
                elseif self.cfg[leftIndex]["number_arr2"][1] == "转生" then
                    if SL:GetMetaValue("RELEVEL") >= self.cfg[leftIndex]["number_arr2"][2] then
                        return true
                    end
                elseif self.cfg[leftIndex]["number_arr2"][1] == "宗师" then
                    local layer = tonumber(GameData.GetData("l_masterLayer",false)) or 0 --#region 宗师境界
                    if layer >= self.cfg[leftIndex]["number_arr2"][2] then
                       return true
                    end
                end
            elseif i == 4 then
                if self.cfg[leftIndex]["number_arr2"][3] == "变量" then --#region 目标4
                    if self.tab1[tostring(leftIndex).."4"] then
                        return true
                    end
                else
                    if SL:GetMetaValue("ITEM_COUNT", self.cfg[leftIndex]["number_arr2"][3]) >= self.cfg[leftIndex]["number_arr2"][4] or self.tab1[tostring(leftIndex).."4"] then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function awakeRoadOBJ:GetDownBtnRedShow(leftIndex)
    if self.tab3[tostring(leftIndex)] == nil then
        for i=1,4 do
            if self.tab2[tostring(leftIndex)..tostring(i)] == nil then
                return false
            end
        end 
        return true
    end
    return false
end

--#region 后端消息刷新ui
function awakeRoadOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["节点"] = function ()
            self:leftBtnEvent(self.leftIndex)
            GUI:ListView_jumpToItem(self.ui.leftList,self.leftIndex)
            self:flushOneListRed()
        end,
        ["本章"] = function ()
            self:refreshLeftList()
            if self.leftIndex+1 <= #self.cfg then
                self:leftBtnEvent(self.leftIndex+1)
                GUI:ListView_jumpToItem(self.ui.leftList,self.leftIndex+1)
            else
                self:leftBtnEvent(self.leftIndex)
                GUI:ListView_jumpToItem(self.ui.leftList,self.leftIndex)
            end
            self:flushOneListRed()
            
        end,
    }
    self.tab1 = GameData.GetData("TL_awakeRoad",true) or {} --#region 变量数值表1(杀怪数,境界,合成)
    self.tab2 = GameData.GetData("TL_awakeRoadNode",true) or {} --#region 节点是否领取
    self.tab3 = GameData.GetData("TL_awakeRoadPage",true) or {} --#region 本章是否领取
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end

end

--#region 关闭前回调
function awakeRoadOBJ:onClose(...)

end

-- local function onClickNpc(npc_info)
--     if npc_info.index == awakeRoadOBJ.npcId then
--         ViewMgr.open(awakeRoadOBJ.Name)
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "awakeRoadOBJ", onClickNpc)

return awakeRoadOBJ