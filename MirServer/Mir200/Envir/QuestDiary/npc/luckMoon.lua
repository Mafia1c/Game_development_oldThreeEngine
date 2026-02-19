local luckMoon = {}
luckMoon.cfg = include("QuestDiary/config/luckMoonPositionCfg.lua")

function luckMoon:buyEvent(actor) --#region 首次购买
    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
    if hasGift == "" then hasGift = {} end
    if hasGift["gift_cycf"] then
        return Sendmsg9(actor, "ff0000", "当前苍月赐福已购买过！", 1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_cycf",1,"luckMoonOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

function luckMoon:buyGift1(actor) --#region 购1次
    local time = VarApi.getPlayerJIntVar(actor,"JL_cycf1")
    if time >= 1 then
        return Sendmsg9(actor,"ff0000","今日苍月赐福1次购买次数已用尽！",1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_cycf1",1,"luckMoonOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

function luckMoon:buyGift10(actor) --#region 购10次
    local time = VarApi.getPlayerJIntVar(actor,"JL_cycf10")
    if time >= 1 then
        return Sendmsg9(actor,"ff0000","今日苍月赐福10次购买次数已用尽！",1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):gift(actor,"gift_cycf1",10,"luckMoonOBJ") --#region 礼包名#次数#前端obj
    else
        Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
    end
end

function luckMoon:goMap1(actor) --#region 前往遗忘禁地
    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
    if hasGift == "" then hasGift = {} end
    if not hasGift["gift_cycf"] then
        return Sendmsg9(actor,"ff0000","您还未激活苍月赐福礼包，无法前往遗忘禁地！",1)
    end
    local positionTab = getsysvar(VarEngine.ywjd_npc)
    if positionTab=="" or not getnpcbyindex(900) then
        delnpc("遗忘禁地","苍月岛")
        local rand = math.random(#self.cfg) --#region 随机坐标key
        local npcInfo = {
            ["Idx"] =  900,  -- 自定义NPC的Idx，NPC点击触发时，触发参数会传回Idx值
            ["npcname"] =  "遗忘禁地", -- NPC名称
            ["appr"] =   2005,  -- NPC外形效果
            ["limit"] = 43200, -- 生命周期 (秒) 引擎64_24.05.23新增
        }
        createnpc("苍月岛",self.cfg[rand]["x"],self.cfg[rand]["y"],tbl2json(npcInfo))
        setsysvar(VarEngine.ywjd_npc,self.cfg[rand]["x"].."#"..self.cfg[rand]["y"])
    end
    positionTab= strsplit(getsysvar(VarEngine.ywjd_npc),"#")
    mapmove(actor,"苍月岛",positionTab[1],positionTab[2],2)
    lualib:CloseNpcUi(actor, "luckMoonOBJ")
end

function luckMoon:goMap2(actor) --#region 前往噩梦之渊
    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_Recharge_hasGift")) --#region 充值过的礼包
    if hasGift == "" then hasGift = {} end
    if not hasGift["gift_cycf"] then
        return Sendmsg9(actor,"ff0000","您还未激活苍月赐福礼包，无法前往噩梦之渊！",1)
    end
    local positionTab = getsysvar(VarEngine.emzy_npc)
    if positionTab=="" or not getnpcbyindex(901) then
        delnpc("噩梦之渊","苍月岛")
        local rand = math.random(#self.cfg) --#region 随机坐标key
        local npcInfo = {
            ["Idx"] =  901,  -- 自定义NPC的Idx，NPC点击触发时，触发参数会传回Idx值
            ["npcname"] =  "噩梦之渊", -- NPC名称
            ["appr"] =   2005,  -- NPC外形效果
            ["limit"] = 43200, -- 生命周期 (秒) 引擎64_24.05.23新增
        }
        createnpc("苍月岛",self.cfg[rand]["x"],self.cfg[rand]["y"],tbl2json(npcInfo))
        setsysvar(VarEngine.emzy_npc,self.cfg[rand]["x"].."#"..self.cfg[rand]["y"])
    end
    positionTab= strsplit(getsysvar(VarEngine.emzy_npc),"#")
    mapmove(actor,"苍月岛",positionTab[1],positionTab[2],2)
    lualib:CloseNpcUi(actor, "luckMoonOBJ")
end


return luckMoon