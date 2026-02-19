local LingZhuangStrengthen = {}
LingZhuangStrengthen.cfg = include("QuestDiary/config/LingZhuangStrengthenCfg.lua")
LingZhuangStrengthen.suit_cfg = include("QuestDiary/config/LingZhuangSuitCfg.lua")
LingZhuangStrengthen.map_cfg = {}
for i,v in ipairs(LingZhuangStrengthen.cfg) do
	LingZhuangStrengthen.map_cfg[v.part_name] =  LingZhuangStrengthen.map_cfg[v.part_name] or {}
	table.insert(LingZhuangStrengthen.map_cfg[v.part_name],v)
end

function LingZhuangStrengthen:upEvent(actor,param)
    local is_select = VarApi.getPlayerUIntVar(actor,"LingZhuangStrengthen_check")
    lualib:ShowNpcUi(actor,"LingZhuangStrengthenOBJ","inin_check_box#"..is_select)
end
function LingZhuangStrengthen:ClickCheckBox(actor,is_check_box)
    if getbagitemcount(actor,"幸运符") <= 0 then
        return
    end 
    VarApi.setPlayerUIntVar(actor,"LingZhuangStrengthen_check",is_check_box)
    lualib:FlushNpcUi(actor,"LingZhuangStrengthenOBJ","flush_check_box|"..is_check_box)
end
--点击强化
function LingZhuangStrengthen:StrengthenOnClick(actor,index)
    local part_index = tonumber(index) 
    local name = getiteminfo(actor,linkbodyitem(actor,part_index),7)
    if name == "" or name == nil then
        return Sendmsg9(actor, "ffffff",  "该部位未穿戴装备，无法强化!", 1)
    end

    if string.find(name, "%(GP%)$") == nil then
        return Sendmsg9(actor, "ffffff",  "仅GP灵装可进行强化!", 1)
    end
    local cur_level = getitemaddvalue(actor,linkbodyitem(actor,part_index),2,3)
    if cur_level == -1 then
       return  Sendmsg9(actor, "ffffff",  "该部位未穿戴装备，无法强化!", 1)
    end

    local gsub_name = name:gsub("%(.-%)", "")
    local cfg = LingZhuangStrengthen.map_cfg[gsub_name][cur_level + 1] 
    -- --是否满级
    if LingZhuangStrengthen:isMaxLevel(gsub_name,cur_level,part_index) then
        return Sendmsg9(actor, "ffffff",  "强化已满级！", 1)
    end
    if  getbagitemcount(actor,cfg.need_item) < cfg.need_item_num then
       return Sendmsg9(actor, "ffffff",  cfg.need_item.."数量不足", 1) 
    end
    if  getbindmoney(actor,cfg.need_money_name) < cfg.need_money_num then
       return Sendmsg9(actor, "ffffff",  cfg.need_money_name.."数量不足", 1) 
    end
    if not takeitem(actor,cfg.need_item, cfg.need_item_num,0,"强化扣除") then
        return Sendmsg9(actor, "ffffff",  cfg.need_item.."扣除失败", 1) 
    end
    if not consumebindmoney(actor,cfg.need_money_name,cfg.need_money_num,"强化扣除通用货币扣除") then
        return Sendmsg9(actor, "ffffff",  cfg.need_item.."扣除失败", 1) 
    end
    --是否勾选幸运符
    local is_select = VarApi.getPlayerUIntVar(actor,"LingZhuangStrengthen_check")
    local odds = cfg.odds
    if is_select > 0 then
        odds = odds + 10
        if not takeitem(actor,"幸运符", 1,0,"强化扣除") then
            Sendmsg9(actor, "ffffff",  "幸运符数量不足", 1) 
        end
    end
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    local gs_odds = 0
    if type(list) == "table" and list[account_id] then
        gs_odds = list[account_id]["lzqh_odds"] or 0
    end

    local level = cur_level
    local odds_nuber = math.random(100)
    local is_sure = odds_nuber <= (odds + gs_odds)
    if is_sure then 
        level = cur_level + 1
        local player_name = getbaseinfo(actor,1)

        local str =  "强化大师:恭喜<「%s」/FCOLOR=250>成功将：<「%s」/FCOLOR=250>强化至<「+%s」/FCOLOR=250>，获得永久强化属性"
        Sendmsg13(actor,255, string.format(str,player_name,name,level) ,2,13)
        Sendmsg9(actor, "ffffff",  "强化成功", 1) 
    else
        level = cur_level - 1
        Sendmsg9(actor, "ff0000",  "强化失败,强化等级降低1级", 1) 
    end
    
    if level < 0 then level = 0 end
    LingZhuangStrengthen:setLingZhuangStrengthenAttr(actor,part_index,level,LingZhuangStrengthen.map_cfg[gsub_name][level + 1])

    if is_select > 0 and getbagitemcount(actor,"幸运符") < 1 then
        VarApi.setPlayerUIntVar(actor,"LingZhuangStrengthen_check",0)
        lualib:FlushNpcUi(actor,"LingZhuangStrengthenOBJ","flush_check_box|"..0)
    else
        lualib:FlushNpcUi(actor,"LingZhuangStrengthenOBJ","flushqianghua|"..part_index)
    end
    LingZhuangStrengthen:flushSuitAttr(actor)
end
--设置强化属性
function LingZhuangStrengthen:setLingZhuangStrengthenAttr(actor,part_index,level,cfg)
    local item_obj = linkbodyitem(actor,part_index)
    setitemaddvalue(actor,item_obj,2,3,level)  --设置物品的星级
    local attr_str = cfg.cur_job_attr .."|".. cfg.cur_subjoin_attr_arr
    setaddnewabil(actor,-2,"=",attr_str,item_obj)
    refreshitem(actor,item_obj)
end
---属性总等级属性
function LingZhuangStrengthen:flushSuitAttr(actor)
    delbuff(actor, 30000)
    local equpos_map = {20,22,23,27,26,24,25,28}
	local all_levle = 0
 	for k,v in pairs(equpos_map) do
        local cur_level = getitemaddvalue(actor,linkbodyitem(actor,v),2,3)
        if cur_level > 0 then
            all_levle = all_levle + cur_level
        end
 	end
    local cfg = nil
    for i = 1, #LingZhuangStrengthen.suit_cfg do
        if all_levle >= LingZhuangStrengthen.suit_cfg[i].level then
            cfg = LingZhuangStrengthen.suit_cfg[i]
        end
    end
    if cfg then
        local buffTab = {}
        for k, v in pairs(LingZhuangStrengthen:getSuitAttr(cfg)) do
           
            buffTab[v.id] = v.value
        end
        addbuff(actor, 30000, 0, 1, actor, buffTab)
    end
end
function LingZhuangStrengthen:getSuitAttr(cfg)
    local attr_list = {}
    local str_tab = strsplit(cfg.arr_map,"|")
    for i,v in ipairs(str_tab) do
        local attr_tab = strsplit(v,"#")
        table.insert(attr_list,{id = tonumber(attr_tab[1]) ,value = tonumber(attr_tab[2]) }) 
    end
    return attr_list
end
function LingZhuangStrengthen:BuyGiftClick(actor,count)
    count = tonumber(count)
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_zylb",count,"LingZhuangBuyTip") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end
function LingZhuangStrengthen:isMaxLevel(name,cur_level,part_index)
    local max_level = 0
    for k, v in pairs(LingZhuangStrengthen.map_cfg[name]) do
        if v.strengthen_level > 0 and v.part_index == part_index then
            max_level = max_level +1 
        end
    end 
    return cur_level >= max_level
end

return LingZhuangStrengthen