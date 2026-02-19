local donateOBJ = {}
donateOBJ.Name = "donateOBJ"
donateOBJ.npcId = 308

function donateOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/donateUI")
    self.ui = GUI:ui_delegate(parent)

    if sMsg then
        sMsg = SL:JsonDecode(sMsg)
    else
        sMsg = {}
    end
    self.infoTab = sMsg --#region 捐献表

    self:refreshMidBox()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("donateOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("donateOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn,function ()
        local number = GUI:TextInput_getString(self.ui.input)
        SendMsgCallFunByNpc(self.npcId, "donate", "upEvent",number)
    end)
end

--#region 刷新中间box
function donateOBJ:refreshMidBox()
    GUI:runAction(self.ui.title,GUI:ActionSequence(GUI:DelayTime(0.01),GUI:CallFunc(function()
        Animation.followOpacity(self.ui.title,255,0.3)
        GUI:runAction(self.ui.title,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.3,376,420)))
        GUI:runAction(self.ui.title,GUI:ActionScaleTo(0.3,1))
        -- GUI:Timeline_Window1(self.ui.title)
    end)
    ))
    GUI:removeAllChildren(self.ui.midList)
    self.ui = GUI:ui_delegate(self._parent)

    local colorTab = {"#ff0000","#ffff00","#00ffe8","#9b00ff","#ff9b00","#ffffff",}
    local textTab = {"HP+10%、攻魔道伤+10%","HP+8%、攻魔道伤+8%","HP+6%、攻魔道伤+6%","HP+5%、攻魔道伤+5%","HP+4%、攻魔道伤+4%","HP+2%、攻魔道伤+2%",}
    local function createBox(index,box,name,number)
        GUI:Image_Create(box,"icon"..index,34,22,"res/custom/npc/45jx/n_"..index..".png")
        GUI:setAnchorPoint(self.ui["icon"..index],0.5,0.5)
        GUI:Text_Create(box,"name"..index,140,20,16,colorTab[index],name)
        GUI:setAnchorPoint(self.ui["name"..index],0.5,0.5)
        GUI:Text_Create(box,"number"..index,368,20,16,colorTab[index],number)
        GUI:setAnchorPoint(self.ui["number"..index],0.5,0.5)
        GUI:Text_Create(box,"infoText"..index,610,20,16,colorTab[index],textTab[index])
        GUI:setAnchorPoint(self.ui["infoText"..index],0.5,0.5)
    end
    local time = 0
    for i = 1, 6 do
        local box = GUI:Layout_Create(self.ui.midList,"midBox"..i,0,0,732,46,false)
        if self.infoTab ~= nil and self.infoTab[i] then
            createBox(i,box,self.infoTab[i]["actorName"],self.infoTab[i]["number"])
        elseif i == 6 then
            createBox(i,box,"捐献10灵符未上榜者，统一获得第六名属性","")
            GUI:setPositionX(self.ui.name6,226)
        else
            createBox(i,box,"暂无玩家上榜",0)
        end
        GUI:setVisible(box,false)
        time = time +0.05
        GUI:runAction(box,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(box,true)
            GUI:setPositionX(box,-732)
            GUI:runAction(box,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(box))))
        end)))
    end
    local ownNumber = GameData.GetData("l_donate",false)
    if ownNumber == nil then ownNumber = 0
    end
    GUI:Text_setString(self.ui.nowNumber,ownNumber.."灵符")
end

--#region 关闭前回调
function donateOBJ:onClose(...)

end

--#region 后端消息刷新ui
function donateOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["捐献"] = function()
            if tab[2] then
                tab[2] = SL:JsonDecode(tab[2])
            else
                tab[2] = {}
            end
            self.infoTab = tab[2] --#region 捐献表
            self:refreshMidBox()
        end,
    }
    functionTab[tab[1]]()
end

local function onClickNpc(npc_info)
    if npc_info.index == donateOBJ.npcId then
        SendMsgClickNpc(donateOBJ.npcId .. "#donate")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "donateOBJ", onClickNpc)
return donateOBJ