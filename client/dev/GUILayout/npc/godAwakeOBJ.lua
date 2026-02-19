local godAwakeOBJ = {}

godAwakeOBJ.Name = "godAwakeOBJ"
godAwakeOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
godAwakeOBJ.cfg = SL:Require("GUILayout/config/godAwakeCfg",true)
godAwakeOBJ.npcId = 286
local tips ={
    "<总强化等级50级，获得属性：/FCOLOR=251><人物体力增加10%、护甲穿透100、人物等级+1/FCOLOR=249>"
    .."\\<总强化等级60级，获得属性：/FCOLOR=251><人物体力增加15%、护甲穿透150、人物等级+2/FCOLOR=249>"
    .."\\<总强化等级70级，获得属性：/FCOLOR=251><人物体力增加20%、护甲穿透200、人物等级+3/FCOLOR=249>"
    .."\\<总强化等级80级，获得属性：/FCOLOR=251><人物体力增加25%、护甲穿透250、人物等级+4/FCOLOR=249>"
    .."\\<总强化等级90级，获得属性：/FCOLOR=251><人物体力增加30%、护甲穿透300、人物等级+5/FCOLOR=249>"
    .."\\<总强化等级100级，获得属性：/FCOLOR=251><人物体力增加35%、护甲穿透350、人物等级+6/FCOLOR=249>"
    .."\\<总强化等级110级，获得属性：/FCOLOR=251><人物体力增加40%、护甲穿透400、人物等级+7/FCOLOR=249>"
    .."\\<总强化等级120级，获得属性：/FCOLOR=251><人物体力增加50%、护甲穿透500、人物等级+8/FCOLOR=249>",
}

function godAwakeOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/godAwakeUI")
    self.ui = GUI:ui_delegate(parent)
    GUI:Timeline_Window1(self.ui.FrameLayout)

    self:refreshLeftNode()
    self:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("godAwakeOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("godAwakeOBJ")
    end)
    GUI:addOnClickEvent(self.ui.tipsBtn, function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn)
        GUI:ShowWorldTips(tips[1], worldPos, GUI:p(1, 1))
    end)
    --给服务端发消息
    GUI:addOnClickEvent(self.ui.checkBtn,function ()
        if self.leftIndex == nil then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴神器并选取需要强化的神器！</font>")
        end
        SendMsgCallFunByNpc(self.npcId, "godAwake", "luckEvent", "")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        if self.leftIndex == nil then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴神器并选取需要强化的神器！</font>")
        end
        SendMsgCallFunByNpc(self.npcId, "godAwake", "upEvent", self.leftIndex)
    end)
    --#region 充值box
    GUI:addOnClickEvent(self.ui.buyBtn,function ()
        GUI:setVisible(self.ui.mask,true)
    end)
    GUI:addOnClickEvent(self.ui.mask,function ()
        GUI:setVisible(self.ui.mask,false)
    end)
    GUI:addOnClickEvent(self.ui.maskCloseBtn, function ()
        GUI:setVisible(self.ui.mask,false)
    end)
    GUI:addOnClickEvent(self.ui.buyBtn1,function ()
        SendMsgCallFunByNpc(self.npcId, "godAwake", "buyEvent1", "")
    end)
    GUI:addOnClickEvent(self.ui.buyBtn10,function ()
        SendMsgCallFunByNpc(self.npcId, "godAwake", "buyEvent10", "")
    end)
    GUI:addOnClickEvent(self.ui.buyBtn100,function ()
        SendMsgCallFunByNpc(self.npcId, "godAwake", "buyEvent100", "")
    end)
end

function godAwakeOBJ:runAction() --#region 动画
    GUI:UserUILayout(self.ui.equipListNode1, {dir=1,addDir=2,interval=0.5,gap = {y=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:UserUILayout(self.ui.equipListNode2, {dir=1,addDir=2,interval=0.5,gap = {y=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
end
function godAwakeOBJ:refreshLeftNode() --#region 加载左节点
    self.leftIndex = nil
    for index, value in ipairs(self.cfg) do
        local position = value["position"]
        if SL:GetMetaValue("EQUIPBYPOS", position) == value["name"] then
            removeOBJ(self.ui["equip"..index],self)
            local equip = GUI:EquipShow_Create(self.ui["equipBox"..index],"equip"..index,32,32,position,false,{look=false,bgVisible=false})
            GUI:EquipShow_setAutoUpdate(equip)
            GUI:setAnchorPoint(equip,0.5,0.5)
            local layout = GUI:Layout_Create(self.ui["equipBox"..index],"equipLayout"..index,0,0,60,60,false)
            GUI:setLocalZOrder(layout,20)
            GUI:setTouchEnabled(layout,true)
            GUI:addOnClickEvent(layout,function ()
                if self.leftIndex == index then
                    return
                end
                self:refreshRightNode(index)
            end)
        end
    end
    GUI:Text_setString(self.ui.allStarText,self:allStar().."级")
end

function godAwakeOBJ:refreshRightNode(leftIndex) --#region 加载右节点
    self.leftIndex = leftIndex
    removeOBJ(self.ui.leftTag,self)
    local leftTag = GUI:Image_Create(self.ui["equipBox"..leftIndex],"leftTag",0,0,"res/public/1900000678_1.png")
    GUI:Image_setScale9Slice(leftTag,8,8,28,28)
    GUI:setContentSize(leftTag,64,64)
    Animation.breathingEffect(leftTag,0.5,0.5)
    removeOBJ(self.ui.nowEquip,self)
    local position = self.cfg[leftIndex]["position"]
    local equip = GUI:EquipShow_Create(self.ui.rightNode,"nowEquip",614,424,position,false,{look=true,bgVisible=false})
    GUI:EquipShow_setAutoUpdate(equip)
    GUI:setAnchorPoint(equip,0.5,0.5)
    GUI:Text_setString(self.ui.nowName, self.cfg[leftIndex]["name"])
    local star = tonumber(GameData.GetData("UL_godAwake"..position,false)) or 0
    local strTab1 = {} --#region 文字
    for i = 1, 3 do
        table.insert(strTab1,self.cfg[self.cfg[leftIndex]["level_arr"][1]]["level_arr"][i])
    end
    local strTab2 = {} --#region 百分比biaos
    for i = 4, 6 do
        if self.cfg[self.cfg[leftIndex]["level_arr"][1]]["number_arr"][i] == 0 then
            table.insert(strTab2,"")
        else
            table.insert(strTab2,"%")
        end
    end
    if star == 0 then
        for i = 1, 3 do
            GUI:Text_setString(self.ui["infoText1"..i],strTab1[i].."0"..strTab2[i])
            GUI:Text_setString(self.ui["infoText2"..i],strTab1[i]..self.cfg[self.cfg[leftIndex]["level_arr"][1]]["number_arr"][i]..strTab2[i])
        end
    elseif star == 15 then
        for i = 1, 3 do
            GUI:Text_setString(self.ui["infoText1"..i],strTab1[i]..self.cfg[self.cfg[leftIndex]["level_arr"][star]]["number_arr"][i]..strTab2[i])
            GUI:Text_setString(self.ui["infoText2"..i],strTab1[i].."MAX"..strTab2[i])
        end
    else
        for i = 1, 3 do
            GUI:Text_setString(self.ui["infoText1"..i],strTab1[i]..self.cfg[self.cfg[leftIndex]["level_arr"][star]]["number_arr"][i]..strTab2[i])
            GUI:Text_setString(self.ui["infoText2"..i],strTab1[i]..self.cfg[self.cfg[leftIndex]["level_arr"][star+1]]["number_arr"][i]..strTab2[i])
        end
    end
    GUI:UserUILayout(self.ui.infoNode1, {dir=1,addDir=2,interval=0.5,gap = {y=4},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:UserUILayout(self.ui.infoNode2, {dir=1,addDir=2,interval=0.5,gap = {y=4},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    if tonumber(GameData.GetData("UL_godAwakeLuck",false)) == 1 then
        GUI:Button_loadTextureNormal(self.ui.checkBtn, "res/public/1900000551.png")
        GUI:Text_setString(self.ui.oddsNumber,(self.cfg[self.cfg[leftIndex]["level_arr"][star+1] or self.cfg[leftIndex]["level_arr"][star]]["odd"])+10 .."%")
    else
        GUI:Button_loadTextureNormal(self.ui.checkBtn, "res/public/1900000550.png")
        GUI:Text_setString(self.ui.oddsNumber,self.cfg[self.cfg[leftIndex]["level_arr"][star+1] or self.cfg[leftIndex]["level_arr"][star]]["odd"].."%")
    end
    self:refreshNeedItem()
end

--#region 加载强化需要的物品框(无加号)
function godAwakeOBJ:refreshNeedItem()
    local position = self.cfg[self.leftIndex]["position"]
    local star = tonumber(GameData.GetData("UL_godAwake"..position,false)) or 0
    GUI:removeAllChildren(self.ui.needBox)
    self.ui = GUI:ui_delegate(self._parent)
    if star == 15 then --#region 最高等级
        GUI:setVisible(self.ui.upBtn,false)
        return
    end
    GUI:setVisible(self.ui.upBtn,true)
    local infoTab = self.cfg[self.cfg[self.leftIndex]["level_arr"][star+1]]
    local number = 0 --#region 物品显示
    --#region 升星物品显示
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        local itemColor = 0
        if SL:GetMetaValue("ITEM_COUNT", k) < v then
            itemColor = 249
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
    GUI:UserUILayout(self.ui.needBox, {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists) end})
end

function godAwakeOBJ:allStar() --#region 所有星星计算
    local allStar = 0
    for index, value in ipairs(self.cfg) do
        allStar = allStar + (tonumber(GameData.GetData("UL_godAwake"..value["position"],false)) or 0)
    end
    return allStar
end

--#region 后端消息刷新ui
function godAwakeOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["幸运符"] = function ()
            local position = self.cfg[self.leftIndex]["position"]
            local star = tonumber(GameData.GetData("UL_godAwake"..position,false)) or 0
            if tonumber(GameData.GetData("UL_godAwakeLuck", false)) == 1 then
                GUI:Button_loadTextureNormal(self.ui.checkBtn, "res/public/1900000551.png")
                GUI:Text_setString(self.ui.oddsNumber,(self.cfg[self.cfg[self.leftIndex]["level_arr"][star+1]]["odd"])+10 .."%")
            else
                GUI:Button_loadTextureNormal(self.ui.checkBtn, "res/public/1900000550.png")
                GUI:Text_setString(self.ui.oddsNumber,self.cfg[self.cfg[self.leftIndex]["level_arr"][star+1]]["odd"] .."%")
            end
        end,
        ["失败"] = function ()
            -- self:refreshLeftNode()
            -- self:runAction()
            self:refreshRightNode(self.leftIndex)
            self:refreshNeedItem()
            GUI:Text_setString(self.ui.allStarText,self:allStar().."级")
        end,
        ["强化"] = function ()
            -- self:refreshLeftNode()
            -- self:runAction()
            self:refreshRightNode(self.leftIndex)
            self:refreshNeedItem()
            GUI:Text_setString(self.ui.allStarText,self:allStar().."级")
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end


--#region 关闭前回调
function godAwakeOBJ:onClose(...)

end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == godAwakeOBJ.npcId then
        SendMsgClickNpc(godAwakeOBJ.npcId .. "#godAwake")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, godAwakeOBJ.Name, onClickNpc)

return godAwakeOBJ