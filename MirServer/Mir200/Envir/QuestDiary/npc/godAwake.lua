local godAwake = {}
godAwake.cfg = include("QuestDiary/config/godAwakeCfg.lua")

function godAwake:click(actor)
    VarApi.setPlayerUIntVar(actor,"UL_godAwakeLuck",0,true)
    lualib:ShowNpcUi(actor, "godAwakeOBJ", "")
end

function godAwake:luckEvent(actor) --#region 幸运符
    local temp = VarApi.getPlayerUIntVar(actor,"UL_godAwakeLuck")
    if temp == 0 and 1 > getbagitemcount(actor, "幸运符") then
        Sendmsg9(actor, "ff0000", "当前背包中幸运符材料不足！", 1)
        openhyperlink(actor,11,0)
    elseif temp == 0 then
        Sendmsg9(actor, "00FF00", "成功勾选幸运符！", 1)
        VarApi.setPlayerUIntVar(actor,"UL_godAwakeLuck",1,true)
        lualib:FlushNpcUi(actor, "godAwakeOBJ", "幸运符")
    else
        Sendmsg9(actor, "00FF00", "取消勾选幸运符！", 1)
        VarApi.setPlayerUIntVar(actor,"UL_godAwakeLuck",0,true)
        lualib:FlushNpcUi(actor, "godAwakeOBJ", "幸运符")
    end
end

function godAwake:upEvent(actor,...)
    local param = {...}
    local leftIndex = tonumber(param[1])
    if not self.cfg[leftIndex] then
        return Sendmsg9(actor,"ff0000","当前选取神器数据异常！",1)
    end
    local position = self.cfg[leftIndex]["position"]
    local star = VarApi.getPlayerUIntVar(actor,"UL_godAwake"..position)
    local equipObj = linkbodyitem(actor,position)
    local equipName = getiteminfo(actor,equipObj,7)
    if self.cfg[leftIndex]["name"] ~= equipName then
        return Sendmsg9(actor,"ff0000","请先穿戴解封后的神器再来强化！",1)
    elseif star == 15 then
        return Sendmsg9(actor,"ff0000","当前神器已强化至最高等级！",1)
    end

    local infoTab = self.cfg[self.cfg[leftIndex]["level_arr"][star+1]]
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do --#region 非通用货币
        if v > querymoney(actor, getstditeminfo(k,0)) then
            lualib:FlushNpcUi(actor,"godAwakeOBJ","不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do --#region 通用货币
        if v > getbindmoney(actor, k) then
            lualib:FlushNpcUi(actor,"godAwakeOBJ","不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if v > getbagitemcount(actor,k) then
            lualib:FlushNpcUi(actor,"godAwakeOBJ","不足#"..k)
            return Sendmsg9(actor, "ff0000", "当前"..k.."材料不足！", 1)
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
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if not takeitem(actor,k,v,0) then
            return Sendmsg9(actor, "ff0000", k.."扣除失败！", 1)
        end
    end

    local luck = infoTab["odd"]
    if VarApi.getPlayerUIntVar(actor,"UL_godAwakeLuck") == 1 then
        if not takeitem(actor,"幸运符",1,0) then
            return Sendmsg9(actor, "ff0000", "幸运符扣除失败！", 1)
        end
        luck = luck +10
    end
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    local gs_odds = 0
    if type(list) == "table" and list[account_id] then
        gs_odds = list[account_id]["zsqh_bodds"] or 0
    end
    if math.random(100) > (luck+gs_odds) then
        if star - 1 <= 0 and VarApi.getPlayerUIntVar(actor,"UL_godAwakeLuck") == 0 then
            VarApi.setPlayerUIntVar(actor,"UL_godAwake"..position,0,true)
            setitemaddvalue(actor,equipObj,2,3,0)
            local attrstr = self:getattrstr(actor,leftIndex,1)
            setaddnewabil(actor,position,"-",attrstr)
        elseif VarApi.getPlayerUIntVar(actor,"UL_godAwakeLuck") == 0 then
            VarApi.setPlayerUIntVar(actor, "UL_godAwake" .. position, star - 1, true)
            setitemaddvalue(actor, equipObj, 2, 3, star - 1)
            local attrstr = self:getattrstr(actor,leftIndex,star-1)
            setaddnewabil(actor, position, "=", attrstr)
        end
        Sendmsg9(actor, "ff0000", "当前神器强化失败！", 1)
        lualib:FlushNpcUi(actor,"godAwakeOBJ","失败")
    else
        setitemaddvalue(actor,equipObj,2,3,star+1)
        VarApi.setPlayerUIntVar(actor,"UL_godAwake"..position,star+1,true)
        local attrstr = self:getattrstr(actor,leftIndex,star+1)
        setaddnewabil(actor, position, "=", attrstr)
        sendmsgnew(actor, 255, 255, "神器觉醒强化ぐ：恭喜<『" .. getbaseinfo(actor, 1) .. "』/FCOLOR=249>成功强化神器至"
        .."<『".. star+1 .."星』/FCOLOR=251>,获得属性提升！",1,8)
        lualib:FlushNpcUi(actor,"godAwakeOBJ","强化")
    end
    if 1 > getbagitemcount(actor, "幸运符") then
        VarApi.setPlayerUIntVar(actor,"UL_godAwakeLuck",0,true)
    end
    self:suitInfo(actor)
end

function godAwake:getattrstr(actor,leftIndex,star)
    local infoTab = self.cfg[self.cfg[leftIndex]["level_arr"][star]]
    local attrstr = ""
    for i = 1, 8 do
        if i == 1 then
            attrstr = infoTab["attrstr" .. i]
        elseif infoTab["attrstr" .. i] then
            attrstr = attrstr .. "|" .. infoTab["attrstr" .. i]
        end
    end
    return attrstr
end

function godAwake:suitInfo(actor) --#region 套装属性
    local allstar = 0
    for index, value in ipairs(self.cfg) do
        allstar = allstar + VarApi.getPlayerUIntVar(actor,"UL_godAwake"..value["position"])
    end
    local nowLv = getbaseinfo(actor,6)
    local lastLv = VarApi.getPlayerUIntVar(actor,"UL_godAwakeLastLv") --#region 上次加的等级
    local function addsuit(level,tab)
        delbuff(actor,20007)
        addbuff(actor,20007,0,1,actor,tab)
        VarApi.setPlayerUIntVar(actor,"UL_godAwakeLastLv",level,false)
        changelevel(actor,"=",nowLv-lastLv+level)
    end
    if allstar >= 50 and allstar < 60 and lastLv ~= 1 then
        addsuit(1,{[30]=10,[78]=100})
    elseif allstar >= 60 and allstar < 70 and lastLv ~= 2 then
        addsuit(2,{[30]=15,[78]=150})
    elseif allstar >= 70 and allstar < 80 and lastLv ~= 3 then
        addsuit(3,{[30]=20,[78]=200})
    elseif allstar >= 80 and allstar < 90 and lastLv ~= 4 then
        addsuit(4,{[30]=25,[78]=250})
    elseif allstar >= 90 and allstar < 100 and lastLv ~= 5 then
        addsuit(5,{[30]=30,[78]=300})
    elseif allstar >= 100 and allstar < 110 and lastLv ~= 6 then
        addsuit(6,{[30]=35,[78]=350})
    elseif allstar >= 110 and allstar < 120 and lastLv ~= 7 then
        addsuit(7,{[30]=40,[78]=400})
    elseif allstar >= 120 and lastLv ~= 8 then
        addsuit(8,{[30]=50,[78]=500})
    elseif VarApi.getPlayerUIntVar(actor,"UL_godAwakeLastLv")==1 and allstar < 50 then
        delbuff(actor,20007)
        VarApi.setPlayerUIntVar(actor,"UL_godAwakeLastLv",0,false)
        changelevel(actor,"-",1)
    end
end

function godAwake:buyEvent1(actor) --#region 强化增益包买一次
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_qhlb",1,"godAwakeOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end
function godAwake:buyEvent10(actor) --#region 强化增益包买10次
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_qhlb",10,"godAwakeOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end
function godAwake:buyEvent100(actor) --#region 强化增益包买100次
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_qhlb",100,"godAwakeOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

return godAwake