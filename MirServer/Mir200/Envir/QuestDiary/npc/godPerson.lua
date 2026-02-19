local godPerson = {}
godPerson.cfg = {
    [1] = { ["title"]="圣灵道人·三生", ["effect"]=46144, ["level"]=18, ["need_config"]={{"声望",200000},{"金刚石",2000000},}, },
    [2] = { ["title"]="圣灵道人·六道", ["effect"]=46145, ["level"]=20, ["need_config"]={{"声望",200000},{"金刚石",2000000},}, },
    [3] = { ["title"]="圣灵道人·九天", ["effect"]=46146, ["level"]=22, ["need_config"]={{"声望",200000},{"金刚石",2000000},}, },
    [4] = { ["title"]="圣灵道人·化神", ["effect"]=46147, ["level"]=25, ["need_config"]={{"灵符",100000},{"金刚石",5000000},}, },
}

function godPerson:click(actor)
    local layer = VarApi.getPlayerUIntVar(actor, "UL_godPerson")--#region 当前圣灵境界
    if layer == 0 and not checktitle(actor,"至尊天人") then
        return Sendmsg9(actor, "ff0000", "请先提升至至尊天人境界！", 1)
    end
    lualib:ShowNpcUi(actor, "godPersonOBJ", "")
end

function godPerson:upEvent(actor,...)
    local layer = VarApi.getPlayerUIntVar(actor, "UL_godPerson")--#region 当前圣灵境界
    if layer == 0 and not checktitle(actor,"至尊天人") then
        return Sendmsg9(actor, "ff0000", "当前还未达到至尊天人境界！", 1)
    elseif layer == #self.cfg then
        return Sendmsg9(actor, "ff0000", "当前圣灵境界已突破至最高境界"..self.cfg[layer]["title"].."！", 1)
    elseif tonumber(getbaseinfo(actor,39)) < self.cfg[layer+1]["level"] then
        return Sendmsg9(actor, "ff0000", "当前角色转生等级不足"..self.cfg[layer+1]["level"].."级！", 1)
    end

    local infoTab = self.cfg[layer+1]["need_config"]
    if infoTab[1][2] > querymoney(actor, getstditeminfo(infoTab[1][1],0)) then
        lualib:FlushNpcUi(actor,"godPersonOBJ","不足#1")
        return Sendmsg9(actor, "ff0000", "当前"..infoTab[1][1].."货币不足！", 1)
    end
    if infoTab[2][2] > getbindmoney(actor, infoTab[2][1]) then
        lualib:FlushNpcUi(actor,"godPersonOBJ","不足#2")
        return Sendmsg9(actor, "ff0000", "当前"..infoTab[2][1].."货币不足！", 1)
    end
    if not changemoney(actor,getstditeminfo(infoTab[1][1],0),"-",infoTab[1][2],"圣灵境界非通用货币扣除",true) then
        return Sendmsg9(actor, "ff0000", infoTab[1][1].."扣除失败！", 1)
    end
    if not consumebindmoney(actor,infoTab[2][1],infoTab[2][2],"圣灵境界通用货币扣除") then
        return Sendmsg9(actor, "ff0000", infoTab[2][1].."扣除失败！", 1)
    end
    VarApi.setPlayerUIntVar(actor,"UL_godPerson",layer+1,true)
    if layer > 0 then
        deprivetitle(actor,self.cfg[layer]["title"])
    else
        deprivetitle(actor,"至尊天人")
    end
    confertitle(actor,self.cfg[layer+1]["title"],1)
    Sendmsg9(actor, "00ff00", "恭喜成功突破至"..self.cfg[layer+1]["title"].."境界！", 1)
    sendmsgnew(actor,255,255,"圣灵境界ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功突破至"
    .."<『"..self.cfg[layer+1]["title"].."』/FCOLOR=251>境界,获得属性提升！",1,8)
    lualib:FlushNpcUi(actor,"godPersonOBJ","提升")
end

return godPerson
