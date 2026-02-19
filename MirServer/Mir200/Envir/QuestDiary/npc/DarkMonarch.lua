local DarkMonarch = {}
DarkMonarch.cfg = include("QuestDiary/config/DarkMonarchCfg.lua")
function DarkMonarch:upEvent(actor)
    local active_flag = json2tbl(VarApi.getPlayerTStrVar(actor, "T_ahls_active_flag")) 
    if active_flag == "" then
        active_flag = {}
    end
    lualib:ShowNpcUi(actor,"DarkMonarchOBJ",tbl2json(active_flag))
end
function DarkMonarch:JieFengClick(actor,index)
    local active_flag = json2tbl(VarApi.getPlayerTStrVar(actor, "T_ahls_active_flag")) 
    if DarkMonarch:GetIsActive(index,active_flag) then
        return  Sendmsg9(actor, "ffffff", "ÄãÒÑ½â·â¹ý´ËÉñÆ÷", 1) 
    end

    local cfg = DarkMonarch.cfg[tonumber(index)]
    for k, v in pairs(cfg.nedd_map) do
        if getbagitemcount(actor,k) < tonumber(v) then
           return  Sendmsg9(actor, "ffffff", k.."ÊýÁ¿²»×ã", 1) 
        end
    end

    for k, v in pairs(cfg.nedd_map) do
        if not takeitemex(actor,k,v,0,"°µºÚµÛÍõ¿Û³ý")  then
           return  Sendmsg9(actor, "ffffff", k.."¿Û³ýÊ§°Ü", 1) 
        end
    end
    if active_flag == "" then
        active_flag = {}
    end
    
    if giveonitem(actor,cfg.location,cfg.Name,1,307,"°µºÚµÛÍõ¶Ò»»")then
        table.insert(active_flag,index) 
        local str =  "°µºÚµÛÍõ:¹§Ï²<¡¸%s¡¹/FCOLOR=251>³É¹¦½â·â£º<¡¸%s¡¹/FCOLOR=251>!"
        local player_name = getbaseinfo(actor,1)
        Sendmsg13(actor,255, string.format(str,player_name,cfg.Name) ,2,13)
        VarApi.setPlayerTStrVar(actor, "T_ahls_active_flag",tbl2json(active_flag))
        lualib:FlushNpcUi(actor,"DarkMonarchOBJ",tbl2json(active_flag).."#"..index)
    end
end

function DarkMonarch:GetIsActive(index,list)
    if list == "" then
        return false
    end

    for i,v in ipairs(list) do
        if tonumber(v) == tonumber(index)  then
           return true 
        end
    end
    return false
end
return DarkMonarch