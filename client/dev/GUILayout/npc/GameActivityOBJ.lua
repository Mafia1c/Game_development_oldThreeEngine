--=====================游戏攻略
local GameActivityOBJ = {}
GameActivityOBJ.Name = "GameActivityOBJ"
GameActivityOBJ.RunAction = true

local img_list = {
    {"res/custom/npc/22hd/bg1.png", y = 179, reward = {"海量经验","特殊四格","高级材料","游戏货币","十二生肖"}, enterValue = "<进入条件: 免费进入/FCOLOR=250>"},
    {"res/custom/npc/22hd/bg2.png", y = 179, reward = {"海量经验","海量经验","海量经验","海量经验","秘宝礼盒"}, enterValue = "<进入条件: 免费进入/FCOLOR=250>"},
    {"res/custom/npc/22hd/bg3.png", y = 179, reward = {"游戏货币","特殊四格","高级材料","海量经验","十二生肖"}, enterValue = "<进入条件: 免费进入/FCOLOR=250>"},
    {"res/custom/npc/22hd/bg4.png", y = 179, reward = {"火龙装备","高级材料","海量经验","游戏货币","特殊四格"}, enterValue = "<进入条件: 加入行会/FCOLOR=250>"},
    {"res/custom/npc/22hd/bg5.png", y = 179, reward = {"天下第一道","天下第一法","天下第一战"}, enterValue = "<进入条件: 45级/FCOLOR=250>"},
    {"res/custom/npc/22hd/bg6.png", y = 161, reward = {"撒旦宝箱","高级材料","游戏货币","海量经验","十二生肖"}, enterValue = "<进入条件: 开启狂暴(每次活动开启,入口15分钟后关闭)/FCOLOR=250>"},
    {"res/custom/npc/22hd/bg7.png", y = 155, reward = {"高级材料","乱斗之王","游戏货币"}, enterValue = "<进入条件: 开启狂暴(活动持续时间15分钟)/FCOLOR=250>"},
    {"res/custom/npc/22hd/bg8.png", y = 179, reward = {"海量经验","特殊四格","高级材料","游戏货币","十二生肖"}, enterValue = "<进入条件: 免费进入/FCOLOR=250>"},
    {"res/custom/npc/22hd/bg81.png", y = 179, reward = {"十二生肖"}, enterValue = "<进入条件: 免费进入/FCOLOR=250>"},
    {"res/custom/npc/22hd/bg91.png", y = 179, reward = {"十二生肖"}, enterValue = "<进入条件: 免费进入/FCOLOR=250>"},
}
local img_path = "res/custom/tag/0-"
function GameActivityOBJ:main(...)
    self.active_state = {...}
    self.red_width_list = {}
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent

    GUI:LoadExport(parent, "npc/GameActivityUI", function () end)

    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = 1

    self:updateViewInfo(1)
    self:initClickEvent()
    for i=1,8 do
        self:flushRed(tonumber(self.active_state[i]) == 1,i)
    end
end

function GameActivityOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    for i = 1, 8 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            self:updateViewInfo(i)
        end)
    end

    GUI:addOnClickEvent(self.ui.enter_btn, function()
        self:onClickEnterBtn()
    end)
end

function GameActivityOBJ:onClickEnterBtn()
    -- 传送地图
    SendMsgClickMainBtn("0#ActivityMapLogic#onEnterGameActivity#"..self.cur_select_index)
end

function GameActivityOBJ:updateViewInfo(index)
    index = tonumber(index)
    self.cur_select_index = index
    local cfg = img_list[index]
    GUI:Image_loadTexture(self.ui.bg_Image, cfg[1])
    for i = 1, 8 do
        GUI:setVisible(self.ui["Image_"..i], index == i)
    end

    local id = self.active_state[index]
    GUI:Image_loadTexture(self.ui.state_img, img_path..id..".png")
    if id == 1 then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.enter_btn)
        end
    else
        if self.red_width then
            GUI:removeFromParent(self.red_width)
            self.red_width = nil
        end 
    end
    GUI:setPositionY(self.ui.rewardNode, cfg.y)
    GUI:removeAllChildren(self.ui.rewardNode)
    if self.ui._enter_txt then
        GUI:removeFromParent(self.ui._enter_txt)
        self.ui._enter_txt = nil
    end

    -- reward item
    local item_width = 65
    local reward = cfg.reward
    local count =  #reward
    for i = 1, count, 1 do
        local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", reward[i])
        local setData  = {}
        setData.index = item_id               -- 物品Index
        setData.look  = true                  -- 是否显示tips
        setData.bgVisible = true              -- 是否显示背景框
        setData.count = 1                     -- 物品数量
        local item = GUI:ItemShow_Create(self.ui.rewardNode, "reward_item"..i, 0, 0, setData)
        GUI:setAnchorPoint(item, 0.5, 0.5)
        local x = (item_width - (i - count / 2) * item_width - 30) * -1
        GUI:setPosition(item, x, 0)
    end

    self.ui._enter_txt = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "_enter_txt", 490, 35, cfg.enterValue, 600, 18, "#ffffff")
    GUI:setAnchorPoint(self.ui._enter_txt, 0.5, 0)
    GUI:setVisible(self.ui.kb_die_num, index == 8)
end
function GameActivityOBJ:flushRed(is_show_red,index)
    if self.red_width_list[index] then
        GUI:removeFromParent(self.red_width_list[index])
        self.red_width_list[index] = nil
    end 
    if is_show_red then
        if self.red_width_list[index] == nil then
            self.red_width_list[index] = SL:CreateRedPoint(self.ui["Button_"..index],{x= 105,y = 10})
        end
    end
end

function GameActivityOBJ:onClose()
    for k,v in pairs(self.red_width_list) do
        if v then
            GUI:removeFromParent(v)
        end
    end
    self.red_width_list = {}
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end
end

return GameActivityOBJ