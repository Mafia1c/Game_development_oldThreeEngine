local WelfareHall = {}
local _cfg = include("QuestDiary/config/welfareHallcfg.lua")
local frist_equip_cfg = include("QuestDiary/config/FirstDropEquipCfg.lua")
local cdk_cfg = include("QuestDiary/config/cdk_cfg.lua")
local map_cfg = {}
for k, v in ipairs(_cfg) do
    map_cfg[v.type] = map_cfg[v.type] or {}
    table.insert(map_cfg[v.type], v)
end
local tmp_cfg = {}
for k, v in pairs(map_cfg) do
    local data = v
    -- data.name = v[1].tag_name
    table.insert(tmp_cfg, data)
end
table.sort(tmp_cfg, function (a, b) return a[1].sort < b[1].sort end)
WelfareHall.cfg = tmp_cfg

--初始化数据
function WelfareHall:upEvent(actor,index,type,is_open)
    index = tonumber(index)
    type = tonumber(type)
    if is_open and not WelfareHall:IsOpenTab(actor,type) then
       return Sendmsg9(actor, "ffffff",  "活动已关闭！", 1) 
    end
    local cfg =  map_cfg[type]
    local data = {}
    if cfg[1].tag_name == "登录豪礼" then
        data = WelfareHall:GetLoginGiftData(actor,type)
    elseif cfg[1].tag_name == "在线奖励" then
        local minute = math.floor(getplaydef(actor,VarEngine.OnLine_TimeStamp) / 60) 
        local online_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_online_gift_award")) 
        if online_award_flag == "" then
            online_award_flag = {}
        end
        data.award_list = online_award_flag
        data.online_time = minute
    elseif cfg[1].tag_name == "成长奖励" then
        local grow_up_award_flag = json2tbl(VarApi.getPlayerTStrVar(actor,"T_grow_up_gift_award")) 
        if grow_up_award_flag == "" then
            grow_up_award_flag = {}
        end
        data = grow_up_award_flag
    elseif cfg[1].tag_name == "充值回馈" then
        local day_recharge = VarApi.getPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE)
        local accumulate_recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)

        local recharge_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_recharge_back_gift_award")) 
        if recharge_award_flag == "" then
            recharge_award_flag = {}
        end
        data.award_list = recharge_award_flag
        data.day_recharge = day_recharge
        data.accumulate_recharge = accumulate_recharge
    elseif cfg[1].tag_name == "客服豪礼" then
        data.is_get = VarApi.getPlayerUIntVar(actor,"U_service_gift_award")
    -- elseif cfg[1].tag_name == "开服特惠" then
    --     data.is_buy = VarApi.getPlayerUIntVar(actor,"U_open_server_gift")
    elseif cfg[1].tag_name == "合区特惠" then
    elseif cfg[1].tag_name == "惊喜魔盒" then
        data.critical = VarApi.getPlayerUIntVar(actor,"J_surpise_box_critical")
        data.double = VarApi.getPlayerJIntVar(actor,"J_surpise_box_double")
    elseif cfg[1].tag_name == "首爆奖励" then
        local list = json2tbl(getsysvar(VarEngine.FristEquip))
        if list == "" then
            list = {}
        end
        local frist_equip_flag = json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP)) 
        if frist_equip_flag == "" then
            frist_equip_flag = {}
        end
        local zstq_level = VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL)
        data.equip_count_list = list
        data.equip_state = frist_equip_flag
        data.zstq_level = zstq_level
    elseif cfg[1].tag_name == "珍宝掉落" then
        local list = json2tbl(getsysvar(VarEngine.EquipDropRecord))
        if list == "" then
            list = {}
        end
        data = list
    elseif cfg[1].tag_name == "限时福利" then

    elseif cfg[1].tag_name == "cdk兑换" then
        
    end
    if is_open then
        lualib:ShowNpcUi(actor, "WelfareHallOBJ",cfg[1].tag_name.."#"..tbl2json(data))
    else
        lualib:FlushNpcUi(actor,"WelfareHallOBJ","open_view#"..index.."#"..tbl2json(data))
    end
end
function WelfareHall:IsOpenTab(actor,type)
    local merge_num =  getsysvar(VarEngine.HeFuCount) or 0
    if type == 6 then --合区特惠
        if merge_num < 0 then
            return false
        end
    elseif type == 7 then
        return merge_num >= 1
    elseif type == 10 then
        local gift_tab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift"))
        if gift_tab == "" then
           return false 
        end
        local is_show = false
        for i=1,2 do
            if not gift_tab["gift_xsfl"..i] then
                is_show = true
            end
        end
        return merge_num >= 1 and is_show 
    end
    return true
end


-----------------------登录好礼-----------------------
function WelfareHall:GetLoginGiftData(actor,type)
    type = tonumber(type) 
    local list = {}
    list.common_list = {}
    list.privilege_list = {}
    local day = VarApi.getPlayerUIntVar(actor,VarIntDef.LOGIN_DAY)
    local days_later = VarApi.getPlayerJIntVar(actor,"J_days_later")
    for i,v in ipairs(map_cfg[type]) do
        if WelfareHall:GetLoginGiftState(actor,v.parame1)  == 2 then
            list.common_list[v.parame1] = 2 --已领取  
        else
            if v.parame1 == 8 then
                if days_later <=0 and day >= 8 then
                    list.common_list[v.parame1] = 0 --可领取 
                else
                    list.common_list[v.parame1] = 1 --不可领取  
                end
            else
                if day >= v.parame1 then
                    list.common_list[v.parame1] = 0 --可领取  
                else
                    list.common_list[v.parame1] = 1 --不可领取  
                end
            end
        end

        if WelfareHall:GetTqLoginGiftState(actor,v.parame1)  == 2 then
            list.privilege_list[v.parame1] = 2 --已领取  
        else
            if day >= v.parame1 then
                list.privilege_list[v.parame1] = 0 --可领取  
            else
                list.privilege_list[v.parame1] = 1 --不可领取  
            end
        end
    end
    return list
end
function WelfareHall:FlushLoginGift(actor,type)
    type = tonumber(type) 
    local list = {}
    local day = VarApi.getPlayerUIntVar(actor,VarIntDef.LOGIN_DAY)
    local days_later = VarApi.getPlayerJIntVar(actor,"J_days_later")
    for i,v in ipairs(map_cfg[type]) do
        if WelfareHall:GetLoginGiftState(actor,v.parame1)  == 2 then
            list[v.parame1] = 2 --已领取  
        else
            if v.parame1 == 8 then
                if days_later <= 0 and day >= 8 then
                    list[v.parame1] = 0 --可领取 
                else
                    list[v.parame1] = 1 --不可领取  
                end
            else
                if day >= v.parame1 then
                    list[v.parame1] = 0 --可领取  
                else
                    list[v.parame1] = 1 --不可领取  
                end
            end
        end
    end
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","init_login_gift#"..tbl2json(list))
end
--特权
function WelfareHall:FlushTeQuanGift(actor,type)
     type = tonumber(type) 
    local privilege_list = {}
    local day = VarApi.getPlayerUIntVar(actor,VarIntDef.LOGIN_DAY)
    for i,v in ipairs(map_cfg[type]) do
        if WelfareHall:GetTqLoginGiftState(actor,v.parame1)  == 2 then
            privilege_list[v.parame1] = 2 --已领取  
        else
            if day >= v.parame1 then
                privilege_list[v.parame1] = 0 --可领取  
            else
                privilege_list[v.parame1] = 1 --不可领取  
            end
        end
    end
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","init_tq_login_gift#"..tbl2json(privilege_list))
end
--登录好礼是否领取
function WelfareHall:GetLoginGiftState(actor,id)
    local common_award_flag = json2tbl(VarApi.getPlayerTStrVar(actor,"T_login_gift_com_award")) 
    if common_award_flag == "" then
       return 0
    end
    local days_later = VarApi.getPlayerJIntVar(actor,"J_days_later")
    for k,v in pairs(common_award_flag) do
        if v.id == tonumber(id) then
            if v.id > 7 then
                return days_later
            else
                return v.state 
            end
        end
    end
    return 0
end
function WelfareHall:GetLoginCommonAward(actor,type,id)
    type = tonumber(type)
    local day = VarApi.getPlayerUIntVar(actor,VarIntDef.LOGIN_DAY)
    
    if day < tonumber(id) then
        return Sendmsg9(actor, "ffffff",  "累计登陆天数不足", 1) 
    end
    local common_award_flag = json2tbl(VarApi.getPlayerTStrVar(actor,"T_login_gift_com_award")) 
    if common_award_flag == "" then
       common_award_flag = {}
    end    
    for k, v in pairs(common_award_flag) do
        if v and v.id == tonumber(id) and tonumber(id) ~= 8 then
            Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
            return
        end
    end        
    local str =  "福利大厅:恭喜<「%s」/FCOLOR=251>在福利大厅里免费领取<「第%s天」/FCOLOR=251>登录豪礼"
    local player_name = getbaseinfo(actor,1)
    Sendmsg13(actor,255, string.format(str,player_name,id) ,2,13)
    local cfg = {}
    for i,v in ipairs(map_cfg[type]) do
        if v.parame1 == tonumber(id) then
            cfg = v
            break 
        end
    end
    local list = {}
    for k, v in pairs(cfg.award1_map) do
        table.insert(list,{name = k,count = v})
    end
    for i,v in ipairs(list) do
        local stdmode =  getstditeminfo(v.name,2)
        local count = v.count
        if  stdmode == 41 then  --货币
            changemoney(actor,getstditeminfo(v.name, 0),"+",count,"登录豪礼",true)
        else
            giveitem(actor,v.name,count,307)
        end
    end

    if tonumber(id) == 8 then
        VarApi.setPlayerJIntVar(actor,"J_days_later",2)
        local is_set = true
        for k, v in pairs(common_award_flag) do
            if v.id == 8 then
                is_set = false
            end
        end
        if  is_set then
            table.insert(common_award_flag,{id =tonumber(id),state = 2})        
        end
    else
        table.insert(common_award_flag,{id =tonumber(id),state = 2})
    end

    VarApi.setPlayerTStrVar(actor,"T_login_gift_com_award",tbl2json(common_award_flag))
    WelfareHall:FlushLoginGift(actor,type)
    lualib:ShowAwardTipUi(actor, list)
    lualib:SendDataClient(actor, "WelfareHall_flush#".. 1 .."#"..WelfareHall:GetloginRed(actor))
end
--登录好礼是否领取  --特权
function WelfareHall:GetTqLoginGiftState(actor,id)
    local tq_award_flag = json2tbl(VarApi.getPlayerTStrVar(actor,"T_login_gift_tq_award")) 
    if tq_award_flag == "" then
       return 0
    end
    for k,v in pairs(tq_award_flag) do
        if v.id == tonumber(id) then
           return v.state 
        end
    end
    return 0
end

function WelfareHall:GetLoginTqAward(actor,act_type,id)
    act_type = tonumber(act_type)
    local day = VarApi.getPlayerUIntVar(actor,VarIntDef.LOGIN_DAY)
    if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) == 0  then
        return Sendmsg9(actor, "ffffff",  "需开通终身特权领取", 1) 
    end
    if day < tonumber(id) then
        return Sendmsg9(actor, "ffffff",  "累计登陆天数不足", 1) 
    end
    local tq_award_flag = json2tbl(VarApi.getPlayerTStrVar(actor,"T_login_gift_tq_award")) 
    if tq_award_flag == "" then
       tq_award_flag = {}
    end    
    for k, v in pairs(tq_award_flag) do
        if v and v.id == tonumber(id) then
            Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
            return
        end
    end      
  
    local cfg = nil
    for i,v in ipairs(map_cfg[act_type]) do
        if v.parame1 == tonumber(id) then
            cfg = v
            break 
        end
    end
    local list = {}
    if cfg == nil or type(cfg.award2_map) ~= "table" then
       return  
    end
    for k, v in pairs(cfg.award2_map) do
        table.insert(list,{name = k,count = v})
    end
    for i,v in ipairs(list) do
        local stdmode =  getstditeminfo(v.name,2)
        local count = v.count
        if  stdmode == 41 then  --货币
            changemoney(actor,getstditeminfo(v.name, 0),"+",count,"登录豪礼",true)
        else
            giveitem(actor,v.name,count,307)
        end
    end
    local str =  "福利大厅:恭喜<「%s」/FCOLOR=251>在福利大厅里额外领取<「第%s天」/FCOLOR=251>登录豪礼"
    local player_name = getbaseinfo(actor,1)
    Sendmsg13(actor,255, string.format(str,player_name,id) ,2,13)
    table.insert(tq_award_flag,{id =tonumber(id),state = 2})

    VarApi.setPlayerTStrVar(actor,"T_login_gift_tq_award",tbl2json(tq_award_flag))
    WelfareHall:FlushTeQuanGift(actor,act_type)
    lualib:ShowAwardTipUi(actor, list)
    lualib:SendDataClient(actor, "WelfareHall_flush#".. 1 .."#"..WelfareHall:GetloginRed(actor))
end
function WelfareHall:GetloginRed(actor)
    local day = VarApi.getPlayerUIntVar(actor,VarIntDef.LOGIN_DAY)
    for _,v in ipairs(map_cfg[1]) do
        if WelfareHall:GetLoginGiftState(actor,v.parame1)  ~= 2 then
            if day >= v.parame1 then
                return 1
            end
        end
        if WelfareHall:GetTqLoginGiftState(actor,v.parame1) ~= 2 and v.parame1 < 8 then
            if day >= v.parame1 then
                return 1
            end
        end
    end
    return 0
end
----------------------------------------------登录好礼-- end------------------------------------------

----------------------------------------------在线豪礼------------------------------------------------
function WelfareHall:FlushOnLine(actor)
    local minute = math.floor(getplaydef(actor,VarEngine.OnLine_TimeStamp) / 60)  
    local online_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_online_gift_award")) 
    if online_award_flag == "" then
        online_award_flag = {}
    end
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_online#".. tbl2json(online_award_flag).."#"..minute)
end
function WelfareHall:GetOnlineAward(actor,act_type,index)
    act_type = tonumber(act_type)
    index = tonumber(index)
    if act_type == nil or map_cfg[act_type] == nil then
        return   Sendmsg9(actor, "ff0000", "数据异常!", 1)
    end

    local cfg = map_cfg[act_type][index]
    if cfg == nil then
        return   Sendmsg9(actor, "ff0000", "数据异常!", 1)
    end
    local minute = math.floor(getplaydef(actor,VarEngine.OnLine_TimeStamp) / 60) 
    if minute < cfg.parame1 then
       return Sendmsg9(actor, "ffffff",  "累计在线不足"..cfg.parame1.."分钟", 1) 
    end
    local online_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_online_gift_award")) 
    if online_award_flag == "" then
        online_award_flag = {}
    end    
    for key, v in pairs(online_award_flag) do
        if v.is_get and v.index == index then
            Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
            return
        end
    end
    local list ={}
    for k, v in pairs(cfg.award1_map) do
        table.insert(list,{name = k,count = v})
    end
    
    if  VarApi.getPlayerJIntVar(actor,VarIntDef.DAY_RECHARGE)  > 0 then
        for k, v in pairs(cfg.award2_map) do
            table.insert(list,{name = k,count = v})
        end
    end
    for i,v in ipairs(list) do
        local stdmode =  getstditeminfo(v.name,2)
        local count = v.count
        if  stdmode == 41 then  --货币
            changemoney(actor,getstditeminfo(v.name, 0),"+",count,"在线豪礼",true)
        else
            giveitem(actor,v.name,count,307)
        end
    end

    lualib:ShowAwardTipUi(actor, list)
     local str =  "福利大厅:恭喜<「%s」/FCOLOR=251>在福利大厅里额外领取<「%s分」/FCOLOR=251>在线时长奖励"
    local player_name = getbaseinfo(actor,1)
    Sendmsg13(actor,255, string.format(str,player_name,cfg.parame1) ,2,13)


    table.insert(online_award_flag,{index = index,is_get = true}) 
    VarApi.setPlayerZStrVar(actor,"Z_online_gift_award",tbl2json(online_award_flag))
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_online#".. tbl2json(online_award_flag).."#"..minute)
    lualib:SendDataClient(actor, "WelfareHall_flush#".. 2 .."#"..WelfareHall:getOnlineRed(actor))
end
function WelfareHall:IsAlreadyReceived(actor,index)
    local online_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_online_gift_award")) 
    if online_award_flag == "" then
        return false
    end
    for k,v in pairs(online_award_flag) do
        if tonumber(v.index) == index then
            return v.is_get
        end
    end 
    return false
end
function WelfareHall:getOnlineRed(actor)
    local minute = math.floor(getplaydef(actor,VarEngine.OnLine_TimeStamp) / 60)  
    for _,v in ipairs(map_cfg[2]) do
        if minute >= v.parame1 and not WelfareHall:IsAlreadyReceived(actor,v.index) then
            return 1
        end
    end
    return 0
end
----------------------------------------------在线豪礼 end------------------------------------------------
---------------------------------------------成长奖励-----------------------------------------------------
function WelfareHall:FlushGrowUpGift(actor)
    local grow_up_award_flag = json2tbl(VarApi.getPlayerTStrVar(actor,"T_grow_up_gift_award")) 
    if grow_up_award_flag == "" then
        grow_up_award_flag = {}
    end
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_growup#".. tbl2json(grow_up_award_flag))
end
function WelfareHall:GetGrowUpAward(actor,get_type,type,index)
    type = tonumber(type)
    index = tonumber(index)
    local cfg = map_cfg[type][index]
    local list = {}
    local level_is_get,jj_is_get = WelfareHall:GetGrowUpIsGet(actor,index)
    release_print(level_is_get,jj_is_get)
    if get_type == "等级" then
        local double = 1
        if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) > 0 then
            double = 2
        end
        local role_level = getbaseinfo(actor, 6)
        if role_level < cfg.parame1 then
            return Sendmsg9(actor, "ffffff",  "等级不足", 1) 
        end
        if level_is_get then
            return Sendmsg9(actor, "ffffff",  "奖励已领取过!", 1) 
        end
        for k, v in pairs(cfg.award1_map) do
            table.insert(list,{name = k,count = double*v})
            changemoney(actor,getstditeminfo(k, 0),"+",double*v,"福利大厅领取",true)
        end
        WelfareHall:SetGrowUpFlag(actor,index,"level_award")
    elseif get_type == "境界" then
        local double = 1
        if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) > 0 then
            double = 2
        end
        local jj_level = VarApi.getPlayerUIntVar(actor, "l_masterLayer") 
        if jj_level < cfg.index then
            return Sendmsg9(actor, "ffffff",  "境界不足", 1) 
        end
        if jj_is_get then
            return Sendmsg9(actor, "ffffff",  "奖励已领取过!", 1) 
        end
        for k, v in pairs(cfg.award2_map) do
            table.insert(list,{name = k,count = double*v})
            changemoney(actor,getstditeminfo(k, 0),"+",double*v,"福利大厅领取",true)
        end
        WelfareHall:SetGrowUpFlag(actor,index,"jj_award")
    end

    local str =  "福利大厅:恭喜<「%s」/FCOLOR=251>在福利大厅里领取成长奖励"
    local player_name = getbaseinfo(actor,1)
    Sendmsg13(actor,255, string.format(str,player_name) ,2,13)
    lualib:ShowAwardTipUi(actor, list)

    local grow_up_award_flag = json2tbl(VarApi.getPlayerTStrVar(actor,"T_grow_up_gift_award")) 
    if grow_up_award_flag == "" then
        grow_up_award_flag = {}
    end
    
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_growup#".. tbl2json(grow_up_award_flag))
    lualib:SendDataClient(actor, "WelfareHall_flush#".. 3 .."#"..WelfareHall:GetGrowUpRed(actor))
end
function WelfareHall:SetGrowUpFlag(actor,id,key)
    local grow_up_award_flag = json2tbl(VarApi.getPlayerTStrVar(actor,"T_grow_up_gift_award")) 
    if grow_up_award_flag == "" then
        grow_up_award_flag = {}
    end
    local is_set = false
    for k, v in pairs(grow_up_award_flag) do
        if tonumber(v.id)  == tonumber(id) then
            v[key] = true
            is_set = true
        end
    end
    if is_set == false then
        table.insert(grow_up_award_flag,{id = id,[key] = true}) 
    end
    VarApi.setPlayerTStrVar(actor,"T_grow_up_gift_award",tbl2json(grow_up_award_flag))
end
function WelfareHall:GetGrowUpIsGet(actor,index)
    local grow_up_award_flag = json2tbl(VarApi.getPlayerTStrVar(actor,"T_grow_up_gift_award")) 
    if grow_up_award_flag == "" then
       return false 
    end
    for i,v in ipairs(grow_up_award_flag) do
        if tonumber(v.id) == tonumber(index) then
           return v.level_award,v.jj_award 
        end
    end
    return false,false
end

function WelfareHall:GetGrowUpRed(actor)
    for k, v in pairs(map_cfg[3]) do
        local level_award,jj_award = WelfareHall:GetGrowUpIsGet(actor,v.index)
        local role_level = getbaseinfo(actor, 6)
        local jj_level = VarApi.getPlayerUIntVar(actor, "l_masterLayer") 
        if role_level >= v.parame1 and not level_award then
           return 1
        elseif  jj_level >= v.index and not jj_award  then
            return 1
        end
    end 
    return 0
end
------------------------------------------------------end------------------------------------------
------------------------------------------------------充值回馈------------------------------------------
function WelfareHall:InitRechargeFeedback(actor)
    local day_recharge = VarApi.getPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE)
    local accumulate_recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)

    local recharge_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_recharge_back_gift_award")) 
    if recharge_award_flag == "" then
       recharge_award_flag = {}
    end
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","init_recharge#".. tbl2json(recharge_award_flag).."#"..day_recharge.."#"..accumulate_recharge)
end
function WelfareHall:GetRechargeBackAward(actor,type,index)
    local day_recharge = VarApi.getPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE)
    local accumulate_recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    local is_tq = VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) > 0
    type = tonumber(type)
    index = tonumber(index)
    local cfg = map_cfg[type][index]
    local get_recharge = cfg.parame1
    if index == 7 then
        if not WelfareHall:SpecialRechargeIndexCanGet(actor,day_recharge) then
            return Sendmsg9(actor, "ffffff",  "今日充值数量不足", 1) 
        end
    else
        if day_recharge < cfg.parame1 then
           return Sendmsg9(actor, "ffffff",  "今日充值数量不足", 1) 
        end
        if  WelfareHall:RechargeIsGet(actor,index) then
            return Sendmsg9(actor, "ffffff",  "奖励已领取过", 1) 
        end
    end

    local list ={}
    for k, v in pairs(cfg.award1_map) do
        table.insert(list,{name = v[1],count = v[2]})
    end
    if is_tq then
        for k, v in pairs(cfg.award2_map) do
            table.insert(list,{name = v[1],count = v[2]})
        end
    end
    for i,v in ipairs(list) do
        local stdmode =  getstditeminfo(v.name,2)
        local count = v.count
        if  stdmode == 41 then  --货币
            changemoney(actor,getstditeminfo(v.name, 0),"+",count,"充值回馈",true)
        else
            if accumulate_recharge >= 68 then
                giveitem(actor,v.name,count,0)
            else
                giveitem(actor,v.name,count,307)
            end
        end
    end
    lualib:ShowAwardTipUi(actor, list)
    WelfareHall:SetRechargeBackFlag(actor,index,get_recharge)
    local recharge_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_recharge_back_gift_award")) 
    if recharge_award_flag == "" then
       recharge_award_flag = {}
    end
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_recharge#"..index.."#".. tbl2json(recharge_award_flag))
    lualib:SendDataClient(actor, "WelfareHall_flush#".. 4 .."#"..WelfareHall:GetRechargeRed(actor))
end
function WelfareHall:SetRechargeBackFlag(actor,id,day_recharge)
    local recharge_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_recharge_back_gift_award")) 
    if recharge_award_flag == "" then
       recharge_award_flag = {}
    end
    if tonumber(id) ~= 7 then
        table.insert(recharge_award_flag,{index = id,is_get = true,recharge = day_recharge}) 
    else
        local is_set = false
        for k, v in pairs(recharge_award_flag) do
            if tonumber(v.index) == 7 then
               is_set = true
            end
        end
        if is_set == false then
            table.insert(recharge_award_flag,{index = id,is_get = true,recharge = day_recharge}) 
        else
            for k, v in pairs(recharge_award_flag) do
                if tonumber(v.index) == 7 then
                   v.recharge = v.recharge + day_recharge
                end
            end
        end
    end
    VarApi.setPlayerZStrVar(actor,"Z_recharge_back_gift_award",tbl2json(recharge_award_flag))
end

function WelfareHall:RechargeIsGet(actor,index)
    local recharge_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_recharge_back_gift_award")) 
    if recharge_award_flag == "" then
        return false
    end
    for k, v in pairs(recharge_award_flag) do
        if index == tonumber(v.index) then
            return v.is_get
        end
    end
    return false
end
function WelfareHall:SpecialRechargeIndexCanGet(actor,day_recharge)
    local recharge_award_flag = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_recharge_back_gift_award")) 
    if recharge_award_flag == "" then
       recharge_award_flag = {}
    end
    for k, v in pairs(recharge_award_flag) do
        if tonumber(v.index) == 7 then
            if v.recharge >= 100 then
                return day_recharge - v.recharge >= 100
            else
                return day_recharge >= 100
            end
        end
    end
    return day_recharge >= 100
end

function WelfareHall:GetRechargeRed(actor)
     local day_recharge = VarApi.getPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE)
    for k, v in pairs(map_cfg[4]) do
        if v.index == 7 then
            if WelfareHall:SpecialRechargeIndexCanGet(actor,day_recharge) then
                return 1
            end 
        else
            if day_recharge >= v.parame1 and not WelfareHall:RechargeIsGet(actor,v.index) then
                return 1
            end
        end
    end 
    return 0
end
---------------------------------------------------------end-------------------------------------------
---------------------------------------------------------客服豪礼-------------------------------------------
function WelfareHall:InitService(actor)
    local is_get = VarApi.getPlayerUIntVar(actor,"U_service_gift_award")
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_service#"..is_get)
end
function WelfareHall:GetServiceAward(actor,act_type)
    act_type = tonumber(act_type)
    if act_type == nil then
        Sendmsg9(actor, "ffffff",  "数据异常", 1) 
        return
    end
    if map_cfg[act_type] == nil then
        Sendmsg9(actor, "ffffff",  "数据异常", 1) 
        return
    end
    local cfg = map_cfg[act_type][1]
    local is_get = VarApi.getPlayerUIntVar(actor,"U_service_gift_award")
    local list ={}
    if is_get > 0 then
       return  Sendmsg9(actor, "ffffff",  "奖励已领取过", 1) 
    end
    if type(cfg.award1_map) ~= "table" then
        Sendmsg9(actor, "ffffff",  "数据异常", 1) 
        return
    end
    for k, v in pairs(cfg.award1_map) do
        table.insert(list,{name = v[1],count = v[2]})
    end
    for i,v in ipairs(list) do
        local stdmode =  getstditeminfo(v.name,2)
        local count = v.count
        if stdmode == 41 then  --货币
            changemoney(actor,getstditeminfo(v.name, 0),"+",count,"客服豪礼",true)
        else
            giveitem(actor,v.name,count,307)
        end
    end
    lualib:ShowAwardTipUi(actor, list)
    VarApi.setPlayerUIntVar(actor,"U_service_gift_award",1)
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_service#"..1)
    if VarApi.getPlayerUIntVar(actor, "U_navigation_task_step") == 1 then
        newcompletetask(actor, 101)
    end
    lualib:SendDataClient(actor, "WelfareHall_flush#".. 5 .."#"..WelfareHall:GetServiceRed(actor))
end
function WelfareHall:GetServiceRed(actor)
    if  VarApi.getPlayerUIntVar(actor,"U_service_gift_award") < 1 then
       return 1
    end
    return 0
end
---------------------------------------------------------end-------------------------------------------

---------------------------------------------------------合区特惠-------------------------------------------
function WelfareHall:InitMergeGift(actor)
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_merge")
end
function WelfareHall:BuyMergerGift(actor,index,num,limit_num) --#region boxIndex
    local hefu_count = getsysvar(VarEngine.HeFuCount)
    index = tonumber(index)
    local buy_num = 0
    if num == "1" then
        buy_num = 1
    elseif num == "2" then
        buy_num = 10
    else
        buy_num = 100
    end
    local buy_list = json2tbl(VarApi.getPlayerZStrVar(actor,"Z_gift_thlb")) 
    if buy_list == "" or buy_list == nil then
        buy_list = {}
    end
    local time = buy_list[tostring(hefu_count)..tostring(index)] or 0
    if time + buy_num > tonumber(limit_num) then
        return Sendmsg9(actor, "ffffff",  "购买次数不足！", 1) 
    end
    local gift_hefu_key = hefu_count
    if gift_hefu_key >=5 then
        gift_hefu_key = 5
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_thlb"..gift_hefu_key..index,buy_num,"WelfareHallOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end
---------------------------------------------------------end-------------------------------------------
---------------------------------------------------------惊喜魔盒-------------------------------------------
function WelfareHall:InitSurpriseBoxInfo(actor)
    local critical = VarApi.getPlayerUIntVar(actor,"J_surpise_box_critical")
    local double = VarApi.getPlayerJIntVar(actor,"J_surpise_box_double")
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_surprisebox#"..critical.."#"..double)
end
function WelfareHall:BuySurpriseBox(actor,btn_index)
    btn_index = tonumber(btn_index)
    local number = 0 --#region 购买次数
    if btn_index == 1 then
        number = 1
    elseif btn_index == 2 then
        number = 10
    else
        number = 100
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_jxmh",number,"SurpriseBoxGiftObj") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end
function WelfareHall:OpenSurpriseBox(actor,type,btn_index)
    btn_index = tonumber(btn_index)
    type = tonumber(type)
    local num = btn_index
    if btn_index ~= 1 then
        num = 10
    end
    
    local cfg = map_cfg[type]
    if getbagitemcount(actor,"魔盒") < num then
       return  Sendmsg9(actor, "ffffff",  "魔盒数量不足！", 1) 
    end
    local list = {}
    table.insert(list,{name = cfg[1].award2_map,count = num})
    local duobei_num = 0
    for i = 1, num do
        if  takeitemex(actor,"魔盒",1,0,"惊喜魔盒") then
            local items = {}
            for i,v in ipairs(cfg) do
                table.insert(items,{weight=v.parame1,item = v}) 
            end
            local item =  weightedRandom(items).item
            local count_str = strsplit(item.parame2,"#")
            local count = math.random(tonumber(count_str[1]) ,tonumber(count_str[2]) )
            local critical = VarApi.getPlayerUIntVar(actor,"J_surpise_box_critical")
            local critical_odds = math.random(100)
            if critical < 1 then
               VarApi.setPlayerUIntVar(actor,"J_surpise_box_critical",10)
               critical = VarApi.getPlayerUIntVar(actor,"J_surpise_box_critical")
            end
            local is_critical = critical_odds < critical
            if is_critical then
                count = count * 2 
                VarApi.setPlayerUIntVar(actor,"J_surpise_box_critical",10)
                duobei_num = duobei_num + 1
            else
                VarApi.setPlayerUIntVar(actor,"J_surpise_box_critical",critical + 1)
            end
            local double = VarApi.getPlayerJIntVar(actor,"J_surpise_box_double")
            if double < 1  and VarApi.getPlayerJIntVar(actor,VarIntDef.DAY_RECHARGE) > 0 then
                count = count * 2
                VarApi.setPlayerJIntVar(actor,"J_surpise_box_double",1)
                VarApi.setPlayerUIntVar(actor,"J_surpise_box_critical",10) 
            end
          
            changemoney(actor,getstditeminfo(item.award1_map,0),"+",count,"魔盒开启",true)
            table.insert(list,{name = item.award1_map,count = count})
            giveitem(actor,item.award2_map,1,307,"魔盒获得")
        end
    end
    if btn_index == 1 then
        Sendmsg9(actor, "ffffff",  duobei_num < 1 and "开启成功!" or "开启成功，本次获得双倍收益！", 1) 
    else
        Sendmsg9(actor, "ffffff",  string.format("开启成功，本次获得%s次双倍收益！",duobei_num) , 1) 
    end
    lualib:ShowAwardTipUi(actor,list)
    local critical = VarApi.getPlayerUIntVar(actor,"J_surpise_box_critical")
    if critical < 1 then  critical = 10 end
    local double = VarApi.getPlayerJIntVar(actor,"J_surpise_box_double")
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_surprisebox#"..critical.."#"..double)
    lualib:SendDataClient(actor, "WelfareHall_flush#".. 7 .."#"..WelfareHall:GetSurpriseBoxRed(actor))
end
function WelfareHall:GetSurpriseBoxRed(actor)
    if getsysvar(VarEngine.HeFuCount) < 1 then return 0 end
    if getbagitemcount(actor,"魔盒") > 0 then
       return 1
    end
    return 0
end
---------------------------------------------------------end-------------------------------------------
---------------------------------------------------------首爆-------------------------------------------
function WelfareHall:InitFristEquip(actor)
    WelfareHall:flushFristEquipView(actor,0)
end
function WelfareHall:flushFristEquipView(actor,page)
    local list = json2tbl(getsysvar(VarEngine.FristEquip))
    if list == "" then
        list = {}
    end
    local frist_equip_flag = json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP)) 
    if frist_equip_flag == "" then
        frist_equip_flag = {}
    end
    local zstq_level = VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL)
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_frist_equip#"..tbl2json(list).."#".. tbl2json(frist_equip_flag) .."#"..page .. "#" ..zstq_level)
end
function WelfareHall:GetFristEquipAward(actor,page,key_name)
    key_name = tonumber(key_name)
    local cfg = frist_equip_cfg[key_name]
    if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) <= 0 then
       return  Sendmsg9(actor, "ffffff",  "未开通终身特权", 1) 
    end
    local frist_equip_flag = json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP)) 
    if frist_equip_flag == "" then
        frist_equip_flag = {}
    end

    if frist_equip_flag[cfg.equip_name] == nil or frist_equip_flag[cfg.equip_name] ~= 1 then
       return Sendmsg9(actor, "ffffff",  "未获得装备", 1) 
    end
    if frist_equip_flag[cfg.equip_name] and frist_equip_flag[cfg.equip_name] ==2 then
       return Sendmsg9(actor, "ffffff",  "请勿重复领取", 1) 
    end
    for i = 1, 3 do
        if cfg["award_num"..i] > 0 then
            local stdmode =  getstditeminfo(cfg["award_name"..i],2)
            if stdmode == 41 then  --货币
                changemoney(actor,getstditeminfo(cfg["award_name"..i], 0),"+",cfg["award_num"..i],"个人首爆",true)
            else
                giveitem(actor,cfg["award_name"..i],cfg["award_num"..i],307,"个人首爆")
            end
        end
    end
    frist_equip_flag[cfg.equip_name] = 2
    VarApi.setPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP,tbl2json(frist_equip_flag))
    Sendmsg9(actor, "ffffff",  "领取成功", 1) 
    WelfareHall:flushFristEquipView(actor,page)
    lualib:SendDataClient(actor, "WelfareHall_flush#".. 8 .."#"..WelfareHall:GetEquipDropRed(actor))
end
function WelfareHall:GetAllFristEquipAward(actor,page)
    local frist_equip_flag = json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP)) 
    if frist_equip_flag == "" then
        frist_equip_flag = {}
    end
    local is_get = false
    local all_list = {}
    for i,v in ipairs(frist_equip_cfg) do
        if frist_equip_flag[v.equip_name] and  frist_equip_flag[v.equip_name] == 1 then
             for i = 1, 3 do
                if v["award_num"..i] > 0 then
                    all_list[v["award_name"..i]] = (all_list[v["award_name"..i]] or 0) + v["award_num"..i]
                end
            end
            is_get = true
            frist_equip_flag[v.equip_name] = 2
        end
    end
    if is_get  then
        VarApi.setPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP,tbl2json(frist_equip_flag))
        local award_list = {}
        for k, v in pairs(all_list) do
            local stdmode =  getstditeminfo(k,2)
            if stdmode == 41 then  --货币
                changemoney(actor,getstditeminfo(k, 0),"+",v,"个人首爆",true)
            else
                giveitem(actor,k,v,307,"个人首爆")
            end
            table.insert(award_list,{name =k,count = v}) 
        end
        lualib:ShowAwardTipUi(actor,award_list)
        Sendmsg9(actor, "ffffff",  "领取成功", 1)     
        lualib:SendDataClient(actor, "WelfareHall_flush#".. 8 .."#"..WelfareHall:GetEquipDropRed(actor))
    else
        Sendmsg9(actor, "ffffff",  "没有可领取的奖励", 1) 
    end
    WelfareHall:flushFristEquipView(actor,page)
end
function WelfareHall:GetEquipDropRed(actor)
    local zstq_level = VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL)
    if  zstq_level < 1 then return 0 end
        for _,v in ipairs(frist_equip_cfg) do
        if WelfareHall:GetFristEuipState(actor,v.equip_name) == 1 then
            return 1
        end
    end
    return 0
end

--0 不可领 1 可领 2 已领取
function WelfareHall:GetFristEuipState(actor,name)
    local frist_equip_flag = json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP)) 
    if frist_equip_flag == "" then
        return 0
    end
    return frist_equip_flag[name]
end
---------------------------------------------------------end-------------------------------------------
---------------------------------------------------------珍宝掉落-------------------------------------------
function WelfareHall:InitEquipDropRecord(actor)
    local list = json2tbl(getsysvar(VarEngine.EquipDropRecord))
    if list == "" then
        list = {}
    end
    lualib:FlushNpcUi(actor,"WelfareHallOBJ","flush_equip_drop_record#"..tbl2json(list))
end
---------------------------------------------------------end-------------------------------------------

----------------------------------------------------------限时福利--------------------------------------

function WelfareHall:LimitWelfareHallBuy(actor,index)
    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
    if hasGift == "" then hasGift = {} end
    if hasGift["gift_xsfl"..index] then
        return Sendmsg9(actor, "ff0000", "当前限时福利已购买过！", 1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor, "gift_xsfl"..index, 1, "LimitWelfareObj") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
    local limit_end_time = VarApi.getPlayerUIntVar(actor,"U_limit_effect_end_time")
    limit_end_time = limit_end_time - os.time()
    if limit_end_time < 0 then
        limit_end_time = 0
    end
    lualib:FlushNpcUi(actor,"LimitWelfareObj", limit_end_time)
end
function WelfareHall:openLimitView(actor)
    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
    local can_open  = false
    for i = 1, 2 do
        if hasGift == "" or  hasGift["gift_xsfl"..i] == nil then
            can_open = true 
        end
    end
    if not can_open then return end
    local limit_end_time = VarApi.getPlayerUIntVar(actor,"U_limit_effect_end_time")
    if limit_end_time == 0 then
        limit_end_time = os.time() + 1800
        VarApi.setPlayerUIntVar(actor, "U_limit_effect_end_time", limit_end_time)
        VarApi.setPlayerUIntVar(actor, "U_limit_time", os.time() + 43200, true)
        LoginTrigger.CheckOpenLimitGiftTip(actor)
    end
    limit_end_time = limit_end_time - os.time()
    if limit_end_time < 0 then
        limit_end_time = 0
    end
    lualib:ShowNpcUi(actor, "LimitWelfareObj", limit_end_time)
end
---------------------------------------------------------end-------------------------------------------
---------------------------------------------------------Cdk兑换---------------------------------------
function WelfareHall:GetCdkAward(actor,str)
    for k, v in pairs(cdk_cfg) do
        if v.gift_key == str then
            if not WelfareHall:GetCdkCanget(actor,v)  then
                return Sendmsg9(actor, "ffffff", "兑换码已领取过!", 1)
            end
            local award_list = strsplit(v.gift_award,"|")
            for i,v in ipairs(award_list) do
                local award = strsplit(v,"#")
                local stdmode =  getstditeminfo(award[1],2)
                if  stdmode == 41 then  --货币
                    changemoney(actor,getstditeminfo(award[1], 0),"+", tonumber(award[2]),"cdk兑换",true)
                else
                    giveitem(actor,award[1],tonumber(award[2]),307)
                end
            end
            if v.limit and v.limit > 0 then
                local server_get_list = json2tbl(getsysvar(VarEngine.CdkNum))
                if server_get_list == "" then
                    server_get_list  ={}
                end
                server_get_list[v.gift_key] = {key = v.gift_key}
                setsysvar(VarEngine.CdkNum,tbl2json(server_get_list))
            else
                local cdk_get_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_cdk_get_list")) 
                if cdk_get_list == "" then
                    cdk_get_list = {}
                end
                cdk_get_list[v.gift_key] = {key = v.gift_key}
                VarApi.setPlayerTStrVar(actor,"T_cdk_get_list",tbl2json(cdk_get_list))
            end
            return Sendmsg9(actor, "ffffff", "恭喜您兑换码已领取成功！", 1)
        end
    end
    return Sendmsg9(actor, "ffffff", "兑换码错误", 1)
end
function WelfareHall:GetCdkCanget(actor,data)
    if data.limit and data.limit > 0 then
        local server_get_list = json2tbl(getsysvar(VarEngine.CdkNum))
        if server_get_list == "" then
           return true
        end
        for k, v in pairs(server_get_list) do
            if v.key == data.gift_key then
                return false
            end
        end
    else
        local cdk_get_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_cdk_get_list")) 
        if cdk_get_list == "" then
            return true
        end
        for k, v in pairs(cdk_get_list) do
            if v.key == data.gift_key then
                return false 
            end
        end
    end
    return true
end
----------------------------------------------------------end-------------------------------------------
function WelfareHall:flushRedData(actor)
    if WelfareHall:GetloginRed(actor) > 0 or 
        WelfareHall:getOnlineRed(actor) > 0 or
        WelfareHall:GetGrowUpRed(actor) > 0 or
        WelfareHall:GetRechargeRed(actor) > 0 or
        WelfareHall:GetServiceRed(actor) > 0 or
        -- WelfareHall:GetbuyOpRed(actor) > 0 or
        WelfareHall:GetSurpriseBoxRed(actor) > 0 or
        WelfareHall:GetEquipDropRed(actor) > 0  then        
        return 1
    end
    return 0
end
function WelfareHall:FlushSigleRedData(actor)
    for k, v in pairs(map_cfg) do
        if v[1].type == 1 then
            lualib:SendDataClient(actor, "WelfareHall#".. 1 .."#"..WelfareHall:GetloginRed(actor))
        elseif v[1].type == 2 then 
            lualib:SendDataClient(actor, "WelfareHall#".. 2 .."#"..WelfareHall:getOnlineRed(actor))
        elseif v[1].type == 3 then
            lualib:SendDataClient(actor, "WelfareHall#".. 3 .."#"..WelfareHall:GetGrowUpRed(actor))
        elseif v[1].type == 4 then
            lualib:SendDataClient(actor, "WelfareHall#".. 4 .."#"..WelfareHall:GetRechargeRed(actor))
        elseif v[1].type == 5 then
            lualib:SendDataClient(actor, "WelfareHall#".. 5 .."#"..WelfareHall:GetServiceRed(actor))
        -- elseif v[1].type == 6 then
        --     lualib:SendDataClient(actor, "WelfareHall#".. 6 .."#"..WelfareHall:GetbuyOpRed(actor))
        elseif v[1].type == 7 then
            lualib:SendDataClient(actor, "WelfareHall#".. 7 .."#"..WelfareHall:GetSurpriseBoxRed(actor))
        elseif v[1].type == 8 then
            lualib:SendDataClient(actor, "WelfareHall#".. 8 .."#"..WelfareHall:GetEquipDropRed(actor))
        end      
    end
end
return WelfareHall