GameData = {}
GameData.global_data = {}                   -- 全局数据  用来保存服务器100协议下发的数据

-- init
function GameData.init()
    GameData.global_data = {}
end

--- @param data string      "U1#100"
function GameData.SetData(data)
    local tab = SL:Split(data, "#")
    GameData.global_data[tab[1]] = tonumber(tab[2]) or tab[2]
end

---@param key string
---@param return_table boolean 是否返回table格式
function GameData.GetData(key, return_table)
    local ret = GameData.global_data[key]
    if return_table then
        ret = SL:JsonDecode(ret, false)
    end
    return ret
end

-- clear
function GameData.ClearData()
    GameData.global_data = {}
end