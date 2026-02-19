PickupItemexTrigger = PickupItemexTrigger or {}
local temp_cfg = include("QuestDiary/config/FirstDropEquipCfg.lua")
local record_temp_cfg = include("QuestDiary/config/RarityEquipRecordCfg.lua")
local _cfg = {}
for i,v in ipairs(temp_cfg) do
    _cfg[v.equip_name] = v
end
PickupItemexTrigger.frist_equip_cfg = _cfg

local record_cfg = {}
for i,v in ipairs(record_temp_cfg) do
    record_cfg[v.equip_name] = v
end
-- 首爆奖励
local first_list = json2tbl(getsysvar(VarEngine.FristEquip))
if type(first_list) ~= "table" then
    first_list = {}
end
PickupItemexTrigger.first_list = PickupItemexTrigger.first_list or first_list

-- 缓存珍宝掉落
local tmp_list = json2tbl(getsysvar(VarEngine.EquipDropRecord))
if type(tmp_list) ~= "table" then
    tmp_list = {}
end
PickupItemexTrigger.record_list = PickupItemexTrigger.record_list or tmp_list

PickupItemexTrigger.cache_interval_time = 0

--#region 拾取前触发(玩家对象，物品对象)return false阻止拾取
function PickupItemexTrigger.pickupitemfrontex(actor, item)
    local itemId = getiteminfo(actor, item, 1) --#region 物品id
    local itemName = getiteminfo(actor, item, 7) --#region 物品名称

    if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) < 68 then --#reigon 累计充值<68不上拍卖行
        setitemaddvalue(actor,item,2,1,307)
    end
    if checkkuafuserver() then
        if VarApi.getPlayerUIntVar(actor,"U_kf_recharge") < 68 then
            setitemaddvalue(actor,item,2,1,307)
        else
            setitemaddvalue(actor,item,2,1,0)
        end
    end
    return true
end
--#region 拾取触发(玩家对象,物品对象,物品id,物品唯一id)
function PickupItemexTrigger.pickupitemex(actor, item,itemIdx,itemMakeIndex)
    ---首爆奖励
    local name = getiteminfo(actor, item,7)
    if name == "撒旦宝箱" then
        setsysvar(VarEngine.JqdbBoxTime,os.time() + 300)  
        playeffect(actor,20451,20,80,0,0,0)
        setontimer(actor, 60000, 300, 1,1)
        setontimer(actor, 60001, 1, 0,1)
    end
    local cfg = PickupItemexTrigger.frist_equip_cfg[name]
    if cfg then
        local source_data = json2tbl(getthrowitemly(actor,item)) 
        if source_data.source and source_data.source == "怪物" then
            if PickupItemexTrigger.first_list[name] == nil then
                PickupItemexTrigger.first_list[name] = 1
                local mail_award = ""
                for i = 1, 3 do
                    if cfg["award_num"..i] > 0 then
                        mail_award = mail_award .."&".. string.format("%s#%s",cfg["award_name"..i],cfg["award_num"..i] ) 
                    end
                end
                local mail_str = string.format("恭喜阁下获得全服首爆物品：%s \\您的首爆奖励已经发放，请查收！\\提示：开通终身特权还可领取个人首爆奖励！\\邮箱数据不定时清理，为了您的权益，请及时删除邮件",name) 
                sendmail(getbaseinfo(actor,2),1,"全服首爆",mail_str,mail_award)
                lualib:ShowNpcUi(actor,"FristEquipTipObj","2#"..name)
            end
            if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) > 0 then
                local frist_equip_flag = json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP)) 
                if frist_equip_flag == "" then
                    frist_equip_flag = {}
                end
                if frist_equip_flag[name] == nil then
                    frist_equip_flag[name] = 1
                    lualib:ShowNpcUi(actor,"FristEquipTipObj","1#"..name) 
                    VarApi.setPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP,tbl2json(frist_equip_flag))
                end
            end
        end
    end
    --珍宝掉落展示
    if record_cfg[name] then
        local data = {}
        data.map_name = getbaseinfo(actor,45)
        data.player_name = getbaseinfo(actor,1)
        data.boss_name = getplaydef(actor,"S1")
        data.equip_name = name
        data.time = os.date("%d日:%H:%M:%S", os.time())
        data.timestamp = os.time()
        if #PickupItemexTrigger.record_list >= 999 then
            table.remove(PickupItemexTrigger.record_list, #PickupItemexTrigger.record_list)
            table.insert(PickupItemexTrigger.record_list, 1, data)
        else
            table.insert(PickupItemexTrigger.record_list, 1, data)
        end
    end

    -- 这个函数耗时过高   变量值每隔6秒更新一次
    if os.time() - PickupItemexTrigger.cache_interval_time >= 6 then
        PickupItemexTrigger.cache_interval_time = os.time()
        setsysvar(VarEngine.EquipDropRecord, tbl2json(PickupItemexTrigger.record_list))
        setsysvar(VarEngine.FristEquip, tbl2json(PickupItemexTrigger.first_list))
    end
end
function ontimer60000(actor)
    if takeitem(actor,"撒旦宝箱",1,0) then
        local award = "绑定元宝#180000&五彩石#58&书页#58&生肖(鼠)#1&生肖(牛)#1&生肖(虎)#1&生肖(兔)#1&生肖(龍)#1&生肖(蛇)#1&生肖(馬)#1&生肖(羊)#1&生肖(猴)#1&生肖(鸡)#1&生肖(狗)#1&生肖(猪)#1"
        sendmail(getbaseinfo(actor,2),1,"激情夺宝","开启撒旦宝箱获得以下奖励，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时删除邮件！",award)
        clearplayeffect(actor,20451)
        if hastimer(actor,60001) then
            setofftimer(actor, 60001)
        end
    end
end
function ontimer60001(actor)
    local end_time = getsysvar(VarEngine.JqdbBoxTime)  
    if end_time <= 0 then
        setofftimer(actor, 60001)
        return  
    end
    local name = getbaseinfo(actor,1) 
    local x = getbaseinfo(actor,4) 
    local y = getbaseinfo(actor,5) 
    local str = string.format("宝箱携带者[%s],出现在坐标：[%s:%s]",name,x,y)
    local player_list = getplaycount("hd_jqdb",0,0)
    if type(player_list) == "table" then
        for k, v in pairs(player_list) do
            if end_time > 0 then
                senddelaymsg(v, str.."宝箱争夺倒计时：%s",end_time - os.time(),168,1)
            end
        end
    end 
end