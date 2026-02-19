-- 引擎玩家变量
VarApi = {}
-- 数字型个人变量
-- U    可保存.255个(U0 - U254)（存放在SQL角色数据库）最大值21亿
VarApi.playerUIntVarData = {}

-- 字符型个人变量
-- T    可保存.255个(T0 - T254)（存放在SQL角色数据库）最大长度8000字符串以内      
VarApi.playerTStrVarData = {}

-- 数字型个人变量,每晚自动12点重置
-- J	可保存.每晚自动12点重置,合区或关停服务器请错开00:00点.500个(J0 - J499)（存放在SQL角色数据库）
VarApi.playerJIntVarData = {}

-- 字符型个人变量,每晚自动12点重置
-- Z	可保存.每晚自动12点重置,合区或关停服务器请错开00:00点.500个(Z0 - Z499)（存放在SQL角色数据库）
VarApi.playerZStrVarData = {}

function VarApi.Init(actor)
    lualib:CallFuncByClient(actor, "HeFuCount", getsysvar(VarEngine.HeFuCount))
    lualib:CallFuncByClient(actor, "OpenDay", getsysvar(VarEngine.OpenDay))
    VarApi.playerUIntVarData[actor] = VarApi.playerUIntVarData[actor] or {}
    VarApi.playerTStrVarData[actor] = VarApi.playerTStrVarData[actor] or {}
    VarApi.playerJIntVarData[actor] = VarApi.playerJIntVarData[actor] or {}
    VarApi.playerZStrVarData[actor] = VarApi.playerZStrVarData[actor] or {}

    local u_str_json = getplaydef(actor, "T0")                        -- 获取玩家 U丶T丶J丶Z 变量所有的Key
    local u_table = json2tbl(u_str_json)
    if u_table and type(u_table) == "table" then
        for k, v in pairs(u_table) do
            iniplayvar(actor, "integer", "HUMAN", v)                  -- 初始化
            local value = getplayvar(actor, "HUMAN", v)
            VarApi.playerUIntVarData[actor][v] = value
            lualib:SendDataClient(actor, v.."#"..value)
            setplayvar(actor,"HUMAN", v, value, 1)
        end
    end

    local t_str_json = getplaydef(actor, "T1")                        -- 获取玩家 U丶T丶J丶Z 变量所有的Key
    local t_table = json2tbl(t_str_json)
    if t_table and type(t_table) == "table" then
        for k, v in pairs(t_table) do
            iniplayvar(actor, "string", "HUMAN", v)                  -- 初始化
            local value = getplayvar(actor, "HUMAN", v)
            VarApi.playerTStrVarData[actor][v] = value
            lualib:SendDataClient(actor, v.."#"..value)
            setplayvar(actor,"HUMAN", v, value, 1)
        end
    end

    local j_str_json = getplaydef(actor, "T2")                        -- 获取玩家 U丶T丶J丶Z 变量所有的Key
    local j_table = json2tbl(j_str_json)
    if j_table and type(j_table) == "table" then
        for k, v in pairs(j_table) do
            iniplayvar(actor, "integer", "HUMAN", v)                  -- 初始化
            local value = getplayvar(actor, "HUMAN", v)
            VarApi.playerJIntVarData[actor][v] = value
            lualib:SendDataClient(actor, v.."#"..value)
            setplayvar(actor,"HUMAN", v, value, 1)
        end
    end
    
    local z_str_json = getplaydef(actor, "T3")                        -- 获取玩家 U丶T丶J丶Z 变量所有的Key
    local z_table = json2tbl(z_str_json)
    if z_table and type(z_table) == "table" then
        for k, v in pairs(z_table) do
            iniplayvar(actor, "string", "HUMAN", v)                  -- 初始化
            local value = getplayvar(actor, "HUMAN", v)
            VarApi.playerZStrVarData[actor][v] = value
            lualib:SendDataClient(actor, v.."#"..value)
            setplayvar(actor,"HUMAN", v, value, 1)
        end
    end    
end

--- 设置玩家数字型个人变量  U
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
--- @param value  integer   对应的值
--- @sendClient  boolean  是否同步客户端缓存    true.同步
function VarApi.setPlayerUIntVar(actor, key, value, sendClient)
    VarApi.playerUIntVarData[actor] = VarApi.playerUIntVarData[actor] or {}
    key = tostring(key)
    local u_var_tab = {}
    local u_str = getplaydef(actor, "T0")
    if u_str == "" then
    else
        u_var_tab = json2tbl(u_str)
    end
    if not isInTable(u_var_tab, key) then
        iniplayvar(actor, "integer", "HUMAN", key)
        table.insert(u_var_tab, key)
        setplaydef(actor, "T0", tbl2json(u_var_tab))
    end
    setplayvar(actor,"HUMAN", key, value, 1)
     -- 发送到客户端  
    if sendClient then                                   
        lualib:SendDataClient(actor, key.."#"..value)
    end
    VarApi.playerUIntVarData[actor][key] = value
end

--- 获取玩家数字型个人变量  U
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
function VarApi.getPlayerUIntVar(actor, key)
    key = tostring(key)
    local v = VarApi.playerUIntVarData[actor]
    if v then
        return tonumber(v[key]) or 0
    end
    return 0
end


--- 设置玩家字符型个人变量      T
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
--- @param value  string   对应的值
--- @sendClient  boolean  是否同步客户端缓存  true.同步
function VarApi.setPlayerTStrVar(actor, key, value, sendClient)
    VarApi.playerTStrVarData[actor] = VarApi.playerTStrVarData[actor] or {}
    key = tostring(key)
    local t_var_tab  = {}
    local t_str = getplaydef(actor, "T1")
    if "" == t_str then
    else
        t_var_tab = json2tbl(t_str)
    end
    if not isInTable(t_var_tab, key) then
        iniplayvar(actor, "string", "HUMAN", key)
        table.insert(t_var_tab, key)
        setplaydef(actor, "T1", tbl2json(t_var_tab))
    end
    setplayvar(actor,"HUMAN", key, value, 1)
    if sendClient then
        lualib:SendDataClient(actor, key.."#"..value)
    end
    VarApi.playerTStrVarData[actor][key] = value
end

--- 获取玩家字符型个人变量      T
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
function VarApi.getPlayerTStrVar(actor, key)
    key = tostring(key)
    local v = VarApi.playerTStrVarData[actor]
    if v then
        return v[key] or ""
    end
    return ""
end

--- 设置玩家数字型个人变量  J   每晚自动12点重置
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
--- @param value  integer   对应的值
--- @sendClient  boolean  是否同步客户端缓存    true.同步
function VarApi.setPlayerJIntVar(actor, key, value, sendClient)
    VarApi.playerJIntVarData[actor] = VarApi.playerJIntVarData[actor] or {}
    local j_var_tab = {}
    local j_str = getplaydef(actor, "T2")
    if "" == j_str then
    else
        j_var_tab = json2tbl(j_str)
    end
    if not isInTable(j_var_tab, key) then
        iniplayvar(actor, "integer", "HUMAN", key)
        table.insert(j_var_tab, key)
        setplaydef(actor, "T2", tbl2json(j_var_tab))
    end
    setplayvar(actor,"HUMAN", key, value, 1)
    if sendClient then
        lualib:SendDataClient(actor, key.."#"..value)
    end
    VarApi.playerJIntVarData[actor][key] = value
end

--- 获取玩家数字型个人变量  J   每晚自动12点重置
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
function VarApi.getPlayerJIntVar(actor, key)
    local v = VarApi.playerJIntVarData[actor]
    if v then
        return tonumber(v[key]) or 0
    end
    return 0
end


--- 设置玩家字符型个人变量      Z   每晚自动12点重置
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
--- @param value  string   对应的值
--- @sendClient  boolean  是否同步客户端缓存  true.同步
function VarApi.setPlayerZStrVar(actor, key, value, sendClient)
    VarApi.playerZStrVarData[actor] = VarApi.playerZStrVarData[actor] or {}
    local z_var_tab = {}
    local z_str = getplaydef(actor, "T3")
    if "" == z_str then
    else
        z_var_tab = json2tbl(z_str)
    end
    if not isInTable(z_var_tab, key) then
        iniplayvar(actor, "string", "HUMAN", key)
        table.insert(z_var_tab, key)
        setplaydef(actor, "T3", tbl2json(z_var_tab))
    end
    setplayvar(actor,"HUMAN", key, value, 1)
    if sendClient then
        lualib:SendDataClient(actor, key.."#"..value)
    end
    VarApi.playerZStrVarData[actor][key] = value
end

--- 获取玩家字符型个人变量      Z   每晚自动12点重置
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
function VarApi.getPlayerZStrVar(actor, key)
    key = tostring(key)
    local v = VarApi.playerZStrVarData[actor]
    if v then
        return v[key] or ""
    end
    return ""
end


function VarApi.GetTableLength(tab)
    local count = 0
    if type(tab) ~= "table" then
        return count
    end
    for k, v in pairs(tab) do
        if v then
            count = count + 1
        end
    end
    return count
end

function VarApi.GetTableIndex(tab, key)
    local count = -1
    if type(tab) ~= "table" then
        return count
    end
    for k, v in pairs(tab) do
        if v == key then
            count = k
            break
        end
    end
    return count
end

-- 跨天触发 清一下缓存
function VarApi.resetDayVar()
    for index, value in ipairs(VarClearKeyList_J) do
        clearhumcustvar("*", value)
    end
    for index, value in ipairs(VarClearKeyList_Z) do
        clearhumcustvar("*", value)
    end

    local player_list = getplayerlst(0)
    for i, player in ipairs(player_list or {}) do
        for _, var in pairs(VarClearKeyList_J) do
            lualib:SendDataClient(player, var.."#0")
        end
        for _, var in pairs(VarClearKeyList_Z) do
            lualib:SendDataClient(player, var.."#")
        end
    end

    VarApi.playerJIntVarData = {}
    VarApi.playerZStrVarData = {}
end

