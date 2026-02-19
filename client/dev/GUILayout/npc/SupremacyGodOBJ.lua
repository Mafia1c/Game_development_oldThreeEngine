local SupremacyGodOBJ = {}
SupremacyGodOBJ.Name = "SupremacyGodOBJ"
SupremacyGodOBJ.cfg = SL:Require("GUILayout/config/RuneWordsCfg",true)
SupremacyGodOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
SupremacyGodOBJ.npcId = 292
SupremacyGodOBJ.RunAction = true
SupremacyGodOBJ.cfg = {"声望",200000,"金刚石",2000000}

function SupremacyGodOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.key_index = 0
	self.active_list = {}
	--加载UI
	GUI:LoadExport(parent, "npc/SupremacyGodUI")

	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(SupremacyGodOBJ.Name)
	end) 
	--给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "SupremacyGod", "upEvent")
    end)
	self:refreshInfo()
end

function SupremacyGodOBJ:refreshInfo()
    local is_show_red = true
    local itemColor = 249
    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[1]))) >= self.cfg[2]then
        itemColor = 250
    else
        is_show_red =false
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
    GUI:setVisible(self.ui.upBtn,tonumber(GameData.GetData("UL_SupremacyGod",false)) ~= 1)
    GUI:setVisible(self.ui.activeImg,tonumber(GameData.GetData("UL_SupremacyGod",false)) == 1)
    if tonumber(GameData.GetData("UL_landGod",false)) ~= 1  or tonumber(GameData.GetData("l_masterLayer",false)) < 11 or SL:GetMetaValue("LEVEL") < 79 then
        is_show_red = false

    end
    self:flushRed(is_show_red)
end

--#region 后端消息刷新ui
function SupremacyGodOBJ:flushView(...)
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

function SupremacyGodOBJ:flushRed(is_show_red)
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
function SupremacyGodOBJ:onClose( ... )
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end
-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == SupremacyGodOBJ.npcId then
        ViewMgr.open(SupremacyGodOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, SupremacyGodOBJ.Name, onClickNpc)

return SupremacyGodOBJ