local masterLayerOBJ = {}

masterLayerOBJ.Name = "masterLayerOBJ"
masterLayerOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
masterLayerOBJ.cfg = SL:Require("GUILayout/config/masterLayerCfg",true)
masterLayerOBJ.npcId = 104

function masterLayerOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/masterLayerUI")

    self.ui = GUI:ui_delegate(parent)

    masterLayerOBJ:refreshLeftBox()
    masterLayerOBJ:refreshRightBox()
    masterLayerOBJ:refreshNeedItem()
    masterLayerOBJ:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("masterLayerOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("masterLayerOBJ")
    end)

    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "masterLayer", "upEvent","")
    end)
end

--#region 开始动画
function masterLayerOBJ:runAction()
    GUI:runAction(self.ui.leftBox,GUI:ActionSequence(GUI:DelayTime(0.01),GUI:CallFunc(function()
        Animation.followOpacity(self.ui.infoList1,255,0.3)
        GUI:runAction(self.ui.infoList1,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.3,140,370)))
        GUI:runAction(self.ui.effectBox,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.4,0,0)))
    end),GUI:DelayTime(0.3),GUI:CallFunc(function()
        Animation.followOpacity(self.ui.infoList2,255,0.3)
        Animation.followOpacity(self.ui.tipsImg,255,0.3)
        GUI:runAction(self.ui.infoList2,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.3,140,222)))
    end)
    ))
    GUI:Timeline_Window1(self.ui.rightBox)
    GUI:Timeline_Window4(self.ui.FrameLayout)
end
--#region 刷新左边box
function masterLayerOBJ:refreshLeftBox()
    local level = tonumber(GameData.GetData("l_masterLayer",false)) --#region 当前宗师境界
    if level == nil then
        level = 1
    elseif level ~= #self.cfg then
        level = level +1
    end
    removeOBJ(self.ui.effectLevel,self)
    GUI:Effect_Create(self.ui.effectBox,"effectLevel",32,462,0,self.cfg[level]["effectId"])
end
--#region 刷新右边box
function masterLayerOBJ:refreshRightBox()
    local tab = {"攻 魔 道 ：","杀怪爆率：","生命加成：",}
    local level = tonumber(GameData.GetData("l_masterLayer",false)) --#region 当前宗师境界
    if level == nil then level = 0 end;
    if level == #self.cfg then
        GUI:Text_setString(self.ui["text11"],tab[1]..self.cfg[level]["text1"].."-"..self.cfg[level]["text11"])
        GUI:Text_setString(self.ui["text12"],tab[2]..self.cfg[level]["text2"].."%")
        GUI:Text_setString(self.ui["text13"],tab[3]..self.cfg[level]["text3"].."%")
        GUI:Text_setString(self.ui["text21"],tab[1].."Max")
        GUI:Text_setString(self.ui["text22"],tab[2].."Max")
        GUI:Text_setString(self.ui["text23"],tab[3].."Max")
    elseif level == 0 then
        GUI:Text_setString(self.ui["text11"],tab[1].."0-0")
        GUI:Text_setString(self.ui["text12"],tab[2].."0%")
        GUI:Text_setString(self.ui["text13"],tab[3].."0%")
        GUI:Text_setString(self.ui["text21"],tab[1]..self.cfg[1]["text1"].."-"..self.cfg[1]["text11"])
        GUI:Text_setString(self.ui["text22"],tab[2]..self.cfg[1]["text2"].."%")
        GUI:Text_setString(self.ui["text23"],tab[3]..self.cfg[1]["text3"].."%")
    else
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."1"],tab[1]..self.cfg[level+i-1]["text1"].."-"..self.cfg[level+i-1]["text11"])
            GUI:Text_setString(self.ui["text"..i.."2"],tab[2]..self.cfg[level+i-1]["text2"].."%")
            GUI:Text_setString(self.ui["text"..i.."3"],tab[3]..self.cfg[level+i-1]["text3"].."%")
        end
    end

end
--#region 加载强化需要的物品框(无加号)
function masterLayerOBJ:refreshNeedItem(temp)
    local level = tonumber(GameData.GetData("l_masterLayer",false)) --#region 当前宗师境界
    GUI:removeAllChildren(self.ui.needBox)
    self.ui = GUI:ui_delegate(self._parent)
    if level == #masterLayerOBJ.cfg then --#region 最高等级
        GUI:setVisible(self.ui.upBtn,false)
         self:flushRed(false)
        return
    elseif level == nil then
        level = 0
    end
    local infoTab = masterLayerOBJ.cfg[level+1]
    local number = 0 --#region 物品显示
    local is_show_red = true
    --#region 升星物品显示
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
        GUI:setAnchorPoint(item,0.5,0.5)
        GUI:setContentSize(self.ui.needBox,60*(number)+(number-1)*(20),60)
    end
    self:flushRed(is_show_red)
end

function masterLayerOBJ:flushRed(is_show_red)
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

--#region 后端消息刷新ui
function masterLayerOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["进阶"] = function()
            -- if not self.ui.levelEffect then
            --     GUI:Effect_Create(self.ui.bg,"levelEffect",400,300,0,61528)
            --     GUI:Effect_setAutoRemoveOnFinish(self.ui.levelEffect)
            -- end
            self:refreshLeftBox()
            self:refreshRightBox()
            self:refreshNeedItem()
        end,
    }
    functionTab[tab[1]]()
end

--#region 关闭前回调
function masterLayerOBJ:onClose(...)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == masterLayerOBJ.npcId then
        ViewMgr.open(masterLayerOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, masterLayerOBJ.Name, onClickNpc)

return masterLayerOBJ