local WorldNo1Npc = {}

function WorldNo1Npc:click(actor, npc_id, sMsg)
    local list = self:getRankListData()
    for k, v in pairs(list) do
        local _actor = getplayerbyid(v.roleId)
        if not isnotnull(_actor)  then
            v.clothEffectID =0
            v.weaponEffectID =0
            v.headEffectID = 0
            v.capEffectID = 0
            v.shieldEffectID =0
        else
            -- ÒÂ·þ
            local cloth = linkbodyitem(_actor, 0)
            local _id = getiteminfo(_actor, cloth, 2)
            v.clothID = getdbitemfieldvalue(_id, "Looks")
            local sEffect = getdbitemfieldvalue(_id, "sEffect")
            if sEffect and string.find(sEffect, "#") then
                v.clothEffectID = strsplit(sEffect, "#")[1]
            else
                v.clothEffectID = sEffect or 0
            end
            
            -- ÎäÆ÷
            local weapon = linkbodyitem(_actor, 1)
            _id = getiteminfo(_actor, weapon, 2)
            v.weaponID = getdbitemfieldvalue(_id, "Looks")
            sEffect = getdbitemfieldvalue(_id, "sEffect")
            if sEffect and string.find(sEffect, "#") then
                v.weaponEffectID = strsplit(sEffect, "#")[1]
            else
                v.weaponEffectID = sEffect or 0
            end
            
            -- Í·¿ø
            local head = linkbodyitem(_actor, 4)
            _id = getiteminfo(_actor, head, 2)
            v.headID = getdbitemfieldvalue(_id, "Looks")
            sEffect = getdbitemfieldvalue(_id, "sEffect")
            if sEffect and string.find(sEffect, "#") then
                v.headEffectID = strsplit(sEffect, "#")[1]
            else    
                v.headEffectID = sEffect or 0
            end
    
            -- ¶·óÒ
            local cap = linkbodyitem(_actor, 13)
            _id = getiteminfo(_actor, cap, 2)
            v.capID = getdbitemfieldvalue(_id, "Looks")
            sEffect = getdbitemfieldvalue(_id, "sEffect")
            if sEffect and string.find(sEffect, "#") then
                v.capEffectID = strsplit(sEffect, "#")[1]
            else
                v.capEffectID = sEffect or 0
            end
    
            -- ¶ÜÅÆ
            local shield = linkbodyitem(_actor, 16)
            _id = getiteminfo(_actor, shield, 2)
            v.shieldID = getdbitemfieldvalue(_id, "Looks")
            sEffect = getdbitemfieldvalue(_id, "sEffect")
            if sEffect and string.find(sEffect, "#") then
                v.shieldEffectID = strsplit(sEffect, "#")[1]
            else
                v.shieldEffectID = sEffect or 0
            end
        end
    end

    lualib:ShowNpcUi(actor, "WorldNo1OBJ", tbl2json(list))
end

function WorldNo1Npc:onClickGoToBtn(actor)
    local level = getbaseinfo(actor, 6)
    if level >= 45 then
        mapmove(actor, "txzl", 51, 78, 3)
        lualib:CloseNpcUi(actor, "WorldNo1OBJ")
    else
        Sendmsg9(actor, "ffffff", "µÈ¼¶²»×ã!",1)
    end
end

function WorldNo1Npc:onClickLookBtn(actor, role)
    release_print("onClickLookBtn ========== ",role)
    viewplayer(actor, role, 101)
end

function WorldNo1Npc:getRankListData()
    local rank_list = {}
    local str = getsysvar(VarEngine.WorldNo1Rank)
    if nil ~= str and "" ~= str then
        local tab = json2tbl(str)
        for k, v in pairs(tab) do
            rank_list[k] = v
        end
    end
    return rank_list
end

return WorldNo1Npc