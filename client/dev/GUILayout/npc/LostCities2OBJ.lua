local LostCities2OBJ = {}
LostCities2OBJ.Name = "LostCities2OBJ"
LostCities2OBJ.RunAction = true
LostCities2OBJ.HideMain = true

function LostCities2OBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LostCities2UI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:showRewardItem()
end

function LostCities2OBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.joinBtn, function ()
        SendMsgCallFunByNpc(0, "LostAbyssNpc", "enterMSZC", 1)
    end)
end

function LostCities2OBJ:showRewardItem()
    -- reward item
    local reward_list = {"「乾坤圈」","「混天绫」","「风火轮」","「神火罩」","魔童降世(限定装扮)"}
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

return LostCities2OBJ