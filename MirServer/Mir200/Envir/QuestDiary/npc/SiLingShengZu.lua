local SiLingShengZu = {}
SiLingShengZu.cfg = include("QuestDiary/config/AncientAlienWorldCfg.lua")

function SiLingShengZu:upEvent(actor,...)
    local state = VarApi.getPlayerUIntVar(actor, "T_slsz_title_state")
    lualib:FlushNpcUi(actor,"SiLingShengZuOBJ",state)
end
function SiLingShengZu:ActiveClick(actor)
    if VarApi.getPlayerUIntVar(actor, "T_slsz_title_state") > 0 then
       return Sendmsg9(actor, "ffffff", "已经激活过！" , 1)   
    end
    for i,v in ipairs(SiLingShengZu.cfg) do
        local num =  VarApi.getPlayerUIntVar(actor, "T_ygyj_defeat_num"..v.key_name)
        if num <= v.total_pass_num then
            return Sendmsg9(actor, "ffffff", "激活需要领取[远古异界]全部累计通关奖励！" , 1) 
        end
    end
    if confertitle(actor,"幽冥·死灵圣祖") then
        VarApi.setPlayerUIntVar(actor, "T_slsz_title_state",1)
        lualib:FlushNpcUi(actor,"SiLingShengZuOBJ",1)
    end
end

return SiLingShengZu
