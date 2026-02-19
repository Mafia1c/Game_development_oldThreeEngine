
local OneDayLockOBJ = {}
OneDayLockOBJ.Name = "OneDayLockOBJ"
OneDayLockOBJ.RunAction = true

function OneDayLockOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/OneDayLockUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:showItem()
end

function OneDayLockOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(OneDayLockOBJ.Name)
    end)
    GUI:addOnClickEvent(self.ui.Button_1, function ()
        SendMsgClickSysBtn("_logingive#OtherSysFunc#onClickBtn#1")
    end)
    GUI:addOnClickEvent(self.ui.Button_2, function ()
        local sdk_code = GUI:TextInput_getString(self.ui.TextInput_1)
        SendMsgClickSysBtn("_logingive#OtherSysFunc#onClickBtn#2#"..sdk_code)
    end)

    for i = 1, 8 do
        local btn = self.ui["Image_"..i]
        GUI:addOnClickEvent(btn, function ()
            SendMsgClickSysBtn("_logingive#OtherSysFunc#onClickBtn#3#"..i)
            GUI:setTouchEnabled(btn, false)
        end)
    end
end

function OneDayLockOBJ:showItem()
    local item_list = {
        {"爆率+10%", 10369},
        {"爆率+25%", 10371},
        {"爆率+15%", 10370},
        {"爆率+35%", 10372},
        {"回收+10%", 10373},
        {"回收+25%", 10375},
        {"回收+15%", 10374},
        {"回收+35%", 10376},
    }
    for k, v in pairs(item_list) do
        local setData  = {}
        setData.index = v[2]                 -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], setData)
    end
end

function OneDayLockOBJ:flushView(item_name, count, index)
    count = tonumber(count)
    local item_id = tonumber(item_name)
    if item_id then
    else
        item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", item_name)
    end
    local card = self.ui["Image_"..index]
    if nil == card then
        return
    end

    local item = GUI:getChildByName(card, "ItemShow")
    GUI:setVisible(item, true)
    local setData  = {}
    setData.index = item_id                 -- 物品Index
    setData.look  = true                  -- 是否显示tips
    setData.bgVisible = false              -- 是否显示背景框
    setData.count = count                     -- 物品数量
    GUI:ItemShow_updateItem(item, setData)
    GUI:Image_loadTexture(card, "res/custom/npc/40zbfl/p2.png")
end

return OneDayLockOBJ