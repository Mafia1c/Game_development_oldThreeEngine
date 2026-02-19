local masterGodEquipOBJ = {}

masterGodEquipOBJ.Name = "masterGodEquipOBJ"
masterGodEquipOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
masterGodEquipOBJ.cfg = SL:Require("GUILayout/config/masterGodEquipCfg",true)
masterGodEquipOBJ.npcId = 115

function masterGodEquipOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/masterGodEquipUI")
    self.ui = GUI:ui_delegate(parent)

    self:refreshLeftBox()
    self:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("masterGodEquipOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("masterGodEquipOBJ")
    end)

    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        for index, value in ipairs(self.cfg) do
            local equipName = SL:GetMetaValue("EQUIPBYPOS", value["position"])
            if equipName ~= "" and self.cfg[equipName] then
                break
            elseif index == #self.cfg then
                return SL:ShowSystemTips("<font color=\'#ff0000\'>请先获得灵装装备！</font>")
            end
        end
        if self.nowIndex == nil then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先选取需要觉醒的灵装！</font>")
        end
        SendMsgCallFunByNpc(self.npcId, "masterGodEquip", "upEvent", self.nowIndex)
    end)
end
--#region 开始动画
function masterGodEquipOBJ:runAction()
    GUI:runAction(self.ui.leftBox,GUI:ActionSequence(GUI:DelayTime(0,01),GUI:CallFunc(function ()
        GUI:runAction(self.ui.box1,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.1,90,360)))
    end),GUI:DelayTime(0.08),GUI:CallFunc(function ()
        GUI:runAction(self.ui.box2,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.1,38,274)))
    end),GUI:DelayTime(0.08),GUI:CallFunc(function ()
        GUI:runAction(self.ui.box3,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.1,38,190)))
    end),GUI:DelayTime(0.08),GUI:CallFunc(function ()
        GUI:runAction(self.ui.box4,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.1,102,108)))
    end),GUI:DelayTime(0.08),GUI:CallFunc(function ()
        GUI:runAction(self.ui.box5,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.1,306,108)))
    end),GUI:DelayTime(0.08),GUI:CallFunc(function ()
        GUI:runAction(self.ui.box6,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.1,360,190)))
    end),GUI:DelayTime(0.08),GUI:CallFunc(function ()
        GUI:runAction(self.ui.box7,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.1,360,274)))
    end),GUI:DelayTime(0.08),GUI:CallFunc(function ()
        GUI:runAction(self.ui.box8,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.1,306,360)))
    end)
    ))
    GUI:runAction(self.ui.rightBox,GUI:ActionSequence(GUI:DelayTime(0.01),GUI:CallFunc(function()
        Animation.followOpacity(self.ui.infoBox1,255,0.3)
        GUI:runAction(self.ui.infoBox1,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.3,146,354)))
    end),GUI:DelayTime(0.2),GUI:CallFunc(function()
        Animation.followOpacity(self.ui.infoBox2,255,0.3)
        GUI:runAction(self.ui.infoBox2,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.3,148,200)))
    end)
    ))
    GUI:Timeline_Window1(self.ui.rightBox)
end
--#region 刷新左边box
function masterGodEquipOBJ:refreshLeftBox()
    self.nowIndex = nil
    for index, value in ipairs(self.cfg) do
        local equipName = SL:GetMetaValue("EQUIPBYPOS", value["position"])
        if equipName ~= "" and self.cfg[equipName] then
            local equip = GUI:EquipShow_Create(self.ui["box"..index],"equip"..value["position"],36,35,value["position"],false
            ,{bgVisible=false,look=false})
            GUI:EquipShow_setAutoUpdate(equip)
            GUI:setAnchorPoint(equip,0.5,0.5)
            local layout = GUI:Layout_Create(equip, "sonLayout"..index, 30, 30, 60, 60, true)
            GUI:setAnchorPoint(layout, 0.5, 0.5)
            GUI:setTouchEnabled(layout, true)
            GUI:setSwallowTouches(layout, false)
            GUI:addOnClickEvent(layout,function ()
                self.nowIndex = index
                self:clickRefresh()
            end)
        end
    end
end
function masterGodEquipOBJ:clickRefresh() --#region 点击刷新信息
    removeOBJ(self.ui.selectBox,self)
    GUI:Image_Create(self.ui["equip"..self.cfg[self.nowIndex]["position"]],"selectBox",1,1,"res/public/1900000678_1.png")
    GUI:setContentSize(self.ui.selectBox,62,62)
    Animation.breathingEffect(self.ui.selectBox,0.6,0.6)
    removeOBJ(self.ui.equipNow,self)
    local equipName = SL:GetMetaValue("EQUIPBYPOS", self.cfg[self.nowIndex]["position"])
    local equip = GUI:EquipShow_Create(self.ui.leftBox,"equipNow",238,291,self.cfg[self.nowIndex]["position"],false
    ,{bgVisible=false,look=true})
    GUI:EquipShow_setAutoUpdate(equip)
    GUI:setAnchorPoint(equip,0.5,0.5)

    local color1 = self.cfg[equipName]["color_arr"][1]
    local color2 = self.cfg[equipName]["color_arr"][2]
    removeOBJ(self.ui.Rtext1,self)
    removeOBJ(self.ui.Rtext2,self)
    GUI:RichTextFCOLOR_Create(self.ui.infoBox2,"Rtext1",100,52,"选择灵装：<"..equipName.."/FCOLOR="..color1..">",204,16,"#FFFFFF")
    GUI:RichTextFCOLOR_Create(self.ui.infoBox2,"Rtext2",100,30,"进阶灵装：<"..(self.cfg[equipName]["next"] or "已满阶").."/FCOLOR="..color2..">",204,16,"#FFFFFF")
    GUI:setAnchorPoint(self.ui.Rtext1,0.5,0.5)
    GUI:setAnchorPoint(self.ui.Rtext2,0.5,0.5)
    self:refreshNeedItem()
end
--#region 加载强化需要的物品框(无加号)
function masterGodEquipOBJ:refreshNeedItem()
    local equipName = SL:GetMetaValue("EQUIPBYPOS", self.cfg[self.nowIndex]["position"])
    GUI:removeAllChildren(self.ui.needBox)
    self.ui = GUI:ui_delegate(self._parent)
    if not self.cfg[equipName]["next"] then --#region 最高等级
        GUI:setVisible(self.ui.upBtn,false)
        return
    end
    GUI:setVisible(self.ui.upBtn,true)
    local infoTab = self.cfg[equipName]
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
        GUI:setAnchorPoint(item,0.5,0.5)
        GUI:setContentSize(self.ui.needBox,60*(number)+(number-1)*(20),60)
    end
end


--#region 后端消息刷新ui
function masterGodEquipOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["觉醒"] = function ()
            self:clickRefresh()
        end,
    }
    functionTab[tab[1]]()
end

--#region 关闭前回调
function masterGodEquipOBJ:onClose(...)

end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == masterGodEquipOBJ.npcId then
        ViewMgr.open(masterGodEquipOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, masterGodEquipOBJ.Name, onClickNpc)

return masterGodEquipOBJ