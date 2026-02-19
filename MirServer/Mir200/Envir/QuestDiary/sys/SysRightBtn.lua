local SysRightBtn = {}

function SysRightBtn:onClickBtn(actor, sMsg)
    if tonumber(sMsg) == 1 then                 -- 开启挂机
        startautoattack(actor)
    elseif sMsg == "TreasureObj" then
        lualib:ShowNpcUi(actor, "TreasureObj")
    elseif sMsg == "disguiseOBJ" then
        if checkkuafu(actor) then
            return Sendmsg9(actor, "ff0000", "跨服暂时不支持更改时装", 1)
        end
        local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_disguise")) --#region 装扮表
        if "" == hastab then hastab = {} end
        for index = 1, 4 do
            if hastab[tostring(index)] and hastab[tostring(index)] ~= {} then
                lualib:ShowNpcUi(actor, "disguiseOBJ","")
                break
            elseif 4 == index then
                Sendmsg9(actor,"ff0000","您还未拥有任何时装！",1)
            end
        end
    elseif sMsg == "rank" then
        openhyperlink(actor, 32, 2)
        openhyperlink(actor, 32, 1, 1, 0)
    elseif sMsg == "shangcheng" then
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服地图禁止使用！", 1)
        else
            openhyperlink(actor, 9, 1)
        end
    else
        stopautoattack(actor)
    end
    
end

return SysRightBtn