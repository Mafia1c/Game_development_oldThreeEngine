local DivineDragonOBJ = {}
DivineDragonOBJ.Name = "DivineDragonOBJ"
DivineDragonOBJ.cfg = SL:Require("GUILayout/config/DivineDragonCfg",true)
DivineDragonOBJ.NPC = 253
DivineDragonOBJ.RunAction = true
DivineDragonOBJ.equip_ids = {50997,50998,50999,51000,51001,51002,51003,51004}


function DivineDragonOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/DivineDragonUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = 1

    self:initClickEvent()
    self:showEquipInfo()
    self:updateShowItem()
end

function DivineDragonOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(DivineDragonOBJ.Name)
    end)
    GUI:addOnClickEvent(self.ui.unsealBtn, function ()
        SendMsgCallFunByNpc(DivineDragonOBJ.NPC, "DivineDragonNpc", "onClickUnseal", self.cur_select_index)
    end)
    for i = 1, 8 do
        GUI:addOnClickEvent(self.ui["icon_click_"..i], function ()
            if i == self.cur_select_index then
                return
            end
            self.cur_select_index = i

            self:updateShowItem()
        end)
    end
end

function DivineDragonOBJ:showEquipInfo()
    for i = 1, 8 do
        local v = {}
        v.index = self.equip_ids[i] or 0
        v.look  = false
        v.bgVisible = false
        v.count = 1
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i],  v)
    end
end

function DivineDragonOBJ:updateShowItem()
    GUI:removeAllChildren(self.ui.txtNode)
    local cfg = self.cfg[self.cur_select_index]
    if self.cur_select_index then
        local pos = GUI:getPosition(self.ui["ItemShow_"..self.cur_select_index])
        GUI:setPosition(self.ui.select_img, pos.x, pos.y)
    end

    GUI:ItemShow_updateItem(self.ui["showItem"],  {index = self.equip_ids[self.cur_select_index], look = true})
    GUI:setVisible(self.ui.select_img, self.cur_select_index ~= nil)
    GUI:Text_setString(self.ui.equipName, cfg.Name)

    local rich = GUI:RichTextFCOLOR_Create(self.ui["txtNode"], "_title", 0, -5, cfg.title, 300, 18, "#ffffff")
    GUI:setAnchorPoint(rich, 0.5, 0)
    rich = GUI:RichTextFCOLOR_Create(self.ui["txtNode"], "_map", 0, -30, cfg.map, 300, 18, "#ffffff")
    GUI:setAnchorPoint(rich, 0.5, 0)
    rich = GUI:RichTextFCOLOR_Create(self.ui["txtNode"], "_boos", 0, -55, cfg.boss, 300, 18, "#ffffff")
    GUI:setAnchorPoint(rich, 0.5, 0)
    rich = GUI:RichTextFCOLOR_Create(self.ui["txtNode"], "_baolv", 0, -78, cfg.baoLv, 300, 18, "#ffffff")
    GUI:setAnchorPoint(rich, 0.5, 0)

    local tmp_list = {}
    for k, v in pairs(cfg.nedd_map) do
        local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k)
        local value = v
        local data = {
            item_id,
            value
        }
        table.insert(tmp_list, data)
    end
    table.sort(tmp_list, function (a, b)
        return a[1] > b[1]
    end)

    for i = 1, #tmp_list do
        local v = tmp_list[i]
        local color = 255
        if v[1] <= 100 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", v[1])) < v[2] then
                color = 249
            end
        else
            if SL:GetMetaValue("ITEM_COUNT", v[1]) < v[2] then
                color = 249
            end
        end
        GUI:ItemShow_updateItem(self.ui["needItem_"..i], {index = v[1], look = true, bgVisible = true, count = v[2], color = color})
    end
end

function DivineDragonOBJ:flushView()

end

local function onClickNpc(npc_info)
    if npc_info.index == DivineDragonOBJ.NPC then
        SendMsgClickNpc(DivineDragonOBJ.NPC.."#DivineDragonNpc")
        -- ViewMgr.open(DivineDragonOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "DivineDragonOBJ", onClickNpc)

return DivineDragonOBJ