local TianMingAwakeningNpc = {}
TianMingAwakeningNpc.cfg = include("QuestDiary/config/TianMingAwakeningCfg.lua")
TianMingAwakeningNpc.mail_content = "恭喜你成功觉醒全套%s根骨\\您的天命根骨觉醒奖励已发放,请查收\\邮箱数据不定时清理,为了保护您的权益,请及时删除邮件!"

function TianMingAwakeningNpc:click(actor, npc_id)
    local root_bone_reward = VarApi.getPlayerUIntVar(actor, "U_root_bone_reward")       -- 判断根骨是否满级
    if root_bone_reward < 6 then
        return Sendmsg9(actor, "ffffff", "请先激活全部天命根骨!", 1)
    end
    local bone_data = {0,0,0,0,0,0,0,0,0,0}
    local bone_str = VarApi.getPlayerTStrVar(actor, "T_tm_awakening")
    if "" == bone_str then
    else
        bone_data = json2tbl(bone_str)
    end
    lualib:ShowNpcUi(actor, "TianMingAwakeningOBJ", tbl2json(bone_data))
end

function TianMingAwakeningNpc:onClickAwakening(actor, index, level)
    index = tonumber(index)
    level = tonumber(level)
    if level >= 3 then
        return Sendmsg9(actor, "ffffff", "天命根骨已全部激活!", 1)
    end
    local cfg_index = level * 10 + index
    local _cfg = self.cfg[cfg_index]
    local is_continue, root_bone = self:checkRootBoneLevel(actor, level + 1)
    if not is_continue then
        return Sendmsg9(actor, "ffffff", "请先觉醒全套根骨!", 1)
    end
    local add_rate = 0
    local is_select = VarApi.getPlayerUIntVar(actor, "T_awakening_checkbox_state")
    if is_select == 1 then
        local xyf_num = getbagitemcount(actor, "幸运符", 0)
        if xyf_num <= 0 then
            openhyperlink(actor, 11, 0)
            return Sendmsg9(actor, "ffffff", "幸运符数量不足, 可在商城购买!", 1)
        end
        add_rate = 10
    end

    local need_data = {}
    need_data[_cfg.needitem1] = _cfg.itemnum1
    need_data[_cfg.needitem2] = _cfg.itemnum2
    need_data[_cfg.needitem3] = _cfg.itemnum3
    if is_select == 1 then
        need_data["幸运符"] = 1
    end
    for k, v in pairs(need_data) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."不足" , 1)
        end
    end
    for k, v in pairs(need_data) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v, "天命根骨扣除!") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."天命根骨扣除!") then
                return Sendmsg9(actor,  "ffffff", k.."扣除失败" , 1)
            end
        end
    end
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    local gs_odds = 0
    if type(list) == "table" and list[account_id] then
        gs_odds = list[account_id]["tm2_bodds"] or 0
    end
    local success = _cfg.success + add_rate + gs_odds
    local v = math.random(1, 100)
    if v > success then
        return Sendmsg9(actor, "ffffff", "很遗憾本次觉醒失败!", 1)
    end
    root_bone[index] = level + 1
    local str_json = tbl2json(root_bone)
    VarApi.setPlayerTStrVar(actor, "T_tm_awakening", str_json)
    lualib:FlushNpcUi(actor, "TianMingAwakeningOBJ", str_json)
    self:checkBoneReward(actor, root_bone)
    if hasbuff(actor, 10000) then
        -- local buff_overLap = getbuffinfo(actor, 10000, 1)
        buffstack(actor, 10000, "+", 1, 0)
    else
        addbuff(actor, 10000, 0, 1, actor, {[89] = 200})
    end
    return Sendmsg9(actor, "ffffff", _cfg.btnName.."根骨觉醒成功", 1)
end

function TianMingAwakeningNpc:onChangeSelectedState(actor, is_select)
    is_select = tonumber(is_select)
    if is_select == 1 then
        local xyf_num = getbagitemcount(actor, "幸运符", 0)
        if xyf_num <= 0 then
            is_select = 0
            openhyperlink(actor, 11, 0)
            Sendmsg9(actor, "ffffff", "幸运符数量不足, 可在商城购买!", 1)
            lualib:FlushNpcUi(actor, "TianMingAwakeningOBJ", 0)
        else
            Sendmsg9(actor, "ffffff", "勾选幸运符成功!", 1)
        end
    else
        Sendmsg9(actor, "ffffff", "取消幸运符勾选!", 1)
    end
    VarApi.setPlayerUIntVar(actor, "T_awakening_checkbox_state", is_select)
end

function TianMingAwakeningNpc:checkRootBoneLevel(actor, next_level)
    local bone_str = VarApi.getPlayerTStrVar(actor, "T_tm_awakening")
    local tmp_map = {0,0,0,0,0,0,0,0,0,0}
    if "" ~= bone_str then
        tmp_map = json2tbl(bone_str)
    end
    for k, v in pairs(tmp_map) do
        if next_level - tonumber(v) > 1 then
            return false, tmp_map
        end
    end
    return true, tmp_map
end

function TianMingAwakeningNpc:checkBoneReward(actor, bone_data)
    local reward_level = 4
    for k, v in pairs(bone_data) do
        if reward_level > tonumber(v) then
            reward_level = tonumber(v)
        end
    end
    local reward_id = VarApi.getPlayerUIntVar(actor, "U_tm_awakening_reward")
    local reward = self.cfg.reward[reward_level]
    if reward and reward_id < reward_level then
        local name = string.sub(reward[1], 1, 4)
        local content = string.format(self.mail_content, name)
        sendmail(getbaseinfo(actor, 2), 1, "天命根骨", content, reward[1].."#1")
        VarApi.setPlayerUIntVar(actor, "U_tm_awakening_reward", reward_level)
        messagebox(actor, "恭喜你, 成功觉醒全套觉醒根骨\\觉醒奖励已通过邮箱发放!", "@_tm_awakening_CallBack_ok", "")
    end
end

function _tm_awakening_CallBack_ok(actor)
end

return TianMingAwakeningNpc