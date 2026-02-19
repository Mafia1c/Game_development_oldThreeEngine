local bossAward = {}
bossAward.cfg = include("QuestDiary/config/bossAwardCfg.lua")

function bossAward:goMap(actor,...) --#region 前往地图
    local param = {...}
    local leftIndex1 = tonumber(param[1]) --#region 左侧index1
    local boss_name = param[2]
    -- local leftIndex2 = tonumber(param[2]) --#region 左侧index2
    -- local boxIndex = tonumber(param[3]) --#region midBoxIndex
    if not getbaseinfo(actor,48) or getbaseinfo(actor,3) ~= "3" or getbaseinfo(actor,3) == ("b101"..getbaseinfo(actor,2)) then --#region 玩家不在安全区
        return Sendmsg9(actor, "ff0000", "只能在安全区使用！", 1)
    end
    lualib:CloseNpcUi(actor, "bossAwardOBJ")
    opennpcshowex(actor,self.cfg[boss_name]["npcId"],1,1)
end

function bossAward:goCopyMap(actor,...) --#region 前往副本地图
    local param = {...}
    self.leftIndex1 = tonumber(param[1]) --#region 左侧index1
    local name = param[2]
    if not getbaseinfo(actor,48) or getbaseinfo(actor,3) ~= "3" or getbaseinfo(actor,3) == ("b101"..getbaseinfo(actor,2)) then --#region 玩家不在安全区
        return Sendmsg9(actor, "ff0000", "只能在安全区使用！", 1)
    end
    if getbagitemcount(actor, self.cfg[self.leftIndex1]["need_arr"][1]) < self.cfg[self.leftIndex1]["need_arr"][2] then
        return Sendmsg9(actor, "ff0000", "当前背包" .. self.cfg[self.leftIndex1]["need_arr"][1] .. "物品不足！", 1)
    end
    if not takeitem(actor, self.cfg[self.leftIndex1]["need_arr"][1], self.cfg[self.leftIndex1]["need_arr"][2], 0) then
        return Sendmsg9(actor, "ff0000", self.cfg[self.leftIndex1]["need_arr"][1] .. "扣除失败！", 1)
    end

    self:create(actor,name)
end

function bossAward:create(actor,name) --#region 创建副本
    local mapid = getbaseinfo(actor,3)
    local newmapid = self.cfg[name]["mapId"]..getbaseinfo(actor,2);
    local x= getbaseinfo(actor,4)
    local y = getbaseinfo(actor,5)
    delmirrormap(newmapid)
    local result = addmirrormap(self.cfg[name]["mapId"],newmapid,
    name.."副本",3600,mapid,3,x,y)
    if not result then
        return Sendmsg9(actor,"ff0000","副本创建失败！",1)
    end

    delaygoto(actor,200,"move_bossaward,"..newmapid..",10,10,"..name,1)
end
function move_bossaward(actor,newmapid,newmapx,newmapy,bossname)
    local mons = genmon(newmapid,newmapx,newmapy,bossname,1,1,249)
    mapmove(actor,newmapid,newmapx,newmapy,2)
    lualib:CloseNpcUi(actor, "bossAwardOBJ")
end

function bossAward:rewardEvent(actor,...) --#region 本章奖励
    local param = {...}
    local leftIndex1 = tonumber(param[1]) --#region 1级列表idx
    local tab = VarApi.getPlayerTStrVar(actor, "l_bossAward")
    tab = json2tbl(tab)
    if VarApi.getPlayerUIntVar(actor,"UL_bossAward"..leftIndex1) == 1 then
        return Sendmsg9(actor,"ff0000","本章奖励已领取过！",1)
    end
    for i = 1, self.cfg[leftIndex1]["to"] do
        for index, value in ipairs(self.cfg[leftIndex1]["boss_arr"..i]) do
            if tab == "" or not tab[value] then
                return Sendmsg9(actor,"ff0000","当前"..value.."BOSS尚未击杀！",1)
            end
            if i == self.cfg[leftIndex1]["to"] and index == #self.cfg[leftIndex1]["boss_arr"..i] then
                -- for k, v in pairs(self.cfg[leftIndex1]["award_map"]) do
                --     if getstditeminfo(k,0) < 10000 then
                --         changemoney(actor,getstditeminfo(k,0),"+",v,"boss悬赏章节奖励货币",true)
                --     else
                --         giveitem(actor,k,v,307,"boss悬赏章节奖励物品")
                --     end
                -- end
                giveitem(actor,self.cfg[leftIndex1]["suit"],1,307,"boss悬赏本章奖励")
                Sendmsg9(actor, "00ff00", "恭喜获得本章奖励：".. self.cfg[leftIndex1]["suit"] .."！", 1)
                sendmsgnew(actor,255,255,"BOSS悬赏：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>击杀一众BOSS，获得悬赏奖励"
                .."<『".. self.cfg[leftIndex1]["suit"] .."』/FCOLOR=251>,全服起立顶礼膜拜！",1,5)
                VarApi.setPlayerUIntVar(actor,"UL_bossAward"..leftIndex1,1,true)
                lualib:FlushNpcUi(actor,"bossAwardOBJ","本章")
                return
            end
        end
    end
end
function bossAward:rewardPageEvent(actor,...) --#region 页签悬赏奖励
    local param = {...}
    local leftIndex1 = tonumber(param[1]) --#region 1级列表idx
    local leftIndex2 = tonumber(param[2]) --#region 2级列表idx
    if VarApi.getPlayerUIntVar(actor,"UL_page_bossAward"..leftIndex1.."_"..leftIndex2) == 1 then
        return Sendmsg9(actor,"ff0000","奖励已领取过！",1)
    end
    local tab = json2tbl(VarApi.getPlayerTStrVar(actor, "l_bossAward")) 
    for i,v in ipairs(self.cfg[leftIndex1]["boss_arr"..leftIndex2]) do
        if tab == "" or not tab[v] then
           return  Sendmsg9(actor,"ff0000","当前"..v.."BOSS尚未击杀！",1)
        end
    end
    for k, v in pairs(self.cfg[leftIndex1]["award_map"]) do
        if getstditeminfo(k,0) < 10000 then
            changemoney(actor,getstditeminfo(k,0),"+",v,"boss悬赏章节奖励货币",true)
        else
            if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) >= 68 then
                giveitem(actor,k,v,0,"boss悬赏章节奖励物品")
            else
                giveitem(actor,k,v,307,"boss悬赏章节奖励物品")
            end
        end
    end
    Sendmsg9(actor, "00ff00", "恭喜获得本章奖励！", 1)
    VarApi.setPlayerUIntVar(actor,"UL_page_bossAward"..leftIndex1.."_"..leftIndex2,1,true)
    lualib:FlushNpcUi(actor,"bossAwardOBJ","本页")
end
return bossAward