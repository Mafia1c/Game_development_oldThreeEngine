ClickNpcTrigger = {}

local function IsWhitePlayer(actor)
    if getgmlevel(actor) < 10 then
        sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>GM权限不足</font>","Type":9}')
        return true
    end
    local account_id = getconst(actor, "<$USERACCOUNT>")
    if not isInTable(VarGmWhitePlayer, account_id) then
        lualibgm:sendmsg(actor, "不是管理员！")
        return true
    end
end
--#region npc点击触发(玩家对象,npc索引id,npc文本路径)return true不允许
function ClickNpcTrigger.clicknpc(actor,npcId,sScript)
    if npcId == 900 then --#region 苍月赐福(遗忘禁地)
        map(actor,"遗忘禁地")
    elseif npcId == 901 then --#region 苍月赐福(噩梦之渊)
        map(actor,"噩梦之渊")
    elseif npcId == 239 then --gm
        if IsWhitePlayer(actor) then return true end
        GMBoxMgr.showGMBackend(actor)
    elseif npcId == 242 then --gm
        if IsWhitePlayer(actor) then return true end
        GMBoxMgr.show_gm_gs_end(actor)
    elseif npcId == 124 then
        if IsWhitePlayer(actor) then return true end
        lualib:CallFuncByClient(actor, "GMBoxOBJ")
    elseif npcId == 443 then
        local class =  IncludeNpcClass("PosternOfFateTreasure")
        if class then
            class:ShowDuHuanAward(actor)
        end
    end
    return false --#region 允许点击
end
