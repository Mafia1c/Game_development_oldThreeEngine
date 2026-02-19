local xuemai = {}
xuemai.cfg = include("QuestDiary/config/talentCfg.lua")
function xuemai:upEvent(actor,param)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服地图禁止使用!", 1)
        return
    end
    local xmtf_data = {}
    xmtf_data.tianfu_data = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.XMTF))
    xmtf_data.xuemai_data = json2tbl(VarApi.getPlayerTStrVar(actor, "xuemaibuff"))
    local num = VarApi.getPlayerJIntVar(actor,"tqfwcx")
    VarApi.setPlayerJIntVar(actor,"tqfwcx",num,true)
    lualib:ShowNpcUi(actor,"xuemaiOBJ",xmtf_data)
    if VarApi.getPlayerUIntVar(actor, "U_navigation_task_step") == 3 then
        navigation(actor, 0, "activateButton", "点击查看血脉")
    end
end
function xuemai:flushRedData(actor)
    local level = getbaseinfo(actor,6)
    if level < 40 then
       return 0
    end
    local tianfu  = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.XMTF))
    local xuemai =  json2tbl(VarApi.getPlayerTStrVar(actor, "xuemaibuff"))
    if tianfu == "" then
        tianfu = {}
    end
    if  (#tianfu < level - 40 and #tianfu < 30)  then
        return 1  
    elseif (xuemai ~= "" or  #xuemai < 6) and #xuemai < math.floor(#tianfu/5) then 
        return 1
    end
    return 0
end
--激活血脉
function xuemai:activeClick(actor)
    local level = getbaseinfo(actor, 6)
    local tf_count = level - 40                 -- 天赋可激活次数
    local xm_count = math.floor(tf_count / 5)    -- 血脉可激活次数
    local tianfu_data = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.XMTF))
    if "" == tianfu_data then
        tianfu_data = {}
    end
    local xuemai_data = json2tbl(VarApi.getPlayerTStrVar(actor, "xuemaibuff"))
    if "" == xuemai_data then
        xuemai_data = {}
    end
    if #tianfu_data >= 30 and #xuemai_data >= 6 then
        Sendmsg9(actor, "ffffff", "天赋已经全部激活", 1)
        return
	end
    local is_tian_fu = true
    local next_index = #tianfu_data + 1 + #xuemai_data
    if next_index % 6 == 0 then
        is_tian_fu = false
        next_index = #xuemai_data + 1
    end

    if is_tian_fu then
        if tf_count <= #tianfu_data then
            Sendmsg9(actor, "ffffff", "剩余天赋激活次数不足", 1)
            return
        end
        local selected = VarApi.getPlayerTStrVar(actor,"random_tianfu") --#当前选中的卡牌
        if selected == nil or selected == "" then
            selected = xuemai:refreshKaiPai(actor,"天赋")
        end
        VarApi.setPlayerTStrVar(actor,"random_tianfu",tbl2json(selected))
        lualib:ShowNpcUi(actor,"tianfuActiveObj",tbl2json(selected))
    else
        if xm_count <= #xuemai_data then
            Sendmsg9(actor, "ffffff", "剩余血脉激活次数不足", 1)
            return
        end
        local selected = VarApi.getPlayerTStrVar(actor,"random_xuemai") --#当前选中的卡牌
        if selected == nil or selected == "" then
            selected = xuemai:refreshKaiPai(actor,"血脉")
        end
        local xue_mai_list = json2tbl(VarApi.getPlayerTStrVar(actor, "xuemaibuff")) 
        if xue_mai_list == nil or xue_mai_list == "" then
            local zhiye = getbaseinfo(actor,7)
            if zhiye == 0 then
                selected = {10712}
            elseif zhiye == 1 then
                selected = {10346}
            else
                selected = {10353}
            end
        end
        VarApi.setPlayerTStrVar(actor,"random_xuemai",tbl2json(selected))
        lualib:ShowNpcUi(actor,"xuemaiActiveObj",tbl2json(selected))
    end
end
function xuemai:isActiveXueMai(tianfu_data,xuemai_data)
    if xuemai_data == "" then
       xuemai_data = {} 
    end
    if tianfu_data == "" then
       tianfu_data = {} 
    end
	if #tianfu_data > 0 and #tianfu_data % 5 == 0 and #xuemai_data < math.floor(#tianfu_data/5) then
		return true
	end
	return  false
end
function xuemai:refreshKaiPai(actor,flush_type)
	local list = {}
    local selected ={}
    if  flush_type == "天赋" then
        for k,v in pairs(xuemai.cfg) do
            if v.talent_group == "天赋" and not xuemai:isMaxLevel(actor,v.key_name,v.maxlevel,"天赋") then
                table.insert(list,v) 
            end
        end
        selected = xuemai:weightedRandomSelect(list, 3)
    else
         for k,v in pairs(xuemai.cfg) do
            if v.talent_group == "血脉" and not xuemai:isMaxLevel(actor,v.key_name,v.maxlevel,"血脉") then
                table.insert(list,v) 
            end
        end
        selected = xuemai:weightedRandomSelect(list, 1)
    end
	return selected
end

--书页 灵符按钮刷新
function xuemai:flushKaiPai(actor,flush_type)
    local tab = strsplit(flush_type,"|")
    if tab[1] == "书页" then
        if not takeitem(actor,"书页",199,0) then
            return Sendmsg9(actor, "ffffff", "书页数量不足", 1)
        end
    else
        if not consumebindmoney(actor,"灵符",100,0) then
            return Sendmsg9(actor, "ffffff", "灵符数量不足", 1)
        end
    end
    local selected = xuemai:refreshKaiPai(actor,tab[2])
    if tab[2] == "天赋" then
        VarApi.setPlayerTStrVar(actor,"random_tianfu",tbl2json(selected))
        lualib:FlushNpcUi(actor,"tianfuActiveObj",tbl2json(selected)) 
    else
        VarApi.setPlayerTStrVar(actor,"random_xuemai",tbl2json(selected))
        lualib:FlushNpcUi(actor,"xuemaiActiveObj",tbl2json(selected)) 
    end
end
function xuemai:resetKaPai(actor,reset_type)
    release_print("aaaaaaaaaaaaaaa")
    -- if reset_type == "天赋" then
    --     VarApi.setPlayerTStrVar(actor,"random_tianfu","")
    -- else
    --     VarApi.setPlayerTStrVar(actor,"random_xuemai","")
    -- end
end
-- 随机选择三个不同的元素
function xuemai:weightedRandomSelect(items, count)
    local temp_items = {}
    for i, v in ipairs(items) do
        temp_items[i] = {key_name = v.key_name, weight = v.weight}
    end
    
    local selected = {}
    
    for i = 1, count do
        if #temp_items == 0 then break end
        
        -- 计算当前总权重
        local total = 0
        for _, v in ipairs(temp_items) do
            total = total + v.weight
        end
        
        -- 随机选择
        local rand = math.random() * total
        local cumulative = 0
        local selected_index
        
        for j, v in ipairs(temp_items) do
            cumulative = cumulative + v.weight
            if rand <= cumulative then
                selected_index = j
                break
            end
        end
        
        if selected_index then
            table.insert(selected, temp_items[selected_index].key_name)
            table.remove(temp_items, selected_index)
        end
    end
    return selected
end
function xuemai:isMaxLevel(actor,key_name,max_level,xuemai_type)
    local data = nil

    if xuemai_type == "天赋" then
        data = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.XMTF))
    else
        data = json2tbl(VarApi.getPlayerTStrVar(actor, "xuemaibuff"))
    end
	if data == nil or data == ""  then return false end
	local num = 0
	for k,v in pairs(data) do
		if tonumber(v)  == key_name then
			num = num + 1  
		end
	end
	if num >= max_level then
		return true
	end
	return false
end

--重修天赋
function xuemai:rebuildClick(actor,selected_index)
    local data = {}
    local index = 0
    local select_list = {}
     if tonumber(selected_index) > 30 then  --血脉
        data = json2tbl(VarApi.getPlayerTStrVar(actor, "xuemaibuff"))
        index = tonumber(selected_index)  - 30
        select_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_xm_has_select")) --已经刷新出来的 天命
        if select_list == "" then
            select_list = {}
        end
     else
        data = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.XMTF))
        index = tonumber(selected_index) 
     end
  
    lualib:ShowNpcUi(actor,"xuemaiChongXiuObj",xuemai.cfg[tonumber(data[index])].key_name .."|"..selected_index .."|"..tbl2json(select_list))
end
--刷新重修界面卡牌
function xuemai:flushChongXiuKaPai(actor,flush_type)
    local tab = strsplit(flush_type,"|")
    if tab[1] == "书页" then
        if not takeitem(actor,"书页",199,0) then
            return Sendmsg9(actor, "ffffff", "书页数量不足", 1)
        end
    elseif tab[1] == "灵符" then
        if not consumebindmoney(actor,"灵符",100,0) then
            return Sendmsg9(actor, "ffffff", "灵符数量不足", 1)
        end
    elseif  tab[1] == "特权" then
        local num = VarApi.getPlayerJIntVar(actor,"tqfwcx")
        local te_level = VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL)
        if te_level <=0 or num <= 0 then
           return 
        end
    elseif  tab[1] == "免费" then
        local num = VarApi.getPlayerUIntVar(actor,"U_zsmf_fwcx")
        if num >=5 then
           return 
        end
    end
    local select_index = tonumber(tab[2])
    local select_list = xuemai:refreshKaiPai(actor,select_index > 30 and "血脉" or "天赋")
    VarApi.setPlayerTStrVar(actor,"T_xm_has_select",tbl2json(select_list))
    if tab[1] == "特权" then
        local num = VarApi.getPlayerJIntVar(actor,"tqfwcx")
        VarApi.setPlayerJIntVar(actor,"tqfwcx",num - 1,true)
    elseif tab[1] == "免费" then
        local num = VarApi.getPlayerUIntVar(actor,"U_zsmf_fwcx")
        VarApi.setPlayerUIntVar(actor,"U_zsmf_fwcx",num + 1,true)
    end
    
    lualib:FlushNpcUi(actor,"xuemaiChongXiuObj",tbl2json(select_list) .."|".. select_index)
end

--设置主角的小天赋信息
function xuemai:setTianFuInfo(actor,param)

    local selected = VarApi.getPlayerTStrVar(actor, "random_tianfu")
    local tab = strsplit(param,"|") 
    local xmtf_data = {}
    local level = getbaseinfo(actor, 6) - 40
    local remain_count = level

    xmtf_data.tianfu_data = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.XMTF))
    xmtf_data.xuemai_data = json2tbl(VarApi.getPlayerTStrVar(actor, "xuemaibuff")) 

    if xmtf_data.tianfu_data == "" then
        xmtf_data.tianfu_data = {}
    end
    if tonumber(tab[1]) == nil then
        Sendmsg9(actor, "ffffff", "非法数据!", 1)
        return
    end
    local _cfg = self.cfg[tonumber(tab[1])]
    if _cfg == nil then
        return
    end
    if _cfg.talent_group ~= "天赋" then
        Sendmsg9(actor, "ffffff", "非法数据!", 1)
        return
    end
    -- 重修
    if tab[2] ~= nil and tab[2] ~= "" then
        local reset = VarApi.getPlayerTStrVar(actor,"T_xm_has_select")
        if nil == reset or "" == reset then
            Sendmsg9(actor, "ffffff", "非法数据!", 1)
            return
        end
        local item_id = xmtf_data.tianfu_data[tonumber(tab[2])]
        local old_buff_id = self.cfg[tonumber(item_id)].buff_id
        local buff_layer = getbuffinfo(actor,old_buff_id,1) 
        if  tonumber(buff_layer) and buff_layer > 1 then
            buffstack(actor,old_buff_id,"-",1,0)
        else
            delbuff(actor, old_buff_id)
        end
        xmtf_data.tianfu_data[tonumber(tab[2])] = tab[1]
        VarApi.setPlayerTStrVar(actor,"T_xm_has_select", "")
    else
        if nil == selected or "" == selected then
            Sendmsg9(actor, "ffffff", "非法数据!", 1)
            return
        end   
        if #xmtf_data.tianfu_data >= remain_count then
            Sendmsg9(actor, "ffffff", "剩余激活次数不足!", 1)
            return
        end        
        local count = 0
        for key, v in pairs(xmtf_data.tianfu_data) do
            if v == tonumber(tab[1]) then
                count = count + 1
            end
        end
        if _cfg.maxlevel <= count then
            Sendmsg9(actor, "ffffff", "当前可叠加层数已满!", 1)
            return
        end
        table.insert(xmtf_data.tianfu_data, tonumber(tab[1]))
    end

    local buff_id = _cfg.buff_id
    addbuff(actor, buff_id)
    VarApi.setPlayerTStrVar(actor,"random_tianfu","")
    lualib:CloseNpcUi(actor,"tianfuActiveObj")

    VarApi.setPlayerTStrVar(actor, VarStrDef.XMTF,tbl2json(xmtf_data.tianfu_data),true)
    if tab[2] ~= nil and tab[2] ~= ""  then
        lualib:FlushNpcUi(actor,"xuemaiOBJ", tbl2json(xmtf_data).."|重修|"..tab[2])
    else
        lualib:FlushNpcUi(actor,"xuemaiOBJ", xmtf_data)
    end
    if VarApi.getPlayerUIntVar(actor, "U_navigation_task_step") == 3 then
        newcompletetask(actor, 103)
    end

end

--设置主角的大天赋信息
function xuemai:setXueMaiInfo(actor,param)
    local select = VarApi.getPlayerTStrVar(actor,"random_xuemai")

    local tab = strsplit(param,"|") 
    local xmtf_data = {}
    local level = getbaseinfo(actor, 6) - 40
    local remain_count = math.floor(level / 5)

    xmtf_data.xuemai_data = json2tbl(VarApi.getPlayerTStrVar(actor, "xuemaibuff")) 

    if  xmtf_data.xuemai_data == "" then
        xmtf_data.xuemai_data = {}
    end

    if nil == tonumber(tab[1]) then
        return
    end
    local cfg = xuemai.cfg[tonumber(tab[1])]
    if cfg == nil then
        return
    end
    if cfg.talent_group ~= "血脉" then
        Sendmsg9(actor, "ffffff", "非法数据!", 1)
        return
    end
    if tab[2] ~= nil and tab[2] ~= "" then
        local reset = VarApi.getPlayerTStrVar(actor,"T_xm_has_select")
        if nil == reset or "" == reset then
            Sendmsg9(actor, "ffffff", "非法数据!", 1)
            return
        end        
        local item_id = xmtf_data.xuemai_data[tonumber(tab[2]) - 30]
        local old_buff_id = xuemai.cfg[tonumber(item_id)].buff_id
        delbuff(actor, old_buff_id)
        xmtf_data.xuemai_data[tonumber(tab[2]) - 30] = tab[1]
        VarApi.setPlayerTStrVar(actor,"T_xm_has_select", "")
    else
        if nil == select or "" == select then
            Sendmsg9(actor, "ffffff", "非法数据!", 1)
            return
        end
        if #xmtf_data.xuemai_data >= remain_count then
            Sendmsg9(actor, "ffffff", "剩余可激活次数不足!", 1)
            return
        end
        if isInTable(xmtf_data.xuemai_data, tonumber(tab[1])) then
            return
        end
        table.insert(xmtf_data.xuemai_data, tonumber(tab[1]))
    end

    local buff_id = cfg.buff_id
    addbuff(actor, buff_id)
    VarApi.setPlayerTStrVar(actor,"random_xuemai","")
    lualib:CloseNpcUi(actor,"xuemaiActiveObj")
    
    xmtf_data.tianfu_data = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.XMTF))
    VarApi.setPlayerTStrVar(actor, "xuemaibuff",tbl2json(xmtf_data.xuemai_data),true)
    if tab[2] ~= nil and tab[2] ~= ""  then
        lualib:FlushNpcUi(actor,"xuemaiOBJ", tbl2json(xmtf_data).."|重修|"..tab[2])
    else
        lualib:FlushNpcUi(actor,"xuemaiOBJ", xmtf_data)
    end
    self:flushBuffRevive(actor)
end
function xuemai:resetBuffLayer(actor)
    local tianfu  = json2tbl(VarApi.getPlayerTStrVar(actor, VarStrDef.XMTF))
    if type(tianfu) == "table" then
        for k, v in pairs(tianfu) do
            if tonumber(v) <= 10343 then
                delbuff(actor,self.cfg[tonumber(v)].buff_id) 
            end
        end
        for k, v in pairs(tianfu) do
            if tonumber(v) <= 10343 then
               addbuff(actor,self.cfg[tonumber(v)].buff_id)
            end
        end
        VarApi.setPlayerUIntVar(actor,"U_is_reset_xuemai_buff",1)
    end
end
function xuemai:flushBuffRevive(actor)
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
    if not isInTable(buff_list,50027) then 
        delbutton(actor,105,5555555)
        return 
    end 
    delbutton(actor,105,5555555)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    local end_time = VarApi.getPlayerUIntVar(actor,"U_50027_buff_cd_timestamp") 
    local y = is_pc and -180 or -80
    if end_time - os.time() > 0 then
        local str = [[
        <Text|x=10|y=%s|color=255|size=18|text=复活时间：>
        <COUNTDOWN|x=100|y=%s|time=%s|count=1|size=16|color=249|link=@buff_countdown_flush>]]
        addbutton(actor,105,5555555,string.format(str,y,y,end_time - os.time()) )  
    else
        local str = [[
        <Text|x=10|y=%s|color=255|size=18|text=复活时间：>
        <Text|x=100|y=%s|color=250|size=18|text=可复活>]]
        addbutton(actor,105,5555555,string.format(str,y,y) )  
    end
end
function buff_countdown_flush(actor)
    local class = IncludeNpcClass("xuemai")
    if class then 
        class:flushBuffRevive(actor)
    end
end

return xuemai