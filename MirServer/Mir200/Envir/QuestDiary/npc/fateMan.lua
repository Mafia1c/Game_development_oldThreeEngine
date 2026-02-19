local fateMan = {}
fateMan.cfg = include("QuestDiary/config/fateManCfg.lua")

function fateMan:upEvent(actor,...)
    local layer = VarApi.getPlayerUIntVar(actor,"l_fateMan")
    if layer == #self.cfg then
        return Sendmsg9(actor, "ff0000", "当前天命老人已突破至最高等级！", 1)
    elseif getbaseinfo(actor,6) < self.cfg[layer+1]["level"] then
        return Sendmsg9(actor, "ff0000", "当前角色等级不足"..self.cfg[layer+1]["level"].."！", 1)
    elseif VarApi.getPlayerUIntVar(actor, "l_masterLayer") < self.cfg[layer+1]["layer"] then
        return Sendmsg9(actor, "ff0000", "请先将宗师境界提示至"..self.cfg[layer+1]["name"].."境界！", 1)
    end
    local job = getbaseinfo(actor,7)
    if self.cfg[layer+1]["need_arr"..job][2] > getbagitemcount(actor, self.cfg[layer+1]["need_arr"..job][1]) then
        sendluamsg(actor, 1002, 0, 0, 0, "fateManOBJ#不足#"..self.cfg[layer+1]["need_arr"..job][1])
        return Sendmsg9(actor, "ff0000", "当前"..self.cfg[layer+1]["need_arr"..job][1].."物品不足！", 1)
    end
    for i = 3, 6 do
        local infoTab = self.cfg[layer+1]["need_arr"..i]
        if not infoTab then
            break
        end
        if getstditeminfo(infoTab[1], 0) < 10000 then
            if infoTab[2] > getbindmoney(actor, infoTab[1]) then
                lualib:FlushNpcUi(actor, "fateManOBJ", "不足#"..infoTab[1])
                return Sendmsg9(actor, "ff0000", "当前"..infoTab[1].."货币不足！", 1)
            end
        else
            if infoTab[2] > getbagitemcount(actor, infoTab[1]) then
                lualib:FlushNpcUi(actor, "fateManOBJ", "不足#"..infoTab[1])
                return Sendmsg9(actor, "ff0000", "当前"..infoTab[1].."物品不足！", 1)
            end
        end
    end
    if not takeitem(actor,self.cfg[layer+1]["need_arr"..job][1],self.cfg[layer+1]["need_arr"..job][2],0) then
        return Sendmsg9(actor, "ff0000", self.cfg[layer+1]["need_arr"..job][1].."扣除失败！", 1)
    end
    for i = 3, 6 do
        local infoTab = self.cfg[layer+1]["need_arr"..i]
        if not infoTab then
            break
        end
        if getstditeminfo(infoTab[1], 0) < 10000 then
            if not consumebindmoney(actor,infoTab[1],infoTab[2],"天命老人通用货币扣除") then
                return Sendmsg9(actor, "ff0000", infoTab[1].."扣除失败！", 1)
            end
        else
            if not takeitem(actor,infoTab[1],infoTab[2],0) then
                return Sendmsg9(actor, "ff0000", infoTab[1].."扣除失败！", 1)
            end
        end
    end

    local level = getbaseinfo(actor,6)
    changelevel(actor,"+",1)
    VarApi.setPlayerUIntVar(actor,"l_fateMan",layer+1,true)
    sendmsgnew(actor,255,255,"天命老人ぐ恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功突破至"
    .."<『".. level+1 .."』/FCOLOR=251>级,天命血脉觉醒！",1,8)
    Sendmsg9(actor, "00FF00", "突破成功！", 1)
    lualib:FlushNpcUi(actor, "fateManOBJ", "提升")
end

return fateMan