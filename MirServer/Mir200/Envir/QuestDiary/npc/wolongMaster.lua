local wolongMaster = {}
wolongMaster.cfg = include("QuestDiary/config/wolongMasterCfg.lua")

function wolongMaster:goMap1(actor,...) --#region 卧龙守将
    local param = {...}
    local sonIndex = tonumber(param[1]) --#region 第几个
    local name = self.cfg[1]["info_arr"][sonIndex]
    if not name or not self.cfg[name] then
        return Sendmsg9(actor, "ff0000", "当前选取数据异常！", 1)
    end
    mapmove(actor,self.cfg[name]["info_config"][1],self.cfg[name]["info_config"][2],self.cfg[name]["info_config"][3],2)
    lualib:CloseNpcUi(actor, "wolongMasterOBJ")
end

function wolongMaster:goMap2(actor,...) --#region 卧龙庄主
    mapmove(actor,"ddnb",46,36,2)
    lualib:CloseNpcUi(actor, "wolongMasterOBJ")
end

function wolongMaster:active3(actor,...)--#region 诛仙之力
    for index, value in ipairs(self.cfg[3]["info_config"]) do
        if getstditeminfo(value[1], 0) < 10000 then
            if value[2] > getbindmoney(actor, value[1]) then
                lualib:FlushNpcUi(actor, "wolongMasterOBJ", "不足#3"..index)
                return Sendmsg9(actor, "ff0000", "当前"..value[1].."货币不足！", 1)
            end
        else
            if value[2] > getbagitemcount(actor, value[1]) then
                lualib:FlushNpcUi(actor, "wolongMasterOBJ", "不足#3"..index)
                return Sendmsg9(actor, "ff0000", "当前"..value[1].."物品不足！", 1)
            end
        end
    end
    for index, value in ipairs(self.cfg[3]["info_config"]) do
        if getstditeminfo(value[1], 0) < 10000 then
            if not consumebindmoney(actor,value[1],value[2],"诛仙之力通用货币扣除") then
                return Sendmsg9(actor, "ff0000", value[1].."扣除失败！", 1)
            end
        else
            if not takeitem(actor,value[1],value[2],0) then
                return Sendmsg9(actor, "ff0000", value[1].."扣除失败！", 1)
            end
        end
    end
    confertitle(actor, "诛仙之力·王",1)
    seticon(actor,0,1,15276,0,0,1,0,0)
    VarApi.setPlayerUIntVar(actor, "l_zhuxian", 1, true)
    VarApi.setPlayerTStrVar(actor, VarStrDef.ICON_0, "15276#诛仙之力·王", true)
    Sendmsg9(actor, "00ff00", "恭喜成功获得称号：诛仙之力！", 1)
    sendmsgnew(actor,255,255,"诛仙之力ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功获得"
    .."<『诛仙之力·王』/FCOLOR=251>,获得属性提升！",1,5)
    return lualib:FlushNpcUi(actor, "wolongMasterOBJ", "称号")
end

return wolongMaster