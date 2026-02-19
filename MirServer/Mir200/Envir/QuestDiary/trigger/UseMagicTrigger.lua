UseMagicTrigger = {}

--#region 自身使用任意技能前触发(玩家触发)(玩家对象，技能id，技能名字，受击对象，受击对象x坐标，受击对象y坐标，返回值(true/false，允许/组织施法))
function UseMagicTrigger.onBeginmagic(actor, maigicID,maigicName,targetObject,positionX,positionY)
    local timestamp = VarApi.getPlayerUIntVar(actor,"U_50053_buff_cd_timestamp") 
    local rand_number = math.random(100) --#region 随机数
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
    if isInTable(buff_list, 50053) and os.time() - timestamp > 120 and rand_number <= 1 then
        VarApi.setPlayerUIntVar(actor,"U_50053_buff_cd_timestamp",os.time()) 
        addbuff(actor,60011,10)
        sendattackeff(actor,149)
        local str = string.format('{"Msg":"魔宗BUFF攻击附加固定伤害值：%s","FColor":0,"BColor":255,"Type":1,"Time":1}',getbaseinfo(actor,22))
        sendmsg(actor, 1, str)

    end

    return true
end