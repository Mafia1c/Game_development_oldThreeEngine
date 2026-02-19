local WuShuangXueMai = {}
WuShuangXueMai.cfg = include("QuestDiary/config/WuShuangXueMaiCfg.lua")
function WuShuangXueMai:upEvent(actor)
    local has_active_list = json2tbl(VarApi.getPlayerTStrVar(actor, "T_has_wsxm_active_list")) 
    if has_active_list == "" then 
        has_active_list = {}
    end
    lualib:ShowNpcUi(actor,"WuShuangXueMaiOBJ","initview#"..tbl2json(has_active_list).."#"..WuShuangXueMai:GetCanActiveCount(actor))
end
function WuShuangXueMai:activeClick(actor,param)
    local gengu_count = VarApi.getPlayerUIntVar(actor, "U_root_bone_reward")
    local has_active_num = VarApi.getPlayerUIntVar(actor, "U_has_wsxm_active_num")
    if has_active_num >= 6 or has_active_num >= gengu_count then
       return Sendmsg9(actor, "ffffff", "激活次数不足", 1)
    end
    local key_name = VarApi.getPlayerUIntVar(actor,"U_cur_random_wsxm") --#当前选中的卡牌
    if key_name == 0 then
        key_name = WuShuangXueMai:weightedRandomSelect(actor)
        VarApi.setPlayerUIntVar(actor,"U_cur_random_wsxm",key_name) 
    end
    lualib:ShowNpcUi(actor,"WuShuangActiveOBJ",key_name)
end
function WuShuangXueMai:SlectActiveClick(actor,key_name)
    local gengu_count = VarApi.getPlayerUIntVar(actor, "U_root_bone_reward")
    VarApi.setPlayerUIntVar(actor,"U_cur_random_wsxm",0) 
    local has_active_list = json2tbl(VarApi.getPlayerTStrVar(actor, "T_has_wsxm_active_list")) 
    if has_active_list == "" then 
        has_active_list = {}
    end
    local has_active_num = VarApi.getPlayerUIntVar(actor, "U_has_wsxm_active_num")
    if has_active_num >= 6 or has_active_num >= gengu_count then
        return Sendmsg9(actor, "ffffff", "激活次数不足", 1)
    end
    local cfg =  WuShuangXueMai.cfg[tonumber(key_name)]
    if WuShuangXueMai:IsActiveByKey(actor,key_name) then
        lualib:CloseNpcUi(actor,"WuShuangActiveOBJ")
        return Sendmsg9(actor, "ffffff", cfg.talent_name.. "已满级", 1)
    end
    addbuff(actor, cfg.buff_id)
    table.insert(has_active_list,tonumber(key_name)) 
    VarApi.setPlayerUIntVar(actor, "U_has_wsxm_active_num",has_active_num + 1)
    VarApi.setPlayerTStrVar(actor, "T_has_wsxm_active_list",tbl2json(has_active_list))
    local str =  "天赋血脉:恭喜<「%s」/FCOLOR=251>成功激活無双血脉<「%s」/FCOLOR=251>恭喜恭喜！"
    local player_name = getbaseinfo(actor,1)
    Sendmsg13(actor,255, string.format(str,player_name,cfg.talent_name) ,2,13)
    if cfg.buff_id == 50057 then
        WuShuangXueMai:FlushSkillCd(actor,true)
    end

    lualib:CloseNpcUi(actor,"WuShuangActiveOBJ")
    lualib:FlushNpcUi(actor,"WuShuangXueMaiOBJ","flush_view|"..tbl2json(has_active_list).."|"..WuShuangXueMai:GetCanActiveCount(actor))
end
--刷新卡牌
function WuShuangXueMai:flushKaiPai(actor)
    if  getbindmoney(actor,"灵符") < 500 then
        return Sendmsg9(actor, "ffffff", "灵符不足", 1)
    end
    if consumebindmoney(actor,"灵符",500,"无双血脉激活扣除") then
        Sendmsg9(actor, "ffffff", "刷新成功", 1)
        local key_name = WuShuangXueMai:weightedRandomSelect(actor)
        VarApi.setPlayerUIntVar(actor,"U_cur_random_wsxm",key_name) 
        lualib:FlushNpcUi(actor,"WuShuangActiveOBJ",key_name)
    end
end
function WuShuangXueMai:ChongXiuFlush(actor)
    if  getbindmoney(actor,"灵符") < 500 then
        return Sendmsg9(actor, "ffffff", "灵符不足", 1)
    end
    if consumebindmoney(actor,"灵符",500,"无双血脉激活扣除") then
        Sendmsg9(actor, "ffffff", "刷新成功", 1)
        local key_name = WuShuangXueMai:weightedRandomSelect(actor)
        lualib:FlushNpcUi(actor,"WuShuangChongXiuOBJ",key_name)
    end
end
function WuShuangXueMai:ChongXiuSetInfo(actor,pos,key_name)
    local has_active_list = json2tbl(VarApi.getPlayerTStrVar(actor, "T_has_wsxm_active_list")) 
    if has_active_list == "" then 
        has_active_list = {}
    end
    if has_active_list[tonumber(pos)] == nil then
        release_print("bug：位置未激活，但是点了重修")
        return
    end 
    local old_cfg = WuShuangXueMai.cfg[tonumber(has_active_list[tonumber(pos)])]
    delbuff(actor,old_cfg.buff_id)
    local new_cfg = WuShuangXueMai.cfg[tonumber(key_name)]

    WuShuangXueMai:FlushSkillCd(actor,new_cfg.buff_id == 50057)

    addbuff(actor, new_cfg.buff_id)
    has_active_list[tonumber(pos)] = tonumber(key_name) 
    Sendmsg9(actor, "ffffff", "重修成功获得：" .. new_cfg.talent_name, 1)
    VarApi.setPlayerTStrVar(actor, "T_has_wsxm_active_list",tbl2json(has_active_list))
    lualib:CloseNpcUi(actor,"WuShuangChongXiuOBJ")
    lualib:FlushNpcUi(actor,"WuShuangXueMaiOBJ","chongxiu_flush|"..tbl2json(has_active_list).."|"..WuShuangXueMai:GetCanActiveCount(actor).."|"..key_name)
end
function WuShuangXueMai:IsActiveByKey(actor,key_name)
    local has_active_list = json2tbl(VarApi.getPlayerTStrVar(actor, "T_has_wsxm_active_list")) 
    if has_active_list == "" then return false end
    for k, v in pairs(has_active_list) do
        if tonumber(v) == tonumber(key_name) then
           return true  
        end
    end
    return false 
end

function WuShuangXueMai:GetCanActiveCount(actor)
    local gengu_count = VarApi.getPlayerUIntVar(actor, "U_root_bone_reward")
    local has_active_num = VarApi.getPlayerUIntVar(actor, "U_has_wsxm_active_num")
    if has_active_num >= 6 then
       return 0 
    end
    if gengu_count > has_active_num then
        return gengu_count - has_active_num
    end
    return 0
end
function WuShuangXueMai:weightedRandomSelect(actor)
    local key_name = math.random(1,#WuShuangXueMai.cfg)
    if WuShuangXueMai:IsActiveByKey(actor,key_name) then
       return WuShuangXueMai:weightedRandomSelect(actor)
    end
    return key_name
end

function WuShuangXueMai:FlushSkillCd(actor,is_lessen)
    local skill_list = getallskills(actor)
    for k, v in pairs(skill_list or {}) do
        local skill_name = getskillname(v)
        if is_lessen then
            sendattackeff(actor,145)
            setskilldeccd(actor,skill_name,"-",1)
        else
            setskilldeccd(actor,skill_name,"=",0)
        end
    end
end
return WuShuangXueMai