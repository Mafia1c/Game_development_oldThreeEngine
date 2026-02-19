-- 被攻击前触发
BeforeBeingAttackedTrigger = {}
BeforeBeingAttackedTrigger.zhanshen_buff_var = 0
BeforeBeingAttackedTrigger.mofa_skill = {8, 11, 22, 23, 24, 31, 33,84,13,52,57,86}
--#region 人物被攻击前触发(玩家对象，攻击对象，受击对象(玩家)，技能id，伤害，本次攻击标记(0-正常，1-暴击，2-格挡)，return为修改后伤害)
function BeforeBeingAttackedTrigger.struckdamage(actor,Hiter,Target,MagicId,Damage,Model)
    local buff_list = getallbuffid(Target)
    if checkkuafuserver() then
        buff_list = {}
        local buff_str = VarApi.getPlayerTStrVar(actor, "T_kuafu_buff_info")
        local tmp_list = strsplit(buff_str, "#")
        if type(tmp_list) == "table" then
            for k, v in pairs(tmp_list) do
                buff_list[k] = tonumber(v)
            end
        end
    end    

    local rand_number = math.random(100) --#region 随机数
    addbuff(Target, 50060)

    if getbaseinfo(Hiter,-1) then --#region 攻击者为玩家
        if VarApi.getPlayerUIntVar(Target, "UL_godPerson") > VarApi.getPlayerUIntVar(Hiter, "UL_godPerson") then --#region 圣灵境界
            Damage = math.floor(Damage*0.85)
        elseif VarApi.getPlayerUIntVar(Hiter, "UL_landGod") ~= 1 and VarApi.getPlayerUIntVar(Target, "UL_landGod") == 1 then --#region 陆地仙人
            Damage = math.floor(Damage*0.9)
        end
        if tonumber(getconst(Target,"<$CUSTABIL[251]>")) > 0 and type(tonumber(MagicId)) == "number" then --#region 龙虎天师技能抵抗
            Damage = math.floor(Damage*(1-tonumber(getconst(Hiter,"<$CUSTABIL[251]>"))*0.01))
        end
    else --#region 为怪物

    end

    if VarApi.getPlayerUIntVar(actor,"U_bawangXY")==1 and rand_number <= 1 then
        Damage = math.floor(Damage * 0.8) --#region 霸王项羽(SP装扮)20%减伤
        sendmsg(actor, 1, '{"Msg":"霸王项羽【金刚护体】免疫20%伤害！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        -- Sendmsg9(Target, "00ff00", "霸王项羽【金刚护体】免疫20%伤害！", 1)
        local msgTab = {
                ["Msg"] = "BUFF【金刚护体】触发：本次免疫20%伤害！",
                ["FColor"] = 219,["BColor"] = 255,["Type"] = 8,
        }
        sendmsg(actor, 1, tbl2json(msgTab))
    end



    if VarApi.getPlayerUIntVar(Target, "U_in_xunhang") == 1 and getbaseinfo(Hiter,-1) then
        local info = VarApi.getPlayerTStrVar(Target, "T_map_xun_hang")
        if info == nil or info == "" then
            info = "-1|-1|-1#0|1|0|0"
        end
        local tab = strsplit(info, "#")
        local state = strsplit(tab[2], "|")

        local cur_hp = getbaseinfo(Target,9)
        local max_hp = getbaseinfo(Target,10)
        local hp_cd =  VarApi.getPlayerUIntVar(Target, "U_xunhang_cd"..1)
        local attack_cd =  VarApi.getPlayerUIntVar(Target, "U_xunhang_cd"..3)
        if (cur_hp / max_hp) * 100 < 50 and tonumber(state[1]) > 0 and os.time() - hp_cd > 60  then
            VarApi.setPlayerUIntVar(Target, "U_in_xunhang",0)
            mapmove(Target, 3, 333,333,5)
            VarApi.setPlayerUIntVar(Target, "U_xunhang_cd"..1,os.time())
        end
        if getbaseinfo(Target,-1) and  tonumber(state[3]) > 0 and os.time() - attack_cd > 60 then  
            OtherTrigger:XunHangRandomMap(Target)
        end
    end
    if isInTable(buff_list, 50023) and  not isInTable(buff_list, 60014)  then
        local max_hp = getbaseinfo(Target,10)
        local cur_hp = getbaseinfo(Target,9)
        if cur_hp <= max_hp * 0.8 then
            local lossPercent = (max_hp - cur_hp) / max_hp * 100
            local unitsLost = math.floor(lossPercent / 5)

            if unitsLost >  0 then
                local str = string.format('{"Msg":"血脉泰坦BUFF触发，本次回复生命：%s%%血量！","FColor":0,"BColor":255,"Type":1,"Time":1}',unitsLost)
                sendmsg(Target, 1, str)
            end
            --需要定时器
            if not hastimer(Target, 50023) then
                setontimer(Target, 50023,1,0,1)
            end
         
        end
    end
    if isInTable(buff_list, 50049) then
        local max_hp = getbaseinfo(Target,10)
        local cur_hp = getbaseinfo(Target,9)
        local timestamp = VarApi.getPlayerUIntVar(Target,"U_50049_buff_cd_timestamp") 
        if cur_hp <= max_hp * 0.3 and os.time() - timestamp > 120 then
            VarApi.setPlayerUIntVar(Target,"U_50049_buff_cd_timestamp",os.time()) 
            -- changemode(actor,1,2)
            addbuff(Target,50065,2)
            changespeedex(Target,1,20,2)
             sendattackeff(Target,147)
            sendmsg(Target, 1, '{"Msg":"BUFF【名刀】触发：获得无敌状态，移速增加50%，持续2秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        end
    end
  
    if getbaseinfo(Hiter,-1) then --#region 当前攻击者为玩家 
        local timestamp = VarApi.getPlayerUIntVar(Target,"U_50050_buff_cd_timestamp") 
        if isInTable(buff_list, 50050) and os.time() - timestamp > 120 then
             sendattackeff(Target,143)
            VarApi.setPlayerUIntVar(Target,"U_50050_buff_cd_timestamp",os.time()) 
            sendmsg(Target, 1, '{"Msg":"BUFF【辉月】触发：2秒内免疫所有伤害，接触效果后刷新所有技能CD！","FColor":251,"BColor":0,"Type":6,"Time":1}')
            makeposion(Target,12,2)
            -- changemode(actor,1,2)
            addbuff(Target,50065,2)
            if not hastimer(Target,50050) then
                setontimer(Target, 50050, 2, 1,1)
            end
        end

        timestamp = VarApi.getPlayerUIntVar(Target,"U_50054_buff_cd_timestamp") 
        if isInTable(buff_list, 50054) and os.time() - timestamp > 120 then
            local max_hp = getbaseinfo(Target,10)
            if Damage >= max_hp*0.1 then
                sendattackeff(Target,144)
                lualib:SendDataClient(Hiter, "open_buff_dark")
                VarApi.setPlayerUIntVar(Target,"U_50054_buff_cd_timestamp",os.time()) 
                sendmsg(Target, 1, '{"Msg":"BUFF【极夜】触发：对方已进入极夜模式，视野降低，持续10秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
            end
        end

        rand_number = math.random(100) --#region 随机数
        timestamp = VarApi.getPlayerUIntVar(Target,"U_50058_buff_cd_timestamp") 
        if MagicId == 22 and isInTable(buff_list, 50058) and os.time() - timestamp > 120 then
            addbuff(Target,60012,10)
            VarApi.setPlayerUIntVar(Target,"U_50058_buff_cd_timestamp",os.time()) 
            
            sendmsg(Target, 1, '{"Msg":"BUFF【辟火】触发：20%几率免疫火墙伤害，持续10秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        end
        if MagicId == 22 and isInTable(buff_list, 60012) and rand_number <= 1 then
            Damage = 0
        end
    end
    local timestamp = VarApi.getPlayerUIntVar(Target,"U_title_10544_cd_timestamp") 
    if checktitle(Target,"全服最靓的仔") and getbaseinfo(Target,-1) then
        local occupation = getbaseinfo(actor,7) == 0 
        if occupation == 0 and  MagicId and  BeforeBeingAttackedTrigger.mofa_skill[MagicId] and  math.random(100) <= 1  then
            Damage = Damage - (Damage *0.3)
        elseif occupation == 1  then
            local cur_hp = getbaseinfo(Target,9)
            local max_hp = getbaseinfo(Target,10)
            if cur_hp < max_hp * 0.3 and  os.time() - timestamp > 90 then
                VarApi.setPlayerUIntVar(Target,"U_title_10544_cd_timestamp",os.time())
                changemode(Target,14,3)
                changemode(Target,16,3)
                changemode(Target,15,3)
                changemode(Target,17,3)
            end
        end
    end
    timestamp = VarApi.getPlayerUIntVar(Target,"U_50059_buff_cd_timestamp") 
    if isInTable(buff_list, 50059) and os.time() - timestamp > 120 then
        changemode(Target,2,10)
        sendattackeff(Target,146)
        sendmsg(Target, 1, '{"Msg":"BUFF【迷踪】触发：进入隐身状态，持续10秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        sendmsg(Target, 1, '{"Msg":"进入隐身模式！","FColor":0,"BColor":255,"Type":1,"Time":1}')
        VarApi.setPlayerUIntVar(Target,"U_50059_buff_cd_timestamp",os.time())
        VarApi.setPlayerUIntVar(Target,"U_inyinshen",1)
    end
    timestamp = VarApi.getPlayerUIntVar(Target,"U_50068_buff_cd_timestamp") 
    if isInTable(buff_list, 50068) and os.time() - timestamp > 120 and math.random(100) <= 1 then
        if checkkuafu(Target) then
            kfbackcall(1,getbaseinfo(Target,2),"addbuff",60013 ) --#region 自定义变量传递
        else
            addbuff(Target,60013,10)
        end
        VarApi.setPlayerUIntVar(Target,"U_50068_buff_cd_timestamp",os.time())
        sendattackeff(Target, 153)
        sendmsg(Target, 1, '{"Msg":"BUFF【破军】触发：暴击几率提升20%，持续10秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end
    timestamp = VarApi.getPlayerUIntVar(Target,"U_fhl_buff_cd_timestamp") 
    if checkitemw(Target,"「风火轮」",1) and timestamp > 120  and  math.random(100) <= 1 and  getbaseinfo(Hiter,-1) then
        VarApi.setPlayerUIntVar(Target,"U_fhl_buff_cd_timestamp",os.time())
        addbuff(Target,30007) 
        Sendmsg9(Target, "FFFF00", "「风火轮」法宝触发：免疫伤害的20%，持续10秒", 1)
    end
    if hasbuff(Target,30007) then
        Damage = Damage * 0.2
    end

    return Damage
end

-- 宝宝被攻击前触发
function BeforeBeingAttackedTrigger.struckdamagebb()
end
--玩家受击后物理受击  魔法受击后触发
function BeforeBeingAttackedTrigger.attackEnd(actor,Hiter,Target,MagicId)
    local buff_list = getallbuffid(Target)
    if checkkuafuserver() then
        buff_list = {}
        local buff_str = VarApi.getPlayerTStrVar(Target, "T_kuafu_buff_info")
        local tmp_list = strsplit(buff_str, "#")
        if type(tmp_list) == "table" then
            for k, v in pairs(tmp_list) do
                buff_list[k] = tonumber(v)
            end
        end
    end
    if isInTable(buff_list, 50020) then
        delattlist(Target,"战神buff属性")
        local max_hp = getbaseinfo(Target,10)
        local cur_hp = getbaseinfo(Target,9)
        local lossPercent = (max_hp - cur_hp) / max_hp * 100
        local unitsLost = math.floor(lossPercent / 10)
        if unitsLost > BeforeBeingAttackedTrigger.zhanshen_buff_var then
            BeforeBeingAttackedTrigger.zhanshen_buff_var = unitsLost
            sendattackeff(Target,130)
        elseif unitsLost <= 0 or unitsLost < BeforeBeingAttackedTrigger.zhanshen_buff_var then
            BeforeBeingAttackedTrigger.zhanshen_buff_var = unitsLost
        end
        addattlist(Target,"战神buff属性","+", "3#25#".. unitsLost*5)
    end
end
