local blackShopOBJ = {}

blackShopOBJ.Name = "blackShopOBJ"
blackShopOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
blackShopOBJ.cfg = {
    [315] = { { "根骨福袋", 999, 10, 48, 10 }, { "神龙福袋", 999, 10, 48, 10 }, { "飞升福袋", 999, 10, 48, 10 } },
    [316] = { { "帝王福袋", 1299, 10, 58, 10 }, { "龙神福袋", 1299, 10, 58, 10 }, { "符文福袋", 1299, 10, 58, 10 }, },
}
blackShopOBJ.cfg2 = { [315]={"JL_ggfd","JL_slfd","JL_fsfd"}, [316]={"JL_dwfd","JL_lsfd","JL_fwfd"}, } --#region rmb购买次数

function blackShopOBJ:main(npcId)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    --加载UI
    GUI:LoadExport(parent, "npc/blackShopUI")
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("blackShopOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.CloseButton, function()
        ViewMgr.close("blackShopOBJ")
    end)
    --#region 购买maskBox
    GUI:addOnClickEvent(self.ui.mask,function ()
        GUI:setVisible(self.ui.mask,false)
    end)
    GUI:addOnClickEvent(self.ui.maskCloseBtn,function ()
        GUI:setVisible(self.ui.mask, false)
    end)
    GUI:addOnClickEvent(self.ui.buyBtn_1,function ()
        SendMsgCallFunByNpc(npcId, "blackShop", "buyEvent2",npcId.."#"..self.btnIndex.."#1") --#region rmb购买
    end)
    GUI:addOnClickEvent(self.ui.buyBtn_10,function ()
        SendMsgCallFunByNpc(npcId, "blackShop", "buyEvent2",npcId.."#"..self.btnIndex.."#10") --#region rmb购买
    end)

    self:refreshInfo(npcId)
end

function blackShopOBJ:refreshInfo(npcId)
    self.npcId = npcId
    for i = 1, 3 do
        GUI:Text_setString(self.ui["itemName"..i],"《".. self.cfg[npcId][i][1] .."》")
        GUI:ItemShow_updateItem(self.ui["item"..i],{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[npcId][i][1]),look=true,bgVisible=true})

        GUI:Button_setTitleText(self.ui["buyBtn1"..i],self.cfg[npcId][i][2].."灵符购买") --#region 灵符按钮
        removeOBJ(self.ui["Rtext1"..i],self)
        local time1 = GameData.GetData("JL_blackShop"..npcId..i,false) or 0 --#region 今天灵符购买次数
        local Rtext1 = GUI:RichTextFCOLOR_Create(self.ui["buyBtn1"..i],"Rtext1"..i,55,-12,"限购：<"..time1.."/"..self.cfg[npcId][i][3].."/FCOLOR=250>次",120,16,"#ffffff")
        GUI:setAnchorPoint(Rtext1,0.5,0.5)

        GUI:Button_setTitleText(self.ui["buyBtn2"..i],self.cfg[npcId][i][4].."元购买") --#region rmb按钮
        removeOBJ(self.ui["Rtext2"..i],self)
        local time2 = GameData.GetData(self.cfg2[npcId][i],false) or 0 --#region 今天rmb购买次数
        local Rtext2 = GUI:RichTextFCOLOR_Create(self.ui["buyBtn2"..i],"Rtext2"..i,55,-12,"限购：<"..time2.."/"..self.cfg[npcId][i][5].."/FCOLOR=250>次",120,16,"#ffffff")
        GUI:setAnchorPoint(Rtext2,0.5,0.5)
    end
    GUI:UserUILayout(self.ui.topNode, {dir=2,addDir=2,interval=0.5,gap = {x=170},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    for i = 1, 2 do
        GUI:UserUILayout(self.ui["btnNode"..i], {dir=2,addDir=2,interval=0.5,gap = {x=60},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["buyBtn1"..i],function ()
            self.btnIndex = i
            SendMsgCallFunByNpc(npcId, "blackShop", "buyEvent1",npcId.."#"..i) --#region 灵符购买
        end)
        GUI:addOnClickEvent(self.ui["buyBtn2"..i],function ()
            self.btnIndex = i
            local time2 = GameData.GetData(self.cfg2[npcId][i],false) or 0 --#region 今天rmb购买次数
            GUI:Text_setString(self.ui.copyText1,"《"..self.cfg[npcId][i][1].."》")
            GUI:Text_setString(self.ui.copyText2,"礼包价格："..self.cfg[npcId][i][4].."元")
            GUI:Text_setString(self.ui.copyText3,"限购次数："..time2.."/"..self.cfg[npcId][i][5])
            GUI:setVisible(self.ui.mask,true)
        end)
    end
end

--#region 后端消息刷新ui
function blackShopOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["lf"] = function ()
            removeOBJ(self.ui["Rtext1"..self.btnIndex],self)
            local time1 = GameData.GetData("JL_blackShop"..self.npcId..self.btnIndex,false) or 0 --#region 今天灵符购买次数
            local Rtext1 = GUI:RichTextFCOLOR_Create(self.ui["buyBtn1"..self.btnIndex],"Rtext1"..self.btnIndex,55,-12,"限购：<"..time1.."/"..self.cfg[self.npcId][self.btnIndex][3].."/FCOLOR=250>次",120,16,"#ffffff")
            GUI:setAnchorPoint(Rtext1,0.5,0.5)
        end,
        ["充值刷新"] = function ()
            removeOBJ(self.ui["Rtext2"..self.btnIndex],self)
            local time2 = GameData.GetData(self.cfg2[self.npcId][self.btnIndex],false) or 0 --#region 今天rmb购买次数
            GUI:Text_setString(self.ui.copyText3,"限购次数："..time2.."/"..self.cfg[self.npcId][self.btnIndex][5])
            local Rtext2 = GUI:RichTextFCOLOR_Create(self.ui["buyBtn2"..self.btnIndex],"Rtext2"..self.btnIndex,55,-12,"限购：<"..time2.."/"..self.cfg[self.npcId][self.btnIndex][5].."/FCOLOR=250>次",120,16,"#ffffff")
            GUI:setAnchorPoint(Rtext2,0.5,0.5)
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end


--#region 关闭前回调
function blackShopOBJ:onClose(...)
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == 315 or npc_info.index == 316 then --#region 苍月岛/魔龙城
        ViewMgr.open(blackShopOBJ.Name,npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, blackShopOBJ.Name, onClickNpc)

return blackShopOBJ