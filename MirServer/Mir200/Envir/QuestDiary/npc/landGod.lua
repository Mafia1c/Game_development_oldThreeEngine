local landGod = {}
landGod.cfg = {"声望",100000,"金刚石",1000000}

function landGod:upEvent(actor,...)
    local level = VarApi.getPlayerUIntVar(actor, "l_masterLayer")--#region 当前宗师境界
    if level < 11 then
        return Sendmsg9(actor, "ff0000", "当前宗师境界还未提升至大宗师境界！", 1)
    elseif tonumber(getbaseinfo(actor,6)) < 79 then
        return Sendmsg9(actor, "ff0000", "当前角色等级不足79级！", 1)
    elseif VarApi.getPlayerUIntVar(actor, "UL_landGod") == 1 then
        return Sendmsg9(actor, "ff0000", "当前已是陆地仙人境界！", 1)
    end

    if self.cfg[2] > querymoney(actor, getstditeminfo(self.cfg[1],0)) then
        lualib:FlushNpcUi(actor,"landGodOBJ","不足#1")
        return Sendmsg9(actor, "ff0000", "当前"..self.cfg[1].."货币不足！", 1)
    end
    if self.cfg[4] > getbindmoney(actor, self.cfg[3]) then
        lualib:FlushNpcUi(actor,"landGodOBJ","不足#2")
        return Sendmsg9(actor, "ff0000", "当前"..self.cfg[3].."货币不足！", 1)
    end
    if not changemoney(actor,getstditeminfo(self.cfg[1],0),"-",self.cfg[2],"陆地仙人非通用货币扣除",true) then
        return Sendmsg9(actor, "ff0000", self.cfg[1].."扣除失败！", 1)
    end
    if not consumebindmoney(actor,self.cfg[3],self.cfg[4],"陆地仙人通用货币扣除") then
        return Sendmsg9(actor, "ff0000", self.cfg[3].."扣除失败！", 1)
    end
    VarApi.setPlayerUIntVar(actor,"UL_landGod",1,true)
    deprivetitle(actor,"大宗师")
    confertitle(actor,"陆地仙人",1)
    Sendmsg9(actor, "00ff00", "恭喜成功达成陆地仙人！", 1)
    sendmsgnew(actor,255,255,"陆地仙人ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功突破至"
    .."<『陆地仙人』/FCOLOR=251>境界,获得属性提升！",1,8)
    lualib:FlushNpcUi(actor,"landGodOBJ","提升")
end

return landGod
