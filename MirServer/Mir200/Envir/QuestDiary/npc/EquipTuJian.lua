local EquipTuJian = {}
EquipTuJian.cfg = include("QuestDiary/config/equipTuJianCfg.lua")
function EquipTuJian:upEvent(actor,param)
    local active_map =json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.ZBTJ)) 
    if active_map == "" then
        active_map = {}
    end
    local suit_active_list = json2tbl(VarApi.getPlayerTStrVar(actor,"_suitawardstate")) 
    if suit_active_list == "" then
        suit_active_list = {}
    end

    lualib:ShowNpcUi(actor,"EquipTuJianObj","initFlush#"..param.."#"..tbl2json(active_map).."#"..tbl2json(suit_active_list))
end
function EquipTuJian:OnClickShouJi(actor,key_name)
    local cfg = EquipTuJian.cfg[tonumber(key_name)]
    local is_set =false
    for i = 1, 6 do
        if getbagitemcount(actor,cfg["pos"..i]) > 0 and not EquipTuJian:checkHasActive(actor,tonumber(key_name) ,i) then
            if takeitem(actor,cfg["pos"..i],1,0) then 
                EquipTuJian:setActiveState(actor,key_name,i)
                is_set = true
            end
        end
    end
    if is_set then
        local active_map =json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.ZBTJ)) 
        if active_map == "" then
            active_map = {}
        end
        if EquipTuJian:activeSuitMax(key_name,active_map) then
            EquipTuJian:setSuitAward(actor,key_name)
            local list = {}
            for i = 1, 2 do
                table.insert(list,{name = cfg["award_money"..i],count = cfg["award_money_num"..i]})
            end
            lualib:ShowAwardTipUi(actor,list)
            changemoney(actor, getstditeminfo(cfg.award_money1, 0), "+", cfg.award_money_num1, "_装备图鉴激活增加", true)
            changemoney(actor, getstditeminfo(cfg.award_money2, 0), "+", cfg.award_money_num2, "_装备图鉴激活增加", true)
        end
        local suit_active_list = json2tbl(VarApi.getPlayerTStrVar(actor,"_suitawardstate")) 
        if suit_active_list == "" then
            suit_active_list = {}
        end
        lualib:FlushNpcUi(actor,"EquipTuJianObj","flushState|"..key_name.."|"..tbl2json(active_map).."|"..tbl2json(suit_active_list))
        EquipTuJian:SetAvtiveAttr(actor)
        Sendmsg9(actor, "ffffff",  "收集成功", 1) 
        EquipTuJian:flushRedData(actor)
    else
        Sendmsg9(actor, "ffffff",  "未发现可收集装备", 1) 
    end
end
--检查是不是已经激活
function EquipTuJian:checkHasActive(actor,key_name,pos_index)
    local active_map = json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.ZBTJ)) 
    if active_map == "" then
        return false
    end
    for k, v in pairs(active_map) do
        if v.key_name == key_name and v.pos_index == pos_index  then
            return v.is_active
        end
    end
    return false
end
--设置激活图鉴
function EquipTuJian:setActiveState(actor,key_name,pos_index)
    local active_map = json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.ZBTJ)) 
    if active_map == "" then
        active_map = {}
    end
    table.insert(active_map,{key_name = tonumber(key_name) ,pos_index = pos_index,is_active = true}) 
    VarApi.setPlayerTStrVar(actor,VarStrDef.ZBTJ,tbl2json(active_map))
end
--设置激活的属性
function EquipTuJian:SetAvtiveAttr(actor)
    delattlist(actor, "equip_tujian")
    local active_map =json2tbl(VarApi.getPlayerTStrVar(actor,VarStrDef.ZBTJ)) 
    if active_map == "" then
        return
    end

	local hp,attack,defense,hp_up = 0,0,0,0
	for k,v in pairs(active_map) do
		if v.is_active then
			if v.pos_index <= 2 and v.is_active then
				hp = 10 + hp
			elseif v.pos_index > 2 and v.pos_index <= 4 then
				attack = attack + 1
			elseif v.pos_index > 4 and v.pos_index <= 6 then
				defense = defense + 1
			end
		end
	end
    local attr_str = ""
    if hp > 0 then
        attr_str = attr_str .. "3#1#"..hp.."|"
    end
    if attack > 0 then
        attr_str =  attr_str .. "3#4#"..attack.."|".."3#6#"..attack.."|".."3#8#"..attack.."|"
    end

    if defense > 0 then
        attr_str = attr_str .. "3#10#"..defense.."|".."3#12#"..defense.."|"
    end

	for k,v in pairs(EquipTuJian.cfg) do
		if EquipTuJian:getSuitIsActive(actor,v.key_name) then
			hp_up = hp_up + 200
		end
	end

    if hp_up > 0 then
        attr_str = attr_str .. "3#89#"..hp_up
    end
    addattlist(actor,"equip_tujian","+",attr_str)
    VarApi.setPlayerTStrVar(actor, "_equiptujian",attr_str )
end
--整套装备激活奖励
function EquipTuJian:setSuitAward(actor,key_name)
    local active_map = json2tbl(VarApi.getPlayerTStrVar(actor,"_suitawardstate")) 
    if active_map == "" then
        active_map = {}
    end
    table.insert(active_map,key_name)
    VarApi.setPlayerTStrVar(actor, "_suitawardstate",tbl2json(active_map))
 
end

--整套是否已经激活整套
function EquipTuJian:activeSuitMax(key_name,active_map)
	local suit_num = 0
	for i=1,6 do
		for _,info in pairs(active_map) do
			if tonumber(key_name) == tonumber(info.key_name)  and tonumber(info.pos_index) == i and info.is_active then
				suit_num = suit_num + 1
			end
		end
	end
	return suit_num >= 6
end
function EquipTuJian:getSuitIsActive(actor,key_name)
    local active_map = json2tbl(VarApi.getPlayerTStrVar(actor,"_suitawardstate")) 
    if active_map == "" then
      return false
    end
    for k, v in pairs(active_map) do
        if tonumber(v) == tonumber(key_name) then
            return true 
        end
    end
    return false
end
function EquipTuJian:flushRedData(actor)
    for _,v in ipairs(EquipTuJian.cfg) do
        for i = 1, 6 do
            local equip_name = v["pos"..i]
            local count =  getbagitemcount(actor,equip_name)
            if count > 0 and not EquipTuJian:checkHasActive(actor,tonumber(v.key_name) ,i)  then
                VarApi.setPlayerTStrVar(actor,"T_equip_tujian_red_num",1,true)
                return 
            end
        end
    end
    VarApi.setPlayerTStrVar(actor,"T_equip_tujian_red_num",0,true)
end 
local function _onLogin(actor)
    local attr_str = VarApi.getPlayerTStrVar(actor,"_equiptujian")
    delattlist(actor, "equip_tujian")
    addattlist(actor,"equip_tujian","+",attr_str)
    return false
end

GameEvent.add("login", _onLogin, "EquipTuJian")

return EquipTuJian