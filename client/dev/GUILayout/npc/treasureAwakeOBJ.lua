local treasureAwakeOBJ = {}

treasureAwakeOBJ.Name = "treasureAwakeOBJ"
treasureAwakeOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
treasureAwakeOBJ.cfg = SL:Require("GUILayout/config/treasureAwakeCfg",true)
treasureAwakeOBJ.npcId = 332

function treasureAwakeOBJ:main(star)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/treasureAwakeUI")
    self.ui = GUI:ui_delegate(parent)

    self.star = tonumber(star) or 0
    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("treasureAwakeOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("treasureAwakeOBJ")
    end)
    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "treasureAwake", "upEvent", "")
    end)

    self:refreshLeftNode()
    self:refreshNeedItem()
    self:runAction()
end

function treasureAwakeOBJ:runAction() --#region 动画
    GUI:UserUILayout(self.ui.needBox, {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
        -- table.sort(lists, function (a, b)
        --     return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        -- end)
    end})
    GUI:Timeline_Window4(self.ui.FrameLayout)
end
function treasureAwakeOBJ:refreshLeftNode() --#region 加载左节点
    local temp = self.star
    if temp ~= #self.cfg then temp = self.star+1 end
    GUI:Text_setString(self.ui.equipName,"《"..SL:GetMetaValue("EQUIPBYPOS", 14).."》")
    GUI:Text_setString(self.ui.starText,temp.."星")
    GUI:Text_setString(self.ui.oddText,self.cfg[temp]["odd"].."%")
    removeOBJ(self.ui.equipItem,self)
    GUI:EquipShow_Create(self.ui.leftNode,"equipItem",290,359,14,false,{look=true,bgVisible=false})
    GUI:EquipShow_setAutoUpdate(self.ui.equipItem)
    GUI:setAnchorPoint(self.ui.equipItem,0.5,0.5)
end

--#region 加载强化需要的物品框(无加号)
function treasureAwakeOBJ:refreshNeedItem()
    GUI:removeAllChildren(self.ui.needBox)
    self.ui = GUI:ui_delegate(self._parent)
    if self.star == #self.cfg then --#region 最高等级
        GUI:setVisible(self.ui.upBtn,false)
        return
    end
    local infoTab = self.cfg[self.star+1]
    local number = 0 --#region 物品显示
    --#region 升星物品显示
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
end

--#region 后端消息刷新ui
function treasureAwakeOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["失败"] = function ()
            self:refreshLeftNode()
            self:refreshNeedItem()
        end,
        ["提升"] = function ()
            self:refreshLeftNode()
            self:refreshNeedItem()
        end,
    }
    self.star = tonumber(tab[2]) or self.star
    functionTab[tab[1]]()
end

--#region 关闭前回调
function treasureAwakeOBJ:onClose(...)

end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == treasureAwakeOBJ.npcId then
        SendMsgClickNpc(npc_info.index .. "#treasureAwake")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, treasureAwakeOBJ.Name, onClickNpc)

return treasureAwakeOBJ