local SkillMasterNpc = {}
SkillMasterNpc.cfg = include("QuestDiary/config/skillMasterCfg.lua")

function SkillMasterNpc:click(actor, npc_id)
    local tmp_tab = {}
    for i = 1, 12 do
        local value = VarApi.getPlayerUIntVar(actor, "T_skill_master_"..i)
        tmp_tab[i] = value
    end
    lualib:ShowNpcUi(actor, "SkillMasterOBJ", tbl2json(tmp_tab))
end

function SkillMasterNpc:onClickUpBtn(actor, index)
    local _index = tonumber(index)
    local level = VarApi.getPlayerUIntVar(actor, "T_skill_master_".._index)
    local skill_list = self:getSkillData(actor)
    local skill_id = skill_list[_index]
    if level >= 5 then
        return Sendmsg9(actor, "ffffff", "强化等级已达到5级", 1)
    end
    level = level + 1
    if _index % 4 == 0 then
        local is_continue = true
        for i = _index - 1, _index - 3, -1 do
            local _v = VarApi.getPlayerUIntVar(actor, "T_skill_master_"..i)
            if _v < level then
                is_continue = false
            end
        end
        if not is_continue then
            return Sendmsg9(actor, "ffffff", "请将三个前置技能强化到"..level.."级后再来尝试!", 1)
        end
        if nil == getskillinfo(actor, skill_id) then
            return Sendmsg9(actor, "ffffff", "你还没学习该技能!", 1)
        end
    end
    local need_sy = self.cfg.needitem_sy[level]
    local need_jgs = self.cfg.needitem_jgs[level]
    local sy_value = getbagitemcount(actor, "书页", 0)
    if sy_value < need_sy then
        return Sendmsg9(actor, "ffffff", "书页不足", 1)
    end
    local jgs_value = getbindmoney(actor, "金刚石")
    if jgs_value < need_jgs then
        return Sendmsg9(actor, "ffffff", "金刚石/绑定金刚石不足", 1)
    end
    if not takeitem(actor, "书页", need_sy) then
        return Sendmsg9(actor,"ff0000"," 扣除失败!", 1)
    end
    if not consumebindmoney(actor, "金刚石", need_jgs, "技能强化金刚石扣除") then
        return Sendmsg9(actor,"ff0000","扣除失败!", 1)
    end

    local skill_name = getskillname(skill_id)
    if _index % 4 == 0 then
        local _tab = strsplit(self.cfg.attribute_pow, "#")
        local value = _tab[level]
        setskillinfo(actor, skill_id, 2, level)
        setmagicpower(actor, skill_name, value, 1)
        if skill_id == 26 and level == 5 then
            addbuff(actor, 50033)
        end      
    else
        local _tab = strsplit(self.cfg.attribute_def, "#")
        local value = _tab[level]
        setmagicdefpower(actor, skill_name, value, 1)
    end
    VarApi.setPlayerUIntVar(actor, "T_skill_master_".._index, level, false)
    lualib:FlushNpcUi(actor, "SkillMasterOBJ", index.."#"..level)

    if level == 5 and _index % 4 == 0 then
        local v = LoginTrigger.skill_effect_cfg[skill_id]
        if v then
            setmagicskillefft(actor, v[1], v[2], v[3])
        end
    end
    Sendmsg9(actor, "ffffff", "强化成功!", 1)
end

function SkillMasterNpc:getSkillData(actor)
    local job = getbaseinfo(actor, 7)
    local tmp_list = {}
    for i = 1, 3 do
        local skill_ids = strsplit(self.cfg[i].skillid_def, "#")
        skill_ids[#skill_ids + 1] = self.cfg[i].skillid_pow[job + 1]
        for k, v in pairs(skill_ids) do
            tmp_list[#tmp_list + 1] = tonumber(v)
        end
    end
    return tmp_list
end

return SkillMasterNpc