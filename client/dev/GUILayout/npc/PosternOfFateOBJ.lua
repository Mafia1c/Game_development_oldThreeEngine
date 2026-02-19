local PosternOfFateOBJ = {}
PosternOfFateOBJ.Name = "PosternOfFateOBJ"
PosternOfFateOBJ.NPC = 109

function PosternOfFateOBJ:main(mon_count,role_count)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/PosternOfFateUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:showRewardItem()
    local str = "存活中"
    local color = "#00FF00"
    if tonumber(mon_count) <= 0 then
        str = "已死亡"
        color = "#ff0000"
    end
    GUI:Text_setString(self.ui.mon_count_txt,str)
    GUI:Text_setTextColor(self.ui.mon_count_txt,color)
    GUI:Text_setString(self.ui.role_count_txt,role_count)
end

function PosternOfFateOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.GotoBtn, function ()
        SendMsgCallFunByNpc(PosternOfFateOBJ.NPC, "PosternOfFateNpc", "onClickGoToBtn", "")
    end)
end

function PosternOfFateOBJ:showRewardItem()
   
    local reward_list = {"海量经验", "特殊四格", "高级材料", "游戏货币", "十二生肖"}
    for k, v in pairs(reward_list) do
        local index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v)
        local setData  = {}
        setData.index = index                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], setData)
    end    
end

local function onClickNpc(npc_info)
    if npc_info.index == PosternOfFateOBJ.NPC then
    --     ViewMgr.open(PosternOfFateOBJ.Name)
        SendMsgCallFunByNpc(PosternOfFateOBJ.NPC,"PosternOfFateNpc","upEvent")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "PosternOfFateOBJ", onClickNpc)
return PosternOfFateOBJ