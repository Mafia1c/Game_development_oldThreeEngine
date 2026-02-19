local bossAwardOBJ = {}

bossAwardOBJ.Name = "bossAwardOBJ"
bossAwardOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
bossAwardOBJ.cfg = SL:Require("GUILayout/config/bossAwardCfg",true)
bossAwardOBJ.npcId = 0

function bossAwardOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/bossAwardUI")
    self.ui = GUI:ui_delegate(parent)

    self:refreshLeftList()
    self:leftBtnEvent(1)
    self:runAction()
    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("bossAwardOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("bossAwardOBJ")
    end)

    --章节
    GUI:addOnClickEvent(self.ui.rewardBtn,function ()
        SendMsgCallFunByNpc(0, "bossAward", "rewardEvent",self.leftIndex1)
    end)

    --页签悬赏
    GUI:addOnClickEvent(self.ui.rewardBtn_1,function ()
        
        SendMsgCallFunByNpc(0, "bossAward", "rewardPageEvent",self.leftIndex1.."#"..self.leftIndex2)
    end)
end

--#region 起始动画
function bossAwardOBJ:runAction()
    GUI:Timeline_Window1(self.ui.FrameLayout)
end

--#region 刷新左侧list
function bossAwardOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftList)
    self.ui = GUI:ui_delegate(self._parent)
    for index, value in ipairs(bossAwardOBJ.cfg) do
        if index == 4 and (GameData.GetData("U_enter_tow_map",false) or 0) == 0 then
            break
        end
        local btn = GUI:Button_Create(self.ui.leftList,"leftBtn"..index,0,0,"res/custom/dayeqian1.png")
        local infoTab = bossAwardOBJ.cfg[index]
        GUI:Button_setTitleText(btn,infoTab["type"])
        GUI:Button_setTitleFontSize(btn,18)
        GUI:Button_setTitleColor(btn, "#F8E6C6")
        GUI:Button_loadTexturePressed(btn, "res/custom/dayeqian2.png")
        GUI:addOnClickEvent(btn,function ()
            self:leftBtnEvent(index)
        end)
    end
end

--#region 左侧按钮点击事件
function bossAwardOBJ:leftBtnEvent(leftIndex)
    self.leftIndex1 = leftIndex --#region 1级列表index
    removeOBJ(self.ui.leftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..leftIndex],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)
    removeOBJ(self.ui.leftListNow,self)
    local infoTab = bossAwardOBJ.cfg[leftIndex]
    local _height = 40*infoTab["to"]
    GUI:ScrollView_setInnerContainerSize(self.ui.leftList,114,42*#self.cfg+_height)

    local length = 3
    if (GameData.GetData("U_enter_tow_map",false) or 0) > 0 then length = #bossAwardOBJ.cfg end
    for index = 1, length do
        -- GUI:setPositionY(self.ui["leftBtn"..index],440+_height-((index)*42))
        GUI:setPositionY(self.ui["leftBtn"..index],42*#self.cfg+_height-((index)*42))
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/dayeqian1.png")
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..self.leftIndex1],"res/custom/dayeqian2.png")

    for i = leftIndex+1, length do
        GUI:setPositionY(self.ui["leftBtn"..i],GUI:getPositionY(self.ui["leftBtn"..i]) - _height)
    end

    local list = GUI:ListView_Create(self.ui["leftBtn"..leftIndex],"leftListNow",0,0,106,_height,1)
    GUI:setTouchEnabled(list,false)
    GUI:setAnchorPoint(list,0,1)
    for i = 1, infoTab["to"] do
        local img = GUI:Image_Create(list,"smallImg"..i,0,0,"res/custom/npc/37boss/tab.png")
        local name = GUI:Text_Create(img,"name"..i,56,22,16,"#00ff00",infoTab["type"]..i)
        local tab = GameData.GetData("l_bossAward",true) or {} --#region boss悬赏表
        for index, value in ipairs(infoTab["boss_arr"..i]) do --#region 完成标
            if tab == {} or not tab[value] then
                break
            elseif index == #infoTab["boss_arr"..i] then
                GUI:Image_Create(img,"complete"..i,10,24,"res/custom/npc/37boss/tag3.png")
                GUI:setAnchorPoint(self.ui["complete"..i],0.5,0.5)
            end
        end
        GUI:setAnchorPoint(name,0.5,0.5)
        GUI:setLocalZOrder(name,20)
        GUI:setTouchEnabled(name,true)
        GUI:addOnClickEvent(name,function ()
            self:refreshMidBox(i)
        end)
    end

    if (GameData.GetData("UL_bossAward"..leftIndex,false)or 0) > 0 then
        GUI:setVisible(self.ui.rewardBtn,false)
        GUI:setVisible(self.ui.rewardHasImg2,true)
    else
        GUI:setVisible(self.ui.rewardBtn,true)
        GUI:setVisible(self.ui.rewardHasImg2,false)
    end
    local tab = GameData.GetData("l_bossAward",true) or {}
    for i = 1, infoTab["to"] do
        for index, value in ipairs(infoTab["boss_arr"..i]) do --#region 完成标
            if tab == {} or not tab[value] then
                self:refreshMidBox(i)
                return
            end
        end
    end

    self:refreshMidBox(1)
end

--#region 刷新中间box
function bossAwardOBJ:refreshMidBox(leftIndex2)
    self.leftIndex2 = leftIndex2 --#region 2级列表index
    if self.ui.leftNowImg then
        GUI:removeFromParent(self.ui.leftNowImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["smallImg"..leftIndex2],"leftNowImg",52,20,"res/public/1900000678.png")
    GUI:setAnchorPoint(self.ui.leftNowImg,0.5,0.5)
    local tab = GameData.GetData("l_bossAward",true) or {} --#region boss悬赏表
    local bossList = self.cfg[self.leftIndex1]["boss_arr"..self.leftIndex2] --#region 当前展现list
    local temp_list = {}
    for i,v in ipairs(bossList) do
        table.insert(temp_list,{name=v,index =i})
    end
    table.sort(temp_list, function (a,b)
        local a_kill = tab[a.name] and 1 or 0
        local b_kill = tab[b.name] and 1 or 0
        if a_kill ~= b_kill then
            return a_kill < b_kill 
        end
        return a.index < b.index
    end )
    GUI:removeAllChildren(self.ui.midList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for i = 1, #temp_list do
        local name = temp_list[i].name
        local box = GUI:Image_Create(self.ui.midList,"midBox"..i,0,0,"res/custom/npc/37boss/mb_2.png")
        GUI:Text_Create(box,"bossName"..i,138,336,18,"#ff0000",name)
        GUI:setAnchorPoint(self.ui["bossName"..i], 0.5, 0.5)
        GUI:Effect_Create(box,"bossEffect"..i,self.cfg[name]["x"],self.cfg[name]["y"],2,self.cfg[name]["effectId"]
        ,0,self.cfg[name]["action"],self.cfg[name]["to"])
        GUI:setScale(self.ui["bossEffect"..i],self.cfg[name]["scale"])
        if tab[name] then --#region 标签
            GUI:Image_Create(box,"bosTag"..i,230,286,"res/custom/npc/37boss/tag2.png")
        else
            GUI:Image_Create(box,"bosTag"..i,230,286,"res/custom/npc/37boss/tag1.png")
        end
        GUI:setAnchorPoint(self.ui["bosTag"..i],0.5,0.5)
        GUI:Text_Create(box, "goMap"..i, 134, 34, 16, "#FFFF00", "前往："..self.cfg[name]["mapName"])
        GUI:setAnchorPoint(self.ui["goMap"..i],0.5,0.5)
        GUI:Text_enableUnderline(self.ui["goMap"..i])
        GUI:setTouchEnabled(self.ui["goMap"..i],true)
        GUI:addOnClickEvent(self.ui["goMap"..i],function ()
            SendMsgCallFunByNpc(self.npcId, "bossAward", "goMap",self.leftIndex1.."#"..name)
        end)
        if self.cfg[self.leftIndex1]["need_arr"] then
            GUI:setPositionY(self.ui["goMap"..i],50)
            GUI:Text_Create(box, "elseMap"..i, 134, 22, 16, "#FFFF00", "挑战"..self.cfg[self.leftIndex1]["type"].."副本")
            GUI:setAnchorPoint(self.ui["elseMap"..i], 0.5, 0.5)
            GUI:Text_enableUnderline(self.ui["elseMap"..i])
            GUI:setTouchEnabled(self.ui["elseMap"..i],true)
            GUI:addOnClickEvent(self.ui["elseMap"..i], function()
                self:copyMapBox(i,name)
            end)
        end
        time = time +0.1
        GUI:setVisible(box,false)
        GUI:runAction(box,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(box,true)
            GUI:setPositionY(box,360)
            GUI:runAction(box,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.1,GUI:getPositionX(box),0)))
        end)))
    end

    if (GameData.GetData("UL_page_bossAward"..self.leftIndex1.."_"..leftIndex2,false)or 0) > 0 then
        GUI:setVisible(self.ui.rewardBtn_1,false)
        GUI:setVisible(self.ui.rewardHasImg1,true)
    else
        GUI:setVisible(self.ui.rewardBtn_1,true)
        GUI:setVisible(self.ui.rewardHasImg1,false)
    end
    self:itemBox()
end

--#region 打开副本需求box
function bossAwardOBJ:copyMapBox(boxIndex,name)
    self.boxIndex = boxIndex --#region 当前midBoxIndex
    GUI:setTouchEnabled(self.ui.mask,true)
    GUI:setContentSize(self.ui.mask,SL:GetMetaValue("SCREEN_WIDTH"),SL:GetMetaValue("SCREEN_HEIGHT"))
    GUI:Text_setString(self.ui.copyText1,"是否确定前往“"..self.cfg[self.leftIndex1]["type"].."镜像副本”挑战？")
    GUI:Text_setString(self.ui.copyText2,"挑战需要："..self.cfg[self.leftIndex1]["need_arr"][1].."×"..self.cfg[self.leftIndex1]["need_arr"][2])
    GUI:setVisible(self.ui.copyMapBox,true)
    GUI:Timeline_Window3(self.ui.copyMapBox)
    GUI:addOnClickEvent(self.ui.copyBtn1,function ()
        SendMsgCallFunByNpc(self.npcId, "bossAward", "goCopyMap",self.leftIndex1.."#"..name)
    end)
    GUI:addOnClickEvent(self.ui.copyBtn2,function ()
        GUI:setVisible(self.ui.copyMapBox,false)
    end)

end

--#region 刷新奖励box
function bossAwardOBJ:itemBox()
    GUI:removeAllChildren(self.ui.awardBox)
    GUI:removeAllChildren(self.ui.suitBox)
    self.ui = GUI:ui_delegate(self._parent)
    local number = 0
    for k, v in pairs(bossAwardOBJ.cfg[self.leftIndex1]["award_map"] or {}) do
        number = number + 1
        GUI:Image_Create(self.ui.awardBox,"itemBox"..number,0,0,"res/custom/itemBox.png")
        local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
            look = true,})
        GUI:setAnchorPoint(item,0.5,0.5)
    end
    GUI:Image_Create(self.ui.suitBox,"itemBox9",0,0,"res/custom/itemBox.png")
    local item = GUI:ItemShow_Create(self.ui["itemBox9"],"item_"..bossAwardOBJ.cfg[self.leftIndex1]["suit"],30,30,
    {index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", bossAwardOBJ.cfg[self.leftIndex1]["suit"]),bgVisible = false,look = true,})
    GUI:setAnchorPoint(item,0.5,0.5)
end

--#region 后端消息刷新ui
function bossAwardOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["本章"] = function ()
            if (GameData.GetData("UL_bossAward"..self.leftIndex1,false)or 0) > 0 then
                GUI:setVisible(self.ui.rewardBtn,false)
                GUI:setVisible(self.ui.rewardHasImg2,true)
            else
                GUI:setVisible(self.ui.rewardBtn,true)
                GUI:setVisible(self.ui.rewardHasImg2,false)
            end
        end,
        ["本页"] = function ()
            if (GameData.GetData("UL_page_bossAward"..self.leftIndex1.."_"..self.leftIndex2,false)or 0) > 0 then
                GUI:setVisible(self.ui.rewardBtn_1,false)
                GUI:setVisible(self.ui.rewardHasImg1,true)
            else
                GUI:setVisible(self.ui.rewardBtn_1,true)
                GUI:setVisible(self.ui.rewardHasImg1,false)
            end
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
    
end

--#region 关闭前回调
function bossAwardOBJ:onClose(...)

end

-- local function onClickNpc(npc_info)
--     if npc_info.index == bossAwardOBJ.npcId then
--         ViewMgr.open(bossAwardOBJ.Name)
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "bossAwardOBJ", onClickNpc)

return bossAwardOBJ