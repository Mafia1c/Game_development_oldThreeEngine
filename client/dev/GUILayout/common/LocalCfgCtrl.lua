LocalCfgCtrl = LocalCfgCtrl or {}
SL:Require("GUILayout/common/LocalCfgParser", true)
LocalCfgCtrl.cfg = SL:Require("scripts/game_config/cfg_redpoint",true)

-- 气泡检测     配置文件 game_config/cfg_bubble.lua
-- 红点检测     配置文件 game_config/cfg_redpoint.lua

-- self.parser = LocalCfgParser.New()
LocalCfgCtrl.bubble_cfg = nil
LocalCfgCtrl.redpoint_cfg = nil

LocalCfgCtrl.delayer_execute_time = 5
LocalCfgCtrl.redPoint_check_count = 10

LocalCfgCtrl.cachedGetValue = {}
LocalCfgCtrl.red_point_data_cache = {}       -- 缓存红点信息 删除的时候要用

local function Update(now_time, elapse_time)
    -- 红点每帧检测一个
    LocalCfgCtrl:CheckRedPointCfg()
end
------------------------------------------------------- 红点 ------------------------------------------------------------
function LocalCfgCtrl:CheckRedPointCfg()
    if self.redpoint_cfg == nil then
        self.redpoint_cfg = {}
        local cfg = LocalCfgCtrl.cfg
        for k, v in ipairs(cfg) do
            self.red_point_data_cache[v.id] = {}
            table.insert(self.redpoint_cfg,  SL:CopyData(v))
        end
        self.start_index = 0
        self.redPoint_total_count = #self.redpoint_cfg
    end
    local cur_index = 0
    for i = 1, self.redPoint_check_count do
        cur_index = i + self.start_index
        local v = self.redpoint_cfg[cur_index]
        if v then
            local varCondition1 = v.levelCondition                   -- 条件1
            local varCondition2 = v.VarCondition                   -- 条件2
            local currencyCondition = v.currencyCondition           -- 条件3
            local is_ok = self:CheckRedPointVars(varCondition1, varCondition2, currencyCondition)
            if true == v._is_check_ok then
                if not is_ok then
                    v._is_check_ok = false
                    self:DelRedPointData(v)
                end
            else
                if is_ok then
                    v._is_check_ok = true                               -- 标记这一条已经检测通过了
                    self:CreateRedPointData(v)
                end
            end
        end
    end
    self.start_index = self.start_index + self.redPoint_check_count
    if self.start_index > self.redPoint_total_count + 1 then
        self.start_index = 0
    end
end

function LocalCfgCtrl:GetVarRedPointValueByKey(key, op)
    local value
    if LocalCfgCtrl.cachedGetValue[key] then
        value = LocalCfgCtrl.cachedGetValue[key]()
        if nil == value then
            if op ~= "==" then
                value = 0
            else
                value = "null"
            end
        else
            if op ~= "==" then
                value = tonumber(value) or 0
            else
                value = tostring(value) or ""
            end
        end
        return value
    end
    local s, e = string.find(key, "<.->")
    local is_stm = string.find(key, "%$")
    local coin_id = tonumber(key)
    local is_customize_constant = LocalCfgCtrl:CheckCustomizeConstant(key)                                  -- 自定义常量
    if nil ~= is_stm and s ~= nil and e ~= nil and nil == is_customize_constant then                --STM常量
        local subKey = string.sub(key, s + 2, e - 1)
        value = LocalCfgCtrl:GetSTMValueByKey(subKey, key)
    elseif (coin_id or string.find(key, "#") ~= nil) and (nil == s and nil == e) then               --货币(注意关联货币)
        value = 0
        if coin_id then
            if coin_id <= 99 then
                value = SL:GetMetaValue("MONEY_ASSOCIATED", coin_id) 
            else
                value = SL:GetMetaValue("ITEM_COUNT", coin_id) 
            end
        else
            local tabs = string.split(key, "#")
            for k, v in pairs(tabs) do
                local item_id = tonumber(v)
                if item_id <= 99 then
                    value = value + SL:GetMetaValue("MONEY_ASSOCIATED", coin_id)
                else
                    value = value + SL:GetMetaValue("ITEM_COUNT", coin_id)
                end
            end
        end
    else                                                                    --系统变量
        if s and e then
            local subKey = string.sub(key, s + 1, e - 1)
            if subKey == "$SFUN" then
                --转到后端处理处理
            end
        else
            value = GameData.GetData(key)
        end
        if "" == value or value == nil then
            value = "null"
        end
    end
    if nil == value then
        if op ~= "==" then
            value = 0
        else
            value = "null"
        end
    else
        if op ~= "==" then
            value = tonumber(value) or 0
        else
            value = tostring(value) or ""
        end
    end
    return value
end

function LocalCfgCtrl:CheckRedPointVars(var1, var2, var3)
    local var = ""
    if var1 then
        var = "["..var1.."]"
    end
    if var2 then
        if var == "" then
            var =  "["..var2.."]"
        else
            var =  var .."&".. "["..var2.."]"
        end 
    end
    if var3 then
        if var == "" then
            var =  "["..var3.."]"
        else
            var =  var .."&".. "["..var3.."]"
        end 
    end
    LocalCfgParser:setKeyValueTranslator(LocalCfgCtrl.GetVarRedPointValueByKey)
    return LocalCfgParser:evaluateLuaExpression(var),false,var
end

-- 创建一个红点数据
-- ids: 104#30#100#31#33#111#112#113#114  主界面ID#按钮ID#面板ID(layerid)#按钮ID#按钮ID按钮ID（用#无限添加按钮ID）
-- offset: 0#15#15#0|0#15#15#3  红点偏移位置 手机端红点#X坐标#Y坐标#显示位置|PC端红点#X坐标#Y坐标#显示位置 (0或空=左上角,1=右上角,2=左下角,3=右下角,4=居中)
function LocalCfgCtrl:CreateRedPointData(cfg)
    local id = cfg.id
    local t = string.split(cfg.offset or "", "|")
    local res_tabs = string.split(t[1] or "", "#")
    local id_tab = string.split(cfg.ids, "|")
    local id_tabs = string.split(id_tab[1], "#")
    if SL:GetMetaValue("WINPLAYMODE") then
        res_tabs = string.split(t[2] or "", "#")
        if id_tab[2] ~= "" and id_tab[2] ~= nil then
            id_tabs = string.split(id_tab[2], "#")
        end
    end
    local count = #id_tabs
    if count < 2 then
        return
    end
    local red_type = tonumber(res_tabs[1])
    for k, v in pairs(id_tabs) do
        local red_data = nil
        local ui_id = 0
        if k == 1 then
            red_data = self:CreateRedData()
            ui_id = id_tabs[1] or 0
            red_data.btn_id = id_tabs[2] or 0
        elseif k == 3 then
            red_data = self:CreateRedData()
            ui_id = id_tabs[3] or 0
            red_data.btn_id = id_tabs[4]
        elseif k > 4 then
            red_data = self:CreateRedData()
            ui_id = id_tabs[3] or 0
            red_data.btn_id = id_tabs[k]
        end
        if red_data and red_data.btn_id then
            red_data.red_id = id
            red_data.ui_id = tonumber(ui_id) or ui_id
            red_data.align = tonumber(res_tabs[4]) or 0
            if nil == red_type then
                red_data.type = 0
                red_data.res = res_tabs[1]
            elseif 0 == red_type then
                red_data.type = 0
            else
                red_data.type = 1
                red_data.res = res_tabs[1]
            end
            red_data.x = tonumber(res_tabs[2]) or 0
            red_data.y = tonumber(res_tabs[3]) or 0
            ssr.AddRedDot({add = 1, mainId = red_data.ui_id, uiId = red_data.btn_id, x =  red_data.x , y = red_data.y , mode = 0, res = "res/public/btn_npcfh_04.png"}) 
            --显示红点
            table.insert(self.red_point_data_cache[id], red_data)
        end
    end
end
-- 删除红点
function LocalCfgCtrl:DelRedPointData(cfg)
    local id = cfg.id
    local red_tabs = self.red_point_data_cache[id]
    for k, v in pairs(red_tabs) do
        ssr.AddRedDot({add = 0, mainId = v.ui_id, uiId = v.btn_id, x =  v.x , y = v.y , mode = 0, res = "res/public/btn_npcfh_04.png"}) 
    end
    self.red_point_data_cache[id] = {}
end


----------------------------------------------------- 公共方法 -----------------------------------------------------------
function LocalCfgCtrl:GetSTMValueByKey(key, originalKey)
    local value = ""
    local s, e = string.find(key, "%[.-]")
    -- 判断是否是装备名字或者装备item_id
    if s and e then
        --装备 暂未处理
    -- 其他stm常量
    else
        local key_list = string.split(key,"@")
        if #key_list > 1 then
            value = SL:GetMetaValue(key_list[1],tonumber(unpack(key_list, 2)))
        else
            value = SL:GetMetaValue(key)
            self.cachedGetValue[originalKey] = function() return  SL:GetMetaValue(key) end
        end
    end
    return value
end

-- 检查是否是自定义常量
local customize_constant = {
    "%$SFUN",
}
function LocalCfgCtrl:CheckCustomizeConstant(key)
    local is_constant
    for k, v in pairs(customize_constant) do
        is_constant = string.find(key, v)
        if nil ~= is_constant then
            break
        end
    end
    return is_constant
end

function LocalCfgCtrl:CreateRedData()
    return {
        red_id = 0,
        btn_id = nil,
        npc_id = 0,
        obj_id = 0,
        x =  0,
        y =  0,
        res = "",
        ui_id = 0,
        type = 0,
        align = 0,
        isLocalCfg = true
    }
end

local function callBack(data)
    if LocalCfgCtrl.redpoint_cfg == nil then return end
    for k,v in pairs(LocalCfgCtrl.redpoint_cfg) do
        if v._is_check_ok then
            v._is_check_ok = false
        end
    end
    LocalCfgCtrl:CheckRedPointCfg()
end
SL:UnRegisterLUAEvent(MAIN_TOP_BTN_CHANGE, "LocalCfgCtrl")

SL:RegisterLUAEvent(MAIN_TOP_BTN_CHANGE, "LocalCfgCtrl", callBack)

local function bagChangeBack(data)
    if data.opera == 0 or data.opera == 3 then
        for i,v in ipairs(data.operID) do
            if v.item.StdMode == 49 and v.item.Dura >= v.item.DuraMax then
                local data = {add = 1, mainId = 1, uiId = v.MakeIndex, x = 30, y = 30, mode = 1, res = "15256"}
                if SL:GetMetaValue("WINPLAYMODE") then
                    data = {add = 1, mainId = 1, uiId = v.MakeIndex, x = 10, y = 22, mode = 1, res = "15256"}
                end
                ssr.AddRedDot(data)
            end
        end
    end
end
SL:UnRegisterLUAEvent(LUA_EVENT_BAG_ITEM_CHANGE, "LocalCfgCtrl")
SL:RegisterLUAEvent(LUA_EVENT_BAG_ITEM_CHANGE, "LocalCfgCtrl", bagChangeBack)

if LocalCfgCtrl.sch then
    SL:UnSchedule(LocalCfgCtrl.sch)
end 
LocalCfgCtrl.sch = SL:Schedule(Update, 2)