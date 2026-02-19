local PosternOfFateNpc = {}
PosternOfFateNpc.cfg = include("QuestDiary/config/PosternOfFateCfg.lua")
local treasure_type_weight ="1#40|2#30|3#30"
function PosternOfFateNpc:upEvent(actor)
    local top_map_id = "my80"
    if nil ~= getmapname("my100") then
        top_map_id = "my100"
    end
    local mon_count = getmoncount(top_map_id,-1,true)
    local role_count = getplaycountinmap('0',top_map_id,1)
    lualib:ShowNpcUi(actor,"PosternOfFateOBJ",mon_count.."#"..role_count)
end
function PosternOfFateNpc:onClickGoToBtn(actor)
    local dice_num = getbagitemcount(actor, "黄金骰子", 0)
    if dice_num < 1 then
        return Sendmsg9(actor, "ffffff", "进入命运之门需要: 黄金骰子x1", 1)
    end
    if not takeitem(actor, "黄金骰子", 1) then
        return Sendmsg9(actor,"ffffff","扣除失败!", 1)
    end
    local npc_class = IncludeNpcClass("PosternOfFateTreasure")
    if npc_class then
        npc_class:resetMYZMVar(actor)
    end
    map(actor, "my1")
    lualib:CloseNpcUi(actor, "PosternOfFateOBJ")
    VarApi.setPlayerUIntVar(actor, "U_actor_dice_value", 0, false)

    self:GenerateRewardPool(actor)
end

-- 生成命运之门卡牌奖池
function PosternOfFateNpc:GenerateRewardPool(actor)
    setplaydef(actor, "T99", "")
    local get_level = getplaydef(actor, "U99")
    local reward_list = {}
    for key, level in ipairs({10,20,30,40,50,60,70,80,90}) do
        if level > get_level then
            local data = {}
            data.level = level
            data.reward = self:GetRewardInfo(actor)
            data.index = key
            reward_list[key] = data
        end
    end
    setplaydef(actor, "T99", tbl2json(reward_list))
end

function PosternOfFateNpc:GetRewardInfo(actor)
    local r_tab = getWeightedCfg(treasure_type_weight)
    local value = weightedRandom(r_tab).value           -- 奖励类型

    local reward_cfg = self.cfg["treasure_"..value]
    if nil == reward_cfg then
        Sendmsg9(actor, "ff0000", "数据异常", 1)
        return
    end
    local _recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)           -- 真充
    local reward_tab = reward_cfg.award_list
    if value == 2 and _recharge >= 68 then
        reward_tab = reward_cfg.award_list2 or reward_tab
    end
    local reward_weight = reward_cfg.weight
    r_tab = getWeightedCfg(reward_weight)
    local index = weightedRandom(r_tab).value
    local ret = reward_tab[index]
    if nil == ret then
        Sendmsg9(actor, "ff0000", "数据异常", 1)
        return
    end
    if value == 3 then
        ret = self.cfg[ret]
        local tmp_tab = strsplit(ret, "#")
        ret = tmp_tab[math.random(#tmp_tab)] .. "#1"
    end
    -- 经验#10000
    ret = string.gsub(ret, "#", "|")
    return ret
end

function PosternOfFateNpc:onClickTopNpc(actor, npc_id)
    local top_map_id = "my80"
    local map_name = getmapname("my100")
    if nil ~= map_name then
        top_map_id = "my100"
    end
    local dice_state = VarApi.getPlayerUIntVar(actor, "U_actor_dice_value")
    if dice_state ~= 0 then
        Sendmsg9(actor, "ff0000", "正在摇骰子,请稍后重试!", 1)
        return
    end
    local mon_count = getmoncount(top_map_id, -1, true)
    local map_id = getbaseinfo(actor, 3)
    if map_id ~= top_map_id then
        Sendmsg9(actor, "ff0000", "恶意刷金提醒！", 1)
        return
    end
    if mon_count <= 0 then
        mapmove(actor, 3, 333, 333, 2)
        changemoney(actor, 15, "+", 200, "_增加200声望", true)
    else
        messagebox(actor, "是否放弃击杀本层BOSS\\领取声望x200奖励后立即回城!", "@_g_click_callback_ok", "@_g_click_callback_no")
    end
end

function PosternOfFateNpc:showDiceView(actor, npc_id)
    local dice_state = VarApi.getPlayerUIntVar(actor, "U_actor_dice_value")
    if dice_state ~= 0 then
        Sendmsg9(actor, "ff0000", "请稍后重试!", 1)
        return
    end
    local cur_map_id = getbaseinfo(actor, 3)
    if nil == string.find(cur_map_id, "my") then
        Sendmsg9(actor, "ff0000", "数据异常!", 1)
        return
    end
    local cur_level = string.match(cur_map_id, "%-?%d+%.?%d*")

    lualib:ShowNpcUi(actor, "PosternOfFateExtendOBJ", npc_id.."#"..cur_level)
end

-- 摇骰子
function PosternOfFateNpc:playDice(actor, dice, npc_id)
    local cur_map_id = getbaseinfo(actor, 3)
    local dice_state = VarApi.getPlayerUIntVar(actor, "U_actor_dice_value")
    if dice_state ~= 0 then
        Sendmsg9(actor, "ff0000", "请稍后重试!", 1)
        return
    end
    if nil == string.find(cur_map_id, "my") then
        Sendmsg9(actor, "ff0000", "数据异常!", 1)
        return
    end
    local mon_count = getmoncount(cur_map_id, -1, true)
    if mon_count > 0 then
        Sendmsg9(actor, "ffffff", "当前地图怪物未击杀!", 1)
        return
    end
    local is_need_money = true
    dice = tonumber(dice)
    if dice == 0 then
        dice = math.random(1, 6)
        is_need_money = false
    end
    local cfg = self.cfg[1]
    local tab = {}
    if cfg and cfg.needItem then
        tab = strsplit(cfg.needItem, "#")
    end

    if is_need_money then
        local name = "绑定灵符"
        local item_id = 20
        local money = querymoney(actor, item_id)
        if 20 > money then
            name = "灵符"
            item_id = 7
            money = querymoney(actor, item_id)
        end
        if money < 20 then
            return Sendmsg9(actor, "ff0000", "灵符/绑定灵符不足！", 1)
        end

        if not changemoney(actor, item_id, "-", 20, name.."扣除", true) then
            return Sendmsg9(actor, "ff0000", name.."扣除失败！", 1)
        end
    end

    lualib:CloseNpcUi(actor, "PosternOfFateExtendOBJ")
    setplaydef(actor, "D0", dice)
    playdice(actor, 1, "@_posternofFatenpc_callback,1")
    VarApi.setPlayerUIntVar(actor, "U_play_dice_time", os.time())
    VarApi.setPlayerUIntVar(actor, "U_actor_dice_value", dice, false)       -- 标记一下正在摇骰子
end

function _posternofFatenpc_callback(actor, param1)
    local play_time = VarApi.getPlayerUIntVar(actor, "U_play_dice_time")
    local cur_time = os.time() - play_time
    if cur_time <= 2 or play_time == 0 then
        map(actor, 3)
        Sendmsg9(actor, "ff0000", "数据异常警告!", 1)
        return
    end
    VarApi.setPlayerUIntVar(actor, "U_play_dice_time", 0)
    local cur_map_id = getbaseinfo(actor, 3)
    local dice = getplaydef(actor, "D0")
    local cur_level = string.match(cur_map_id, "%-?%d+%.?%d*")
    cur_level = tonumber(cur_level)
    if nil == string.find(cur_map_id, "my") then
        map(actor, 3)
        Sendmsg9(actor, "ff0000", "数据异常!", 1)
        return
    end
    if nil == cur_level or not isInTable({1,2,3,4,5,6}, dice) then
        map(actor, 3)
        Sendmsg9(actor, "ff0000", "数据异常警告!", 1)
        return
    end

    local level = cur_level + dice
    if cur_level >= level then
        Sendmsg9(actor, "ff0000", "数据异常警告!", 1)
        map(actor, 3)
        return
    end
    local map_name = getmapname("my"..level)
    if nil == map_name then
        for i = 1, 6, 1 do
            level = level - 1
            map_name = getmapname("my"..level)
            if map_name ~= nil then
                break
            end
        end
    end
    if nil == string.find(cur_map_id, "my") and cur_map_id ~= "my1"  then
        map(actor, 3)
        return Sendmsg9(actor, "ffffff", "当前不可传送!", 1)
    end
    map(actor, "my"..level)
    VarApi.setPlayerUIntVar(actor, "U_actor_dice_value", 0, false)
end

function _g_click_callback_ok(actor)
    local top_map_id = "my80"
    local map_name = getmapname("my100")
    if nil ~= map_name then
        top_map_id = "my100"
    end
    local map_id = getbaseinfo(actor,3)
    if map_id ~= top_map_id then
        Sendmsg9(actor, "ff0000", "恶意刷金提醒！", 1)
        return
    end    
    mapmove(actor, 3, 333, 333, 2)
    changemoney(actor, 15, "+", 200, "_增加200声望", true)
end

function _g_click_callback_no(actor)

end

return PosternOfFateNpc