local GoldForest = {}
GoldForest.cfg = include("QuestDiary/config/goldForestCfg.lua")
local type_map = {}
for i,v in ipairs(GoldForest.cfg) do
	type_map[v.name] = type_map[v.name] or {}
	table.insert(type_map[v.name],v)
end
function GoldForest:upEvent(actor,param)
    local random_list = json2tbl(VarApi.getPlayerTStrVar(actor,"_goldforestrandom"))
    if  random_list == "" then
        random_list = GoldForest:GetRandomAwardList()
        VarApi.setPlayerTStrVar(actor,"_goldforestrandom",tbl2json(random_list))
    end
    local data = {}
    data.random_list = random_list
    data.is_jump_ani = VarApi.getPlayerJIntVar(actor,"_goldforest_jump_ani")
    data.has_lottery_num = VarApi.getPlayerJIntVar(actor,"_has_lottery_num")
    data.has_lottery_list = json2tbl(VarApi.getPlayerZStrVar(actor,"_gold_has_lottery")) 
    data.active_enter = VarApi.getPlayerJIntVar(actor,"_goldforest_active_enter")
    if data.has_lottery_list == "" then
        data.has_lottery_list = {}
    end
    lualib:ShowNpcUi(actor,"GoldForestOBJ","init_flush#".. tbl2json(data))
    
end
function GoldForest:SetJumpAniState(actor,state)
    VarApi.setPlayerJIntVar(actor,"_goldforest_jump_ani",tonumber(state))
    lualib:FlushNpcUi(actor,"GoldForestOBJ","flush_jump_state|" .. state)
end
--抽奖
function GoldForest:StartLottery(actor)
    if  GoldForest.is_play_dice then
        Sendmsg9(actor, "ff0000", "正在摇骰子,请稍后重试!", 1)
        return
    end
    if getbagitemcount(actor,"黄金骰子") <= 0 then
        return Sendmsg9(actor, "ffffff",  "黄金骰子不足！", 1) 
    end
    if not takeitemex(actor, "黄金骰子", 1,0,"黄金森林抽奖") then
        return Sendmsg9(actor, "ffffff",  "物品扣除失败！", 1) 
    end
    GoldForest.touzi_is_same = nil
    local notsamenum =  VarApi.getPlayerJIntVar(actor,"_notsamenum")
    local dice_list = {}
    local is_jump_ani = VarApi.getPlayerJIntVar(actor,"_goldforest_jump_ani") > 0
    local list = {}
    for i = 1, 3 do
        local dice = GoldForest:GetRandomDice(list)
        if notsamenum >= 4 then   --第五次必然双倍
            for s = 1, 3 do
                table.insert(dice_list,dice) 
                if not is_jump_ani then
                    setplaydef(actor, "D"..s-1,dice)
                end
            end
            break
        else
            table.insert(dice_list,dice) 
            if not is_jump_ani then
                setplaydef(actor, "D"..i-1,dice)
            end
        end
    end
    local is_same = true
    local first = dice_list[1]
    for i = 2, #dice_list do
        if dice_list[i] ~= first then
            is_same = false
            break
        end
    end
    if is_same then
        VarApi.setPlayerJIntVar(actor,"_notsamenum",0)
    else
        VarApi.setPlayerJIntVar(actor,"_notsamenum",notsamenum + 1)
      
    end
    GoldForest.touzi_is_same = is_same
    if not is_jump_ani then
        playdice(actor, 3, "@_gold_fore_callback")
        GoldForest.is_play_dice = true
    else
       GoldForest:SetLotteryAward(actor,is_same)
    end
end
function GoldForest:GetRandomDice(list)
    local dice = math.random(1, 6)
    if list[dice] then
        dice = GoldForest:GetRandomDice(list)
    end
    list[dice] = dice 
    return dice
end

--设置抽奖奖励 
---* is_double 是否双倍奖励
function GoldForest:SetLotteryAward(actor,is_double)
    if nil == GoldForest.touzi_is_same then
        Sendmsg9(actor,"ff0000","非法操作",1)
        return
    end
    local random_list = json2tbl(VarApi.getPlayerTStrVar(actor,"_goldforestrandom"))
    local lottery_list = {}
    for k, v in pairs(random_list) do
        table.insert(lottery_list,v)
    end
    for i,v in ipairs(GoldForest.cfg) do
        if v.name == "四格" then
            table.insert(lottery_list,v.key_name)
        end
    end
    local random_index = lottery_list[math.random(1,#lottery_list)] 
    if GoldForest:CheckIsGet(actor,random_index) then
        GoldForest:SetLotteryAward(actor,is_double)
        return
    end
   
    local cfg = GoldForest.cfg[random_index] 
    local stdmode =  getstditeminfo(cfg.item_name,2)
    local count = is_double and cfg.item_count * 2 or cfg.item_count
    if  stdmode == 41 then  --货币
        changemoney(actor,getstditeminfo(cfg.item_name, 0),"+",count,"黄金森林抽奖",true)
    else
        giveitem(actor,cfg.item_name,count)
    end
    if is_double then
        VarApi.setPlayerJIntVar(actor,"_goldforest_active_enter",1)
        Sendmsg9(actor, "ffffff",  "恭喜你摇到豹子,奖励数量翻倍！", 1) 
    end
    local list = json2tbl(VarApi.getPlayerZStrVar(actor,"_gold_has_lottery")) 
    if list == "" then
        list = {}
    end
    table.insert(list,random_index)
    local has_lottery_num = VarApi.getPlayerJIntVar(actor,"_has_lottery_num")
    VarApi.setPlayerJIntVar(actor,"_has_lottery_num",has_lottery_num + 1 > 30 and 30 or has_lottery_num + 1)
    VarApi.setPlayerZStrVar(actor,"_gold_has_lottery",tbl2json(list))
    local award_list = {}
    table.insert(award_list,{name = cfg.item_name,count = count})
    lualib:ShowAwardTipUi(actor,award_list)
    lualib:FlushNpcUi(actor,"GoldForestOBJ","flush_lottery|"..tbl2json(list) .."|".. has_lottery_num+1 .. "|" .. VarApi.getPlayerJIntVar(actor,"_goldforest_active_enter"))
    GoldForest:SetSpecialAward(actor,lottery_list)
    GoldForest:SetProgressAward(actor)
   
end
--设置大奖
function GoldForest:SetSpecialAward(actor,lottery_list)
    if nil == GoldForest.touzi_is_same then
        Sendmsg9(actor,"ff0000","非法操作",1)
        return
    end
    GoldForest.touzi_is_same = nil
    --设置大奖
    local list = json2tbl(VarApi.getPlayerZStrVar(actor,"_gold_has_lottery")) 
    if list == "" then
        list = {}
    end
    if #list >= #lottery_list then
        local cfg = GoldForest.cfg[#GoldForest.cfg]
        local award = string.format("%s#%s",cfg.item_name,cfg.item_count) 
        sendmail(getbaseinfo(actor,2),1,"黄金森林","恭喜你开启一轮黄金森林宝藏\\获得终极奖励，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时删除邮件！",award)
       
        local str =  "黄金森林:恭喜<「%s」/FCOLOR=251>成功开启所有宝藏，获得<「%sx%s」/FCOLOR=251>终极奖励!"
        local player_name = getbaseinfo(actor,1)
        Sendmsg13(actor,255, string.format(str,player_name,cfg.item_name,cfg.item_count) ,2,13)

        VarApi.setPlayerZStrVar(actor,"_gold_has_lottery",tbl2json({}))
        local random_list = GoldForest:GetRandomAwardList()
        VarApi.setPlayerTStrVar(actor,"_goldforestrandom",tbl2json(random_list))
        local has_lottery_num = VarApi.getPlayerJIntVar(actor,"_has_lottery_num")
         
        lualib:FlushNpcUi(actor,"GoldForestOBJ","reset_lottery|".. tbl2json(random_list).."|"..tbl2json({}) .."|"..has_lottery_num)
    end
    GoldForest.is_play_dice = nil
end
--进度奖励
function GoldForest:SetProgressAward(actor)
    local has_lottery_num = VarApi.getPlayerJIntVar(actor,"_has_lottery_num")
    for i = 1, 5 do
        if has_lottery_num >= GoldForest.cfg[i].accumulative and  not GoldForest:ProgressIsGet(actor,i) then
            local list = json2tbl(VarApi.getPlayerZStrVar(actor,"_goldforesrProgress")) 
            if list == "" then
                list = {}
            end
            
            table.insert(list,i)
            VarApi.setPlayerZStrVar(actor,"_goldforesrProgress",tbl2json(list))
            local award = string.format("%s#%s#307", GoldForest.cfg[i].accumulative_item,GoldForest.cfg[i].accumulative_item_num) 
            local str = "恭喜你开启%s次黄金森林宝藏\\获得额外奖励，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时删除邮件！"
            sendmail(getbaseinfo(actor,2),1,"黄金森林",string.format(str,GoldForest.cfg[i].accumulative) ,award)
        end
    end
end
function GoldForest:ProgressIsGet(actor,key_name)
    local list = json2tbl(VarApi.getPlayerZStrVar(actor,"_goldforesrProgress")) 
    if list == "" then
        return false
    end
   
    for i,v in ipairs(list) do
        if tonumber(v)  == tonumber(key_name) then
           return true 
        end
    end
    return false
end
function GoldForest:CheckIsGet(actor,key_name)
    local list = json2tbl(VarApi.getPlayerZStrVar(actor,"_gold_has_lottery")) 
    if list == "" then
        return false
    end
    for i,v in ipairs(list) do
        if tonumber(key_name) == tonumber(v) then
           return true 
        end
    end
    return false 
end
function GoldForest:EnterMap(actor)
    if VarApi.getPlayerJIntVar(actor,"_goldforest_active_enter") > 0 then
        mapmove(actor,GoldForest.cfg[1].mapid)
        lualib:CloseNpcUi(actor,"GoldForestOBJ")
    else
        Sendmsg9(actor,"ff0000","未激活黄金森林",1)
    end
end
function _gold_fore_callback(actor)
    GoldForest:SetLotteryAward(actor,GoldForest.touzi_is_same)
end
--获取随机12个奖励
function GoldForest:GetRandomAwardList()
	local random_list = {}
	local used = {}
	while #random_list < 12 do
        local index = math.random(1, #type_map["随机"])
        if not used[index] then
            table.insert(random_list, index)
            used[index] = true
        end
    end
    return random_list
end

return GoldForest