local ChangeOccupation = {}
ChangeOccupation.cfg = include("QuestDiary/config/talentCfg.lua")
function ChangeOccupation:upEvent(actor,job)
    if  tonumber(job) == nil then
       return  Sendmsg9(actor, "ffffff",  "转职数据异常", 1) 
    end
    local is_can_change = false
    if getbaseinfo(actor,6) < 60 then
        is_can_change = true
    else
        if querymoney(actor,7) < 588 then
            return Sendmsg9(actor, "ffffff",  "非绑定灵符不足", 1) 
        end
        if changemoney(actor,7,"-",588,"转职扣除",true) then
            is_can_change = true
        end
    end
    if is_can_change then
        local change_job = tonumber(job)
        setbaseinfo(actor,7,change_job)
        delnojobskill(actor)
        LoginTrigger.loginAddSkills(actor)
        VarApi.setPlayerTStrVar(actor, VarStrDef.XMTF,"")
        VarApi.setPlayerTStrVar(actor, "xuemaibuff","")
        VarApi.setPlayerUIntVar(actor, "l_superSkill",0)
        for i = 1, 12 do
            VarApi.setPlayerUIntVar(actor, "T_skill_master_"..i, 0, false)
        end
        for k,v in pairs(self.cfg) do
            if hasbuff(actor,v.buff_id) then
                delbuff(actor,v.buff_id) 
            end
        end
        delaygoto(actor,1000,"change_job_quitgame,"..change_job,0)
    end
end
function change_job_quitgame(actor,change_job)
    lualib:FlushNpcUi(actor,"ChangeOccupationOBJ","quitgame|"..change_job)
end
return ChangeOccupation