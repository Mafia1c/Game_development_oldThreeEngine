local OptionalTreasureOBJ = {}
OptionalTreasureOBJ.Name = "OptionalTreasureOBJ"
OptionalTreasureOBJ.RunAction = true

function OptionalTreasureOBJ:main(id_tab, _type)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/OptionalTreasureUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.treasure_ids = SL:JsonDecode(id_tab)
    self.ui_type = tonumber(_type)

    self:initClickEvent()
    self:showCellInfo()
end

function OptionalTreasureOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    for i = 1, 6 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            SendMsgCallFunByNpc(0, "OptionalItemNpc", "onGetTreasureReward", self.ui_type.."#"..i)
        end)
    end
end

function OptionalTreasureOBJ:showCellInfo()
    for i = 1, 6 do
        local id = self.treasure_ids[i]
        local setData  = {}
        setData.index = tonumber(id) or 0                 -- 物品Index
        setData.bgVisible = true              -- 是否显示背景框
        setData.look = true
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)

        local name = SL:GetMetaValue("ITEM_NAME", setData.index)
        GUI:Text_setString(self.ui["Text_"..i], name)
        local color = "#ff0000"
        if self.ui_type == 2 then
            color = "#00ffe8"
        end
        GUI:Text_setTextColor(self.ui["Text_"..i], color)
    end
end

return OptionalTreasureOBJ