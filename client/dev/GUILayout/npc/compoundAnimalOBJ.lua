local compoundAnimalOBJ = {}
compoundAnimalOBJ.Name = "compoundAnimalOBJ"
compoundAnimalOBJ.cfg = SL:Require("GUILayout/config/compoundAnimalCfg",true)
compoundAnimalOBJ.npcId = 100

function compoundAnimalOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/compoundAnimalUI")
    self.ui = GUI:ui_delegate(parent)
    self.red_width_list = {}
    self:refreshLeftList()
    self:leftBtnEvent1(1)
    -- self:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("compoundAnimalOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("compoundAnimalOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn,function ()
        SendMsgCallFunByNpc(self.npcId, "compoundAnimal", "upEvent",self.leftIndex1.."#"..self.leftIndex2.."#"..self.sonIndex)
    end)
end

--#region 刷新左侧list
function compoundAnimalOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftList1)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
        local btn = GUI:Button_Create(self.ui.leftList1,"leftBtn"..index,0,0,"res/custom/dayeqian1.png")
        GUI:Button_setTitleText(btn,value["type"])
        GUI:Button_setTitleFontSize(btn,18)
        GUI:Button_setTitleColor(btn,"#F8E6C6")
        GUI:Button_loadTexturePressed(btn, "res/custom/dayeqian2.png")
        GUI:addOnClickEvent(btn,function ()
            self:leftBtnEvent1(index)
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

function compoundAnimalOBJ:FlushBtnRedShow()
    for i,v in ipairs(self.cfg) do
        --一级按钮红点
        if self:IsShowOneTagRedShow(i)  then  
            if self.red_width_list["leftBtn"..i] == nil then
                self.red_width_list["leftBtn"..i] = SL:CreateRedPoint(self.ui["leftBtn"..i] ,{x=102,y=10})
            end
        else
            if self.red_width_list["leftBtn"..i]  then
                GUI:removeFromParent(self.red_width_list["leftBtn"..i] )
                self.red_width_list["leftBtn"..i]  = nil
            end 
        end
    end
end
function compoundAnimalOBJ:FlushTwoBtnRedShow(leftIndex1)
    --二级红点
    local type = self.cfg[leftIndex1]["equip_arr"][1]
    for index = 1, #self.cfg[type]["equip_arr"] do
        if self:TwoTagIsShowRed(leftIndex1,1,index) then
            if GUI:Win_IsNull(self.red_width_list["name_"..leftIndex1.."_"..index]) and self.ui["name"..index] then
                self.red_width_list["name_"..leftIndex1.."_"..index] = SL:CreateRedPoint(self.ui["name"..index] ,{x=102,y=2})
            end
        else
            if not GUI:Win_IsNull(self.red_width_list["name_"..leftIndex1.."_"..index])  then
                GUI:removeFromParent(self.red_width_list["name_"..leftIndex1.."_"..index] )
                self.red_width_list["name_"..leftIndex1.."_"..index]  = nil
            end 
        end
    end
end

function compoundAnimalOBJ:IsShowOneTagRedShow(leftIndex1)
    local type = self.cfg[leftIndex1]["equip_arr"][1]
    for i = 1, #self.cfg[type]["equip_arr"] do
        if self:TwoTagIsShowRed(leftIndex1,1,i) then
            return true
        end
    end
    return false
end
--#region 左侧一级按钮点击事件
function compoundAnimalOBJ:leftBtnEvent1(leftIndex1)
    self.leftIndex1 = leftIndex1 --#region 1级列表index
    GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/npc/02sx/bg"..leftIndex1..".png")
    if self.ui.leftTag1 then
        GUI:removeFromParent(self.ui.leftTag1)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["leftBtn"..leftIndex1],"leftTag1",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag1,0.5,0.5)
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/dayeqian1.png")
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..self.leftIndex1],"res/custom/dayeqian2.png")
    GUI:removeAllChildren(self.ui.leftList2)
    self.ui = GUI:ui_delegate(self._parent)
    for index, value in ipairs(self.cfg[leftIndex1]["equip_arr"]) do
        local btn = GUI:Button_Create(self.ui.leftList2,"left_btn"..index,5,0,"res/custom/yeqian1.png")
        GUI:Button_setTitleText(btn,value)
        GUI:Button_setTitleFontSize(btn,18)
        GUI:Button_setTitleColor(btn,"#F8E6C6")
        GUI:Button_loadTexturePressed(btn, "res/custom/yeqian1.png")
        -- GUI:addOnClickEvent(btn,function ()
        --     self:leftBtnEvent2(index)
        -- end)
        GUI:setPositionY(btn,GUI:getContentSize(self.ui.leftList2).height-36*(index))
    end

    self:leftBtnEvent2(1)
end

--#region 左侧二级按钮点击事件
function compoundAnimalOBJ:leftBtnEvent2(leftIndex2)
    self.leftIndex2 = leftIndex2 --#region 二级标签
    local type = self.cfg[self.leftIndex1]["equip_arr"][leftIndex2]

    if self.ui.leftTag2 then
        GUI:removeFromParent(self.ui.leftTag2)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["left_btn"..leftIndex2],"leftTag2",-1,32,"res/public/jiantou.png")
    GUI:setRotation(self.ui.leftTag2,90)
    GUI:setAnchorPoint(self.ui.leftTag1,0.5,0.5)
    if self.ui.leftListNow then
        GUI:removeFromParent(self.ui.leftListNow)
        self.ui = GUI:ui_delegate(self._parent)
    end
    local list = GUI:ListView_Create(self.ui["left_btn"..leftIndex2],"leftListNow",0,0,110,40*10,1)
    GUI:ListView_setBounceEnabled(list,true)
    -- GUI:setTouchEnabled(list,false)
    GUI:setAnchorPoint(list,0,1)
    local time = 0
    for i = 1, #self.cfg[type]["equip_arr"] do
        local img = GUI:Image_Create(list,"smallImg"..i,0,0,"res/custom/sonBox.png")
        local name = GUI:Text_Create(img,"name"..i,60,22,16,"#FFFFFF",self.cfg[type]["equip_arr"][i])
        GUI:setAnchorPoint(name,0.5,0.5)
        GUI:setLocalZOrder(name,20)
        GUI:setTouchEnabled(name,true)
        GUI:addOnClickEvent(name,function ()
            self:refreshMidBox(i)
        end)
        GUI:setVisible(img,false)
        time = time +0.05
        GUI:runAction(img,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(img,true)
            GUI:setPositionX(img,114)
            GUI:runAction(img,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(img))))
        end)))
    end
    self:refreshMidBox(1)
end
local function allStarFun() --#region 获取所有生肖星星总数
    local allStar = 0
    for i = 1, 12 do
        local star = GameData.GetData("l_animalStar_"..i,false) or 0
        allStar = allStar + star
    end
    return allStar
end
local suit ={
    "<当前佩戴传承系列生肖星星总数量：","/120/FCOLOR=250>\\<佩戴传承系列生肖星星总数达到15星，获得属性：PK增伤1%/FCOLOR=251>\\<佩戴传承系列生肖星星总数达到30星，获得属性：PK增伤3%/FCOLOR=251>"
    .."\\<佩戴传承系列生肖星星总数达到45星，获得属性：PK增伤5%/FCOLOR=251>\\<佩戴传承系列生肖星星总数达到60星，获得属性：PK增伤10%/FCOLOR=251>"
    .."\\<佩戴传承系列生肖星星总数达到90星，获得属性：PK增伤15%、生命加成10%/FCOLOR=251>\\<佩戴传承系列生肖星星总数达到120星，获得属性：PK增伤20%、生命加成20%/FCOLOR=251>",
}
--#region 子对象刷新midBox
function compoundAnimalOBJ:refreshMidBox(sonIndex)
    local suffix ={"(鼠)","(牛)","(虎)","(兔)","(龍)","(蛇)","(馬)","(羊)","(猴)","(鸡)","(狗)","(猪)",}
    self.sonIndex = sonIndex --#region 第几个子对象
    local name = self.cfg[self.leftIndex1]["equip_arr"][self.leftIndex2]
    if self.ui.leftSonImg then
        GUI:removeFromParent(self.ui.leftSonImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["smallImg"..sonIndex],"leftSonImg",52,20,"res/public/1900000678.png")
    GUI:setAnchorPoint(self.ui.leftSonImg,0.5,0.5)
    GUI:removeAllChildren(self.ui.theItemBox)
    self.ui = GUI:ui_delegate(self._parent)
    GUI:Node_Create(self.ui.theItemBox,"itemImg",237,342)
    GUI:Node_Create(self.ui.theItemBox,"needImg1",90,193)
    GUI:Node_Create(self.ui.theItemBox,"needImg2",238,193)
    GUI:Node_Create(self.ui.theItemBox,"needImg3",386,193)
    if self.leftIndex1 == 2 then
        GUI:Text_Create(self.ui.theItemBox,"animalText3",238,134,16,"#FFFF00","当前合成次数："..(GameData.GetData("l_animalTime",false) or 0))
        GUI:Text_Create(self.ui.theItemBox,"animalText1",252,110,16,"#00FF00","传承生肖合成时随机赋予1-10星，并随机附加1-10点属性")
        GUI:Text_Create(self.ui.theItemBox,"animalText2",252,84,16,"#FFFF00","说明：每合成12次，必出1个10星")
        GUI:Button_Create(self.ui.theItemBox,"suitBtn",444,412,"res/custom/suitBtn2.png")
        GUI:setAnchorPoint(self.ui.animalText3,0.5,0.5)
        GUI:setAnchorPoint(self.ui.animalText1,0.5,0.5)
        GUI:setAnchorPoint(self.ui.animalText2,0.5,0.5)
        GUI:setAnchorPoint(self.ui.suitBtn,0.5,0.5)
        GUI:addOnClickEvent(self.ui.suitBtn,function ()
            local worldPos = GUI:getTouchEndPosition(self.ui.suitBtn)
            GUI:ShowWorldTips(suit[1]..allStarFun()..suit[2], worldPos, GUI:p(1, 1))
        end)
    end

    GUI:ItemShow_Create(self.ui.itemImg,"item_",0,0,{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME"
    , self.cfg[name]["equip_arr"][sonIndex]),look  =true,bgVisible =false})
    GUI:setAnchorPoint(self.ui.item_,0.5,0.5)
    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local equipName = value[1]
        if index == 1 then
            equipName = equipName..suffix[sonIndex]
        end
        local itemColor = 249
        if SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName) < 1000 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName))) >= value[2] then
                itemColor = 250
            end
        else
            if SL:GetMetaValue("ITEM_COUNT", equipName) >= value[2] then
                itemColor = 250
            end
        end
        local item = GUI:ItemShow_Create(self.ui["needImg"..index],"item_"..equipName,0,0,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName)
        ,count = value[2],bgVisible = false,look = true,color =itemColor})
        GUI:setAnchorPoint(item,0.5,0.5)
    end
    self:FlushBtnRedShow()
    self:FlushTwoBtnRedShow(self.leftIndex1)
    self:flushRed(self:TwoTagIsShowRed(self.leftIndex1,self.leftIndex2,sonIndex))
end



function compoundAnimalOBJ:flushRed(is_show_red)
    if self.upbtn_red_width then
        GUI:removeFromParent(self.upbtn_red_width)
        self.upbtn_red_width = nil
    end 
    if is_show_red then
        if self.upbtn_red_width == nil then
            self.upbtn_red_width = SL:CreateRedPoint(self.ui.upBtn)
        end
    end
end

function compoundAnimalOBJ:TwoTagIsShowRed(leftIndex1,leftIndex2,sonIndex)
    local suffix ={"(鼠)","(牛)","(虎)","(兔)","(龍)","(蛇)","(馬)","(羊)","(猴)","(鸡)","(狗)","(猪)",}
    local name = self.cfg[leftIndex1]["equip_arr"][leftIndex2]
    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local equipName = value[1]
        if index == 1 then
            equipName = equipName..suffix[sonIndex]
        end
        if SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName) < 1000 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName))) < value[2] then
                return false
            end
        else
            if SL:GetMetaValue("ITEM_COUNT", equipName) < value[2] then
                return false
            end
        end
    end
    return true
end

--#region 关闭前回调
function compoundAnimalOBJ:onClose(...)
    for k,v in pairs(self.red_width_list) do
        if v then
            GUI:removeFromParent(v)
        end
    end
    self.red_width_list = {}
    if self.upbtn_red_width then
        GUI:removeFromParent(self.upbtn_red_width)
        self.upbtn_red_width = nil
    end 
end

--#region 后端消息刷新ui
function compoundAnimalOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["获得"] = function()
            compoundAnimalOBJ:refreshMidBox(self.sonIndex)
        end,
    }
    functionTab[tab[1]]()
end

local function onClickNpc(npc_info)
    if npc_info.index == compoundAnimalOBJ.npcId then
        ViewMgr.open(compoundAnimalOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "compoundAnimalOBJ", onClickNpc)
return compoundAnimalOBJ