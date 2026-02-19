local PosternOfFateTreasure = {}
local top_layer = 80
if nil ~= getmapname("my100") then
    top_layer = 100
end
release_print("命运之门层数: ", top_layer)
function PosternOfFateTreasure:upEvent(actor,npc_id)
    local map_id = getbaseinfo(actor, 3)
    local cur_level = string.match(map_id, "%-?%d+%.?%d*")
    local flush_count =  VarApi.getPlayerJIntVar(actor,"J_flush_myzm_count")
    local reward = VarApi.getPlayerTStrVar(actor, "T_myzm_kapai_reward"..cur_level)
    lualib:ShowNpcUi(actor,"PosternOfFateTreasureObj", cur_level.."#"..flush_count .. "#"..reward)
end
function PosternOfFateTreasure:open_kapai(actor, index)
    index = tonumber(index)
    local map_id = getbaseinfo(actor, 3)
    local cur_level = string.match(map_id, "%-?%d+%.?%d*")
    cur_level = tonumber(cur_level)
    if nil == cur_level or cur_level % 10 ~= 0 or cur_level == top_layer then
        Sendmsg9(actor, "ff0000", "数据异常1", 1)
        return
    end

    local reward = VarApi.getPlayerTStrVar(actor, "T_myzm_kapai_reward"..cur_level)
    if "" ~= reward then
        Sendmsg9(actor, "ffffff", "当前奖励已开启, 请及时领取!", 1)
        return
    end
    local reward_str = getplaydef(actor, "T99")
    local reward_list = json2tbl(reward_str)
    local ret_data = nil
    for key, v in pairs(reward_list or {}) do
        if v.level == cur_level then
            ret_data = v
            break
        end
    end
    if ret_data then

    else
        Sendmsg9(actor, "ff0000", "数据异常, 封号警告!", 1)
        return
    end

    local ret = ret_data.reward
    ret = index .. "|" .. ret .. "|1"
    VarApi.setPlayerTStrVar(actor, "T_myzm_kapai_reward"..cur_level, ret)
    lualib:FlushNpcUi(actor,"PosternOfFateTreasureObj", ret)
end

function PosternOfFateTreasure:flushKapai(actor)
    local map_id = getbaseinfo(actor, 3)
    local cur_level = string.match(map_id, "%-?%d+%.?%d*")
    cur_level = tonumber(cur_level)
    if cur_level % 10 ~= 0 or cur_level == top_layer then
        Sendmsg9(actor, "ff0000", "数据异常", 1)
        return
    end
    local get_level = getplaydef(actor, "U99")
    local reward = VarApi.getPlayerTStrVar(actor, "T_myzm_kapai_reward"..cur_level)
    local tmp_tab = strsplit(reward, "|")
    if type(tmp_tab) == "table" then
        local get_stare = tonumber(tmp_tab[4]) or 0
        if get_stare == 2 then
            Sendmsg9(actor, "ffffff", "奖励已领不可以刷新!", 1)
            return
        end
    end
    if get_level == cur_level then
        Sendmsg9(actor, "ffffff", "奖励已领不可以刷新!", 1)
        return
    end

    if VarApi.getPlayerUIntVar(actor,VarIntDef.ZSTQ_LEVEL) <= 0 then
        return Sendmsg9(actor, "ffffff", "开通终生特权每日可刷新1次！", 1)
    end

    local flush_count =  VarApi.getPlayerJIntVar(actor,"J_flush_myzm_count")
    if flush_count < 1 then
       return Sendmsg9(actor, "ffffff", "今日刷新次数不足", 1)
    end

    local npc_class = IncludeNpcClass("PosternOfFateNpc")
    if npc_class then
        npc_class:GenerateRewardPool(actor)
    end

    flush_count = flush_count - 1
    VarApi.setPlayerJIntVar(actor, "J_flush_myzm_count", flush_count)
    VarApi.setPlayerTStrVar(actor, "T_myzm_kapai_reward"..cur_level, "")
    lualib:FlushNpcUi(actor,"PosternOfFateTreasureObj", "#"..flush_count)
end

function PosternOfFateTreasure:getAward(actor, index)
    local map_id = getbaseinfo(actor, 3)
    local level = string.match(map_id, "%-?%d+%.?%d*")
    if nil == level then
        Sendmsg9(actor, "ffffff", "数据异常！", 1)
        return
    end
    local reward = VarApi.getPlayerTStrVar(actor, "T_myzm_kapai_reward"..level)
    local tmp_tab = strsplit(reward, "|")
    if type(tmp_tab) == "table" then
        local get_stare = tonumber(tmp_tab[4]) or 0
        if get_stare == 2 then
            Sendmsg9(actor, "ffffff", "奖励已领取!", 1)
            return
        end
    else
        Sendmsg9(actor, "ff0000", "数据异常!", 1)
        return
    end
    local get_level = getplaydef(actor, "U99")
    level = tonumber(level)
    if nil == level or get_level >= level then
        Sendmsg9(actor, "ff0000", "数据异常, 封号警告!", 1)
        return
    end
    if index ~= tmp_tab[1] then
        Sendmsg9(actor, "ff0000", "非法操作!", 1)
        return
    end

    if string.find(map_id, "my") == nil or (level and tonumber(level) and tonumber(level) % 10 ~= 0) or level == top_layer then
        Sendmsg9(actor, "ff0000", "非法操作!", 1)
        return
    end

    local reward_str = getplaydef(actor, "T99")
    local reward_list = json2tbl(reward_str)
    local ret_data = nil
    local _index = 0
    for key, v in pairs(reward_list or {}) do
        if v.level == level then
            ret_data = v
            _index = key
            break
        end
    end
    if ret_data then
        table.remove(reward_list, _index)
    else
        Sendmsg9(actor, "ffffff", "数据异常, 封号警告!", 1)
        return
    end
    
    local remain_bag_count = getbagblank(actor)
    if remain_bag_count < 5 then
        Sendmsg9(actor, "ffffff", "背包已满，请先确保背包内有足够空间!", 1)
        return
    end
    setplaydef(actor, "T99", tbl2json(reward_list))
    setplaydef(actor, "U99", level)
    local tips = string.format("命运使者%s层奖励", level)
    local accumulate_recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    local bind_value = accumulate_recharge >= 68 and 0 or 307
    local item_name = tmp_tab[2]
    local count = tonumber(tmp_tab[3]) or 0
    local stdmode = getstditeminfo(item_name,2)
    if stdmode == 41 then
        changemoney(actor, getstditeminfo(item_name, 0), "+", count, tips.."货币",true)
    else
        giveitem(actor, item_name, count, bind_value, tips.."道具")
    end
    tmp_tab[4] = 2
    local ret = tmp_tab[1] .. "|" .. item_name .. "|" .. count .. "|" .. tmp_tab[4]
    VarApi.setPlayerTStrVar(actor, "T_myzm_kapai_reward"..level, ret)
    local flush_count =  VarApi.getPlayerJIntVar(actor,"J_flush_myzm_count")
    lualib:FlushNpcUi(actor, "PosternOfFateTreasureObj", ret.."#"..flush_count)
end

-- 重置命运之门奖励
function PosternOfFateTreasure:resetMYZMVar(actor)
    local level_tab = {10,20,30,40,50,60,70,80,90,100}
    for i = 1, #level_tab, 1 do
        VarApi.setPlayerTStrVar(actor, "T_myzm_kapai_reward"..level_tab[i], "")
    end
    setplaydef(actor, "U99", 0)
end

function PosternOfFateTreasure:ShowDuHuanAward(actor)
    local dh_count = VarApi.getPlayerJIntVar(actor,"J_myzm_dh_count")
    local str = [[
    <Layout|x=546|y=0|width=1136|height=640|link=@exit>
    <Img|move=0|show=0|width=546|height=200|loadDelay=1|reset=1|img=public/bg_npc_01.png|bg=1|show=4>
    <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
    <Button|x=76.0|y=140|width=104|height=34|nimg=public/1900000612.png|size=18|color=255|text=兑换1次|link=@myzm_dh_reputation,1>
    <Button|x=225.0|y=140|size=18|nimg=public/1900000612.png|color=255|text=兑换10次|link=@myzm_dh_reputation,10>
    <Button|x=369.0|y=140|size=18|nimg=public/1900000612.png|color=255|text=兑换50次|link=@myzm_dh_reputation,50>
    <Text|x=180.0|y=21.0|size=18|color=241|text=使用黄金骰子兑换声望>
    <Text|x=110.0|y=54.0|size=18|color=251|text=1个黄金骰子可兑换200声望，每日限50次>
    <Text|x=195.0|y=88.0|size=18|color=251|text=剩余兑换次数：%s>]]
    say(actor, string.format(str,50 - dh_count) )
end
function myzm_dh_reputation(actor,num)
    num = tonumber(num)
    local dh_count = VarApi.getPlayerJIntVar(actor,"J_myzm_dh_count")
    if num > getbagitemcount(actor,"黄金骰子") then
        return  Sendmsg9(actor, "ffffff", "黄金骰子不足!", 1)
    end
    if num  > 50 - dh_count then
        return Sendmsg9(actor, "ffffff", "今日兑换次数不足!", 1)
    end
    local map_id = getbaseinfo(actor, 3)
    if map_id ~= "my100" then
        return Sendmsg9(actor, "ffffff", "兑换数据异常!", 1)
    end
    if takeitem(actor,"黄金骰子",num,0,"命运之门兑换声望") then
        changemoney(actor,15,"+",num * 200,"命运之门声望兑换",true) 
        local dh_count = VarApi.getPlayerJIntVar(actor,"J_myzm_dh_count")
        VarApi.setPlayerJIntVar(actor,"J_myzm_dh_count",dh_count + num )
        Sendmsg9(actor, "ffffff", "兑换成功!", 1)
        local class =  IncludeNpcClass("PosternOfFateTreasure")
        if class then
            class:ShowDuHuanAward(actor)
        end
    end
end

return PosternOfFateTreasure