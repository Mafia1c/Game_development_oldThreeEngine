local treasure = {}
treasure.cfg = include("QuestDiary/config/zsmbcfg.lua")
treasure.cfg2 = include("QuestDiary/config/treasureAwakeCfg.lua")
function treasure:upEvent(actor,tab_index)
    local mibao_state_list =  VarApi.getPlayerTStrVar(actor, VarStrDef.ZSMB)
    if mibao_state_list == "" then
       mibao_state_list =  {} 
    end
    lualib:ShowNpcUi(actor,"TreasureObj","init_flush#"..tab_index.."#"..tbl2json(mibao_state_list))
end
function treasure:flushRedData(actor)
     for k, v in pairs(treasure.cfg) do
        local num = getbagitemcount(actor,v.name)
        if num > 0 and not treasure:getIsActive(actor,v.key_name) then
           return 1
        end
    end
    return 0
end
function treasure:tabOnClick(actor,tab_index)
    local mibao_state_list =  VarApi.getPlayerTStrVar(actor, VarStrDef.ZSMB)
    if mibao_state_list == "" then
       mibao_state_list =  {} 
    end
    lualib:FlushNpcUi(actor,"TreasureObj","init_flush#"..tab_index.."#"..tbl2json(mibao_state_list))
end

function treasure:cellBtnClick(actor,param)
    local tab = strsplit(param,"|") 
    local accumulate_recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    if tonumber(tab[1]) == 1 then  --收录
        if not takeitem(actor,treasure.cfg[tonumber(tab[2])].name,1,0) then
            return Sendmsg9(actor, "ffffff",  string.format("收录该秘宝需要：%sx1",treasure.cfg[tonumber(tab[2])].name) , 1)
        end
        local mibao_state_list = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.ZSMB)) 
        if type(mibao_state_list) == "string" then
            mibao_state_list =  {} 
        end
        table.insert(mibao_state_list,tonumber(tab[2]))
        VarApi.setPlayerTStrVar(actor,VarStrDef.ZSMB,tbl2json(mibao_state_list))
        treasure:setbuffAttr(actor)
        lualib:FlushNpcUi(actor,"TreasureObj","shoulu_flush#"..tab[1].."#".. tab[2].."#"..tbl2json(mibao_state_list))
        
        VarApi.setPlayerUIntVar(actor, "U_zsmb_state_"..tab[2], 1)
    elseif tonumber(tab[1]) == 2 then  --回收
        local cur_cfg = treasure.cfg[tonumber(tab[2])]
        if getbagitemcount(actor,cur_cfg.name) <= 0 then
            return Sendmsg9(actor, "ffffff",  string.format("你没有%s!",treasure.cfg[tonumber(tab[2])].name) , 1)
        end
        if not takeitem(actor,cur_cfg.name,1,0) then
            return Sendmsg9(actor, "ffffff",  string.format("你没有%s!",treasure.cfg[tonumber(tab[2])].name) , 1)
        end
        if accumulate_recharge >= 68  then
            giveitem(actor,cur_cfg.recycle_name,cur_cfg.recycle_num,0)
        else
            giveitem(actor,cur_cfg.recycle_name,cur_cfg.recycle_num,307)
        end
        return Sendmsg9(actor, "ffffff",  "回收获得：秘宝碎片x".. cur_cfg.recycle_num, 1)
    elseif tonumber(tab[1]) == 3 then
        local cur_cfg = treasure.cfg[tonumber(tab[2])]
        if getbagitemcount(actor,cur_cfg.need_name1) < tonumber(cur_cfg.need_num1)  then
            return Sendmsg9(actor, "ffffff",  string.format("%s不足!",cur_cfg.need_name1) , 1)
        end
        if getbindmoney(actor,cur_cfg.need_name2) < tonumber(cur_cfg.need_num2)  then 
            return Sendmsg9(actor, "ffffff",  string.format("%s不足!",cur_cfg.need_name2) , 1)
        end

        if not consumebindmoney(actor,cur_cfg.need_name2,cur_cfg.need_num2,"秘宝兑换通用货币扣除") then
            return Sendmsg9(actor, "ffffff",  string.format("%s不足!",cur_cfg.need_name2) , 1)
        end

        if not takeitem(actor,cur_cfg.need_name1,cur_cfg.need_num1,0) then
            return Sendmsg9(actor, "ffffff",  string.format("%s不足!",cur_cfg.need_name1) , 1)
        end
        Sendmsg9(actor, "ffffff",  "兑换成功", 1)
        if accumulate_recharge >= 68 then
            giveitem(actor,cur_cfg.name,1)
        else
            giveitem(actor,cur_cfg.name,1,307)
        end
    end
end

function treasure:setbuffAttr(actor)
    delbuff(actor,30002)
    local buffTab = {}
    for i,v in ipairs(treasure.cfg) do
        if treasure:getIsActive(actor,v.key_name) then
            if v.group == "秘宝" then
                buffTab[35] = (buffTab[35] or 0) +  v.treasure_attr_value
            elseif v.group == "名品" then
                buffTab[36] = (buffTab[36] or 0) + v.treasure_attr_value
                buffTab[37] = (buffTab[37] or 0) + v.treasure_attr_value
            elseif v.group == "绝品" then
                buffTab[60] = (buffTab[60] or 0) + v.treasure_attr_value
            elseif v.group == "孤品" then
                buffTab[25] =  (buffTab[25] or 0) + v.treasure_attr_value
            end
        end
    end
    addbuff(actor, 30002, 0, 1, actor, buffTab)
end
--一键收录
function treasure:allShouLuClick(actor)
    local mibao_state_list = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.ZSMB)) 
    if type(mibao_state_list) == "string" then
        mibao_state_list =  {} 
    end
    local is_sure = false
    for k, v in pairs(treasure.cfg) do
        local num = getbagitemcount(actor,v.name)
        if num > 0 and not treasure:getIsActive(actor,v.key_name) then
            if takeitem(actor,v.name,1,0) then
                table.insert(mibao_state_list,tonumber(v.key_name))
                is_sure = true
            end
        end
    end
    if is_sure  then
        VarApi.setPlayerTStrVar(actor,VarStrDef.ZSMB,tbl2json(mibao_state_list))
        treasure:setbuffAttr(actor)
        lualib:FlushNpcUi(actor,"TreasureObj","all_shoulu_flush#"..tbl2json(mibao_state_list))    
    else
        return Sendmsg9(actor, "ffffff",  "没有可收录的秘宝", 1)
    end
end
function treasure:getIsActive(actor,key_name)
    local list = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.ZSMB)) 
    if list == "" then return false end
    for k, v in pairs(list) do
        if tonumber(v) == tonumber(key_name)  then
            return true 
        end
    end
    return false
end
--一键回收
function treasure:allHuiShouClick(actor)
    local is_sure = false
    local all_count =0
    local accumulate_recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    for k, v in pairs(treasure.cfg) do
        if v.group ~= "绝品" and v.group ~= "孤品" then
            local num = getbagitemcount(actor,v.name)
            if num > 0 then
                if takeitem(actor,v.name,num,0) then
                    is_sure = true
                end
                all_count = num*tonumber(v.recycle_num) + all_count
                if accumulate_recharge  >= 68 then
                    giveitem(actor,v.recycle_name,num*tonumber(v.recycle_num) )
                else
                    giveitem(actor,v.recycle_name,num*tonumber(v.recycle_num),307)
                end
            end
        end
    end
    if is_sure == false then
        return Sendmsg9(actor, "ffffff",  "没有可回收的秘宝", 1)
    else
         return Sendmsg9(actor, "ffffff",  "一键回收获得：秘宝碎片x".. all_count, 1)
    end
end
--秘宝觉醒
function treasure:jueXingClick(actor,key_name)
    if tonumber(key_name) <= 0 then
        return Sendmsg9(actor, "ffffff",  "只有绝品、孤品秘宝可进行觉醒！", 1)
    end
    local name = getiteminfo(actor, linkbodyitem(actor,14), 7)
    if name == nil or treasure:getCfgByName(name) == nil  then
        return Sendmsg9(actor, "ffffff",  "只有绝品、孤品秘宝可进行觉醒！", 1)
    end
    local cfg =  treasure:getCfgByName(name)
    if cfg.group ~= "孤品" and cfg.group ~= "绝品" then
        return Sendmsg9(actor, "ffffff",  "只有绝品、孤品秘宝可进行觉醒！", 1)
    end
    if getbindmoney(actor, "灵符") <  2000 then
        return Sendmsg9(actor, "ffffff",  "灵符数量不足", 1)
    end
    
    local material_cfg = treasure.cfg[tonumber(key_name)]
    if name == material_cfg.name then
       return  Sendmsg9(actor, "ffffff",  "同类型装备无法觉醒", 1)
    end
    local attr_str = getitemattidvalue(actor,2,material_cfg.awakening_attr_id,14)
    if attr_str ~= 0 then
       return  Sendmsg9(actor, "ffffff",  "当前主孤品已觉醒过副孤品属性", 1)
    end
    local num = VarApi.getPlayerUIntVar(actor, "mbjuexing_failure_num")
    local odds = math.random(1,100)

    local account_id = getconst(actor, "<$USERACCOUNT>")
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    local one_mbjx_odds = 0
    if type(list) == "table" and list[account_id] then
        one_mbjx_odds = list[account_id]["one_mbjx_odds"] or 0
    end
    
    -- if num > material_cfg.failure_num and odds <= 20 then
    if odds <= (20 + one_mbjx_odds )then
        if not takeitem(actor,material_cfg.name,1,0,"觉醒扣除") then
            return Sendmsg9(actor, "ffffff",  string.format("不存在material_cfg.name") , 1)
        end
        if not consumebindmoney(actor,"灵符",2000,"秘宝觉醒通用货币扣除") then
            return Sendmsg9(actor, "ffffff",  "灵符数量不足", 1)
        end
        local str = getdbitemfieldvalue(material_cfg.name,"Attribute" )
        setaddnewabil(actor,14,"+",str)
        setitemaddvalue(actor,linkbodyitem(actor,14),2,1,0)
        lualib:FlushNpcUi(actor,"TreasureObj","juexing_flush")    
        VarApi.setPlayerUIntVar(actor, "mbjuexing_failure_num",0)
        local player_name = getbaseinfo(actor,1)
        local str =  "宗师神器:恭喜<「%s」/FCOLOR=250>成功进行<「秘宝觉醒」/FCOLOR=241>，获得觉醒属性"
        Sendmsg13(actor,255, string.format(str,player_name) ,2,13)
        if self.cfg2[getiteminfo(actor,linkbodyitem(actor,14),7)] then
            local time = getitemintparam(actor,14,1)
            if time == nil then time = 0 end
            setitemintparam(actor,14,1,time+1)
            updatecustitemparam (actor,14)
        end
    else
     
        if not consumebindmoney(actor,"灵符",2000,"秘宝觉醒通用货币扣除") then
            return Sendmsg9(actor, "ffffff",  "灵符数量不足", 1)
        end
        Sendmsg9(actor, "ffffff",  "很遗憾本次觉醒失败！", 1)
        VarApi.setPlayerUIntVar(actor, "mbjuexing_failure_num",num + 1)
    end
end
function treasure:getCfgByName(name)
    for k, v in pairs(treasure.cfg) do
        if v.name == name then
            return v  
        end
    end
    return nil
end
return treasure