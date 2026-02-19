local flyUp = {}
flyUp.cfg = {
    [1] = { ["text1"]="10",["text2"]="25",["needMaterials_map"]={["十转凭证"]=999,},["needCurrency_map"]={["灵符"]=10000,},["buff_map"]={[89]=1000,[67]=2500,}, },
    [2] = { ["text1"]="20",["text2"]="30",["needMaterials_map"]={["十转凭证"]=999,},["needCurrency_map"]={["灵符"]=50000,},["buff_map"]={[89]=2000,[67]=3000,}, },
    [3] = { ["text1"]="30",["text2"]="40",["needMaterials_map"]={["十转凭证"]=999,},["needCurrency_map"]={["灵符"]=100000,},["buff_map"]={[89]=3000,[67]=4000,}, },
}

function flyUp:upEvent(actor,...)
    local level = tonumber(getbaseinfo(actor,39))--#region 当前转生等级
    local layer = VarApi.getPlayerUIntVar(actor, "l_flyUp")--#region 当前表中layer

    if layer == #self.cfg then
        return Sendmsg9(actor,"ff0000","当前轮回飞升已至最高等级！",1)
    elseif getbaseinfo(actor,6) < 79 then
        return Sendmsg9(actor,"ff0000","当前人物等级还不足79级！",1)
    elseif level < 15 then
        return Sendmsg9(actor,"ff0000","当前人物转生等级还不足15转！",1)
    end

    local infoTab = self.cfg[layer+1]
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if v > getbagitemcount(actor, k) then
            lualib:FlushNpcUi(actor, "flyUpOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "材料不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do     --#region 非通用货币
        if v > querymoney(actor, getstditeminfo(k, 0)) then
            lualib:FlushNpcUi(actor, "flyUpOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do     --#region 通用货币
        if v > getbindmoney(actor, k) then
            lualib:FlushNpcUi(actor, "flyUpOBJ", "不足#" .. k)
            return Sendmsg9(actor, "ff0000", "当前" .. k .. "货币不足！", 1)
        end
    end
    for k, v in pairs(infoTab["needMaterials_map"] or {}) do
        if not takeitem(actor, k, v, 0) then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency1_map"] or {}) do     --#region 非通用货币
        if not changemoney(actor, getstditeminfo(k, 0), "-", v, "轮回飞升非通用货币扣除", true) then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end
    for k, v in pairs(infoTab["needCurrency_map"] or {}) do     --#region 通用货币
        if not consumebindmoney(actor, k, v, "轮回飞升通用货币扣除") then
            return Sendmsg9(actor, "ff0000", k .. "扣除失败！", 1)
        end
    end

    VarApi.setPlayerUIntVar(actor, "l_flyUp", layer+1, true)
    setbaseinfo(actor,39,level+1)
    changelevel(actor,"+",1)
    delbuff(actor, 20006)
    addbuff(actor, 20006, 0, 1, actor, self.cfg[layer+1]["buff_map"])
    Sendmsg9(actor, "00ff00", "恭喜轮回转生至：".. level+1 .."转！", 1)
    sendmsgnew(actor,255,255,"轮回飞升ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功轮回飞升至"
    .."<『".. getbaseinfo(actor,39) .."』转/FCOLOR=251>,全服起立顶礼膜拜！",1,5)
    lualib:FlushNpcUi(actor,"flyUpOBJ","提升")
end


return flyUp