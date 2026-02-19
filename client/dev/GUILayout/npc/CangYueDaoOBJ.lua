
local CangYueDaoOBJ = {}
CangYueDaoOBJ.NPC = 93
CangYueDaoOBJ.Name = "CangYueDaoOBJ"
CangYueDaoOBJ.RunAction = true

function CangYueDaoOBJ:main(sl_state)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/CangYueDaoUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()

    local title_list = {
        {"砝码大陆有个神秘的岛屿<【苍月岛】/FCOLOR=243>", 375, 335},
        {"传说<【三英雄】/FCOLOR=251>在岛屿上封印了魔界通道", 350, 310},
        {"需要激活<【神龙之羽】/FCOLOR=254><(卧龙山庄激活)/FCOLOR=253>", 365, 285}
    }
    for k, v in ipairs(title_list) do
        local name_rich = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "_cyd_title"..k, v[2], v[3], v[1], 400, 18, "#ffffff")
    end

    local title = "神龙之羽: <%s/FCOLOR=%d>"
    if sl_state == "1" then
        title = string.format(title, "已激活", 250)
    else
        title = string.format(title, "未激活", 249)
    end
    self.sl_active_rich = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "_sl_active", 520, 107, title, 400, 18, "#ffffff")

    self:showRewardItem()
end

function CangYueDaoOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(CangYueDaoOBJ.Name)
    end)
    GUI:addOnClickEvent(self.ui.enterMapBtn, function ()
        SendMsgCallFunByNpc(CangYueDaoOBJ.NPC, "GoToMapNpc", "GotoMap3", "")
    end)
end

function CangYueDaoOBJ:showRewardItem()
    local reward_list = {"宗师装备", "聖龍装备", "神龙装备", "天龙装备", "高级材料"}
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
    if npc_info.index == CangYueDaoOBJ.NPC then
        SendMsgCallFunByNpc(CangYueDaoOBJ.NPC, "GoToMapNpc", "GotoMap3", "open")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "CangYueDaoOBJ", onClickNpc)

return CangYueDaoOBJ