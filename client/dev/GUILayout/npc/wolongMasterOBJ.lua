local wolongMasterOBJ = {}

wolongMasterOBJ.Name = "wolongMasterOBJ"
wolongMasterOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
wolongMasterOBJ.cfg = SL:Require("GUILayout/config/wolongMasterCfg",true)
wolongMasterOBJ.npcId = 326

function wolongMasterOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/wolongMasterUI")
    self.ui = GUI:ui_delegate(parent)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("wolongMasterOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("wolongMasterOBJ")
    end)
    --给服务端发消息
    GUI:addOnClickEvent(self.ui.goBtn2, function()
        SendMsgCallFunByNpc(self.npcId, "wolongMaster", "goMap2", "")
    end)
    GUI:addOnClickEvent(self.ui.activeBtn3, function()
        SendMsgCallFunByNpc(self.npcId, "wolongMaster", "active3", "")
    end)

    self:refreshLeftList()
    self:refreshMidBox1()
end
function wolongMasterOBJ:refreshLeftList() --#region 加载左列表
    GUI:removeAllChildren(self.ui.leftList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
        local btn = GUI:Button_Create(self.ui.leftList,"leftBtn"..index,0,0,"res/custom/dayeqian1.png")
        GUI:Button_setTitleText(btn,value["type"])
        GUI:Button_setTitleFontSize(btn,18)
        GUI:Button_setTitleColor(btn,"#F8E6C6")
        GUI:Button_loadTexturePressed(btn, "res/custom/dayeqian2.png")
        GUI:addOnClickEvent(btn,function ()
            local tab = {
                function () self:refreshMidBox1() end,
                function () self:refreshMidBox2() end,
                function () self:refreshMidBox3() end,}
            tab[index]()
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

function wolongMasterOBJ:refreshMidBox1() --#region 刷新中间box守将
    self.leftIndex =1
    GUI:Image_loadTexture(self.ui.bg_Image,"res/custom/npc/78wlzz/bg1.png")
    removeOBJ(self.ui.leftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..self.leftIndex],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],(index == self.leftIndex and "res/custom/dayeqian2.png") or "res/custom/dayeqian1.png")
    end
    for i = 1, 3 do
        GUI:setVisible(self.ui["rightBox"..i],i == self.leftIndex)
    end
    GUI:removeAllChildren(self.ui.boxList1)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg[1]["info_arr"]) do
        local img = GUI:Image_Create(self.ui.boxList1,"box1"..index,0,0,"res/custom/npc/78wlzz/rq"..index..".png")
        local item1 = GUI:ItemShow_Create(img,"item_"..index.."1",250,42,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[value]["info_arr"][1]),look=true,bgVisible=true,count=self.cfg[value]["info_arr"][2],color=251,})
        local item2 = GUI:ItemShow_Create(img,"item_"..index.."2",384,42,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[value]["info_arr"][3]),look=true,bgVisible=true,count=self.cfg[value]["info_arr"][4],color=251,})
        GUI:setAnchorPoint(item1,0.5,0.5)
        GUI:setAnchorPoint(item2,0.5,0.5)
        local btn = GUI:Button_Create(img,"goMapBtn1"..index,524,44,"res/custom/yeqian1.png")
        GUI:Button_setTitleText(btn,"前往挑战")
        GUI:Button_setTitleFontSize(btn,16)
        GUI:Button_setTitleColor(btn,"#F8E6C6")
        GUI:Button_loadTexturePressed(btn, "res/custom/dayeqian2.png")
        GUI:setAnchorPoint(btn,0.5,0.5)
        GUI:addOnClickEvent(btn,function ()
            SendMsgCallFunByNpc(self.npcId, "wolongMaster", "goMap1", index)
        end)
        GUI:setVisible(img,false)
        time = time +0.05
        GUI:runAction(img,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(img,true)
            GUI:setPositionX(img,612)
            GUI:runAction(img,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(img))))
        end)))
    end
end

function wolongMasterOBJ:refreshMidBox2() --#region 刷新中间box庄主
    self.leftIndex =2
    GUI:Image_loadTexture(self.ui.bg_Image,"res/custom/npc/78wlzz/bg2.png")
    removeOBJ(self.ui.leftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..self.leftIndex],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],(index == self.leftIndex and "res/custom/dayeqian2.png") or "res/custom/dayeqian1.png")
    end
    local x_space = SL:GetMetaValue("WINPLAYMODE") and 30 or 1
    for i = 1, 3 do
        GUI:setVisible(self.ui["rightBox"..i],i == self.leftIndex)
    end
    GUI:UserUILayout(self.ui.itemNode2, {dir=2,addDir=2,interval=0.5,gap = {x=x_space},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    removeOBJ(self.ui.Rtext2,self)
    GUI:RichTextFCOLOR_Create(self.ui.rightBox2,"Rtext2",10,104,"<挑战卧龙庄主说明：/FCOLOR=251>\\"
    .."收集五种<【元素魔石×1】/FCOLOR=251>进行召唤挑战<【卧龙庄主】/FCOLOR=249>\\击败<【卧龙庄主】/FCOLOR=249>可获得激活<【诛仙之力】/FCOLOR=251>所需材料\\元素魔石：<【智慧魔石、力量魔石、自然魔石、权利魔石、黑暗魔石】/FCOLOR=249>",500,16,"#FFFFFF")
    GUI:setAnchorPoint(self.ui.Rtext2, 0, 1)
end

function wolongMasterOBJ:refreshMidBox3() --#region 刷新中间box诛仙
    self.leftIndex =3
    GUI:Image_loadTexture(self.ui.bg_Image,"res/custom/npc/78wlzz/bg3.png")
    removeOBJ(self.ui.leftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..self.leftIndex],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],(index == self.leftIndex and "res/custom/dayeqian2.png") or "res/custom/dayeqian1.png")
    end
    for i = 1, 3 do
        GUI:setVisible(self.ui["rightBox"..i],i == self.leftIndex)
    end
    local is_show_red = true
    for index, value in ipairs(self.cfg[3]["info_config"]) do
        local itemColor = 249
        if SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]) < 1000 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]))) >= value[2] then
                itemColor = 250
            else
                is_show_red = false
            end
        else
            if SL:GetMetaValue("ITEM_COUNT", value[1]) >= value[2] then
                itemColor = 250
            else
                is_show_red = false
            end
        end
        ItemShow_updateItem(self.ui["item_3"..index],{showCount=true,index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[1]),count=value[2], color=itemColor,look=true,bgVisible=true})
    end
    GUI:UserUILayout(self.ui.textNode3, {dir=1,addDir=2,interval=0.5,gap = {y=8},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    local x_space = SL:GetMetaValue("WINPLAYMODE") and 30 or 6
    GUI:UserUILayout(self.ui.itemNode3, {dir=2,addDir=2,interval=0.5,gap = {x=x_space},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    self:flushRed(is_show_red)
    GUI:setVisible(self.ui.activeBtn3,tonumber(GameData.GetData("l_zhuxian"))~=1)
    GUI:setVisible(self.ui.activeImg3,tonumber(GameData.GetData("l_zhuxian"))==1)
end

--#region 后端消息刷新ui
function wolongMasterOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["称号"] = function ()
            self:refreshMidBox3()
        end,
    }
    functionTab[tab[1]]()
end

function wolongMasterOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.activeBtn3)
        end
    end
end

--#region 关闭前回调
function wolongMasterOBJ:onClose(...)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == wolongMasterOBJ.npcId then
        ViewMgr.open(wolongMasterOBJ.Name)
    end
    if npc_info.index == 327 then
        SendMsgClickNpc(npc_info.index .. "#wolongGuard")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, wolongMasterOBJ.Name, onClickNpc)

return wolongMasterOBJ