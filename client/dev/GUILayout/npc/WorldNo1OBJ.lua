local WorldNo1OBJ = {}
WorldNo1OBJ.Name = "WorldNo1OBJ"
WorldNo1OBJ.NPC = 111
WorldNo1OBJ.RunAction = true

function WorldNo1OBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WorldNo1UI", function () end)
    self.ui = GUI:ui_delegate(parent)

    if sMsg then
        sMsg = SL:JsonDecode(sMsg)
    else
        sMsg = {}
    end
    self.view_info = sMsg

    self:initClickEvent()
    self:showRankInfo()
end

function WorldNo1OBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.GotoBtn, function ()
        SendMsgCallFunByNpc(WorldNo1OBJ.NPC, "WorldNo1Npc", "onClickGoToBtn", "")
    end)

    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["look_btn"..i], function ()
            local v = self.view_info[(i - 1)..""]
            if nil == v  then
                return
            end
            SendMsgCallFunByNpc(WorldNo1OBJ.NPC, "WorldNo1Npc", "onClickLookBtn", v.roleId)
        end)
    end

    GUI:addOnClickEvent(self.ui.No1_zhan, function ()
        SL:OpenItemTips({typeId = 10267, pos = {x = 170, y = 70}})
    end)
    GUI:addOnClickEvent(self.ui.No1_fa, function ()
        SL:OpenItemTips({typeId = 10268, pos = {x = 280, y = 70}})
    end)
    GUI:addOnClickEvent(self.ui.No1_dao, function ()
        SL:OpenItemTips({typeId = 10269, pos = {x = 380, y = 70}})
    end)
end

local pos = {
    [0] = {x = 200, y = 245},
    [1] = {x = 445, y = 245},
    [2] = {x = 685, y = 245}
}
function WorldNo1OBJ:createUIModel(info, type)
    info = info or {}
    local p = pos[type]
    GUI:UIModel_Create(self.ui.FrameLayout, "model_"..type, p.x, p.y, tonumber(info.sex) or 0, info, nil, true, type)
end

function WorldNo1OBJ:showRankInfo()
    local job_title = {[0] = "战:  ", [1] = "法:  ", [2] = "道:  "}
    for i = 0, 2 do
        local v = self.view_info[i..""]
        if v then
            GUI:Text_setString(self.ui["name_txt"..(i+1)], "天下第一" .. job_title[i] .. v.up_name)
            GUI:Text_setString(self.ui["tip_txt"..(i+1)], "申请等级:   " .. v.up_level .. "级")

            v.clothID = tonumber(v.clothID)
            v.clothEffectID = tonumber(v.clothEffectID)
            v.weaponID = tonumber(v.weaponID)
            v.weaponEffectID = tonumber(v.weaponEffectID)
            v.headID = tonumber(v.headID)
            v.headEffectID = tonumber(v.headEffectID)
            v.capID = tonumber(v.capID)
            v.capEffectID = tonumber(v.capEffectID)
            v.shieldID = tonumber(v.shieldID)
            v.shieldEffectID = tonumber(v.shieldEffectID)
        end
        self:createUIModel(v, i)
    end
end

local function onClickNpc(npc_info)
    if npc_info.index == WorldNo1OBJ.NPC then
        SendMsgClickNpc(WorldNo1OBJ.NPC .. "#" .. "WorldNo1Npc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "WorldNo1OBJ", onClickNpc)
return WorldNo1OBJ