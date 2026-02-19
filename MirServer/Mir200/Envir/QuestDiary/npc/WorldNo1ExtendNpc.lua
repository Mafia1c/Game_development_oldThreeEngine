local WorldNo1ExtendNpc = {}
WorldNo1ExtendNpc.cfg = {
        ["119"] = 0,
        ["120"] = 1,
        ["121"] = 2
    }

function WorldNo1ExtendNpc:click(actor, npc_id)
    local rank_list = self:getRankListData()
    local job = self.cfg[npc_id..""]
    local sMsg = rank_list[job..""]
    if sMsg then
        sMsg = npc_id.."#"..tbl2json(sMsg)
    else
        sMsg = npc_id
    end
    lualib:ShowNpcUi(actor, "WorldNo1ExtendOBJ", sMsg)
end

function WorldNo1ExtendNpc:onClickApplyBtn(actor, npc_id)
    local level = getbaseinfo(actor, 6)
    if level < 45 then
        return Sendmsg9(actor, "ffffff", " 等级不足!",1)
    end
    local job = getbaseinfo(actor, 7)
    if job ~= self.cfg[npc_id] then
        return Sendmsg9(actor, "ffffff", "职业不对, 无法申请!",1)
    end

    -- 0. 未开启  1.进行中   2.已结束
    local txdy_state = NpcClassCache["ActivityMapLogic"]:GetActiveIsOpen(5)
    if txdy_state ~= 1 then
        return Sendmsg9(actor, "ffffff", "未在开放申请时间内, 详情查看全服活动天下第一介绍!",1)
    end
    local suffix = {[0] = "战", [1] = "法", [2] = "道"}
    local rank_list = self:getRankListData()
    local up_role = rank_list[job..""]
    if up_role and tonumber(up_role.up_level) >= level then
        return Sendmsg9(actor, "ffffff", "等级大于榜上人物即可申请!",1)
    end
    if up_role then
        local _role = getplayerbyid(up_role.roleId)
        if _role then
            deprivetitle(_role, up_role.title)
        end
    end
    local role = {
        up_time = os.time(),
        up_level = level,
        up_guild = getguildinfo(actor, 1) or "无",
        up_name = getbaseinfo(actor, 1),
        roleId = getbaseinfo(actor, 2),
        job = job.."",
        sex = getbaseinfo(actor, 8),
        title = "天下第一"..suffix[job]
    }
    rank_list[job..""] = role
    local str = tbl2json(rank_list)
    setsysvar(VarEngine.WorldNo1Rank, str)
    confertitle(actor, role.title, 1)
    changetitletime(actor, role.title, "=", os.time() + 14400)
    lualib:FlushNpcUi(actor,"WorldNo1ExtendOBJ", tbl2json(role))
end

function WorldNo1ExtendNpc:getRankListData()
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

function WorldNo1ExtendNpc:CheckDelWordNo1Title(actor, del_all)
    local rank_list = self:getRankListData()
    local roleId = getbaseinfo(actor, 2)
    local job = getbaseinfo(actor, 7)
    local is_del = true
    for k, v in pairs(rank_list) do
        if del_all then
            is_del = false
            local _role = getplayerbyid(v.roleId)
            if _role then
                deprivetitle(_role, v.title)
            end
        else
            if roleId == v.roleId then
                is_del = false
                break
            end
        end
    end
    local suffix = {[0] = "战", [1] = "法", [2] = "道"}
    if is_del then
        changetitletime(actor, "天下第一"..suffix[job], "-", 14400)
    end
end

function WorldNo1ExtendNpc:UpdateWoldRankList()
    self:CheckDelWordNo1Title("0", true)
    setsysvar(VarEngine.WorldNo1Rank, "")
    if hastimerex(369) then
        setofftimerex(369)
    end
    setontimerex(369, 14370)
end

function ontimerex369()
    setsysvar(VarEngine.WorldNo1Rank, "")
    setofftimerex(369)
end

return WorldNo1ExtendNpc