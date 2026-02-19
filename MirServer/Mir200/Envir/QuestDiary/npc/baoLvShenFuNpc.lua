local baoLvShenFuNpc = {}
baoLvShenFuNpc.cfg = {
    [50659] = {
        index = 1,
        name = "爆率神符1.3倍",
        weight = 900
    },
    [50660] = {
        index = 2,
        name = "爆率神符1.4倍",
        weight = 800
    },
    [50661] = {
        index = 3,
        name = "爆率神符1.5倍",
        weight = 700
    },
    [50662] = {
        index = 4,
        name = "爆率神符1.6倍",
        weight = 600
    },
    [50663] = {
        index = 5,
        name = "爆率神符1.7倍",
        weight = 500
    },
    [50664] = {
        index = 6,
        name = "爆率神符1.8倍",
        weight = 400
    },
    [50665] = {
        index = 7,
        name = "爆率神符1.9倍",
        weight = 300
    },
    [50666] = {
        index = 8,
        name = "爆率神符2.0倍",
        weight = 200
    },
    [50667] = {
        index = 9,
        name = "爆率神符·尊",
        weight = 100
    }
}
baoLvShenFuNpc.ui_items = {50659,50660,50661,50662,50663,50664,50665,50666,50667}
baoLvShenFuNpc.reward_item = {}

function baoLvShenFuNpc:click(actor)
    self.lf_open = VarApi.getPlayerJIntVar(actor, "J_lf_open_count")
    self.remain_time = VarApi.getPlayerJIntVar(actor, "J_mf_open_time") - os.time()
    if self.remain_time < 0 then
        self.remain_time = 0
    end
    lualib:ShowNpcUi(actor, "BaoLvSFOBJ", tbl2json(self.ui_items).."#"..self.lf_open.."#"..self.remain_time)
end

function baoLvShenFuNpc:onClickStartBtn(actor, type)
    local reward = weightedRandom(self.cfg)
    if not reward then
        return
    end
    self.lf_open = VarApi.getPlayerJIntVar(actor, "J_lf_open_count")
    local equip = getiteminfo(actor, linkbodyitem(actor, 15), 2)
    if equip == 50667 then           -- 已经佩戴了尊及以上就不能再摇了
        if VarApi.getPlayerUIntVar(actor, "U_navigation_task_step") == 7 then
            newcompletetask(actor, 107)
            local node_str = [[
                <Layout|x=270|y=10|width=50|height=80|link=@close_btn_and_openview>
                <Effect|effectid=27583|effecttype=0|scale=0.6|x=290|y=30>
                <Button|x=270|y=60|nimg=custom/npc/12bl/shenfu.png|width=68|height=21>
                <COUNTDOWN|x=305|a=4|y=85|time=1800|count=1|size=16|color=250|showWay=1>
            ]]
            addbutton(actor, 101, 10000, node_str)
        end        
        local str = "已佩戴至尊神符!"
        return Sendmsg9(actor, "ffffff", str, 1)
    end
    -- 灵符开启
    if type == "1" then
        local money = querymoney(actor, 7)
        if money < 66 then
            local str = "灵符数量不足!"
            return Sendmsg9(actor, "ffffff", str, 1)
        end
        self.lf_open = self.lf_open + 1
        if not changemoney(actor, 7, "-", 66, "灵符扣除",true) then
            return Sendmsg9(actor, "ff0000", "灵符扣除失败！", 1)
        end
        VarApi.setPlayerJIntVar(actor, "J_lf_open_count",  self.lf_open)
        if self.lf_open >= 3 then
            reward = self.cfg[50667]
        else
            reward = self.cfg[50666]
        end
    else    -- 免费开启
        local last_open_time = VarApi.getPlayerJIntVar(actor, "J_mf_open_time")
        if last_open_time == 0 or os.time() > last_open_time then
            VarApi.setPlayerJIntVar(actor, "J_mf_open_time", os.time() + 1800)
        else
            return Sendmsg9(actor, "ffffff", "转盘冷却中, 请稍后再来！", 1)
        end
        self.remain_time = 1800
    end

    if reward then
        lualib:FlushNpcUi(actor, "BaoLvSFOBJ", reward.index.."#"..(self.lf_open).."#"..self.remain_time)

        setontimer(actor, 123, 2, 1)
        self.reward_item[actor] = reward
        if VarApi.getPlayerUIntVar(actor, "U_navigation_task_step") == 7 then
            newcompletetask(actor, 107)
            local node_str = [[
                <Layout|x=270|y=10|width=50|height=80|link=@close_btn_and_openview>
                <Effect|effectid=27583|effecttype=0|scale=0.6|x=290|y=30>
                <Button|x=270|y=60|nimg=custom/npc/12bl/shenfu.png|width=68|height=21>
                <COUNTDOWN|x=305|a=4|y=85|time=1800|count=1|size=16|color=250|showWay=1>
            ]]
            addbutton(actor, 101, 10000, node_str)
        end
    end
end
function close_btn_and_openview(actor)
    delbutton(actor, 101, 10000)
    baoLvShenFuNpc:click(actor)
end

function ontimer123(actor)
    local reward = baoLvShenFuNpc.reward_item[actor]
    if reward then
        delbodyitem(actor, 15, "___扣除神符")
        giveonitem(actor, 15, reward.name, 1,307)
        local equip = linkbodyitem(actor, 15)
        setthrowitemly2(actor, equip, tbl2json({["source"] = 2, ["player"] = getbaseinfo(actor, 1), ["time"] = os.time()}))
    end
    baoLvShenFuNpc.reward_item[actor] = nil
end

return baoLvShenFuNpc
