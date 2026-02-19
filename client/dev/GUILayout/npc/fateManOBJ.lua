local fateManOBJ = {}

fateManOBJ.Name = "fateManOBJ"
fateManOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
fateManOBJ.cfg = SL:Require("GUILayout/config/fateManCfg",true)
fateManOBJ.npcId = 247

function fateManOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/fateManUI")
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("fateManOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("fateManOBJ")
    end)
    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "fateMan", "upEvent", "")
    end)

    self:refreshMidBox()
    -- self:runAction()
end
--#region 开始动画
function fateManOBJ:runAction()
    GUI:runAction(self.ui.leftBox,GUI:ActionSequence(GUI:DelayTime(0.01),GUI:CallFunc(function()
        Animation.followOpacity(self.ui.infoList1,255,0.3)
        GUI:runAction(self.ui.infoList1,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.3,140,370)))
        GUI:runAction(self.ui.effectBox,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.4,0,0)))
        GUI:runAction(self.ui.ballImg,GUI:ActionMoveTo(0.2,242,274))
    end),GUI:DelayTime(0.2),GUI:CallFunc(function()
        Animation.followOpacity(self.ui.infoList2,255,0.3)
        GUI:runAction(self.ui.infoList2,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.3,140,222)))
    end)
    ))
    GUI:Timeline_Window1(self.ui.rightBox)
end
--#region 刷新中间box
function fateManOBJ:refreshMidBox()
    self.layer = tonumber(GameData.GetData("l_fateMan",false)) or 0
    GUI:removeAllChildren(self.ui.item_node)
    self.ui = GUI:ui_delegate(self._parent)
    if self.layer ~= #self.cfg then
        self.layer = self.layer+1
    end
    local function itemFun(i,name,tab)
        GUI:Image_Create(self.ui.item_node,"itemBox"..i,0,0,"res/custom/itemBox.png")
        GUI:Win_SetParam(self.ui["itemBox"..i], i)
        local item = GUI:ItemShow_Create(self.ui["itemBox"..i],"item_"..name,30,30,tab)
        tab["showCount"] = true
        ItemShow_updateItem(item,tab)
        GUI:setAnchorPoint(item,0.5,0.5)
    end
    for i = 1, 5 do
        local color = 250
        if i == 1 then
            local infoTab = self.cfg[self.layer]["need_arr"..SL:GetMetaValue("JOB")]
            if SL:GetMetaValue("ITEM_COUNT", infoTab[1]) < infoTab[2] then
                color = 249
            end
            itemFun(i,infoTab[1],{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", infoTab[1]),look=true,bgVisible=false,count=infoTab[2],color =color,})
            goto continue
        end
        local infoTab = self.cfg[self.layer]["need_arr"..i+1] or {}
        if not self.cfg[self.layer]["need_arr"..i+1] then
            goto continue
        end
        local index = (SL:GetMetaValue("ITEM_INDEX_BY_NAME", infoTab[1]))
        if index < 10000 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", index)) < infoTab[2] then
                color = 249
            end
            itemFun(i,infoTab[1],{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", infoTab[1]),look=true,bgVisible=false,count=infoTab[2],color =color,})
        else
            if tonumber(SL:GetMetaValue("ITEM_COUNT", infoTab[1])) < infoTab[2] then
                color = 249
            end
            itemFun(i,infoTab[1],{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", infoTab[1]),look=true,bgVisible=false,count=infoTab[2],color =color,})
        end
        ::continue::
    end
    GUI:UserUILayout(self.ui.item_node, {dir=2,addDir=2,interval=1,gap = {x=4},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return GUI:Win_GetParam(a) > GUI:Win_GetParam(b)
        end)
    end})
    if self.layer == #self.cfg then
        GUI:Text_setString(self.ui.needText,"当前已经突破至最高等级")
        GUI:setVisible(self.ui.upBtn,false)
        GUI:setVisible(self.ui.activeImg,true)
    end
    local name = self.cfg[self.layer]["name"].."境界"
    GUI:Text_setString(self.ui.needText,"突破需要宗师境界达到："..name)
end


--#region 后端消息刷新ui
function fateManOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["提升"] = function ()
            self:refreshMidBox()
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

--#region 关闭前回调
function fateManOBJ:onClose(...)

end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == fateManOBJ.npcId then
        ViewMgr.open(fateManOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, fateManOBJ.Name, onClickNpc)

return fateManOBJ