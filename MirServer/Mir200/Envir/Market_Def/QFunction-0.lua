--=========================================================== 监测玩家货币变化情况  ==============================================================
cache_money_change_log = nil ~= cache_money_change_log and cache_money_change_log or {}
for moneyIdx = 1, 100 do
    _G["moneychange"..moneyIdx] = function (actor)
        local user_id = getbaseinfo(actor, 2)
        cache_money_change_log[user_id] = cache_money_change_log[user_id] or {}
        local old_num = tonumber(getconst(actor, "<$OLDMONEY>"))
        local cur_num = querymoney(actor, moneyIdx)
        --间隔0.1秒内  首次锁定角色10秒  连续3次踢出游戏  下次登陆直接锁定1天   GM后台提供解锁借口
        if cur_num > old_num then
            -- local data = cache_money_change_log[user_id][moneyIdx]
            -- if nil == data then
            --     local tmp = {}
            --     tmp.moneyId = moneyIdx
            --     tmp.change_time = GetCurrentTime()
            --     tmp.lock_count = 0
            --     data = tmp
            -- else
            --     local cur_time = GetCurrentTime()
            --     if cur_time - data.change_time <= 150 then
            --         data.lock_count = data.lock_count + 1
            --         local lock_time = data.lock_count * 10
            --         changemode(actor, 10, lock_time)
            --         if data.lock_count >= 3 then
            --             setplaydef(actor, "U89", os.time())
            --             messagebox(actor,"【系统提示】：\\数据异常,请立即退出游戏。\\如有疑问请联系客服处理！","@_log_off_game")
            --         else
            --             senddelaymsg(actor, "<数据异常, 将在%s秒后解除锁定, 请勿退出游戏!/FCOLOR=249>", lock_time, 255, 0, "@_unlock_player")
            --         end
            --         setplaydef(actor, "U88", data.lock_count)
            --     else

            --     end
            --     data.change_time = cur_time
            -- end
            -- cache_money_change_log[user_id][moneyIdx] = data
        end
    end
end
function _log_off_game(actor)
    openhyperlink(actor, 34, 0)
end
function _unlock_player(actor)
    local user_id = getbaseinfo(actor, 2)
    setplaydef(actor, "U88", 0)
    setplaydef(actor, "U89", 0)
    changemode(actor, 10, 1)
    senddelaymsg(actor, "<数据异常, 将在%s秒后解除锁定, 请勿退出游戏!/FCOLOR=249>", 1, 255, 0, "@_unlock_player")
    cache_money_change_log[user_id] = {}
end
--=============================================================== end  ==================================================================

include("QuestDiary/LoadAllFile.lua")
QFIncludes("QF")
math.randomseed(tostring(os.time()):reverse():sub(1, 7))

handle_request_interval = handle_request_interval and handle_request_interval or {}
---接受协议消息触发
--- @param actor  string 玩家对象
--- @param msgid integer  协议ID
--- @param npc_id integer npcID 
--- @param sMsg string  协议携带数据
function handlerequest(actor, msgid, npc_id, arg2, arg3, sMsg)
    local map_id = getbaseinfo(actor, 3)
    local cur_time = GetCurrentTime()
    local op_time = handle_request_interval[actor] or 0
    if cur_time - op_time <= 200 and tonumber(npc_id) > 0 then
        Sendmsg9(actor, "ff0000", "请勿频繁操作!", 1)
        return
    end
    handle_request_interval[actor] = cur_time
    local lock_state = getplaydef(actor, "U88")
    if lock_state > 0 then
        Sendmsg9(actor, "ff0000", "数据异常, 请联系客服处理!", 1)
        return
    end
    local tab = strsplit(sMsg, "#")
    msgid = tonumber(msgid)
    local _npc_id = tonumber(tab[1])
    -- local filter_list = {112, 1, 328, 329}
    -- if _npc_id and _npc_id ~= 0 and not isInTable(filter_list, _npc_id) then
    --     local npc = getnpcbyindex(_npc_id)
    --     if nil == npc or map_id ~= getbaseinfo(npc, 3) then
    --         Sendmsg9(actor, "ff0000", "距离NPC过远!", 1)
    --         return
    --     end
    -- end
    local _file_name = tab[2]
    local _func_name = tab[3]
    if msgid == CS_MSG_CALL_FUN_BY_NPC then                     -- 调用指定npc的指定函数 npcid#classname#funName#param
        local npc_class = IncludeNpcClass(_file_name)
        if nil == npc_class then
            npc_class = IncludeMainClass(_file_name)
        end
        if npc_class and npc_class[_func_name] then
            npc_class[_func_name](npc_class, actor, unpack(tab,4))
        end
    elseif msgid == CS_MSG_SEND_DATA then                       -- 客户端发送数据到服务器
    elseif msgid == CS_MSG_CLICK_NPC then                       -- 点击npc协议   sMsg = npcid#classname#param
        local npc_class = IncludeNpcClass(_file_name)
        if npc_class and npc_class.click then
            npc_class:click(actor, _npc_id, unpack(tab,3))
        end
    elseif msgid == CS_MSG_CLICK_MAIN_BTN then                  -- 主界面按钮协议    sMsg = npcid#classname#param
        local npc_class = IncludeMainClass(_file_name)
        if npc_class and npc_class[_func_name] then
            npc_class[_func_name](npc_class, actor, unpack(tab, 4))
        end
    elseif msgid == CS_MSG_CLICK_SYS_BTN then                   -- 点击系统面板上的一些按钮    
        local sys_class = IncludeSysClass(_file_name)
        if sys_class and sys_class[_func_name] then
            sys_class[_func_name](sys_class, actor, unpack(tab,4))
        end
    end
end

--#region BUFF操作触发(玩家对象，buffID，组id，操作类型1：新增2：更新4：删除)
function buffchange(actor, buffId, groupId, opt)
    if  buffId == 50060 and opt == 4 then -- 脱战
        local timestamp = VarApi.getPlayerUIntVar(actor,"U_50048_buff_cd_timestamp") 
        if hasbuff(actor,50048) and os.time() - timestamp > 120  then
            setsuckdamage(actor,"=",getbaseinfo(actor,12) * 0.5,500,100)
            VarApi.setPlayerUIntVar(actor,"U_50048_buff_cd_timestamp",os.time())
            local str = string.format('{"Msg":"BUFF【魔女】触发：获得伤害吸收%s，吸收比例为50%%！","FColor":251,"BColor":0,"Type":6,"Time":1}',math.floor(getbaseinfo(actor,12) * 0.5))
            sendmsg(actor, 1, str)
            playeffect(actor,187,0,0,0,0,0)
            setontimer(actor,50048,1,0,1)
            sendattackeff(actor,148)
        end
        timestamp = VarApi.getPlayerUIntVar(actor,"U_50056_buff_cd_timestamp") 
        if hasbuff(actor,50056) and os.time() - timestamp > 120 and not hasbuff(actor,60014)  then
            addbuff(actor,60015)
            VarApi.setPlayerUIntVar(actor,"U_50056_buff_cd_timestamp",os.time())
            -- sendmsg(actor, 1, '{"Msg":"無双_霸者_BUFF触发！！","FColor":0,"BColor":255,"Type":1}')
            sendattackeff(actor,141)
        end
    end
    --opt     1=新增;2=更新;4=删除;
    runTriggerCallBack("buffchange", actor, buffId, groupId, opt)
end
function bufftriggerhpchange(actor,buffID,buffGroup,HP,buffHost,mon,result)
    if buffID == 50032 and getbaseinfo(actor,1) ~= "" then
        sendattackeff(actor,122)
        local str = string.format('{"Msg":"你被对方[猎杀BUFF]打中，每秒掉血2%%，BUFF持续剩余%s秒！","FColor":0,"BColor":255,"Type":1,"Time":1}',getbuffinfo(actor,50032,2))
        sendmsg(actor, 1, str)
    end
end 

--编辑行会公告前触发
function updateguildnotice(actor)
    return false
end

--聊天触发
function triggerchat(actor, msg, channel, msgType)
    runTriggerCallBack("triggerchat", actor, msg, channel)
    local level = getbaseinfo(actor,6)
    if level < 50 or VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) == 0 then
        Sendmsg9(actor, "ffffff", "不满足发言条件!", 1)
        return false
    end
    return true
end

--脱装备前触发
--[[
    where
]]
function takeoffbeforeex(actor, item, site, itemUID)
    runTriggerCallBack("takeoffbeforeex", actor, item, site, itemUID)
    local is_continue = TakeEquipTrigger.onPlayerBeforeexEquip(actor, item, site, itemUID)
    if nil ~= is_continue then
        return is_continue
    end
    return true
end

--脱装备后触发
function takeoffex(actor, item, site, itemName, itemUID)
    runTriggerCallBack("takeoffex", actor, item, site, itemName, itemUID)
    return TakeEquipTrigger.onPlayerTakeOffEquip(actor, item, site, itemName, itemUID)
end

--#region buff表21列填时间加名称触发(列1000#@bufftrigger) 具体逻辑在BffTrigger编写
function bufftrigger(actor,buffId)
    BuffTrigger.onBuffTrigger(actor, buffId)
end

--穿装备前触发
function takeonbeforeex(actor, item, site, itemUID)

    runTriggerCallBack("takeonbeforeex", actor, item, site, itemUID)
    return true
end

--穿装备后触发
function takeonex(actor, item, site, itemName, itemUID)
    TakeEquipTrigger.onPlayerTakeOnEquip(actor, item, site, itemName, itemUID)
    runTriggerCallBack("takeonex", actor, item, site, itemName, itemUID)
end

--物品进背包
function addbag(actor, item)
    if not actor then
        return
    end

    runTriggerCallBack("addbag", actor, item)
end

--任意地图杀死怪物
function killmon(actor, monObj,killerType,monId,monName,mapID)
    KillmonTrigger.onKillMon(actor, monObj,killerType,monId,monName,mapID)
    OtherTrigger.onKillMon(actor, monObj,killerType,monId,monName,mapID)
    runTriggerCallBack("killmon", actor, monObj,killerType,monId,monName,mapID)
end

--#region 称号改变触发(玩家对象，称号道具id)添加,更改
function titlechangedex(actor,titleIdx)
    TitleTrigger.onTitlechangedex(actor,titleIdx)
    runTriggerCallBack("titlechangedex", actor, titleIdx)
end
--#region 称号取消触发(玩家对象，称号道具id)取消穿戴,删除
function untitledex(actor,titleIdx)
    TitleTrigger.onUntitledex(actor,titleIdx)
    runTriggerCallBack("untitledex", actor, titleIdx)
end



--在跨服中地图杀死怪物
function killkfmon(actor, mapkey, monName, monNameEx, monIdx)
    return runTriggerCallBack("killkfmon", actor, mapkey, monName, monNameEx, monIdx)
end

--杀死人物时触发
--actor		触发对象
--targer	被杀玩家
function killplay(actor, targer)
    runTriggerCallBack("killplay", actor, targer)
end

--大退触发
function playoffline(actor)
    ChangeOfflinePlayer(actor, true)
    runTriggerCallBack("playoffline", actor)
end

--小退触发
function playreconnection(actor)
    runTriggerCallBack("playreconnection", actor)
end

--怪物掉落触发
--[[ function mondropitem(actor, item, monster, x, y)
    return true
end ]]

function kflogin(actor) --#region 跨服成功跨服qf触发
    KuaFuTrigger.kflogin(actor)
    runTriggerCallBack("kflogin", actor)
end

function kuafuend(actor) --#region 跨服结束本服qf触发
    KuaFuTrigger.kuafuend(actor)
    runTriggerCallBack("kuafuend", actor)
end

 --#region 跨服通知触发本服QF(传递的字符串1(字符串),传递的字符串2(字符串))
function kfsyscall99(actor,parama,paramb)
    KuaFuTrigger.kfsyscall99(actor, parama, paramb)
    runTriggerCallBack("kfsyscall99", actor, parama, paramb)
end

--#region 本服通知触发跨服QF(传递的字符串1(字符串),传递的字符串2(字符串))
function bfsyscall99(actor,parama,paramb) 
    KuaFuTrigger.bfsyscall99(actor, parama, paramb)
    runTriggerCallBack("bfsyscall99", actor, parama, paramb)
end

--跨服战场 跨服通知本服
function kfsyscall1(actor,parama,paramb)
    KuaFuTrigger.kfsyscall1(actor, parama, paramb)
end
--跨服调用-爆装备提示--{mapname, x, y, equipid}
function dropuseitems_kf(player, str)
    runTriggerCallBack("dropuseitems_kf", player, str)
end

--人物死亡装备掉落前触发支持stop
function checkdropuseitems(actor, equipSite, itemId)
    local drop_item = VarApi.getPlayerTStrVar(actor, "T_drop_items")
    if drop_item == "" then
        drop_item = {}
    else
        drop_item = json2tbl(drop_item)
    end
    drop_item[#drop_item + 1] = getstditeminfo(itemId, 1)
    VarApi.setPlayerTStrVar(actor, "T_drop_items", tbl2json(drop_item))
    runTriggerCallBack("checkdropuseitems", actor, equipSite, itemId)
    return true
end

--玩家被击杀
function playdie(actor, killer)
    if ActivityMapLogic.playdie(actor,killer) then --#region 乱斗之王提前判断
        return
    end
    local drop_str = ""
    local drop_item = VarApi.getPlayerTStrVar(actor, "T_drop_items")
    if drop_item == "" then
        drop_str = "无"
    else
        for key, name in pairs(json2tbl(drop_item)) do
            if "" == drop_str then
                drop_str = name
            else
                drop_str = drop_str .. "," .. name
            end
        end
    end    
    local str = "尊敬的玩家:\\您被%s<%s/FCOLOR=249>于<%s/FCOLOR=149>在<%s/FCOLOR=149>击败，死亡掉落:<%s/FCOLOR=249>，建议您提升实力后再前往复仇!"
    local tag = "怪物"
    if getbaseinfo(killer, -1) then
        tag = "玩家"
    end
    local name = getbaseinfo(killer, 1)
    local time = GetDate()
    local map_name = getbaseinfo(killer, 45)
    str = string.format(str, tag, name, time, map_name, drop_str)
    sendmail(getbaseinfo(actor, 2), 1, "死亡通知", str, "")

    VarApi.setPlayerTStrVar(actor, "T_drop_items", "")
    runTriggerCallBack("playdie", actor, killer)
end

--#region npc点击触发(玩家对象,npc索引id,npc文本路径)return true不允许
function clicknpc(actor,npcId,sScript)
    return ClickNpcTrigger.clicknpc(actor,npcId,sScript)
end

--拾取触发
function pickupitemex(actor, item,itemIdx,itemMakeIndex)
    PickupItemexTrigger.pickupitemex(actor, item,itemIdx,itemMakeIndex)
    runTriggerCallBack("pickupitemex", actor, item,itemIdx,itemMakeIndex)
end

--#region 拾取前触发(玩家对象，物品对象)return false阻止拾取
function pickupitemfrontex(actor, item)
    PickupItemexTrigger.pickupitemfrontex(actor, item)
    runTriggerCallBack("pickupitemfrontex", actor, item)
end

--扔任意物品前触发
function dropitemfrontex(actor, item,itemName,model)
    OtherTrigger.dropitemfrontex(actor, item,itemName,model)
    runTriggerCallBack("dropitemfrontex", actor, item)
end

--扔任意物品后触发
function dropitemex(actor, item)
    runTriggerCallBack("dropitemex", actor, item)
end
--切换地图
function entermap(actor, map_id, x, y)
    OtherTrigger.onMapChange(actor, map_id, x, y)
    -- ChuanQiPuBg.onJoinPubg(actor, map_id)
    ActivityMapLogic.onMapChange(actor, map_id, x, y)
    runTriggerCallBack("entermap", actor, map_id, x, y)
end

--在跨服切换地图
function entermapkf(actor, cur_mapid, former_mapid, stayTime, leaveMapName)
    runTriggerCallBack("entermapkf", actor, cur_mapid, former_mapid, stayTime, leaveMapName)
end

function delaystartautofight(actor)
    runTriggerCallBack("delaystartautofight", actor)
end
--离开地图
function leavemap(actor, map_id, x, y)
    OtherTrigger.onLeaveMapChange(actor, map_id, x, y)
    ActivityMapLogic.onLeaveMapChange(actor, map_id, x, y)
    runTriggerCallBack("leavemap", actor,map_id)
end

--升级触发
function playlevelup(actor)
    runTriggerCallBack("playlevelup", actor)
end


-- 开始挂机触发
function startautoplaygame(actor)
    runTriggerCallBack("startautoplaygame", actor)
end

-- 停止挂机触发
function stopautoplaygame(actor)
    runTriggerCallBack("stopautoplaygame", actor)
end

--攻城开始时触发
function castlewarstart(sysobj)
    release_print("攻城开始 ************")
    CastleWarTrigger.CastleWarStart(sysobj)
    runTriggerCallBack("castlewarstart", sysobj)
end

--攻城结束时触发
function castlewarend(sysobj)
    release_print("攻城结束 ************")
    CastleWarTrigger.CastleWarEnd(sysobj)
    runTriggerCallBack("castlewarend", sysobj)
end

-- 怪物掉落物品触发
function mondropitemex(actor, item, monster, itemX, itemY)
    MonDropItemTrigger.mondropitemex(actor, item, monster, itemX, itemY)
    runTriggerCallBack("mondropitemex", actor, item, monster, itemX, itemY)
end

--退出行会前触发
function guilddelmemberbefore(actor)
    runTriggerCallBack("guilddelmemberbefore", actor)
end

--解散行会前触发
function guildclosebefore(actor)
    runTriggerCallBack("guildclosebefore", actor)
end

-- 加入行会前触发
function guildaddmember(actor, guild, name)
    runTriggerCallBack("guildaddmember", actor, guild, name)
end

-- 加入行会后触发
function guildaddmemberafter(actor, guild, name)
    runTriggerCallBack("guildaddmemberafter", actor, guild, name)
end

-- 查看别人装备触发
function lookhuminfo(actor, targetName)
    VarApi.setPlayerTStrVar(actor, "T_look_palyer_name", targetName)
    --#region 境界显示
    local titleTab = {["初识"]=15243,["感知"]=15246,["不惑"]=15240,["洞玄"]=15245,["知命"]=15250,["天启"]=15248,["无距"]=15249,["涅槃"]=15247,["不朽"]=15241,["超凡"]=15242,["大宗师"]=15244
    ,["陆地仙人"]=46140,["至尊天人"]=46141,["圣灵道人·三生"]=46144,["圣灵道人·六道"]=46145,["圣灵道人·九天"]=46146,["圣灵道人·化神"]=46147}
    delbutton(actor,301,996)
    if getplayerbyname(targetName) then
        for key, value in pairs(titleTab) do
            if checktitle(getplayerbyname(targetName),key) then
                addbutton(actor, 301, 996, "<Effect|effectid="..value.."|x=8|y=0|effecttype=0>")
                break
            end
        end
    end
    --#endregion
    runTriggerCallBack("lookhuminfo", actor, targetName)
end

--任命掌门触发
function setguildrank1(actor)
    runTriggerCallBack("setguildrank1", actor)
end

--创建行会前触发
function checkbuildguild(actor, guildName)
    runTriggerCallBack("checkbuildguild", actor, guildName)
end

-- 走路触发
function walk(actor)
    runTriggerCallBack("walk", actor)
end

--#region QFunction-0重载后触发
function qfloadbegin(sysobj)
    
end

-- 镖车进入自动寻路范围触发
function carfindmaster(actor)
    runTriggerCallBack("carfindmaster", actor)
end

-- 丢失镖车触发
function losercar(actor, car)
    runTriggerCallBack("losercar", actor, car)
end

-- 镖车死亡触发
--- @param actor  string 攻击镖车对象
--- @param car string  镖车对象
function cardie(actor, car)
    runTriggerCallBack("cardie", actor)
end

function carpathend(actor)
    runTriggerCallBack("carpathend", actor)
end

--#region QFunction-0重载后触发
function qfloadend(sysobj)
    local player_list = getplayerlst(1)
    for i, player  in ipairs(player_list or {}) do
        release_print("在线玩家",i,getbaseinfo(player,1),"角色是否离线挂机:",getbaseinfo(player,61),"行会名:",getbaseinfo(player, 36),"当前开服天数"..getsysvar(VarEngine.OpenDay))
        VarApi.Init(player)
        if checkkuafu(player) then
            lualib:CallFuncByClient(player, "HiedMainTopBtn", nil)
        end
    end
end

-- 充值触发  self.玩家对象  gold.充值金额  productId.产品ID  MoneyId.货币ID  isReal.真实/扶持充值  orderTime.订单时间
function recharge(self, Gold, ProductId, MoneyId, isReal, orderTime, rechargeAmount, giftAmount, refundAmount)
    RechargeTrigger.onRecharge(self, Gold, ProductId, MoneyId, isReal, orderTime, rechargeAmount, giftAmount, refundAmount)
end

---双击使用道具前触发
---*  actor: 玩家对象
---@param actor string 玩家对象
---@param itemobj obj 道具对象
---@param itemidx number 道具idx
---@param itemMakeIndex number 道具唯一id
---@param itemNum number 道具数量
---@param stdMode number 物品表stdMode参数
---@return boolean 是否允许使用
function beforeeatitem(actor,itemobj,itemidx,itemMakeIndex,itemNum,stdMode)
    return UseItemTrigger.useItem(actor, itemobj, itemidx, itemMakeIndex, itemNum, stdMode)
end

--#region 人物攻击前触发(玩家对象，受击对象，攻击对象，技能id，伤害，当前攻击模式，return为修改后伤害)
function attackdamage(self, Target, Hiter, MagicId, Damage, Model)
    return BeforeAttackTrigger.onPlayerAttack(self, Target, Hiter, MagicId, Damage, Model)
end

--- 套装 668 成功触发
function groupitemonex(actor,suit_id)
    suit_id = tonumber(suit_id) 
    if suit_id == 668 then
        release_print("668套装**********")
        VarApi.setPlayerUIntVar(actor, "U_3003_suit_state", 1)
    elseif suit_id == 718 then
        VarApi.setPlayerUIntVar(actor, "U_feijian_suit_state", 1)
        -- changelevel(actor,"+",1)
    elseif suit_id == 719 then
        -- changelevel(actor,"+",2)
        VarApi.setPlayerUIntVar(actor, "U_feijian_suit_state", 2)
    end
end

function groupitemoffex(actor, suit_id)
    suit_id = tonumber(suit_id) 
    if suit_id == 668 then
        VarApi.setPlayerUIntVar(actor, "U_3003_suit_state", 0)
    elseif suit_id == 718 then
        VarApi.setPlayerUIntVar(actor, "U_feijian_suit_state", 0)
        -- changelevel(actor,"-",1)
    elseif suit_id == 719 then
        VarApi.setPlayerUIntVar(actor, "U_feijian_suit_state", 0)
        -- changelevel(actor,"-",2)
    end
end

-- 暴击触发
function crittrigger(actor, attack, damage, MagicId)
    if 1 == VarApi.getPlayerUIntVar(actor, "U_3003_suit_state") then
        local old_time = VarApi.getPlayerUIntVar(actor, "U_3003_suit_time")
        local cur_time = os.time()
        if cur_time - old_time >= 30 then
            VarApi.setPlayerUIntVar(actor, "U_3003_suit_time", cur_time)
            if checkkuafu(actor) then
                KuaFuTrigger.bfbackcall(actor, "crittrigger", getbaseinfo(attack, 2))
            else
                makeposion(attack, 12, 1)
                sendmsg(actor, 1, '{"Msg":"BUFF【神龙专属】神龙专属BUFF触发：将目标冰冻1秒！","FColor":251,"BColor":0,"Type":6,"Time":1}')
            end
        end
    end
end
--玩家受击触发
function struckdamage(self,Hiter,Target,MagicId,Damage,Model)
    return BeforeBeingAttackedTrigger.struckdamage(self,Hiter,Target,MagicId,Damage,Model)
end

--宠物攻击伤害前触发
function attackdamagepet(play,target,petObj,magicID,damage,isImportant)
     return BeforeAttackTrigger.attackdamagepet(play,target,petObj,magicID,damage,isImportant)
end
--玩家物理受击后触发
function struck(self,Hiter,Target,MagicId)
    return BeforeBeingAttackedTrigger.attackEnd(self,Hiter,Target,MagicId)
end

--玩家魔法受击后触发
function magicstruck(self,Hiter,Target,MagicId)
    return BeforeBeingAttackedTrigger.attackEnd(self,Hiter,Target,MagicId)
end
--=================================================================QM
--服务器启动
function startup(role)
    for k, v in pairs(VarEngine.MonUpdateVar) do
        setsysvar(k, v)
    end
    KuaFuTrigger.updateKFMon()      -- 跨服地图刷boss
    HeFuTrigger.updateInfo()        -- 合服信息更新(内部判断是否第一次登陆)
    if hasenvirtimer("祥瑞迷宫新区", 70001) then --#region 祥瑞迷宫新区地图刷怪
        setenvirofftimer("祥瑞迷宫新区", 70001)
    end
    _lucktreasure_map_mon()
    setenvirontimer("祥瑞迷宫新区", 70001, 3600, "@_lucktreasure_map_mon")

    addscheduled("update_全局机器人",'RunOnDay','00:00:00','@_update_run_day')
    addscheduled("update_全局机器人2", 'SEC', 1, '@_check_map_open_state')
    addscheduled("update_祥瑞宝藏机器人", 'RunOnDay', '12:00:00', '@_clear_luck_treasure_point')

    addscheduled("update_全局机器人_runtime",'SEC',3,'@_update_run_time')
    if getsysvar(VarEngine.ActiveStartFlag) > 0 then
       ActivityMgr.initActive()
   end 

    addscheduled("update_沙巴克机器人1",'RunOnDay','20:00:00','@_run_shabake_open')
    addscheduled("update_沙巴克机器人2",'RunOnDay','21:00:00','@_run_shabake_close')
    
    addscheduled("update_跨服沙城机器人1",'RunOnDay','21:05:00','@_run_kuafu_shabake_open',1)
    addscheduled("update_跨服沙城机器人2",'RunOnDay','22:05:00','@_run_kuafu_shabake_close',1)
    runTriggerCallBack("startup", role)
end
function _lucktreasure_map_mon() --#region 祥瑞迷宫新区地图刷怪
    local mon_list = {"子鼠启运兽", "丑牛耕耘兽", "寅虎驱邪兽", "卯兔捣药兽", "辰龙赐福兽", "巳蛇蜕厄兽","午马奔腾兽","未羊护生兽","申猴闹春兽","酉鸡报喜兽","戌狗守岁兽","亥猪纳福兽",}
    for index, value in ipairs(mon_list) do
        if getmoncount("祥瑞迷宫新区", getdbmonfieldvalue(value, "idx"), true) < 1 then
            genmon("祥瑞迷宫新区",0,0,value,1000,1,249) --#region 刷怪
        end
    end
end
function _clear_luck_treasure_point() --#region 3合后每周五12.清祥瑞宝藏积分
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count < 3 then
        return
    end
    local weekday = os.date("*t").wday
    if weekday == 6 then
        setsysvar(VarEngine.luckTreasure, "") --#region 清除祥瑞宝藏积分表
        local clearKeyList = {"JL_treasureOpen","UL_treasureOpenAll","JL_treasureTodayPoint","UL_treasureAllPoint",} 
        for index, value in ipairs(clearKeyList) do
            clearhumcustvar("*", value)                       -- 合服需要清理的个人变量
        end
        local player_list = getplayerlst(0)
        for i, player in ipairs(player_list or {}) do
            VarApi.setPlayerJIntVar(player,"JL_treasureOpen",0,true)
            VarApi.setPlayerUIntVar(player,"UL_treasureOpenAll",0,true)
            VarApi.setPlayerJIntVar(player,"JL_treasureTodayPoint",0,true)
            VarApi.setPlayerUIntVar(player,"UL_treasureAllPoint",0,true)
        end
    end
end

function _update_run_day()
    if getsysvar(VarEngine.ActiveStartFlag) <= 0 then
        return
    end
    local open_day = getsysvar(VarEngine.OpenDay)           -- 开区天数
    setsysvar(VarEngine.OpenDay, open_day + 1)
    local player_list = getplayerlst(0)
    for i, player in ipairs(player_list or {}) do
        lualib:CallFuncByClient(player, "OpenDay", getsysvar(VarEngine.OpenDay))
    end
    VarApi.resetDayVar("0")
end

function _update_run_time()
    if getsysvar(VarEngine.ActiveStartFlag) <= 0 then
        return
    end
    local time = getsysvar(VarEngine.OpenServerTime) 
    local start_sever_time = getsysvar(VarEngine.RunTime)
    if nil == start_sever_time or 0 == start_sever_time then
        if time > 0 then
            local old_run_time = os.time() - time
            start_sever_time = old_run_time
            setsysvar(VarEngine.OpenServerTime,0) 
        else
            start_sever_time = 0
        end
    end
    start_sever_time = start_sever_time + 3
    if start_sever_time >= 4200 and getsysvar(VarEngine.WuDaoDaHuiTipFlag) < 1 then
        setsysvar(VarEngine.WuDaoDaHuiTipFlag,1)
        sendmovemsg("0", 1, 250, 0,180 , 1,"【武道大会】：地图已开放，击杀全部BOSS可领取天龙武器，仅开放一次！")
    end
    setsysvar(VarEngine.RunTime, start_sever_time)
end

function _check_map_open_state()
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count == 0 then
        return
    end
    local dateInfo = os.date("*t")
    local dayOfWeek = dateInfo.wday
    local hour = dateInfo.hour
    local min = dateInfo.min
    local sec = dateInfo.sec
    local tips_list = {}
    local map_state = 0
    if dayOfWeek == 1 or dayOfWeek == 7 then        -- 周末
        if min == 0 and sec <= 1 then
            map_state = 1
        end
    else
        if hour % 2 == 0 and min == 0 and sec <= 1 then
            map_state = 1
        end
    end
    if hour < 12 then
        map_state = 0
    end
    if map_state == 1 and merge_count >= 4 then
        tips_list[#tips_list + 1] = "【系统提示】：「暗黑之城」入口已经开放，可在魔龙城进入，入口持续10分钟后将自动关闭"
        tips_list[#tips_list + 1] = "【系统提示】：「暗黑之城」入口已经开放，可在魔龙城进入，入口持续10分钟后将自动关闭"
    end
    if hour % 2 == 0 and min == 0 and sec <= 1 and merge_count >=2 then
        tips_list[#tips_list + 1] = "【系统提示】：龙魂禁地入口已开启，入口将在10分钟后关闭，攻击「卧龙夫人」可获得海量卧龙令"
        tips_list[#tips_list + 1] = "【系统提示】：龙魂禁地入口已开启，入口将在10分钟后关闭，攻击「卧龙夫人」可获得海量卧龙令"
    end
    if hour == 15 and min == 0 and sec <= 1 then
        tips_list[#tips_list + 1] = "【系统提示】：跨服战场「混沌战场」活动已开启，请勇士们前往击杀跨服BOSS，可获得丰厚奖励！"
    end
    if hour == 22 and min == 0 and sec <= 1 then
        tips_list[#tips_list + 1] = "【系统提示】：跨服战场「通灵战场」活动已开启，请勇士们前往击杀跨服BOSS，可获得丰厚奖励！"
    end

    for k, v in pairs(tips_list) do
        sendmovemsg("0", 1, 251, 0, 60 + (k - 1) * 30, 1, v)
    end
end

function _run_shabake_open()
    local hf_state = tonumber(getconst("0", "<$HFDAYS>"))                         -- 1. 代表今天合服了
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count > 0 then
        local dateInfo = os.date("*t")
        local dayOfWeek = dateInfo.wday
        if (dayOfWeek == 4 or dayOfWeek == 7) or hf_state == 1 then            -- 周三  周六
            addtocastlewarlistex("*")
            gmexecute("0","ForcedWallConQuestwar")
            for i = 1, 3 do
                sendmovemsg("0", 1, 250, 0, 60+(i - 1 )*30, 1,"【活动提示】: 沙巴克攻城已开启!")
            end
            sendmsg("0", 2, string.format('{"Msg":"%s","FColor":255,"BColor":249,"Type":1}', "【提示】: 沙巴克攻城已开启!"))
        end
    end
end
function _run_shabake_close()
    if castleinfo(5) then
        gmexecute("0","ForcedWallConQuestwar")
    end
end

function _run_kuafu_shabake_open(actor)
    local dateInfo = os.date("*t")
    local dayOfWeek = dateInfo.wday
    if (dayOfWeek == 4 or dayOfWeek == 7) then            -- 周三  周六
        local npc_class = IncludeNpcClass("KuafuShaCheng")
        if npc_class then
            npc_class:kfscStart(actor)
        end
    end
end
function _run_kuafu_shabake_close(actor)
    local dateInfo = os.date("*t")
    local dayOfWeek = dateInfo.wday
    if (dayOfWeek == 4 or dayOfWeek == 7) then            -- 周三  周六
        local npc_class = IncludeNpcClass("KuafuShaCheng")
        if npc_class then
            npc_class:KfscEnd(actor)
        end
    end
    
end
--角色登陆触发
function login(actor)
    ChangeOfflinePlayer(actor, false)
    if getsysvar(VarEngine.ActiveStartFlag) <= 0 then
        setsysvar(VarEngine.ActiveStartFlag,1)
        ActivityMgr.initActive()
    end
    LoginTrigger.login(actor)

    -- 玩家上线时检测是否有货币异常情况
    local lock_state = getplaydef(actor, "U88")
    if lock_state > 2 then
        local lock_time = getplaydef(actor, "U89")
        local remain_time = os.time() - lock_time
        if remain_time > 86400 then
            remain_time = 86400
            setplaydef(actor, "U89", os.time())
        end
        changemode(actor, 10, remain_time)
        senddelaymsg(actor, "<数据异常, 将在%s秒后解除锁定!/FCOLOR=249>", remain_time, 255, 0, "@_unlock_player")
    end
end

-- 跨天触发
function resetday(actor)
    LoginTrigger.resetdayLogin(actor)
    -- release_print("跨天登录触发~~~~~~~~~")
    -- createfile('..\\QuestDiary\\跨天登录触发.txt')
    -- addtextlist('..\\QuestDiary\\跨天登录触发.txt','触发时间', os.time())
end

-- 每天登录触发  每天第一次登录
function setday(actor)
    -- release_print("每天登录触发~~~~~~~~~")
    -- createfile('..\\QuestDiary\\每天登录触发.txt')
    -- addtextlist('..\\QuestDiary\\每天登录触发.txt','触发时间', os.time())
end

--初始化行会触发 actor是创建者
function loadguild(actor, ...)
    runTriggerCallBack("loadguild", actor, ...)
end
--组队杀怪触发
function groupkillmon(actor, bossName)
    runTriggerCallBack("groupkillmon", actor, bossName)
end
--角色获得宝宝触发
function slavebb(actor, mon)
    return BaByTrigger.slavebb(actor, mon)
end

-- 合成触发
function g_compounditem10000(actor, idx)
    OtherTrigger.onCompoundItem10000(actor, idx)
end
function nextdie(actor,hiter,isplay)
    local buff_list = getallbuffid(actor)
    if checkkuafu(actor) then
        buff_list = {}
        local buff_str = VarApi.getPlayerTStrVar(actor, "T_kuafu_buff_info")
        local tmp_list = strsplit(buff_str, "#")
        if type(tmp_list) == "table" then
            for k, v in pairs(tmp_list) do
                buff_list[k] = tonumber(v)
            end
        end
    end
    local timestamp = VarApi.getPlayerUIntVar(actor,"U_50027_buff_cd_timestamp") 
    if isInTable(buff_list,50027) and timestamp - os.time() <= 0  then
        VarApi.setPlayerUIntVar(actor,"U_50027_buff_cd_timestamp",os.time() + 120) 
        realive(actor)
        addhpper(actor,"=",30)
        sendattackeff(actor,128)
        sendmsg(actor, 1, '{"Msg":"BUFF【永生】触发：您已复活，请留意自身血量！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        local class = IncludeNpcClass("xuemai")
        if class then 
            class:flushBuffRevive(actor)
        end
    end
end
function sendability(actor)
    local per_huifu = getbaseinfo(actor,51,202)
    local old_huifu = VarApi.getPlayerUIntVar(actor,"U_per_huifu")
    local new_value = math.floor(per_huifu/10) 
    if new_value ~= old_huifu then
        local jc_huifu = getbaseinfo(actor,51,71)
        addattlist(actor,"回复属性","+","3#71#".. math.floor(jc_huifu * (new_value/10)) )
        VarApi.setPlayerUIntVar(actor,"U_per_huifu",new_value)
    end
end
--=================================================================QMEnd

--- npc 脚本调用外部函数 示例
function QFCallFunByNpc(actor, param)
    local tab = strsplit(param, "#")
    local fun, err = assert(load(tab[1]))()
    release_print("QFCallFunByNpc **************** ", err, fun)
    if fun then
        fun(actor, unpack(tab, 2))
    end
end

--- 测试登录触发 测试用例
-- local callBack = function (actor)
--     mapmove(actor, 3, 333, 333, 0)      --　跳转到盟重省333，333
--     setgmlevel(actor, 10)               --　设置最高ｇｍ权限
--     changelevel(actor, "=", 88)         --  调整人物等级    
--     setbagcount(actor, 126)             --  设置背包格子
--     VarApi.Init(actor)
--     release_print("login ******************* ")
-- end
-- addTriggerCallBack("login", callBack)

-- 刷怪触发   策划老白
function flush_cehualaobai()
    setsysvar(VarEngine.WuDaoDaHuiBoss, "")
end

-- 合成气泡
function compound_bubble(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
    openhyperlink(actor, 2201, 0)
end
-- 特殊四格气泡
function special_bubble(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
    lualib:ShowNpcUi(actor, "fourCellOBJ", "")
end
-- 十二生肖气泡
function zodiac_bubble(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
    lualib:ShowNpcUi(actor, "compoundAnimalOBJ", "")
end
-- 宗师境界气泡
function grandmaster_bubble(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
    lualib:ShowNpcUi(actor, "masterLayerOBJ", "")
end
-- 转生境界气泡
function reincarnation_bubble(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
    lualib:ShowNpcUi(actor, "zhuanshengOBJ", "")
end
-- 技能强化气泡
function skill_bubble(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
    local npc_class = IncludeNpcClass("SkillMasterNpc")
    if npc_class then
        npc_class:click(actor)
    end
end
-- 宗师秘宝气泡
function strengthen_bubble(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
    local npc_class = IncludeNpcClass("treasure")
    if npc_class then
        npc_class:upEvent(actor, 1)
    end
end
-- 觉醒之路气泡
function awakening_bubble(actor, _type)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
end
-- 五行之力气泡
function five_elements_bubble(actor, _type)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end    
    local npc_class = IncludeNpcClass("WuXingZhiLi")
    if npc_class then
        npc_class:click(actor, 1)
    end
end


--- 改名卡
--- 1. 会先执行查询人物名称操作，并触发：queryinghumname;
-- 2. 会根据查询结果情况触发：humnamefilter（名称被过滤）、namelengthfail（长度不符合要求）、humnameexists（名称已经存在）;
-- 3. 执行改名操作前触发：changeinghumname，根据改名结果触发：changehumnameok(改名成功)、changehumnamefail(改名失败)。

--正在查询玩家名称
function queryinghumname(actor)
    -- sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>正在查询请稍后。。。</font>","Type":9}')
end

--名称被过滤
function humnamefilter(actor)
    sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>名称被过滤。。。</font>","Type":9}')
end

--长度不符合要求
function namelengthfail(actor)
    sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>长度不符合要求</font>","Type":9}')
end

--名称已经存在
function humnameexists(actor)
    sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>名称已经存在</font>","Type":9}')
end

--正在执行改名操作
function changeinghumname(actor)
    -- sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>正在修改请稍后。。。</font>","Type":9}')
end

--改名成功
function changehumnameok(actor)
    --#region 捐献榜
    local rank_list = {}
    local str = getsysvar(VarEngine.donate)
    rank_list = json2tbl(str)
    for i = 1, 5 do
        if (rank_list[i] and rank_list[i]["actorName"] == getconst(actor,"<$USERNAME>")) then
            rank_list[i]["actorName"] = getconst(actor,"<$USERNEWNAME>")
        end
    end
    str = tbl2json(rank_list)
    setsysvar(VarEngine.donate, str)
    --#region 祥瑞宝藏积分榜
    local rank_list = {}
    local str = getsysvar(VarEngine.luckTreasure)
    rank_list = json2tbl(str)
    for i = 1, 5 do
        if (rank_list[i] and rank_list[i]["actorName"] == getconst(actor,"<$USERNAME>")) then
            rank_list[i]["actorName"] = getconst(actor,"<$USERNEWNAME>")
        end
    end
    str = tbl2json(rank_list)
    setsysvar(VarEngine.luckTreasure, str)

    sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>'..parsetext("你的名字修改成功，旧名称：<$USERNAME> 新名称：<$USERNEWNAME>！",actor)..'</font>","Type":9}')
end

--改名失败
function changehumnamefail(actor)
    sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>修改名称失败</font>","Type":9}')
end

-- 接取任务触发
function picktask(actor, task_id)
    TaskTrigger.onPickTask(actor, task_id)
end

-- 点击任务触发
function clicknewtask(actor, task_id)
    TaskTrigger.onClickTask(actor, task_id)
end

-- 刷新任务
function changetask(actor, task_id)
    TaskTrigger.onChangeTask(actor, task_id)
end

-- 完成任务
function completetask(actor, task_id)
    TaskTrigger.onCompleteTask(actor, task_id)
end

-- 删除任务
function deletetask(actor, task_id)
    TaskTrigger.onDeleteTask(actor, task_id)
end
--#region 自身使用任意技能前触发(玩家触发)(玩家对象，技能id，技能名字，受击对象，受击对象x坐标，受击对象y坐标，返回值(true/false，允许/组织施法))
function beginmagic(actor, skillId,maigicName, targer, x, y)
    runTriggerCallBack("beginmagic", actor, skillId,maigicName, targer, x, y)
    local level = getskillinfo(actor, 55, 2)
    if skillId == 55 then
        local mob_count = getbaseinfo(actor, 38)
        for i = 0 , mob_count-1 do
            local mon = getslavebyindex(actor, i)
            if mon and isnotnull(mon) then
                local name = getbaseinfo(mon, 1)
                if string.find(name, "月灵") then
                    killmonbyobj(actor, mon, false, false, false)
                end
            end
        end
        local count = 1
        if level and level >= 5 then
            count = 2
            playeffect(actor, 46122, 0, 0, 1, 0, 0)
        end
        for i = 1, count do
            local mon = recallmob(actor, "月灵", 5, 30, 0, 0, 0)
            if checktitle(actor,"全服最靓的仔")  then
                changemobability(actor,mon,10,"+",getbaseinfo(actor,24)*0.1,30) 
            end
        end
        return false
    end
    if skillId == 71 then  --擒龙手麻痹效果
        if getbaseinfo(targer,48) then
            return
        end 
        local self_level = getbaseinfo(actor,6)
        local target_level = getbaseinfo(targer,6)
        if self_level > target_level  then
            makeposion(targer,5,2)
        end
    end
    return UseMagicTrigger.onBeginmagic(actor, skillId,maigicName, targer, x, y)
end

-- 自定义排行榜刷新触发
function inisort(sysobj)
    local player_list = getplayerlst(1)
    for i, actor in ipairs(player_list or {}) do  
        local value = getconst(actor, "<$PLAYERPOWER>")
        VarApi.setPlayerUIntVar(actor, "战斗力", math.ceil(value / 100))
    end
end

function activity_test_fun(actor)
    ActivityMapLogic.flushLdzwView(actor)
end
function ontimer50048(actor)
    if getsuckdamage(actor) <= 0 then
        clearplayeffect(actor, 187)
        setofftimer(actor, 50048)
    end
end

-- 添加/删除离线挂机人物
function ChangeOfflinePlayer(actor, is_add)
    local user_id = getbaseinfo(actor, 2)
    local offline_list = getsysvar(VarEngine.Offline)
    if "" == offline_list or nil == offline_list then
        offline_list = {}
    else
        offline_list = json2tbl(offline_list)
    end
    local index = tabOfIndex(offline_list, user_id)
    if is_add then
        local count = math.random(40, 50)
        if #offline_list > count or nil ~= index then
            return
        end
        offline_list[#offline_list + 1] = user_id
        offlineplay(actor, 24 * 60 * 30)
        mapmove(actor, 3, 330, 330, 6)
    else
        if nil == index or type(index) ~= "number" then
            return
        end
        table.remove(offline_list, index)
    end
    setsysvar(VarEngine.Offline, tbl2json(offline_list))
end

function mon_drop_equip_call(actor, itemName, mon)
    local random = math.random(100)
    if random > 10 then
        return false
    end
    return true
end

function mon_drop_fabao_call(actor, itemName, mon)
    local map_name = getbaseinfo(actor, 45)
    local random_value = 100
    if nil == string.find(map_name, "之地") then
        random_value = 10
    end
    local random = math.random(random_value)
    if random > 1 then
        return false
    end
    return true
end