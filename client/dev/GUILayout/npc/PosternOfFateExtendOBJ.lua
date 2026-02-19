local PosternOfFateExtendOBJ = {}
PosternOfFateExtendOBJ.Name = "PosternOfFateExtendOBJ"
PosternOfFateExtendOBJ.cfg = SL:Require("GUILayout/config/PosternOfFateCfg",true)

function PosternOfFateExtendOBJ:main(npc_id, cur_level)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/PosternOfFateExtendUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.npc_id = npc_id
    self.cur_level = tonumber(cur_level)
    local level = string.match(SL:GetMetaValue("MAP_ID"), "%-?%d+%.?%d*")
    if level ~= cur_level then
        self.cur_level = tonumber(level)
    end
    SL:Print(level, cur_level)
    self:initClickEvent()
    self:showUiInfo()
end

function PosternOfFateExtendOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.challengeBtn, function ()
        SendMsgCallFunByNpc(self.npc_id, "PosternOfFateNpc", "playDice",  "0#"..self.npc_id)
    end)

    for i = 1, 6 do
        GUI:addOnClickEvent(self.ui["pointBtn_"..i], function ()
            SendMsgCallFunByNpc(self.npc_id, "PosternOfFateNpc", "playDice", i.."#"..self.npc_id )
        end)
    end

    GUI:addOnClickEvent(self.ui.open_treasure_btn,function ()
        SendMsgCallFunByNpc(self.npc_id, "PosternOfFateTreasure", "upEvent",self.npc_id)
    end)
end

function PosternOfFateExtendOBJ:showUiInfo(index)
    index = index or 0
    GUI:Text_setString(self.ui.view_level_txt, "当前层数: " .. SL:GetMetaValue("MAP_NAME"))
    local layer = self.cur_level
    GUI:setVisible(self.ui.open_treasure_btn,layer ~= 100 and layer %10 == 0)
    local cfg = PosternOfFateExtendOBJ.cfg[1]
    local rich_txt1 = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "_rich_txt1", 30, 115, cfg.mapIntroduce, 550,18)
    local rich_txt2 = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "_rich_txt2", 30, 85, cfg.mapIntroduce1, 550,18)
end

local function onClickNpc(npc_info)

    local cfg = PosternOfFateExtendOBJ.cfg[1]
    if isInTable(cfg.npcid_arr, npc_info.index) then
        SendMsgCallFunByNpc(npc_info.index, "PosternOfFateNpc", "showDiceView", npc_info.index)
    end
    if npc_info.index == 233 then
        SendMsgCallFunByNpc(npc_info.index, "PosternOfFateNpc", "onClickTopNpc", npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "PosternOfFateExtendOBJ", onClickNpc)

return PosternOfFateExtendOBJ