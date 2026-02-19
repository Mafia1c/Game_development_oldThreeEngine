local treasureAwake = {}
treasureAwake.cfg = include("QuestDiary/config/treasureAwakeCfg.lua")

function treasureAwake:click(actor)
    local obj = linkbodyitem(actor,14)
    local equipName = getiteminfo(actor,obj,7)
    local makeIndex = getiteminfo(actor,obj,1)
    if not self.cfg[equipName] then
        return Sendmsg9(actor, "ff0000", "只有佩戴绝品或孤品秘宝可进行觉醒！", 1)
    end
    local star = getitemaddvalue(actor,obj,2,3)
    lualib:ShowNpcUi(actor, "treasureAwakeOBJ",star)
end

function treasureAwake:logSetBind(actor) --#region 登陆判断觉醒后设置绑定(新加)
    if (getitemintparam(actor,14,1) and getitemintparam(actor,14,1)>0) 
    or (getitemattidvalue(actor,2,4,14) and getitemattidvalue(actor,2,4,14)>0) then
        setitemaddvalue(actor,linkbodyitem(actor,14),2,1,0)
    end
end
function treasureAwake:upEvent(actor,...)
    local time = getitemintparam(actor,14,1)
    local equipObj = linkbodyitem(actor,14)
    local star = getitemaddvalue(actor,equipObj,2,3)
    if star==0 and (time==nil or time<5) and getitemattidvalue(actor,2,4,14) ~=25 then
        return Sendmsg9(actor,"ff0000","当前秘宝继承属性小于5条！",1)
    elseif star == #self.cfg then
        return Sendmsg9(actor,"ff0000","当前秘宝已觉醒至最高等级！",1)
    end

    local infoTab = self.cfg[star+1]
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if v > getbagitemcount(actor,k) then
            lualib:FlushNpcUi(actor,"treasureAwakeOBJ","不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."材料不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
        if v > querymoney(actor, getstditeminfo(k,0)) then
            lualib:FlushNpcUi(actor,"treasureAwakeOBJ","不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
        if v > getbindmoney(actor, k) then
            lualib:FlushNpcUi(actor,"treasureAwakeOBJ","不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if not takeitem(actor,k,v,0) then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
        if not changemoney(actor,getstditeminfo(k,0),"-",v,"神龙秘宝觉醒非通用货币扣除",true) then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
        if not consumebindmoney(actor,k,v,"神龙秘宝觉醒通用货币扣除") then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    local gs_odds = 0
    if type(list) == "table" and list[account_id] then
        gs_odds = list[account_id]["mibaoawake_odds"] or 0
    end

    local odds = self.cfg[star+1]["odd"] + gs_odds
    
    if math.random(100) > odds then
        if star > 0 then
           setitemaddvalue(actor,equipObj,2,3,star-1)
        end
        Sendmsg9(actor, "ff0000", "当前秘宝觉醒失败！", 1)
        lualib:FlushNpcUi(actor,"treasureAwakeOBJ","失败#"..(star-1))
    else
        setitemaddvalue(actor,equipObj,2,3,star+1)
        sendmsgnew(actor,255,255,"神龙秘宝觉醒ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功觉醒秘宝至"
        .."<『".. star+1 .."阶』/FCOLOR=251>,获得属性提升！",1,8)
        lualib:FlushNpcUi(actor,"treasureAwakeOBJ","提升#"..(star+1))
    end
    self:addInfo(actor)
end

function treasureAwake:addInfo(actor)
    local equipObj = linkbodyitem(actor,14)
    local star = getitemaddvalue(actor,equipObj,2,3)
    local attr_str = getitemcustomabil(actor, equipObj)
    local attr_tab = json2tbl(attr_str)
    if "" == attr_tab or nil == attr_tab then
        attr_tab = {
            ["abil"] = {}
        }
    end
    local tmp_tab = {}
    for index, value in ipairs({{4,2}, {6,2}, {8,2}, {36,200}, {37,200}}) do
        local ratio = 0
        if index > 3  then
            ratio = 1
        end
        tmp_tab[#tmp_tab + 1] = {255, value[1], value[2]*star, ratio, 0, #tmp_tab + 1, #tmp_tab}
    end
    if star >=9 then
        tmp_tab[#tmp_tab + 1] = {245, 89, 500, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 35, 500, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 36, 500, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 37, 500, 1, 0, #tmp_tab + 1, #tmp_tab}
    elseif star >= 6 then
        tmp_tab[#tmp_tab + 1] = {245, 89, 500, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 35, 500, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 36, 0, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 37, 0, 1, 0, #tmp_tab + 1, #tmp_tab}
    elseif star >= 3 then
        tmp_tab[#tmp_tab + 1] = {245, 89, 500, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 35, 0, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 36, 0, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 37, 0, 1, 0, #tmp_tab + 1, #tmp_tab}
    else
        tmp_tab[#tmp_tab + 1] = {245, 89, 0, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 35, 0, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 36, 0, 1, 0, #tmp_tab + 1, #tmp_tab}
        tmp_tab[#tmp_tab + 1] = {245, 37, 0, 1, 0, #tmp_tab + 1, #tmp_tab}
    end
    if star == 12 then
        VarApi.setPlayerUIntVar(actor, "UL_treasureAwake12", 1, false)
    end

    local tbl = {
        ["i"] = 2,
        ["t"] = "[觉醒属性]: ",
        ["c"] = 251,
        ["v"] = tmp_tab,
    }
    attr_tab.abil[4] = tbl
    setitemcustomabil(actor, equipObj, tbl2json(attr_tab))
end

return treasureAwake