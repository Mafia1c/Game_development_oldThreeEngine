local zhuanshengOBJ = {}

zhuanshengOBJ.Name = "zhuanshengOBJ"
zhuanshengOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
zhuanshengOBJ.cfg = SL:Require("GUILayout/config/zhuanshengCfg",true)
zhuanshengOBJ.npcId = 105

function zhuanshengOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/zhuanshengUI")
    self.ui = GUI:ui_delegate(parent)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("zhuanshengOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("zhuanshengOBJ")
    end)
    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "zhuansheng", "upEvent","")
    end)

    for i = 1, 10 do
        GUI:setVisible(self.ui["ball"..i], false)
        GUI:setOpacity(self.ui["ball"..i], 0)
    end
    self:refreshLeftBox()
    self:refreshRightBox()
    self:refreshNeedItem()
    self:runAction()
end
function zhuanshengOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.upBtn)
        end
    end
end
--#region 球渐变
function zhuanshengOBJ:ballLight(i,time,delayTime,type,star)
    local tab = {
        ["出现"] = function()
            GUI:runAction(self.ui["ballImg"],GUI:ActionSequence(GUI:DelayTime(delayTime-time),GUI:CallFunc(function()
                GUI:setVisible(self.ui["ball"..i],true)
                GUI:runAction(self.ui["ball"..i],GUI:ActionFadeIn(time))
                -- if i <= star - 1 then
                --     GUI:setVisible(self.ui["line"..i],true)
                --     GUI:runAction(self.ui["line"..i],GUI:ActionFadeIn(time))
                -- end
            end)))
        end,
        ["消失"] = function()
            GUI:runAction(self.ui["ballImg"],GUI:ActionSequence(GUI:DelayTime(delayTime-time),GUI:CallFunc(function()
                GUI:setVisible(self.ui["ball"..i],false)
                GUI:runAction(self.ui["ball"..i],GUI:ActionFadeOut(time))
                -- if i <= 9 then
                --     GUI:setVisible(self.ui["line"..i],false)
                --     GUI:runAction(self.ui["line"..i],GUI:ActionFadeOut(time))
                -- end
            end)))
        end,
    }
    tab[type]()
end
--#region 开始动画
function zhuanshengOBJ:runAction()
    GUI:runAction(self.ui.leftBox,GUI:ActionSequence(GUI:DelayTime(0.01),GUI:CallFunc(function()
        -- Animation.followOpacity(self.ui.infoList1,255,0.3)
        -- GUI:runAction(self.ui.infoList1,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.3,140,370)))
        GUI:runAction(self.ui.effectBox,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.4,0,0)))
        GUI:runAction(self.ui.ballImg,GUI:ActionMoveTo(0.2,242,274))
    end),GUI:DelayTime(0.2),GUI:CallFunc(function()
        -- Animation.followOpacity(self.ui.infoList2,255,0.3)
        -- GUI:runAction(self.ui.infoList2,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.3,140,222)))
    end)
    ))
    GUI:Timeline_Window1(self.ui.rightBox)
end
--#region 刷新左边box
function zhuanshengOBJ:refreshLeftBox()
    local star = tonumber(GameData.GetData("UL_zsStar",false)) or 0 --#region 星
    local level = SL:GetMetaValue("RELEVEL") --#region 当前转生等级
    GUI:Image_loadTexture(self.ui.levelImg,"res/custom/npc/03zs/level/"..level..".png")
    --math.floor((n - 1) / 10)
    local time = 0
    if level >= 15 then
        for i = 1, 10 do
            time = time + 0.05
            zhuanshengOBJ:ballLight(i, 0.05, time, "出现")
        end
    else
        for i = 1, star do
            time = time + 0.05
            zhuanshengOBJ:ballLight(i, 0.05, time, "出现")
        end
    end

end
--#region 刷新右边box
function zhuanshengOBJ:refreshRightBox()
    local tab = {"攻击：","魔法：","道术：",}
    local typeIndex = tonumber(SL:GetMetaValue("JOB"))--#region 职业转index
    local type = tab[typeIndex+1]
    local name = {type,"防御：","魔防：","生命值："}
    local layer = tonumber(GameData.GetData("l_zhuansheng",false)) --#region 当前表中layer
    local star = tonumber(GameData.GetData("UL_zsStar",false)) --#region 星
    if layer == nil then layer = 0 end;
    if layer == 0 then
        for i = 1, 3 do
            GUI:Text_setString(self.ui["text1"..i],name[i].."0-0")
            GUI:Text_setString(self.ui["text2"..i],name[i].."0-0")
        end
        GUI:Text_setString(self.ui["text14"],name[4].."0")
        GUI:Text_setString(self.ui["text24"],name[4]..(self.cfg[1]["text_"..typeIndex]))
    elseif layer < 100 and star== 10 then
        for i = 1, 3 do
            GUI:Text_setString(self.ui["text1"..i],name[i]..self.cfg[layer-1]["text"..i].."-"..self.cfg[layer-1]["text"..i])
            GUI:Text_setString(self.ui["text2"..i],name[i]..self.cfg[layer]["text"..i].."-"..self.cfg[layer]["text"..i])
        end
        GUI:Text_setString(self.ui["text14"],name[4]..self.cfg[layer]["text_"..typeIndex])
        GUI:Text_setString(self.ui["text24"],name[4]..self.cfg[layer]["text_"..typeIndex])
    elseif layer < 100 then
        for i = 1, 3 do
            GUI:Text_setString(self.ui["text1"..i],name[i]..self.cfg[layer]["text"..i].."-"..self.cfg[layer]["text"..i])
            GUI:Text_setString(self.ui["text2"..i],name[i]..self.cfg[layer]["text"..i].."-"..self.cfg[layer]["text"..i])
        end
        GUI:Text_setString(self.ui["text14"],name[4]..self.cfg[layer]["text_"..typeIndex])
        GUI:Text_setString(self.ui["text24"],name[4]..self.cfg[layer+1]["text_"..typeIndex])
    elseif layer == 100 and star == 10 then
        for i = 1, 3 do
            GUI:Text_setString(self.ui["text1"..i],name[i]..self.cfg[layer-1]["text"..i].."-"..self.cfg[layer-1]["text"..i])
            removeOBJ(self.ui["text2"..i],self)
        end
        GUI:Text_setString(self.ui["text14"],name[4]..self.cfg[layer-1]["text_"..typeIndex])
        removeOBJ(self.ui.infoList2,self)
        GUI:Text_Create(self.ui.rightBox, "text21", 138, 244, 16, "#00ff00", "生命加成：1%")
        GUI:Text_Create(self.ui.rightBox, "text22", 138, 224, 16, "#00ff00", "攻击倍数：0%")
        GUI:Text_Create(self.ui.rightBox, "text23", 138, 204, 16, "#00ff00", "（突破转生渴获得攻击倍数）")
        for i = 1, 3 do
            GUI:setAnchorPoint(self.ui["text2"..i],0.5,0.5)
        end
    elseif layer == #self.cfg and star == 10 then
        for i = 1, 2 do
            removeOBJ(self.ui["infoList" .. i], self)
            removeOBJ(self.ui["text"..i .. "1"], self)
            removeOBJ(self.ui["text"..i .. "2"], self)
            removeOBJ(self.ui["text"..i .. "3"], self)
        end
        GUI:Text_Create(self.ui.rightBox, "text11", 138, 380, 16, "#FFFFFF", "生命加成：" .. self.cfg[layer]["text_"..typeIndex] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text12", 138, 360, 16, "#FFFFFF", "攻击倍数：" .. self.cfg[layer]["text1"] .. "%")

        GUI:Text_Create(self.ui.rightBox, "text21", 138, 244, 16, "#00ff00", "生命加成：".. self.cfg[layer]["text_"..typeIndex] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text22", 138, 224, 16, "#00ff00", "攻击倍数：" .. self.cfg[layer]["text2"] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text23", 138, 204, 16, "#00ff00", "（突破转生可获得攻击倍数）")
        for i = 1, 3 do
            if self.ui["text1" .. i] then GUI:setAnchorPoint(self.ui["text1" .. i], 0.5, 0.5) end
            if self.ui["text2" .. i] then GUI:setAnchorPoint(self.ui["text2" .. i], 0.5, 0.5) end
        end
    elseif layer == #self.cfg and star == 0 then
        for i = 1, 2 do
            removeOBJ(self.ui["infoList" .. i], self)
            removeOBJ(self.ui["text"..i .. "1"], self)
            removeOBJ(self.ui["text"..i .. "2"], self)
            removeOBJ(self.ui["text"..i .. "3"], self)
        end
        GUI:Text_Create(self.ui.rightBox, "text11", 138, 380, 16, "#FFFFFF", "生命加成：" .. self.cfg[layer]["text_"..typeIndex] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text12", 138, 360, 16, "#FFFFFF", "攻击倍数：20%")

        GUI:Text_Create(self.ui.rightBox, "text21", 138, 244, 16, "#00ff00", "生命加成：MAX")
        GUI:Text_Create(self.ui.rightBox, "text22", 138, 224, 16, "#00ff00", "攻击倍数：MAX")
        GUI:Text_Create(self.ui.rightBox, "text23", 138, 204, 16, "#00ff00", "（突破转生可获得攻击倍数）")
        for i = 1, 3 do
            if self.ui["text1" .. i] then GUI:setAnchorPoint(self.ui["text1" .. i], 0.5, 0.5) end
            if self.ui["text2" .. i] then GUI:setAnchorPoint(self.ui["text2" .. i], 0.5, 0.5) end
        end
    elseif layer == 100 and star == 0 then
        for i = 1, 2 do
            removeOBJ(self.ui["infoList" .. i], self)
            removeOBJ(self.ui["text"..i .. "1"], self)
            removeOBJ(self.ui["text"..i .. "2"], self)
            removeOBJ(self.ui["text"..i .. "3"], self)
        end
        GUI:Text_Create(self.ui.rightBox, "text11", 138, 380, 16, "#FFFFFF", "生命加成：" .. self.cfg[101]["text_"..typeIndex] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text12", 138, 360, 16, "#FFFFFF", "攻击倍数：" .. self.cfg[101]["text1"] .. "%")

        GUI:Text_Create(self.ui.rightBox, "text21", 138, 244, 16, "#00ff00", "生命加成：" .. self.cfg[102]["text_"..typeIndex] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text22", 138, 224, 16, "#00ff00", "攻击倍数：" .. self.cfg[101]["text2"] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text23", 138, 204, 16, "#00ff00", "（突破转生可获得攻击倍数）")
        for i = 1, 3 do
            if self.ui["text1" .. i] then GUI:setAnchorPoint(self.ui["text1" .. i], 0.5, 0.5) end
            if self.ui["text2" .. i] then GUI:setAnchorPoint(self.ui["text2" .. i], 0.5, 0.5) end
        end
    else
        for i = 1, 2 do
            removeOBJ(self.ui["infoList" .. i], self)
            removeOBJ(self.ui["text"..i .. "1"], self)
            removeOBJ(self.ui["text"..i .. "2"], self)
            removeOBJ(self.ui["text"..i .. "3"], self)
        end
        GUI:Text_Create(self.ui.rightBox, "text11", 138, 380, 16, "#FFFFFF", "生命加成：" .. self.cfg[layer]["text_"..typeIndex] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text12", 138, 360, 16, "#FFFFFF", "攻击倍数：" .. self.cfg[layer]["text1"] .. "%")

        GUI:Text_Create(self.ui.rightBox, "text21", 138, 244, 16, "#00ff00", "生命加成：" .. self.cfg[layer+1]["text_"..typeIndex] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text22", 138, 224, 16, "#00ff00", "攻击倍数：" .. self.cfg[layer]["text2"] .. "%")
        GUI:Text_Create(self.ui.rightBox, "text23", 138, 204, 16, "#00ff00", "（突破转生可获得攻击倍数）")
        for i = 1, 3 do
            if self.ui["text1" .. i] then GUI:setAnchorPoint(self.ui["text1" .. i], 0.5, 0.5) end
            if self.ui["text2" .. i] then GUI:setAnchorPoint(self.ui["text2" .. i], 0.5, 0.5) end
        end
    end

end
--#region 加载强化需要的物品框(无加号)
function zhuanshengOBJ:refreshNeedItem()
    local layer = tonumber(GameData.GetData("l_zhuansheng",false)) --#region 当前表中layer
    local star = tonumber(GameData.GetData("UL_zsStar",false)) --#region 星
    local level = SL:GetMetaValue("RELEVEL") --#region 转生等级
    GUI:removeAllChildren(self.ui.needBox)
    self.ui = GUI:ui_delegate(self._parent)
    if layer == #self.cfg and star == 0 and level >= 15 then --#region 最高等级
        GUI:setVisible(self.ui.upBtn,false)
        self:flushRed(false)
        return
    end
    if layer == nil then layer = 0 end
    local infoTab = self.cfg[layer+1] or self.cfg[layer]
    if star ~= nil and star == 10 then infoTab = self.cfg[layer] end
    local number = 0
    local is_show_red = true
    --#region 升星物品显示
    if layer >= 110 and star == 10 then --#region 3dl突破特殊判断
        for k, v in pairs(infoTab["upNeed_map1"] or {}) do
            local itemColor = 0
            if SL:GetMetaValue("ITEM_COUNT", k) < v then
                itemColor = 249
                is_show_red = false
            else itemColor = 250 end
            number = number + 1
            GUI:Image_Create(self.ui.needBox,"itemBox"..number,60*(number-1)+(number-1)*(20),0,"res/custom/itemBox.png")
            local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            ItemShow_updateItem(item,{showCount=true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            GUI:setAnchorPoint(item,0.5,0.5)
            GUI:setContentSize(self.ui.needBox,60*(number)+(number-1)*(20),60)
        end
        for k, v in pairs(infoTab["upNeed_map2"] or {}) do
            local itemColor = 0
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", k))) < v then
                itemColor = 249
                is_show_red = false
            else itemColor = 250 end
            number = number + 1
            GUI:Image_Create(self.ui.needBox,"itemBox"..number,60*(number-1)+(number-1)*(20),0,"res/custom/itemBox.png")
            local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            ItemShow_updateItem(item,{showCount=true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            GUI:setAnchorPoint(item,0.5,0.5)
            GUI:setContentSize(self.ui.needBox,60*(number)+(number-1)*(20),60)
        end
    else
        for k, v in pairs(infoTab["needMaterials_map"] or {}) do
            local itemColor = 0
            if SL:GetMetaValue("ITEM_COUNT", k) < v then
                itemColor = 249
                is_show_red = false
            else itemColor = 250 end
            number = number + 1
            GUI:Image_Create(self.ui.needBox,"itemBox"..number,60*(number-1)+(number-1)*(20),0,"res/custom/itemBox.png")
            local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            ItemShow_updateItem(item,{showCount=true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            GUI:setAnchorPoint(item,0.5,0.5)
            GUI:setContentSize(self.ui.needBox,60*(number)+(number-1)*(20),60)
        end
        for k, v in pairs(infoTab["needCurrency_map"] or {}) do
            local itemColor = 0
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", k))) < v then
                itemColor = 249
                is_show_red = false
            else itemColor = 250 end
            number = number + 1
            GUI:Image_Create(self.ui.needBox,"itemBox"..number,60*(number-1)+(number-1)*(20),0,"res/custom/itemBox.png")
            local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            ItemShow_updateItem(item,{showCount=true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            GUI:setAnchorPoint(item,0.5,0.5)
            GUI:setContentSize(self.ui.needBox,60*(number)+(number-1)*(20),60)
        end
        for k, v in pairs(infoTab["needCurrency1_map"] or {}) do
            local itemColor = 0
            if tonumber(SL:GetMetaValue("MONEY", SL:GetMetaValue("ITEM_INDEX_BY_NAME", k))) < v then
                itemColor = 249
                is_show_red = false
            else itemColor = 250 end
            number = number + 1
            GUI:Image_Create(self.ui.needBox,"itemBox"..number,60*(number-1)+(number-1)*(20),0,"res/custom/itemBox.png")
            local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            ItemShow_updateItem(item,{showCount=true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
                look = true,color =itemColor})
            GUI:setAnchorPoint(item,0.5,0.5)
            GUI:setContentSize(self.ui.needBox,60*(number)+(number-1)*(20),60)
        end
        if SL:GetMetaValue("MAP_NAME") ~= "苍月岛" then
            is_show_red =false
        end
    end


  self:flushRed(is_show_red)
end


--#region 后端消息刷新ui
function zhuanshengOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["升星"] = function()
            -- if not self.ui.levelEffect then
            --     GUI:Effect_Create(self.ui.bg,"levelEffect",400,300,0,61528)
            --     GUI:Effect_setAutoRemoveOnFinish(self.ui.levelEffect)
            -- end

            local star = tonumber(GameData.GetData("UL_zsStar",false)) --#region 星
            GUI:setVisible(self.ui["ball"..star],true)
            Animation.followOpacity(self.ui["ball"..star],255,0.3)
            zhuanshengOBJ:refreshRightBox()
            zhuanshengOBJ:refreshNeedItem()
        end,
        ["进阶"] = function()
            -- if not self.ui.levelEffect then
            --     GUI:Effect_Create(self.ui.bg,"levelEffect",400,300,0,61528)
            --     GUI:Effect_setAutoRemoveOnFinish(self.ui.levelEffect)
            -- end
            local time = 0
            for i = 10, 1,-1 do
                time = time + 0.02
                -- zhuanshengOBJ:ballLight(i, 0.03, time, "消失")
                GUI:setVisible(self.ui["ball"..i], false)
            end
            local level = SL:GetMetaValue("RELEVEL") --#region 当前转生等级
            GUI:Image_loadTexture(self.ui.levelImg,"res/custom/npc/03zs/level/"..(level+1)..".png")
            zhuanshengOBJ:refreshRightBox()
            zhuanshengOBJ:refreshNeedItem()
        end,
    }
    functionTab[tab[1]]()
end

--#region 关闭前回调
function zhuanshengOBJ:onClose(...)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == zhuanshengOBJ.npcId then
        ViewMgr.open(zhuanshengOBJ.Name)
    elseif npc_info.index == 254 then
        ViewMgr.open(zhuanshengOBJ.Name)
        -- SendMsgClickNpc(zhuanshengOBJ.npcId .. "#zhuansheng")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, zhuanshengOBJ.Name, onClickNpc)

return zhuanshengOBJ