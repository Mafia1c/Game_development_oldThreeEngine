local DragonFeathersNpc = {}
DragonFeathersNpc.cfg = include("QuestDiary/config/DragonFeathersCfg.lua")
DragonFeathersNpc.attr_ids = {89, 35, 22, 26, 27}

function DragonFeathersNpc:click(actor)
    local str_tab = self:getAttrList(actor)
    lualib:ShowNpcUi(actor, "DragonFeathersOBJ", tbl2json(str_tab))
end

function DragonFeathersNpc:onClickActivation(actor)
    local equip = linkbodyitem(actor, 21)
    if "0" ~= equip then
        return
    end
    local cfg = self.cfg[1]
    for k, v in pairs(cfg.nedd_map) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."²»×ã" , 1)
        end
    end
    for k, v in pairs(cfg.nedd_map) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v) then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."ÉñÁúÖ®Óð¿Û³ý") then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        end
    end
    local source = {
        map = "ÎÔÁúÉ½×¯",
        source = 2,
        player = getbaseinfo(actor, 1),
        time = os.time()
    }
    giveonitem(actor, 21, "ÉñÁúÖ®Óð")
    equip = linkbodyitem(actor, 21)
    setthrowitemly2(actor, equip, tbl2json(source))
    local str_tab = self:getAttrList(actor)
    lualib:FlushNpcUi(actor, "DragonFeathersOBJ", tbl2json(str_tab))
end

function DragonFeathersNpc:onClickHuanYu(actor, index)
    index = tonumber(index)
    local equip = linkbodyitem(actor, 21)
    if "0" == equip then
        return Sendmsg9(actor,  "ffffff", "ÇëÏÈ¼¤»îÉñÁúÖ®Óð!" , 1)
    end
    local cfg = self.cfg[index + 1]
    for k, v in pairs(cfg.nedd_map) do
        local item_id = getstditeminfo(k, 0)
        local num = getbagitemcount(actor, k, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, k)
        end
        if num < v then
            return Sendmsg9(actor,  "ffffff", k.."²»×ã" , 1)
        end
    end
    for k, v in pairs(cfg.nedd_map) do
        local item_id = getstditeminfo(k, 0)
        if item_id <= 100 then
            if not consumebindmoney(actor, k, v) then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        else
            if not takeitem(actor, k, v, 0, k.."ÉñÁúÖ®Óð¿Û³ý") then
                return Sendmsg9(actor,  "ffffff", k.."¿Û³ýÊ§°Ü" , 1)
            end
        end
    end
    local weight_cfg = getWeightedCfg(cfg.weight1)
    local value = weightedRandom(weight_cfg).value
    if index < 3 then
        value = value * 100
    end
    local attr_id = cfg.attrid
    setaddnewabil(actor, 21, "=", "3#"..attr_id.."#"..value)

    local tips_tab = {"½ð","Ä¾","Ë®","»ð","ÍÁ"}
    local str = "ÕÙ»½"..tips_tab[index].."ÔªËØ³É¹¦!"
    local str_tab = self:getAttrList(actor)
    lualib:FlushNpcUi(actor, "DragonFeathersOBJ", tbl2json(str_tab))
    Sendmsg9(actor,  "ffffff", str , 1)
end

function DragonFeathersNpc:getAttrList(actor)
    local tmp_list = {}
    for k, v in ipairs(self.attr_ids) do
        local attr_str = getitemattidvalue(actor, 2, v, 21)
        tmp_list[k] = attr_str
    end
    for i = 1, 5 do
        if nil == tmp_list[i] then
            tmp_list[i] = 0
        end
    end
    return tmp_list
end

return DragonFeathersNpc