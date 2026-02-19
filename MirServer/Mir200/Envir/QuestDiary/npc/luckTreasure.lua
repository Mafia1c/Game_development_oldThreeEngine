local luckTreasure = {}
luckTreasure.cfg1 = {["0"]={"屠尽天下又何妨(称号)",1,"圣诞天使(限时装扮)",1,},["1"]={"宝石碎片",888,"步步高升(足迹)",1,},
["2"]={"卧龙钥匙",10,"一路长虹(限定魂环)",1,},["3"]={"十转凭证",10,"小恶魔(时装精灵)",1,},["4"]={"龙神石",10,"洛丽塔(女仆)",1,},} --#region 每日奖励轮换
luckTreasure.cfg11 = {
    [46]={{"头颅根骨",2},{"身躯根骨",2},{"左臂根骨",2},{"左手根骨",2},{"右臂根骨",2},{"右手根骨",2},{"左腿根骨",2},{"左脚根骨",2},{"右腿根骨",2},{"右脚根骨",2},},
    [7]={{"十转凭证",2}}, [4]={{"金刚石",1900},{"龙之心",3},{"龙之血",3},},
    [3]={{"灵符",190},{"声望",200},{"龙神石",1},{"觉醒宝石",1},{"连环明珠",1},{"暗黑水晶",1},{"灵魂水晶",1},{"魔界残魂",1},{"帝王之心",1},},
    [2]={{"启运(福)",1},{"耕耘(福)",1},{"驱邪(福)",1},{"捣药(福)",1},{"赐福(福)",1},{"蜕厄(福)",1},{"奔腾(福)",1},{"护生(福)",1},{"闹春(福)",1},{"报喜(福)",1},{"守岁(福)",1},{"纳福(福)",1},},
    [1]={{"圣诞天使(限时装扮)",1},{"屠尽天下又何妨(称号)",1},{"头号玩家(称号)",1},{"劳动先锋(限定装扮)",1},{"全服最靓的仔(称号)",1},{"龙神坐骑(限定装扮)",1}}
}
--1 今天开启次数 累计开启次数 每日领取一次 2 排行 今日积分 累计积分 
-- local tab = {
--     [1] = {["actorName"] = "玩家",["allPoint"]=100,},
-- }

function luckTreasure:cilck(actor,...)
    -- local rank_list = self:getRankListData()
    -- local sMsg = tbl2json(rank_list)
    -- lualib:ShowNpcUi(actor, "luckTreasureOBJ", sMsg)
end
function luckTreasure:getRankListData() --#region 获得积分排行榜
    local rank_list = {}
    local str = getsysvar(VarEngine.luckTreasure)
    rank_list = json2tbl(str)
    return rank_list
end

function luckTreasure:todayGet(actor) --#region 特权每日领取
    local temp = VarApi.getPlayerUIntVar(actor,VarIntDef.ZSTQ_LEVEL)
    local time = VarApi.getPlayerJIntVar(actor,"JL_treasureOne")
    if temp < 1 then
        return Sendmsg9(actor, "ff0000", "角色当前并未开通终身特权！", 1)
    end
    if time > 0 then
        return Sendmsg9(actor, "ff0000", "角色今日已领取过祥瑞钥匙(福利)！", 1)
    end
    VarApi.setPlayerJIntVar(actor,"JL_treasureOne",time+1,true)
    giveitem(actor,"祥瑞钥匙(福利)",1,307,"祥瑞宝藏特权领取钥匙")
end
function luckTreasure:goMap1(actor,...) --#region 祥瑞宝阁
    local time = getsysvar(VarEngine.HeFuCount) --#region 合服次数
    local number = VarApi.getPlayerJIntVar(actor,"JL_treasureOpen") --#region 今天开启次数
    local allNumber = VarApi.getPlayerUIntVar(actor,"UL_treasureOpenAll") --#region 累计开启次数
    if number < 5 then
        return Sendmsg9(actor, "ff0000", "今日祥瑞宝藏开启次数不足5次！", 1)
    end
    if time >=4 then
        map(actor,"祥瑞宝阁4")
    else
        map(actor,"祥瑞宝阁"..time)
    end
    lualib:CloseNpcUi(actor, "luckTreasureOBJ")
end
function luckTreasure:goMap2(actor,...) --#region 祥瑞迷宫(跨服待加)
    local todayPoint = VarApi.getPlayerJIntVar(actor,"JL_treasureTodayPoint") --#region 今日积分
    if todayPoint < 20 then
        return Sendmsg9(actor, "ff0000", "今日宝箱积分不足20,暂不能进入！", 1)
    end
    local number = getsysvar(VarEngine.HeFuCount) --#region 合服次数
    if number == 0 then
        map(actor,"祥瑞迷宫新区")
        lualib:CloseNpcUi(actor, "luckTreasureOBJ")
        self:refreshTask(actor) --#region 刷新任务面板
    else
        if checkkuafuconnect() then
            KuaFuTrigger.bfbackcall(actor, "call_buff")
            map(actor,"祥瑞迷宫合区")
            lualib:CloseNpcUi(actor, "luckTreasureOBJ")
            Sendmsg9(actor, "ff0000", "成功连接至跨服地图祥瑞迷宫！", 1)
        else
            return Sendmsg9(actor, "ff0000", "跨服未连接，等待开放！", 1)
        end
    end
end

function luckTreasure:refreshTask(actor) --#region 刷新祥瑞迷宫新区任务面板
    local mon_list = {"子鼠启运兽", "丑牛耕耘兽", "寅虎驱邪兽", "卯兔捣药兽", "辰龙赐福兽", "巳蛇蜕厄兽","午马奔腾兽","未羊护生兽","申猴闹春兽","酉鸡报喜兽","戌狗守岁兽","亥猪纳福兽",}
    local infoList = {}
    for index, value in ipairs(mon_list) do
        if getmoncount("祥瑞迷宫新区", getdbmonfieldvalue(value, "idx"), true) > 0 then
            table.insert(infoList, "<已刷新/FCOLOR=250>")
        else
            table.insert(infoList, "<已阵亡/FCOLOR=249>")
        end
    end
    delbutton(actor, 110, "_123456")
    local info = [[
        <Text|x=50.0|y=10.0|color=243|size=16|text=《祥瑞迷宫》>
        <Text|x=2.0|y=34.0|color=250|size=16|text=BOSS存活状态(可下滑查看)>
        <ListView|children={2,3,4,5,6,7,8,9,10,11,12,13}|x=36|y=60|width=220|height=120|direction=1|bounce=1|margin=2|reload=1>
        <RText|id=2|x=0.0|y=0.0|color=250|size=16|text=<子鼠启运兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=3|x=0.0|y=0.0|color=250|size=16|text=<丑牛耕耘兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=4|x=0.0|y=0.0|color=250|size=16|text=<寅虎驱邪兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=5|x=0.0|y=0.0|color=250|size=16|text=<寅虎驱邪兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=6|x=0.0|y=0.0|color=250|size=16|text=<辰龙赐福兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=7|x=0.0|y=0.0|color=250|size=16|text=<巳蛇蜕厄兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=8|x=0.0|y=0.0|color=250|size=16|text=<午马奔腾兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=9|x=0.0|y=0.0|color=250|size=16|text=<未羊护生兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=10|x=0.0|y=0.0|color=250|size=16|text=<申猴闹春兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=11|x=0.0|y=0.0|color=250|size=16|text=<申猴闹春兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=12|x=0.0|y=0.0|color=250|size=16|text=<申猴闹春兽/FCOLOR=253><-/FCOLOR=250>%s>
        <RText|id=13|x=0.0|y=0.0|color=250|size=16|text=<亥猪纳福兽/FCOLOR=253><-/FCOLOR=250>%s>
    ]]
    info = string.format(info, infoList[1], infoList[2], infoList[3], infoList[4], infoList[5], infoList[6], infoList[7], infoList[8], infoList[9], infoList[10], infoList[11], infoList[12])
    addbutton(actor, 110, "_123456", info)
end

function luckTreasure:recycle(actor,...) --#region 回收饰品
    local param = {...}
    local index = tonumber(param[1])
    local itemName = getstditeminfo(index+51043,1)
    if 1 > getbagitemcount(actor, itemName) then
        return Sendmsg9(actor, "ff0000", "当前背包"..itemName.."物品不足！", 1)
    end
    if not takeitem(actor, itemName, 1, 0, "祥瑞宝藏回收"..itemName) then
        return Sendmsg9(actor, "ff0000", "祥瑞钥匙回收"..itemName.."扣除失败！", 1)
    end
    changemoney(actor,getstditeminfo("金刚石",0),"+",20000,"祥瑞宝藏回收"..itemName,true)
end
function luckTreasure:buyEvent1(actor,...) --#region 雨水礼包瑞彩缤纷炮(充值19)
    local param = {...}
    local time = tonumber(param[1]) --#region 次数
    if not isInTable({1,10,100},time) then
        return Sendmsg9(actor, "ff0000", "购买次数异常！", 1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_yslb",time,"luckTreasureOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end
function luckTreasure:buyEvent2(actor,...) --#region 春分礼包喜乐年华炮(充值19)
    local param = {...}
    local time = tonumber(param[1]) --#region 次数
    if not isInTable({1,10,100},time) then
        return Sendmsg9(actor, "ff0000", "购买次数异常！", 1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_cflb",time,"luckTreasureOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end
function luckTreasure:buyEvent3(actor,...) --#region 谷雨礼包瑞彩缤纷(充值19)
    local param = {...}
    local time = tonumber(param[1]) --#region 次数
    if not isInTable({1,10,100},time) then
        return Sendmsg9(actor, "ff0000", "购买次数异常！", 1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_yglb",time,"luckTreasureOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end
function luckTreasure:sellEvent1(actor,...)--#region 新春祥瑞(元宝买烟花)
    if 1000000 > getbindmoney(actor, "元宝") then
        return Sendmsg9(actor, "ff0000", "当前元宝不足100万！", 1)
    end
    if not consumebindmoney(actor, "元宝", 1000000, "新春祥瑞元宝扣除") then
        return Sendmsg9(actor, "ff0000", "新春祥瑞元宝扣除失败！", 1)
    end
    Sendmsg9(actor, "00FF00", "恭喜您成功购买获得祥龙贺岁炮！", 1)
    giveitem(actor, "祥龙贺岁炮", 1, 307, "新春祥瑞元宝获得")
end
function luckTreasure:sellEvent2(actor,...)--#region 新春祥瑞(灵符买烟花)
    if 100 > getbindmoney(actor, "灵符") then
        return Sendmsg9(actor, "ff0000", "当前灵符不足100！", 1)
    end
    if not consumebindmoney(actor, "灵符", 100, "新春祥瑞灵符扣除") then
        return Sendmsg9(actor, "ff0000", "新春祥瑞灵符扣除失败！", 1)
    end
    Sendmsg9(actor, "00FF00", "恭喜您成功购买获得福运连年炮！", 1)
    giveitem(actor, "福运连年炮", 1, 307, "新春祥瑞灵符获得")
end


----------------------------------------------------------------------------------------- --#region开宝箱和积分排行榜相关
function luckTreasure:open1(actor) --#region 打开祥瑞1次
    local rand = math.random(63)
    if 1 <= getbagitemcount(actor, "祥瑞钥匙(福利)") then
        if not takeitem(actor,"祥瑞钥匙(福利)",1,0,"祥瑞钥匙(福利)开宝箱1") then
            return Sendmsg9(actor, "ff0000", "祥瑞钥匙(福利)开宝箱1次扣除失败！", 1)
        end
        local list = self:giveOne(actor,rand)
        for index, value in ipairs(self:boxEvent(actor,1,0)) do
            table.insert(list,value)
        end
        lualib:ShowAwardTipUi(actor,list)
        lualib:FlushNpcUi(actor,"luckTreasureOBJ", "开宝箱")
        return
    end
    if 1 <= getbagitemcount(actor, "祥瑞钥匙") then
        if not takeitem(actor,"祥瑞钥匙",1,0,"祥瑞钥匙开宝箱1") then
            return Sendmsg9(actor, "ff0000", "祥瑞钥匙开宝箱1次扣除失败！", 1)
        end
        local list = self:giveOne(actor,rand)
        for index, value in ipairs(self:boxEvent(actor,1,1)) do
            table.insert(list,value)
        end
        lualib:ShowAwardTipUi(actor,list)
        lualib:FlushNpcUi(actor,"luckTreasureOBJ", "开宝箱")
        return
    end
    Sendmsg9(actor, "ff0000", "当前背包中祥瑞钥匙和祥瑞钥匙(福利)都不足1！", 1)
end
function luckTreasure:open10(actor) --#region 打开祥瑞10次
    if 10 > getbagitemcount(actor, "祥瑞钥匙") then
        return Sendmsg9(actor, "ff0000", "当前背包中祥瑞钥匙不足10个！", 1)
    end
    if not takeitem(actor, "祥瑞钥匙", 10, 0, "祥瑞钥匙开宝箱10") then
        return Sendmsg9(actor, "ff0000", "祥瑞钥匙开宝箱10次扣除失败！", 1)
    end
    local list = {}
    for i = 1, 10 do
        local rand = math.random(63)
        table.insert(list,self:giveOne(actor,rand)[1])
    end
    for index, value in ipairs(self:boxEvent(actor, 10, 1)) do
        table.insert(list, value)
    end
    lualib:ShowAwardTipUi(actor, list)
    lualib:FlushNpcUi(actor,"luckTreasureOBJ", "开宝箱")
end
function luckTreasure:giveOne(actor,number) --#region 开宝箱给物品
    local list = {}
    if not number then
        return Sendmsg9(actor, "ff0000", "开宝箱给物品异常！", 1)
    end
    -- release_print(number)
    local function giveItemFun(index) --#region 给物品
        local rand = math.random(#self.cfg11[index])
        local itemId = getstditeminfo(self.cfg11[index][rand][1],0)
        if itemId < 10000 then
            changemoney(actor,itemId,"+",self.cfg11[index][rand][2],"祥瑞宝箱概率"..index.."得货币",true)
        else
            giveitem(actor,self.cfg11[index][rand][1],self.cfg11[index][rand][2],307,"祥瑞宝箱概率"..index.."得物品")
        end
        table.insert(list,{name = self.cfg11[index][rand][1],count =self.cfg11[index][rand][2]})
    end
    if number <= 46 then
        giveItemFun(46) --#region 头颅根骨等
    elseif number <= 53 then
        giveItemFun(7) --#region 十转凭证
    elseif number <= 57 then
        giveItemFun(4) --#region 金刚石等
    elseif number <= 60 then
        giveItemFun(3) --#region 灵符等
    elseif number <= 62 then
        giveItemFun(2) --#region 各种福
    elseif number <= 63 then
        giveItemFun(1) --#region 各种称号等
    else
        return Sendmsg9(actor, "ff0000", "当前宝箱开出物品异常！", 1)
    end

    return list
end
--#region 开宝箱后事件[开启数量,次数给物品,积分变化,积分给物品][[打开次数，是否高级钥匙]]
function luckTreasure:boxEvent(actor,openTime,tag)
    local username = getbaseinfo(actor,1) --#region 玩家名称
    local list = {} --#region 奖励物品
    local todayTime = VarApi.getPlayerJIntVar(actor,"JL_treasureOpen") --#region 今天开启次数
    local allTime = VarApi.getPlayerUIntVar(actor,"UL_treasureOpenAll") --#region 累计开启次数
    local todayPoint = VarApi.getPlayerJIntVar(actor,"JL_treasureTodayPoint") --#region 今日积分
    local allPoint = VarApi.getPlayerUIntVar(actor,"UL_treasureAllPoint") --#region 累计积分
    VarApi.setPlayerJIntVar(actor,"JL_treasureOpen",todayTime+openTime,true)
    VarApi.setPlayerUIntVar(actor,"UL_treasureOpenAll",allTime+openTime,true)
    if allTime < 99 and allTime+openTime >= 99 then --#region 累计开启99奖励
        sendmail(getbaseinfo(actor, 2), 1, "祥瑞宝箱", "恭喜大佬累计祥瑞宝藏开启次数达到99\\宝藏奖励已发送，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！"
        , "龙神坐骑(限定装扮)#1#307")
        sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【祥瑞宝藏累计99次奖励】/FCOLOR=249}！您也想获得赶快来开启吧！", 1, 3)
        table.insert(list,{name = "龙神坐骑(限定装扮)",count =1})
    end
    if todayTime < 18 and todayTime+openTime >= 18 then --#region 每日必得
        local time = getsysvar(VarEngine.HeFuCount) --#region 合服次数
        time = time%5
        sendmail(getbaseinfo(actor,2),1,"祥瑞宝箱","恭喜您今日开启宝藏次数达到18次\\已获得必得奖励，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！"
        ,self.cfg1[tostring(time)][1].."#"..self.cfg1[tostring(time)][2].."#307")
        sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【祥瑞宝藏今日18次奖励】/FCOLOR=249}！您也想获得赶快来开启吧！", 1, 3)
        table.insert(list,{name = self.cfg1[tostring(time)][1],count =self.cfg1[tostring(time)][2]})
    elseif todayTime < 58 and todayTime+openTime >= 58 then
        local time = getsysvar(VarEngine.HeFuCount) --#region 合服次数
        time = time%5
        sendmail(getbaseinfo(actor,2),1,"祥瑞宝箱","恭喜您今日开启宝藏次数达到58次\\已获得必得奖励，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！"
        ,self.cfg1[tostring(time)][3].."#"..self.cfg1[tostring(time)][4].."#307")
        sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【祥瑞宝藏今日58次奖励】/FCOLOR=249}！您也想获得赶快来开启吧！", 1, 3)
        table.insert(list,{name = self.cfg1[tostring(time)][3],count =self.cfg1[tostring(time)][4]})
    end
    if tag == 1 then --#region 为祥瑞宝藏打开
        VarApi.setPlayerJIntVar(actor,"JL_treasureTodayPoint",todayPoint+openTime*10,true)
        VarApi.setPlayerUIntVar(actor,"UL_treasureAllPoint",allPoint+openTime*10,true)
        if todayPoint < 50 and todayPoint+openTime*10 >= 50 then --#region 每日积分奖励
            sendmail(getbaseinfo(actor, 2), 1, "宝藏奖励", "恭喜大佬今日祥瑞积分达到50\\宝藏奖励已发送，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！"
            , "绑定金刚石#50000#307")
            table.insert(list,{name = "绑定金刚石",count =50000})
        elseif todayPoint < 200 and todayPoint+openTime*10 >= 200 then
            sendmail(getbaseinfo(actor, 2), 1, "宝藏奖励", "恭喜大佬今日祥瑞积分达到200\\宝藏奖励已发送，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！"
            , "绑定金刚石#200000#307")
            table.insert(list,{name = "绑定金刚石",count =200000})
        end
        if allPoint < 580 and allPoint+openTime*10 >= 580 then --#region 累计积分奖励
            sendmail(getbaseinfo(actor, 2), 1, "宝藏奖励", "恭喜大佬累计祥瑞积分达到580\\宝藏奖励已发送，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！"
            , "斩断红尘多情客(称号)#1#307")
            table.insert(list,{name = "斩断红尘多情客(称号)",count =1})
        elseif allPoint < 1280 and allPoint+openTime*10 >= 1280 then
            sendmail(getbaseinfo(actor, 2), 1, "宝藏奖励", "恭喜大佬累计祥瑞积分达到1280\\宝藏奖励已发送，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！"
            , "九霄风云齐聚会(称号)#1#307")
            table.insert(list,{name = "九霄风云齐聚会(称号)",count =1})
        elseif allPoint < 1880 and allPoint+openTime*10 >= 1880 then
            sendmail(getbaseinfo(actor, 2), 1, "宝藏奖励", "恭喜大佬累计祥瑞积分达到1880\\宝藏奖励已发送，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！"
            , "神念一现死一片(称号)#1#307")
            table.insert(list,{name = "神念一现死一片(称号)",count =1})
        end
        self:rankList(actor,allPoint,allPoint+openTime*10)
    end
    return list
end
function luckTreasure:rankList(actor,point1,point2) --#region 积分排行榜(增加前积分,增加后积分)
    self.nowRank = nil --#region 当前玩家排名
    local userName = getbaseinfo(actor,1) --#region 玩家名称
    local rank_list = self:getRankListData() --#region 积分排行榜
    if point2 < 588 then
        sendmsgnew(actor,255,255,"祥瑞宝藏：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功开启祥瑞"
        .."获得豪华奖励，属性大幅提升，全服顶礼膜拜！",1,8)
        return
    end

    if rank_list == "" then rank_list = {} end
    local inTable = false
    for index, value in ipairs(rank_list) do --#region 当前在表中替换数量
        if value["actorName"] == userName then
            value["allPoint"] = point2
            inTable = true
            break
        end
    end
    if not inTable then --#region 不在表中
        rank_list[#rank_list+1] ={["actorName"]=userName,["allPoint"] = point2}
    end
    table.sort(rank_list,function(a,b)
		if a.allPoint > b.allPoint then
			return true
		end
		return false
	end)
    for index, value in ipairs(rank_list) do
        if index > 5 then
            table.remove(rank_list,index)
        end
    end

    local str = tbl2json(rank_list)
    setsysvar(VarEngine.luckTreasure, str)
    self:otherTitle(actor)
    sendmsgnew(actor,255,255,"祥瑞宝藏：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功开启祥瑞"
    .."获得豪华奖励，属性大幅提升，全服顶礼膜拜！",1,8)
    lualib:FlushNpcUi(actor,"luckTreasureOBJ", "积分榜#"..str)
end
function luckTreasure:otherTitle(actor) --#region 积分排行榜称号更改(不在线玩家下次登陆触发)
    local titleTab = {"至尊魂环","荣耀魂环","王者魂环",}
    local rank_list = self:getRankListData() --#region 捐献表
    if rank_list == "" then rank_list = {} end
    for index, value in ipairs(rank_list or {}) do --#region 在排行榜中(对排行榜操作)
        if index <=3 and getplayerbyname(value["actorName"]) and not checktitle(getplayerbyname(value["actorName"]),titleTab[index]) then
            for i, v in ipairs(titleTab) do
                deprivetitle(getplayerbyname(value["actorName"]),v)
                VarApi.setPlayerTStrVar(getplayerbyname(value["actorName"]),VarStrDef.ICON_2,"",true)
                seticon(getplayerbyname(value["actorName"]),2,-1)
            end
            confertitle(getplayerbyname(value["actorName"]),titleTab[index],0)
        elseif index > 3 and getplayerbyname(value["actorName"]) then
            for i, v in ipairs(titleTab) do
                deprivetitle(getplayerbyname(value["actorName"]),v)
                VarApi.setPlayerTStrVar(getplayerbyname(value["actorName"]),VarStrDef.ICON_2,"",true)
                seticon(getplayerbyname(value["actorName"]),2,-1)
            end
        end
    end
    for index, value in ipairs(rank_list or {}) do --#region 传入不在排行榜中(对自己操作，排行榜有数据)
        if getbaseinfo(actor, 1) == value["actorName"] then
            break
        elseif actor and index == #rank_list then
            for i, v in ipairs(titleTab) do
                deprivetitle(actor, v)
                VarApi.setPlayerTStrVar(actor,VarStrDef.ICON_2,"",true)
                seticon(actor,2,-1)
            end
        end
    end
    if next(rank_list) == nil then --#region 没有排行榜数据(清除称号)
        for i, v in ipairs(titleTab) do
            deprivetitle(actor, v)
            VarApi.setPlayerTStrVar(actor,VarStrDef.ICON_2,"",true)
            seticon(actor,2,-1)
        end
    end
end

return luckTreasure