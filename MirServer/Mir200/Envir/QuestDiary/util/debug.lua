LF = {}

function LF.printDebug(...)
    local info = debug.getinfo(2, "Sl")
    local file = info.source
    local line = info.currentline
    local args = {...}

    -- 截取文件路径，只保留关键词后面的部分
    local keyword = "Envir"  -- 关键词
    local startIndex, _ = string.find(file, keyword)
    if startIndex then
        file = string.sub(file, startIndex)
    end

    local separator = string.rep("一", 36)  -- 分隔线
    local log = "\r\n"..separator .. "\r\n[DEBUG] 信息 Begin：\r\n".."文件：" .. file .. "	    [ 行号:" .. line .. " ]\r\n" .. separator .. "\r\n输出内容：\r\n"

	local tablestr = ""
	local str = ""
	local count = 0
    for i, arg in ipairs(args) do

        if type(arg) == "table" then
            str = str .. "["..tostring(i).."] = ".."[" .. type(arg) .. "]\r\n" .. LF.tableToString(arg) .. "\r\n"
        else

            str = str .. "[" .. i .. "] = " .. "[" .. type(arg) .. "]\t"..tostring(arg) .. "\r\n"
        end
    end
    log = log..str.. separator .."\r\n[DEBUG] 信息 End：\r\n文件：" .. file .. "	    [ 行号:" .. line .. " ]\r\n" .. separator .. "\r\n"
   release_print(log)
end

function LF.tableToString(tbl, indent)
    indent = indent or 0
    local indentStr = string.rep("\t", indent)
    local result = ""

    for k, v in pairs(tbl) do
        if type(v) == "table" then
            result = result .. indentStr .."\t[" .. tostring(k) .. "]  = > ".. type(k).."\t 层级  :"..(indent+1).."\r\n"
            result = result .. LF.tableToString(v, indent + 1)
        else
            result = result .. indentStr .. "\t[" .. type(v) .. "]\t" .. tostring(k) .. "\t = \t" .. tostring(v) .. "\r\n"
        end
    end

    return result
end

function LF.dump(o, depth)
    release_print(LF.dumpTable(o, {max_depth = depth}))
end

-- 将 Lua 值转换为可读字符串（支持 table 递归）
-- @param value 要转换的值
-- @param [options] 可选参数表，包含：
--   indent: 初始缩进级别（默认 0）
--   max_depth: 最大递归深度（默认 10，防止无限递归）
--   seen: 用于检测循环引用的表（通常不需要手动传入）
function LF.dumpTable(value, options)
    options = options or {}
    local indent = options.indent or 0
    local max_depth = options.max_depth or 10
    local seen = options.seen or {}
    
    -- 基本类型直接返回
    local typ = type(value)
    if typ == "string" then
        return string.format("%q", value)  -- 给字符串加引号
    elseif typ ~= "table" then
        return tostring(value)
    end
    
    -- 检查循环引用
    if seen[value] then
        return "<circular reference>"
    end
    
    -- 检查递归深度
    if indent >= max_depth then
        return "<max depth reached>"
    end
    
    -- 标记当前 table 为已访问
    seen[value] = true
    
    local parts = {}  -- 收集各部分字符串
    local indent_str = string.rep("  ", indent)
    local next_indent_str = string.rep("  ", indent + 1)
    
    -- 先处理数组部分（连续数字索引）
    local array_part = {}
    for i = 1, #value do
        table.insert(array_part, LF.dumpTable(value[i], {
            indent = indent + 1,
            max_depth = max_depth,
            seen = seen
        }))
    end
    
    -- 处理非数组部分
    local hash_part = {}
    for k, v in pairs(value) do
        -- 跳过数组部分已处理的键
        if type(k) ~= "number" or k > #value or k < 1 then
            local key_str
            if type(k) == "string" and string.match(k, "^[a-zA-Z_][a-zA-Z0-9_]*$") then
                key_str = k  -- 如果是合法标识符，直接使用
            else
                key_str = "[" .. LF.dumpTable(k, {indent = 0, max_depth = max_depth}) .. "]"
            end
            
            table.insert(hash_part, string.format(
                "%s%s = %s",
                next_indent_str,
                key_str,
                LF.dumpTable(v, {
                    indent = indent + 1,
                    max_depth = max_depth,
                    seen = seen
                })
            ))
        end
    end
    -- 组合所有部分
    if #array_part > 0 and #hash_part > 0 then
        table.insert(parts, "{\r\n" .. next_indent_str .. "-- array part:")
        table.insert(parts, next_indent_str .. table.concat(array_part, ",\r\n" .. next_indent_str))
        table.insert(parts, next_indent_str .. "-- hash part:")
        table.insert(parts, table.concat(hash_part, ",\r\n"))
        table.insert(parts, indent_str .. "}")
    elseif #array_part > 0 then
        table.insert(parts, "{\r\n" .. next_indent_str .. table.concat(array_part, ",\r\n" .. next_indent_str) .. "\r\n" .. indent_str .. "}")
    elseif #hash_part > 0 then
        table.insert(parts, "{\r\n" .. table.concat(hash_part, ",\r\n") .. "\r\n" .. indent_str .. "}")
    else
        return "{}"
    end
    return table.concat(parts, "\r\n")
end
