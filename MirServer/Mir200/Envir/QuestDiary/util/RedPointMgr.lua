RedPointMgr = {}
RedPointMgr.cfg = include("QuestDiary/config/cfg_redpoint.lua")
RedPointMgr.red_point_data_cache = {}       -- 缓存红点信息 删除的时候要用
RedPointMgr.redPoint_check_count = 10
function RedPointMgr:CheckRedPointCfg(actor)
    if self.redpoint_cfg == nil then
        self.redpoint_cfg = {}
        local cfg = RedPointMgr.cfg
        for k, v in ipairs(cfg) do
            self.red_point_data_cache[v.id] = {}
            table.insert(self.redpoint_cfg,  v)
        end
        self.start_index = 0
        self.redPoint_total_count = #self.redpoint_cfg
    end
    local cur_index = 0
    for i = 1, self.redPoint_check_count do
        cur_index = i + self.start_index
        local v = self.redpoint_cfg[cur_index]
        if v then
            local varCondition2 = v.VarCondition                   -- 条件2
            if string.find(varCondition2,"$SFUN")  then
                local content = string.match(varCondition2, "%((.-)%)")
                local str_list = strsplit(content,"#")
              
                self:FlushVarValue(actor,str_list[1],str_list[2],str_list[3])
            end
        end
    end
    self.start_index = self.start_index + self.redPoint_check_count
    if self.start_index > self.redPoint_total_count + 1 then
        self.start_index = 0
    end
end

function RedPointMgr:FlushVarValue(actor,...)
    local tab = {...}
    local fun_name = tab[3] ~= nil and tab[3] or "flushRedData"
    local class = IncludeNpcClass(tab[2]) or IncludeMainClass(tab[2]) 
    if class then
        local fun = class[fun_name]
        local red_num = fun(fun,actor)
        if VarApi.getPlayerUIntVar(actor, tab[1]) ~= red_num then
            VarApi.setPlayerUIntVar(actor, tab[1],red_num,true)
        end
    end
end

