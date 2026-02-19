local GreatMasterAwake = {}
GreatMasterAwake.cfg = include("QuestDiary/config/GreatMasterAwakeCfg.lua")
function GreatMasterAwake:upEvent(actor,param)
    -- local temp_odds = VarApi.getPlayerUIntVar(actor,"U_zsjx_odds")
    lualib:ShowNpcUi(actor,"GreatMasterAwakeOBJ","init_flush")
end
function GreatMasterAwake:OnClickJueXing(actor,key_name)
    key_name = tonumber(key_name) 
    local cfg = GreatMasterAwake.cfg[key_name]
    for k, v in pairs(cfg.need_map) do
        local stdmode =  getstditeminfo(k,2)
        local count = 0
        if stdmode == 41 then
            count = getbindmoney(actor,k)
        else
            count = getbagitemcount(actor,k)
        end
        if count < v  then
            return Sendmsg9(actor, "ffffff",  k.."ÊýÁ¿²»×ã", 1) 
        end
    end
    local temp_odds = VarApi.getPlayerUIntVar(actor,"U_zsjx_odds"..key_name)
    local name_tab = {["ÁúÖ®ÐÄ"] = 1,["½ð¸ÕÊ¯"] = 2,["ÁúÖ®Ñª"] = 3}
    local odds = cfg.probability + temp_odds
    local odds_nuber = math.random(1,101)
    local is_sure = odds_nuber <= odds
    for k, v in pairs(cfg.need_map) do
        local stdmode =  getstditeminfo(k,2)
        local count = 0
        if stdmode == 41 then
            if not consumebindmoney(actor,k,v,"×ÚÊ¦¾õÐÑ¿Û³ý") then
                return Sendmsg9(actor, "ffffff",  k.."¿Û³ýÊ§°Ü", 1) 
            end
        else      
            if is_sure then
                if not takeitem(actor,k,v,0,"×ÚÊ¦¾õÐÑ") then
                    return Sendmsg9(actor, "ffffff",  k.."¿Û³ýÊ§°Ü", 1) 
                end
            else
                if name_tab[k] ~= nil then
                    if not takeitem(actor,k,v,0,"×ÚÊ¦¾õÐÑ") then
                        return Sendmsg9(actor, "ffffff",  k.."¿Û³ýÊ§°Ü", 1) 
                    end
                end   
            end
        end
    end
    if is_sure == false then
        if temp_odds < 10 then
            temp_odds = temp_odds + 1
        end
        VarApi.setPlayerUIntVar(actor,"U_zsjx_odds"..key_name,temp_odds,true)
        Sendmsg9(actor, "ffffff",  "¾õÐÑÊ§°Ü£¡", 1) 
    else
        if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) >= 68 then
            giveitem(actor,cfg.name,1)
        else
            giveitem(actor,cfg.name,1,307)
        end
        
        temp_odds = 0
        VarApi.setPlayerUIntVar(actor,"U_zsjx_odds"..key_name,temp_odds,true)
        local player_name = getbaseinfo(actor,1)
        local str =  "×ÚÊ¦¾õÐÑ:¹§Ï²<¡¸%s¡¹/FCOLOR=251>³É¹¦¾õÐÑ×°±¸<¡¸%s¡¹/FCOLOR=251>!"
        Sendmsg13(actor,255, string.format(str,player_name,cfg.name) ,2,13)
    end
    lualib:FlushNpcUi(actor,"GreatMasterAwakeOBJ","jx_flush|"..key_name)
end

return GreatMasterAwake