local magicRingOBJ = {}

magicRingOBJ.Name = "magicRingOBJ"
magicRingOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
magicRingOBJ.cfg = SL:Require("GUILayout/config/magicRingCfg",true)
magicRingOBJ.cfg2 = {
    [1] = { ["give_arr"]={"龙神石",1},["need_config"]={{"龙之血",1},{"龙之心",1},{"金刚石",20000},}, },
    [2] = { ["give_arr"]={"龙神石",10},["need_config"]={{"龙之血",10},{"龙之心",10},{"金刚石",200000},}, },
    [3] = { ["give_arr"]={"龙神石",100},["need_config"]={{"龙之血",100},{"龙之心",100},{"金刚石",2000000},}, },
}
magicRingOBJ.npcId = 288

function magicRingOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/magicRingUI")
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshLeftNode()
    self:refreshRightNode1(1)
    self:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("magicRingOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("magicRingOBJ")
    end)
    --给服务端发消息
    GUI:addOnClickEvent(self.ui.changeBtn1,function ()
        self:refreshRightNode2()
    end)
    GUI:addOnClickEvent(self.ui.changeBtn2,function ()
        self:refreshRightNode1(self.leftIndex)
    end)
    GUI:addOnClickEvent(self.ui.upBtn1, function()
        SendMsgCallFunByNpc(self.npcId, "magicRing", "upEvent",self.leftIndex)
    end)

end
function magicRingOBJ:runAction() --#region 动画

end

function magicRingOBJ:refreshLeftNode() --#region 加载左列表
    for index, value in ipairs(self.cfg) do
        GUI:ItemShow_updateItem(self.ui["leftEquip"..index],{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", value["name"]),look=false,bgVisible=true,})
        GUI:Text_setString(self.ui["leftName"..index], value["name"])
        GUI:addOnClickEvent(self.ui["leftLayout"..index],function ()
            self:refreshRightNode1(index)
        end)
    end
    GUI:UserUILayout(self.ui.leftNode, {dir=1,addDir=2,interval=0.5,gap = {y=46},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:RichTextFCOLOR_Create(self.ui.FrameBG,"Rtext",200,86,"上古魔戒拥有<【远古魔力】/FCOLOR=250>\\\\魔戒散落在魔龙城<各个地图 BOSS/FCOLOR=250>几率掉落"
    ,400,16,"#ffffff",1)
    GUI:setAnchorPoint(self.ui.Rtext,0,1)
end

function magicRingOBJ:refreshRightNode1(leftIndex) --#region 加载右锻造魔戒node
    GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/npc/69mj/bg1.png")
    self.leftIndex = leftIndex
    self.rightPanel = 1
    for i = 1, 2 do
        GUI:setVisible(self.ui["rightNode"..i],self.rightPanel== i or false)
        GUI:setVisible(self.ui["changeBtn"..i],self.rightPanel== i or false)
    end
    removeOBJ(self.ui.leftTag,self)
    local leftTag = GUI:Image_Create(self.ui["leftLayout"..self.leftIndex],"leftTag",0,0,"res/public/1900000678_1.png")
    -- GUI:setAnchorPoint(leftTag,0.5,0.5) 
    GUI:Image_setScale9Slice(leftTag,8,8,28,28)
    GUI:setContentSize(leftTag, 60, 60)
    Animation.breathingEffect(leftTag,0.6,0.6)
    local is_show_red = true
    for index, value in ipairs(self.cfg[self.leftIndex]["need_config"]) do
        local itemColor = 250
        if SL:GetMetaValue("ITEM_COUNT", value[1]) < 1 then
            is_show_red =false
            itemColor = 249
        end
        ItemShow_updateItem(self.ui["item1_name"..index],{showCount=true,index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]),look=true,bgVisible=false,count=value[2],color =itemColor})
    end
    GUI:ItemShow_updateItem(self.ui["equipNow1"],{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[self.leftIndex]["name"]),look=true,bgVisible=false,})
    GUI:Text_setString(self.ui.nowName1,self.cfg[self.leftIndex]["name"])
    GUI:Text_setString(self.ui.oddText12,self.cfg[self.leftIndex]["odd"].."%")

    GUI:removeAllChildren(self.ui.needBox1)
    self.ui = GUI:ui_delegate(self._parent)
    local infoTab = self.cfg[self.leftIndex]
    local number = 0 --#region 物品显示
    --#region 升星物品显示
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        local itemColor = 0
        if SL:GetMetaValue("ITEM_COUNT", k) < v then
            itemColor = 249
            is_show_red = false
        else itemColor = 250 end
        number = number + 1
        GUI:Image_Create(self.ui.needBox1,"itemBox"..number,60*(number-1)+(number-1)*(20),0,"res/custom/itemBox.png")
        local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
            look = true,color =itemColor})
        GUI:setAnchorPoint(item,0.5,0.5)
        GUI:setContentSize(self.ui.needBox1,60*(number)+(number-1)*(20),60)
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do
        local itemColor = 0
        if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", k))) < v then
            itemColor = 249
             is_show_red = false
        else itemColor = 250 end
        number = number + 1
        GUI:Image_Create(self.ui.needBox1,"itemBox"..number,60*(number-1)+(number-1)*(20),0,"res/custom/itemBox.png")
        local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
            look = true,color =itemColor})
        GUI:setAnchorPoint(item,0.5,0.5)
        GUI:setContentSize(self.ui.needBox1,60*(number)+(number-1)*(20),60)
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do
        local itemColor = 0
        if tonumber(SL:GetMetaValue("MONEY", SL:GetMetaValue("ITEM_INDEX_BY_NAME", k))) < v then
            itemColor = 249
             is_show_red = false
        else itemColor = 250 end
        number = number + 1
        GUI:Image_Create(self.ui.needBox1,"itemBox"..number,60*(number-1)+(number-1)*(20),0,"res/custom/itemBox.png")

        local item = GUI:ItemShow_Create(self.ui["itemBox"..number],"item_"..k,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = false,
            look = true,color =itemColor})
        GUI:setAnchorPoint(item,0.5,0.5)
        GUI:setContentSize(self.ui.needBox1,60*(number)+(number-1)*(20),60)
    end
    self:flushRed(is_show_red)
    GUI:UserUILayout(self.ui.needBox1, {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)    end})
end

function magicRingOBJ:refreshRightNode2() --#region 加载合成龙神石node
    GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/npc/69mj/bg3.png")
    self.rightPanel = 2
    for i = 1, 2 do
        GUI:setVisible(self.ui["rightNode"..i],self.rightPanel== i or false)
        GUI:setVisible(self.ui["changeBtn"..i],self.rightPanel== i or false)
    end
    for index, value in ipairs(self.cfg2) do
        for k, v in ipairs(value["need_config"]) do
            local color = 250
            if SL:GetMetaValue("ITEM_INDEX_BY_NAME", v[1]) < 10000 then
                if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", v[1]))) < v[2] then color = 249 end
            else
                if tonumber(SL:GetMetaValue("ITEM_COUNT", v[1])) < v[2] then color = 249 end
            end
            ItemShow_updateItem(self.ui["needItem2_" .. index .. k],
                {showCount=true, index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v[1]), look = true, bgVisible = true, color = color, count =v[2]})
        end
        ItemShow_updateItem(self.ui["resultItem2"..index],
                {showCount=true, index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", value["give_arr"][1]), look = true, bgVisible = true,count =value["give_arr"][2],color=251})
        GUI:addOnClickEvent(self.ui["upBtn2"..index], function ()
            self.sonIndex = index
            SendMsgCallFunByNpc(self.npcId, "magicRing", "compound",index)
        end)
        GUI:UserUILayout(self.ui["needNode2"..index], {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)  
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
end

--#region 后端消息刷新ui
function magicRingOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足11"] = function()
            Animation.bounceEffect(self.ui["item1_"..tab[2]], 5,20) --#region 装备 锻造魔戒
        end,
        ["不足12"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20) --#region 物品 锻造魔戒
        end,
        ["不足21"] = function ()
            Animation.bounceEffect(self.ui["needItem2_"..(self.sonIndex)..tab[2]], 5,20) --#region 合成龙神石
        end,
        ["失败"] = function()
            self:refreshRightNode1(self.leftIndex)
        end,
        ["锻造"] = function ()
            self:refreshRightNode1(self.leftIndex)
        end,
        ["龙神石"] = function ()
            magicRingOBJ:refreshRightNode2()
        end,
    }
    functionTab[tab[1]]()
end

function magicRingOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.upBtn1)
        end
    end
end

--#region 关闭前回调
function magicRingOBJ:onClose(...)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == magicRingOBJ.npcId then
        ViewMgr.open(magicRingOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, magicRingOBJ.Name, onClickNpc)

return magicRingOBJ