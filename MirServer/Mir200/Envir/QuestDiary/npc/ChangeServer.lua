local ChangeServer = {}
function ChangeServer:upEvent(actor)
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local zhuanquda = json2tbl(VarApi.getPlayerTStrVar(actor,"zhuanqu_data")) 
    local data = json2tbl(readini('QuestDiary/zhuanqu.ini',"zq",account_id)) 
    local server_Id = globalinfo(11)
    if zhuanquda == "" and data ~= "" then
        if data.zhuanqu_id ~= server_Id then
            zhuanquda = data
        end
    end
    if zhuanquda == "" then
        zhuanquda = {}
    end
    lualib:ShowNpcUi(actor,"ChangeServerOBJ",tbl2json(zhuanquda) )
end
function ChangeServer:OnClickRechargeBtn(actor)
    messagebox(actor,"请确定是否转区？","@_ok_change_server_fun","@no_change_server")
end
function ChangeServer:okChangeServer(actor)
    local recharge_value =  VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    if recharge_value < 200 then
        return  Sendmsg9(actor, "ffffff",  "你当前充值低于200元，转区失败！", 1) 
    end
    local mainServiceId = getconst(actor, "<$MAINTONGSERVER>")
    if tonumber(mainServiceId) <= 0 then
        return Sendmsg9(actor, "ffffff",  "未设置通区主区", 1) 
    end
    local server_Id = globalinfo(11)
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local data = {}
    data.can_get_all_num = recharge_value
    data.already_get_num = 0
    data.zhuanqu_id = server_Id
    writeini('QuestDiary/zhuanqu.ini', "zq", account_id, tbl2json(data))
    updatemaintongfile(mainServiceId, '..\\QuestDiary\\zhuanqu.ini', '..\\QuestDiary\\zhuanqu.ini')
    local role_name = getbaseinfo(actor,1)
    gmexecute("0","DenyCharNameLogon",role_name,1)
    delaygoto(actor,1000,"QuitGame,",0)
end

function _ok_change_server_fun(actor)
    local npc_class = IncludeNpcClass("ChangeServer")
    if npc_class then
        npc_class:okChangeServer(actor)
    end
end
function QuitGame(actor)
    openhyperlink(actor,34)
end

function ChangeServer:OnClickGetBtn(actor,get_num)
    local mainServiceId = getconst(actor, "<$MAINTONGSERVER>")
    if tonumber(mainServiceId) <= 0 then
        return Sendmsg9(actor, "ffffff",  "未设置通区主区", 1) 
    end
    local merge_count = getsysvar(VarEngine.HeFuCount)
    if merge_count > 0  then
        return Sendmsg9(actor, "ffffff",  "需要去新区领取", 1) 
    end
    local server_Id = globalinfo(11)
    get_num = tonumber(get_num)

    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"zhuanqu_data")) 
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local cache_data = json2tbl(readini('QuestDiary/zhuanqu.ini',"zq",account_id)) 
    if data == "" and cache_data ~= "" then
        if cache_data.zhuanqu_id ~= server_Id then
            VarApi.setPlayerTStrVar(actor,"zhuanqu_data",tbl2json(cache_data))
            deliniitem('QuestDiary/zhuanqu.ini', "zq", account_id)
            updatemaintongfile(mainServiceId, '..\\QuestDiary\\zhuanqu.ini', '..\\QuestDiary\\zhuanqu.ini')
            data = cache_data
        end
    end
    if data == "" then
        return Sendmsg9(actor, "ffffff",  "没有可领取的转区金额", 1) 
    end

    local wait_get_num  = data.can_get_all_num - data.already_get_num
    local recharge_value =  VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE)
    if recharge_value < data.can_get_all_num then
        if get_num > (recharge_value - data.already_get_num) then
            return Sendmsg9(actor, "ffffff",  "可领取金额不足", 1) 
        end
    end
    if get_num > wait_get_num  then
        return Sendmsg9(actor, "ffffff",  "可领取金额不足", 1) 
    end
   
    local zq_data = {}
    zq_data.can_get_all_num = data.can_get_all_num
    zq_data.already_get_num =  data.already_get_num + get_num
    zq_data.zhuanqu_id = server_Id
    changemoney(actor,20,"+",get_num * 10,"转区领取",true)
    VarApi.setPlayerTStrVar(actor,"zhuanqu_data",tbl2json(zq_data))
    lualib:FlushNpcUi(actor,"ChangeServerOBJ","zhuanqu_data#"..tbl2json(zq_data))
end

return ChangeServer