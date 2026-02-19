local MapTransmissionObj = {}
MapTransmissionObj.Name = "MapTransmissionObj"
MapTransmissionObj.RunAction = true
--[[
    {60,91,92},{其他}               --　已完成待测试
    {257-262},{371-376},            --　缺资源
]]

function MapTransmissionObj:main(id)
    id = tonumber(id)
    local ui_path = "npc/GoToMap1UI"

    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent

    GUI:LoadExport(parent, ui_path, function () end)

    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()

    GUI:setContentSize(self.ui["Scene"], SL:GetMetaValue("SCREEN_WIDTH"), SL:GetMetaValue("SCREEN_HEIGHT"))
end

function MapTransmissionObj:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    local map_names = {
        ["map_tc"] = {"3",330,331,1},
        ["map_zy"] = {"zhuangyuan", 85, 93, 1},
        ["map_mlc"] = {"魔龙城", 122, 155, 1},
        ["map_bqcb"] = {"0", 331, 268, 1},
        ["map_fmsg"] = {"4", 237, 199, 1},
        ["map_yjzm"] = {"异界次元", 82, 81, 1},
        ["map_brm"] = {"11",181, 320, 1},
        ["map_cyd"] = {"苍月岛", 140, 334, 1}
    }
    for k, v in pairs(map_names) do
        GUI:addOnClickEvent(self.ui[k], function()
            SendMsgCallFunByNpc(1, "GoToMapNpc", "GotoMap2", k)
            ViewMgr.close(MapTransmissionObj.Name)
        end)
    end
end

function MapTransmissionObj:flushView(...)
    local tab = {...}

end

-- 点击npc触发
local function onClickNpc(npc_info)
    if npc_info.index == 1 then
        ViewMgr.open(MapTransmissionObj.Name)
    end
    if npc_info.index == 325 then
        SendMsgCallFunByNpc(1, "GoToMapNpc", "GotoMap2", "卧龙山庄")
    end

    if npc_info.index == 264 then
        SendMsgCallFunByNpc(1, "GoToMapNpc", "GotoMap2", "map_fmsg")
    end

    if npc_info.index == 307 then
        SendMsgCallFunByNpc(1, "GoToMapNpc", "GotoMap2", "map_cyd")
    end
    if isInTable({301,302,303,304,305}, npc_info.index) then
        local id = npc_info.index - 299
        -- SendMsgCallFunByNpc(npc_info.index, "GoToMapNpc", "GotoMap6", "暗黑之城"..id)
        ViewMgr.open("AHZCExtendOBJ", npc_info.index, "暗黑之城"..id)
    end
    if npc_info.index == 48 then
        SendMsgCallFunByNpc(1, "GoToMapNpc", "GotoMap7", "mryj2")
    end
    if npc_info.index == 345 then
        SendMsgCallFunByNpc(1, "GoToMapNpc", "GotoMap7", "mryj2_jx")
    end
    if npc_info.index == 59 then
        SendMsgCallFunByNpc(1, "GoToMapNpc", "GotoMap7", "zs_hlxg2")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MapTransmissionObj", onClickNpc)

return MapTransmissionObj