LoginTrigger = {}
LoginTrigger.skill_effect_cfg = {
	[31] = {"魔法盾", 3101, 12},
	[26] = {"烈火剑法", 2601},
	[66] = {"开天斩", 6601},
	[56] = {"逐日剑法", 5601},
	[22] = {"火墙", 2201, 46114},
	[58] = {"流星火雨", 5801},
	[13] = {"灵魂火符", 1301},
	[52] = {"飓风破", 5201}
}
local add_skills = {
    [0] = {3, 7, 12, 25, 26, 27},
    [1] = {8, 11, 22, 23, 24, 31, 33},
    [2] = {2, 4, 6, 13, 14, 15, 18, 19, 29, 30}
}

function LoginTrigger.firstLogin(actor)
    VarApi.setPlayerUIntVar(actor, VarIntDef.ENTER_TIME, os.time(), true)
    VarApi.setPlayerUIntVar(actor, VarIntDef.LOGIN_DAY, 1)
    LoginTrigger.loginAddSkills(actor)
    mapmove(actor, 3, 333, 333, 0)      --　跳转到盟重省333，333
    setbagcount(actor, 126)             --  设置背包格子
    changestorage(actor, 240)

    for k, v in pairs(VarCustomIntDef) do
        iniplayvar(actor, "integer", "HUMAN", v)
    end
    for k, v in pairs(VarCustomStrDef) do
        iniplayvar(actor, "string", "HUMAN", v)
    end
end

function LoginTrigger.login(actor)
    local blackTable = {"111.37.98.5"}
    if isInTable(blackTable,getconst(actor, "<$IPADDR>")) then
        RecordBackendOperationLog(actor, actor, "黑名单登陆", "", "")
        kick(actor)
        return
    end
    VarApi.Init(actor)

    local value = getconst(actor, "<$PLAYERPOWER>")
    VarApi.setPlayerUIntVar(actor, "战斗力", math.ceil(value / 100))
    changemoney(actor,11,"=",VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE),"登陆设置11货币总充值",true)

    --#region 玩家首次登陆触发
    if VarApi.getPlayerUIntVar(actor, VarIntDef.ENTER_TIME) == 0 then
        LoginTrigger.firstLogin(actor)
    end
    HeFuTrigger.userLogin(actor) --#region 合服触发

    local login_func = function ()
        --#region 玩家正常登陆触发
        if VarApi.getPlayerTStrVar(actor, VarStrDef.ICON_0) ~= "" then --#region 称号顶戴(0号位)
            local iconTab = strsplit(VarApi.getPlayerTStrVar(actor, VarStrDef.ICON_0),"#") --#region 称号名称#特效id#x偏移#y偏移
            seticon(actor,0,1,iconTab[2],iconTab[3],iconTab[4],1,0,0)
        end
        if VarApi.getPlayerTStrVar(actor, VarStrDef.ICON_2) ~= "" then --#region 称号顶戴,魂环(2号位)
            local iconTab = strsplit(VarApi.getPlayerTStrVar(actor, VarStrDef.ICON_2),"#") --#region 称号名称#特效id#x偏移#y偏移
            seticon(actor,2,1,iconTab[2],iconTab[3],iconTab[4],1,0,1)
        end
        if linkbodyitem(actor,45) ~= "0" and VarApi.getPlayerTStrVar(actor,"UL_disguise3") == "小恶魔(精灵)" then --#region 精灵顶戴(1号位置)
            seticon(actor,1,1,11900,-50,-60,1,0,0)
        end

        if hasbuff(actor,50057) then
            local skill_list = getallskills(actor)
            for k, v in pairs(skill_list or {}) do
                local skill_name = getskillname(v)
                setskilldeccd(actor,skill_name,"-",1)
            end
        end
        if checktitle(actor,"全服最靓的仔") then
            local skill_list = getallskills(actor)
            for k, v in pairs(skill_list or {}) do
                local skill_name = getskillname(v)
                local cur_cd = getskillcscd(skill_name)/1000
                local jm_per = 0
                local occupation = getbaseinfo(actor,7) 
                if occupation == 0 then
                    jm_per = cur_cd * 0.3
                elseif occupation == 1 then
                    jm_per = cur_cd * 0.1
                elseif occupation == 2 then
                    jm_per = cur_cd * 0.15
                end
                setskilldeccd(actor,skill_name,"-",jm_per)
            end
        end
        local pet_name = VarApi.getPlayerTStrVar(actor,"UL_disguise4")
        if pet_name ~= "" then
            createsprite(actor,"洛丽塔")
            VarApi.setPlayerTStrVar(actor,"UL_disguise4",pet_name,true)
        end

        VarApi.setPlayerUIntVar(actor, "U_actor_dice_value", 0, false) -- 登录时重置摇骰子标记 避免玩家在骰子还未出结果时小退或大退导致的意外情况
    end
    login_func()

    LoginTrigger.addBtns(actor)
    PlayerTimer.initPlayerTimer(actor)

    -- 检测是否删除天下第一称号
    local npc_class = IncludeNpcClass("WorldNo1ExtendNpc")
    if npc_class then
        npc_class:CheckDelWordNo1Title(actor, false)
    end
    npc_class = IncludeSysClass("OtherSysFunc")
    if npc_class then
        npc_class:addOneDayLookAttr(actor)
    end

    -- 五行之力装备更新属性
    npc_class = IncludeNpcClass("WuXingZhiLi")
    if npc_class then
        npc_class:loginUpdateWXZLAttr(actor)
    end

    setontimer(actor, 22222, 1, 0)
    LoginTrigger.changeSkillEffect(actor)

    if not getbaseinfo(actor, 48) then
        mapmove(actor, 3, 330, 330, 3)
    end

    local account_id = getconst(actor, "<$USERACCOUNT>")
    -- release_print("account_id: ", account_id)
    if isInTable(VarGmWhitePlayer, account_id) then
        setgmlevel(actor, 10)
    end
    LoginTrigger.CheckOpenLimitGiftTip(actor)
    LoginTrigger.FlushZhanQuText(actor)

    TaskTrigger.onLogin(actor, nil)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    if is_pc then
        delaygoto(actor, 1600, "_jump_to_func", 1)
    else
        delaygoto(actor, 600, "_jump_to_func", 1)
    end
    local per_huifu = getbaseinfo(actor,51,202)
    if per_huifu > 0 then
        local new_value = math.floor(per_huifu/10) 
        local jc_huifu = getbaseinfo(actor,51,71)
        addattlist(actor,"回复属性","+","3#71#".. math.floor(jc_huifu * (new_value/10)) )
    end

    local gs_userid_list = {"20780558"} --#region gs主播暗属性
    if isInTable(gs_userid_list,getconst(actor, "<$USERACCOUNT>")) then
        local number1,number2,number3,number4,number5,number6,number7,number8 = getsysvar(VarEngine.GsZQ),getsysvar(VarEngine.GsBJ)
        ,getsysvar(VarEngine.GsPK),getsysvar(VarEngine.GsGJ),getsysvar(VarEngine.GsPK2),getsysvar(VarEngine.GsHSFY),
        getsysvar(VarEngine.GsFBD),getsysvar(VarEngine.GsMFZ)
        if number1==0 then number1 = 50 end
        if number2==0 then number2 = 20 end
        if number3==0 then number3 = 20 end
        if number4==0 then number4 = 20 end
        if number5==0 then number5 = 50 end
        if number6==0 then number6 = 50 end
        if number7==0 then number7 = 90 end
        if number8==0 then number8 = 6000 end
        VarApi.setPlayerUIntVar(actor,"U_gsZQ_info",number1,true)
        VarApi.setPlayerUIntVar(actor,"U_gsBJ_info",number2,true)
        VarApi.setPlayerUIntVar(actor,"U_gsPK_info",number3,true)
        VarApi.setPlayerUIntVar(actor,"U_gsGJ_info",number4,true)
        VarApi.setPlayerUIntVar(actor,"U_gsPK2_info",number5,true)
        VarApi.setPlayerUIntVar(actor,"U_gsHSFY_info",number6,true)
        VarApi.setPlayerUIntVar(actor,"U_gsFZBD_info",number7,true)
        VarApi.setPlayerUIntVar(actor,"U_gsMFZ_info",number8,true)
        addattlist(actor,"gs_info_929","=",string.format("3#13#%s|3#21#%s|3#76#%s|3#25#%s|3#77#%s|3#28#%s|3#51#%s|3#2#%s"
        ,number1,number2,number3*100,number4,number5*100,number6,number7 *100,number8))
    end
    local flag = VarApi.getPlayerUIntVar(actor,"U_is_reset_xuemai_buff")
    if flag < 1 then
        local class = IncludeNpcClass("xuemai")
        if class then 
            class:resetBuffLayer(actor)
        end
    end
    local class = IncludeNpcClass("xuemai")
    if class then 
        class:flushBuffRevive(actor)
    end
    if IncludeNpcClass("donate") then --#region 捐献排行榜操作
        IncludeNpcClass("donate"):otherTitle(actor)
    end
    if IncludeNpcClass("zhuansheng") then --#region 转生登陆加属性(转职更改成长属性)
        IncludeNpcClass("zhuansheng"):logAddInfo(actor)
    end
    if IncludeNpcClass("luckTreasure") then --#region 祥瑞宝藏积分排行榜
        IncludeNpcClass("luckTreasure"):otherTitle(actor)
    end
    if IncludeNpcClass("treasureAwake") then --#region 登陆判断觉醒后设置绑定(新加)
        IncludeNpcClass("treasureAwake"):logSetBind(actor)
    end

    -- 专属装备根据充值觉得师傅绑定
    local npc_class = IncludeNpcClass("DivineDragonNpc")
    if npc_class then
        npc_class:updateEquipBindType(actor)
    end

    runTriggerCallBack("login", actor)
end

function _jump_to_func(actor)
    local _step = VarApi.getPlayerUIntVar(actor, "U_navigation_task_step")
    if _step == 0 then
        lualib:ShowNpcUi(actor, "GmBaoZhangOBJ", "")
    end
end

--跨天
function LoginTrigger.resetdayLogin(actor)
    local day = VarApi.getPlayerUIntVar(actor,VarIntDef.LOGIN_DAY)
    VarApi.setPlayerUIntVar(actor,VarIntDef.LOGIN_DAY,day + 1,true)
end
function ontimer22222(actor)
    local level = getskillinfo(actor, 31, 2)
    if level and level >= 5 then
        local cur_hp = getbaseinfo(actor, 9)
        local max_hp = getbaseinfo(actor, 10)
        local bool, endTime = checkhumanstate(actor,1)
        if bool then
            local rate = (max_hp - cur_hp) / (max_hp * 0.05)
            changehumnewvalue(actor, 77, rate * 100, endTime)
        else
            changehumnewvalue(actor, 77, 0, endTime)
        end
    end
end

function LoginTrigger.loginAddSkills(actor)
    local job = getbaseinfo(actor, 7)
    local _tab = add_skills[job]
    for k, v in pairs(_tab) do
        addskill(actor, v, 3)
    end
end

-- 改变技能特效
function LoginTrigger.changeSkillEffect(actor)
    for k, v in pairs(LoginTrigger.skill_effect_cfg) do
        local level = getskillinfo(actor, k, 2)
        if level and level >= 5 then
            setmagicskillefft(actor, v[1], v[2], v[3])
        end
    end
end

function LoginTrigger.addBtns(actor)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    local map_btn = {
        -- {8, 10000,"<Button|a=0|x=585|y=150|nimg=custom/bt_dz.png|text=联系客服|color=255|size=18|link=@call_map_func,1>"},
        -- {8, 10001,"<Button|a=0|x=585|y=190|nimg=custom/bt_dz.png|text=新人红卡|color=255|size=18|link=@call_map_func,2>"},
        -- {8, 10002,"<Button|a=0|x=585|y=180|nimg=custom/bt_dz.png|text=每日必看|color=255|size=18|link=@call_map_func,3>"},
        {8, 10003,"<Button|a=0|x=585|y=180|nimg=custom/bt_dz.png|text=公益捐献|color=255|size=18|link=@call_map_func,4>"},

        {8, 10005,"<Button|a=0|x=565|y=310|nimg=custom/minimap/an1.png|pimg=custom/minimap/an1.png|color=255|size=18|link=@go_home>"},
        {8, 10006,"<Button|a=0|x=565|y=365|nimg=custom/minimap/an2.png|pimg=custom/minimap/an2.png|color=255|size=18|link=@go_random>"},
        {8, 10007,"<Button|a=0|x=565|y=420|nimg=custom/minimap/an3.png|pimg=custom/minimap/an3.png|color=255|size=18|link=@map_move>"}
    }
    if is_pc then
        map_btn = {
            -- {8, 10000,"<Button|a=0|x=565|y=150|nimg=custom/bt_dz.png|text=联系客服|color=255|size=18|link=@call_map_func,1>"},
            -- {8, 10001,"<Button|a=0|x=565|y=190|nimg=custom/bt_dz.png|text=新人红卡|color=255|size=18|link=@call_map_func,2>"},
            -- {8, 10002,"<Button|a=0|x=565|y=180|nimg=custom/bt_dz.png|text=每日必看|color=255|size=18|link=@call_map_func,3>"},
            {8, 10003,"<Button|a=0|x=565|y=180|nimg=custom/bt_dz.png|text=公益捐献|color=255|size=18|link=@call_map_func,4>"},

            {8, 10005,"<Button|a=0|x=545|y=310|nimg=custom/minimap/an1.png|pimg=custom/minimap/an1.png|color=255|size=18|link=@go_home>"},
            {8, 10006,"<Button|a=0|x=545|y=365|nimg=custom/minimap/an2.png|pimg=custom/minimap/an2.png|color=255|size=18|link=@go_random>"},
            {8, 10007,"<Button|a=0|x=545|y=420|nimg=custom/minimap/an3.png|pimg=custom/minimap/an3.png|color=255|size=18|link=@map_move>"}
        }
    end
    for k, v in pairs(map_btn) do
        addbutton(actor, v[1], v[2], v[3])
    end
    local bag_btns = {
        {7, 10000,"<Button|a=0|x=52|y=405|nimg=private/bag_ui/bag_ui_mobile/bt.png|text=整理|color=255|size=18|link=@call_bag_func,1>"},
        {7, 10001,"<Button|a=0|x=152|y=405|nimg=private/bag_ui/bag_ui_mobile/bt.png|text=过滤|color=255|size=18|link=@call_bag_func,2>"},
        {7, 10002,"<Button|a=0|x=252|y=405|nimg=private/bag_ui/bag_ui_mobile/bt.png|text=回收|color=255|size=18|link=@call_bag_func,3>"},
        {7, 10003,"<Button|a=0|x=352|y=405|nimg=private/bag_ui/bag_ui_mobile/bt.png|text=仓库|color=255|size=18|link=@call_bag_func,4>"}
    }
    if is_pc then
        bag_btns = {
            {7, 10000,"<Button|a=0|x=-10|y=380|nimg=private/bag_ui/bag_ui_mobile/bt.png|text=整理|color=255|size=18|link=@call_bag_func,1>"},
            {7, 10001,"<Button|a=0|x=90|y=380|nimg=private/bag_ui/bag_ui_mobile/bt.png|text=过滤|color=255|size=18|link=@call_bag_func,2>"},
            {7, 10002,"<Button|a=0|x=190|y=380|nimg=private/bag_ui/bag_ui_mobile/bt.png|text=回收|color=255|size=18|link=@call_bag_func,3>"},
            {7, 10003,"<Button|a=0|x=290|y=380|nimg=private/bag_ui/bag_ui_mobile/bt.png|text=仓库|color=255|size=18|link=@call_bag_func,4>"}
        }
    end
    for k, v in pairs(bag_btns) do
        addbutton(actor, v[1], v[2], v[3])
    end

    local str = [[
        <Button|a=0|x=57|y=130.0|width=38|height=88|nimg=private/rank_ui/rank_ui_mobile/1900012110.png|pimg=private/rank_ui/rank_ui_mobile/1900012111.png|outlinecolor=0|outline=1|color=251|size=18|text=等\级\榜|link=@rank_page,1>
        <Button|a=0|x=57|y=220.0|width=38|height=88|nimg=private/rank_ui/rank_ui_mobile/1900012110.png|pimg=private/rank_ui/rank_ui_mobile/1900012111.png|outlinecolor=0|outline=1|color=251|size=18|text=战\力\榜|link=@rank_page,2>
    ]]
    addbutton(actor, 45, 1, str)
    if getbaseinfo(actor, 7) == 2 then
        local value = VarApi.getPlayerUIntVar(actor, "U_auto_call") 
        if getbaseinfo(actor, 47) then
            value = 1
        end
      
        local fight_str = [[
            <Text|id=0|x=480|y=140|color=255|size=16|text=自动召唤>
            <CheckBox|id=1|x=580|y=140|checkboxid=123|nimg=custom/g1.png|pimg=custom/k7.png|default=%s|link=@_change_call_state>
        ]]
        if is_pc then
            fight_str = [[
                <Text|id=0|x=400|y=140|color=255|size=16|text=自动召唤>
                <CheckBox|id=1|x=500|y=140|checkboxid=123|nimg=custom/g1.png|pimg=custom/k7.png|default=%s|link=@_change_call_state>
            ]]
        end
        fight_str = string.format(fight_str, value)
        addbutton(actor, 302, 10000, fight_str)
        VarApi.setPlayerUIntVar(actor, "U_auto_call", value)
    else
        delbutton(actor, 302, 10000)
        VarApi.setPlayerUIntVar(actor, "U_auto_call", 0)
    end
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count > 0 then
    local surprise_eff_tip = [[
        <Img|img=custom/npc/20fl/13/icon.png|x=310|y=-310|width=100|height=100|opacity=0|link=@open_surprise_box>
        <Effect|effectid=27580|effecttype=0|scale=0.6|x=350|y=-270|link=@open_surprise_box>
        <Button|x=330|y=-240|nimg=custom/npc/20fl/13/icon.png|pimg=custom/npc/20fl/13/icon.png|link=@open_surprise_box>
    ]]
    addbutton(actor, 103, 10004, surprise_eff_tip)
    end
    

    local test_btn = {
        {102, 100000,"<Button|a=0|x=-885|y=50|nimg=public/1900000652.png|text=开启攻城|color=255|size=18|link=@call_test_func,1>"},
        {102, 100001,"<Button|a=0|x=-885|y=90|nimg=public/1900000652.png|text=关闭攻城|color=255|size=18|link=@call_test_func,2>"},
    }
    for k, v in pairs(test_btn) do
        -- addbutton(actor, v[1], v[2], v[3])
    end
end
function LoginTrigger.CheckOpenLimitGiftTip(actor)
    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
    if hasGift == "" then hasGift = {} end
    if hasGift["gift_xsfl1"] and hasGift["gift_xsfl2"] then
       return  
    end
    local width = tonumber(getconst(actor, "<$SCREENWIDTH>")) or 1136
    local limit_gift_obj = [[
        <COUNTDOWN|x=%d|a=4|y=-175|time=%s|count=1|size=16|color=250|showWay=1|link=@limit_time_end>
        <Img|img=custom/top/an111.png|x=%d|y=-255|link=@open_limitgift_box>
    ]]
    if getconst(actor,"<$CLIENTFLAG>") == "1" then
        width = width * 0.45
        limit_gift_obj = [[
            <COUNTDOWN|x=%d|a=4|y=-225|time=%s|count=1|size=16|color=250|showWay=1|link=@limit_time_end>
            <Img|img=custom/top/an111.png|x=%d|y=-305|link=@open_limitgift_box>
        ]]
    else
        width = 485
    end
    local end_time = VarApi.getPlayerUIntVar(actor,"U_limit_time")
    if os.time() < end_time then
        local str = string.format(limit_gift_obj, width, end_time - os.time(), width - 40)
        addbutton(actor, 103, 10005, str)
    else
        VarApi.setPlayerUIntVar(actor,"U_limit_time",0,true) 
    end
end
function limit_time_end(actor)
    VarApi.setPlayerUIntVar(actor,"U_limit_time",0,true) 
    delbutton(actor, 103, 10005)
end
function LoginTrigger.FlushZhanQuText(actor)
    local mainServiceId = getconst(actor, "<$MAINTONGSERVER>")
    if tonumber(mainServiceId) > 0 then
        local serviceId = globalinfo(11)
        if tonumber(mainServiceId) == tonumber(serviceId) and  not io.open("QuestDiary/zhuanqu.ini","r") then
            --创建通区转区文件夹
            tongfile(0, '..\\QuestDiary\\zhuanqu.ini')
        else
            getmaintongfile(mainServiceId, '..\\QuestDiary\\zhuanqu.ini','..\\QuestDiary\\zhuanqu.ini')
        end
    end
end

function rank_page(actor, page)
    page = tonumber(page)
    openhyperlink(actor, 32, 2)
    openhyperlink(actor, 32, 1, page, 0)
end

function go_home(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end
    local random_num = getbagitemcount(actor, "盟重传送石")
    if random_num <= 0 then
        return Sendmsg9(actor, "ffffff", "您没有盟重传送石!", 1)
    end
    -- mapmove(actor, 3, 333,333,5)
    eatitem(actor, "盟重传送石", 1)
    openhyperlink(actor, 24, 2)
end

function go_random(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
    local random_num = getbagitemcount(actor, "随机传送石")
    if random_num <= 0 then
        return Sendmsg9(actor, "ffffff", "您没有随机传送石!", 1)
    end
    -- local map_id = getbaseinfo(actor, 3)
    -- map(actor, map_id)
    eatitem(actor, "随机传送石", 1)
    openhyperlink(actor, 24, 2)
end

function map_move(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    elseif checkmirrormap(getbaseinfo(actor, 3)) then
        Sendmsg9(actor, "ffffff", "镜像地图禁止使用！", 1)
        return
    end
    local map_list = {"0150","sss1","sss2","sss3","sss4","sss5","sss6","sss66","sss7","牛马庙","sss11","通天桥","ddnb","卧龙山庄","龙源秘境","卧龙祭坛","龙渊地牢","龙之巢穴","迷失之城","激情粽王","龙舟竞速"}
    local map_id = getbaseinfo(actor, 3)
    if isInTable(map_list, map_id) then
        Sendmsg9(actor, "ffffff", "此地图禁止使用传送!", 1)
        return
    end
    local cd_time = VarApi.getPlayerUIntVar(actor, "U_map_move_time")
    local cur_time = os.time()
    if cur_time - cd_time >= 10 then
        
        mapmove(actor, map_id, getconst(actor, "<$ToPointX>"), getconst(actor, "<$ToPointY>"))
        openhyperlink(actor, 24, 2)
        VarApi.setPlayerUIntVar(actor, "U_map_move_time", cur_time)
    else
        local remain_time = 10 - (cur_time - cd_time)
        return Sendmsg9(actor, "ffffff", "传送CD中, "..remain_time.."秒后恢复!", 1)
    end
end

-- op_type: 1.联系客服  2.新人红卡   3.每日必看   4.公益捐献
function call_map_func(actor, op_type)
    op_type = tonumber(op_type)
    if op_type == 1 then
        -- lualib:ShowNpcUi(actor, "CallServiceOBJ", "")
    elseif op_type == 2 then
        -- lualib:ShowNpcUi(actor, "NewPlayerOBJ", "")
    elseif op_type == 3 then
        -- lualib:ShowNpcUi(actor, "OneDayLockOBJ", "")
        Sendmsg9(actor, "ffffff", "功能维护中, 敬请期待!", 1)
    elseif op_type == 4 then
        local npc_class = IncludeNpcClass("donate")
        if npc_class and npc_class.click then
            npc_class:click(actor)
        end
    end
end

-- op_type: 1.整理  2.过滤   3.回收   4.仓库
function call_bag_func(actor, op_type)
    op_type = tonumber(op_type)
    if op_type == 1 then
        refreshbag(actor)
    elseif op_type == 2 then
        local filter_value = VarApi.getPlayerUIntVar(actor, "U_filterglobalmsg")
        local value = 0
        if filter_value == 0 then
            value = 1
        end
        filterglobalmsg(actor, value)
        VarApi.setPlayerUIntVar(actor, "U_filterglobalmsg", value)
        local str = "已关闭过滤全服提示信息!"
        if value == 1 then
            str = "已开启过滤全服提示信息, 将不再提示各类系统信息!"
        end
        Sendmsg9(actor, "ffffff", str, 1)
    elseif op_type == 3 then
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域无法使用!", 1)
            return
        end         
        local tmp_list = VarApi.getPlayerTStrVar(actor, "T_recycle_info")
        local tmp_str = VarApi.getPlayerTStrVar(actor, "T_recycle_state")
        if "" == tmp_str then
            tmp_str = tbl2json({"1", "1", "1"})
            VarApi.setPlayerTStrVar(actor, "T_recycle_state",tmp_str)
        end
        lualib:ShowNpcUi(actor, "RecycleOBJ", tmp_list.."#"..tmp_str)
    elseif op_type == 4 then
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域无法使用!", 1)
            return
        end 
        openstorage(actor)
    end

end

function _change_call_state(actor)
    local value = VarApi.getPlayerUIntVar(actor, "U_auto_call")
    if value == 1 then
        value = 0
    else
        value = 1
    end
    VarApi.setPlayerUIntVar(actor, "U_auto_call", value)

    delbutton(actor, 302, 10000)
    local fight_str = [[
        <Text|id=0|x=480|y=140|color=255|size=16|text=自动召唤>
        <CheckBox|id=1|x=580|y=140|checkboxid=123|nimg=custom/g1.png|pimg=custom/k7.png|default=%s|link=@_change_call_state>
    ]]
    if getconst(actor,"<$CLIENTFLAG>") == "1" then
        fight_str = [[
            <Text|id=0|x=400|y=140|color=255|size=16|text=自动召唤>
            <CheckBox|id=1|x=500|y=140|checkboxid=123|nimg=custom/g1.png|pimg=custom/k7.png|default=%s|link=@_change_call_state>
        ]]
    end
    fight_str = string.format(fight_str, value)
    addbutton(actor, 302, 10000, fight_str)    
end

function _change_cs_state(actor)
end

function call_test_func(actor, op_type)
    op_type = tonumber(op_type)
    if op_type == 1 then
        -- createsprite(actor, "拾取小精灵")
        -- pickupitems(actor, 0, 5, 0.5)
        -- openhyperlink(actor, 36, 0)
        -- seticon(actor, 9, 1, 46125, 0, 0, 1, 0, 1)
        -- sendmapmsg("hd_cfgc", '{"Msg":"测试发送地图消息!","FColor":249,"BColor":255,"Type":11,"Time":3,"SendName":"[提示]","SendId":"123"}')
        -- sendmsgnew(actor, 255,249, "测试主屏幕弹出公告!", 1, 5)
        -- ChuanQiPuBg.initPubg("hd_cfgc",  0)
        -- map(actor, ChuanQiPuBg.cfg.map_id)
        -- ChuanQiPuBg.startPubg(ChuanQiPuBg.cfg.map_id) -- 开启吃鸡
        -- addtocastlewarlistex("*")
        -- gmexecute("0","ForcedWallConQuestwar")
        -- Sendmsg9(actor, "ffffff", "所有行会加入攻城列表!", 1)
    else
        -- ChuanQiPuBg.gameOver(true)
        -- if castleinfo(5) then
        --     gmexecute("0","ForcedWallConQuestwar")
        -- end
    end
end
function open_surprise_box(actor)
    local class = IncludeNpcClass("WelfareHall")
    if class then 
        class:FlushSigleRedData(actor)
    end
    class:upEvent(actor,0,7,true)
    delbutton(actor, 103, 10004)
end
function open_limitgift_box(actor)
    local class = IncludeNpcClass("WelfareHall")
    if class then 
        class:FlushSigleRedData(actor)
    end
    class:openLimitView(actor)
end
