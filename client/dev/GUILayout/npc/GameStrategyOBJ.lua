--=====================游戏攻略
local GameStrategyOBJ = {}
GameStrategyOBJ.Name = "GameStrategyOBJ"
GameStrategyOBJ.RunAction = true
GameStrategyOBJ.cfg = SL:Require("GUILayout/config/zsmbcfg",true)
local bg_list = {
    "res/custom/npc/19gl/bg1.png",
    "res/custom/npc/19gl/bg3.png",
    "res/custom/npc/19gl/bg4.png"
}
local img_list = {
    "res/custom/npc/19gl/banbenjs.png",
    "res/custom/npc/19gl/kuaisushengji.png",
    "res/custom/npc/19gl/qihaotuij.png"
}

local min_height = 435
function GameStrategyOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent

    GUI:LoadExport(parent, "npc/GameStrategyUI", function () end)

    self.ui = GUI:ui_delegate(parent)

    self:updateViewInfo(1)
    self:initClickEvent()
end

function GameStrategyOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    for i = 1, 5 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            self:updateViewInfo(i)
        end)
    end
end

function GameStrategyOBJ:updateViewInfo(index)
    GUI:setVisible(self.ui.info_list,index ~= 4) 
    GUI:setVisible(self.ui.tujian_list,index == 4) 
    if index == 4 then
        self:SetMiBaoTj()
    elseif index == 5 then
        ViewMgr.close("GameStrategyOBJ")
        ViewMgr.open("PreviewOccupationOBJ")
        return 
    else
        GUI:Image_loadTexture(self.ui.bg_Image, bg_list[index])
        GUI:Image_loadTexture(self.ui.img_value, img_list[index])
        local height = GUI:getContentSize(self.ui.img_value).height
        if height < min_height then
            height = min_height
        end
        GUI:ScrollView_setInnerContainerSize(self.ui.info_list, 590, height)
        GUI:setPositionY(self.ui.img_value, height)
        GUI:ScrollView_scrollToTop(self.ui.info_list, 0.1, true)
        GUI:setTouchEnabled(self.ui.info_list, height > min_height)
    end
    for i = 1, 5 do
        GUI:setVisible(self.ui["Image_"..i], index == i)
    end
end

function GameStrategyOBJ:SetMiBaoTj()
    local list_index = 1
    GUI:removeAllChildren(self.ui.tujian_list)
    self.ui = GUI:ui_delegate(self._parent)
    for i=1,math.ceil(#GameStrategyOBJ.cfg / 4) do
        local list = GUI:ListView_Create(self.ui.tujian_list,"listView"..i, 0, 0, 603, 169, 2)
        GUI:ListView_setGravity(list, 2)
        GUI:ListView_setItemsMargin(list, 23)
        GUI:setTouchEnabled(list, false)
    end 
    for i,v in ipairs(GameStrategyOBJ.cfg) do
        local cellObj = GUI:Image_Create(self.ui["listView"..list_index],"cell_img"..v.key_name, 100, 0, "res/custom/npc/07zsmb/rq.png")
        local item = GUI:ItemShow_Create(cellObj, "cell_item"..i,65, 93,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v.name),bgVisible = false,look = true})
        GUI:setAnchorPoint(item,0.5,0.5) 
        local text = GUI:Text_Create(cellObj, "name_text"..i, 18, 0, 16, "#ffffff",v.name)
        SL:SetColorStyle(text, v.color)
        GUI:Text_setTextAreaSize(text,100, 150)
        GUI:Text_setTextHorizontalAlignment(text, 1)
        if i % 4 == 0 then
            list_index = list_index + 1
        end
    end
end

return GameStrategyOBJ