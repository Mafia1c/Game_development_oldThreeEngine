local lockMagicOBJ = {}
lockMagicOBJ.Name = "lockMagicOBJ"
lockMagicOBJ.npcId = 0
lockMagicOBJ.RunAction = true
lockMagicOBJ.cfg={
    {{"龙之心",99},{"金刚锤",99},{"宝石碎片",58},{"绑定金刚石",1980}},{{"龙之心",99},{"金刚锤",99},{"宝石碎片",58},{"绑定金刚石",1980}},
    {{"龙之心",99},{"金刚锤",99},{"宝石碎片",58},{"绑定金刚石",1980}},{{"龙之心",99},{"金刚锤",99},{"宝石碎片",58},{"绑定金刚石",1980}},
    {{"龙之心",99},{"金刚锤",99},{"宝石碎片",58},{"绑定金刚石",1980}},{{"龙之心",99},{"金刚锤",99},{"宝石碎片",58},{"绑定金刚石",1980}},
    {{"龙之心",99},{"金刚锤",99},{"宝石碎片",58},{"绑定金刚石",1980}},
}

function lockMagicOBJ:main(...)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent

    GUI:LoadExport(parent, "npc/lockMagicUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:refreshInfo()
end

function lockMagicOBJ:refreshInfo()
    local giftTab = GameData.GetData("TL_Recharge_hasGift",true) or {} --#region 充值过的礼包
    GUI:setVisible(self.ui.buyBtn, not giftTab["gift_fmcf"])
    GUI:setVisible(self.ui.buyImg, giftTab["gift_fmcf"] and true)
    GUI:removeAllChildren(self.ui.infoList)
    self.ui = GUI:ui_delegate(self._parent)
    local textTab = {"【第一天】", "【第二天】", "【第三天】", "【第四天】", "【第五天】", "【第六天】", "【第七天】"}
    local time = 0
    for index, value in ipairs(self.cfg) do
        local box = GUI:Image_Create(self.ui.infoList, "rightBox"..index, 0, 0, "res/custom/npc/49fm/z10.png")
        GUI:Text_Create(box,"title"..index, 174, 92, 16, "#FFFF00", textTab[index].."可领")
        GUI:setAnchorPoint(self.ui["title"..index], 0.5, 0.5)
        GUI:Node_Create(box, "itemNode"..index, 130, 38)
        for i, v in ipairs(value) do
            GUI:ItemShow_Create(self.ui["itemNode"..index], "item"..index.."_"..i, 0, 0, 
            {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", v[1]), look=true, bgVisible=true, count=v[2], color=250})
        end
        local isWin32 = SL:GetMetaValue("WINPLAYMODE")
        GUI:UserUILayout(self.ui["itemNode"..index], {dir=2, addDir=2, interval=0.5, gap = {x= isWin32 and 30 or 2}, sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
        GUI:Button_Create(box, "upBtn"..index, 298, 38, "res/custom/npc/49fm/lq.png")
        GUI:setAnchorPoint(self.ui["upBtn"..index], 0.5, 0.5)
        GUI:Image_Create(box, "upImg"..index, 298, 38, "res/custom/tag/ok.png")
        GUI:setAnchorPoint(self.ui["upImg"..index], 0.5, 0.5)
        GUI:setVisible(self.ui["upImg"..index], (GameData.GetData("UL_fmcf"..index,false) or 0) > 0)
        GUI:setVisible(self.ui["upBtn"..index], (GameData.GetData("UL_fmcf"..index,false) or 0) == 0)
        GUI:removeAllChildren(self.ui["upBtn"..index])
        if (GameData.GetData("JL_fmcf_today",false) or 0) <= 0 and giftTab["gift_fmcf"] then
            if index ~= 1 then
                if (GameData.GetData("UL_fmcf"..index-1,false) or 0) > 0 and (GameData.GetData("UL_fmcf"..index,false) or 0) <= 0 then
                    SL:CreateRedPoint(self.ui["upBtn"..index])
                end
            else
                if (GameData.GetData("UL_fmcf"..index,false) or 0) <= 0 then
                    SL:CreateRedPoint(self.ui["upBtn"..index])
                end
            end
        end 
    
        GUI:addOnClickEvent(self.ui["upBtn"..index], function ()
            SendMsgCallFunByNpc(self.npcId, "lockMagic", "upEvent", index)
        end)
        GUI:setVisible(box,false)
        time = time +0.07
        GUI:runAction(box,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(box,true)
            GUI:setPositionX(box,346)
            GUI:runAction(box,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.07,0,GUI:getPositionY(box))))
        end)))
    end
    GUI:addOnClickEvent(self.ui.buyBtn, function ()
        SendMsgCallFunByNpc(self.npcId, "lockMagic", "buyEvent", "") --#region 首次购买
    end)

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close(self.Name)
    end)
end

function lockMagicOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["充值刷新"] = function ()
            self:refreshInfo()
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

return lockMagicOBJ