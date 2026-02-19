LocalCfgParser = LocalCfgParser or {}
LocalCfgParser.cachedExpress = {}
--default func
LocalCfgParser.getVariableOfKey = function() return false end

function LocalCfgParser:setKeyValueTranslator(getVariableOfKey)
	self.getVariableOfKey = getVariableOfKey
end

function LocalCfgParser:getLogicalOpStr(str)
	if "|" == str then
		return " or "
	elseif "&" == str then
		return " and "
	end
end

function LocalCfgParser:evaluateLuaExpression(luaExpress)
	if self.cachedExpress[luaExpress] then
		return self.cachedExpress[luaExpress]()
	end
	local str2LuaCode = "return "
	local left, op, right = "", "", ""
	local inBracket = false
	local onLeft = true
	local pos = 1

	while pos <= #luaExpress do
		local char = luaExpress:sub(pos, pos)
		local skipLoop = false
		if not inBracket then
			if char == '[' then
				local bracketCount = 1
				for i = pos + 1, #luaExpress do
					if luaExpress:sub(i, i) == '[' then
						bracketCount = bracketCount + 1
					elseif luaExpress:sub(i, i) == ']' then
						bracketCount = bracketCount - 1
					end
					if bracketCount == 0 then
						local subStr = luaExpress:sub(pos + 1, i - 1)
						str2LuaCode = str2LuaCode .. " LocalCfgParser:evaluateLuaExpression(\"".. subStr .. "\") "
						pos = i + 1
						if pos <= #luaExpress then
							str2LuaCode = str2LuaCode .. self:getLogicalOpStr(luaExpress:sub(pos, pos))
						end	
						break
					end
				end
				skipLoop = true
			elseif char == '<' and left == "" then
				local closePos = luaExpress:find(">", pos)
				left = luaExpress:sub(pos, closePos)
				pos = closePos + 1
				inBracket = true
			end
		end

		if not skipLoop then
			char = luaExpress:sub(pos, pos)
			if onLeft then
				if luaExpress:find("^<=", pos) ~= nil or luaExpress:find("^>=", pos) ~= nil then
					op = luaExpress:sub(pos, pos + 1)
					onLeft = false
					pos = pos + 1

				elseif luaExpress:find("^<", pos) ~= nil or luaExpress:find("^>", pos) ~= nil then
					op = char
					onLeft = false
				elseif luaExpress:find("^=", pos) ~= nil then
					op = "=="
					onLeft = false
				else
					left = left .. char
				end
			else
				if char == '|' or char == '&' then
					-- 这样的话需要把右值转成number
					if string.find(op, "<") or string.find(op, ">") then
						right = tonumber(right) or 0
					elseif not self:isStringPureNumber(right) or self:isNumberPureString(left) then
						right = "\"" .. right .. "\""
					elseif op == "==" then
						right = "\"" .. right .. "\""
					end
					--left = string.upper(left)
					str2LuaCode = str2LuaCode .. "LocalCfgParser:getVariableOfKey(\"" .. left .. "\", \"" .. op .."\")" .. op .. right .. self:getLogicalOpStr(char)
					left, op, right = "", "", ""

					onLeft = true
					inBracket = false
				else
					right = right .. char
				end
			end
		end
		pos = pos + 1
	end
	if op ~= "" then
		-- 这样的话需要把右值转成number
		if string.find(op, "<") or string.find(op, ">") then
			right = tonumber(right) or 0
		elseif not self:isStringPureNumber(right) or self:isNumberPureString(left) then
			right = "\"" .. right .. "\""
		elseif op == "==" then
			right = "\"" .. right .. "\""
		end
		--left = string.upper(left)
		str2LuaCode = str2LuaCode .. "LocalCfgParser:getVariableOfKey(\"" .. left .. "\",\"".. op .."\")" .. op .. right
	end
	local resultFunc, err = load(str2LuaCode)
	self.cachedExpress[luaExpress] = resultFunc
	-- SL:Print("LocalCfgParser:getVariableOfKey",str2LuaCode,self.cachedExpress[luaExpress]())
	return self.cachedExpress[luaExpress]()
end

-- 通过左值类型转换右值
function LocalCfgParser:isNumberPureString(str)
	local _s = str
	local str_tabs = {"A","S","T","Z"}
	local first_char = _s:sub(1, 1)
	if first_char == "<" then
		first_char = _s:sub(2, 2)
	end
	if isInTable(str_tabs,first_char) and string.find(str, "#") == nil then
		return true
	end
	return false
end

-- 通过左值类型转换右值
function LocalCfgParser:isStringPureNumber(str)
	local _s = str
	local str_tabs = {"G","I","P","D","N","M","	U","J","B"}
	local first_char = _s:sub(1, 1)
	if first_char == "<" then
		first_char = _s:sub(2, 2)
	end
	if isInTable(str_tabs,first_char) and string.find(str, "#") == nil then
		return true
	end
	return false
end