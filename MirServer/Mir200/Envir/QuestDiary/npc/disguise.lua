local disguise = {}
disguise.cfg = include("QuestDiary/config/disguiseCfg.lua")
local tab = {
    [1] = {"社团风云(装扮)","海盗船长(装扮)"}, --#时装
    [2] = {"城主专属足迹(足迹)","步步高升足迹"}, --#称号(足迹)
    [3] = {"小恶魔(时装精灵)"}, --#装备
    [4] = {"洛丽塔(女仆)"}, --#宠物
}

function disguise:click(actor)

end

function disguise:dress1(actor, ...) --#region 穿戴时装
    local param = {...}
    local name = param[1] --#region 时装名称
    local sex = getbaseinfo(actor,8) --#region 性别
    if VarApi.getPlayerTStrVar(actor,"UL_disguise1") ~= name then
        VarApi.setPlayerTStrVar(actor,"UL_disguise1",name,true)
        delbodyitem(actor,17,"穿戴时装前扣除")
        giveonitem(actor,17,name..sex,1,307,"时装界面给予时装")
        setbaseinfo(actor,57,1)
        Sendmsg9(actor, "ffffff", "成功穿戴时装"..name.."!", 1)
    else
        VarApi.setPlayerTStrVar(actor,"UL_disguise1","",true)
        setbaseinfo(actor,57,0)
        Sendmsg9(actor, "ffffff", "时装取消穿戴!", 1)
    end

    lualib:FlushNpcUi(actor,"disguiseOBJ", "时装")
end

function disguise:dress2(actor,...) --#region 穿戴足迹
    local param = {...}
    local name = param[1] --#region 足迹名称
    local effectTab = {["城主专属足迹"]=46139,["步步高升足迹"]=40197,}
    if name == "城主专属足迹" and not checktitle(actor,"城主专属足迹") then
        return Sendmsg9(actor, "ffffff", "当前没有称号城主专属足迹!", 1)
    end
    if VarApi.getPlayerTStrVar(actor,"UL_disguise2") ~= name then
        VarApi.setPlayerTStrVar(actor,"UL_disguise2",name,true)
        if effectTab[name] then
            setmoveeff(actor, effectTab[name], 1)
        end
        Sendmsg9(actor, "ffffff", "成功穿戴足迹"..name.."!", 1)
    else
        VarApi.setPlayerTStrVar(actor,"UL_disguise2","",true)
        setmoveeff(actor, 0, 1)
        Sendmsg9(actor, "ffffff", "足迹取消穿戴!", 1)
    end

    lualib:FlushNpcUi(actor,"disguiseOBJ", "足迹")
end

function disguise:dress3(actor,...) --#region 穿戴精灵(顶戴)
    local param = {...}
    local name = param[1] --#region 精灵名称
    if VarApi.getPlayerTStrVar(actor,"UL_disguise3") ~= name then
        VarApi.setPlayerTStrVar(actor,"UL_disguise3",name,true)
        seticon(actor,1,1,11900,-50,-60,1,0,0)
        Sendmsg9(actor, "ffffff", "成功穿戴精灵"..name.."!", 1)
    else
        seticon(actor,1,-1)
        VarApi.setPlayerTStrVar(actor,"UL_disguise3","",true)
        Sendmsg9(actor, "ffffff", "精灵取消穿戴!", 1)
    end

    lualib:FlushNpcUi(actor,"disguiseOBJ", "精灵")
end

function disguise:dress4(actor,...) --#region 穿戴宠物
    local param = {...}
    local name = param[1] --#region 宠物名称
    if VarApi.getPlayerTStrVar(actor,"UL_disguise4") ~= name then
        createsprite(actor,"洛丽塔")
        VarApi.setPlayerTStrVar(actor,"UL_disguise4",name,true)
        Sendmsg9(actor, "ffffff", "成功召唤宠物"..name.."!", 1)
    else
        releasesprite(actor)
        VarApi.setPlayerTStrVar(actor,"UL_disguise4","",true)
        Sendmsg9(actor, "ffffff", "取消宠物召唤!", 1)
    end

    lualib:FlushNpcUi(actor,"disguiseOBJ", "宠物")
end

return disguise