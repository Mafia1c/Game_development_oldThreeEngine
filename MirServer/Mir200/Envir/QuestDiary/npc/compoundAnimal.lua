local compoundAnimal = {}
compoundAnimal.cfg = include("QuestDiary/config/compoundAnimalCfg.lua")
local suffix ={"(鼠)","(牛)","(虎)","(兔)","(龍)","(蛇)","(馬)","(羊)","(猴)","(鸡)","(狗)","(猪)",}

function compoundAnimal:upEvent(actor,...)
    if getbagblank(actor) < 1 then
        return Sendmsg9(actor, "ff0000", "当前角色背包已满,请先清理后再来合成！", 1)
    end
    local param = {...}
    local leftIndex1 = tonumber(param[1]) --#region 左侧index1
    local leftIndex2 = tonumber(param[2]) --#region 左侧index2
    local sonIndex = tonumber(param[3]) --#region 第几个子对象
    local accumulate_recharge = VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    local name = self.cfg[leftIndex1]["equip_arr"][leftIndex2]
    if leftIndex1 == 1 then
        for index, value in ipairs(self.cfg[name]["need_config"]) do
            local itemName = value[1]
            if index == 1 then
                itemName = itemName .. suffix[sonIndex]
            end
            if getstditeminfo(itemName,0) < 10000 then
                if getbindmoney(actor,itemName) < value[2] then
                    lualib:FlushNpcUi(actor, "compoundAnimalOBJ", "不足#"..itemName)
                    return Sendmsg9(actor, "ff0000", "当前货币" .. itemName .. "数量少于" .. value[2] .. "！", 1)
                end
            elseif getbagitemcount(actor, itemName) < value[2] then
                lualib:FlushNpcUi(actor, "compoundAnimalOBJ", "不足#"..itemName)
                return Sendmsg9(actor, "ff0000", "当前背包" .. itemName .. "数量少于" .. value[2] .. "！", 1)
            end
        end
        for index, value in ipairs(self.cfg[name]["need_config"]) do
            local itemName = value[1]
            if index == 1 then
                itemName = itemName .. suffix[sonIndex]
            end
            if getstditeminfo(itemName,0) < 10000 then
                if not consumebindmoney(actor, itemName, value[2], "上古生肖非通用货币扣除", true) then
                    return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
                end
            else
                if not takeitem(actor, itemName, value[2], 0) then
                    return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
                end
            end
        end
        local bind = 307
        if accumulate_recharge >= 68 then
            bind = 0
        end
        if getbagblank(actor) < 5 then
            sendmail(getbaseinfo(actor, 2), 1, "上古生肖合成合成", "您的背包已满, 道具已发放至邮箱, 请及时领取!", self.cfg[name]["equip_arr"][sonIndex].."#1#"..bind)
        else
            giveitem(actor, self.cfg[name]["equip_arr"][sonIndex], 1, bind, "上古生肖合成")
        end
        Sendmsg9(actor, "FFFFFF", "合成获得：" .. self.cfg[name]["equip_arr"][sonIndex] .. "！", 1)
        return lualib:FlushNpcUi(actor, "compoundAnimalOBJ", "获得")
    else --#region 传承生肖额外属性
        for index, value in ipairs(self.cfg[name]["need_config"]) do
            local itemName = value[1]
            if index == 1 then
                itemName = itemName .. suffix[sonIndex]
            end
            if getstditeminfo(itemName,0) < 10000 then
                if getbindmoney(actor,itemName) < value[2] then
                    lualib:FlushNpcUi(actor, "compoundAnimalOBJ", "不足#"..itemName)
                    return Sendmsg9(actor, "ff0000", "当前货币" .. itemName .. "数量少于" .. value[2] .. "！", 1)
                end
            elseif getbagitemcount(actor, itemName) < value[2] then
                lualib:FlushNpcUi(actor, "compoundAnimalOBJ", "不足#"..itemName)
                return Sendmsg9(actor, "ff0000", "当前背包" .. itemName .. "数量少于" .. value[2] .. "！", 1)
            end
        end
        for index, value in ipairs(self.cfg[name]["need_config"]) do
            local itemName = value[1]
            if index == 1 then
                itemName = itemName .. suffix[sonIndex]
            end
            if getstditeminfo(itemName,0) < 10000 then
                if not consumebindmoney(actor, itemName, value[2], "上古生肖非通用货币扣除", true) then
                    return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
                end
            else
                if not takeitem(actor, itemName, value[2], 0) then
                    return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
                end
            end
        end
       
        if accumulate_recharge >= 68 then
            giveonitem(actor,29+sonIndex,self.cfg[name]["equip_arr"][sonIndex],1,0,"传承生肖合成")
        else
            giveonitem(actor,29+sonIndex,self.cfg[name]["equip_arr"][sonIndex],1,307,"传承生肖合成")
        end

        local time = VarApi.getPlayerUIntVar(actor, "l_animalTime")--#region 当前合成次数
        local job = tonumber(getbaseinfo(actor,7)) --#region 职业
        local infoTab = {"0","1","2","3","4",}
        if time < 12 then
            local star = math.random(10) --#region 随机星和属性值
            local number = math.random(5) --#region 随机属性值id
            setitemaddvalue(actor,linkbodyitem(actor,29+sonIndex),2,3,star)
            setitemaddvalue(actor, linkbodyitem(actor, 29+sonIndex), 1, infoTab[number], star)
            if star ~= 10 then     
                VarApi.setPlayerUIntVar(actor,"l_animalTime",time+1,true)
            else
                VarApi.setPlayerUIntVar(actor,"l_animalTime",0,true)
            end
        else
            VarApi.setPlayerUIntVar(actor,"l_animalTime",0,true)
            local star = 10 --#region 星和属性值
            local number = math.random(5) --#region 随机属性值id
            setitemaddvalue(actor,linkbodyitem(actor,29+sonIndex),2,3,star)
            setitemaddvalue(actor, linkbodyitem(actor, 29+sonIndex), 1, infoTab[number], star)
        end
        self:updateZodiacBuff(actor)
        Sendmsg9(actor, "FFFFFF", "合成获得：" .. self.cfg[name]["equip_arr"][sonIndex] .. "！", 1)
        -- sendmsgnew(actor,255,255,"十二生肖ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>合成"
        -- ..self.cfg[name]["equip_arr"][sonIndex].."时获得『<"..VarApi.getPlayerUIntVar(actor,"l_animalStar_"..sonIndex).."星/FCOLOR=245>』极品生肖！",1,10)
        return lualib:FlushNpcUi(actor, "compoundAnimalOBJ", "获得")
    end

end

function compoundAnimal:updateZodiacBuff(actor)
    local star_level = 0
    for key, index in pairs({30,31,32,33,34,35,36,37,38,39,40,41}) do
        local equip = linkbodyitem(actor, index)
        local value = getitemaddvalue(actor, equip, 2, 3)
        if nil == value or nil == tonumber(value) or value < 0 then
            value = 0
        end
        star_level = star_level + value
        VarApi.setPlayerUIntVar(actor,"l_animalStar_"..key, value, true)
    end
    local allStar = star_level
    if allStar >= 15 and allStar < 30 then
        delbuff(actor,20007)
        addbuff(actor,20007,0,1,actor,{[76]=100,})
    elseif allStar >= 30 and allStar < 45 then
        delbuff(actor,20007)
        addbuff(actor,20007,0,1,actor,{[76]=300,})
    elseif allStar >= 45 and allStar < 60 then
        delbuff(actor,20007)
        addbuff(actor,20007,0,1,actor,{[76]=500,})
    elseif allStar >= 60 and allStar < 90 then
        delbuff(actor,20007)
        addbuff(actor,20007,0,1,actor,{[76]=1000,})
    elseif allStar >= 90 and allStar <120 then
        delbuff(actor,20007)
        addbuff(actor,20007,0,1,actor,{[76]=1500,[89]=1000,})
    elseif allStar >= 120 then
        delbuff(actor,20007)
        addbuff(actor,20007,0,1,actor,{[76]=2000,[89]=2000,})
    else
        delbuff(actor,20007)
    end
end


return compoundAnimal