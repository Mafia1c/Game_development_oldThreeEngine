lualibgm = lualibgm or {}

function lualibgm:playerIsGm(actor)
    local gmLv = getgmlevel(actor)
    if gmLv < 10 then
        sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>GM权限不足</font>","Type":9}')
    end
    local account_id = getconst(actor, "<$USERACCOUNT>")
    if not isInTable(VarGmWhitePlayer, account_id) then
        sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>不是管理员！</font>","Type":9}')
    end
    return gmLv >= 10 and isInTable(VarGmWhitePlayer, account_id)
end

function lualibgm:sendmsg(actor,str)
    sendmsg(actor, 1,string.format('{"Msg":"<font color=\'#D2B48C\'>[GM]%s</font>","Type":9}',str))
    sendmsg(actor, 1,string.format('{"Msg":"<font color=\'#D2B48C\'>[GM]%s</font>","Type":1}',str))
end

function lualibgm:getplayerbyname(actor,name)
    local player = getplayerbyname(name)
    if not player or player == "" or player == "0" or not isnotnull(player) then
        player = false
        lualibgm:sendmsg(actor,"玩家不存在")
    end
    return player
end

-- ==================================================================================
-- ==================================================================================
-- =====================================//系统//=====================================
-- ==================================================================================
-- ==================================================================================

--获取系统变量 gm_getsysvar
---@param param1 string 变量名
function usercmd1(actor,param1)
    if not lualibgm:playerIsGm(actor) then return end
    messagebox(actor, getsysvar(param1), "", "")
    lualibgm:sendmsg(actor,string.format("获取 %s变量 : %s",param1,getsysvar(param1)))
end

--设置系统变量 gm_setsysvar
---@param param1 string 变量名
---@param param2 string|number 变量值
---@param param3 string 变量值类型
function usercmd2(actor,param1,param2,param3)
    if not lualibgm:playerIsGm(actor) then return end
    local var = getsysvar(param1)
    param2 = tonumber(param2) or param2
    if param3 == "integer" then
        param2 = tonumber(param2) or 0
        setsysvar(param1,param2)
    elseif param3 == "string" then
        setsysvar(param1,param2)
        if param2 == '""' then
            setsysvar(param1,"")
        end
    elseif param3 == "table" then
        if param2 == '""' then
            setsysvar(param1,"")
        else
            local result = param2:gsub("#", ":"):gsub("|", ",")
            setsysvar(param1,result)
        end
    end
    lualibgm:sendmsg(actor,string.format("修改 %s变量 : %s → %s",param1,param2,var,getsysvar(param1)))
    if param1 == "G493" or param1 == "g493" then
        HeFuTrigger.CleanSysVar()
    elseif param1 == "G498" then
        if tonumber(param2) and tonumber(param2) >= 99 then
            ActivityMgr:SetSpecialActiveState("狂暴争霸1",true)
        else
            ActivityMgr:SetSpecialActiveState("狂暴争霸1",false)
        end
    end
end

--声明系统自定义变量 gm_inisysvarex
---@param param1 string 变量名
---@param param2 string 变量值类型
function usercmd3(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    inisysvar(param2,param1,0)
    lualibgm:sendmsg(actor,string.format("声明系统自定义变量,%s - %s",param1,param2))
end

--获取系统自定义变量 gm_getsysvarex
---@param param1 string 变量名
function usercmd4(actor,param1)
    if not lualibgm:playerIsGm(actor) then return end
    lualibgm:sendmsg(actor,param1..":"..getsysvarex(param1))
end

--设置系统自定义变量 gm_setsysvarex
---@param param1 string 变量名
---@param param2 string|number 变量值
---@param param3 string 变量值类型
---@param param4 number 是否保存数据库
function usercmd5(actor,param1,param2,param3,param4)
    if not lualibgm:playerIsGm(actor) then return end
    if param3 == "integer" then
        param2 = tonumber(param2) or 0
    end
    param4 = tonumber(param4) or 0
    local var = getsysvarex(param1)
    setsysvarex(param1,param2,param4)
    lualibgm:sendmsg(actor,string.format("修改 %s变量 : %s → %s",param1,param2,var,getsysvarex(param1)))
end

--设置系统自定义变量 gm_setsysvarex
---@param param1 string 变量名
---@param param2 string|number 变量值
---@param param3 string 变量值类型
---@param param4 number 是否保存数据库
function usercmd5(actor,param1,param2,param3,param4)
    if not lualibgm:playerIsGm(actor) then return end
    if param3 == "integer" then
        param2 = tonumber(param2) or 0
    end
    param4 = tonumber(param4) or 0
    local var = getsysvarex(param1)
    setsysvarex(param1,param2,param4)
    if param3 == "string" and param2 == '""' then
        setsysvarex(param1,"",param4)
    end
    lualibgm:sendmsg(actor,string.format("修改 %s变量 : %s → %s",param1,param2,var,getsysvarex(param1)))
end

--请求一条来自服务端的消息 gm_sendluamsg
---@param param1 number 消息号
---@param param2 number 参数1
---@param param3 number 参数2
---@param param4 number 参数3
---@param param5 string 参数3
function usercmd6(actor,param1,param2,param3,param4,param5)
    if not lualibgm:playerIsGm(actor) then return end
    param1 = tonumber(param1) or 0
    param2 = tonumber(param2) or 0
    param3 = tonumber(param3) or 0
    param4 = tonumber(param4) or 0
    sendluamsg(actor,param1,param2,param3,param3,param5)
    lualibgm:sendmsg(actor,string.format("给客户端发送%s号消息",param1))
end

-- ==================================================================================
-- ==================================================================================
-- =====================================//玩家//=====================================
-- ==================================================================================
-- ==================================================================================

--获取玩家变量 gm_getplayvar
---@param param1 string 玩家名
---@param param2 string 变量名
---@param param3 string 变量值类型
function usercmd1011(actor,param1,param2,param3)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        if param3 == "integer" then
            local temp = VarApi.getPlayerUIntVar(player, param2)
            lualibgm:sendmsg(actor,string.format("%s 获取 %s变量int : %s",param1,param2,temp))
        else
            local temp = VarApi.getPlayerTStrVar(player, param2)
            messagebox(actor, temp, "", "")
            lualibgm:sendmsg(actor,string.format("%s 获取 %s变量str : %s",param1,param2,temp))
            lualibgm:sendmsg(actor,temp)
        end
    end
end

--设置玩家变量 gm_setplayvar
---@param param1 string 玩家名
---@param param2 string 变量名
---@param param3 string|number 变量值
---@param param4 string 变量值类型
function usercmd1012(actor,param1,param2,param3,param4)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        if param4 == "integer" then
            param3 = tonumber(param3) or 0
            local var = VarApi.getPlayerUIntVar(player, param2)
            VarApi.setPlayerUIntVar(player, param2, param3, true)
            lualibgm:sendmsg(actor,string.format("%s 修改 %s变量int : %s → %s",param1,param2,var,VarApi.getPlayerUIntVar(player, param2)))
        elseif param4=="string" then
            local var = VarApi.getPlayerTStrVar(player, param2)
            VarApi.setPlayerTStrVar(player, param2, param3, true)
            if param3=='""' then
                VarApi.setPlayerTStrVar(player, param2, "", true)
            end
            lualibgm:sendmsg(actor,string.format("%s 修改 %s变量str : %s → %s",param1,param2,var,VarApi.getPlayerTStrVar(player, param2)))
        elseif param4=="table" then
            local var = VarApi.getPlayerTStrVar(player, param2)
            if param3=='""' then
                if param2 == VarStrDef.XMTF then --#region 特殊删天赋属性
                    local cfg = include("QuestDiary/config/talentCfg.lua")
                    for k, v in pairs(cfg) do
                        if hasbuff(player, v.buff_id) then
                            delbuff(player, v.buff_id)
                        end
                    end
                end
                VarApi.setPlayerTStrVar(player, param2, "", true)
            else
                local result = param3:gsub("#", ":"):gsub("|", ",")
                VarApi.setPlayerTStrVar(player, param2, result, true)
            end
            lualibgm:sendmsg(actor,string.format("%s 修改 %s变量str : %s → %s",param1,param2,var,VarApi.getPlayerTStrVar(player, param2)))
        end
        -- local var = getplaydef(player,param2)
        -- setplaydef(player,param2,param3)
        -- lualibgm:sendmsg(actor,string.format("%s 修改 %s变量 : %s → %s",param1,param2,var,getplaydef(player,param2)))
    end
end

--获取玩家天变量 gm_getplayvarex
---@param param1 string 玩家名
---@param param2 string 变量名
---@param param3 string 变量值类型
function usercmd1013(actor,param1,param2,param3)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        if param3 == "integer" then
            local temp = VarApi.getPlayerJIntVar(player, param2)
            lualibgm:sendmsg(actor,string.format("%s 获取 %s天变量int : %s",param1,param2,temp))
        else
            local temp = VarApi.getPlayerZStrVar(player, param2)
            messagebox(actor, temp, "", "")
            lualibgm:sendmsg(actor,string.format("%s 获取 %s天变量str : %s",param1,param2,temp))
        end
    end
end

--设置玩家天变量 gm_setplayvarex
---@param param1 string 玩家名
---@param param2 string 变量名
---@param param3 string|number 变量值
---@param param4 string 变量值类型
---@param param5 number 是否保存数据库
function usercmd1014(actor,param1,param2,param3,param4,param5)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        if param4 == "integer" then
            param3 = tonumber(param3) or 0
            local var = VarApi.getPlayerJIntVar(player, param2)
            VarApi.setPlayerJIntVar(player, param2, param3, true)
            lualibgm:sendmsg(actor,string.format("%s 修改 %s天变量int : %s → %s",param1,param2,var,VarApi.getPlayerJIntVar(player, param2)))
        elseif param4=="string" then
            local var = VarApi.getPlayerZStrVar(player, param2)
            VarApi.setPlayerZStrVar(player, param2, param3, true)
            if param3=='""' then
                VarApi.setPlayerZStrVar(player, param2, "", true)
            end
            lualibgm:sendmsg(actor,string.format("%s 修改 %s天变量str : %s → %s",param1,param2,var,VarApi.getPlayerZStrVar(player, param2)))
        elseif param4=="table" then
            local var = VarApi.getPlayerZStrVar(player, param2)
            if param3=='""' then
                VarApi.setPlayerZStrVar(player, param2, "", true)
            else
                local result = param3:gsub("#", ":"):gsub("|", ",")
                VarApi.setPlayerZStrVar(player, param2, result, true)
            end
            lualibgm:sendmsg(actor,string.format("%s 修改 %s天变量str : %s → %s",param1,param2,var,VarApi.getPlayerZStrVar(player, param2)))
        end
        -- if param4 == "integer" then
        --     param3 = tonumber(param3) or 0
        -- end
        -- param5 = tonumber(param5) or 0
        -- local var = getplayvar(player,"HUMAN",param2)
        -- iniplayvar(player, param4, "HUMAN", param2)
        -- setplayvar(player,"HUMAN",param2,param3,param5)
        -- lualibgm:sendmsg(actor,string.format("%s 修改 %s变量 : %s → %s",param1,param2,var,getplayvar(player,"HUMAN",param2)))
    end
end

-- 跳转到玩家附近 gm_jumptoplay
---@param param1 string 玩家名
function usercmd1015(actor,param1)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        local map,x,y = getbaseinfo(player,3), getbaseinfo(player,4), getbaseinfo(player,5)
        mapmove(actor,map,x,y,5)
        lualibgm:sendmsg(actor,string.format("跳转到 %s [%s,%s]",map,x,y))
    end
end

-- 拉玩家到身边 gm_bringplay
---@param param1 string 玩家名
function usercmd1016(actor,param1)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        local map,x,y = getbaseinfo(actor,3), getbaseinfo(actor,4), getbaseinfo(actor,5)
        mapmove(player,map,x,y,5)
        lualibgm:sendmsg(actor,string.format("拉人到 %s [%s,%s]",map,x,y))
    end
end

-- 发送背包道具 gm_giveitem
---@param param1 string 玩家名
---@param param2 string 物品名称
---@param param3 number 数量
---@param param4 number 规则
function usercmd1017(actor,param1,param2,param3,param4)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        param3 = tonumber(param3) or 1
        param4 = tonumber(param4) or 0
        if giveitem(player,param2,param3,param4) then
            lualibgm:sendmsg(actor,string.format("发送物品 %s → %s",param2,param1))
            RecordBackendOperationLog(actor, player, "发送物品", param2, param3)
        else
            lualibgm:sendmsg(actor,string.format("%s发送失败",param2))
        end
    end
end

-- 查找背包道具 gm_finditem
---@param param1 string 玩家名
---@param param2 string 物品名称
function usercmd1018(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        lualibgm:sendmsg(actor,string.format("%s 拥有 %s * %s",param1,param2,getbagitemcount(player,param2) or 0))
    end
end

-- 检测玩家称号 gm_checktitle
---@param param1 string 玩家名
---@param param2 string 称号名称
function usercmd1019(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        lualibgm:sendmsg(actor,string.format("%s-%s-%s称号",param1,checktitle(player,param2) and "拥有" or "没有",param2))
    end
end

-- 添加玩家称号 gm_addtitle
---@param param1 string 玩家名
---@param param2 string 称号名称
---@param param3 number 是否激活
function usercmd1020(actor,param1,param2,param3)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        param3 = tonumber(param3) or 0
        if confertitle(player, param2, param3) then
            lualibgm:sendmsg(actor,"称号添加成功")
            RecordBackendOperationLog(actor, player, "添加称号", param2, "1")
        else
            lualibgm:sendmsg(actor,"称号添加失败")
        end
    end
end

-- 删除玩家称号 gm_deltitle
---@param param1 string 玩家名
---@param param2 string 称号名称
function usercmd1021(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        if deprivetitle(player,param2) then
            lualibgm:sendmsg(actor,"称号删除成功")
            RecordBackendOperationLog(actor, player, "删除称号", param2, "1")
        else
            lualibgm:sendmsg(actor,"称号删除失败")
        end
    end
end

-- 检测玩家BUFF gm_checkbuff
---@param param1 string 玩家名
---@param param2 number buffID
function usercmd1022(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        param2 = tonumber(param2) or 0
        if param2 < 10000 then
            lualibgm:sendmsg(actor,"buffid需大于10000")
            return
        end
        lualibgm:sendmsg(actor,string.format("%s-%s-%sBUFF",param1,hasbuff(player,param2) and "拥有" or "没有",param2))
    end
end

-- 添加玩家BUFF gm_addbuff
---@param param1 string 玩家名
---@param param2 number buffID
---@param param3 number 时间
function usercmd1023(actor,param1,param2,param3)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        param2 = tonumber(param2) or 0
        param3 = tonumber(param3) or 0
        if param2 < 10000 then
            lualibgm:sendmsg(actor,"buffid需大于10000")
            return
        end
        if addbuff(player, param2, param3) then
            lualibgm:sendmsg(actor,"buff添加成功")
        else
            lualibgm:sendmsg(actor,"buff添加失败")
        end
    end
end

-- 添加玩家BUFF2 gm_addbuffex
---@param param1 string 玩家名
---@param param2 number buffID
---@param param3 number 时间
---@param param4 number 层数
---@param param5 string 释放者
---@param param6 string 额外属性[1#10|4#20]
function usercmd1024(actor,param1,param2,param3,param4,param5,param6)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        param2 = tonumber(param2) or 0
        param3 = tonumber(param3) or 0
        param4 = tonumber(param4) or 0
        local hiter = lualibgm:getplayerbyname(actor,param5) or player
        if param2 < 10000 then
            lualibgm:sendmsg(actor,"buffid需大于10000")
            return
        end
        local attr = {}
        param6 = param6:gsub("%s+", "")
        for k, v in param6:gmatch("(%d+)#(%d+)[|]?") do
            local key_num = tonumber(k)
            local value_num = tonumber(v)
            if key_num and value_num then
                attr[key_num] = value_num
            end
        end
        -- LOGPrint("attr",tbl2json(attr))
        if addbuff(player, param2, param3,param4,hiter,attr) then
            lualibgm:sendmsg(actor,"buff添加成功")
        else
            lualibgm:sendmsg(actor,"buff添加失败")
        end
    end
end

-- 删除玩家BUFF gm_delbuff
---@param param1 string 玩家名
---@param param2 number buffID
function usercmd1025(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        if delbuff(player, param2) then
            lualibgm:sendmsg(actor,"buff删除成功")
        else
            lualibgm:sendmsg(actor,"buff删除失败")
        end
    end
end

-- 设置玩家等级 gm_setrelevel
---@param param1 string 玩家名
---@param param2 number 等级
function usercmd1026(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        changelevel(player,"=",tonumber(param2))
        lualibgm:sendmsg(actor,"等级更改成功")
    end
end

-- 设置玩家转生等级 gm_setrelevel
---@param param1 string 玩家名
---@param param2 number 转生等级
function usercmd1027(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        setbaseinfo(player,39,tonumber(param2))
        lualibgm:sendmsg(actor,"转生等级更改成功")
    end
end

-- 获得玩家货币数量 gm_getcurrency
---@param param1 string 玩家名
---@param param2 string 货币名称
function usercmd1028(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        if getstditeminfo(param2, 0) == nil then
            return lualibgm:sendmsg(actor,string.format("%s 当前物品表中没有 %s ",param1,param2))
        end
        lualibgm:sendmsg(actor,string.format("%s 拥有 %s * %s",param1,param2,querymoney(player,getstditeminfo(param2, 0)) or 0))
    end
end

-- 设置玩家货币数量 gm_setcurrency
---@param param1 string 玩家名
---@param param2 string 货币名称
---@param param3 number 货币数量
function usercmd1029(actor,param1,param2,param3)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        param3 = tonumber(param3) or 1
        if getstditeminfo(param2, 0) == nil then
            return lualibgm:sendmsg(actor,string.format("%s 当前物品表中没有 %s ",param1,param2))
        end
        changemoney(player,getstditeminfo(param2,0),"=",param3,"gm刷货币",true)
        lualibgm:sendmsg(actor,string.format("货币 %s 设置 %s → %s",param2,querymoney(player,getstditeminfo(param2,0)),param3))

        RecordBackendOperationLog(actor, player, "设置货币", param2, param3)
    end
end

-- 设置gm权限 gm_setgmlevel
---@param param1 string 玩家名
---@param param2 number 权限
function usercmd1030(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        param2 = tonumber(param2) or 0
        local lastGm = getgmlevel(player)
        setgmlevel(player,param2)
        lualibgm:sendmsg(actor,string.format("玩家 %s gm权限设置为 %s → %s",param1,lastGm,param2))
    end
end

-- ==================================================================================
-- ==================================================================================
-- =====================================//地图//=====================================
-- ==================================================================================
-- ==================================================================================

-- 跳转地图 @gm_mapmove
---@param param1 string 地图号
---@param param2 number X
---@param param3 number Y
function usercmd2001(actor,param1,param2,param3)
    if not lualibgm:playerIsGm(actor) then return end
    param2 = tonumber(param2)
    param3 = tonumber(param3)
    if param2 == nil or param3 == nil then
        map(actor,param1)
        lualibgm:sendmsg(actor, "地图跳转")
        sendluamsg(actor, 996, 1, 2, 3, "asss")
    else
        mapmove(actor, param1, param2, param3)
        lualibgm:sendmsg(actor, "地图跳转")
        sendluamsg(actor, 996, 1, 2, 3, "asss")
    end

end

-- 全屏清怪(10*10) gm_killmon1
---@param param1 string 怪物名(`*`全清)
---@param param2 string 是否掉落
function usercmd2002(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    local bool = param2 == "1" and true or false
    local map,x,y = getbaseinfo(actor,3), getbaseinfo(actor,4), getbaseinfo(actor,5)
    local mons = getmapmon(map,param1,x,y,10)
    for i, mon in ipairs(mons or {}) do
        killmonbyobj(actor,mon,bool,bool,bool)
        lualibgm:sendmsg(actor,"全屏清怪")
    end
end

-- 地图清怪 gm_killmon2
---@param param1 string 怪物名(`*`全清)
---@param param2 string 是否掉落
function usercmd2003(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    local bool = param2 == "1" and true or false
    -- local map = getbaseinfo(actor,3)
    -- killmonsters(map,param1,0,bool)
    -- lualibgm:sendmsg(actor,"地图清怪")
    local map,x,y = getbaseinfo(actor,3), getbaseinfo(actor,4), getbaseinfo(actor,5)
    local mons = getmapmon(map,param1,x,y,1000)
    for i, mon in ipairs(mons or {}) do
        killmonbyobj(actor,mon,bool,bool,bool)
    end
    lualibgm:sendmsg(actor,"地图清怪")
end

-- 查询当前地图怪物 "@gm_selectmon 怪物名称"
---@param param1 string 怪物名(`*`全部查询)
function usercmd2004(actor,param1)
    if not lualibgm:playerIsGm(actor) then return end
    local map = getbaseinfo(actor,3)
    local mons = getmapmon(map,param1,0,0,999)
    for i, mon in ipairs(mons or {}) do
        lualibgm:sendmsg(actor,string.format("mon,%s - [%s,%s]",getbaseinfo(mon,1),getbaseinfo(mon,4),getbaseinfo(mon,5)))
    end
end

-- 查询当前地图玩家 "@gm_selectplay"
function usercmd2005(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local map = getbaseinfo(actor,3)
    local player_list = getplaycount(map,true,true)
    for i, player in ipairs(player_list or {}) do
        lualibgm:sendmsg(actor,string.format("player,%s - [%s,%s]",getbaseinfo(player,1),getbaseinfo(player,4),getbaseinfo(player,5)))
    end
end

-- 转移当前地图玩家 "@gm_moveplayers 目标地图号 X Y"
---@param param1 string 地图号
---@param param2 number X
---@param param3 number Y
function usercmd2006(actor,param1,param2,param3)
    if not lualibgm:playerIsGm(actor) then return end
    param2 = tonumber(param2) or 0
    param3 = tonumber(param3) or 0
    local players = getplaycount(param1,true,true)
    for _, player in ipairs(type(players) == "table" and players or {}) do
        -- if player ~= actor then
            mapmove(player,param1,param2,param3)
        -- end
    end
    lualibgm:sendmsg(actor,"地图转移玩家")
end

-- ==================================================================================
-- ==================================================================================
-- =====================================//道具//=====================================
-- ==================================================================================
-- ==================================================================================


-- function usercmd3001(actor,param1)
-- end

-- ==================================================================================
-- ==================================================================================
-- =====================================//NPC//======================================
-- ==================================================================================
-- ==================================================================================

-- 刷npc gm_createnpc
---@param param1 string 地图号
---@param param2 number X
---@param param3 number Y
---@param param4 number npcID
---@param param5 string npc名称
---@param param6 number 外形[appr]
---@param param7 string 脚本路径[script]
function usercmd4001(actor,param1,param2,param3,param4,param5,param6,param7)
    if not lualibgm:playerIsGm(actor) then return end
    param2 = tonumber(param2) or 0
    param3 = tonumber(param3) or 0
    param4 = tonumber(param4) or 0
    param6 = tonumber(param6) or 0

    local npcInfo = {}
    npcInfo.Idx = param4
    npcInfo.npcname = param5
    npcInfo.appr = param6
    npcInfo.script = param7
    createnpc(param1,param2,param3,tbl2json(npcInfo))
    lualibgm:sendmsg(actor,"创建临时npc")
end

-- ==================================================================================
-- ==================================================================================
-- =====================================//怪物//=====================================
-- ==================================================================================
-- ==================================================================================

-- 刷怪 gm_genmon
---@param param1 string 地图号
---@param param2 number X
---@param param3 number Y
---@param param4 string 怪物名称
---@param param5 number 范围
---@param param6 number 数量
---@param param7 number 颜色
function usercmd5001(actor,param1,param2,param3,param4,param5,param6,param7)
    if not lualibgm:playerIsGm(actor) then return end
    param2 = tonumber(param2) or 0
    param3 = tonumber(param3) or 0
    param5 = tonumber(param5) or 5
    param6 = tonumber(param6) or 1
    param7 = tonumber(param7) or 0
    genmon(param1,param2,param3,param4,param5,param6,param7)
    lualibgm:sendmsg(actor,string.format("成功刷怪 %s * %s",param4,param6))
end

-- ==================================================================================
-- ==================================================================================
-- =====================================//行会//=====================================
-- ==================================================================================
-- ==================================================================================

-- 加入行会 "@gm_addguild 玩家名称 行会名称"
---@param param1 string 玩家名
---@param param2 string 行会名称
function usercmd6001(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        local guild = getmyguild(actor)
        if guild == "0" then
            addguildmember(player,param2)
            lualibgm:sendmsg(actor,string.format("%s加入%s",param1,param2))
        else
            lualibgm:sendmsg(actor,string.format("玩家%s已经加入行会:",param1,getguildinfo(guild,1)))
        end
    end
end

-- 退出行会 "@gm_delguild 玩家名称"
function usercmd6002(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        local guild = getmyguild(actor)
        if guild ~= "0" then
            delguildmember(player,param2)
            lualibgm:sendmsg(actor,string.format("%s加入%s",param1,param2))
        else
            lualibgm:sendmsg(actor,string.format("玩家%s没有加入行会",param1))
        end
    end
end

-- 设置行会职务 "@gm_setguildlv 玩家名称 行会职务"
function usercmd6003(actor,param1,param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    if player then
        param2 = tonumber(param2) or 5
        local lv = getplayguildlevel(player)
        if lv ~= param2 and setplayguildlevel(player,param2) then
            lualibgm:sendmsg(actor,string.format("设置%s行会职务 %s → %s",lv,param2))
        else
            lualibgm:sendmsg(actor,string.format("%职务设置失败%s",param1,param2))
        end
    end
end

-- ==================================================================================
-- ==================================================================================
-- =====================================//沙巴克//===================================
-- ==================================================================================
-- ==================================================================================

-- 获取沙巴克基本信息 "@gm_castleinfo 信息索引"
function usercmd7001(actor,param1)
    if not lualibgm:playerIsGm(actor) then return end
    param1 = tonumber(param1) or 1
    local config = {
        [1] = "沙城名称",
        [2] = "沙城行会名称",
        [3] = "沙城行会会长名字",
        [4] = "占领天数",
        [5] = "当前是否在攻沙状态",
        [6] = "沙城行会副会长"
    }
    if not config[param1] then return lualibgm:sendmsg(actor,"未知索引") end
    local value = castleinfo(param1)
    if type(value) == "table" then
        for i, name in ipairs(t) do
            lualibgm:sendmsg(actor,string.format("%s[%s] - %s",config[param1],i,name))
        end
    else
        lualibgm:sendmsg(actor,string.format("%s - %s",config[param1],value))
    end
end

-- 发放系列装备
---@param actor string 玩家
---@param param1 string 玩家名
---@param param2 string 装备系列名称
function usercmd8001(actor,param1, param2)
    if not lualibgm:playerIsGm(actor) then return end
    local player = lualibgm:getplayerbyname(actor,param1)
    local cfg = IncludeNpcClass("RecycleNpc").cfg
    local info = nil
    for k, v in pairs(cfg) do
        if string.find(v.type, param2) then
            info = v
            break
        end
    end
    if nil == info or nil == player then
        return
    end
    for k, v in pairs(info.list_arr) do
        giveitem(player, v, 1, 127)
    end
    lualibgm:sendmsg(actor,string.format("已给%s发放全套%s装备", param1, param2))
end

function usercmd9001(actor) --#region 乐见城
    if not lualibgm:playerIsGm(actor) then return end
     local backend_ui = [[
        <Layout|x=0|y=0|width=1136|height=640|link=@exit>
        <Img|x=0|y=0|width=770|height=516|bg=1|img=public/1900000610.png|show=4|loadDelay=1|move=0|esc=1|reset=1|scale9b=10|scale9l=10|scale9r=10|scale9t=10>
        <Button|x=770|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Img|opacity=100|x=280|y=150|esc=0|img=public/lock_2.png>
        <Text|x=340|y=210|size=32|color=255|text=限制登录>
        <Img|x=325|y=260|esc=0|img=public/1900000668.png>
        <Input|x=325|y=260|width=156|height=31|type=0|isChatInput=0|color=255|inputid=9|size=16>
        <Button|submitInput=9|x=355|y=300|mimg=public/1900000662.png|nimg=public/1900000662.png|text=密码登录|color=250|link=@goto_ljc_click>
        ]]
    say(actor, backend_ui)
end
function usercmd9002(actor) --#region gs_后台
    if not lualibgm:playerIsGm(actor) then return end
    GMBoxMgr.show_gm_gs_end(actor)
end
function goto_ljc_click(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local str = getconst(actor, "<$NPCINPUT(9)>")
    if str == "zs666" then
        map(actor, "乐见城")
    else
        lualibgm:sendmsg(actor,"密码错误！")
    end
end