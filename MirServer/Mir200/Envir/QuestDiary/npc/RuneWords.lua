local RuneWords = {}
RuneWords.cfg = include("QuestDiary/config/RuneWordsCfg.lua")
function RuneWords:upEvent(actor)
    local active_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_runewords_active_list"))
    if active_list == "" then
        active_list = {}
    end
    lualib:ShowNpcUi(actor,"RuneWordsOBJ","InitListView#"..tbl2json(active_list) )
end
function RuneWords:ActiveClick(actor,index)
    local cfg = RuneWords.cfg[tonumber(index)]
    if getbagitemcount(actor,cfg.itemname) < 1  then
       return Sendmsg9(actor, "ffffff",string.format("缺少%sx1，无法解密",cfg.itemname)   , 1) 
    end
    for k, v in pairs(cfg.needitem_map) do
        if getbindmoney(actor,k) < v then
           return Sendmsg9(actor, "ffffff",k.."不足"  , 1) 
        end
    end
    for k, v in pairs(cfg.needitem_map) do
        if not consumebindmoney(actor,k,v,"符文之语扣除") then
            return Sendmsg9(actor, "ffffff",k.."扣除失败"  , 1) 
        end
    end
    if not takeitemex(actor,cfg.itemname,1,0,"符文之语扣除") then
        return Sendmsg9(actor, "ffffff",cfg.itemname.."扣除失败"  , 1) 
    end
    local active_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_runewords_active_list"))
    if active_list == "" then
        active_list = {}
    end
    if self:GetIsActive(actor,index) then --再次激活
        local name_str = ""
        for k, v in pairs(cfg.decryptagin_map) do
            name_str = name_str .. k.."x"..v
            changemoney(actor,getstditeminfo(k, 0),"+",v,"符文之语下发",true)
        end
        Sendmsg9(actor, "ffffff","解密成功，获得" ..name_str , 1) 
    else   --首次激活
        local attr_str = VarApi.getPlayerTStrVar(actor,"T_RuneWords_attr")
        addattlist(actor,"RuneWords_attr","+",cfg.decrypt)
        attr_str = attr_str.."|" .. cfg.decrypt
        VarApi.setPlayerTStrVar(actor,"T_RuneWords_attr",attr_str)
        Sendmsg9(actor, "ffffff","解密成功" , 1) 

        
        table.insert(active_list,tonumber(index)) 
        VarApi.setPlayerTStrVar(actor,"T_runewords_active_list",tbl2json(active_list) )
    end
    lualib:FlushNpcUi(actor,"RuneWordsOBJ","FlushSigleItem#"..tbl2json(active_list) .. "#"..index)
end
function RuneWords:GetIsActive(actor,index)
    local active_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_runewords_active_list"))
    if active_list == "" then return false end
    for i,v in ipairs(active_list) do
        if tostring(v) == index then
           return true 
        end
    end
    return false
end
local function _onLogin(actor)
    local attr_str =VarApi.getPlayerTStrVar(actor,"T_RuneWords_attr")
    delattlist(actor, "RuneWords_attr")
    addattlist(actor,"RuneWords_attr","+",attr_str)
    return false
end
GameEvent.add("login", _onLogin, "RuneWords")

return RuneWords