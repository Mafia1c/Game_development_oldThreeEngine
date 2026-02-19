local compoundGoodOBJ = {}
compoundGoodOBJ.Name = "compoundGoodOBJ"
compoundGoodOBJ.cfg = SL:Require("GUILayout/config/compoundGoodCfg",true)
compoundGoodOBJ.npcId = 117

function compoundGoodOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/compoundGoodUI")
    self.ui = GUI:ui_delegate(parent)

    self:refreshLeftList()
    self:leftBtnEvent1(1)
    -- self:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("compoundGoodOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("compoundGoodOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn,function ()
        SendMsgCallFunByNpc(self.npcId, "compoundGood", "upEvent",self.leftIndex1.."#"..self.sonIndex)
    end)
end

--#region 刷新左侧list
function compoundGoodOBJ:refreshLeftList()
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

--#region 左侧一级按钮点击事件
function compoundGoodOBJ:leftBtnEvent1(leftIndex1)
    self.leftIndex1 = leftIndex1 --#region 1级列表index
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
    local img = GUI:Image_Create(self.ui.leftList2, "left_btn1", 0, 0, "res/custom/yeqian1.png")
    GUI:Text_Create(img,"left_text1",58,18,18,"#F8E6C6",self.cfg[leftIndex1]["type"])
    GUI:setAnchorPoint(self.ui.left_text1,0.5,0.5)
    GUI:setPositionY(img, GUI:getContentSize(self.ui.leftList2).height - 36 * (1))
    GUI:Image_Create(img,"leftTag2",16,20,"res/public/jiantou.png")
    GUI:setRotation(self.ui.leftTag2,90)
    GUI:setAnchorPoint(self.ui.leftTag2,0.5,0.5)

    local list = GUI:ListView_Create(img,"leftListNow",0,0,106,40*#self.cfg[leftIndex1]["item_arr"],1)
    GUI:ListView_setBounceEnabled(list,true)
    GUI:setAnchorPoint(list,0,1)
    local time = 0
    for i = 1, #self.cfg[leftIndex1]["item_arr"] do
        local img = GUI:Image_Create(list,"smallImg"..i,0,0,"res/custom/sonBox.png")
        local name = GUI:Text_Create(img,"name"..i,56,22,16,"#FFFFFF",self.cfg[leftIndex1]["item_arr"][i])
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

--#region 子对象刷新midBox
function compoundGoodOBJ:refreshMidBox(sonIndex)
    self.sonIndex = sonIndex --#region 第几个子对象
    local name = self.cfg[self.leftIndex1]["item_arr"][sonIndex]
    if self.ui.leftSonImg then
        GUI:removeFromParent(self.ui.leftSonImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["smallImg"..sonIndex],"leftSonImg",52,20,"res/public/1900000678.png")
    GUI:setAnchorPoint(self.ui.leftSonImg,0.5,0.5)
    GUI:removeAllChildren(self.ui.theItemBox)
    self.ui = GUI:ui_delegate(self._parent)
    GUI:Node_Create(self.ui.theItemBox,"itemImg",245,280)
    GUI:Node_Create(self.ui.theItemBox,"needImg1",118,168)
    GUI:Node_Create(self.ui.theItemBox,"needImg2",372,168)
    local is_show_red = true
    GUI:ItemShow_Create(self.ui.itemImg,"item_",0,0,{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME"
    , name),look  =true,bgVisible =false})
    GUI:setAnchorPoint(self.ui.item_,0.5,0.5)
    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local equipName = value[1]
        local itemColor = 249
        if SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName) < 1000 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName))) >= value[2] then
                itemColor = 250
            else
                is_show_red = false
            end
        else
            if SL:GetMetaValue("ITEM_COUNT", equipName) >= value[2] then
                itemColor = 250
            else
                is_show_red = false
            end
        end
        local item = GUI:ItemShow_Create(self.ui["needImg"..index],"item_"..equipName,0,0,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName)
        ,count = value[2],bgVisible = false,look = true,color =itemColor})
        GUI:setAnchorPoint(item,0.5,0.5)
    end
    GUI:Text_setString(self.ui.oddText2, self.cfg[name]["odd"].."%")
    GUI:Text_setString(self.ui.itemText2, name)
    self:flushRed(is_show_red)
end

function compoundGoodOBJ:flushRed(is_show_red)
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

--#region 关闭前回调
function compoundGoodOBJ:onClose(...)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

--#region 后端消息刷新ui
function compoundGoodOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["获得"] = function()
            self:refreshMidBox(self.sonIndex)
        end,
    }
    functionTab[tab[1]]()
end

local function onClickNpc(npc_info)
    if npc_info.index == compoundGoodOBJ.npcId then
        ViewMgr.open(compoundGoodOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "compoundGoodOBJ", onClickNpc)
return compoundGoodOBJ