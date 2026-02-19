local DeathRevive = {}

function DeathRevive:onClickReviveBtn(actor, sMsg)
    if sMsg == "0" then
        mapmove(actor, 3, 330, 330, 1)
    else
        if not consumebindmoney(actor, "灵符", 50) then
            return Sendmsg9(actor, "ffffff", "灵符不足！", 1)
        end
        Sendmsg9(actor, "ffffff", "复活成功", 1)
    end
    lualib:CloseNpcUi(actor, "ReviveOBJ")
    realive(actor)
end

local function _onKillPlayer(actor, killer)

    lualib:ShowNpcUi(actor, "ReviveOBJ", getbaseinfo(killer,1))
    return Sendmsg9(actor, "ffffff", "你被干掉了~", 1)
end

GameEvent.add("playdie", _onKillPlayer, "DeathRevive")

return DeathRevive