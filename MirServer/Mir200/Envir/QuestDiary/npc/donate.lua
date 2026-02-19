local donate = {}
-- local tab = {
--     [1] = {["actorName"] = "玩家",["number"]=100,},
-- }
function donate:getRankListData(actor) --#region 获得捐献表
    local rank_list = {}
    local str = getsysvar(VarEngine.donate)
    rank_list = json2tbl(str)
    return rank_list
end

function donate:click(actor)
    local rank_list = self:getRankListData(actor)
    local sMsg = tbl2json(rank_list)
    lualib:ShowNpcUi(actor, "donateOBJ", sMsg)
end

function donate:upEvent(actor, ...) --#region 捐献
    local param = {...}
    local number = tonumber(param[1]) --#region 数量
    if number == "" or number == nil or number == 0 then
        return Sendmsg9(actor, "ff0000", "请输入正确的数值来捐献！", 1)
    end
    if querymoney(actor, getstditeminfo("灵符", 0)) < number then
        return Sendmsg9(actor, "ff0000", "当前灵符数量少于" .. number .. "！", 1)
    end
    if number < 10 then
       return Sendmsg9(actor, "ffffff", "每次捐献不得少于10灵符！", 1)
    end
    local userName = getbaseinfo(actor,1)                         --#region 玩家名称
    local userId = getbaseinfo(actor, 2)                          --#region 玩家唯一ID
    local ownNumber = VarApi.getPlayerUIntVar(actor, "l_donate") --#region 已捐献数量
    local upNumber = number+ownNumber
    local rank_list = self:getRankListData() --#region 捐献表
    self.nowIndex = 10
    local function deleTitle(actorName) --#region 第5名称号移除
        if getplayerbyname(actorName) and checktitle(getplayerbyname(actorName),"捐献第五名") then
            deprivetitle(getplayerbyname(actorName),"捐献第五名")
            confertitle(getplayerbyname(actorName),"捐献第六名",0)
        end
    end
    if rank_list == "" then rank_list = {} end
    local inTable = false
    for index, value in ipairs(rank_list) do --#region 当前在表中替换数量
        if value["actorName"] == userName then
            value["number"] = upNumber
            inTable = true
            break
        end
    end
    if not inTable then --#region 不在表中
        rank_list[#rank_list+1] ={["actorName"]=userName,["number"] = upNumber}
    end
    table.sort(rank_list,function(a,b)
		if a.number > b.number then
			return true
		end
		return false
	end)
    if rank_list[6] then
        deleTitle(rank_list[6] and rank_list[6]["actorName"])
    end
    
    for index, value in ipairs(rank_list) do
        if index > 5 then
            table.remove(rank_list,index)
        end
    end
    changemoney(actor,7,"-",number,"捐献扣",true)

    VarApi.setPlayerUIntVar(actor,"l_donate",upNumber,true)
    local str = tbl2json(rank_list)
    setsysvar(VarEngine.donate, str)
    self:otherTitle(actor)
    sendmsgnew(actor,255,255,"公益捐献：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功捐献"
    .."<『"..number.."灵符』/FCOLOR=251>,获得属性提升！",1,8)
    lualib:FlushNpcUi(actor,"donateOBJ", "捐献#"..str)
end

function donate:otherTitle(actor) --#region 捐献排行榜称号更改(不在线玩家下次登陆触发)
    local titleTab = {"捐献第一名","捐献第二名","捐献第三名","捐献第四名","捐献第五名","捐献第六名",}
    local rank_list = self:getRankListData() --#region 捐献表
    if rank_list == "" then rank_list = {} end
    for index, value in ipairs(rank_list or {}) do --#region 在排行榜中(对排行榜操作)
        if getplayerbyname(value["actorName"]) and not checktitle(getplayerbyname(value["actorName"]),titleTab[index]) then
            for i, v in ipairs(titleTab) do
                deprivetitle(getplayerbyname(value["actorName"]),v)
            end
            confertitle(getplayerbyname(value["actorName"]),titleTab[index],0)
        end
    end
    for index, value in ipairs(rank_list or {}) do --#region 传入不在排行榜中(对自己操作，排行榜有数据)
        if getbaseinfo(actor, 1) == value["actorName"] then
            break
        elseif index == #rank_list then
            for i, v in ipairs(titleTab) do
                deprivetitle(actor, v)
            end
            if VarApi.getPlayerUIntVar(actor,"l_donate") >= 10 and not checktitle(actor,"捐献第六名") then
                confertitle(actor,"捐献第六名",0)
            end
        end
    end
    if next(rank_list) == nil then --#region 没有排行榜数据(清除称号)
        for i, v in ipairs(titleTab) do
            deprivetitle(actor, v)
        end
    end
end

return donate