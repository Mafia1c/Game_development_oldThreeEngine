local disguiseOBJ = {}
disguiseOBJ.Name = "disguiseOBJ"
disguiseOBJ.cfg = SL:Require("GUILayout/config/disguiseCfg",true)
disguiseOBJ.npcId = 0

function disguiseOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/disguiseUI")
    self.ui = GUI:ui_delegate(parent)

    self:refreshLeftList()
    local hastab = GameData.GetData("TL_disguise",true) or {} --#region 装扮表
    for index, value in ipairs(self.cfg) do
        if hastab[tostring(index)] and hastab[tostring(index)] ~= {} then
            self:leftBtnEvent(index)
            break
        end
    end

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("disguiseOBJ")
    end)

    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("disguiseOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        if self.leftIndex ~= nil and self.rightName ~= nil then
            SendMsgCallFunByNpc(self.npcId, "disguise", "dress"..self.leftIndex,self.cfg[self.rightName]["itemName"])
        else
            SL:ShowSystemTips("<font color=\'#ff0000\'>请先激活时装或选取需要外显的时装！</font>")
        end
    end)
    GUI:addOnClickEvent(self.ui.tipsBtn, function()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn)
        local specialTab = {}
        local tips = "<当前已激活的时装属性：/FCOLOR=250>\\".."<攻击加成："..#hastab["1"].."-"..#hastab["1"].."/FCOLOR=255>\\".."<魔法加成："..#hastab["1"].."-"..#hastab["1"].."/FCOLOR=255>\\"
        .."<道术加成："..#hastab["1"].."-"..#hastab["1"].."/FCOLOR=255>\\".."<防御加成："..#hastab["1"].."-"..#hastab["1"].."/FCOLOR=255>\\"
        .."<魔御加成："..#hastab["1"].."-"..#hastab["1"].."/FCOLOR=255>\\"
        for i, v in ipairs(hastab["1"] or {}) do
            for key, value in pairs(self.cfg[v]["text_map"]) do
                if not specialTab[key] then
                    specialTab[key] = {value[1], value[2]}
                else
                    specialTab[key][1] = specialTab[key][1] + value[1]
                end
            end
        end
        for key, value in pairs(specialTab) do
            tips = tips .. "<"..key.."："..value[1].."%/FCOLOR="..value[2]..">\\"
        end
        GUI:ShowWorldTips(string.sub(tips, 1, -2), worldPos, GUI:p(1, 1))
    end)
end

--#region 刷新左侧list
function disguiseOBJ:refreshLeftList()
    local hastab = GameData.GetData("TL_disguise",true) or {} --#region 装扮表
    GUI:removeAllChildren(self.ui.leftList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
        if hastab[tostring(index)] and hastab[tostring(index)] ~= {} then
            local btn = GUI:Button_Create(self.ui.leftList, "leftBtn" .. index, 0, 0, "res/custom/dayeqian1.png")
            GUI:Button_setTitleText(btn,value["type"])
            GUI:Button_setTitleFontSize(btn,18)
            GUI:Button_setTitleColor(btn,"#F8E6C6")
            GUI:Button_loadTexturePressed(btn, "res/custom/dayeqian2.png")
            GUI:addOnClickEvent(btn,function ()
                self:leftBtnEvent(index)
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
end

--#region 左侧点击事件
function disguiseOBJ:leftBtnEvent(leftIndex)
    GUI:setVisible(self.ui.tipsBtn,leftIndex == 1) --#region 1级列表才有tips
    local hastab = GameData.GetData("TL_disguise",true) or {} --#region 装扮表
    self.leftIndex = leftIndex --#region 1级列表index
    removeOBJ(self.ui.leftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..leftIndex],"leftTag",6,22,"res/public/jiantou.png")
    GUI:setAnchorPoint(self.ui.leftTag,0.5,0.5)
    for index, value in ipairs(self.cfg) do
        if hastab[tostring(index)] and hastab[tostring(index)] ~= {} then
            GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/dayeqian1.png")
        end
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..self.leftIndex],"res/custom/dayeqian2.png")
    GUI:removeAllChildren(self.ui.hasBigList)
    -- GUI:UserUILayout(self.ui.hasBigList, {dir=2,addDir=2, interval=1,gap={l=100}})
    self.ui = GUI:ui_delegate(self._parent)
    local nowTab = hastab[tostring(leftIndex)] or {}
    local number = math.ceil(#nowTab/4)
    local time = 0
    for i = 1, number do
        local list = GUI:Widget_Create(self.ui.hasBigList,"rightList"..i,0,0,246,60)
        GUI:setTouchEnabled(list,false)
        GUI:setVisible(list,false)
        time = time + 0.05
        GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
            GUI:setVisible(list, true)
            GUI:setPositionX(list, 254)
            GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
        end)))
    end
    local item_index = 0
    for index, value in ipairs(nowTab) do
        item_index = index % 4 == 0 and 4 or index % 4
        local x = (item_index -1) * 60 +  30  
        local y = 30
        local item = GUI:ItemShow_Create(self.ui["rightList"..math.ceil(index/4)],"disguise"..index,x,y
        ,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[value]["itemName"]),bgVisible=true})
        GUI:setAnchorPoint(item,0.5,0.5)
        local layout = GUI:Layout_Create(item,"layout"..index,0,0,60,60,false)
        GUI:setTouchEnabled(layout,true)
        GUI:addOnClickEvent(layout,function ()
            self.rightName = value
            self:refreshMidNode(index)
        end)
    end
   
    if nowTab ~= {} then
        self.rightName = nowTab[1]
        self:refreshMidNode(1)
    end
end

function disguiseOBJ:refreshMidNode(rightIndex) --#region 右边box点击事件
    removeOBJ(self.ui.effectPerson,self)
    removeOBJ(self.ui.nowItem,self)
    removeOBJ(self.ui.nowEffectBox,self)
    if SL:GetMetaValue("WINPLAYMODE") then
        local effect = GUI:Effect_Create(self.ui["layout"..rightIndex], "nowEffectBox", 15, 18, 0, 27565)
        GUI:setScale(effect,0.8)
    else
        GUI:Effect_Create(self.ui["layout"..rightIndex], "nowEffectBox", 28, 32, 0, 27565)
    end
    GUI:ItemShow_Create(self.ui.rightNode,"nowItem",678,438
    ,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[self.rightName]["itemName"]),bgVisible=false,look=true})
    GUI:setAnchorPoint(self.ui.nowItem,0.5,0.5)
    GUI:Text_setString(self.ui.nowName, self.cfg[self.rightName]["itemName"])
    local effectTab = self.cfg[self.rightName]["effect_arr"]
    GUI:Effect_Create(self.ui.midNode, "effectPerson", effectTab[1], effectTab[2], effectTab[3] + SL:GetMetaValue("SEX")
    ,effectTab[4], 0, effectTab[5], effectTab[6])
    GUI:setScale(self.ui.effectPerson, effectTab[7])
    if self.cfg[self.rightName]["itemName"] == GameData.GetData("UL_disguise" .. self.leftIndex, false) then
        GUI:Button_setTitleText(self.ui.upBtn, "关闭外显")
    else
        GUI:Button_setTitleText(self.ui.upBtn, "开启外显")
    end
end

--#region 关闭前回调
function disguiseOBJ:onClose(...)

end

--#region 后端消息刷新ui
function disguiseOBJ:flushView(...)
    local tab = {...}
    local btnName = GUI:Button_getTitleText(self.ui.upBtn)
    if btnName == "开启外显" then
        GUI:Button_setTitleText(self.ui.upBtn,"关闭外显")
    else
        GUI:Button_setTitleText(self.ui.upBtn,"开启外显")
    end
    local functionTab = {
        ["时装"] = function()

        end,
        ["足迹"] = function ()

        end,
        ["精灵"] = function ()

        end,
        ["宠物"] = function ()

        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

local function moveEvent(data)
    local actorID = data and data.id
    if actorID then
        local posX = SL:GetMetaValue("ACTOR_POSITION_X", actorID)
        local posY = SL:GetMetaValue("ACTOR_POSITION_Y", actorID)
        local dir = SL:GetMetaValue("ACTOR_DIR", actorID)
        local effectModel = SL:GetMetaValue("ACTOR_GM_DATA", actorID)[1]
        local effectID = SL:GetMetaValue("ACTOR_GM_DATA", actorID)[2]
        if effectID ~= 0 and posX and posY then
            local actBegin = data.act
            if actBegin == 1 or actBegin == 6 or actBegin == 17 then
                local eff = GUI:Effect_Create(GUI:Attach_SceneB(),
                    string.format("foot_effect%s_%s%s", actorID, posX, posY), posX, posY, effectModel, effectID, 0, 0,
                    dir, 0.8)
                GUI:setScale(eff, 0.3)
                if eff then
                    GUI:Effect_addOnCompleteEvent(eff, function()
                        GUI:removeFromParent(eff)
                    end)
                end
            end
        end
    end
end
SL:RegisterLUAEvent(LUA_EVENT_PLAYER_ACTION_BEGIN, "GUIUtil", moveEvent)
SL:RegisterLUAEvent(LUA_EVENT_NET_PLAYER_ACTION_BEGIN, "GUIUtil", moveEvent)
return disguiseOBJ
