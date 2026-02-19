local skyMasterOBJ = {}

skyMasterOBJ.Name = "skyMasterOBJ"
skyMasterOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
skyMasterOBJ.cfg = SL:Require("GUILayout/config/skyMasterCfg",true)
skyMasterOBJ.npcId = 387

function skyMasterOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/skyMasterUI")
    self.ui = GUI:ui_delegate(self._parent)

    GUI:Timeline_Window1(self.ui.FrameLayout)
    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("skyMasterOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("skyMasterOBJ")
    end)
    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "skyMaster", "upEvent", "")
    end)

    self:refreshLeftNode()
    self:refreshRightNode()
end

function skyMasterOBJ:refreshLeftNode()
    local level = SL:GetMetaValue("RELEVEL")
    GUI:Text_setString(self.ui.levelText,level.."转")
    removeOBJ(self.ui.Rtext1,self)
    removeOBJ(self.ui.Rtext2,self)
    GUI:RichTextFCOLOR_Create(self.ui.leftNode,"Rtext1",80,170,"最高可提升至<【25级】/FCOLOR=249>每当达成转生后\\<人物等级突破提升1级，全系技能抵抗，异次元之力/FCOLOR=250>",380,16,"#ffffff",1)
    GUI:RichTextFCOLOR_Create(self.ui.leftNode,"Rtext2",80,108,"<异次元之力介绍：/FCOLOR=251>\\<异次元之力，/FCOLOR=250>可提升人物在异界地图中的<攻击伤害/FCOLOR=250>"
    .."\\<异次元之力，/FCOLOR=250>每10000点异次元之力提升<1%攻击伤害/FCOLOR=250>",460,16,"#ffffff",1)
    GUI:setAnchorPoint(self.ui.Rtext1,0,1)
    GUI:setAnchorPoint(self.ui.Rtext2,0,1)
end

function skyMasterOBJ:refreshRightNode()
    local layer = tonumber(GameData.GetData("UL_skyMaster",false)) or 18
    local textTab = {"攻击倍数：","生命加成：","技能抵抗：","次元之力：",}
    if layer == 18 then
        for i = 1, 4 do
            GUI:Text_setString(self.ui["text1"..i],textTab[i].."0")
        end
        GUI:Text_setString(self.ui["text21"],textTab[1]..self.cfg[19]["text1"].."%")
        GUI:Text_setString(self.ui["text22"],textTab[2]..self.cfg[19]["text2"].."%")
        GUI:Text_setString(self.ui["text23"],textTab[3]..self.cfg[19]["text3"].."%")
        GUI:Text_setString(self.ui["text24"],textTab[4]..self.cfg[19]["text4"])
    elseif layer == 25 then
        GUI:Text_setString(self.ui["text11"],textTab[1]..self.cfg[25]["text1"].."%")
        GUI:Text_setString(self.ui["text12"],textTab[2]..self.cfg[25]["text2"].."%")
        GUI:Text_setString(self.ui["text13"],textTab[3]..self.cfg[25]["text3"].."%")
        GUI:Text_setString(self.ui["text14"],textTab[4]..self.cfg[25]["text4"])
        for i = 1, 4 do
            GUI:Text_setString(self.ui["text2"..i],textTab[i].."MAX")
        end
    else
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."1"], textTab[1] .. self.cfg[layer+i-1]["text1"] .. "%")
            GUI:Text_setString(self.ui["text"..i.."2"], textTab[2] .. self.cfg[layer+i-1]["text2"] .. "%")
            GUI:Text_setString(self.ui["text"..i.."3"], textTab[3] .. self.cfg[layer+i-1]["text3"] .. "%")
            GUI:Text_setString(self.ui["text"..i.."4"], textTab[4] .. self.cfg[layer+i-1]["text4"])
        end
    end
    GUI:UserUILayout(self.ui.textNode1, {dir=1,addDir=2,interval=0.5,gap = {y=4},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:UserUILayout(self.ui.textNode2, {dir=1,addDir=2,interval=0.5,gap = {y=4},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    GUI:removeAllChildren(self.ui.needBox)
    local is_show_red = true
    self.ui = GUI:ui_delegate(self._parent)
    local infoTab = self.cfg[layer+1] or {}
    local number = 0 --#region 物品显示
    --#region 升星物品显示
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        local itemColor = 0
        if SL:GetMetaValue("ITEM_COUNT", k) < v then
            itemColor = 249
            is_show_red =false
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
    if layer == 25 then
        GUI:setVisible(self.ui.needBox, false)
    end
    GUI:setVisible(self.ui.upBtn,layer ~= 25)
    GUI:setVisible(self.ui.activeImg,layer == 25)
    self:flushRed(is_show_red and SL:GetMetaValue("RELEVEL") >= 18)
end

--#region 后端消息刷新ui
function skyMasterOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["提升"] = function ()
            local level = SL:GetMetaValue("RELEVEL")
            GUI:Text_setString(self.ui.levelText,level+1 .."转")
            self:refreshRightNode()
        end,
    }
    functionTab[tab[1]]()
end
function skyMasterOBJ:flushRed(is_show_red)
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
function skyMasterOBJ:onClose(...)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == skyMasterOBJ.npcId then
        SendMsgClickNpc(skyMasterOBJ.npcId .. "#skyMaster")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, skyMasterOBJ.Name, onClickNpc)

return skyMasterOBJ