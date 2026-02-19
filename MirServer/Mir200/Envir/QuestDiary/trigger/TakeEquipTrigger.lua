-- 穿脱装备触发
TakeEquipTrigger = {}
TakeEquipTrigger.treasureAwakeCfg = include("QuestDiary/config/treasureAwakeCfg.lua") --#region 觉醒秘宝配置

-- 人物穿戴任意装备后触发(玩家对象,物品对象,装备位置,装备名称,装备唯一id)
function TakeEquipTrigger.onPlayerTakeOnEquip(actor, item, site, itemName, itemUID)
    if site == 12 and itemName == "魔血石·MAX" then
        local is_str = VarApi.getPlayerTStrVar(actor, "T_bloodstone_ids")
        if "" ~= is_str then
            local _tab = json2tbl(is_str)
            for k, v in pairs(_tab) do
                if tonumber(v) == 72 then
                    changelevel(actor, "+", 1)
                end
            end
        end
    elseif TakeEquipTrigger.treasureAwakeCfg[itemName] and getitemaddvalue(actor,item,2,3) == 12 then --#region 觉醒秘宝12星冰冻buff添加
        VarApi.setPlayerUIntVar(actor, "UL_treasureAwake12", 1, false)
    elseif isInTable({104,105,106,107,108,109,110,111,112,113,114,115},site) then --#region 福装备12个buff添加
        for index, value in ipairs({104,105,106,107,108,109,110,111,112,113,114,115}) do
            if not getiteminfo(actor,linkbodyitem(actor,value),1) then
                return
            elseif index == 12 then
                VarApi.setPlayerUIntVar(actor, "UL_luckEquip", 1, false)
                return
            end
        end
    elseif  site == 44 and itemName == "「神火罩」" then
        addbuff(actor, 30006,0,1,actor,{[89]=2000}) 
    end
    -- 脱下生肖装备 更新传承生肖buff
    if isInTable({30,31,32,33,34,35,36,37,38,39,40,41}, site) and nil ~= string.find(itemName, "传承") then
        local npc_class = IncludeNpcClass("compoundAnimal")
        if npc_class then
            npc_class:updateZodiacBuff(actor)
        end
    end
    -- 穿灵装装备 更新buff
    if isInTable({20,22,23,27,26,24,25,28}, site) then
        local npc_class = IncludeNpcClass("LingZhuangStrengthen")
        if npc_class then
            npc_class:flushSuitAttr(actor)
        end
    end
end

-- 人物脱下任意装备后触发(玩家对象,物品对象,装备位置,装备名称,装备唯一id)
function TakeEquipTrigger.onPlayerTakeOffEquip(actor, item, site, itemName, itemUID)
    if site == 12 and itemName == "魔血石·MAX" then
        local is_str = VarApi.getPlayerTStrVar(actor, "T_bloodstone_ids")
        if "" ~= is_str then
            local _tab = json2tbl(is_str)
            for k, v in pairs(_tab) do
                if tonumber(v) == 72 then
                    changelevel(actor, "-", 1)
                end
            end
        end
    elseif TakeEquipTrigger.treasureAwakeCfg[itemName] then --#region 觉醒秘宝12星冰冻buff移除
        VarApi.setPlayerUIntVar(actor, "UL_treasureAwake12", 0, false)
        return
    elseif isInTable({104,105,106,107,108,109,110,111,112,113,114,115},site) then --#region 福装备12个buff移除
        VarApi.setPlayerUIntVar(actor, "UL_luckEquip", 0, false)
        return
    elseif  site == 44 and itemName == "「神火罩」" then
        delbuff(actor,30006)
    end
    -- 脱下生肖装备 更新传承生肖buff
    if isInTable({30,31,32,33,34,35,36,37,38,39,40,41}, site) and nil ~= string.find(itemName, "传承") then
        local npc_class = IncludeNpcClass("compoundAnimal")
        if npc_class then
            npc_class:updateZodiacBuff(actor)
        end
    end
     -- 脱下灵装装备 更新buff
    if isInTable({20,22,23,27,26,24,25,28}, site) then
        local npc_class = IncludeNpcClass("LingZhuangStrengthen")
        if npc_class then
            npc_class:flushSuitAttr(actor)
        end
    end
end

-- 人物脱下任意装备前触发(玩家对象，物品对象，装备位置，装备唯一id)return是否允许操作
function TakeEquipTrigger.onPlayerBeforeexEquip(actor, item, site, itemUID)
    local itemName = getiteminfo(actor, item, 7)
    if isInTable({87,88,89,90,91,92,93,94}, site) and isInTable({"神龙脊", "飞龙皮", "暗龙角", "天龙眼", "邪龙爪", "苍龙骨", "炎龙羽", "恶龙鳞"}, itemName) then
        Sendmsg9(actor, "ffffff", "这个装备不能脱!", 1)
        return false
    end
    if 17 == site then --#region 时装禁止脱
        Sendmsg9(actor, "ff0000", "当前装备禁止脱下！", 1)
        return false
    end

    return true
end
