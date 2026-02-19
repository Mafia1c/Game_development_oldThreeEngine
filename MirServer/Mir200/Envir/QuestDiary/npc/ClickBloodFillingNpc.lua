local ClickBloodFillingNpc = {}

function ClickBloodFillingNpc:onClickBloodFilling(actor)
    if not getbaseinfo(actor, 48) then
        Sendmsg9(actor, "ffffff", "仅在安全区使用!", 1)
        return
    end
    local cur_hp = getbaseinfo(actor, 9)
    local max_hp = getbaseinfo(actor, 10)
    local max_mp = getbaseinfo(actor, 12)
    if cur_hp >= max_hp then
        return Sendmsg9(actor, "ffffff", "您的状态无需治疗！", 1)
    else
        humanhp(actor, "=", max_hp, 0)
        humanmp(actor, "=", max_mp)
        return Sendmsg9(actor, "ffffff", "治疗完成,状态已恢复！", 1)
    end
end

return ClickBloodFillingNpc