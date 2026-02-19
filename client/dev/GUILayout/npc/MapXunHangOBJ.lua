local MapXunHangOBJ = {}
MapXunHangOBJ.Name = "MapXunHangOBJ"
MapXunHangOBJ.cfg = SL:Require("GUILayout/config/prohibitXhMapCfg",true)

function MapXunHangOBJ:main(mapId, mapName, state)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_names = SL:Split(mapName, "|")
    self.map_info = SL:Split(mapId, "|")
    local tab = SL:Split(state, "|")
    self.check_box_state = {}
    for k, v in ipairs(tab) do
        self.check_box_state[k] = tonumber(v)
    end
    GUI:LoadExport(parent, "npc/MapXunHangUI", function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateMapInfo()
    self:updateCheckBoxInfo()
    self:updateStartBtnState()
end

function MapXunHangOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.start_btn, function()
        self:onClickStartBtn()
    end)

    for i = 1, 4 do
        GUI:CheckBox_addOnEvent(self.ui["checkBox_"..i], function ()
            self:onClickCheckBox(i)
        end)
    end

   
    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["btn_"..i], function ()
            self:onClickRecordBtn(i,self.map_info[i] ~= "-1")
        end)
    end    
end

function MapXunHangOBJ:updateMapInfo(sendSever)
    for k, v in pairs(self.map_info) do
        local str = self.map_names[k]
        local btn_path = "res/custom/npc/43xh/an_jl.png"
        local color = "#ffffff"
        if v ~= "-1" then
            color = "#00FF00"
            btn_path = "res/custom/npc/43xh/an_qk.png"
        end
        GUI:Text_setString(self.ui["map_name"..k], str)
        GUI:Text_setTextColor(self.ui["map_name"..k],color)
        GUI:Button_loadTextureNormal(self.ui["btn_"..k], btn_path)
    end
    if sendSever then
        local sMsg = self:getSendSeverParam()
        SendMsgClickMainBtn("0#MainTopBtn#onRecordXunHangInfo#" .. sMsg)
    end
end

function MapXunHangOBJ:updateCheckBoxInfo()
    for k, v in pairs(self.check_box_state) do
        GUI:CheckBox_setSelected(self.ui["checkBox_"..k], v == 1)
    end
end

function MapXunHangOBJ:onClickCheckBox(index)
    local state = GUI:CheckBox_isSelected(self.ui["checkBox_"..index])
    if index == 2 then
        state = true
        GUI:CheckBox_setSelected(self.ui["checkBox_"..index], state)
    end
    self.check_box_state[index] = state and 1 or 0

    self:updateMapInfo(true)
end

function MapXunHangOBJ:onClickRecordBtn(index,is_remove)
    local map_id = SL:GetMetaValue("MAP_ID")
    local map_name = SL:GetMetaValue("MAP_NAME")
    if self.cfg and isInTable(self.cfg, tostring(map_id)) and not is_remove then
        SendMsgClickMainBtn("0#MainTopBtn#onSelectXunHangMap#" .. map_id)
        return
    end
    if GameData.GetData("U_in_xunhang", false) == 1 then
        SL:ShowSystemTips("您已开启巡航挂机，请先停止巡航")
        return
    end
    if "-1" ~= self.map_info[index] then
        -- 记录地图了
        map_id = "-1"
        map_name = "未记录地图"
    end
    self.map_info[index] = map_id
    self.map_names[index] = map_name

    self:updateMapInfo(true)
end

function MapXunHangOBJ:onClickStartBtn()
    local sMsg = self:getSendSeverParam()
    SendMsgClickMainBtn("0#MainTopBtn#onClickStartXunHang#"..sMsg)
end

function MapXunHangOBJ:updateStartBtnState(data)
    local state = GameData.GetData("U_in_xunhang", false)
    local btn_path = "res/custom/npc/43xh/an_ks.png"
    if state == 1 then
        btn_path = "res/custom/npc/43xh/an_tz.png"
    end
    GUI:Button_loadTextureNormal(self.ui.start_btn, btn_path)
end

function MapXunHangOBJ:getSendSeverParam()
    local ids = nil
    for k, v in pairs(self.map_info) do
        if nil == ids then
            ids = v
        else
            ids = ids .. "|" .. v
        end
    end
    local state = nil
    for k, v in pairs(self.check_box_state) do
        if nil == state then
            state = v
        else
            state = state .. "|" .. v
        end
    end    
    return ids .. "#" .. state
end

local function callBack(data)
    -- SL:Print(GameData.GetData("U_in_xunhang", false))
    if type(data) == "string" and string.find(data, "U_in_xunhang") and ViewMgr.IsOpen(MapXunHangOBJ.Name) then
        MapXunHangOBJ:updateStartBtnState(data)
    end
end

SL:RegisterLUAEvent(LUA_EVENT_GAME_DATA, "MapXunHangOBJ", callBack)

return MapXunHangOBJ