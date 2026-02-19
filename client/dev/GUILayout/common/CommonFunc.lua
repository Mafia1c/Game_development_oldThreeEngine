
function unpack(arr, pos)
    pos = pos or 1
    if pos >= #arr then
        return arr[pos]
    end
    return arr[pos], unpack(arr, pos + 1)
end

function isInTable(tab, value)
    if "table" ~= type(tab) or nil == value then
        return false
    end
    for _, cur_v in pairs(tab) do
        if cur_v == value then
            return true
        end
    end
    return false
end

function GetNpcDistance(npc_id)
    local main_role = SL:GetMetaValue("MAIN_ACTOR_ID")
    local p1x = SL:GetMetaValue("ACTOR_MAP_X", main_role)
    local p1y = SL:GetMetaValue("ACTOR_MAP_Y", main_role)
    local p2x = SL:GetMetaValue("ACTOR_MAP_X", npc_id)
    local p2y = SL:GetMetaValue("ACTOR_MAP_Y", npc_id)

	local x_step = math.abs(p1x - p2x)
	local y_step = math.abs(p1y - p2y)
	 local maxValue = math.max(x_step, y_step)
	return maxValue
end

local weekday_str = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日" }
function timeWeekdayStr(time)
    local weekday = os.date("%w", time)
    return weekday_str[weekday + 1]
end

---移除当前控件并监听parent。
---*  removeObj : 当前需要移除的控件
---*  nowObj : 当前脚本类
---@param removeObj obj
---@param nowObj class
---@return any
function removeOBJ(removeObj,nowObj)
    if removeObj then
        GUI:removeFromParent(removeObj)
        nowObj.ui = GUI:ui_delegate(nowObj._parent)
    end
end


local CONST_3600 = 3600
local CONST_3600_INTERVAL = 1 / CONST_3600
local CONST_60 = 60
local CONST_60_INTERVAL = 1 / CONST_60
local CONST_24 = 24
local CONST_24_INTERVAL = 1 / CONST_24
local CONST_60_60_24_INTERVAL = CONST_3600_INTERVAL * CONST_24_INTERVAL
function FormatSecond2CN_DHMS2(time)
    time = tonumber(time)
    if time and time > 0 then
        local day = math.floor(time * CONST_60_60_24_INTERVAL)
        local hour = math.floor((time * CONST_3600_INTERVAL) % 24)
        local minute = math.floor((time * CONST_60_INTERVAL) % 60)
        local second = math.floor(time % 60)

        local format_str = ""
        if second >= 0 then
            format_str = format_str .. tostring(second) .. "秒"
        end
        if minute > 0 or hour > 0 or day > 0 then
            format_str = tostring(minute) .. "分" .. format_str
        end
        if hour > 0 or day > 0 then
            format_str = tostring(hour) .. "时" .. format_str
        end
        if day > 0 then
            format_str = tostring(day) .. "天" .. format_str
        end

        if format_str == "" then
            return "0秒"
        end
        return format_str
    end

    return "0秒"
end

function ItemShow_updateItem(widget, setData)
    if nil ~= setData.index then
        GUI:ItemShow_updateItem(widget, setData)
    end
    local node = GUI:getChildByName(widget, "_show_count")
    if node then
        GUI:removeFromParent(node)
        node = nil
    end    
    if setData.showCount and setData.count == 1  then     -- 显示数字1
        local size = GUI:getContentSize(widget)
        local str = "<%s/FCOLOR=%d>"
        GUI:RichTextFCOLOR_Create(widget, "_show_count", size.width - 10, 0, string.format(str, setData.count, setData.color or 249), 20, 16, "#ffffff")
    end
end