local MapTransmission12Obj = {}
MapTransmission12Obj.Name = "MapTransmission12Obj"
MapTransmission12Obj.cfg = SL:Require("GUILayout/config/mapMoveData",true)
MapTransmission12Obj.RunAction = true
MapTransmission12Obj.Npc = {320,321,322,323,324}

function MapTransmission12Obj:main(id, name)
    id = tonumber(id)
    local ui_path = "npc/GoToMapUI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.map_cfg = self.cfg[id]
    self.map_cfg_id = id
    if "" == name or nil == name then
        name = "暂无玩家击杀"
    end
    self.kill_name = name

    GUI:LoadExport(parent, ui_path, function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:updateViewInfo()
end

function MapTransmission12Obj:initClickEvent()
    GUI:addOnClickEvent(self.ui.CloseLayout, function() end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.enterGBBtn, function ()
        SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoWDDHMap", self.map_cfg_id.."#1")
    end)
    GUI:addOnClickEvent(self.ui.enterMapBtn, handler(self, self.enterMap))
end

function MapTransmission12Obj:enterMap()
    local map_cfg = self:getMapCfg()
    if nil == map_cfg then
        return
    end
    local sMsg = self.map_cfg_id.."#2"
    SendMsgCallFunByNpc(self.map_cfg_id, "GoToMapNpc", "GotoWDDHMap", sMsg)
end

function MapTransmission12Obj:flushView(...)

end

function MapTransmission12Obj:updateViewInfo()
    -- mini map
    local map_cfg = self:getMapCfg()
    GUI:setVisible(self.ui.map_title1, false)
    GUI:setVisible(self.ui.map_title2, false)
    GUI:setVisible(self.ui.map_title3, false)
    GUI:setVisible(self.ui.b_title1, false)
    GUI:setVisible(self.ui.b_title2, false)
    GUI:Button_setTitleText(self.ui.enterGBBtn, "购买药剂")
    local btn_title = "进入下层"
    if self.map_cfg_id == 324 then
        btn_title = "领取奖励"
    end
    GUI:Button_setTitleText(self.ui.enterMapBtn, btn_title)

    local btn_img = "res/public/1900000660.png"
    GUI:Button_loadTextureNormal(self.ui.enterGBBtn, btn_img)
    GUI:Button_loadTextureNormal(self.ui.enterMapBtn, btn_img)
    GUI:setContentSize(self.ui.enterGBBtn, 106, 40)
    GUI:setContentSize(self.ui.enterMapBtn, 106, 40)
    GUI:setPositionX(self.ui.enterGBBtn, 350)
    GUI:setPositionX(self.ui.enterMapBtn, 465)

    GUI:Text_setString(self.ui["mapName"], map_cfg.name)

    local mini_map = string.gsub(map_cfg.miniMap or "", "T", "")
    local map_img_path = "scene/uiminimap/"..mini_map..".png"
    if SL:IsFileExist(map_img_path) then
        GUI:Image_loadTexture(self.ui["miniMapImg"], map_img_path)
    else
        local function download_callback(isOk, path)
            if isOk then
                GUI:Image_loadTexture(self.ui["miniMapImg"], path)
            end
        end
        SL:DownloadMiniMapRes(tonumber(mini_map), download_callback)
    end

    local boss = "<本层BOSS名称:  %s/FCOLOR=251>"
    local rich1 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_boss", -120, 23, string.format(boss, map_cfg.thisboss), 500, 18, "#ffffff")

    local player = "<本层BOSS击杀:  %s/FCOLOR=253>"
    local rich2 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_player", -120, -8, string.format(player, self.kill_name), 500, 18, "#ffffff")

    local tips = "<第五关BOSS死亡刷新后重置/FCOLOR=249>"
    local rich3 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_tips", -120, -39, tips, 500, 18, "#ffffff")

    local reward = "通关奖励:  <%s/FCOLOR=253>"
    local rich4 = GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_reward", -245, 20, string.format(reward, map_cfg.tgjl), 600, 18, "#ffffff")

    local tj_str = "领取条件:  <%s/FCOLOR=253>"
    local rich5 = GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_tiaojian", -245, -5, string.format(tj_str, map_cfg.lqtj), 500, 18, "#ffffff")

    local buy_str = "伽马药剂:  <%s/FCOLOR=250>"
    local rich6 = GUI:RichTextFCOLOR_Create(self.ui["bottomInfo"], "_buy_item", -245, -30, string.format(buy_str, map_cfg.gmyj), 500, 18, "#ffffff")

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

function MapTransmission12Obj:getMapCfg()
    return self.map_cfg
end

-- 点击npc触发
local function onClickNpc(npc_info)
    local info = MapTransmission12Obj.cfg[npc_info.index]
    if info and isInTable(MapTransmission12Obj.Npc, npc_info.index) then
        SendMsgClickNpc(npc_info.index.."#GoToMapNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmission12Obj", onClickNpc)

return MapTransmission12Obj