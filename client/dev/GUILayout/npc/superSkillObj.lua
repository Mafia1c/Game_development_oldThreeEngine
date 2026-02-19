local superSkillObj = {}

superSkillObj.Name = "superSkillObj"
superSkillObj.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
superSkillObj.npcId = 110

function superSkillObj:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/superSkillUI")
    self.ui = GUI:ui_delegate(parent)

    self:refreshInfo()

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("superSkillObj")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("superSkillObj")
    end)

    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "superSkill", "skill","")
    end)
end

--#region 刷新面板
function superSkillObj:refreshInfo()
    local text = {"战士领悟：<十步一杀/FCOLOR=251>    法师领悟：<冰霜群雨/FCOLOR=251>    道士领悟：<死亡之眼/FCOLOR=251>\\"
        .."领悟条件：人物达到<70级/FCOLOR=249>免费领取"}
    local effect = {{198,104,160,0.4},{204,104,160,0.7},{202,104,160,0.5}}
    local typeIndex = tonumber(SL:GetMetaValue("JOB"))--#region 职业转index
    GUI:removeAllChildren(self.ui.midList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for i = 1, 3 do
        time = time + 0.05
        local box = GUI:Image_Create(self.ui.midList,"box"..i,0,0,"res/custom/npc/09jn/"..i..".png")
        -- GUI:Effect_Create(box,"person"..i,90,176,4,4,SL:GetMetaValue("SEX"))
        GUI:Effect_Create(box,"person"..i,90,176,4,4,SL:GetMetaValue("SEX"),0,4)
        GUI:Effect_Create(box,"skill"..i,effect[i][2],effect[i][3],0,effect[i][1])
        GUI:setScale(self.ui["skill"..i],effect[i][4])
        if typeIndex+1 ~= i then
            GUI:setGrey(box,true)
        end
        GUI:setVisible(box,false)
        GUI:runAction(box,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(box,true)
            GUI:setPositionY(box,360)
            GUI:runAction(box,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,GUI:getPositionX(box),0)))
        end)))
    end
    GUI:RichTextFCOLOR_Create(self.ui.downBox,"Rtext",26,64,text[1],500,16,"#FFFFFF",2)
    GUI:setAnchorPoint(self.ui.Rtext,0,1)
end

--#region 后端消息刷新ui
function superSkillObj:flushView(...)
    local tab = {...}
    local functionTab = {

    }
    functionTab[tab[1]]()
end

--#region 关闭前回调
function superSkillObj:onClose(...)

end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info) 
    if npc_info.index == superSkillObj.npcId then
        ViewMgr.open(superSkillObj.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, superSkillObj.Name, onClickNpc)

return superSkillObj