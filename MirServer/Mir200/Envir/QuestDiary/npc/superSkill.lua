local superSkill = {}

function superSkill:skill(actor,...)
    local param = {...}
    local skill = {"十步一杀","冰霜群雨","死亡之眼",}
    local type = tonumber(getbaseinfo(actor,7)) --#region 职业
    local level = tonumber(getbaseinfo(actor,6)) --#region 等级
    if level < 70 then
        return Sendmsg9(actor, "ff0000", "请先将角色提升至70级后再来领取超级技能"..skill[type+1].."！", 1)
    elseif VarApi.getPlayerUIntVar(actor, "l_superSkill") > 0 then
        return Sendmsg9(actor, "ff0000", "当前超级技能"..skill[type+1].."已学习过！", 1)
    end

    VarApi.setPlayerUIntVar(actor, "l_superSkill", 1, true)
    sendmail(getbaseinfo(actor,2),1,"超级技能","【"..skill[type+1].."】超级技能学习书已发送，请查收您的邮件。",skill[type+1].."#1#307")
    Sendmsg9(actor, "ff0000", "恭喜您成功获得"..skill[type+1].."技能书,请前往邮箱查看吧！", 1)
    sendmsgnew(actor,255,255,"超级技能ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>提升至70级，并获得<"
    ..skill[type+1].."/FCOLOR=245>超级技能，获得强力属性提升！",1,10)
end

return superSkill