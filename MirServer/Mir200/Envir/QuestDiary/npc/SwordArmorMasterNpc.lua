local SwordArmorMasterNpc = {}
SwordArmorMasterNpc.sb_cfg = include("QuestDiary/config/sbChangeCfg.lua")               -- Éñ±ø»¥»»
SwordArmorMasterNpc.fm_cfg = include("QuestDiary/config/JianJiaFuMoCfg.lua")            -- ½£¼×¸½Ä§

SwordArmorMasterNpc.wuqi_cfg = getWeightedCfg("1#500|2#300|3#200|4#100|5#50|6#10|7#5|8#3|9#2|10#1")
SwordArmorMasterNpc.yifu_cfg = getWeightedCfg("1#500|2#300|3#200|4#100|5#50|6#10|7#5|8#3|9#2|10#1")

function SwordArmorMasterNpc:click(actor, npc_id)
    lualib:ShowNpcUi(actor, "SwordArmorMasterOBJ", npc_id)
end

-- Éñ±ø»¥»»
function SwordArmorMasterNpc:onClickExchange(actor, index)
    index = tonumber(index)
    local cfg = self.sb_cfg[index]
    if nil == index or nil == cfg then
        return
    end
    local equip_count = getbagitemcount(actor, cfg.name, 0)
    release_print("onClickExchange: "..equip_count)
    if equip_count <= 0 then
        return Sendmsg9(actor,  "ffffff", "Çë¼ì²éÄãÊÇ·ñÓµÓÐ"..cfg.name.."!" , 1)
    end
    local givename = cfg["givename"]
    local need_data = cfg["need_map"]
    for k, v in pairs(need_data) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v) then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."Éñ±ø»¥»»¿Û³ý") then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        end
    end
    Sendmsg9(actor,  "ffffff", "»¥»»³É¹¦!" , 1)
    giveitem(actor, givename, 1)
end

-- µã»÷½£¼×¸½Ä§µ¼º½°´Å¥     index: 1.ÎäÆ÷   2.ÒÂ·þ
function SwordArmorMasterNpc:onClickEnchantPage(actor, index)
    index = tonumber(index)
    if index == 2 then
        index = 0
    end
    local equip = linkbodyitem(actor, index)
    local cur_count = getitemaddvalue(actor, equip, 2, 19, 0)
    if nil == cur_count or cur_count < 0 then
        cur_count = 0
    end
    local attr_str = getitemcustomabil(actor, equip)
    local attr_tab = json2tbl(attr_str)
    lualib:FlushNpcUi(actor, "SwordArmorMasterOBJ",  index.."#"..cur_count)
end


-- ½£¼×¸½Ä§     equip_index: 0.ÒÂ·þ   1.ÎäÆ÷
function SwordArmorMasterNpc:onClickEquipEnchant(actor, equip_index)
    equip_index = tonumber(equip_index)
    local equip = linkbodyitem(actor, equip_index)
    if nil == equip then
        return Sendmsg9(actor,  "ffffff", "Î´Åå´÷×°±¸ÎÞ·¨¸½Ä§!" , 1)
    end
    local cur_count = getitemaddvalue(actor, equip, 2, 19, 0)
    if cur_count < 0 then
        cur_count = 0
    end
    local offset = 0
    if equip_index == 0 then
        offset = 8
    end
    local next_count = cur_count + 1
    local cfg = self.fm_cfg[next_count + offset]
    local tag = false
    if next_count > 7 then
        next_count = 7
        cfg = self.fm_cfg[next_count + offset]
        tag = true
    end
    local need_data = cfg["need_map"]
    for k, v in pairs(need_data) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."²»×ã" , 1)
        end
    end
    local attr_str = getitemcustomabil(actor, equip)
    local attr_tab = json2tbl(attr_str)
    if tag then
        local str = "µ±Ç°ÎäÆ÷¸½Ä§¹¥»÷ËÙ¶È: +" .. attr_tab.abil[1].v[2][3]
        local txt = "Éñ±ø¸½Ä§"
        if equip_index == 0 then
            str = "µ±Ç°ÒÂ·þ¸½Ä§ËùÓÐÉËº¦·´µ¯: " .. attr_tab.abil[1].v[3][3].."%"
            txt = "Éñ¼×¸½Ä§"
        end
        messagebox(actor, str.."\\ÊÇ·ñÈ·¶¨Ï´Á·¸½Ä§ÊôÐÔ", "@_g_click_ok,"..txt..","..equip_index..","..(next_count + offset), "@_g_click_no,"..(next_count + offset))
        return
    end

    for k, v in pairs(need_data) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v) then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."Éñ±ø»¥»»¿Û³ý") then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        end
    end

    local tmp_tab = {}
    for k, v in pairs(cfg.addid_map) do
        local value = v
        if equip_index == 1 then
            value = value * 100
        end
        local tab = {255, k, value, 1, 0, #tmp_tab, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = tab
    end

    local attr_id = {
        [0] = 29,
        [1] = 20
    }
    local value = weightedRandom(equip_index == 0 and self.yifu_cfg or self.wuqi_cfg).value
    release_print("value ", value)
    if next_count == 7 then
        tmp_tab[#tmp_tab + 1] = {249, attr_id[equip_index], value, equip_index == 0 and 1 or 0, 0, #tmp_tab + 1, #tmp_tab + 1}
        LF.dump(tmp_tab)
    end
    if "" == attr_tab or nil == attr_tab then
        attr_tab = {
            ["abil"] = {}
        }
    end
    local tbl = {
        ["i"] = 0,
        ["t"] = "[Éñ±ø¸½Ä§]: ",
        ["c"] = 253,
        ["v"] = tmp_tab,
    }
    attr_tab.abil[1] = tbl                              -- ¸½Ä§·ÅµÚÒ»ÅÅ   Ç¿»¯µÚ¶þÅÅ
    setitemcustomabil(actor, equip, tbl2json(attr_tab))
    setitemaddvalue(actor, equip, 2, 19, next_count)
    Sendmsg9(actor,  "ffffff", "¸½Ä§³É¹¦!" , 1)
    lualib:FlushNpcUi(actor, "SwordArmorMasterOBJ",  equip_index.."#"..next_count)
end

-- ¸½Ä§×ªÒÆµ¼º½
function SwordArmorMasterNpc:onEnchantTransferPage(actor, index)
    index = tonumber(index)
    if index == 2 then
        index = 0
    end
    local equip = linkbodyitem(actor, index)
    local cur_count = getitemaddvalue(actor, equip, 2, 19, 0)
    if cur_count < 0 then
        cur_count = 0
    end
    lualib:FlushNpcUi(actor, "SwordArmorMasterOBJ",  index.."#"..cur_count.."#123")
end

-- ×ªÒÆ¸½Ä§ÊôÐÔ
function SwordArmorMasterNpc:onClickZhuanYi(actor, makeindex, equip_type)
    equip_type = tonumber(equip_type)
    makeindex = tonumber(makeindex)
    if equip_type == 2 then
        equip_type = 0
    end
    if makeindex == -1 then
        return Sendmsg9(actor,  "ffffff", "ÇëÏÈÑ¡Ôñ×°±¸!" , 1)
    end
    local item = getitembymakeindex(actor, makeindex)
    local equip = linkbodyitem(actor, equip_type)
    local cur_count = getitemaddvalue(actor, equip, 2, 19, 0)
    if cur_count <= 0 then
        return Sendmsg9(actor,  "ffffff", "ÄãÅå´÷µÄ×°±¸Ã»ÓÐ¸½Ä§ÊôÐÔ!" , 1)
    end
    local select_count = getitemaddvalue(actor, item, 2, 19, 0)
    if select_count > 0 then
        return Sendmsg9(actor,  "ffffff", "ÄãÑ¡ÔñµÄ×°±¸ÒÑÓÐ¸½Ä§ÊôÐÔ!" , 1)
    end
    local num = getbindmoney(actor, "Áé·û")
    if num < 100 then
        return Sendmsg9(actor,  "ffffff", "Áé·û²»×ã!" , 1)
    end
    if not consumebindmoney(actor, "Áé·û", 100) then
        return Sendmsg9(actor,  "ffffff", "Áé·û¿Û³ýÊ§°Ü" , 1)
    end    
    local attr_str = getitemcustomabil(actor, equip)
    local attr_tab = json2tbl(attr_str)
    local tab = attr_tab.abil[1]
    local item_attr_str = getitemcustomabil(actor, item)
    local item_tab = json2tbl(item_attr_str)
    if item_tab == "" or #item_attr_str <= 0 then
        item_tab = {
            ["abil"] = {}
        }
    end
    item_tab.abil[1] = tab
    attr_tab.abil[1] = {
        ["i"] = 0,
        ["t"] = 0,
        ["c"] = 0,
        ["v"] = {},
    }

    setitemcustomabil(actor, equip, tbl2json(attr_tab))
    setitemaddvalue(actor, equip, 2, 19, 0)

    setitemcustomabil(actor, item, tbl2json(item_tab))
    setitemaddvalue(actor, item, 2, 19, cur_count)

    lualib:FlushNpcUi(actor, "SwordArmorMasterOBJ",  equip_type.."#1#234")
    return Sendmsg9(actor,  "ffffff", "×ªÒÆ³É¹¦!" , 1)
end

function _g_click_ok(actor, tag, equip_index, index)
    local gm_certainly_count = VarApi.getPlayerUIntVar(actor,"U_gs_wq_certainly_count")
    if tonumber(equip_index) == 0 then
        gm_certainly_count = VarApi.getPlayerUIntVar(actor,"U_gs_yf_certainly_count") 
    end
    index = tonumber(index)
    local npc_class = NpcClassCache["SwordArmorMasterNpc"]
    local cfg = npc_class.fm_cfg[index]
    for k, v in pairs(cfg["need_map"]) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v) then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."Éñ±ø»¥»»¿Û³ý") then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        end
    end
    equip_index = tonumber(equip_index)
    local value = weightedRandom(equip_index == 0 and npc_class.yifu_cfg or npc_class.wuqi_cfg).value
    if gm_certainly_count == 1 then
        value = 10
        if equip_index == 0 then
            VarApi.setPlayerUIntVar(actor,"U_gs_yf_certainly_count",0)
        else
            VarApi.setPlayerUIntVar(actor,"U_gs_wq_certainly_count",0)
        end
    elseif gm_certainly_count > 1 then
        if equip_index == 0 then
            VarApi.setPlayerUIntVar(actor,"U_gs_yf_certainly_count",gm_certainly_count-1)
        else
            VarApi.setPlayerUIntVar(actor,"U_gs_wq_certainly_count",gm_certainly_count-1)
        end
    end
    local name = getbaseinfo(actor, 1)
    local str =  "½£¼×¸½Ä§: ´óÀÐ¡¸<%s/FCOLOR=250>¡¹³É¹¦Ï´Á·%s£¬»ñµÃ¡¸<%s/FCOLOR=253>¡¹ËÙÀ´Õ°Ñö!"
    local txt = "¹¥»÷ËÙ¶È+"..value
    local _index = 2
    if tag == "Éñ¼×¸½Ä§" then
        txt = "ËùÓÐÉËº¦·´µ¯: "..value.."%"
        _index = 3
    end
    local equip = linkbodyitem(actor, equip_index)
    local attr_str = getitemcustomabil(actor, equip)
    local attr_tab = json2tbl(attr_str)
    attr_tab.abil[1].v[_index][3] = value
    setitemcustomabil(actor, equip, tbl2json(attr_tab))
    Sendmsg13(actor,255, string.format(str, name, tag, txt), 2, 15)
    lualib:FlushNpcUi(actor, "SwordArmorMasterOBJ",  equip_index.."#7")
end

function _g_click_no(actor, index)
    -- index = tonumber(index)
    -- local cfg = NpcClassCache["SwordArmorMasterNpc"].fm_cfg[index]
end

return SwordArmorMasterNpc