local disguiseMap = {}
disguiseMap.cfg = {
    { {"幽影魔主·紫烬","金辉神骏(限定装扮)"},{"炽焰神将·燎天","耀金战骑(限定装扮)"},{"黯狱魔将·烬芒","独孤求败(称号)"},{"炽阳灵主·炎裳","盖世英雄(称号)"},{"战令*1","金刚石","声望","时装碎片"},{"sss111",50,54},{100,100,100,1}},
    { {"幽影魔主·紫烬1","暗金烈骑(限定装扮)"},{"炽焰神将·燎天1","苍云神骑(限定装扮)"},{"黯狱魔将·烬芒1","热血同行(称号)"},{"炽阳灵主·炎裳1","十步一殺(称号)"},{"战令*1","金刚石","声望","时装碎片"},{"sss112",50,54},{100,100,100,1}},
    { {"幽影魔主·紫烬2","霜华仙骑(限定装扮)"},{"炽焰神将·燎天2","晶蓝圣骑(限定装扮)"},{"黯狱魔将·烬芒2","唯我独有(称号)"},{"炽阳灵主·炎裳2","雪山孤剑鸣(称号)"},{"战令*1","金刚石","声望","时装碎片"},{"sss113",50,54},{100,100,100,1}},
    { {"幽影魔主·紫烬3","翠影灵骑(限定装扮)"},{"炽焰神将·燎天3","赤焰魔骑(限定装扮)"},{"黯狱魔将·烬芒3","一刀一个小朋友(称号)"},{"炽阳灵主·炎裳3","一骑当千(称号)"},{"战令*1","金刚石","声望","时装碎片"},{"sss114",50,54},{100,100,100,1}},
}

function disguiseMap:getTime(actor,page) --#region (去跨服请求boss时间)
    local user_id = getbaseinfo(actor, 2)
    bfbackcall(99, "0", "get_zb_boss_time|sss11"..page,user_id)
    lualib:ShowNpcUi(actor, "disguiseMapOBJ", "")
end
function disguiseMap:openEvent(actor,page) --#region 点击打开界面
    page = tonumber(page)
    if type(page)~="number" or not self.cfg[page] then
        return Sendmsg9(actor, "ff0000",  "当前地图层数异常" , 1)
    elseif not checkkuafuconnect() then
        return Sendmsg9(actor, "ff0000",  "当前跨服并未开启！" , 1)
    end
    lualib:CloseNpcUi(actor, "CrossShopObj")
    self:getTime(actor,page)
end
function disguiseMap:flushBossInfo(actor,boss_info) --#region 收到跨服时间刷新前端
    lualib:FlushNpcUi(actor,"disguiseMapOBJ","time#"..boss_info)
end

function disguiseMap:gotoMap(actor,page) --#region 传送地图
    page = tonumber(page)
    if type(page)~="number" or not self.cfg[page] then
        return Sendmsg9(actor, "ff0000",  "当前地图层数异常" , 1)
    elseif not checkkuafuconnect() then
        return Sendmsg9(actor, "ff0000",  "当前跨服并未开启！" , 1)
    elseif getbaseinfo(actor,36)=="" then
        return Sendmsg9(actor, "ff0000",  "请先加入行会再来进入！" , 1)
    end
    -- local level = getbaseinfo(actor,6)
    -- if level < 60 then
    --     return Sendmsg9(actor, "ffffff", "等级不足", 1) 
    -- end 

    -- local zs_level = getbaseinfo(actor,39)
    -- if zs_level < 4 then
    --     return Sendmsg9(actor, "ffffff", "转生等级不足", 1) 
    -- end 
    -- local kuangbao = VarApi.getPlayerUIntVar(actor, VarIntDef.KB_LEVEL)
    -- if kuangbao == 0 then
    --     Sendmsg9(actor,"ffffff","未开启狂暴!",1)
    --     return
    -- end
    local time = VarApi.getPlayerJIntVar(actor,"J_disguiseMapTime")
    if time >=6 then
        return Sendmsg9(actor, "ff0000",  "今日挑战次数用尽！" , 1)
    end
    if page==2 and VarApi.getPlayerUIntVar(actor,"U_bigMap"..page)==0 then
        return Sendmsg9(actor, "ff0000",  "请先前往一次封魔神谷！" , 1)
    elseif page==3 and VarApi.getPlayerUIntVar(actor,"U_bigMap"..page)==0 then
        return Sendmsg9(actor, "ff0000",  "请先前往一次苍月岛！" , 1)
    elseif page==4 and VarApi.getPlayerUIntVar(actor,"U_bigMap"..page)==0 then
        return Sendmsg9(actor, "ff0000",  "请先前往一次魔龙城！" , 1)
    end

    lualib:CloseNpcUi(actor, "disguiseMapOBJ")
    mapmove(actor,self.cfg[page][6][1],self.cfg[page][6][2],self.cfg[page][6][3],3)
end
function disguiseMap:showDisguiseReward(actor)
    local list = {}
    local layer = tonumber(string.sub(getbaseinfo(actor,3), -1))
    for i = 1, 4 do
        local item_id = getstditeminfo(self.cfg[layer][i][2], 0)
        table.insert(list,item_id)
    end
    local info = [[
        <Text|x=30.0|y=10.0|color=243|size=16|text=《%s(跨服)》>
        <Text|x=40.0|y=38.0|color=250|size=16|text=当前地图爆出物品>
        <ItemShow|bgtype=1|x=0|y=55|itemid=%s|showtips=1>
        <ItemShow|bgtype=1|x=65|y=55|itemid=%s|showtips=1>
        <ItemShow|bgtype=1|x=135|y=55|itemid=%s|showtips=1>
        <ItemShow|bgtype=1|x=0|y=120|itemid=%s|showtips=1>
    ]]
    info = string.format(info, "装扮地图",unpack(list))
    addbutton(actor, 110, "_1234568", info)
end
--#region 杀怪触发
-- function disguiseMap:KillMonSendAward(actor,map_id)
--     if not string.find(map_id,"sss11") then return end
--     if not checkkuafu(actor) or not checkkuafuconnect() or not string.find(getbaseinfo(actor,3),"sss11") then
--         return Sendmsg9(actor, "ffffff", "数据异常！", 1) 
--     end
--     local kill_hanghui = getbaseinfo(actor,36)
--     local players = getplaycount(map_id,1,1)
--     for index, player in ipairs(type(players) == "table" and players or {}) do
--         local user_id = getbaseinfo(player,2)
--         local hanghui_name = getbaseinfo(player,36)
--         if kill_hanghui == hanghui_name then
--             local layer = string.sub(map_id, -1)
--             kfbackcall(1,user_id,"disguise_map",layer)
--         end
--     end
-- end

--#region 奖励
-- function disguiseMap:SendKillBossAward(actor,layer)
--     if not checkkuafu(actor) or not checkkuafuconnect() or not string.find(getbaseinfo(actor,3),"sss11") then
--         return Sendmsg9(actor, "ffffff", "数据异常！", 1)
--     end
--     layer = tonumber(layer) 
--     if self.cfg[layer] == nil then
--        return Sendmsg9(actor, "ffffff", "未找到层数配置！", 1) 
--     end
--     local emailItemStr = ""
--     for i = 1, #self.cfg[layer][5] do
--         emailItemStr = emailItemStr.."&"..self.cfg[layer][5][i].."#"..self.cfg[layer][7][i].."#307"
--     end
--     emailItemStr = emailItemStr:sub(2)
--     sendmail(getbaseinfo(actor,2),1,"装扮地图","击杀装扮地图BOSS行会成员奖励",emailItemStr)  
-- end

return disguiseMap