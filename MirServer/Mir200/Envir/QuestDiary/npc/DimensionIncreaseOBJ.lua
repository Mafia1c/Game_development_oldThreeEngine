local DimensionIncreaseOBJ = {}
DimensionIncreaseOBJ.cfg = include("QuestDiary/config/DimensionIncreaseCfg.lua")
DimensionIncreaseOBJ.zfcfg = include("QuestDiary/config/DimensionIncrease2Cfg.lua")
local entry_name_list = {"暴君","血牛","金刚"}
local entry_attr_id_list = {252,253,254}
local entry_attr_id_map = {[252] = "暴君",[253] = "血牛",[254] = "金刚"}
function DimensionIncreaseOBJ:upEvent(actor,param)
    -- local temp_odds = VarApi.getPlayerUIntVar(actor,"U_zsjx_odds")
    -- lualib:ShowNpcUi(actor,"DimensionIncreaseOBJ","init_flush")
end
function DimensionIncreaseOBJ:OnClickJf(actor,key_name)
    key_name = tonumber(key_name) 
    local cfg = DimensionIncreaseOBJ.cfg[key_name]
    for k, v in pairs(cfg.need_map) do
        local stdmode =  getstditeminfo(k,2)
        local count = 0
        if stdmode == 41 then
            count = getbindmoney(actor,k)
        else
            count = getbagitemcount(actor,k)
        end
        if count < v  then
            return Sendmsg9(actor, "ffffff",  k.."数量不足", 1) 
        end
    end
    for k, v in pairs(cfg.need_map) do
        local stdmode =  getstditeminfo(k,2)
        if stdmode == 41 then
            if not consumebindmoney(actor,k,v,"次元增幅扣除") then
                return Sendmsg9(actor, "ffffff",  k.."扣除失败", 1) 
            end
        else      
            if not takeitem(actor,k,v,0,"次元增幅") then
                return Sendmsg9(actor, "ffffff",  k.."扣除失败", 1) 
            end
        end
    end
    if giveitem(actor,cfg.name,1) then
        Sendmsg9(actor, "ffffff",  "成功解封次元宗师！", 1)  
    end
    lualib:FlushNpcUi(actor,"DimensionIncreaseOBJ","jf_flush#"..key_name)
end
function DimensionIncreaseOBJ:OnClickZf(actor,key_name)
    key_name = tonumber(key_name) 
    local cfg = DimensionIncreaseOBJ.zfcfg[key_name]  
    
    local name = getiteminfo(actor,linkbodyitem(actor,cfg.part),7)
    
    if name == nil or not DimensionIncreaseOBJ:IsYcyEquip(name) then
       return  Sendmsg9(actor, "ffffff",  "仅异次元宗师装备可进行增幅", 1)  
    end

    for k, v in pairs(cfg.need_map) do
        local stdmode =  getstditeminfo(k,2)
        local count = 0
        if stdmode == 41 then
            count = getbindmoney(actor,k)
        else
            count = getbagitemcount(actor,k)
        end
        if count < v  then
            return Sendmsg9(actor, "ffffff",  k.."数量不足", 1) 
        end
    end
    for k, v in pairs(cfg.need_map) do
        local stdmode =  getstditeminfo(k,2)
        if stdmode == 41 then
            if not consumebindmoney(actor,k,v,"次元增幅扣除") then
                return Sendmsg9(actor, "ffffff",  k.."扣除失败", 1) 
            end
        else      
            if not takeitem(actor,k,v,0,"次元增幅") then
                return Sendmsg9(actor, "ffffff",  k.."扣除失败", 1) 
            end
        end
    end
    local is_sure = math.random() <= (cfg.success_rate / 100)
    if is_sure then
        local entry_id = DimensionIncreaseOBJ:GetRandomEntry(cfg.entry_weight_arr)
        local entry_level = DimensionIncreaseOBJ:GetRandomEntry(cfg.level_weight_arr)
        local str = entry_name_list[entry_id].."Lv"..entry_level
        local attr = DimensionIncreaseOBJ:GetStrengAtt(cfg,entry_id,entry_level)
        DimensionIncreaseOBJ:setStrengthenAttr(actor,cfg.part,attr)
        Sendmsg9(actor, "ffffff",  "增幅成功，获得增幅属性："..str, 1) 
        lualib:FlushNpcUi(actor,"DimensionIncreaseOBJ","zf_flush#"..key_name.."#"..str.."#"..entry_level)
    else
        return Sendmsg9(actor, "ffffff",  "很遗憾，本次增幅失败", 1) 
    end
end
function DimensionIncreaseOBJ:FlushDefAttr(actor,key_name)
     key_name = tonumber(key_name) 
    local cfg = DimensionIncreaseOBJ.zfcfg[key_name]  
    local str = "无"
    local entry_level = 0
    local item_obj = linkbodyitem(actor,cfg.part)
    local attr_str = getitemcustomabil(actor, item_obj)
    local attr_tab = json2tbl(attr_str)
    if type(attr_tab) == "table" then
        for k, v in pairs(attr_tab.abil) do
            if v.t == "[次元增幅]:" then
                for s,value in pairs(v.v) do
                    if entry_attr_id_map[value[2]] ~= nil then
                        str = entry_attr_id_map[value[2]] .. "Lv"..value[3]
                        entry_level = value[3]
                        break 
                    end
                end
            end
        end
    end
    lualib:FlushNpcUi(actor,"DimensionIncreaseOBJ","zf_flush#"..key_name.."#"..str.."#" .. entry_level)
end
function DimensionIncreaseOBJ:GetStrengAtt(cfg,entry_id,entry_level)
    local attr_list = {}
    for i,v in ipairs(cfg["attr"..entry_id]) do
        local value_list = strsplit(v,":")
        table.insert(attr_list,{243, tonumber(value_list[1]),tonumber(value_list[2])*entry_level, 1, 0,i,i})
    end
    table.insert(attr_list,{249, entry_attr_id_list[entry_id],entry_level, 0, 0,#attr_list+1,#attr_list+1})
    return attr_list
end

--设置强化属性
function DimensionIncreaseOBJ:setStrengthenAttr(actor,part_index,attr)
    local item_obj = linkbodyitem(actor,part_index)
    local attr_str = getitemcustomabil(actor, item_obj)
    local attr_tab = json2tbl(attr_str)
    if "" == attr_tab or nil == attr_tab then
        attr_tab = {
            ["abil"] = {}
        }
    end
    
    local tbl = {
        ["i"] = 3,
        ["t"] = "[次元增幅]:",
        ["c"] = 251,
        ["v"] = attr,
    }
    attr_tab.abil[4] = tbl
    setitemcustomabil(actor,item_obj,tbl2json(attr_tab))  --设置物品的强化属性
    refreshitem(actor,item_obj)
end
function DimensionIncreaseOBJ:GetRandomEntry(list)
    local temp_list = {}
    for i,v in ipairs(list) do
        table.insert(temp_list,{value = i,weight = v}) 
    end
    return weightedRandom(temp_list).value
end
--是否异次元装备
function DimensionIncreaseOBJ:IsYcyEquip(equip_name)
    for i,v in ipairs(DimensionIncreaseOBJ.cfg ) do
        if v.name == equip_name then
           return true 
        end
    end
    return false
end
return DimensionIncreaseOBJ