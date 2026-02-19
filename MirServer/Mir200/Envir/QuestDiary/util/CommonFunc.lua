function unpack(arr, pos)
    pos = pos or 1
    if pos >= #arr then
        return arr[pos]
    end
    return arr[pos], unpack(arr, pos + 1)
end

--序列化
function serialize(obj, player)
    local text = ""
    local t = type(obj)
    if t == "number" then
        text = text .. obj
    elseif t == "boolean" then
        text = text .. tostring(obj)
    elseif t == "string" then
        --text = text .. tostring(obj)
        --text = text .. string.format('%q', obj)
        text = text .. "'" .. obj .. "'"
    elseif t == "table" then
        text = text .. "{\n"

        for k, v in pairs(obj) do
            text = text .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
        end

        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in pairs(metatable.__index) do
                text = text .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
            end
        end

        text = text .. "}"
    elseif t == "nil" then
        return nil
    else
        error("can not serialize a " .. t .. " type.")
    end

    return text
end

--反序列化
function deserialize(text)
    local t = type(text)
    if t == "nil" or text == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        text = tostring(text)
    else
        error("can not unserialize a " .. t .. " type.")
    end

    text = "return " .. text

    local func = load(text)
    if func == nil then
        return nil
    end
    return func()
end

--字符串分割，返回表
function strsplit(str, char)
    splitRet = {}
    repeat
        local _Ret =
            string.gsub(
            str,
            "^(.-)%" .. char .. "(.-)$",
            function(a, b)
                splitRet[#splitRet + 1] = a
                str = b
            end
        )
        if str == _Ret then
            splitRet[#splitRet + 1] = _Ret
            break
        end
    until (str == "")
    return splitRet
end

function strreplace(str, index, value)
    if not str or str == "" then
        return
    end
    local len = str:len()
    local front = str:sub(1, index - 1)
    local center = str:sub(index, index)
    local last = str:sub(index + 1, len)

    front = front or ""
    last = last or ""
    return front .. value .. last
end

--表格分割，返回表
function tablesplit(tab, pos)
    local t1, t2 = {}, {}

    for i = 1, pos do
        t1[#t1 + 1] = tab[i]
    end

    for i = pos + 1, #tab do
        t2[#t2 + 1] = tab[i]
    end
    return t1, t2
end

--放回0点时间戳
function GetDayTick(iTime)
    iTime = iTime or os.time()
    local sTime = os.date("%Y-%m-%d", iTime) .. " 00:00:00"
    local _, _, y, m, d, _hour, _min, _sec = string.find(sTime, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
    local timestamp = os.time({year = y, month = m, day = d, hour = _hour, min = _min, sec = _sec})
    return timestamp
end

--返回16:00:00
function GetClock(iTime)
    iTime = iTime or os.time()
    return os.date("%X", iTime)
end

function GetDate(iTime)
    iTime = iTime or os.time()
    return os.date("%Y-%m-%d %H:%M:%S", iTime)
end

function GetYear(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    return t.year
end

function GetMonth(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    return t.month
end

function GetDay(iTime)
    iTime = iTime or os.time()

    local t = os.date("*t", iTime)
    return t.day
end

function GetHour(iTime)
    iTime = iTime or os.time()

    local t = os.date("*t", iTime)
    return t.hour
end

function GetMin(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    return t.min
end

function GetSec(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    return t.sec
end

function GetWday(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    --周日 t.wday = 1
    if t.wday == 1 then
        --周日
        return 7
    else
        return t.wday - 1
    end
end

--获取时刻字符串
function GetClockShow(iTime, showHour)
    local hour = math.floor(iTime / 3600)
    local min = math.floor(iTime / 60) - hour * 60
    local sec = iTime % 60
    if showHour then
        return string.format("%02d:%02d:%02d", hour, min, sec)
    else
        return string.format("%02d:%02d", min, sec)
    end
end

--根据日期获取时间戳
function GetTimestamp(sTime)
    local len = sTime:len()
    if len > 19 then
        return
    end

    if len <= 10 then
        sTime = sTime .. " 00:00:00"
    end

    local _, _, y, m, d, _hour, _min, _sec = string.find(sTime, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
    local timestamp = os.time({year = y, month = m, day = d, hour = _hour, min = _min, sec = _sec})
    return timestamp
end

-- 获取毫秒级时间戳
function GetCurrentTime()
    local current_time = os.time() * 1000 + math.floor(os.clock() * 1000)
    return current_time
end


--根据2个时间戳获取间隔天数
function GetTimeBetweenDays(sTime, eTime)
    eTime = eTime or os.time()
    local ret = strsplit(GetDate(sTime), " ")
    local sTime0 = GetTimestamp(ret[1])
    return math.floor((eTime - sTime0) / 86400)
end

--根据2个日期获取间隔天数
function GetDateBetweenDays(sDate, eDate)
    eDate = eDate or GetDate()
    local ret = strsplit(sDate, " ")
    local sTime0 = GetTimestamp(ret[1])
    local eTime = GetTimestamp(strsplit(eDate, " ")[1])
    return math.floor((eTime - sTime0) / 86400)
end

--根据日期获取显示日期
function GetDateShow(sTime)
    local len = sTime:len()
    if len == 10 or len == 19 then
    else
        return
    end

    if len == 19 then
        sTime = sTime:sub(1, 10)
    end

    local _, _, y, m, d = string.find(sTime, "(%d+)-(%d+)-(%d+)")
    return y .. "年" .. tonumber(m) .. "月" .. tonumber(d) .. "日"
end

--当前周一日期
function GetWeekDate(iTime)
    iTime = iTime or os.time()
    local wDay = GetWday(iTime)
    local date = GetDate(iTime - 86400 * (wDay - 1))
    local ret = date:sub(1, 10)
    return ret
end

function dbg(...)
    release_print(...)
end

function dbgt(tbl, front, parent)
    if type(tbl) ~= "table" then
        return
    end
    local space = "    "
    front = front or space

    if parent then
        release_print(parent)
    end
    release_print(front .. "{")

    for k, v in pairs(tbl) do
        local msg = space .. front

        if type(k) == "string" then
            msg = msg .. string.format('["%s"] = ', k)
        elseif type(k) == "number" then
            msg = msg .. string.format("[%d] = ", k)
        end

        if type(v) == "number" then
            msg = msg .. string.format("%d", v)
        elseif type(v) == "string" then
            msg = msg .. string.format('"%s"', v)
        elseif type(v) == "table" then
            dbgt(v, front .. space, msg)
        end

        if type(v) ~= "table" then
            msg = msg .. ","
            release_print(msg)
        end
    end

    if parent then
        release_print(front .. "},")
    else
        release_print(front .. "}")
    end
end

--根据元素固定间隔和元素数量计算起始坐标
function CalAveragePos(_PSize, _Size, _IX, _Count, _IsCenter)
    if _IsCenter then
        return _PSize / 2 - _IX * (_Count - 1) / 2
    else
        return (_PSize - _Size) / 2 - _IX * (_Count - 1) / 2
    end
end

--根据中心点，一行元素的x坐标(每个元素是ax = 0.5)
--输入中点，间隔，元素宽，个数，第几个
function GetCenterGroupPos(ox,ix,width,count,i)
    if bitAnd(count,1) == 1 then
        return ox + (ix+width) * (i-math.ceil(count/2))
    else
        return ox + (ix+width) * (i-(count+1)/2)
    end
end

--输入元素总数 每行个数 间距 返回坐标
function GetGridPos(_Count, _LineCount, _IX, _IY)
    local tPos = {}
    for i = 1, _Count do
        local line = math.ceil(i / _LineCount) - 1
        local pos = i - line * _LineCount - 1
        local _X = pos * _IX
        local _Y = line * _IY
        tPos[#tPos + 1] = {_X, _Y}
    end
    return tPos
end


--获取一个json串里的key值
function GetJsonValue(strJson, key)
    if type(strJson) ~= "string" or strJson == "" then
        return
    end

    if type(key) ~= "string" and type(key) ~= "number" then
        return
    end

    local ret
    local function _GetJsonValue()
        local tJson = json.decode(strJson)
        ret = tJson[key]
    end

    local _, errinfo = pcall(_GetJsonValue)
    if errinfo then
        release_print("GetJsonValue", errinfo)
        return
    end

    return ret
end

--设置一个json串里的key值并返回
function SetJsonValue(strJson, key, value)
    if not strJson then
        return
    end

    if type(key) ~= "string" and type(key) ~= "number" then
        return
    end

    if type(value) ~= "string" and type(value) ~= "number" then
        return
    end
    local ret

    local function _SetJsonValue()
        local tJson = {}
        if strJson ~= "" then
            tJson = json.decode(strJson)
        end

        tJson[key] = value
        ret = json.encode(tJson)
    end

    local _, errinfo = pcall(_SetJsonValue)
    if errinfo then
        release_print("SetJsonValue", errinfo)
        return
    end

    return ret
end

--计算table总和
function TableSum(tbl)
    local function sum(...)
        local num = 0
        for i = 1, select("#", ...) do
            num = num + select(i, ...)
        end
        return num
    end
    return sum(unpack(tbl))
end

--根据权重随机
function WeightRandom(tab, weightIndex)
    if #tab <= 0 then
        return
    end
    local t = {}
    
    for i = 1,#tab do
        if weightIndex then
            t[i] = tab[i][weightIndex]
        elseif type(tab[i]) == "table" and tab[i].Weight then
            t[i] = tab[i].Weight
        elseif type(tab[i]) == "number" then
            t[i] = tab[i]
        else
            return
        end
    end

    local sum = 0
    for i = 1, #t do
        sum = sum + t[i]
    end

    local comparew = math.random(1, sum)
    local windex = 1
    while sum > 0 do
        sum = sum - t[windex]
        if sum < comparew then
            return windex
        end
        windex = windex + 1
    end

    return nil
end

--简化数值 （超万显示万为单位 超亿显示亿为单位）
function GetSimplenum(num)
    num = tonumber(num)
    if num <= 10000 then
        return tostring(num)
    end

    if num >= 100000000 then
        --亿
        return string.format("%.2f", num / 100000000) .. "亿"
    elseif num > 10000 then
        --万
        return string.format("%.1f", num / 10000) .. "万"
    end
end

--获取通用资源路径
function GetCommonRes(name)
    return "custom/common/" .. name .. ".png"
end

--获取数字资源路径
function GetNumberRes(number, type)
    return "custom/number/" .. type .. "_" .. number .. ".png"
end

--根据方法名执行
function RunFuncName(funcName, ...)
    local func = load("return " .. funcName)
    func = func()
    if func then
        return func(...)
    end
end

----获取属性值显示
--function GetAttrValueStr(attyType, value)
--    attyType = tonumber(attyType)
--    local type = cfg_att_score[attyType].type
--    local str = value
--    if type == 2 then
--        str = value / 100 .. "%"
--    elseif type == 3 then
--        str = value .. "%"
--    end
--    return str
--end
--
----获取属性显示格式
--function GetAttrShow(attyType, value)
--    attyType = tonumber(attyType)
--    return cfg_att_score[attyType].name .. "：" .. GetAttrValueStr(attyType, value)
--end

--100以下阿拉伯数字转中文
function Ara2CN(num)
    local tChar = {
        [0] = "零",
        [1] = "一",
        [2] = "二",
        [3] = "三",
        [4] = "四",
        [5] = "五",
        [6] = "六",
        [7] = "七",
        [8] = "八",
        [9] = "九",
        [10] = "十"
    }

    if num < 11 then
        return tChar[num]
    elseif num < 20 then
        return tChar[10] .. tChar[num % 10]
    elseif num < 100 then
        if num % 10 == 0 then
            return tChar[math.floor(num / 10)] .. tChar[10]
        else
            return tChar[math.floor(num / 10)] .. tChar[10] .. tChar[num % 10]
        end
    end

    return
end

--中文星期几
function CHWeekDay(wDay)
    local tChar = {
        [1] = "一",
        [2] = "二",
        [3] = "三",
        [4] = "四",
        [5] = "五",
        [6] = "六",
        [7] = "日"
    }
    return tChar[wDay]
end

--十进制转二进制
function dec2bin(n)
    local t = {}
    for i = 31, 0, -1 do
        t[#t + 1] = math.floor(n / 2 ^ i)
        n = n % 2 ^ i
    end
    return table.concat(t)
end

--返回一串数字某个位的数值
function GetNumValueByIndex(actor, value, index)
    value = tonumber(value)
    index = tonumber(index)

    local ret = value % (10 ^ index)
    ret = math.floor(ret / (10 ^ (index - 1)))
    return ret
end

--根据总时间(秒数)获取 天,时,分,秒
function GetDetailTime(_TotleTime)
    if _TotleTime <= 0 then
        return 0, 0, 0, 0
    end
    local s = _TotleTime
    local m = math.floor(s / 60)
    local h = math.floor(m / 60)
    local d = math.floor(h / 24)
    s = s % 60
    m = m % 60
    h = h % 24
    return d, h, m, s
end

--根据秒数获取时间剩余的字符串
function GetLeaveTimeString(_TotleTime)
    local d, h, m, s = GetDetailTime(_TotleTime)
    local _Ret = ""
    if d ~= 0 then
        _Ret = d .. "天" .. h .. "时" .. m .. "分" .. s .. "秒"
    elseif h ~= 0 then
        _Ret = h .. "时" .. m .. "分" .. s .. "秒"
    else
        _Ret = m .. "分" .. s .. "秒"
    end
    return _Ret
end

function GetLeaveTimeString2(_TotleTime)
    local d, h, m, s = GetDetailTime(_TotleTime)
    local _Ret = ""
    if h > 0 then
        if h < 10 then
            _Ret = _Ret .. "0" .. h .. ":"
        else
            _Ret = _Ret .. h .. ":"
        end
    end
    if m < 10 then
        _Ret = _Ret .. "0" .. m .. ":"
    else
        _Ret = _Ret .. m .. ":"
    end
    if s < 10 then
        _Ret = _Ret .. "0" .. s
    else
        _Ret = _Ret .. s
    end
    return _Ret
end

--解析邮件道具字符串 返回 tItem,tAmount,tBind
function DecodeMailItems(str)
    if type(str) == "string" and str ~= "" then
        local tItem, tAmount, tBind = {}, {}, {}
        local tItemString = strsplit(str, "&")
        for i = 1, #tItemString do
            local tRet = strsplit(tItemString[i], "#")
            tItem[#tItem + 1] = tRet[1]
            tAmount[#tAmount + 1] = tRet[2]

            if not tRet[3] or tRet[3] == "0" then
                tBind[#tBind + 1] = false
            else
                tBind[#tBind + 1] = true
            end
        end

        return tItem, tAmount, tBind
    end
end

function encodeBase64(source_str)
    local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    return ((source_str:gsub(
        ".",
        function(x)
            local r, b = "", x:byte()
            for i = 8, 1, -1 do
                r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
            end
            return r
        end
    ) .. "0000"):gsub(
        "%d%d%d?%d?%d?%d?",
        function(x)
            if (#x < 6) then
                return ""
            end
            local c = 0
            for i = 1, 6 do
                c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
            end
            return b:sub(c + 1, c + 1)
        end
    ) .. ({"", "==", "="})[#source_str % 3 + 1])
end

--检测行会名玩家名是否这个服务器的, 是则返回原名称
function IsThisServer(name)
    local serverKey = "k" .. lualib:GetServerId() .. "_"
    if name:find(serverKey) then
        --是本服行会
        name = name:gsub(serverKey, "")
        return name
    end
    return false
end

--【位运算】 https://stackoverflow.com/questions/5977654/how-do-i-use-the-bitwise-operator-xor-in-lua
--异或
function bitXor(a, b)
    if type(a) == "table" or type(b) == "table" then return end
    a = tonumber(a)
    b = tonumber(b)
    local p, c = 1, 0
    while a > 0 and b > 0 do
        local ra, rb = a % 2, b % 2
        if ra ~= rb then
            c = c + p
        end
        a, b, p = (a - ra) / 2, (b - rb) / 2, p * 2
    end
    if a < b then
        a = b
    end
    while a > 0 do
        local ra = a % 2
        if ra > 0 then
            c = c + p
        end
        a, p = (a - ra) / 2, p * 2
    end
    return c
end
--或
function bitOr(a, b)
    if type(a) == "table" or type(b) == "table" then return end
    a = tonumber(a)
    b = tonumber(b)
    local p, c = 1, 0
    while a + b > 0 do
        local ra, rb = a % 2, b % 2
        if ra + rb > 0 then
            c = c + p
        end
        a, b, p = (a - ra) / 2, (b - rb) / 2, p * 2
    end
    return c
end
--与
function bitAnd(a, b)
    if type(a) == "table" or type(b) == "table" then return end
    a = tonumber(a)
    b = tonumber(b)
    local p, c = 1, 0
    while a > 0 and b > 0 do
        local ra, rb = a % 2, b % 2
        if ra + rb > 1 then
            c = c + p
        end
        a, b, p = (a - ra) / 2, (b - rb) / 2, p * 2
    end
    return c
end
--非
function bitNot(n)
    if type(n) == "table" then return end
    n = tonumber(n)
    local p, c = 1, 0
    while n > 0 do
        local r = n % 2
        if r < 1 then
            c = c + p
        end
        n, p = (n - r) / 2, p * 2
    end
    return c
end
--左移
function bitLmove(x, by)
    if type(x) == "table" or type(by) == "table" then return end
    x = tonumber(x)
    by = tonumber(by)
    return x * 2 ^ by
end
--右移
function bitRmove(x, by)
    if type(x) == "table" or type(by) == "table" then return end
    x = tonumber(x)
    by = tonumber(by)
    return math.floor(x / 2 ^ by)
end

--k,v属性table转换成装备表属性字段配置格式
function AttTbl2EquipAttStr(tTotalAttr)
    --tTotalAttr = {["1"] =1000, ["3"] = 50}
    local allStr = {}
    for k, v in pairs(tTotalAttr) do
        local singleStr = {3}
        singleStr[#singleStr + 1] = k
        singleStr[#singleStr + 1] = v
        allStr[#allStr + 1] = table.concat(singleStr, "#")
    end

    --"3#76#3500|3#77#3500"
    return table.concat(allStr, "|")
end

--两个表的键值合并,返回一张不重复的键值表，顺序会变
--({"123","222","333","123"},{"123","222","777"})->{"123,"222","333","777"}
function MergeTable(table1, table2)
    local tMap = {}
    if type(table1) == "table" then
        for k,v in pairs(table1) do
            if type(v) ~= "table" then
                tMap[v] = 1
            end
        end
    end
    if type(table2) == "table" then
        for k,v in pairs(table2) do
            if type(v) ~= "table" then
                tMap[v] = 1
            end
        end
    end

    local ret = {}
    for k,v in pairs(tMap) do
        ret[#ret+1] = k
    end

    return ret
end

function isInTable(tb, v)
    if "table" ~= type(tb) or nil == v then
        return false
    end
    for _, cur_v in pairs(tb) do
        if cur_v == v then
            return true
        end
    end
    return false
end

function tabOfIndex(tb, v)
    if "table" ~= type(tb) or nil == v then
        return nil
    end
    for key, cur_v in pairs(tb) do
        if cur_v == v then
            return key
        end
    end
    return nil
end

function gettimestamp(hour, min, sec)
    -- 设置想要的时间（例如，中午12点）
    local t = {year = os.date("%Y"), month = os.date("%m"), day = os.date("%d"), hour = hour, min = min, sec = sec}
    -- 将时间表转换为时间戳
    local timestamp = os.time(t)
    
    return timestamp
end

function runTriggerCallBack(triggerName, ...)
    GameEvent.push(triggerName, ...)
end


function weightedRandom(items)
    -- 计算总权重
    local totalWeight = 0
    for _, item in pairs(items) do
        if item.weight and tonumber(item.weight) ~= nil then
            totalWeight = totalWeight + item.weight
        end
    end
    
    -- 生成随机数
    local randomValue = math.random() * totalWeight
    
    -- 选择对应的项目
    local currentWeight = 0
    for _, item in pairs(items) do
        if item.weight and tonumber(item.weight) ~= nil then
            currentWeight = currentWeight + item.weight
            if randomValue <= currentWeight then
                return item
            end
        end
    end
    
    -- 如果所有检查都失败(理论上不应该发生)，返回最后一个项目
    return items[#items]
end

-- txt权重转为lua权重
-- 值#权重
-- str: 1#500|2#300|3#200|4#100|5#50|6#10|7#5|8#3|9#2|10#1"
function getWeightedCfg(str)
    local tab = strsplit(str, "|")
    local tmp_list = {}
    for k, v in pairs(tab) do
        local _t = strsplit(v, "#")
        tmp_list[#tmp_list + 1] = {value = tonumber(_t[1]) or _t[1], weight = tonumber(_t[2])}
    end
    return tmp_list    
end
function CN2Ara(CN)
    local tChar = {
        ["一"] = 1,
        ["二"] = 2,
        ["三"] = 3,
        ["四"] = 4,
        ["五"] = 5,
        ["六"] = 6,
        ["七"] = 7,
        ["八"] = 8,
        ["九"] = 9,
        ["十"] = 10,
    }
    return tChar[CN]
end
--======================================================= 封装货币相关接口 ==================================================================
-- 设置人物货币
---comment
---@param obj any       玩家对象
---@param moneyId any   货币ID
---@param opt any       操作符
---@param num any       数量
---@param desc any      备注
---@param send any      是否发送到前端
---@return boolean      --是否成功
function ChangeMoney(obj, moneyId, opt, num, desc, send)
    return changemoney(obj, moneyId, opt, num, desc, send)
end
-- 扣除人物通用货币数量(多货币依次计算)
---comment
---@param obj any          玩家对象
---@param moneyName any    货币名称
---@param count any        数量
---@param desc any         备注
---@return boolean         --是否成功
function ConsumeBindMoney(obj, moneyName, count, desc)
    return consumebindmoney(obj, moneyName, count, desc)
end