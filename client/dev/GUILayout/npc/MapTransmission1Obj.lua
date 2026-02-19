local MapTransmission1Obj = {}
MapTransmission1Obj.Name = "MapTransmission1Obj"
MapTransmission1Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission1Obj.RunAction = true
--[[
    {60,91,92},{其他}               --　已完成待测试
    {257-262},{371-376},            --　缺资源
]]

function MapTransmission1Obj:main(id)
    id = tonumber(id)
    local ui_path = "npc/GoToMapUI"
    local filter_ids = {60, 91, 92}
    self.cur_select_page = nil
    if isInTable(filter_ids, id) then
        ui_path = "npc/GoToMap2UI"
        self.cur_select_page = 1
    end
    SL:Print("MapTransmission1Obj :", self.cur_select_page, id)

    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[id]
    self.map_cfg_id = id
    self.eff_pos_list = {}
    self.rich_txt_list = {}

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
    self:updatePageBtn()

    GUI:setContentSize(self.ui["gaobaoLayout"], SL:GetMetaValue("SCREEN_WIDTH"), SL:GetMetaValue("SCREEN_HEIGHT"))
end

function MapTransmission1Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.enterGBBtn, function ()
        GUI:setVisible(self.ui.gaobaoLayout, true)
    end)
    GUI:addOnClickEvent(self.ui.enterMapBtn, handler(self, self.enterMap))
    GUI:addOnClickEvent(self.ui.Button_GB, handler(self, self.enterGaoBao))

    GUI:addOnClickEvent(self.ui.gaobaoLayout, function ()
        GUI:setVisible(self.ui.gaobaoLayout, false)
    end)
end

function MapTransmission1Obj:enterGaoBao()
    local map_cfg = self:getMapCfg()
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id.."|2"
    if nil ~= self.cur_select_page then
        sMsg = sMsg .. "|" .. self.cur_select_page
    end    
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap", sMsg)
end

function MapTransmission1Obj:enterMap()
    local map_cfg = self:getMapCfg()
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id.."|1"
    if nil ~= self.cur_select_page then
        sMsg = sMsg .. "|" .. self.cur_select_page
    end
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoMap", sMsg)
end

function MapTransmission1Obj:flushView(...)
    local tab = {...}

end

function MapTransmission1Obj:updateViewInfo()
    -- mini map
    local map_cfg = self:getMapCfg()

    GUI:Text_setString(self.ui["mapName"], map_cfg.name)

    local mini_map = string.gsub(map_cfg.miniMap or "", "T", "")
    local map_img_path = "scene/uiminimap/"..mini_map..".png"
    if SL:IsFileExist(map_img_path) then
        GUI:Image_loadTexture(self.ui["miniMapImg"], map_img_path)
    else
        local function downloadcallback(isOk, path)
            if isOk then
                GUI:Image_loadTexture(self.ui["miniMapImg"], path)
            end
            SL:release_print("down load mini img === ", isOk, path, mini_map)
        end
        SL:DownloadMiniMapRes(tonumber(mini_map) + 1, downloadcallback)
    end

    for k, v in pairs(self.rich_txt_list) do
        GUI:removeFromParent(v)
    end
    self.rich_txt_list = {}

    local rich1 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map", -65, 23, map_cfg.mapLevel, 500, 18, "#ffffff")
    local rich2 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_mon", -65, -8, map_cfg.updateTime, 500, 18, "#ffffff")
    local rich3 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_boos", -65, -39, map_cfg.boosName, 500, 18, "#ffffff")
    local rich4 = nil
    local rich5 = nil
    local cfg_ids = {243,244,319}
    if isInTable(cfg_ids, self.map_cfg_id) then
        GUI:setVisible(self.ui.b_title1, false)
        GUI:setVisible(self.ui.b_title2, false)
        local str1 = "地图介绍:  <全区首次击杀必爆雷霆衣服/FCOLOR=253>,<击杀BOSS必爆聖龍首饰/FCOLOR=250>"
        local str2 = "进入条件:  <需要开启狂暴之力/FCOLOR=253>"
        if self.map_cfg_id == 244 then
            str1 = "地图介绍:  <全区首次击杀必爆开天级武器/FCOLOR=253>,<击杀BOSS必爆聖龍首饰/FCOLOR=250>"
        end        
        if self.map_cfg_id == 319 then
            str1 = "通关奖励:  <天龙武器x1丶惊喜魔盒x1丶声望x200/FCOLOR=253>"
            str2 = "领取条件:  <5关的Boss为同一个击杀!>"
        end
        rich4 = GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_enter", -245, 12, str1, 600, 18, "#ffffff")
        rich5 = GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_nandu", -245, -19, str2, 500, 18, "#ffffff")
    else
        GUI:setVisible(self.ui.b_title1, true)
        GUI:setVisible(self.ui.b_title2, true)
        rich4 = GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_enter", -158, 12, map_cfg.joinValue, 600, 18, "#ffffff")
        rich5 = GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_nandu", -158, -19, map_cfg.difficulty, 500, 18, "#ffffff")
    end

    self.rich_txt_list = {rich1, rich2, rich3, rich4, rich5}

    GUI:setVisible(self.ui.enterGBBtn, #map_cfg.mapId_arr ~= 1)

    -- reward item
    local reward_list = map_cfg.reward_arr or {}
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

function MapTransmission1Obj:updatePageBtn()
    if nil == self.cur_select_page or nil == self.ui.btnPage then
        return
    end
    GUI:ScrollView_removeAllChildren(self.ui.btnPage)
    local height = GUI:getContentSize(self.ui.btnPage).height
    for k, v in pairs(self.map_cfg) do
        local y = height - ((k - 1) * 42) - ((k - 1) * 1) - 25
        self.eff_pos_list[k] = y
        local btn = GUI:Button_Create(self.ui.btnPage, v.name, 5, y, "res/custom/npc/01ditu/taban.png")
        GUI:Button_setTitleText(btn, v.name)
        GUI:Button_setTitleFontSize(btn, 18)
        GUI:addOnClickEvent(btn, function()
            if k == self.cur_select_page then
                return
            end
            self.cur_select_page = k
            self:updateViewInfo()
            GUI:setPositionY(self.ui._btn_eff, self.eff_pos_list[k])
        end)
    end
    self.ui._btn_eff = GUI:Image_Create(self.ui.btnPage, "_btn_eff", 5, self.eff_pos_list[1], "res/custom/npc/007dtcs02/xz.png")
end

function MapTransmission1Obj:getMapCfg()
    local map_cfg = self.map_cfg
    if nil ~= self.cur_select_page then
        map_cfg = self.map_cfg[self.cur_select_page]
    end
    return map_cfg or self.map_cfg
end

-- 点击npc触发
local function onClickNpc(npc_info)
    local info = MapTransmission1Obj.cfg[npc_info.index]
    local filter_ids = {257,258,259,260,261,262,263,371,372,373,374,375,376,277,278,279,280,281,282,265,266,267,268,269,270,275,62,284,312,328,329,330,331,369,370,377,378,379,380,381,382,383}
    local filter_npc = {392,393,395,397,398,399,400,402,404,405,407,408,409,410}
    if info and nil == info.reward_arr and nil == info[1] and not isInTable(filter_npc, npc_info.index) then
        SendMsgCallFunByNpc(npc_info.index, "GoToMapNpc", "GotoMap", npc_info.index.."|1")
        return
    end
    if info and not isInTable(filter_ids, npc_info.index) then
        SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission1Obj", onClickNpc)

return MapTransmission1Obj