-- 传奇吃鸡
ChuanQiPuBg = {}
ChuanQiPuBg.cfg = {
    map_id = "hd_cfgc",
    -- 初始毒圈
    start_x = 12,
    end_x = 65,
    start_y = 14,
    end_y = 65,
    -- 缩圈步长
    step = {5},
    -- 每次缩圈时间(秒)
    times = {30, 30, 30, 30},
    -- 跑毒方式  0.四边形缩圈  1.圆形缩圈
    pubg_type = 1,
    -- 跑毒活动持续时间(秒)
    totalTimes = 300,
    -- 刷圈中心点
    center_point = 1,
    -- 活动奖励(按名次发放)
    reward = {},
    -- 毒圈初始半径(pubg_type为1时起效)
    radius = 30
}

function ChuanQiPuBg.initData()
    ChuanQiPuBg.player_list = {}
    ChuanQiPuBg.eliminate_list = {}
    ChuanQiPuBg.start_x = ChuanQiPuBg.cfg.start_x
    ChuanQiPuBg.end_x = ChuanQiPuBg.cfg.end_x
    ChuanQiPuBg.start_y = ChuanQiPuBg.cfg.start_y
    ChuanQiPuBg.end_y = ChuanQiPuBg.cfg.end_y
    if type(ChuanQiPuBg.cfg.center_point) == "number" then
        ChuanQiPuBg.center_pos = {
            x = math.random(ChuanQiPuBg.start_x + 10, ChuanQiPuBg.end_x - 10),
            y = math.random(ChuanQiPuBg.start_y + 10, ChuanQiPuBg.end_y - 10)
        }
    else
        ChuanQiPuBg.center_pos = {
            x = ChuanQiPuBg.cfg.center_point[1] or math.floor((ChuanQiPuBg.end_x - ChuanQiPuBg.start_x) * 0.5) + ChuanQiPuBg.start_x,
            y = ChuanQiPuBg.cfg.center_point[2] or math.floor((ChuanQiPuBg.end_y - ChuanQiPuBg.start_y) * 0.5) + ChuanQiPuBg.start_y
        }
    end

    ChuanQiPuBg.run_times = 0
    ChuanQiPuBg.total_times = 0
    ChuanQiPuBg.pubgUpdateCount = 0
    ChuanQiPuBg.curMapEffectNum = 0
    ChuanQiPuBg.timer_id = 321321
    ChuanQiPuBg.end_game = false
    ChuanQiPuBg.cur_radius = ChuanQiPuBg.cfg.radius
end
ChuanQiPuBg.initData()

function ChuanQiPuBg.startPubg(map_id)
    ChuanQiPuBg.initData()              -- 每次跑毒开始时初始化一下
    if hasenvirtimer(map_id, ChuanQiPuBg.timer_id) then
    else
        ChuanQiPuBg.pubgUpdateCount = 0
        setenvirontimer(map_id, ChuanQiPuBg.timer_id, 1, "@update_poison_circle")
    end
end

function ChuanQiPuBg.onJoinPubg(actor, map_id)
    if ChuanQiPuBg.end_game then
        -- 游戏已结束
        Sendmsg9(actor, "ffffff", "活动未开始或已结束!", 1)
        return
    end
    if isInTable(ChuanQiPuBg.eliminate_list, actor) then
        -- 已经淘汰出局玩家不能再进来
        Sendmsg9(actor, "ffffff", "你已被淘汰出局!", 1)
        return
    end
    if map_id == ChuanQiPuBg.cfg.map_id then
        local data = ChuanQiPuBg.player_list[actor] or {}
        data.actor = actor
        data.points = data.points or 0
        ChuanQiPuBg.player_list[actor] = data
        if ChuanQiPuBg.cfg.pubg_type == 1 then
            ChuanQiPuBg.showPubgEffect(ChuanQiPuBg.start_x, ChuanQiPuBg.end_x, ChuanQiPuBg.start_y, ChuanQiPuBg.end_y, ChuanQiPuBg.cur_radius)
        end
    else
        ChuanQiPuBg.player_list[actor] = nil
        if ChuanQiPuBg.cfg.pubg_type == 1 then
            lualib:CallFuncByClient(actor, "DelPubgEffect", nil)
        end
    end
end

function ChuanQiPuBg.showPubgEffect(mini_x, max_x, mini_y, max_y, radius)
    local index = ChuanQiPuBg.curMapEffectNum
    local effect_id = 27
    local points = {}
    if ChuanQiPuBg.cfg.pubg_type == 1 then
        for k, v in pairs(ChuanQiPuBg.player_list) do
            lualib:CallFuncByClient(v.actor, "ShowPubgEffect", ChuanQiPuBg.center_pos.x.."#"..ChuanQiPuBg.center_pos.y.."#"..radius)
        end
    else
        points = ChuanQiPuBg.GetQuadrilateralPoints(mini_x, max_x, mini_y, max_y)
    end
    for k, v in pairs(points) do
        mapeffect(index, ChuanQiPuBg.cfg.map_id, v[1], v[2], effect_id, -1, 0, nil, 1)
        index = index + 1
    end
    ChuanQiPuBg.curMapEffectNum = index
end

function ChuanQiPuBg.delPubgEffect()
    for i = 1, ChuanQiPuBg.curMapEffectNum do
        delmapeffect(i)
    end
end

function update_poison_circle(actor)
    ChuanQiPuBg.run_times = ChuanQiPuBg.run_times + 1
    ChuanQiPuBg.total_times = ChuanQiPuBg.total_times + 1
    if ChuanQiPuBg.total_times > ChuanQiPuBg.cfg.totalTimes then
        ChuanQiPuBg.gameOver()
        return
    end
    local update_count = ChuanQiPuBg.pubgUpdateCount + 1
    local update_time = ChuanQiPuBg.cfg.times[update_count] or ChuanQiPuBg.cfg.times[#ChuanQiPuBg.cfg.times]

    -- 刷圈
    if ChuanQiPuBg.run_times >= update_time then
        local step = ChuanQiPuBg.cfg.step[update_count] or ChuanQiPuBg.cfg.step[#ChuanQiPuBg.cfg.step]
        for k, v in pairs(ChuanQiPuBg.player_list) do
            sendmsgnew(v.actor, 255,249, "毒圈更新!"..step, 0, 2)
        end
        ChuanQiPuBg.run_times = 0
        if ChuanQiPuBg.cfg.pubg_type == 1 then
        else
            ChuanQiPuBg.start_x = ChuanQiPuBg.start_x + step
            ChuanQiPuBg.end_x = ChuanQiPuBg.end_x - step
            ChuanQiPuBg.start_y = ChuanQiPuBg.start_y + step
            ChuanQiPuBg.end_y = ChuanQiPuBg.end_y - step
            if ChuanQiPuBg.start_x > ChuanQiPuBg.center_pos.x then
                ChuanQiPuBg.start_x = ChuanQiPuBg.center_pos.x
            end
            if ChuanQiPuBg.end_x < ChuanQiPuBg.center_pos.x then
                ChuanQiPuBg.end_x = ChuanQiPuBg.center_pos.x
            end
            if ChuanQiPuBg.start_y > ChuanQiPuBg.center_pos.y then
                ChuanQiPuBg.start_y = ChuanQiPuBg.center_pos.y
            end
            if ChuanQiPuBg.end_y < ChuanQiPuBg.center_pos.y then
                ChuanQiPuBg.end_y = ChuanQiPuBg.center_pos.y
            end
        end
        ChuanQiPuBg.cur_radius = ChuanQiPuBg.cur_radius - step
        if ChuanQiPuBg.cur_radius < 1 then
            ChuanQiPuBg.cur_radius = 1
        end
        ChuanQiPuBg.pubgUpdateCount = update_count
        ChuanQiPuBg.showPubgEffect(ChuanQiPuBg.start_x, ChuanQiPuBg.end_x, ChuanQiPuBg.start_y, ChuanQiPuBg.end_y, ChuanQiPuBg.cur_radius)
    else
        local remain_time = update_time - ChuanQiPuBg.run_times
        if remain_time <= 5 then
            for k, v in pairs(ChuanQiPuBg.player_list) do
                sendmsgnew(v.actor, 255,249, "毒圈将在"..remain_time.."秒后更新", 0, 1)
            end
        end
    end

    for k, v in pairs(ChuanQiPuBg.player_list) do
        v.points = v.points + 1
        local x = getbaseinfo(v.actor, 4)
        local y = getbaseinfo(v.actor, 5)
        local in_duquan = false
        -- 判断是否在圈外
        if ChuanQiPuBg.cfg.pubg_type == 1 then
            local dx = (x - ChuanQiPuBg.center_pos.x) * 48
            local dy = (y - ChuanQiPuBg.center_pos.y) * 32
            local distanceSquared = dx * dx + dy * dy
            local tmp_radius = ChuanQiPuBg.cur_radius * 48 + 24
            in_duquan = distanceSquared > tmp_radius * tmp_radius
        else
            if x <= ChuanQiPuBg.start_x or x >= ChuanQiPuBg.end_x or y <= ChuanQiPuBg.start_y or y >= ChuanQiPuBg.end_y then
                in_duquan = true
            end
        end
        if in_duquan then
            local del_hp = getbaseinfo(v.actor, 10) * ((ChuanQiPuBg.pubgUpdateCount + 1) / 10)
            local cur_hp = getbaseinfo(v.actor, 9)
            if cur_hp - del_hp <= 0 then
                ChuanQiPuBg.departure(v)
            else
                humanhp(v.actor, "-", del_hp)
            end            
        end
    end
end

function ChuanQiPuBg.gameOver(reset)
    setenvirofftimer(ChuanQiPuBg.cfg.map_id, ChuanQiPuBg.timer_id)
    ChuanQiPuBg.delPubgEffect()
    for k, v in pairs(ChuanQiPuBg.player_list or {}) do
        ChuanQiPuBg.departure(v)
    end
    if reset then
        ChuanQiPuBg.initData()
    end
    ChuanQiPuBg.end_game = true
end

function ChuanQiPuBg.departure(v)
    mapmove(v.actor, 3 , 330, 330, 5)
    humanhp(v.actor, "=", getbaseinfo(v.actor, 10))
    messagebox(v.actor, "你以离场\\奖励已发放至邮箱, 请及时领取!", "@_on_pubg_callback1", "@_on_pubg_callback2")
    table.insert(ChuanQiPuBg.eliminate_list, v.actor)
    ChuanQiPuBg.player_list[v.actor] = nil
end

function _on_pubg_callback1(actor)
    release_print("_on_pubg_callback1 *** ")
end
function _on_pubg_callback2(actor)
    release_print("_on_pubg_callback2 *** ")
end

-- 获取圆型毒圈最外圈所有坐标点
function ChuanQiPuBg.GetCalculateCirclePoints(x0, y0, r)
    local points = {}
    local x = r
    local y = 0
    local err = 0

    while x >= y do
        -- 添加八个对称的点
        table.insert(points, {x0 + x, y0 + y})
        table.insert(points, {x0 + y, y0 + x})
        table.insert(points, {x0 - y, y0 + x})
        table.insert(points, {x0 - x, y0 + y})
        table.insert(points, {x0 - x, y0 - y})
        table.insert(points, {x0 - y, y0 - x})
        table.insert(points, {x0 + y, y0 - x})
        table.insert(points, {x0 + x, y0 - y})

        if err <= 0 then
            y = y + 1
            err = err + 2*y + 1
        end
        
        if err > 0 then
            x = x - 1
            err = err - 2*x + 1
        end
    end

    return points
end

-- 获取四边形最外圈所有坐标点
function ChuanQiPuBg.GetQuadrilateralPoints(mini_x, max_x, mini_y, max_y)
    local points = {}
    local row = {mini_y, max_y}
    local col = {mini_x, max_x}
    for i = mini_x, max_x do
        for k, v in pairs(row) do
            table.insert(points, {i, v})
        end
    end
    for j = mini_y, max_y do
        for k, v in pairs(col) do
            table.insert(points, {v, j})
        end
    end

    return points
end


