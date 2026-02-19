BaByTrigger = {}
--角色获得宝宝触发
function BaByTrigger.slavebb(actor, mon)
    local buff_list = getallbuffid(actor)
    if checkkuafuserver() then
        buff_list = {}
        local buff_str = VarApi.getPlayerTStrVar(actor, "T_kuafu_buff_info")
        local tmp_list = strsplit(buff_str, "#")
        if type(tmp_list) == "table" then
            for k, v in pairs(tmp_list) do
                buff_list[k] = tonumber(v)
            end
        end
    end
    if isInTable(buff_list, 50029) then
        changeslavelevel(actor,mon,"+",7)
        sendattackeff(actor,125)
    end
end