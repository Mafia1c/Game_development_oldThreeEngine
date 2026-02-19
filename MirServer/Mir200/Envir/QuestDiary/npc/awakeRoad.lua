local awakeRoad = {}
awakeRoad.cfg = include("QuestDiary/config/awakeRoadCfg.lua")
--#region 变量数值表(杀怪数,境界,合成)
local TL_awakeRoad = {
    ["11"]=20,["13"]=5,["14"]=1,["61"]=50,["63"]=1,["64"]=1,
}
local TL_awakeRoadNode = { --#region 是否领取变量
    ["11"]=1,["12"]=1,["13"]=1,["14"]=1,
    ["21"]=1,["22"]=1,["23"]=1,["24"]=1,
}
local TL_awakeRoadPage = { --#region 本章奖励是否领取
    ["1"]=1,["2"]=1,
}
awakeRoad.cfg2 = {
    [2] = "【提示】：\\\\               是否前往完成石墓杀怪*20只！",
    [3] = "【提示】：\\\\               是否前往完成牛魔杀怪*20只！",
    [4] = "【提示】：\\\\               是否前往完成祖玛杀怪*20只！",
    [5] = "【提示】：\\\\               是否前往完成王者禁地杀怪*50只！",
    [6] = "【提示】：\\\\               是否前往完成封魔大殿杀怪*50只！",
    [7] = "【提示】：\\\\               是否前往完成玛雅神殿杀怪*50只！",
    [8] = "【提示】：\\\\               是否前往完成沙藏宝阁杀怪*100只！",
    [9] = "【提示】：\\\\               是否前往完成魔龙领地杀怪*100只！",
    [10] = "【提示】：\\\\              是否前往完成火龙巢穴杀怪*100只！",
    [12] = "【提示】：\\\\              是否前往完成地狱之门杀怪*200只！",
    [13] = "【提示】：\\\\              是否前往完成亡灵古墓杀怪*200只！",
    [14] = "【提示】：\\\\              是否前往完成远古皇陵杀怪*200只！",
    [15] = "【提示】：\\\\              是否前往完成冰霜城堡杀怪*500只！",
    [16] = "【提示】：\\\\              是否前往完成末日遗迹杀怪*500只！",
    [17] = "【提示】：\\\\              是否前往完成巫妖森林杀怪*500只！",
    [18] = "【提示】：\\\\              是否前往完成法老沼泽杀怪*500只！",
    [19] = "【提示】：\\\\              是否前往完成迷失神庙杀怪*500只！",
    [20] = "【提示】：\\\\              是否前往完成鬼泣沙漠杀怪*500只！",
    [60] = "【提示】：\\\\              是否前往完成时空裂缝杀怪*1000只！",
    [102] = "【提示】：\\\\             是否前往完成(五行之力)强化！",
    [101] = "【提示】：\\\\             是否前往完成(特殊四格)合成！",
    [105] = "【提示】：\\\\             是否前往完成人物转生提升！",
    [104] = "【提示】：\\\\             是否前往完成(宗师境界)提升！",
}

function awakeRoad:rewardNode(actor,...) --#region 领取目标奖励
    local param = {...}
    local leftIndex = tonumber(param[1]) --#region 左侧index
    local boxIndex = tonumber(param[2]) --#region 目标index
    local hastab = json2tbl(VarApi.getPlayerTStrVar(actor,"TL_awakeRoadNode"))--#region 是否领取变量
    if hastab == "" then;hastab = {} end
    local tab1 = json2tbl(VarApi.getPlayerTStrVar(actor,"TL_awakeRoad"))--#region 变量存储
    if tab1 == "" then;tab1 = {} end
    if hastab[param[1]..param[2]] then
        return Sendmsg9(actor,"ff0000","当前节点任务奖励已领取过！",1)
    end
    local typeTab = {
        [1] = function () --#region 目标1
            if (tab1[param[1].."1"] or 0) < self.cfg[leftIndex]["number_arr1"][1] then
                self:createBox(actor,leftIndex,boxIndex)
                return true
            end
            return false
        end,
        [2] = function () --#region 目标2
            if getbaseinfo(actor, 6) < self.cfg[leftIndex]["number_arr1"][2] then
                Sendmsg9(actor, "ff0000", "当前角色等级不足" .. self.cfg[leftIndex]["number_arr1"][1] .. "！", 1)
                return true
            end
            return false
        end,
        [3] = function () --#region 目标3
            if self.cfg[leftIndex]["number_arr2"][1] == "五行" then
                if not tab1[param[1].."3"] then
                    self:createBox(actor,leftIndex,boxIndex)
                    return true
                end
            elseif self.cfg[leftIndex]["number_arr2"][1] == "转生" then
                if getbaseinfo(actor,39) < self.cfg[leftIndex]["number_arr2"][2] then
                    self:createBox(actor,leftIndex,boxIndex)
                    return true
                end
            elseif self.cfg[leftIndex]["number_arr2"][1] == "宗师" then
                local layer = VarApi.getPlayerUIntVar(actor, "l_masterLayer")--#region 当前宗师境界
                if layer < self.cfg[leftIndex]["number_arr2"][2] then
                    self:createBox(actor,leftIndex,boxIndex)
                    return true
                end
            end
            return false
        end,
        [4]= function () --#region 目标4
            if self.cfg[leftIndex]["number_arr2"][3] == "变量" then
                if not tab1[param[1].."4"] then
                    self:createBox(actor,leftIndex,boxIndex)
                    return true
                end
            else
                if getbagitemcount(actor,self.cfg[leftIndex]["number_arr2"][3]) < self.cfg[leftIndex]["number_arr2"][4] then
                    Sendmsg9(actor, "ff0000", "当前背包"..self.cfg[leftIndex]["number_arr2"][3].."不足"..self.cfg[leftIndex]["number_arr2"][4].."！", 1)
                    return true
                end
            end
            return false
        end,
    }
    if typeTab[boxIndex]() then
        return
    end

    if boxIndex <= 2 then
        for key, value in pairs(self.cfg[leftIndex]["award_config1"][boxIndex]) do
            changemoney(actor,getstditeminfo(key,0),"+",value,"觉醒之路给货币",true)
        end
    else
        for key, value in pairs(self.cfg[leftIndex]["award_config1"][boxIndex]) do
            giveitem(actor,key,value,307,"觉醒之路给物品")
        end
    end
    hastab[param[1]..param[2]] = 1
    hastab = tbl2json(hastab)
    VarApi.setPlayerTStrVar(actor,"TL_awakeRoadNode",hastab,true)
    lualib:FlushNpcUi(actor, "awakeRoadOBJ", "节点#"..boxIndex)
end

function awakeRoad:createBox(actor,leftIndex,boxIndex) --#region 打开前往box
    local npcId = self.cfg[leftIndex]["npcId_arr"][boxIndex]
    VarApi.setPlayerUIntVar(actor,"U_awake_road_npcId",npcId,false)
    messagebox(actor, self.cfg2[npcId], "@awake_road_open,"..npcId, "@awake_road_close")
end
function awake_road_open(actor,npcId) --#region 打开
    lualib:CloseNpcUi(actor,"awakeRoadOBJ")
    npcId = VarApi.getPlayerUIntVar(actor,"U_awake_road_npcId")
    opennpcshowex(actor,npcId,1,1)
end
function awake_road_close(actor) --#region 关闭
end

function awakeRoad:rewardPage(actor,...) --#region 本章奖励
    local param = {...}
    local leftIndex = tonumber(param[1]) --#region 左侧index
    local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_awakeRoadPage"))
    if hastab == "" then;hastab = {} end
    if hastab[param[1]] then
        return Sendmsg9(actor,"ff0000","本章任务奖励已领取过！",1)
    end
    local tab1 = json2tbl(VarApi.getPlayerTStrVar(actor,"TL_awakeRoadNode"))--#region 节点是否领取变量
    if tab1 == "" then;tab1 = {} end
    for i = 1, 4 do
        if not tab1[param[1]..tostring(i)] then
            return Sendmsg9(actor,"ff0000","本章任务目标"..i.."还未完成！",1)
        end
    end
    if leftIndex > 1 then
        deprivetitle(actor,self.cfg[leftIndex-1]["award_config2"][1][1])
    end
    confertitle(actor,self.cfg[leftIndex]["award_config2"][1][1],1)
    for index, value in ipairs(self.cfg[leftIndex]["award_config2"]) do
        if index > 1 then
            changemoney(actor,getstditeminfo(value[1],0),"+",value[2],"觉醒之路本章给货币",true)
        end
    end
    hastab[param[1]] = 1
    hastab = tbl2json(hastab)
    VarApi.setPlayerTStrVar(actor,"TL_awakeRoadPage",hastab,true)

    Sendmsg9(actor, "00ff00", "恭喜获得本章任务，获得丰厚奖励：！", 1)
    sendmsgnew(actor,255,255,"觉醒之路：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功完成任务"
    .."<『".. self.cfg[leftIndex]["type"] .."』/FCOLOR=251>,全服起立顶礼膜拜！",1,5)
    lualib:FlushNpcUi(actor, "awakeRoadOBJ", "本章")
    
    if leftIndex == 1 then
        local class = IncludeNpcClass("WelfareHall")
        if class then
            class:FlushSigleRedData(actor)
            class:openLimitView(actor)
        end
    end
end

return awakeRoad