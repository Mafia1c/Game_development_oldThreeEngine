--- 全局函数    服务器下发协议到客户端主动调用
GlobalFunc = {}
GlobalFunc.pubg_eff = {}
GlobalFunc.schedule_id = nil

-- 显示吃鸡毒圈特效
GlobalFunc["ShowPubgEffect"] = function (map_x, map_y, radius)
    GlobalFunc["DelPubgEffect"]()
    map_x = tonumber(map_x)
    map_y = tonumber(map_y)
    radius = tonumber(radius)
    if nil == map_x or nil == map_y or nil == radius then
        return
    end
    radius = radius * 48 + 24

    local pos = SL:ConvertMapPos2WorldPos(map_x, map_y)
    local function getPoints(x0, y0, r)
        local points = {}
        local seen = {}
        local x = r
        local y = 0
        local err = 0
        while x >= y do
            -- 添加八个对称的点
            local tmp_points = {}
            table.insert(tmp_points, {x0 + x, y0 + y})
            table.insert(tmp_points, {x0 + y, y0 + x})
            table.insert(tmp_points, {x0 - y, y0 + x})
            table.insert(tmp_points, {x0 - x, y0 + y})
            table.insert(tmp_points, {x0 - x, y0 - y})
            table.insert(tmp_points, {x0 - y, y0 - x})
            table.insert(tmp_points, {x0 + y, y0 - x})
            table.insert(tmp_points, {x0 + x, y0 - y})

            for _, point in ipairs(tmp_points) do
                local key = {point[1], point[2]}
                if not seen[key] then
                    table.insert(points, point)
                    seen[key] = true
                end
            end

            if err <= 0 then
                y = y + 10
                err = err + 2*y + 10
            end
            
            if err > 0 then
                x = x - 10
                err = err - 2*x + 10
            end
        end
        return points
    end

    local map_points = getPoints(pos.x, pos.y, radius)
    local parent = GUI:Attach_SceneB()
    if nil == GlobalFunc.schedule_id then
        local function update_callback()
            local _index = #GlobalFunc.pubg_eff
            if _index == #map_points then
                return
            end
            for i = 1, 100 do
                local k = _index + i
                local v = map_points[k]
                if v then
                    local icon = GUI:Effect_Create(parent, k.."_icon", v[1], v[2], 0, 27)
                    GlobalFunc.pubg_eff[k] = icon
                end
            end
        end
        GlobalFunc.schedule_id = SL:Schedule(update_callback, 0.05)
    end
end

-- 删除吃鸡毒圈特效
GlobalFunc["DelPubgEffect"] = function ()
    if GlobalFunc.schedule_id then
        SL:UnSchedule(GlobalFunc.schedule_id)
    end
    GlobalFunc.schedule_id = nil
    for k, v in pairs(GlobalFunc.pubg_eff)do
        GUI:removeFromParent(v)
    end
    GlobalFunc.pubg_eff = {}
end

-- 显示主界面top按钮
GlobalFunc["ShowMainTopBtn"] = function()
    local layout_102 = GUI:Win_FindParent(102)
    local btn_parent = GUI:GetWindow(layout_102, "btn_parent")
    if btn_parent then
        GUI:setVisible(btn_parent, true)
    end
end

-- 隐藏主界面top按钮
GlobalFunc["HiedMainTopBtn"] = function()
    local layout_102 = GUI:Win_FindParent(102)
    local btn_parent = GUI:GetWindow(layout_102, "btn_parent")
    if btn_parent then
        GUI:setVisible(btn_parent, false)
    end
end

--#region 合服次数接取
GlobalFunc["HeFuCount"] = function(count)
    SL:Print("HeFuCount = ", count)
    GameData.SetData("HeFuCount#"..count)
    SL:onLUAEvent(LUA_EVENT_GAME_DATA, "HeFuCount#"..count)
end

--#region 开服天数接取
GlobalFunc["OpenDay"] = function(count)
    SL:Print("OpenDay = ", count)
    GameData.SetData("OpenDay#"..count)
    SL:onLUAEvent(LUA_EVENT_GAME_DATA, "OpenDay#"..count)
end

--gm踢他下线
GlobalFunc["GMBoxMgr"] = function()
    local data = {}
    data.str = "当前登录账号正在其他位置登录，本机已被强制离线！若非本人操作，请更改密码！"
    data.btnType = 1
    data.btnDesc = {"返回登录"}
    data.showEdit = false
    data.callback = function(atype, param)
        if atype == 1 then
            SL:ExitGame()
        end
    end
    SL:OpenCommonTipsPop(data)
end

--打开gm面板
GlobalFunc["GMBoxOBJ"] = function()
   GUI:Win_Open("A/GMBoxOBJ")
end