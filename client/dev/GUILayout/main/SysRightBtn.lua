--[[
    101 主界面左上 建议开始微调坐标 0 0
    102 主界面右上 建议开始微调坐标 -65 0
    103 主界面左下 建议开始微调坐标 0 -92
    104 主界面右下 建议开始微调坐标 -62 -92
    105 主界面左中 建议开始微调坐标 0 0
    106 主界面上中 建议开始微调坐标 0 0
    107 主界面右中 建议开始微调坐标 -62 0
    108 主界面下中 建议开始微调坐标 0 -92
    109 主界面切换按钮
    110 主界面任务界面
    1101 主界面最顶左上
    1102 主界面最顶右上
    1103 主界面最顶左下
    1104 主界面最顶右下
--]]
local isPC = SL:GetMetaValue("WINPLAYMODE")
local parent107 = GUI:Win_FindParent(107)
local parent108 = GUI:Win_FindParent(108)
local parent109 = GUI:Win_FindParent(109)
local rightUi = {}
local btn_size = {width = 70, height = 70}
local show_btns = true
SL:SetMetaValue("DROPITEM_FLY_WORLD_POSITION", 1100, 400) --#region 飞背包

--- 点击按钮回调 109
--- @param id integer/string        string类型代表Npc面板 
local function onClickRightBtn(id)
    if nil == id then
        return
    end
    if SL:GetMetaValue("KFSTATE") then
        local tabs = {31, "disguiseOBJ", "TreasureObj", 2201}
        if isInTable(tabs, id) then
            SL:ShowSystemTips("跨服区域无法使用!")
            return
        end
    end
    if type(id) == "string" then
        if id == "TreasureObj" then
            SendMsgCallFunByNpc(0, "treasure","upEvent",1)
            return 
        elseif id == "PreviewOccupationOBJ" then
            ViewMgr.open("PreviewOccupationOBJ")
            return
        end
        SendMsgClickSysBtn("_sysbtn#SysRightBtn#onClickBtn#"..id)
    else
        SL:JumpTo(id)
    end
end

--- 点击按钮回调 107
local function onClickRightCenterBtn(id)
    if nil == id then
        return
    end
    if id == "_fight" then
        local is_auto_fight = SL:GetMetaValue("BATTLE_IS_AFK")
        local value = 1
        if is_auto_fight then
            value = 2
        end
        SendMsgClickSysBtn("_fight#SysRightBtn#onClickBtn#"..value)
    elseif id == "_ciSha" then
        local tab = SL:GetMetaValue("SETTING_VALUE", 56)
        if tab[1] == 1 then
            tab[1] = 0
        else
            tab[1] = 1
        end
        local path = "res/private/new_setting/icon/cs2.png"
        if tab[1] == 1 then
            path = "res/private/new_setting/icon/cs1.png"
        end
        GUI:Button_loadTextureNormal(rightUi["_ciSha"], path)
        SL:SetMetaValue("SETTING_VALUE", 56, tab)
    else
        SL:JumpTo(id)
    end
end

local btns_109 = {
    {"_guild", "res/private/main/bottom/1900013013.png", func = onClickRightBtn, id = 31},           -- 行会
    {"_team", "res/private/main/bottom/1900013014.png", func = onClickRightBtn, id = 17},          -- 组队
    {"_skill", "res/private/main/bottom/1900013012.png", func = onClickRightBtn, id = 4},          -- 技能
    {"_exchange", "res/private/main/bottom/1900013015.png", func = onClickRightBtn, id = 33},          -- 交易
    {"_disguise", "res/private/main/bottom/1900012593.png", func = onClickRightBtn, id = "disguiseOBJ"},          -- 装扮
    {"_compound", "res/private/main/bottom/1900012596.png", func = onClickRightBtn, id = 2201},          -- 合成
    {"_setting", "res/private/main/bottom/1900013017.png", func = onClickRightBtn, id = 300},          -- 设置
    {"_email", "res/private/main/bottom/1900012590.png", func = onClickRightBtn, id = 16},          -- 邮件
    {"_miBao", "res/private/main/bottom/19000130.png", func = onClickRightBtn, id = "TreasureObj"},          -- 秘宝
    {"_exit", "res/private/main/bottom/1900013018.png", func = onClickRightBtn, id = 29},            -- 退出
}
local pc_btns_107 = {
    {"_disguise", "res/private/main/bottom/1900012593.png", func = onClickRightBtn,id = "disguiseOBJ"},          -- 装扮
    {"_miBao", "res/private/main/bottom/19000130.png", func = onClickRightBtn, id = "TreasureObj"},          -- 秘宝
    {"_email", "res/private/main/bottom/1900012590.png", func = onClickRightBtn, id = 16},          -- 邮件
    {"_compound", "res/private/main/bottom/1900012596.png", func = onClickRightBtn,id = 2201},          -- 合成
    {"_fight", "res/custom/an/zd1.png", func = onClickRightCenterBtn,id = "_fight"},
    {"_skillpre", "res/private/main/bottom/19000131.png", func = onClickRightBtn,id = "PreviewOccupationOBJ"},--技能预览
}


local btns_107 = {
    {"_role", "res/private/main/bottom/1900013010.png", func = onClickRightCenterBtn, x = -140, y = 60, id = 1},
    {"_bag", "res/private/main/bottom/1900013011.png", func = onClickRightCenterBtn, x = -70, y = 60, id = 7},
    {"_fight", "res/custom/an/zd1.png", func = onClickRightCenterBtn, x = -135, y = -10, id = "_fight"},
    {"_ciSha", "res/private/new_setting/icon/cs2.png", func = onClickRightCenterBtn, x = -200, y = -10, id = "_ciSha"},
}

--- 点击按钮回调 108
--- @param id integer/string        string类型代表Npc面板 
local function onClickRBottomBtn(id)
    if nil == id then
        return
    end
    if type(id) == "string" then
        SendMsgClickSysBtn("_fight#SysRightBtn#onClickBtn#"..id)
    else
        SL:JumpTo(id)
    end
end
local btns_108 = {
    {"_shop", "res/custom/top/d_1.png", func = onClickRBottomBtn, id = "shangcheng", x = -290, y = 22},
    {"_rank", "res/custom/top/d_2.png", func = onClickRBottomBtn, id = "rank", x = -165, y = 22},
    {"_setting2", "res/custom/top/d_3.png", func = onClickRBottomBtn, id = 300, x = 230, y = 22},
}
local pc_switch_btns = {}
local function addMainSysBtn()
    parent107 = GUI:Win_FindParent(107)
    parent108 = GUI:Win_FindParent(108)
    parent109 = GUI:Win_FindParent(109)
    GUI:removeAllChildren(parent107)
    GUI:removeAllChildren(parent108)
    GUI:removeAllChildren(parent109)
    if isPC then
        pc_switch_btns = {}
        local parent = GUI:Node_Create(GUI:Win_FindParent(107), "btn_parent", -10, 160)
        local switch_bg = GUI:Image_Create(parent,"switch_bg",-20,-10, "res/custom/1900012580.png")
        local switch_btn = GUI:Button_Create(switch_bg, "switch", 30, 33, "res/custom/1900012538.png")
        GUI:setAnchorPoint(switch_btn, 0.5, 0.5)
        GUI:setAnchorPoint(switch_bg, 0.5, 0.5)
        local startX = -58
        local startY = 55
        for i=1,#pc_btns_107 do
            local v = pc_btns_107[i]
            local x = startX 
            local y = startY - 60 * (i - 1)
            if v.id == "_fight" then
                x = startX - 60
                y = startY
            elseif v.id == "PreviewOccupationOBJ" then
                x = startX - 60
                y = startY -60
            end
            local btn = GUI:Button_Create(parent107, v[1], x, y, v[2])
            GUI:setScale(btn, 0.9)
            rightUi[v[1]] = btn
            table.insert(pc_switch_btns, btn)
            GUI:addOnClickEvent(btn, function()
                if v.func then
                    v.func(v.id)
                end
            end)
        end

        local function switch_show()
            show_btns = not show_btns
            for k, v in pairs(pc_switch_btns) do
                GUI:setVisible(v, show_btns)
            end
            local path = "res/custom/1900012538.png"
            if not show_btns then
                path = "res/custom/1900012538.png"
                GUI:runAction(switch_btn, GUI:ActionRotateTo(0.1,90))
            else
                GUI:runAction(switch_btn, GUI:ActionRotateTo(0.1,0))
            end
            GUI:Button_loadTextureNormal(switch_btn, path)
        end
        GUI:addOnClickEvent(switch_btn, function()
            switch_show()
           
        end)
    else
        local job = SL:GetMetaValue("JOB")
        for k, v in ipairs(btns_107) do
            if v[1] == "_ciSha" then
                local tab = SL:GetMetaValue("SETTING_VALUE", 56)
                if tab[1] == 1 then
                    v[2] = "res/private/new_setting/icon/cs1.png"
                else
                    v[2] = "res/private/new_setting/icon/cs2.png"
                end
            end
            local btn = GUI:Button_Create(parent107, v[1], v.x or 0, v.y or 0, v[2])
            rightUi[v[1]] = btn
            GUI:addOnClickEvent(btn, function()
                if v.func then
                    v.func(v.id)
                end
            end)
            if v[1] == "_ciSha" then
                GUI:setVisible(btn, job == 0 and SL:GetMetaValue("SKILL_DATA", 12) ~= nil)
            end
        end

        for k, v in pairs(btns_108) do
            local btn = GUI:Button_Create(parent108, v[1], v.x or 0, v.y or 0, v[2])
            rightUi[v[1]] = btn
            GUI:addOnClickEvent(btn, function()
                if v.func then
                    v.func(v.id)
                end
            end)
        end

        local index = 1
        local startX = 160
        local startY = 190
        for i = 1, 4 do
            local x = startX
            local y = startY - btn_size.height * (i - 1)
            for j = 1, 3 do
                local v = btns_109[index]
                if v then
                    x = 160 - btn_size.width * (j - 1)
                    local btn = GUI:Button_Create(parent109, v[1], x, y, v[2])
                    rightUi[v[1]] = btn
                    GUI:addOnClickEvent(btn, function()
                        if v.func then
                            v.func(v.id)
                        end
                    end)
                    index = index + 1
                end
            end
        end
    end
end

-- 自动挂机开始
local function onStartAutoFight()
    if rightUi["_fight"] then
        GUI:Button_loadTextureNormal(rightUi["_fight"], "res/custom/an/zd2.png")
    end
    SL:SetMetaValue("BATTLE_AFK_BEGIN")
end
SL:RegisterLUAEvent(LUA_EVENT_AFKBEGIN, "SysRightBtn", onStartAutoFight)
-- 自动挂机结束
local function onEndAutoFight()
    if rightUi["_fight"] then
        GUI:Button_loadTextureNormal(rightUi["_fight"], "res/custom/an/zd1.png")
    end
    SL:SetMetaValue("BATTLE_AFK_END")
end
SL:RegisterLUAEvent(LUA_EVENT_AFKEND, "SysRightBtn", onEndAutoFight)

local function onSettingChange(info)
    if info and info.id == 56 then
        local value = info.values[1]
        local res = "res/private/new_setting/icon/cs2.png"
        if value == 1 then
            res = "res/private/new_setting/icon/cs1.png"
        end
        if rightUi["_ciSha"] then
            GUI:Button_loadTextureNormal(rightUi["_ciSha"], res)
        end
    end
end
SL:RegisterLUAEvent(LUA_EVENT_SETTING_CAHNGE, "SysRightBtn", onSettingChange)

-------------- 延迟半秒
SL:ScheduleOnce(function () addMainSysBtn() end, 0.5)
