local cutMasterOBJ = {}

cutMasterOBJ.Name = "cutMasterOBJ"
cutMasterOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
cutMasterOBJ.cfg = SL:Require("GUILayout/config/cutMasterCfg",true)
cutMasterOBJ.npcId = 114

function cutMasterOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/cutMasterUI")
    self.ui = GUI:ui_delegate(parent)

    self:refreshLeftList()
    self:leftBtnEvent(1)
    self:runAction()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("cutMasterOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("cutMasterOBJ")
    end)

    GUI:addOnClickEvent(self.ui.elseCloseBtn, function()
        GUI:setVisible(self.ui.elseBox,false)
    end)

    GUI:addOnClickEvent(self.ui.allBtn,function ()
        SendMsgCallFunByNpc(self.npcId, "cutMaster", "all",self.leftIndex)
    end)
end

--#region 起始动画
function cutMasterOBJ:runAction()

end

--#region 刷新面板
function cutMasterOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
        local btn = GUI:Button_Create(self.ui.leftList,"leftBtn"..index,0,0,"res/custom/dayeqian1.png")
        GUI:Button_loadTexturePressed(btn,"res/custom/dayeqian2.png")
        GUI:Button_setTitleText(btn,value.type)
        GUI:Button_setTitleFontSize(btn,18)
        GUI:Button_setTitleColor(btn,"#F8E6C6")
        GUI:addOnClickEvent(btn,function ()
            self:leftBtnEvent(index)
        end)
        time = time + 0.05
        GUI:setVisible(btn,false)
        GUI:runAction(btn,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(btn,true)
            GUI:setPositionX(btn,-114)
            GUI:runAction(btn,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(btn))))
        end)))
    end
end

--#region 左侧按钮事件
function cutMasterOBJ:leftBtnEvent(i)
    self.leftIndex = i
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/dayeqian1.png")
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..i],"res/custom/dayeqian2.png")
    removeOBJ(self.ui.leftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..i],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)

    GUI:removeAllChildren(self.ui.infoList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg[i]["equip_arr"]) do
        local box = GUI:Image_Create(self.ui.infoList,"midBox"..index,0,0,"res/custom/npc/13fj/neirong.png")
        GUI:Image_Create(box,"equipBox"..index,44,29,"res/custom/itemBox.png")
        GUI:setAnchorPoint(self.ui["equipBox"..index],0.5,0.5)
        GUI:ItemShow_Create(self.ui["equipBox"..index],"equip"..index,30,30,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", value),look=true,bgVisible=false})
        GUI:setAnchorPoint(self.ui["equip"..index],0.5,0.5)
        GUI:setScale(self.ui["equipBox"..index],0.8)
        GUI:Text_Create(box,"name"..index,84,15,16,"#FFFFFF",value)
        GUI:ListView_Create(box,"midList"..index,330,29,60,60,2)
        local number = 0
        for key, _ in pairs(self.cfg[i]["award_map"]) do
            number = number+1
            GUI:Image_Create(self.ui["midList"..index],"itemBox"..index..number,0,0,"res/custom/itemBox.png")
            local item = GUI:ItemShow_Create(self.ui["itemBox"..index..number],"item"..index..number,30,30
            ,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", key),look=true,bgVisible=false,count = _})
            ItemShow_updateItem(item,
                {showCount=true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", key),look=true,bgVisible=false,count = _,color=255})
            GUI:setAnchorPoint(self.ui["item"..index..number],0.5,0.5)
        end
        GUI:ListView_setItemsMargin(self.ui["midList"..index],2)
        GUI:setContentSize(self.ui["midList"..index], 62*number, 60)
        GUI:setAnchorPoint(self.ui["midList"..index],0.5,0.5)
        GUI:setScale(self.ui["midList"..index],0.8)
        local btn = GUI:Button_Create(box,"upBtn"..index,542,28,"res/custom/npc/13fj/fj1.png")
        GUI:Button_loadTexturePressed(btn,"res/custom/npc/13fj/fj2.png")
        GUI:setAnchorPoint(btn,0.5,0.5)
        GUI:addOnClickEvent(btn,function ()
            self.rightIndex = index
            SendMsgCallFunByNpc(self.npcId, "cutMaster", "obtain",self.leftIndex.."#"..index)
        end)
        GUI:setVisible(box,false)
        time = time + 0.05
        GUI:runAction(box,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(box,true)
            GUI:setPositionX(box,610)
            GUI:runAction(box,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(box))))
        end)))
    end

end

--#region 后端消息刷新ui
function cutMasterOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["单件"] = function()
            -- if not self.ui.levelEffect then
            --     GUI:Effect_Create(self.ui.bg,"levelEffect",400,300,0,61528)
            --     GUI:Effect_setAutoRemoveOnFinish(self.ui.levelEffect)
            -- end
            GUI:removeAllChildren(self.ui.elseTextList)
            self.ui = GUI:ui_delegate(self._parent)
            GUI:Text_Create(self.ui.elseTextList,"elseText1",0,0,16,"#ffffff","分解成功，分解"..tab[2].."件装备，共获得：")
            for key, value in pairs(self.cfg[self.leftIndex]["award_map"]) do
                GUI:Text_Create(self.ui.elseTextList,"elseText"..key,0,0,16,"#ffffff",key.."×"..value*tab[2])
            end
            GUI:setTouchEnabled(self.ui.mask,true)
            GUI:setContentSize(self.ui.mask,SL:GetMetaValue("SCREEN_WIDTH"),SL:GetMetaValue("SCREEN_HEIGHT"))
            GUI:Timeline_Window3(self.ui.elseBox)
            GUI:setVisible(self.ui.elseBox,true)
        end,
        ["系列"] = function()
            -- if not self.ui.levelEffect then
            --     GUI:Effect_Create(self.ui.bg,"levelEffect",400,300,0,61528)
            --     GUI:Effect_setAutoRemoveOnFinish(self.ui.levelEffect)
            -- end
            GUI:removeAllChildren(self.ui.elseTextList)
            self.ui = GUI:ui_delegate(self._parent)
            GUI:Text_Create(self.ui.elseTextList,"elseText1",0,0,16,"#ffffff","分解成功，分解"..tab[2].."件装备，共获得：")
            for key, value in pairs(self.cfg[self.leftIndex]["award_map"]) do
                GUI:Text_Create(self.ui.elseTextList,"elseText"..key,0,0,16,"#ffffff",key.."×"..value*tab[2])
            end
            GUI:setTouchEnabled(self.ui.mask,true)
            GUI:setContentSize(self.ui.mask,SL:GetMetaValue("SCREEN_WIDTH"),SL:GetMetaValue("SCREEN_HEIGHT"))
            GUI:Timeline_Window3(self.ui.elseBox)
            GUI:setVisible(self.ui.elseBox,true)
        end,
        ["本页"] = function()
            -- if not self.ui.levelEffect then
            --     GUI:Effect_Create(self.ui.bg,"levelEffect",400,300,0,61528)
            --     GUI:Effect_setAutoRemoveOnFinish(self.ui.levelEffect)
            -- end
            GUI:removeAllChildren(self.ui.elseTextList)
            self.ui = GUI:ui_delegate(self._parent)
            GUI:Text_Create(self.ui.elseTextList,"elseText1",0,0,16,"#ffffff","分解成功，分解"..tab[2].."件装备，共获得：")
            for key, value in pairs(self.cfg[self.leftIndex]["award_map"]) do
                GUI:Text_Create(self.ui.elseTextList,"elseText"..key,0,0,16,"#ffffff",key.."×"..value*tab[2])
            end
            GUI:setTouchEnabled(self.ui.mask,true)
            GUI:setContentSize(self.ui.mask,SL:GetMetaValue("SCREEN_WIDTH"),SL:GetMetaValue("SCREEN_HEIGHT"))
            GUI:Timeline_Window3(self.ui.elseBox)
            GUI:setVisible(self.ui.elseBox,true)
        end,
    }
    functionTab[tab[1]]()
end

--#region 关闭前回调
function cutMasterOBJ:onClose(...)

end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == cutMasterOBJ.npcId then
        ViewMgr.open(cutMasterOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, cutMasterOBJ.Name, onClickNpc)

return cutMasterOBJ