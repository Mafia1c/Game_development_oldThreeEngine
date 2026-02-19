local landGodOBJ = {}

landGodOBJ.Name = "landGodOBJ"
landGodOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
landGodOBJ.cfg = {"声望",100000,"金刚石",1000000}
landGodOBJ.npcId = 255

function landGodOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/landGodUI")
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("landGodOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("landGodOBJ")
    end)
    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "landGod", "upEvent", "")
    end)

    self:refreshInfo()
end

function landGodOBJ:refreshInfo()
    local itemColor = 249
    local is_show_red = true
    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", self.cfg[1])) >= self.cfg[2]then
        itemColor = 250
    else
        is_show_red = false
    end
    GUI:ItemShow_updateItem(self.ui["item_1"],
    {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[1]),count=self.cfg[2], color=itemColor,look=true,bgVisible=true})
    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[3]))) >= self.cfg[4]then
        itemColor = 250
    else
        is_show_red = false
    end
    GUI:ItemShow_updateItem(self.ui["item_2"],
    {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[3]),count=self.cfg[4], color=itemColor,look=true,bgVisible=true})
    GUI:setVisible(self.ui.upBtn,tonumber(GameData.GetData("UL_landGod",false)) ~= 1)
    GUI:setVisible(self.ui.activeImg,tonumber(GameData.GetData("UL_landGod",false)) == 1)
    local level = tonumber(GameData.GetData("l_masterLayer",false))
    self:flushRed(is_show_red and level >= 11 and SL:GetMetaValue("LEVEL") >= 79)
end

--#region 后端消息刷新ui
function landGodOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["提升"] = function ()
            self:refreshInfo()
        end,
    }
    functionTab[tab[1]]()
end

function landGodOBJ:flushRed(is_show_red)
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
function landGodOBJ:onClose(...)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == landGodOBJ.npcId then
        ViewMgr.open(landGodOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, landGodOBJ.Name, onClickNpc)

return landGodOBJ