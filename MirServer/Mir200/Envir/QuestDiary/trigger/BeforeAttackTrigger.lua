-- 攻击前触发
BeforeAttackTrigger = {}
BeforeAttackTrigger.yj_map = {["蛮荒禁地1"]=1,["迷惘洞窟1"]=1,["诅咒城堡1"]=1,["古老寺庙1"]=1,["永夜山谷1"]=1,["幽灵神舰1"]=1,["古老寺庙2"]=1,["古老寺庙3"]=1,["dt138"]=1,["古老寺庙4"]=1
,["永夜山谷2"]=1,["dyx01"]=1,["永夜山谷3"]=1,["幽灵神舰2"]=1,["幽灵神舰3"]=1,["幽灵神舰4"]=1,["幽灵神舰5"]=1,["dt079"]=1,["幽灵神舰6"]=1,["蛮荒禁地2"]=1,["dt097"]=1,["蛮荒禁地3"]=1
,["迷惘洞窟2"]=1,["迷惘洞窟3"]=1,["dt068"]=1,["迷惘洞窟4"]=1,["诅咒城堡2"]=1,["诅咒城堡3"]=1,["诅咒城堡4"]=1,["诅咒城堡5"]=1,["dt062"]=1,["诅咒城堡6"]=1} --#region 异界地图
BeforeAttackTrigger.yj_monster = {["异界★军团长·泰拉尔"] = 0.2,["异界★★虚空之主·卡赞"] = 0.25,["异界★★★恶魔使者·路西法"]=0.3,["异界★★★★迷雾主宰·撒旦"]=0.4,["异界★★★★★天空之神·宙斯"]= 0.5}

-- 人物攻击前触发
--#region 人物攻击前触发(玩家对象，受击对象，攻击对象，技能id，伤害，当前攻击模式，return为修改后伤害)
function BeforeAttackTrigger.onPlayerAttack(actor, Target, Hiter, MagicId, Damage, Model)
    local buff_list = getallbuffid(Hiter)
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
    local is_monster = false
    local target_name = getbaseinfo(Target, 1)
    local map_id = getbaseinfo(Hiter, 3)        -- 当前所在地图id
    local pos_x, pos_y = getconst(Hiter, "<$X>"), getconst(Hiter, "<$Y>")
    addbuff(Hiter, 50060)
    
    if getbaseinfo(Target,-1) then --#region 当前被攻击者为玩家
        if VarApi.getPlayerUIntVar(Hiter, "UL_godPerson") > VarApi.getPlayerUIntVar(Target, "UL_godPerson") then --#region 圣灵境界
            Damage = math.floor(Damage*1.5)
            if math.random(100) <= 1 and (os.time()-VarApi.getPlayerUIntVar(Target,"U_tag_godPerson") >120) then
                VarApi.setPlayerUIntVar(Target,"U_tag_godPerson",os.time())
                setbaseinfo(Target,46,100)
                addbuff(Target,71,2,1)
            end
        elseif VarApi.getPlayerUIntVar(Hiter, "UL_landGod") == 1 and VarApi.getPlayerUIntVar(Target, "UL_landGod") ~= 1 then --#region 陆地仙人
            Damage = math.floor(Damage*1.1)
            if math.random(100) <= 1 and (os.time()-VarApi.getPlayerUIntVar(Target,"U_tag_landGod") >120) then
                VarApi.setPlayerUIntVar(Target,"U_tag_landGod",os.time())
                setbaseinfo(Target,46,100)
                addbuff(Target,71,2,1)
            end
        end
        if VarApi.getPlayerUIntVar(Hiter, "l_masterLayer") > VarApi.getPlayerUIntVar(Target, "l_masterLayer") then --#region 宗师境界
            Damage = math.floor(Damage*1.1)
        end
        if BeforeAttackTrigger.yj_map[getbaseinfo(Hiter,3)] and tonumber(getconst(Target,"<$CUSTABIL[250]>")) > 0 then --#region 龙虎天师异次元之力
            Damage = math.floor(Damage*(1+tonumber(getconst(Target,"<$CUSTABIL[250]>"))*0.0001))
        end
        if VarApi.getPlayerUIntVar(Hiter,"UL_luckEquip") > 0 and rand_number <= 1 then --#region 福装备12件触发
            makeposion(Target,12,2)
            Sendmsg9(Hiter, "00FF00", "触发12件福BUFF将对方冰冻2秒！", 1)
            Sendmsg9(Target, "00FF00", "对方玩家触发12件福BUFF将你冰冻2秒！", 1)
        end
    else --#region 为怪物
        is_monster = true  
        setplaydef(Hiter,"S1",getbaseinfo(Target,1))
        if getbaseinfo(Hiter,3) == "hd_hhzb" then
            changeexp(Hiter,"+",2000,false) 
        end
        local boss_name = getbaseinfo(Target,1)
        if BeforeAttackTrigger.yj_monster[boss_name] then
            Damage = Damage * BeforeAttackTrigger.yj_monster[boss_name]
        end
        -- 异界次元地图对怪物造成的伤害减少50%
        if BeforeAttackTrigger.yj_map[getbaseinfo(Hiter,3)] then
            Damage = Damage * 0.5
        end
    end

    if getiteminfo(actor, linkbodyitem(actor, 100), 7) == "紫气东来" and math.random(100) <= 1
        and os.time() - VarApi.getPlayerUIntVar(actor, "UL_magicEquipCD100") > 120 then  --#region 上古魔戒紫气东来
        VarApi.setPlayerUIntVar(actor, "UL_magicEquipCD100", os.time(), false)
        humanhp(Target,"-",math.floor(getbaseinfo(Target,9)*0.2))
        -- Sendmsg9(actor, "00FF00", "【上古魔戒】紫气东来BUFF触发：斩杀目标20%当前血量！", 1)
        sendmsg(actor, 1, '{"Msg":"【上古魔戒】紫气东来BUFF触发：斩杀目标20%当前血量！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end
    if getiteminfo(actor, linkbodyitem(actor, 101), 7) == "兵临城下" and math.random(100) <= 1
        and os.time() - VarApi.getPlayerUIntVar(actor, "UL_magicEquipCD101") > 120 then  --#region 上古魔戒兵临城下
        VarApi.setPlayerUIntVar(actor, "UL_magicEquipCD101", os.time(), false)
        rangeharm(actor,getbaseinfo(actor,4),getbaseinfo(actor,5),3,1,13,5,0,0)
        playeffect(Target,12002,0,0,1,0,0)
        -- Sendmsg9(actor, "00FF00", "【上古魔戒】兵临城下BUFF触发：对区域目标造成当前血量5%伤害！", 1)
        sendmsg(actor, 1, '{"Msg":"【上古魔戒】兵临城下BUFF触发：对区域目标造成当前血量5%伤害！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end
    if getiteminfo(actor, linkbodyitem(actor, 102), 7) == "金戈铁马" and math.random(100) <= 1
        and os.time() - VarApi.getPlayerUIntVar(actor, "UL_magicEquipCD102") > 120 then  --#region 上古魔戒金戈铁马
        VarApi.setPlayerUIntVar(actor, "UL_magicEquipCD102", os.time(), false)
        humanhp(Target,"-",Damage)
        playeffect(Target,13119,0,0,1,0,0)
        -- Sendmsg9(actor, "00FF00", "【上古魔戒】金戈铁马BUFF触发：造成双倍伤害，无敌一秒！", 1)
        sendmsg(actor, 1, '{"Msg":"【上古魔戒】金戈铁马BUFF触发：造成双倍伤害，无敌一秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end
    if getiteminfo(actor, linkbodyitem(actor, 103), 7) == "烽火连城" and math.random(100) <= 1
        and os.time() - VarApi.getPlayerUIntVar(actor, "UL_magicEquipCD103") > 120 then  --#region 上古魔戒烽火连城
        VarApi.setPlayerUIntVar(actor, "UL_magicEquipCD103", os.time(), false)
        rangeharm(actor,getbaseinfo(actor,4),getbaseinfo(actor,5),3,1,13,10,0,0)
        playeffect(Target,13125,0,0,1,0,0)
        sendmsg(actor, 1, '{"Msg":"【上古魔戒】烽火连城BUFF触发：对区域目标造成当前血量10%伤害！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end

    if isInTable(buff_list, 50016) and  math.random(100) <= getbaseinfo(Hiter,51,209) then 
        humanhp(Hiter,"+",Damage*0.1)
        -- sendmsg(actor, 1, '{"Msg":"天赋_贪狼BUFF触发！！","FColor":0,"BColor":255,"Type":1}')
    end

    if isInTable(buff_list, 50018) and  math.random(100) <= 1 then
        Damage = Damage + Damage
        sendattackeff(Hiter,111)
        sendmsg(Hiter, 1, '{"Msg":"BUFF【连击】触发：再次释放一次技能！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end
    if isInTable(buff_list, 50019) and  math.random(100) <= 1 then
        local max_hp = getbaseinfo(Target,10)
        local cur_hp = getbaseinfo(Target,9)
        if cur_hp >= max_hp*0.9 then
            addhpper(Target,"=",90)
            sendattackeff(Hiter,118)
            sendmsg(Hiter, 1, '{"Msg":"BUFF【斩杀】触发：斩杀目标10%血量！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        end
    end
   
    if isInTable(buff_list, 50021) and Model == 1 and not is_monster then
        addbuff(Target,50032,5,1,Hiter)
        sendmsg(Hiter, 1, '{"Msg":"BUFF【猎杀】触发：目标进入流血状态，持续5秒！  (只对人物生效)！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end

    if isInTable(buff_list, 50022) and  math.random(100) <= 1 and #clonelist(Hiter)<1 then
        recallself(Hiter,60,1,50)
        sendattackeff(Hiter,129)
        sendmsg(Hiter, 1, '{"Msg":"血脉【元素】触发：召唤分身成功，分身持续时间60秒","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end
    if isInTable(buff_list, 50024) or getiteminfo(Hiter,linkbodyitem(Hiter,1),7) == "幸运小红剑" or checktitle(Hiter,"新人福利") then
        makeposion(Target,0,60)
        if not checkhumanstate(Target,11,1) then
            if not is_monster and isInTable(buff_list, 50024) then
                sendattackeff(Target,131,0,actor)
            end
        end
    end

    if isInTable(buff_list, 50028) then
        local skill_rand = math.random(100) --#region 随机数
        if skill_rand <=1 then
            local list = {22,58}
            releasemagic(Hiter,list[math.random(2)],1,1,1,0)
            sendattackeff(Hiter,120)
        end
    end
    local timestamp = VarApi.getPlayerUIntVar(Hiter,"U_50031_buff_cd_timestamp") 
    if isInTable(buff_list, 50031) and os.time() - timestamp > 60  and not isInTable(buff_list, 60014) then
        VarApi.setPlayerUIntVar(Hiter,"U_50031_buff_cd_timestamp",os.time()) 
        changemode(Hiter,19,10,30,50)
        setontimer(Hiter,50031,10,1,1)
        playeffect(Hiter,15257,0,0,0,0,0)
        sendattackeff(Hiter,121)
        sendmsg(Hiter, 1, '{"Msg":"BUFF【金刚】触发：10秒内获得30%伤害减少！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end

    if isInTable(buff_list, 60001) and getbaseinfo(Hiter,7) == 0 and is_monster == false then
        Damage = Damage + Damage * 0.3
        -- sendmsg(actor, 1, '{"Msg":"血脉_屠夫BUFF触发！！","FColor":0,"BColor":255,"Type":1}')
    end

    timestamp = VarApi.getPlayerUIntVar(Hiter,"U_50052_buff_cd_timestamp") 
    if isInTable(buff_list, 50052) and Model == 1 and os.time() - timestamp > 120 then
        VarApi.setPlayerUIntVar(Hiter,"U_50052_buff_cd_timestamp",os.time()) 
        Damage = Damage + Damage * 0.5
        sendattackeff(Hiter,152)
        sendmsg(Hiter, 1, '{"Msg":"BUFF【无尽】触发：本次暴击伤害提升50%！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end

    if isInTable(buff_list, 60011) then
        Damage = Damage + getbaseinfo(actor,22)
    end
    
    timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60002_buff_cd_timestamp") 
    if isInTable(buff_list, 60002) and os.time() - timestamp > 60 and  math.random(100) <= 1 then
        addbuff(Target,60014,3)
        VarApi.setPlayerUIntVar(Hiter,"U_60002_buff_cd_timestamp",os.time()) 
        sendmsg(Hiter, 1, '{"Msg":"無双血脉【嘲讽】BUFF触发，目标：金刚、泰坦、霸者被封印3秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        
        sendmsg(Target, 1, '{"Msg":"你被对方[嘲讽BUFF]打中，金刚、泰坦、霸者被封印3秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end

    timestamp = VarApi.getPlayerUIntVar(Hiter,"U_50055_buff_cd_timestamp") 
    if isInTable(buff_list, 50055) and Model == 1 and os.time() - timestamp > 120   then
        changespeedex(Hiter,1,20,3)
        VarApi.setPlayerUIntVar(Hiter,"U_50055_buff_cd_timestamp",os.time()) 
        sendattackeff(Hiter,142)
        sendmsg(Hiter, 1, '{"Msg":"BUFF【风暴】触发：移动速度增加30%，持续3秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    end
    timestamp = VarApi.getPlayerUIntVar(Hiter,"U_treasure_awake12_cd_timestamp")
    if VarApi.getPlayerUIntVar(Hiter, "UL_treasureAwake12") == 1 and os.time()-timestamp>120 and math.random(100)<=1 then --#region 神龙秘宝觉醒1%冰冻
        makeposion(Target,12,1)
        VarApi.setPlayerUIntVar(Hiter,"U_treasure_awake12_cd_timestamp",os.time())
        Sendmsg9(Hiter, "FFFF00", "【神龙秘宝】12星BUFF触发:将对方冰冻1秒！", 1)
        if getbaseinfo(Target,-1) then
            Sendmsg9(Target, "FFFF00", "【神龙秘宝】对方12星BUFF触发:将你冰冻1秒！", 1)
        end
    end
    if checkitemw(Hiter,"「混天绫」",1)  and  math.random(100) <= 1 and not is_monster then
        addbuff(Target,50073)
        Sendmsg9(Hiter, "FFFF00", "「混天绫」法宝触发：目标每秒扣除2%的生命值，持续10秒", 1)
    end
    if checkitemw(Hiter,"「乾坤圈」",1)  and  math.random(100) <= 1 and not is_monster then
        addbuff(Target,30005)
        Sendmsg9(Hiter, "FFFF00", "「乾坤圈」法宝触发：禁锢目标2秒", 1)
        Sendmsg9(Target, "FFFF00", "你被对方禁锢2秒", 1)
    end
    if  VarApi.getPlayerUIntVar(Hiter, "U_feijian_suit_state") > 0 and math.random(100) <= 1 and not is_monster then
        local buff_time = VarApi.getPlayerUIntVar(actor, "U_feijian_suit_state")
        makeposion(Target,12,buff_time)
        Sendmsg9(Hiter, "FFFF00", string.format("飞剑套装BUFF触发:将对方冰冻%s秒！",buff_time) , 1)
        Sendmsg9(Target, "FFFF00", string.format("飞剑套装BUFF触发:将你冰冻%s秒！",buff_time) , 1)
    end
    if is_monster and target_name == "黑暗魔君" then
        --黑暗魔君，血量3000万，5%HP时只吃切割伤害，1%HP时，3*3范围内有非行会成员，BOSS触发无敌
        local cur_hp = getbaseinfo(Target, 9)
        local max_hp = getbaseinfo(Target, 10)
        local my_guild_id = getguildinfo(Hiter, 0)
        if cur_hp <= max_hp * 0.01 then
            local role_list = getobjectinmap(map_id, pos_x, pos_y, 3, 1)
            for k, v in pairs(role_list) do
                local guild_id = getguildinfo(v, 0)
                if my_guild_id == -1 or my_guild_id ~= guild_id then
                    Damage = 0
                end
            end
        elseif cur_hp <= max_hp * 0.05 then
            if Model ~= 3 then
                Damage = 0
            end
        end
    end
    if getbaseinfo(Hiter,51,203) and is_monster and Model ~= 3 then
        local qiege_damage = getbaseinfo(Hiter,51,203) or 0
        local qiege_per = getbaseinfo(Hiter,51,204) or 0
        qiege_damage = qiege_damage + qiege_damage * (qiege_per / 100)
        if isInTable(buff_list, 50017) then
            qiege_damage = qiege_damage + Damage * 0.01
        end
        sendattackeff(Target,107,qiege_damage,actor)
        Damage = Damage + qiege_damage
    end
    local is_yinshen = VarApi.getPlayerUIntVar(actor,"U_inyinshen")
    if is_yinshen > 0 then
        changemode(actor,2,0)
        VarApi.setPlayerUIntVar(actor,"U_inyinshen",0)
    end
    -- 使用强化技能触发
    Damage = BeforeAttackTrigger.UseMasterSkillTrigger(actor, MagicId, Target,Damage)

    local _mon_tab = {"铁锤", "双头恶魔", "冰猿帝王", "墨菲特", "策划老白"}
    local t_name = getbaseinfo(Target, 1)
    if is_monster and isInTable(_mon_tab, t_name) and VarApi.getPlayerUIntVar(Hiter, "U_use_gamayaoji") == 1 then      -- 伽马药剂
        local max_hp = getbaseinfo(Target,10)
        Damage = max_hp * 0.9
        -- local cur_hp = getbaseinfo(Target,9)
        -- Damage = cur_hp * 0.9
        VarApi.setPlayerUIntVar(actor, "U_use_gamayaoji", 0)
    end

    if target_name == "卧龙夫人" then
        if Damage > 100000 then
            Damage = 100000
        end
        if Model == 3 then
            Damage = 0
        end
        if getbaseinfo(Hiter, -1) and Damage > 0 then
            -- giveitem(Hiter,"卧龙令*1",1,307,"攻击卧龙夫人获得")
            -- changemoney(Hiter, 26, "+", 1, "攻击卧龙夫人获得卧龙令!", true)
            KuaFuTrigger.kfbackcall99(Hiter, "卧龙令*1", "")
        end
    end
    -- local luckMon_list = {"子鼠启运兽", "丑牛耕耘兽", "寅虎驱邪兽", "卯兔捣药兽", "辰龙赐福兽", "巳蛇蜕厄兽","午马奔腾兽","未羊护生兽","申猴闹春兽","酉鸡报喜兽","戌狗守岁兽","亥猪纳福兽",}
    -- if isInTable(luckMon_list,target_name) then
    --     Damage = 0
    -- end

    return Damage
end
function ontimer50031(actor)
    clearplayeffect(actor,15257)
end

--#region 宠物攻击伤害前触发(玩家对象,目标对象,宠物对象,技能id,伤害值,是否主目标,return 修改后伤害)
function BeforeAttackTrigger.attackdamagepet(actor,target,petObj,magicID,damage,isImportant)
    if isplayer(target) then
        local buff_list = getallbuffid(target)
        if checkkuafu(target) then
            buff_list = {}
            local buff_str = VarApi.getPlayerTStrVar(target, "T_kuafu_buff_info")
            local tmp_list = strsplit(buff_str, "#")
            if type(tmp_list) == "table" then
                for k, v in pairs(tmp_list) do
                    buff_list[k] = tonumber(v)
                end
            end
        end
        local rand_number = math.random(100) --#region 随机数
        if isInTable(buff_list,60010) then
            damage = 0    
        end
        local timestamp = VarApi.getPlayerUIntVar(target,"U_50051_buff_cd_timestamp") 
        if isInTable(buff_list,50051) and  rand_number  <= 1 and  os.time() - timestamp > 120 then
            addbuff(target,60010,30)
            VarApi.setPlayerUIntVar(target,"U_50051_buff_cd_timestamp",os.time()) 
            sendmsg(target, 1, '{"Msg":"BUFF【通灵】触发：免疫宠物类攻击，持续30秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
            sendattackeff(target,151)
        end
    end
    return damage
end

-- 宝宝攻击前触发
function BeforeAttackTrigger.onPetAttack()

end

-- 使用强化技能触发
function BeforeAttackTrigger.UseMasterSkillTrigger(actor, MagicId, Target,Damage)
    local level = getskillinfo(actor, MagicId, 2)
    if level ~= 5 then
        return Damage
    end
    local rand_number = math.random(100)
    if rand_number > 1 then
        return Damage
    end
    local x, y = getbaseinfo(actor, 4), getbaseinfo(actor, 5)
    -- 开天斩
    if MagicId == 66 then
        makeposion(Target, 12, 1)
    end
    -- 驻日剑法
    if MagicId == 56 then
        local hp = getbaseinfo(Target, 9) * 0.1
        humanhp(actor, "+", hp)
    end
    -- 火墙
    if MagicId == 22 then
        local has_du = checkhumanstate(Target, 11, 1)
        if has_du then
            makeposion(Target, 1, 30)
        else
            makeposion(Target, 0, 30)
        end
    end
    -- 流星火雨
    if MagicId == 58 then
        rangeharm(actor, x, y, 3, 10, 13, 13)
    end
    -- 灵魂火符
    if MagicId == 13 then
        changemode(Target, 10, 1)
    end
    -- 旋风破
    if MagicId == 52 then
        local ds_value = gethumability(actor, 10)
        rangeharm(actor, x, y, 3, ds_value * 1.2, 0)
    end
    return Damage
end
