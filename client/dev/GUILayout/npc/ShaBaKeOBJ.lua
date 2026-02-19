local ShaBaKeOBJ = {}
ShaBaKeOBJ.Name = "ShaBaKeOBJ"
ShaBaKeOBJ.NPC = 126
ShaBaKeOBJ.RunAction = true

function ShaBaKeOBJ:main(state, point)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ShaBaKeUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_state = tonumber(state)
    self.cur_point = tonumber(point) or 0

    self:initClickEvent()
    self:updateUI()
end

function ShaBaKeOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(ShaBaKeOBJ.Name)
    end)

    for i = 1, 4 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function ()
            SendMsgCallFunByNpc(ShaBaKeOBJ.NPC, "ShaBaKeNpc", "onClickMapMove", i)
        end)
    end

    GUI:addOnClickEvent(self.ui.getReward, function ()
        SendMsgCallFunByNpc(ShaBaKeOBJ.NPC, "ShaBaKeNpc", "onClickGetReward", "")
    end)    
end

function ShaBaKeOBJ:updateUI()
    local icon = "res/custom/tag/0-0.png"
    if self.cur_state == 1 then
        icon = "res/custom/tag/0-1.png"
    elseif self.cur_state == 2 then
        icon = "res/custom/tag/0-2.png"
    end
    GUI:Image_loadTexture(self.ui.tagImg, icon)

    local guild_info = SL:GetMetaValue("GUILD_INFO")
    local _name = guild_info.guildName
    if "" == _name then
        _name = "暂无"
    end
    GUI:Text_setString(self.ui.guild_txt, _name)
    GUI:Text_setString(self.ui.point_txt, self.cur_point)
end

function ShaBaKeOBJ:flushView(index, level)

end

local function onClickNpc(npc_info)
    if npc_info.index == ShaBaKeOBJ.NPC then
        SendMsgClickNpc(ShaBaKeOBJ.NPC.."#ShaBaKeNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ShaBaKeOBJ", onClickNpc)

return ShaBaKeOBJ