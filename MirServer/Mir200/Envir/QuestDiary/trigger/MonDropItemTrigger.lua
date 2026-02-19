MonDropItemTrigger = {}
local temp_cfg = include("QuestDiary/config/FirstDropEquipCfg.lua")
local _cfg = {}
for i,v in ipairs(temp_cfg) do
   _cfg[v.equip_name] = _cfg[v.equip_name] or {}
    table.insert(_cfg[v.equip_name],v) 
end
MonDropItemTrigger.frist_equip_cfg = _cfg
local activity_map = {
    "dt091",
    "xdt129_7",
    "µ€Õı±¶≤ÿ",
    "xdt158",
    "guanka",
    "dt138",
    "dt097",
    "dyx01",
    "dt068",
    "dt079",
    "dt062",
    "hd_hhzb",
    "hd_kbzb"
}
function MonDropItemTrigger.mondropitemex(actor, item, monster, itemX, itemY)
    local name = getiteminfo(actor, item,7)
    if MonDropItemTrigger.frist_equip_cfg[name] then
        local frist_equip_flag = json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP)) 
        if frist_equip_flag == "" then
            frist_equip_flag = {}
        end
        if frist_equip_flag[name] == nil then
            local map = getbaseinfo(monster,3)
            if activity_map[map] == nil then
                local data = {}
                data.source = 5
                data.map = map
                data.player = getbaseinfo(actor,1)
                setthrowitemly2(actor,item,tbl2json(data))
            end
        end
    end
end