local RechargeOBJ = {}

RechargeOBJ.Name = "RechargeOBJ"
RechargeOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
RechargeOBJ.cfg = {
    [1]={{"绑定灵符",10},{"秘宝礼盒",1},{"五彩石",50}}, [2]={{"绑定灵符",38},{"书页",100},{"战神兵符",1}}, [3]={{"绑定灵符",98},{"五彩石",100},{"横扫全服(称号)",1}},
    [4]={{"绑定灵符",168},{"书页",200},{"绝品秘宝自选宝箱",1}}, [5]={{"绑定灵符",328},{"五彩石",500},{"孤品秘宝自选宝箱",1}}, [6]={{"绑定灵符",648},{"书页",500},{"斩尽天下不收刀(称号)",1}},
}
RechargeOBJ.npcId = 0
RechargeOBJ.RunAction = true

function RechargeOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/RechargeUI")
    self.ui = GUI:ui_delegate(parent)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("RechargeOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("RechargeOBJ")
    end)

    self.typeIndex = 1
    self:refreshInfo()
end

function RechargeOBJ:refreshInfo()
    local moneyTab = {10,38,98,168,328,648}
    local money = tonumber(GameData.GetData("U_recharge",true)) or 0
    GUI:Text_setString(self.ui.allText,money.."元")
    GUI:UserUILayout(self.ui.typeNode, {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    local giftTab = {"gift_zdy10","gift_zdy38","gift_zdy98","gift_zdy168","gift_zdy328","gift_zdy648"}
    for index, value in ipairs(self.cfg) do
        for i = 1, 3 do
            GUI:ItemShow_updateItem(self.ui["item"..index..i]
            ,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", value[i][1]),look=true,bgVisible=true,count=value[i][2],color=251,})
        end
        GUI:addOnClickEvent(self.ui["midBtn"..index],function ()
            SendMsgClickMainBtn("0#Recharge#custom#"..self.typeIndex.."#"..moneyTab[index])
            -- SendMsgClickMainBtn("0#Recharge#customGift#"..giftTab[index])
        end)
    end
    for i = 1, 2 do
        GUI:UserUILayout(self.ui["midNode"..i], {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["typeBtn"..i],function ()
            self.typeIndex = i
            GUI:setVisible(self.ui.typeTag1,1==i)
            GUI:setVisible(self.ui.typeTag2,2==i)
            GUI:setVisible(self.ui.typeTag3,3==i)
        end)
    end
    GUI:addOnClickEvent(self.ui.buyBtn,function ()
        local number = GUI:TextInput_getString(self.ui.input)
        SendMsgClickMainBtn("0#Recharge#custom#"..self.typeIndex.."#"..number)
        GUI:TextInput_setString(self.ui.input,0)
    end)
end

--#region 后端消息刷新ui
function RechargeOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["refresh"] = function ()
            local money = tonumber(GameData.GetData("U_recharge",true)) or 0
            GUI:Text_setString(self.ui.allText,money.."元")
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

--#region 关闭前回调
function RechargeOBJ:onClose(...)
end

-- 点击npc触发(对应npcList表id)
-- local function onClickNpc(npc_info)
--     if npc_info.index == RechargeOBJ.npcId then
--         ViewMgr.open(RechargeOBJ.Name)
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, RechargeOBJ.Name, onClickNpc)

return RechargeOBJ