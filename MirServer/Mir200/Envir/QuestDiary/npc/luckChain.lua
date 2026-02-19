local luckChain = {}
luckChain.cfg1 = { [1] = "强化幸运", [2] = "转移幸运",}
luckChain.cfg2 = {
    [1] = {["need_config"]={{"金刚石",100},{"超级祝福油",1},}, ["odd"] = 100,},
    [2] = {["need_config"]={{"金刚石",300},{"超级祝福油",1},}, ["odd"] = 100,},
    [3] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 50,},
    [4] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 30,},
    [5] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 20,},
    [6] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 15,},
    [7] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 10,},
    [8] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 5,},
    [9] = {["need_config"]={{"灵符",80},{"超级祝福油",1},}, ["odd"] = 2,},
}
luckChain.i_attr = {11,1,4,7}

function luckChain:getInfo(actor,makeindex) --#region 获得幸运值和属性
    local equipObj = linkbodyitem(actor,3) --#region 穿戴的
    if makeindex ~= nil then
        equipObj = getitembymakeindex(actor,makeindex) --#region 点击的
    end
    if equipObj == "0" then
        return 0,0,0,0,0
    end
    local luck = getitemaddvalue(actor,equipObj,1,5,0)
    local temp1 = getnewitemaddvalue(equipObj,11) or 0 --#region 暴击伤害22 20 11
    local temp2 = getnewitemaddvalue(equipObj,1) or 0 --#region 攻击伤害25 30 1
    local temp3 = getnewitemaddvalue(equipObj,4) or 0 --#region 忽视防御28 50 4
    local temp4 = getnewitemaddvalue(equipObj,7) or 0 --#region 体力增加30 100 7
    return luck,temp1,temp2,temp3,temp4
end

function luckChain:click(actor)
    local luck,temp1,temp2,temp3,temp4 = self:getInfo(actor)
    if getbaseinfo(actor,3) == "3" and luck >= 3 then
        return  Sendmsg9(actor, "ffffff", "当前已强化至等级上限！！", 1)
    end
    lualib:ShowNpcUi(actor, "luckChainOBJ", luck.."#"..temp1.."#"..temp2.."#"..temp3.."#"..temp4)
end

function luckChain:reinforce(actor, ...) --#region 强化
    local equipObj = linkbodyitem(actor,3)
    if equipObj == "0" then
        return Sendmsg9(actor, "ff0000", "当时还未穿戴项链！", 1)
    end
    self.info_tab = {self:getInfo(actor)}
    if self.info_tab[1] >= 9 then
        return Sendmsg9(actor, "ff0000", "当前项链已强化至最高等级9！", 1)
    elseif getbaseinfo(actor,3) == "3" and self.info_tab[1] >= 3 then
        return Sendmsg9(actor, "ffffff", "当前已强化至等级上限！", 1)
    end
    for index, value in ipairs(self.cfg2[self.info_tab[1]+1]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if getbindmoney(actor, itemName) < value[2] then
                lualib:FlushNpcUi(actor, "luckChainOBJ", "不足#" .. itemName)
                return Sendmsg9(actor, "ff0000", "当前货币" .. itemName .. "数量少于" .. value[2] .. "！", 1)
            end
        elseif getbagitemcount(actor, itemName) < value[2] then
            lualib:FlushNpcUi(actor, "luckChainOBJ", "不足#" .. itemName)
            return Sendmsg9(actor, "ff0000", "当前背包" .. itemName .. "数量少于" .. value[2] .. "！", 1)
        end
    end
    for index, value in ipairs(self.cfg2[self.info_tab[1]+1]["need_config"]) do
        local itemName = value[1]
        if getstditeminfo(itemName, 0) < 10000 then
            if not consumebindmoney(actor, itemName, value[2], "项链强化非通用货币扣除") then
                return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
            end
        else
            if not takeitem(actor, itemName, value[2], 0) then
                return Sendmsg9(actor, "ff0000", itemName .. "扣除失败！", 1)
            end
        end
    end
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    local gs_odds = 0
    if type(list) == "table" and list[account_id] then
        gs_odds = list[account_id]["luck_necklace_odds"] or 0
    end
    local odds = self.cfg2[self.info_tab[1]+1]["odd"] + gs_odds
    if math.random(100) > odds then
        lualib:FlushNpcUi(actor,"luckChainOBJ", "失败#"..self.info_tab[1].."#"..self.info_tab[2].."#"..self.info_tab[3].."#"..self.info_tab[4].."#"..self.info_tab[5])
        return Sendmsg9(actor, "ff0000", "幸运项链强化失败！", 1)
    end
    setitemaddvalue(actor,equipObj,1,5,self.info_tab[1]+1)
    if self.info_tab[1] >= 3 then
        local weight = math.random(200)
        if weight >= 100 then
            self:setInfo(actor,4,equipObj,self.info_tab[5]+1)
        elseif 50 <= weight and weight < 100 then
            self:setInfo(actor,3,equipObj,self.info_tab[4]+1)
        elseif 20 <= weight and weight < 50 then
            self:setInfo(actor,2,equipObj,self.info_tab[3]+1)
        elseif weight < 20 then
            self:setInfo(actor,1,equipObj,self.info_tab[2]+1)
        end
    end
    self.info_tab = {self:getInfo(actor)}
    sendmsgnew(actor,255,255,"幸运项链ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功强化项链至"
    .."<『".. self.info_tab[1] .."阶』/FCOLOR=251>,获得属性提升！",1,8)
    Sendmsg9(actor, "00FF00", "成功强化幸运至：" .. self.info_tab[1] .. "阶！", 1)
    lualib:FlushNpcUi(actor,"luckChainOBJ", "强化#"..self.info_tab[1].."#"..self.info_tab[2].."#"..self.info_tab[3].."#"..self.info_tab[4].."#"..self.info_tab[5])
end
function luckChain:setInfo(actor,index,equipObj,value) --#region 根据权重加属性
    self.textIndex = index
    setnewitemvalue(actor,-2,self.i_attr[index],"=",value,equipObj)
end

function luckChain:select(actor,...) --#region 选取
    local param = {...}
    local makeindex = tonumber(param[1]) --#region 唯一id
    local luck,temp1,temp2,temp3,temp4 = self:getInfo(actor,makeindex)
    lualib:FlushNpcUi(actor,"luckChainOBJ", "选取#"..luck.."#"..temp1.."#"..temp2.."#"..temp3.."#"..temp4)
end

function luckChain:transfer(actor,...) --#region 转移幸运
    local param = {...}
    local makeindex = tonumber(param[1]) --#region 唯一id
    local equipObj = getitembymakeindex(actor,makeindex)
    local wearEquipObj = linkbodyitem(actor,3) --#region 穿戴的
    local luck1,temp11,temp21,temp31,temp41 = self:getInfo(actor) --#region 穿戴的
    local luck,temp1,temp2,temp3,temp4 = self:getInfo(actor,makeindex) --#region 选取的
    if makeindex == nil or makeindex == "" then
        return Sendmsg9(actor, "ff0000", "请先选择需要转移属性的项链！", 1)
    elseif wearEquipObj == "0" then
        return Sendmsg9(actor, "ff0000", "当时还未穿戴项链！", 1)
    elseif luck < luck1 then
        return Sendmsg9(actor, "ff0000", "所选取项链幸运值低于身上项链！", 1)
    end
    if querymoney(actor, 7) < 1000 then
        lualib:FlushNpcUi(actor, "luckChainOBJ", "不足#灵符")
        return Sendmsg9(actor, "ff0000", "当前货币灵符数量少于1000！", 1)
    end
    if not changemoney(actor, 7, "-",1000, "项链转移非通用货币扣除",true) then
        return Sendmsg9(actor, "ff0000", "灵符扣除失败！", 1)
    end
    setitemaddvalue(actor,wearEquipObj,1,5,luck)
    self:setInfo(actor,1,wearEquipObj,temp1)
    self:setInfo(actor,2,wearEquipObj,temp2)
    self:setInfo(actor,3,wearEquipObj,temp3)
    self:setInfo(actor,4,wearEquipObj,temp4)
    setitemaddvalue(actor,equipObj,1,5,0)
    self:setInfo(actor,1,equipObj,0)
    self:setInfo(actor,2,equipObj,0)
    self:setInfo(actor,3,equipObj,0)
    self:setInfo(actor,4,equipObj,0)

    Sendmsg9(actor, "00FF00", "成功转移幸运属性至选取装备！", 1)
    lualib:FlushNpcUi(actor,"luckChainOBJ", "转移#"..luck.."#"..temp1.."#"..temp2.."#"..temp3.."#"..temp4)
end

return luckChain