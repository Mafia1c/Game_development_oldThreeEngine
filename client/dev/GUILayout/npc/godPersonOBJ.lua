local godPersonOBJ = {}

godPersonOBJ.Name = "godPersonOBJ"
godPersonOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
godPersonOBJ.cfg = {
    [1] = { ["title"]="圣灵道人·三生", ["lastTitle"]="至尊天人", ["effect"]=46144, ["level"]=18, ["need_config"]={{"声望",200000},{"金刚石",2000000},}, },
    [2] = { ["title"]="圣灵道人·六道", ["lastTitle"]="圣灵道人·三生", ["effect"]=46145, ["level"]=20, ["need_config"]={{"声望",200000},{"金刚石",2000000},}, },
    [3] = { ["title"]="圣灵道人·九天", ["lastTitle"]="圣灵道人·六道", ["effect"]=46146, ["level"]=22, ["need_config"]={{"声望",200000},{"金刚石",2000000},}, },
    [4] = { ["title"]="圣灵道人·化神", ["lastTitle"]="圣灵道人·九天", ["effect"]=46147, ["level"]=25, ["need_config"]={{"灵符",100000},{"金刚石",2000000},}, },
}
godPersonOBJ.npcId = 386

function godPersonOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/godPersonUI")
    self.ui = GUI:ui_delegate(parent)
    GUI:Timeline_Window4(self.ui.FrameLayout)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("godPersonOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("godPersonOBJ")
    end)
    --给服务端发消息
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.npcId, "godPerson", "upEvent", "")
    end)
    self:refreshInfo()
end

function godPersonOBJ:refreshInfo()
    local layer = tonumber(GameData.GetData("UL_godPerson",false)) or 0
    if layer ~= #self.cfg then
        layer = layer+1
    end
    GUI:Image_loadTexture(self.ui.leftImg,"res/custom/npc/88sl/leftBg"..layer..".png")
    removeOBJ(self.ui.effectLv,self)
    local is_show_red = true
    GUI:Effect_Create(self.ui.leftNode,"effectLv",88,478,0,self.cfg[layer]["effect"])
    local infoTab = self.cfg[layer]["need_config"]
    local itemColor = 249
    if tonumber(SL:GetMetaValue("MONEY", SL:GetMetaValue("ITEM_INDEX_BY_NAME", infoTab[1][1]))) >= infoTab[1][2] then
        itemColor = 250
    else
        is_show_red = false
    end
    GUI:ItemShow_updateItem(self.ui["item_1"],
    {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", infoTab[1][1]),count=infoTab[1][2], color=itemColor,look=true,bgVisible=true})
    itemColor = 249
    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", infoTab[2][1]))) >= infoTab[2][2] then
        itemColor = 250
    else
        is_show_red = false
    end
    GUI:ItemShow_updateItem(self.ui["item_2"],
    {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", infoTab[2][1]),count=infoTab[2][2], color=itemColor,look=true,bgVisible=true})

    GUI:ItemShow_updateItem(self.ui["item_3"],
    {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", self.cfg[layer]["title"]),look=true,bgVisible=true})
    GUI:Text_setString(self.ui.needText,"需要："..self.cfg[layer]["lastTitle"].."境界+"..self.cfg[layer]["level"].."转")
    if layer == self.cfg then
        GUI:setVisible(self.ui.needText, false)
        GUI:setVisible(self.ui["item_3"],false)
    end
    GUI:setVisible(self.ui.upBtn,tonumber(GameData.GetData("UL_godPerson",false)) ~= #self.cfg)
    GUI:setVisible(self.ui.activeImg,tonumber(GameData.GetData("UL_godPerson",false)) == #self.cfg)

    if SL:GetMetaValue("RELEVEL") < self.cfg[layer]["level"]  then
        is_show_red = false
    end
    if (tonumber(GameData.GetData("UL_godPerson",false)) or 0) == 0 and SL:GetMetaValue("TITLE_DATA_BY_ID", 10443) == nil then
        is_show_red = false
    end
    self:flushRed(is_show_red)
end

--#region 后端消息刷新ui
function godPersonOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["item_"..tab[2]], 5,20)
        end,
        ["提升"] = function ()
            self:refreshInfo()
        end,
    }
    functionTab[tab[1]]()
end

function godPersonOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.upBtn)
        end
    end
end

--#region 关闭前回调
function godPersonOBJ:onClose(...)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == godPersonOBJ.npcId then
        SendMsgClickNpc(godPersonOBJ.npcId .. "#godPerson")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, godPersonOBJ.Name, onClickNpc)

return godPersonOBJ