local flyUpOBJ = {}

flyUpOBJ.Name = "flyUpOBJ"
flyUpOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
flyUpOBJ.cfg = {
    [1] = { ["text1"]="10",["text2"]="25",["needMaterials_map"]={["十转凭证"]=999,},["needCurrency_map"]={["灵符"]=10000,}, },
    [2] = { ["text1"]="20",["text2"]="30",["needMaterials_map"]={["十转凭证"]=999,},["needCurrency_map"]={["灵符"]=50000,}, },
    [3] = { ["text1"]="30",["text2"]="40",["needMaterials_map"]={["十转凭证"]=999,},["needCurrency_map"]={["灵符"]=100000,}, },
}
flyUpOBJ.npcId = 293

function flyUpOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/flyUpUI")
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshRightBox()
    self:refreshNeedItem()
    self:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("flyUpOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("flyUpOBJ")
    end)

    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "flyUp", "upEvent","")
    end)
end

--#region 开始动画
function flyUpOBJ:runAction()
    GUI:runAction(self.ui.leftBox,GUI:ActionSequence(GUI:DelayTime(0.01),GUI:CallFunc(function()
        GUI:runAction(self.ui.effectBox,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.4,0,0)))
        GUI:UserUILayout(self.ui.infoList1, {dir=1,addDir=2,interval=0.5,gap = {y=4},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end),GUI:DelayTime(0.2),GUI:CallFunc(function()
        GUI:UserUILayout(self.ui.infoList2, {dir=1,addDir=2,interval=0.5,gap = {y=4},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
        Animation.followOpacity(self.ui.upBtn,255,0.5)
        Animation.followOpacity(self.ui.tipsText,255,0.5)
    end)
    ))
    -- GUI:Timeline_Window1(self.ui.rightBox)
end

--#region 刷新右边box
function flyUpOBJ:refreshRightBox()
    local zsLevel = SL:GetMetaValue("RELEVEL")
    GUI:Text_setString(self.ui.tipsText,"轮回飞升：需要人物等级达到79级，当前转生："..zsLevel.."转！")
    local tab = {"生命加成 ：","攻击倍数：",}
    local level = tonumber(GameData.GetData("l_flyUp",false)) --#region 当前宗师境界
    if level == nil then level = 0 end;
    if level == #self.cfg then
        GUI:Text_setString(self.ui["text11"],tab[1]..self.cfg[level]["text1"].."%")
        GUI:Text_setString(self.ui["text12"],tab[2]..self.cfg[level]["text2"].."%")
        GUI:Text_setString(self.ui["text21"],tab[1].."Max")
        GUI:Text_setString(self.ui["text22"],tab[2].."Max")
    elseif level == 0 then
        GUI:Text_setString(self.ui["text11"],tab[1].."0%")
        GUI:Text_setString(self.ui["text12"],tab[2].."0%")
        GUI:Text_setString(self.ui["text21"],tab[1]..self.cfg[1]["text1"].."%")
        GUI:Text_setString(self.ui["text22"],tab[2]..self.cfg[1]["text1"].."%")
    else
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text1"..i],tab[i]..self.cfg[level]["text"..i].."%")
            GUI:Text_setString(self.ui["text2"..i],tab[i]..self.cfg[level+1]["text"..i].."%")
        end
    end
end
--#region 加载强化需要的物品框(无加号)
function flyUpOBJ:refreshNeedItem()
    local level = tonumber(GameData.GetData("l_flyUp",false)) --#region 当前宗师境界
    GUI:removeAllChildren(self.ui.needBox)
    self.ui = GUI:ui_delegate(self._parent)
    if level == #flyUpOBJ.cfg then --#region 最高等级
        GUI:setVisible(self.ui.upBtn,false)
        self:flushRed(false)
        return
    elseif level == nil then
        level = 0
    end
    local infoTab = flyUpOBJ.cfg[level+1]
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
    GUI:UserUILayout(self.ui.needBox, {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists) end})
    SL:Print(SL:GetMetaValue("RELEVEL"))
    if SL:GetMetaValue("LEVEL") < 79 or SL:GetMetaValue("RELEVEL") < 15 then
        is_show_red = false
    end
    self:flushRed(is_show_red)
end


--#region 后端消息刷新ui
function flyUpOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["提升"] = function()
            -- if not self.ui.levelEffect then
            --     GUI:Effect_Create(self.ui.bg,"levelEffect",400,300,0,61528)
            --     GUI:Effect_setAutoRemoveOnFinish(self.ui.levelEffect)
            -- end
            self:refreshRightBox()
            self:refreshNeedItem()
            local zsLevel = SL:GetMetaValue("RELEVEL")
            GUI:Text_setString(self.ui.tipsText,"轮回飞升：需要人物等级达到79级，当前转生：".. zsLevel+1 .."转！")
        end,
    }
    functionTab[tab[1]]()
end

function flyUpOBJ:flushRed(is_show_red)
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
function flyUpOBJ:onClose(...)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == flyUpOBJ.npcId then
        ViewMgr.open(flyUpOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, flyUpOBJ.Name, onClickNpc)

return flyUpOBJ