local CrossRealmBattlefield = {}
CrossRealmBattlefield.cfg = include("QuestDiary/config/CrossRealmBattleCfg.lua")
CrossRealmBattlefield.shop_cfg = include("QuestDiary/config/CrossRealmShopCfg.lua")
CrossRealmBattlefield.feijian_cfg = include("QuestDiary/config/kfFeiJianMapCfg.lua")
CrossRealmBattlefield.kf_shop_cfg = include("QuestDiary/config/CrossShopCfg.lua")
CrossRealmBattlefield.feijian_name_list = {"阶天神风剑","阶霸王风剑","阶炽热风剑","阶神罚风剑","阶大地风剑","阶明月风剑","阶山川风剑","阶大海风剑"}
function CrossRealmBattlefield:GotoShaCheng(actor)  
    if not checkkuafuconnect() then
        return Sendmsg9(actor, "ffffff", "跨服未连接，等待开放！", 1)
    end
    local wday = GetWday(os.time())
    if wday ~= 3 and wday ~= 6 then
        return  Sendmsg9(actor, "ffffff", "合区后，每周三、周六21：05-22:05点开放", 1) 
    end
    local level = getbaseinfo(actor,6)
    if level < 60 then
        return Sendmsg9(actor, "ffffff", "等级不足", 1) 
    end 
    local zs_level = getbaseinfo(actor,39)
    if zs_level < 4 then
        return Sendmsg9(actor, "ffffff", "转生等级不足", 1) 
    end 
    local kuangbao = VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL)
    if kuangbao == 0 then
        Sendmsg9(actor,"ffffff","未开启狂暴!",1)
        return
    end
    local current_time = os.date("*t")
    local current_minutes = current_time.hour * 60 + current_time.min
    local start_minutes = 21 * 60 + 5  -- 21:05
    local end_minutes = 22 * 60 + 5    -- 22:05
    -- 判断是否在范围内
    if current_minutes >= start_minutes and current_minutes <= end_minutes then
        KuaFuTrigger.bfbackcall(actor, "call_buff")
        mapmove(actor,"kfsc_kf",653,297)
        lualib:CloseNpcUi(actor,"CrossRealmBattlefieldOBJ")
    else
        return Sendmsg9(actor, "ffffff", "合区后，每周三、周六21：05-22:05点开放", 1) 
    end
end
function CrossRealmBattlefield:GotoBoss(actor,index)
    local cfg =  CrossRealmBattlefield.cfg[tonumber(index)]
    if not checkkuafuconnect() then
        return Sendmsg9(actor, "ff0000", "跨服未连接，等待开放！", 1)
    end
    local current_time = os.date("*t")
    local start_minutes = 0--21 * 60 + 5  -- 21:05
    local end_minutes = 0--22 * 60 + 5    -- 22:05
    local current_minutes = current_time.hour * 60 + current_time.min
    if tonumber(index) == 1 then
        start_minutes = 15*60 
        end_minutes = 16*60 
    else
        start_minutes = 22*60 
        end_minutes = 23*60 
    end
   
    if current_minutes < start_minutes or current_minutes > end_minutes then
        return Sendmsg9(actor, "ffffff", string.format("%s只在合区后每日%s开放",cfg.map_name,cfg.open_time), 1) 
    end
    local level = getbaseinfo(actor,6)
    if level < 60 then
        return Sendmsg9(actor, "ffffff", "等级不足", 1) 
    end 
    local zs_level = getbaseinfo(actor,39)
    if zs_level < 4 then
        return Sendmsg9(actor, "ffffff", "转生等级不足", 1) 
    end 
    local kuangbao = VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL)
    if kuangbao == 0 then
        Sendmsg9(actor,"ffffff","未开启狂暴!",1)
        return
    end

    if getmyguild(actor) == "0" then
        return Sendmsg9(actor, "ffffff", "请先加入行会！", 1) 
    end
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count > 8 then
        merge_count = 8
    elseif merge_count == 1 then
        merge_count = ""
    end
    local map_id = cfg.map_id..merge_count
    KuaFuTrigger.bfbackcall(actor, "call_buff")
    map(actor,map_id)
    lualib:CloseNpcUi(actor,"CrossRealmBattlefieldOBJ")
end
function CrossRealmBattlefield:BuyItem(actor,key_name)
    local cfg = CrossRealmBattlefield.shop_cfg[tonumber(key_name)]
    local zhanling_num = querymoney(actor,25)
    if zhanling_num < cfg.need then
       return  Sendmsg9(actor, "ffffff", "战令数量不足！", 1) 
    end
    if changemoney(actor,25,"-",cfg.need,"战令商城购买",true) then
        giveitem(actor,cfg.item_name,cfg.num,19)
        Sendmsg9(actor, "ffffff", "兑换成功", 1) 
    end
    lualib:FlushNpcUi(actor,"CrossRealmBattlefieldOBJ","flush_zhanling")
end
----------------------------飞剑-----------------------------
function CrossRealmBattlefield:openFeiJianView(actor)
    if not checkkuafuconnect() then
        return Sendmsg9(actor, "ff0000", "跨服未连接，等待开放！", 1)
    end
    local user_id = getbaseinfo(actor, 2)
    bfbackcall(99, "0", "init_get_fj_boss_time|fjdt_kf1|1",user_id)
end
--请求跨服boss存活数据
function CrossRealmBattlefield:requestBossInfo(actor,layer)
    layer = tonumber(layer)
    if layer > 1 then
        if layer > self:GetMaxLevel(actor)+1 then
            return Sendmsg9(actor, "ffffff", "请先解锁上一层全部飞剑", 1) 
        end
    end
    local user_id = getbaseinfo(actor, 2)
    bfbackcall(99, "0", "get_fj_boss_time|fjdt_kf"..layer.."|"..layer,user_id)
end
function CrossRealmBattlefield:flushFJBossInfo(actor,boss_info,is_init,layer)
    if is_init then
        local enter_num = VarApi.getPlayerJIntVar(actor,"J_enter_num")
        enter_num = 12 - enter_num > 0 and 12 - enter_num or 0
        lualib:ShowNpcUi(actor,"CrossFeiJianOBJ", enter_num.."#"..boss_info.."#"..layer)
        lualib:CloseNpcUi(actor,"CrossShopObj")
    else
        lualib:FlushNpcUi(actor,"CrossFeiJianOBJ","flush_boss_info#"..boss_info.."#"..layer)
    end
end
--怪物死亡刷新倒计时
function CrossRealmBattlefield:KillMonSendAward(actor,map_id)
    if not string.find(map_id,"fjdt_kf") then return end
    local kill_hanghui = getbaseinfo(actor,36)
    local players = getplaycount(map_id,1,1)
    for index, player in ipairs(type(players) == "table" and players or {}) do
        local user_id = getbaseinfo(player,2)
        local hanghui_name = getbaseinfo(player,36)
        if kill_hanghui == hanghui_name then
            local layer = string.match(map_id, "%-?%d+%.?%d*")
            kfbackcall(1,user_id,"feijian_map",layer)
        end
    end
    local boss_time = {}
    local info =  mapbossinfo(map_id,"*",1)
    for k, v in pairs(info) do
        local boss_info =  strsplit(v,"#")
        boss_time[boss_info[1]] = boss_info[3]
    end
    local layer = string.match(map_id, "%-?%d+%.?%d*")
    kfbackcall(1,getbaseinfo(actor, 2),"set_bf_boss_time|"..layer,tbl2json(boss_time) ) --#region 自定义变量传递
end
function CrossRealmBattlefield:GotoFeiJianMap(actor,layer)
    if not checkkuafuconnect() then
        return Sendmsg9(actor, "ff0000", "跨服未连接，等待开放！", 1)
    end
    -- local level = getbaseinfo(actor,6)
    -- if level < 60 then
    --     return Sendmsg9(actor, "ffffff", "等级不足", 1) 
    -- end 

    -- local zs_level = getbaseinfo(actor,39)
    -- if zs_level < 4 then
    --     return Sendmsg9(actor, "ffffff", "转生等级不足", 1) 
    -- end 

    -- local kuangbao = VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL)
    -- if kuangbao == 0 then
    --     Sendmsg9(actor,"ffffff","未开启狂暴!",1)
    --     return
    -- end

    if getmyguild(actor) == "0" then
        return Sendmsg9(actor, "ffffff", "请先加入行会！", 1) 
    end

    local current_time = os.date("*t")
    if current_time.hour < 11 then
        return Sendmsg9(actor, "ffffff", "活动未开启！", 1) 
    end
    local enter_num = VarApi.getPlayerJIntVar(actor,"J_enter_num")
    if enter_num >= 12 then
       return Sendmsg9(actor, "ffffff", "今日剩余可挑战次数不足！", 1) 
    end
    layer = tonumber(layer)
    local cfg =  self.feijian_cfg[layer]
    if cfg == nil then
       return Sendmsg9(actor, "ffffff", "未找到层数配置！", 1) 
    end
    
    if layer > 1 then
        if layer > self:GetMaxLevel(actor)+1 then
            return Sendmsg9(actor, "ffffff", "请先解锁上一层全部飞剑", 1) 
        end
    end
    mapmove(actor,"fjdt_kf"..layer,46,40)
    
    lualib:CloseNpcUi(actor,"CrossFeiJianOBJ")
end

function CrossRealmBattlefield:GetMaxLevel(actor)
    local cur_layer = 10
    local all_equip = {}
    for _, pos in pairs({71,72,73,74,117,118,119,120}) do
        local equip = linkbodyitem(actor, pos)
        local equip_name = getiteminfo(actor, equip, 7) or ""
        if equip_name ~= "" then
            all_equip[equip_name] = equip_name
        else
            return 0
        end
    end
    for k, v in pairs(all_equip) do
        local str = string.sub(v,1,2)
        cur_layer = math.min(CN2Ara(str),cur_layer) 
    end
    return cur_layer
end

function CrossRealmBattlefield:KfShopBuy(actor,key_name)
    local cfg = self.kf_shop_cfg[tonumber(key_name)]
    if cfg == nil then
       return  Sendmsg9(actor, "ffffff", "未找到配置", 1) 
    end
    local cur_count = getbagitemcount(actor,cfg.need_name)
    if cur_count < cfg.need_num then
        return Sendmsg9(actor, "ffffff", cfg.need_name.."不足", 1) 
    end
    if getbagblank(actor) < 5 then
        return Sendmsg9(actor, "ffffff", "当前角色背包已满,请先清理后再来兑换！", 1)
    end
    if takeitem(actor,cfg.need_name,cfg.need_num,0,"跨服boss兑换扣除") then
        if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
            giveitem(actor,cfg.name,1,0,"跨服boss商城兑换")
        else
           giveitem(actor,cfg.name,1,307,"跨服boss商城兑换")
        end
        Sendmsg9(actor, "ffffff", "兑换成功", 1)
    end
end
function CrossRealmBattlefield:showFeiJianReward(actor,mapid)
    local layer = string.match(mapid, "%-?%d+%.?%d*")
    local level = Ara2CN(tonumber(layer))
    local list = {}
    for i,v in ipairs(CrossRealmBattlefield.feijian_name_list) do
        local item_id = getstditeminfo(level..v, 0)
        table.insert(list,item_id)
    end
    local info = [[
        <Text|x=30.0|y=10.0|color=243|size=16|text=《%s(跨服)》>
        <Text|x=40.0|y=38.0|color=250|size=16|text=当前地图爆出物品>
        <ListView|children={1,2,3}|x=0|y=60|width=220|height=120|direction=1|bounce=1|margin=2|reload=1>
        <ListView|id=1|children={4,5,6}|x=0|y=60|width=210|height=60|direction=2|bounce=0|margin=2|reload=1|cantouch=0>
        <ListView|id=2|children={7,8,9}|x=0|y=60|width=210|height=60|direction=2|bounce=0|margin=2|reload=1|cantouch=0>
        <ListView|id=3|children={10,11,12}|x=0|y=60|width=210|height=60|direction=2|bounce=0|margin=2|reload=1|cantouch=0>
        <ItemShow|id=4|bgtype=1|x=0|y=120|itemid=%s|showtips=1>
        <ItemShow|id=5|bgtype=1|x=65|y=120|itemid=%s|showtips=1>
        <ItemShow|id=6|bgtype=1|x=135|y=120|itemid=%s|showtips=1>
        <ItemShow|id=7|bgtype=1|x=0|y=120|itemid=%s|showtips=1>
        <ItemShow|id=8|bgtype=1|x=65|y=120|itemid=%s|showtips=1>
        <ItemShow|id=9|bgtype=1|x=135|y=120|itemid=%s|showtips=1>
        <ItemShow|id=10|bgtype=1|x=0|y=120|itemid=%s|showtips=1>
        <ItemShow|id=11|bgtype=1|x=65|y=120|itemid=%s|showtips=1>
        ]]
    info = string.format(info, "无双飞剑",unpack(list))
    addbutton(actor, 110, "_1234567", info)
end
return CrossRealmBattlefield