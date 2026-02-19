local fourCellOBJ = {}
fourCellOBJ.Name = "fourCellOBJ"
fourCellOBJ.cfg = SL:Require("GUILayout/config/fourCellCfg",true)
fourCellOBJ.npcId = 101

function fourCellOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    self.red_width_list = {}
    self.red_width_list.one_list = {}
    self.red_width_list.two_list = {}
    --加载UI
    GUI:LoadExport(parent, "npc/fourCellUI")
    self.ui = GUI:ui_delegate(parent)

    self:refreshLeftList()
    self:leftBtnEvent1(1)
    -- self:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("fourCellOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("fourCellOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn1,function ()
        SendMsgCallFunByNpc(self.npcId, "fourCell", "upEvent1",self.leftIndex1.."#"..self.sonIndex)
    end)
    GUI:addOnClickEvent(self.ui.upBtn2,function ()
        SendMsgCallFunByNpc(self.npcId, "fourCell", "upEvent2",self.leftIndex1.."#"..self.sonIndex)
    end)
end

--#region 刷新左侧list
function fourCellOBJ:refreshLeftList()
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
    GUI:runAction(self.ui.leftList1, GUI:ActionSequence(GUI:DelayTime(0.1), GUI:CallFunc(function()
        local navigation = tonumber(GameData.GetData("U_navigation_task_step", false))
        if navigation == 5 then
            local function callback()
                self:leftBtnEvent1(3)
            end
            local data = {}
            data.dir           = 8                -- 方向（1~8）从左按瞬时针
            data.guideWidget   = self.ui["leftBtn3"]        -- 当前节点
            data.guideParent   = self._parent          -- 父窗口
            data.guideDesc     = "点击完成!"           -- 文本描述
            data.clickCB       = callback         -- 回调
            data.autoExcute    = 86400            -- 自动执行秒数
            data.isForce       = true             -- 强制引导
            data.hideMask      = true             -- 隐藏蒙版 [仅不强制引导时有效]
            SL:StartGuide(data)
        end
    end)))
end

--#region 左侧一级按钮点击事件
function fourCellOBJ:leftBtnEvent1(leftIndex1)
    for k,v in pairs(self.red_width_list.two_list) do
        if v then
            removeOBJ(v,self)
        end
    end
    self.red_width_list.two_list = {}
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

    local list = GUI:ListView_Create(img,"leftListNow",0,0,106,40*#self.cfg[leftIndex1]["equip_arr"],1)
    GUI:ListView_setBounceEnabled(list,true)
    GUI:setAnchorPoint(list,0,1)
    local time = 0
    for i = 1, #self.cfg[leftIndex1]["equip_arr"] do
        local img = GUI:Image_Create(list,"smallImg"..i,0,0,"res/custom/sonBox.png")
        local name = GUI:Text_Create(img,"name"..i,56,22,16,"#FFFFFF",self.cfg[leftIndex1]["equip_arr"][i])
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
function fourCellOBJ:refreshMidBox(sonIndex)
    self.sonIndex = sonIndex --#region 第几个子对象
    local name = self.cfg[self.leftIndex1]["equip_arr"][sonIndex]
    local position = self.cfg[self.leftIndex1]["position"]
    if self.ui.leftSonImg then
        GUI:removeFromParent(self.ui.leftSonImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["smallImg"..sonIndex],"leftSonImg",52,20,"res/public/1900000678.png")
    GUI:setAnchorPoint(self.ui.leftSonImg,0.5,0.5)
    GUI:removeAllChildren(self.ui.theItemBox)
    self.ui = GUI:ui_delegate(self._parent)
    GUI:Node_Create(self.ui.theItemBox,"itemImg",238,342)
    GUI:Node_Create(self.ui.theItemBox,"needImg1",90,193)
    GUI:Node_Create(self.ui.theItemBox,"needImg2",238,193)
    GUI:Node_Create(self.ui.theItemBox,"needImg3",386,193)

    GUI:ItemShow_Create(self.ui.itemImg,"item_",0,0,{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME"
    , name),look  =true,bgVisible =false})
    GUI:setAnchorPoint(self.ui.item_,0.5,0.5)
    local number = 0
    local is_show_red = true
    local is_show_red2 = true
    for index, value in ipairs(self.cfg[name]["need_config"]) do
        local equipName = value[1]
        local itemColor = 249
        if SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName) < 1000 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName))) >= value[2] then
                itemColor = 250
            else
                is_show_red = false
                is_show_red2 = false
            end
        else
            if index == 1 and (SL:GetMetaValue("ITEM_COUNT", equipName) >= value[2] or (SL:GetMetaValue("EQUIPBYPOS", position) == equipName and SL:GetMetaValue("ITEM_COUNT", equipName) >= value[2]-1)) then
                itemColor = 250
                is_show_red2 = self:CheckPutOnRedShow(position,equipName,value[2])
                is_show_red = SL:GetMetaValue("ITEM_COUNT", equipName) >= value[2]
            elseif SL:GetMetaValue("ITEM_COUNT", equipName) >= value[2] then
                itemColor = 250
            else
                is_show_red = false
                is_show_red2 = false
            end
        end
        local item = GUI:ItemShow_Create(self.ui["needImg"..index],"item_"..equipName,0,0,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName)
        ,count = value[2],bgVisible = false,look = true,color =itemColor})
        ItemShow_updateItem(item,{showCount=true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName)
        ,count = value[2],bgVisible = false,look = true,color =itemColor})
        GUI:setAnchorPoint(item,0.5,0.5)
        number = number+1
    end
    self:flushBtnRed(is_show_red,is_show_red2)
    self:FlushBtnRedShow()
    self:flushTwoBtnShow(self.leftIndex1)
    for i = number+1, 3 do
        GUI:Image_Create(self.ui["needImg"..i],"lockImg"..i,-30,-30,"res/custom/lock.png")
    end
end

function fourCellOBJ:CheckPutOnRedShow(position,equipName,value)
    if SL:GetMetaValue("EQUIPBYPOS", position) == equipName and SL:GetMetaValue("ITEM_COUNT", equipName) >= value -1 then
        return true
    end
    return false
end

function fourCellOBJ:FlushBtnRedShow()
    for i,v in ipairs(self.cfg) do
        if self:GetOneRedShow(i) then
            if self.red_width_list.one_list["leftBtn"..i] == nil then
                self.red_width_list.one_list["leftBtn"..i] = SL:CreateRedPoint(self.ui["leftBtn"..i] ,{x=102,y=10})
            end
        else
            if self.red_width_list.one_list["leftBtn"..i]  then
                GUI:removeFromParent(self.red_width_list.one_list["leftBtn"..i] )
                self.red_width_list.one_list["leftBtn"..i]  = nil
            end
        end
    end
end
function fourCellOBJ:GetOneRedShow(leftIndex1)
    for i = 1, #self.cfg[leftIndex1]["equip_arr"] do
        if self:GetSigleRedShow(leftIndex1,i) then
            return true
        end
    end
    return false
end
function fourCellOBJ:flushTwoBtnShow(leftIndex1)
    --二级红点
    for i = 1, #self.cfg[leftIndex1]["equip_arr"] do
        if self:GetSigleRedShow(leftIndex1,i) then
            if self.red_width_list.two_list[i] == nil then
                self.red_width_list.two_list[i] = SL:CreateRedPoint(self.ui["smallImg"..i],{x=95,y=13})
            end
        else
            if self.red_width_list.two_list[i] then
                GUI:removeFromParent(self.red_width_list.two_list[i])
                self.red_width_list.two_list[i] = nil
            end 
        end
    end
end
function fourCellOBJ:GetSigleRedShow(leftIndex1,sonIndex)
    local is_show_red = true
    local position = self.cfg[leftIndex1]["position"]
    local name = self.cfg[leftIndex1]["equip_arr"][sonIndex]
    for index, value in ipairs(self.cfg[name]["need_config"]) do
        if SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]) < 1000 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]))) < value[2] then
                is_show_red = false
            end
        else
            if index == 1 and (SL:GetMetaValue("ITEM_COUNT", value[1]) >= value[2]
                or (SL:GetMetaValue("EQUIPBYPOS", position) == value[1] and SL:GetMetaValue("ITEM_COUNT", value[1]) >= value[2]-1)) then
            elseif SL:GetMetaValue("ITEM_COUNT", value[1]) >= value[2] then

            else
                is_show_red = false
            end
        end
    end
    return is_show_red
end

function fourCellOBJ:flushBtnRed(is_show_red,is_show_red2)
    if is_show_red then
        if self.upbtn_red_width == nil then
            self.upbtn_red_width = SL:CreateRedPoint(self.ui.upBtn1)
        end
    else
        for _, son in pairs(GUI:getChildren(self.ui.upBtn1)) do
            if son and self.upbtn_red_width then
                removeOBJ(self.upbtn_red_width,self)
            end
        end
        self.upbtn_red_width = nil
    end
    if is_show_red2 then
        if self.upbtn2_red_width == nil then
            self.upbtn2_red_width = SL:CreateRedPoint(self.ui.upBtn2)
        end
    else
        for _, son in pairs(GUI:getChildren(self.ui.upBtn2)) do
            if son and self.upbtn2_red_width then
                removeOBJ(self.upbtn2_red_width,self)
            end
        end
        self.upbtn2_red_width = nil
    end
end

--#region 关闭前回调
function fourCellOBJ:onClose(...)

end

--#region 后端消息刷新ui
function fourCellOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["获得"] = function()
            for k,v in pairs(self.red_width_list.two_list) do
                if v then
                    removeOBJ(v,self)

                end
            end
            self.red_width_list.two_list = {}
            fourCellOBJ:refreshMidBox(self.sonIndex)
        end,
    }
    functionTab[tab[1]]()
end

local function onClickNpc(npc_info) 
    if npc_info.index == fourCellOBJ.npcId then
        ViewMgr.open(fourCellOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "fourCellOBJ", onClickNpc)
return fourCellOBJ