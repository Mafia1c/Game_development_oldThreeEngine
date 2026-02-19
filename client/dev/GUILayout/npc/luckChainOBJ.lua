local luckChainOBJ = {}
luckChainOBJ.Name = "luckChainOBJ"
luckChainOBJ.cfg1 = { [1] = "强化幸运", [2] = "转移幸运",}
luckChainOBJ.cfg2 = {
    [1] = {["need_config"]={{"金刚石",100},{"超级祝福油",1},}, ["odd"] = 100,},
    [2] = {["need_config"]={{"金刚石",300},{"超级祝福油",1},}, ["odd"] = 100,},
    [3] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 50,},
    [4] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 30,},
    [5] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 20,},
    [6] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 15,},
    [7] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 10,},
    [8] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 5,},
    [9] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 2,},
}
luckChainOBJ.textTab = {"暴击伤害增加：","攻击伤害增加：","忽视目标防御：","人物体力增加：",} --#region 强化
luckChainOBJ.textTab1 = {"身上项链幸运：","暴击伤害增加：","攻击伤害增加：","忽视目标防御：","人物体力增加：",} --#region 转移
luckChainOBJ.textTab2 = {"所选项链幸运：","暴击伤害增加：","攻击伤害增加：","忽视目标防御：","人物体力增加：",} --#region 转移
luckChainOBJ.npcId = 108

function luckChainOBJ:main(...)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/luckChainUI")
    self.ui = GUI:ui_delegate(parent)
    self.info_tab = {...}
    for index, value in ipairs(self.info_tab) do
        self.info_tab[index] = tonumber(value)
    end

    self.mapId = SL:GetMetaValue("MAP_ID") --#region 当前地图号
    self:refreshLeftList()
    self:leftBtnEvent(1)
    -- self:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("luckChainOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("luckChainOBJ")
    end)
end

--#region 刷新左侧list
function luckChainOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg1) do
        local btn = GUI:Button_Create(self.ui.leftList,"leftBtn"..index,0,0,"res/custom/dayeqian1.png")
        GUI:Button_setTitleText(btn,value)
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
function luckChainOBJ:leftBtnEvent(leftIndex)
    self.leftIndex = leftIndex --#region 1级列表index
    if self.ui.leftTag then
        GUI:removeFromParent(self.ui.leftTag)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["leftBtn"..leftIndex],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)
    for index, value in ipairs(self.cfg1) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/dayeqian1.png")
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..self.leftIndex],"res/custom/dayeqian2.png")
    local typeFun = {
        [1] = function () --#region 强化幸运
            self:refreshMidBox1()
            self:refreshRightBox1()
            self:refreshDownBox1()
        end,
        [2] = function () --#region 幸运转移
            self:refreshMidBox2()
            self:refreshRightBox2()
            self:refreshDownBox2()
        end,
    }
    typeFun[leftIndex]()
end

--#region 强化幸运midBox
function luckChainOBJ:refreshMidBox1()
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/08xy/bg1.png")
    GUI:removeAllChildren(self.ui.midBox)
    self.ui = GUI:ui_delegate(self._parent)
    local box = GUI:Layout_Create(self.ui.midBox,"theItemBox",0,0,360,380,true)
    GUI:Node_Create(box,"node1",70,285)
    GUI:Node_Create(box,"node2",290,285)
    GUI:Node_Create(box,"node3",181,188)
    local textBg = GUI:Image_Create(self.ui.midBox,"textBg",184,78,"res/custom/blackBg1.png")
    GUI:Image_setScale9Slice(textBg,33,33,20,20)
    GUI:setContentSize(textBg,334,100)
    GUI:setAnchorPoint(textBg,0.5,0.5)
    GUI:Text_Create(textBg, "luckText", 138, 70, 16, "#ffffff", "幸运：")
    GUI:Text_Create(self.ui.luckText, "luckNumber", GUI:getContentSize(self.ui.luckText).width-2, -1, 16, "#00FF00", "+0")
    GUI:Text_Create(textBg, "oddText", 110, 40, 16, "#ffffff", "成功几率：")
    GUI:Text_Create(self.ui.oddText, "oddNumber", GUI:getContentSize(self.ui.oddText).width-2, -1, 16, "#FFFF00", "100%")
    GUI:Text_Create(textBg, "wearText", 84, 8, 16, "#ffffff", "当前佩戴项链：")
    GUI:Text_Create(self.ui.wearText, "wearNumber", GUI:getContentSize(self.ui.wearText).width-2, -1, 16, "#FF0000", "无")
    local equipName = SL:GetMetaValue("EQUIPBYPOS", 3)
    if equipName ~= "" then
        GUI:Text_setString(self.ui.luckNumber,self.info_tab[1])
        local temp = self.info_tab[1]
        if self.info_tab[1] ~= 9 then
            temp = temp +1
        end
        GUI:Text_setString(self.ui.oddNumber,self.cfg2[temp]["odd"].."%")
        GUI:Text_setString(self.ui.wearNumber,equipName)
        for index, value in ipairs(self.cfg2[temp]["need_config"]) do
            if self.info_tab[1] == 9 then
                break
            end
            local needName = value[1]
            local itemColor = 249
            if SL:GetMetaValue("ITEM_INDEX_BY_NAME", needName) < 1000 then
                if tonumber(SL:GetMetaValue("MONEY", SL:GetMetaValue("ITEM_INDEX_BY_NAME", needName))) >= value[2] then
                    itemColor = 250
                end
            else
                if SL:GetMetaValue("ITEM_COUNT", needName) >= value[2] then
                    itemColor = 250
                end
            end
            local item = GUI:ItemShow_Create(self.ui["node" .. index], "item_" .. needName, 0, 0,
    {index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", needName),count = value[2],bgVisible = false,look = true,color = itemColor})
            ItemShow_updateItem(item,{showCount=true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", needName),count = value[2],bgVisible = false,look = true,color = itemColor})
            GUI:setAnchorPoint(item, 0.5, 0.5)
        end
        GUI:EquipShow_Create(self.ui.node3,"item_now",0,0,3,false,{look=true,bgVisible=false,})
        GUI:Image_Create(self.ui.item_now,"equipNowTips",38,38,"res/custom/equip_tips.png")
        GUI:setScale(self.ui.equipNowTips,0.8)
        GUI:setAnchorPoint(self.ui.equipNowTips,0.5,0.5)
        GUI:setAnchorPoint(self.ui.item_now, 0.5, 0.5)
    end
end
--#region 强化幸运右边box
function luckChainOBJ:refreshRightBox1()
    GUI:removeAllChildren(self.ui.rightBox)
    self.ui = GUI:ui_delegate(self._parent)
    GUI:Text_Create(self.ui.rightBox, "text11", 72, 356, 16, "#F0B42A", "[幸运洗练说明]：")
    GUI:setAnchorPoint(self.ui.text11,0.5,0.5)
    local RtextStr = ""
    if self.mapId == "3" then
        RtextStr = "项链幸运最高可以增加幸运：+3！"
    else
        RtextStr = "项链幸运最高可以增加幸运：+9幸运4开始每提升1点幸运，随机为项链附加下方一条元素属性！"
    end
    GUI:RichTextFCOLOR_Create(self.ui.rightBox,"Rtext",10,340,RtextStr,232,16,"#63D64A")
    GUI:setAnchorPoint(self.ui.Rtext,0,1)
    local list = GUI:ListView_Create(self.ui.rightBox,"rightList",126,140,200,160,1)
    GUI:ListView_setClippingEnabled(list,true)
    GUI:ListView_setItemsMargin(list,10)
    GUI:setAnchorPoint(list,0.5,0.5)
    local time = 0
    for i = 1, 4 do
        local black = GUI:Image_Create(list,"textBlack"..i,0,0,"res/custom/blackBg2.png")
        GUI:Image_setScale9Slice(black,5,5,10,10)
        GUI:setContentSize(black,200,30)
        GUI:Text_Create(black,"infoText"..i,40,4,16,"#FF00FF",self.textTab[i]..self.info_tab[i+1])
        GUI:setVisible(black,false)
        time = time +0.05
        GUI:runAction(black,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(black,true)
            GUI:setPositionX(black,200)
            GUI:runAction(black,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(black))))
        end)))
    end
    if self.mapId == "3" then
        GUI:setVisible(list,false)
    else
    end
end
--#region 强化幸运底部box
function luckChainOBJ:refreshDownBox1()
    GUI:removeAllChildren(self.ui.downBox)
    self.ui = GUI:ui_delegate(self._parent)
    local btn = GUI:Button_Create(self.ui.downBox,"upBtn",300,44,"res/custom/bt_dz.png")
    GUI:Button_setTitleText(btn,"强化幸运")
    GUI:Button_setTitleColor(btn,"#f8e6c6")
    GUI:Button_setTitleFontSize(btn,18)
    GUI:setAnchorPoint(btn,0.5,0.5)
    GUI:addOnClickEvent(btn,function ()
        if SL:GetMetaValue("EQUIPBYPOS", 3) == "" then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>当时还未穿戴项链！</font>")
        end
        SendMsgCallFunByNpc(self.npcId, "luckChain", "reinforce","")
    end)
end


--#region 转移幸运midBox
function luckChainOBJ:refreshMidBox2()
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/08xy/bg2.png")
    GUI:removeAllChildren(self.ui.midBox)
    self.ui = GUI:ui_delegate(self._parent)
    local box = GUI:Layout_Create(self.ui.midBox,"theItemBox",0,0,360,380,true)
    GUI:Node_Create(box,"node1",70,285)
    GUI:Node_Create(box,"node2",290,285)
    GUI:Node_Create(box,"node3",181,188)
    local textBg = GUI:Image_Create(self.ui.midBox,"textBg",180,78,"res/custom/blackBg1.png")
    GUI:Image_setScale9Slice(textBg,33,33,20,20)
    GUI:setContentSize(textBg,350,150)
    GUI:setAnchorPoint(textBg,0.5,0.5)
    local list1 = GUI:ListView_Create(textBg,"textList1",26,-6,148,146,1)
    GUI:ListView_setClippingEnabled(list1,true)
    GUI:ListView_setItemsMargin(list1,8)
    local list2 = GUI:ListView_Create(textBg,"textList2",190,-6,148,146,1)
    GUI:ListView_setClippingEnabled(list2,true)
    GUI:ListView_setItemsMargin(list2,8)
    for i = 1, 5 do
        local text1 = GUI:Text_Create(list1,"wear_text"..i,0,0,16,"#FFFFFF",self.textTab1[i])
        GUI:Text_Create(text1, "wear_text1"..i, GUI:getContentSize(text1).width-2, -1, 16, "#FFFF00", "+0")
        local text2 = GUI:Text_Create(list2,"click_text"..i,0,0,16,"#FFFFFF",self.textTab2[i])
        GUI:Text_Create(text2, "click_text1"..i, GUI:getContentSize(text2).width-2, -1, 16, "#00FF00", "+0")
    end
    if self.mapId == "3" then
        for i = 2, 5 do
            GUI:setVisible(self.ui["wear_text"..i],false)
            GUI:setVisible(self.ui["click_text"..i],false)
        end
    end

    local equipName = SL:GetMetaValue("EQUIPBYPOS", 3)
    if equipName ~= "" then
        GUI:Text_setString(self.ui.wear_text11,"+"..self.info_tab[1])
        GUI:Text_setString(self.ui.wear_text12,self.info_tab[2].."%")
        GUI:Text_setString(self.ui.wear_text13,self.info_tab[3].."%")
        GUI:Text_setString(self.ui.wear_text14,self.info_tab[4].."%")
        GUI:Text_setString(self.ui.wear_text15,self.info_tab[5].."%")
        GUI:EquipShow_Create(self.ui.node1,"item_now",0,0,3,false,{look=true,bgVisible=false,})
        GUI:setAnchorPoint(self.ui.item_now, 0.5, 0.5)
        local itemColor = 249
        if tonumber(SL:GetMetaValue("MONEY", SL:GetMetaValue("ITEM_INDEX_BY_NAME", "灵符"))) >= 1000 then
            itemColor = 250
        end
        local item = GUI:ItemShow_Create(self.ui.node2, "item_灵符", 0, 0,
{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", "灵符"),count = 1000,bgVisible = false,look = true,color = itemColor})
        GUI:setAnchorPoint(item, 0.5, 0.5)
        GUI:Image_Create(self.ui.item_now,"equipNowTips",38,38,"res/custom/equip_tips.png")
        GUI:setScale(self.ui.equipNowTips,0.8)
        GUI:setAnchorPoint(self.ui.equipNowTips,0.5,0.5)
    end
end
--#region 转移幸运右边box
function luckChainOBJ:refreshRightBox2()
    GUI:removeAllChildren(self.ui.rightBox)
    self.ui = GUI:ui_delegate(self._parent)
    local bag_items = SL:GetMetaValue("BAG_DATA")
    local tmp_list = {}
    for k, v in pairs(bag_items) do
        if 19 == v.StdMode or 20 == v.StdMode or 21 == v.StdMode then
            local data = {}
            data.index = v.Index
            -- data.count = v.OverLap
            data.look = false
            data.bgVisible = false
            data._MakeIndex = v.MakeIndex
            tmp_list[#tmp_list + 1] = data
        end
    end
    table.sort(tmp_list, function (a,b)
        return a.index < b.index
    end)
    self.has_data_list = tmp_list --#region 背包项链列表

    local bigList = GUI:ListView_Create(self.ui.rightBox,"rightBigList",0,0,254,380,1)
    GUI:ListView_setItemsMargin(bigList,3)
    GUI:ListView_setBounceEnabled(bigList,true)
    GUI:ListView_setClippingEnabled(bigList,true)
    if #self.has_data_list <= 24 then
        local time = 0
        for i = 1, 6 do
            local list = GUI:ListView_Create(bigList,"rightList"..i,0,0,254,60,2)
            GUI:ListView_setItemsMargin(list,5)
            GUI:ListView_setClippingEnabled(list,true)
            GUI:setTouchEnabled(list,false)
            for j = 1, 4 do
                GUI:Image_Create(list,"sonImg"..(i-1)*4+j,0,0,"res/custom/k1.png")
            end
            GUI:setVisible(list,false)
            time = time + 0.05
            GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
                GUI:setVisible(list, true)
                GUI:setPositionX(list, 254)
                GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
            end)))
        end
    else
        local list_number = math.ceil(#self.has_data_list/4)
        local time = 0
        for i = 1, list_number, 1 do
            local list = GUI:ListView_Create(bigList,"rightList"..i,0,0,254,60,2)
            GUI:ListView_setItemsMargin(list,5)
            GUI:ListView_setClippingEnabled(list,true)
            GUI:setTouchEnabled(list,false)
            for j = 1, 4 do
                GUI:Image_Create(list,"sonImg"..(i-1)*4+j,0,0,"res/custom/k1.png")
            end
            GUI:setVisible(list,false)
            time = time + 0.05
            GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
                GUI:setVisible(list, true)
                GUI:setPositionX(list, 254)
                GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
            end)))
        end
    end
    for index, value in ipairs(self.has_data_list or {}) do
        self:createSonItem(index)
    end
end
--#region 创建子列表
function luckChainOBJ:createSonItem(sonIndex)
    local index = math.ceil(sonIndex/4)
    local item = GUI:ItemShow_Create(self.ui["sonImg"..sonIndex],"sonItem"..sonIndex,30,30
    ,{index = self.has_data_list[sonIndex]["index"],look = true,bgVisible =false,itemData = SL:GetMetaValue("ITEM_DATA_BY_MAKEINDEX",  self.has_data_list[sonIndex]["_MakeIndex"], false)})
    GUI:setAnchorPoint(item,0.5,0.5)
    local layout = GUI:Layout_Create(item,"sonLayout"..sonIndex,30,30,60,60,true)
    GUI:setAnchorPoint(layout,0.5,0.5)
    GUI:setTouchEnabled(layout,true)
    GUI:setSwallowTouches(layout, false)
    GUI:addOnClickEvent(layout,function ()
        if self.sonIndex == sonIndex then
            GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..self.sonIndex], false)
            self.sonIndex = nil
            removeOBJ(self.ui.item_select,self)
            GUI:Text_setString(self.ui.click_text11, "+0")
            GUI:Text_setString(self.ui.click_text12, "0%")
            GUI:Text_setString(self.ui.click_text13, "0%")
            GUI:Text_setString(self.ui.click_text14, "0%")
            GUI:Text_setString(self.ui.click_text15, "0%")
        else
            if self.sonIndex ~= nil then
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..self.sonIndex], false)
            end
            self.sonIndex = sonIndex
            GUI:ItemShow_setItemShowChooseState(self.ui["sonItem" .. sonIndex], true)
            self:updateSelectData()
            SendMsgCallFunByNpc(self.npcId, "luckChain", "select",self.has_data_list[sonIndex]["_MakeIndex"])
        end
    end)
end
function luckChainOBJ:updateSelectData()
    local setData  = {}
    setData.index = self.has_data_list[self.sonIndex]["index"]
    setData.look  = true
    setData.bgVisible = false
    setData.itemData = SL:GetMetaValue("ITEM_DATA_BY_MAKEINDEX",  self.has_data_list[self.sonIndex]["_MakeIndex"], false)
    removeOBJ(self.ui.item_select,self)
    local item = GUI:ItemShow_Create(self.ui.node3, "item_select", 0, 0,setData)
    GUI:setAnchorPoint(item, 0.5, 0.5)
end
--#region 转移幸运底部box
function luckChainOBJ:refreshDownBox2()
    GUI:removeAllChildren(self.ui.downBox)
    self.ui = GUI:ui_delegate(self._parent)
    GUI:Text_Create(self.ui.downBox,"downText1",12,54,16,"#F0B42A","[转移说明]：")
    GUI:Text_Create(self.ui.downBox,"downText2",12,6,16,"#00FF00","转移幸运项链仅支持非绑定灵符，无法使用绑定灵符转移幸运项链成功将幸运及元素属性覆盖至身上项链")
    GUI:setContentSize(self.ui.downText2, 370, 48)

    local btn = GUI:Button_Create(self.ui.downBox,"upBtn",474,42,"res/custom/bt_dz.png")
    GUI:Button_setTitleText(btn,"转移幸运")
    GUI:Button_setTitleColor(btn,"#f8e6c6")
    GUI:Button_setTitleFontSize(btn,18)
    GUI:setAnchorPoint(btn,0.5,0.5)
    GUI:addOnClickEvent(btn,function ()
        if SL:GetMetaValue("EQUIPBYPOS", 3) == "" then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>当时还未穿戴项链！</font>")
        elseif self.sonIndex == nil then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先选择需要转移属性的项链！</font>")
        end
        SendMsgCallFunByNpc(self.npcId, "luckChain", "transfer",self.has_data_list[self.sonIndex]["_MakeIndex"])
    end)
end

--#region 关闭前回调
function luckChainOBJ:onClose(...)

end

--#region 后端消息刷新ui
function luckChainOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["强化"] = function()
            self.info_tab = { }
            for i = 1, 5 do
                table.insert(self.info_tab,tonumber(tab[i+1]))
            end
            self:refreshMidBox1()
            self:refreshRightBox1()
        end,
        ["失败"] = function ()
            self.info_tab = { }
            for i = 1, 5 do
                table.insert(self.info_tab,tonumber(tab[i+1]))
            end
            self:refreshMidBox1()
        end,
        ["选取"] = function ()
            GUI:Text_setString(self.ui.click_text11, "+" .. tab[2])
            GUI:Text_setString(self.ui.click_text12, tab[3] .. "%")
            GUI:Text_setString(self.ui.click_text13, tab[4] .. "%")
            GUI:Text_setString(self.ui.click_text14, tab[5] .. "%")
            GUI:Text_setString(self.ui.click_text15, tab[6] .. "%")
        end,
        ["转移"] = function ()
            self.info_tab = { }
            for i = 1, 5 do
                table.insert(self.info_tab,tonumber(tab[i+1]))
            end
            self:refreshMidBox2()
            self:refreshRightBox2()
            GUI:ItemShow_setItemShowChooseState(self.ui["sonItem" .. self.sonIndex], true)
            self:updateSelectData()
            SendMsgCallFunByNpc(self.npcId, "luckChain", "select",self.has_data_list[self.sonIndex]["_MakeIndex"])
        end
    }
    functionTab[tab[1]]()
end

local function onClickNpc(npc_info)
    if npc_info.index == luckChainOBJ.npcId or npc_info.index ==419 then
        SendMsgClickNpc(luckChainOBJ.npcId .. "#luckChain")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "luckChainOBJ", onClickNpc)
return luckChainOBJ