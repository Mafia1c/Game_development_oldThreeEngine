local godStoveOBJ = {}
godStoveOBJ.Name = "godStoveOBJ"
godStoveOBJ.cfg = SL:Require("GUILayout/config/godStoveCfg",true)
godStoveOBJ.npcId = 413

function godStoveOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/godStoveUI")
    self.ui = GUI:ui_delegate(parent)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("godStoveOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("godStoveOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn1,function ()
        SendMsgCallFunByNpc(self.npcId, "godStove", "upEvent1", self.leftIndex.."#"..(self.itemIndex or 0))
    end)
    GUI:addOnClickEvent(self.ui.upBtn10,function ()
        SendMsgCallFunByNpc(self.npcId, "godStove", "upEvent10", self.leftIndex.."#"..(self.itemIndex or 0))
    end)

    Animation.breathingEffect(self.ui.arrowImage, 0.7,0.7)
    self:refreshLeftList()
    self:leftBtnEvent(1)
end

--#region 刷新左侧list
function godStoveOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
        local btn = GUI:Button_Create(self.ui.leftList,"leftBtn"..index,0,0,"res/custom/dayeqian1.png")
        GUI:Button_setTitleText(btn,value["name"])
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
function godStoveOBJ:leftBtnEvent(leftIndex)
    self.leftIndex = leftIndex --#region 1级列表index
    removeOBJ(self.ui.leftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..leftIndex],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/dayeqian1.png")
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..self.leftIndex],"res/custom/dayeqian2.png")
    GUI:ItemShow_updateItem(self.ui.item_end,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[leftIndex]["name"]),look=true,bgVisible=false,})
    GUI:removeAllChildren(self.ui.needItemNode,self)
    self.ui = GUI:ui_delegate(self._parent)
    for i = 1, 3 do
        GUI:Image_Create(self.ui.needItemNode,"itemBox"..i,0,0,"res/custom/itemBox.png")
    end
    local infoTab = self.cfg[leftIndex]
    local number = 0 --#region 物品显示
    self.is_show_red = true
    self.is_show_red2 = true
    --#region 升星物品显示
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do
        local itemColor = 250
        if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", k))) < v then
            itemColor = 249
            self.is_show_red =  false
        end
        if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", k))) < v*10 then
            self.is_show_red2 =  false
        end
        number = number + 1
        local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
            look = true,color =itemColor})
        GUI:setAnchorPoint(item,0.5,0.5)
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do
        local itemColor = 250
        if tonumber(SL:GetMetaValue("MONEY", SL:GetMetaValue("ITEM_INDEX_BY_NAME", k))) < v then
            itemColor = 249
            self.is_show_red =  false
        end
        if tonumber(SL:GetMetaValue("MONEY", SL:GetMetaValue("ITEM_INDEX_BY_NAME", k))) < v*10 then
             self.is_show_red2 =  false
        end
        number = number + 1
        local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
            look = true,color =itemColor})
        GUI:setAnchorPoint(item,0.5,0.5)
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        local itemColor = 250
        if SL:GetMetaValue("ITEM_COUNT", k) < v then
            itemColor = 249
            self.is_show_red =  false
        end
        if SL:GetMetaValue("ITEM_COUNT", k) < v*10 then
            self.is_show_red2 =  false
        end
        number = number + 1
        local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
            look = true,color =itemColor})
        GUI:setAnchorPoint(item,0.5,0.5)
    end
    GUI:UserUILayout(self.ui.needItemNode, {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})

    self:refreshBag()
end

--#region 遍历背包(国殇残魂)
function godStoveOBJ:refreshBag()
    local itemIndexTab = {10380,10381,10382,10383,10384,10385,10386,10387,10388,10389}
    GUI:removeAllChildren(self.ui.rightBigList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for i = 1, 5 do
        local list = GUI:ListView_Create(self.ui.rightBigList, "rightList" .. i, 0, 0, 242, 60, 2)
        GUI:ListView_setItemsMargin(list, 2)
        GUI:ListView_setClippingEnabled(list, true)
        GUI:setTouchEnabled(list, false)
        for j = 1, 4 do
            GUI:Image_Create(list, "sonImg" .. (i - 1) * 4 + j, 0, 0, "res/custom/k1.png")
        end
        GUI:setVisible(list, false)
        time = time + 0.05
        GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
            GUI:setVisible(list, true)
            GUI:setPositionX(list, 254)
            GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
        end)))
    end

    self.sonIndex = nil
    self.itemIndex = nil
    if self.leftIndex == 5 then
        local number = 0
        self:flushRed(false,false)
        for index, value in ipairs(itemIndexTab) do
            local count = SL:GetMetaValue("ITEM_COUNT", value) --总数量
            number = number + math.ceil(count / 9999)      --占第几个格子
            self:createSonItem(index,count, number, value)
        end
    else
        self:flushRed(self.is_show_red, self.is_show_red2)
    end
end
--#region 创建子列表
function godStoveOBJ:createSonItem(tabIndex,count,number,itemIndex)
    if count < 1 then
        return
    end
    local count1 = math.ceil(count / 9999)
    local item
    if tabIndex == 1 then
        for i = 1, count1, 1 do
            if i ~= count1 then
                item = GUI:ItemShow_Create(self.ui["sonImg" .. i], "sonItem" .. i, 30, 30,
                    { index = itemIndex, bgVisible = false, count = 9999 })
            elseif i > 24 then
                return
            else
                item = GUI:ItemShow_Create(self.ui["sonImg" .. i], "sonItem" .. i, 30, 30,
                    { index = itemIndex, bgVisible = false, count = count - (count1 - 1) * 9999 })
                ItemShow_updateItem(item,{showCount=true,index=itemIndex,bgVisible=false,count=count-(count1-1)*9999,color=255})
            end
            GUI:setAnchorPoint(item, 0.5, 0.5)
            self:createLayout(item, i, itemIndex)
        end
    else
        for i = number- count1+1, number do
            if i ~= number then
                item = GUI:ItemShow_Create(self.ui["sonImg" .. i], "sonItem" .. i, 30, 30,
                    { index = itemIndex, bgVisible = false, count = 9999 })
            elseif i > 24 then
                return
            else
                item = GUI:ItemShow_Create(self.ui["sonImg" .. i], "sonItem" .. i, 30, 30,
                    { index = itemIndex, bgVisible = false, count = count - (count1 - 1) * 9999 })
                ItemShow_updateItem(item,{showCount=true,index=itemIndex,bgVisible=false,count=count-(count1-1)*9999,color=255})
            end
            GUI:setAnchorPoint(item, 0.5, 0.5)
            self:createLayout(item, i, itemIndex)
        end
    end
end

function godStoveOBJ:createLayout(item,sonIndex,_itemIndex) --#region 创建点击容器和点击事件
    local layout = GUI:Layout_Create(item, "sonLayout" .. sonIndex, 30, 30, 60, 60, true)
    GUI:setAnchorPoint(layout, 0.5, 0.5)
    GUI:setTouchEnabled(layout, true)
    GUI:addOnClickEvent(layout, function()
        local special_red,special_red2 = true,true
        if self.sonIndex == sonIndex then
            GUI:ItemShow_setItemShowChooseState(self.ui["sonItem" .. self.sonIndex], false)
            self.sonIndex = nil
            self.itemIndex = nil
            removeOBJ(self.ui.item_need53, self)
            special_red = false
            special_red2 = false
        else
            if self.sonIndex ~= nil then
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem" .. self.sonIndex], false)
            end
            self.sonIndex = sonIndex
            self.itemIndex = _itemIndex
            GUI:ItemShow_setItemShowChooseState(self.ui["sonItem" .. sonIndex], true)
            removeOBJ(self.ui.item_need53, self)
            local color = 250
            if SL:GetMetaValue("ITEM_COUNT", _itemIndex) < 99 then
                color = 249
                special_red = false
            end
            if SL:GetMetaValue("ITEM_COUNT", _itemIndex) < 990 then
                special_red2 = false
            end
            GUI:ItemShow_Create(self.ui.itemBox3, "item_need53", 30, 30, { index = _itemIndex, look = true, bgVisible = false,color=color,count=99 })
            GUI:setAnchorPoint(self.ui.item_need53, 0.5, 0.5)
        end
            self:flushRed(self.is_show_red and special_red,self.is_show_red2 and special_red2)
    end)

end

function godStoveOBJ:flushRed(is_show_red,is_show_red2)
    -- if self.red_width then
    --     GUI:removeFromParent(self.red_width)
    --     self.red_width = nil
    -- end 
    GUI:removeAllChildren(self.ui.upBtn1)
    if is_show_red then
        SL:CreateRedPoint(self.ui.upBtn1)
    end
    GUI:removeAllChildren(self.ui.upBtn10)
    if is_show_red2 then
        SL:CreateRedPoint(self.ui.upBtn10)
    end
end

--#region 关闭前回调
function godStoveOBJ:onClose(...)

end

--#region 后端消息刷新ui
function godStoveOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["熔炼"] = function()
            self:leftBtnEvent(self.leftIndex)
        end,
    }
    functionTab[tab[1]]()
end

local function onClickNpc(npc_info)
    if npc_info.index == godStoveOBJ.npcId then
        ViewMgr.open(godStoveOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "godStoveOBJ", onClickNpc)
return godStoveOBJ