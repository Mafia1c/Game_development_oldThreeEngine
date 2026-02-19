local Strengthen = {}
Strengthen.cfg = include("QuestDiary/config/strengthenMasterCfg.lua")
Strengthen.suit_cfg = include("QuestDiary/config/suitAttrCfg.lua")
function Strengthen:upEvent(actor,param)
    local is_select = VarApi.getPlayerUIntVar(actor,"strengthen_check")
    lualib:FlushNpcUi(actor,"StrengthenObj","inin_check_box|"..is_select)
end
function Strengthen:ClickCheckBox(actor,is_check_box)
    if getbagitemcount(actor,"幸运符") <= 0 then
        return
    end 
    VarApi.setPlayerUIntVar(actor,"strengthen_check",is_check_box)
    lualib:FlushNpcUi(actor,"StrengthenObj","flush_check_box|"..is_check_box)
end
--点击强化
function Strengthen:strengthenOnClick(actor,index)
    local part_index = tonumber(index) 
    local cur_level = getitemaddvalue(actor,linkbodyitem(actor,part_index),2,3)
    if cur_level == -1 then
       return  Sendmsg9(actor, "ffffff",  "该部位未穿戴装备，无法强化!", 1)
    end

    local cfg = Strengthen.cfg[part_index][cur_level] 
    --是否满级
    if Strengthen:isMaxLevel(part_index,cur_level) then
        return Sendmsg9(actor, "ffffff",  "强化已满级！", 1)
    end
    if  getbagitemcount(actor,cfg.need_item) < cfg.need_item_num then
       return Sendmsg9(actor, "ffffff",  cfg.need_item.."数量不足", 1) 
    end
    if  getbindmoney(actor,cfg.need_money_name) < cfg.need_money_num then
       return Sendmsg9(actor, "ffffff",  cfg.need_money_name.."数量不足", 1) 
    end
    if not takeitem(actor,cfg.need_item, cfg.need_item_num,0,"强化扣除") then
        return Sendmsg9(actor, "ffffff",  cfg.need_item.."数量不足", 1) 
    end
    if not consumebindmoney(actor,cfg.need_money_name,cfg.need_money_num,"强化扣除通用货币扣除") then
        return Sendmsg9(actor, "ffffff",  cfg.need_item.."数量不足", 1) 
    end
    --是否勾选幸运符
    local is_select = VarApi.getPlayerUIntVar(actor,"strengthen_check")
    local odds = cfg.odds
    if is_select > 0 then
        odds = odds + 10
        if not takeitem(actor,"幸运符", 1,0,"强化扣除") then
            Sendmsg9(actor, "ffffff",  "幸运符数量不足", 1) 
        end
    end
    local level = cur_level
    local odds_nuber = math.random()
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    local gs_odds = 0
    if type(list) == "table" and list[account_id] then
        gs_odds = list[account_id]["equip_stren_odds"] or 0
    end
    local is_sure = odds_nuber <= odds / 100 + (gs_odds == "" and 0 or gs_odds/100)
    if is_sure then 
        level = cur_level + 1
        local player_name = getbaseinfo(actor,1)
        local equip_name = getiteminfo(actor,linkbodyitem(actor,part_index),7)
        -- local str =  "强化大师:恭喜<「%s」/FCOLOR=250>成功将：<「%s」/FCOLOR=250>强化至<「+%s」/FCOLOR=250>，获得永久强化属性"
        -- Sendmsg13(actor,255, string.format(str,player_name,equip_name,level) ,2,13)
        Sendmsg9(actor, "ffffff",  "强化成功", 1) 
    else
        level = cur_level - 1
        Sendmsg9(actor, "ff0000",  "强化失败,强化等级降低1级", 1) 
    end
    
    if level < 0 then level = 0 end
    Strengthen:setStrengthenAttr(actor,part_index,level,Strengthen.cfg[part_index][level])

    local equip_pos_level_list = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.QHDS)) 
    if type(equip_pos_level_list) == "string" then
        equip_pos_level_list =  {} 
    end
    equip_pos_level_list["equip_"..part_index] = level
    VarApi.setPlayerTStrVar(actor,VarStrDef.QHDS,tbl2json(equip_pos_level_list))

    if is_select > 0 and getbagitemcount(actor,"幸运符") < 1 then
        VarApi.setPlayerUIntVar(actor,"strengthen_check",0)
        lualib:FlushNpcUi(actor,"StrengthenObj","flush_check_box|"..0)
    else
        lualib:FlushNpcUi(actor,"StrengthenObj","flushqianghua|"..part_index)
    end
    Strengthen:flushSuitAttr(actor)
end
--设置强化属性
function Strengthen:setStrengthenAttr(actor,part_index,level,cfg)
    local item_obj = linkbodyitem(actor,part_index)
    setitemaddvalue(actor,item_obj,2,3,level)  --设置物品的星级
    if level > 0 then
        local job = getbaseinfo(actor,7)
        local cur_job_attr = cfg.cur_job_attr_map[job]
        local subjoin_attr_id  = tonumber(cfg.cur_subjoin_attr_arr[1])
        local subjoin_attr_value  = tonumber(cfg.cur_subjoin_attr_arr[2])
        if subjoin_attr_id >= 21 and subjoin_attr_id <= 32 then
            subjoin_attr_value = subjoin_attr_value / 100
        end
        local attr_str = getitemcustomabil(actor, item_obj)
        local attr_tab = json2tbl(attr_str)
        if "" == attr_tab or nil == attr_tab then
            attr_tab = {
                ["abil"] = {}
            }
        end
       
        local tbl = {
            ["i"] = 1,
            ["t"] = "[强化属性]:",
            ["c"] = 251,
            ["v"] = {
                {250,tonumber(cur_job_attr[1]),tonumber(cur_job_attr[2]),0,0,1,1},
                {250,subjoin_attr_id,subjoin_attr_value,1,0,2,2}
            },
        }
        attr_tab.abil[2] = tbl
        setitemcustomabil(actor,item_obj,tbl2json(attr_tab))  --设置物品的强化属性
    else
        local attr_str = getitemcustomabil(actor, item_obj)
        local attr_tab = json2tbl(attr_str)
        if "" == attr_tab or nil == attr_tab then
            attr_tab = {
                ["abil"] = {}
            }
        end
        local tbl = {
            ["i"] = 1,
            ["t"] = "",
            ["c"] = 0,
            ["v"] = {},
        }
        attr_tab.abil[2] = tbl
        setitemcustomabil(actor,item_obj,tbl2json(attr_tab))  --设置物品的强化属性
    end
    refreshitem(actor,item_obj)
end
---属性总等级属性
function Strengthen:flushSuitAttr(actor)
    local title_name = VarApi.getPlayerTStrVar(actor,"T_strenthen_title")
    local equpos_map = {1,4,6,8,10,0,3,5,7,11}
	local all_levle = 0
 	for k,v in pairs(equpos_map) do
        local cur_level = getitemaddvalue(actor,linkbodyitem(actor,v),2,3)
        if cur_level > 0 then
            all_levle = all_levle + cur_level
        end
 	end
    local cfg = nil
    for i = 1, #Strengthen.suit_cfg do
        if all_levle >= Strengthen.suit_cfg[i].level then
            cfg = Strengthen.suit_cfg[i]
        end
    end
    if cfg and not checktitle(actor,cfg.title_name) then
        if title_name ~= "" then
            deprivetitle(actor,title_name)
        end
        VarApi.setPlayerTStrVar(actor,"T_strenthen_title",cfg.title_name)
        confertitle(actor,cfg.title_name)
    elseif checktitle(actor,"强化达人Lv40") then
         deprivetitle(actor,title_name)
    end
end
function Strengthen:getSuitAttr(cfg)
    local index = 1
    local attr_list = {}
    if cfg.attr1 ~= "" then
        local str_tab = strsplit(cfg.attr1,"|")
        for i,v in ipairs(str_tab) do
            local attr_tab = strsplit(v,"#")
            table.insert(attr_list,{id = tonumber(attr_tab[2]) ,value = tonumber(attr_tab[3]) }) 
        end
    end
    if cfg.attr2 ~= "" then
        local str_tab = strsplit(cfg.attr2,"|")
        for i,v in ipairs(str_tab) do
            local attr_tab = strsplit(v,"#")
            table.insert(attr_list,{id = tonumber(attr_tab[1]),value = tonumber(attr_tab[2])}) 
        end
    end
    return attr_list
end
function Strengthen:isMaxLevel(part_index,cur_level)
    local max_level = 0
    for k, v in pairs(Strengthen.cfg[part_index]) do
        max_level = max_level + 1
    end 
    return cur_level >= max_level - 1
end
--穿戴装备
local function _StrengthenTakeOnCallback(actor,item,index,name)
    local equip_pos_level_list = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.QHDS)) 
    if type(equip_pos_level_list) == "string" then
        return true
    end
    local level = equip_pos_level_list["equip_"..tostring(index) ] 
    if level == nil or level <= 0 then return true end
    local cfg = Strengthen.cfg[index][level] 
    Strengthen:setStrengthenAttr(actor,index,level,cfg)
    return false
end
GameEvent.add("takeonex", _StrengthenTakeOnCallback, "Strengthen")
--脱下装备
local function _StrengthenTakeOffCallback(actor,item,index,name)
    local attr_str = getitemcustomabil(actor, item)
    local attr_tab = json2tbl(attr_str)
    if "" == attr_tab or nil == attr_tab then
        attr_tab = {
            ["abil"] = {}
        }
    end
    local tbl = {
        ["i"] = 1,
        ["t"] = "",
        ["c"] = 0,
        ["v"] = {},
    }
    attr_tab.abil[2] = tbl
    setitemcustomabil(actor,item,tbl2json(attr_tab))  --设置物品的强化属性
    if Strengthen.cfg[index] then
        setitemaddvalue(actor,item,2,3,0)  --设置物品的星级
    end
    return false
end

GameEvent.add("takeoffex", _StrengthenTakeOffCallback, "Strengthen")

return Strengthen