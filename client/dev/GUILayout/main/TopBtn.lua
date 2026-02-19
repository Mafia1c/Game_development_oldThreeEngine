----------------------------------主界面顶部按钮
-- 点击按钮回调
local function onClickTopBtn(id)
    if nil == id then
        return
    end
    if type(id) == "string" then
        -- 打开对应npc面板
        if id == "LostCities2OBJ" then
            ViewMgr.open("LostCities2OBJ")
            return
        end
        if id == "996" then
            SL:RequestOpen996ManualService()
            return
        end
        -- ViewMgr.open(id)
        SendMsgClickMainBtn("0#MainTopBtn#onClickGameActivity#"..id)
    else
        if id == 35 or id == 27 then
            SendMsgClickMainBtn("0#MainTopBtn#onClickJumpTo#"..id)
        else
            SL:JumpTo(id)
        end
    end
end

local row1Info = {
    -- 按钮id, 图片资源路径, 函数名, 是否一直显示, 参数
    {"_exchange", "res/custom/top/an_1.png",func = onClickTopBtn, id = 35},                                     -- 交易行
    {"_auction", "res/custom/top/an_2.png",func = onClickTopBtn,  id = 27},                         -- 拍卖行
    {"_strategy", "res/custom/top/an_3.png",func = onClickTopBtn, id = "GameStrategyOBJ"},                      -- 游戏攻略
    {"_activity", "res/custom/top/an_4.png",func = onClickTopBtn, id = "GameActivityOBJ"},         -- 全服活动
    {"_rage", "res/custom/top/an_12.png",func = onClickTopBtn,    id = "RageOBJ"},                    -- 狂暴之力
    {"_cross_shop", "res/custom/top/an123.png",func = onClickTopBtn,  id = "CrossShopObj",condition = {["hefu_count"] = 1}},                    -- 跨服商城
    {"_autoFight", "res/custom/top/an_15.png",func = onClickTopBtn, id = "MapXunHangOBJ"},                      -- 挂机巡航
}

local row2Info = {
    -- 按钮id, 图片资源路径, 函数名, 是否一直显示, 参数
    {"_ttsq", "res/custom/top/an_0.png",func = onClickTopBtn, id = 111},                                         -- 天天省钱
    {"_recharge", "res/custom/top/an_11.png",func = onClickTopBtn, id = "RechargeOBJ"},                                    -- 在线充值
    {"_benefit", "res/custom/top/an_7.png",func = onClickTopBtn, id = "WelfareHallOBJ"},                               -- 福利大厅
    {"_privilege", "res/custom/top/an_13.png",func = onClickTopBtn, id = "PrivilegeOBJ"},                            -- 终身特权
    {"_treasure", "res/custom/top/an_22.png",func = onClickTopBtn, id = "luckTreasureOBJ",condition = {["hefu_count"] = 1}},                             -- 祥瑞宝藏
    {"_gift", "res/custom/top/an_9.png",func = onClickTopBtn, id = "FirstRechargeRewardOBJ"},                                    -- 首充豪礼
    {"_battlefield", "res/custom/top/an_10.png",func = onClickTopBtn, id = "CrossRealmBattlefieldOBJ",condition = {["hefu_count"] = 1}},             -- 跨服战场
}
-- GameData.GetData("HeFuCount",false)
local row3Info = {
    {"_kf_btn", "res/custom/top/an_23.png",func = onClickTopBtn, id = "LostCities2OBJ",condition = {["hefu_count"] = 3}},                                    -- 迷失之城
    {"_server_gift", "res/custom/top/an25.png",func = onClickTopBtn, id = "OpenServerGiftObj"},                       -- 开服礼包
    {"_everyday_recharge", "res/custom/top/an_26.png",func = onClickTopBtn, id = "EverydayRechargeOBJ",condition = {["open_day"] = 1},gamedata_limit={["J_everyday_recharge"]=0}},                       -- 每日充值
}
local _cf_btn = {"_cifu", "res/custom/top/an_19.png",func = onClickTopBtn, id = "lockMagicOBJ"}                                    -- 封魔赐福
local cf_state = GameData.GetData("UL_fmcf7", false) or 0
local mark_tow_map = GameData.GetData("U_enter_tow_map", false)
if cf_state == 0 and mark_tow_map == 1 then
    table.insert(row2Info, 7, _cf_btn)
end

local state = GameData.GetData("U_firstRecharge", false)
if state == 1 then
    table.remove(row2Info, 6)
end

local service = {"_996", "res/custom/top/an_20.png",func = onClickTopBtn, id = "996"}                               -- 996客服
if service then
    table.insert(row2Info, service)
end

local isPC = SL:GetMetaValue("WINPLAYMODE")
local topUi = {}
local layout_102 = GUI:Win_FindParent(102)
local startX = 0
local startY = 0
local switch_btns = {}
local show_btns = true
-- 创建按钮
local function create_switch_btn()
    local row1Info,row2Info,row3Info = check_top_btn_condition()
    switch_btns = {}
    layout_102 = GUI:Win_FindParent(102)
    local btn_parent = GUI:GetWindow(layout_102,"btn_parent")
    --若已创建顶部
    if btn_parent and GUI:Win_IsNotNull(btn_parent) then
        GUI:removeFromParent(btn_parent)
    end
    local parent = GUI:Node_Create(layout_102, "btn_parent", 0, 0)
    local size = {width = 60, height = 60}
    startX = -180 - size.width / 2
    startY = -5 - size.height / 2
    if isPC then
        -- pc重新计算x,y
        startX = startX - 10
        startY = startY
    end
    local switch_btn = GUI:Button_Create(parent, "switch", startX, startY, "res/custom/top/top2.png")
    GUI:setAnchorPoint(switch_btn, 0.5, 0.5)
    local merge_count = GameData.GetData("HeFuCount", false) or 0

    local length = math.max(#row1Info, #row2Info, #row3Info)
    for i = 1, length do
        local row1 = row1Info[i]
        local row2 = row2Info[i]
        local row3 = row3Info[i]
        local x1 = (startX - 20) - i * 75
        local x2 = (startX + 20) - i * 75
        local x3 = (startX + 20) - i * 75
        local y1 = startY - 40
        local y2 = startY - 110
        local y3 = startY - 195
        if row1 then
            local btn1 = GUI:Button_Create(parent, row1[1], x1, y1, row1[2])
            local tab = {
                btn = btn1,
                row = 1,
                show = row1.show
            }
            table.insert(switch_btns, tab)
            GUI:addOnClickEvent(btn1, function()
                if row1.func then
                    row1.func(row1.id)
                end
            end)
        end
        if row2 then
            local btn2 = GUI:Button_Create(parent, row2[1], x2, y2, row2[2])
            local tab = {
                btn = btn2,
                row = 2,
                show = row2.show
            }
            if row2.effect then
               GUI:Effect_Create(btn2, "btn_effect"..i, 40,40, 0, 4003)
            end
            table.insert(switch_btns, tab)
            GUI:addOnClickEvent(btn2, function()
                if row2.func then
                    row2.func(row2.id)
                end
            end)
        end
        if row3 then
            local btn3 = GUI:Button_Create(parent, row3[1], x3, y3, row3[2])
            local tab = {
                btn = btn3,
                row = 3,
                show = row3.show
            }
            table.insert(switch_btns, tab)
            GUI:addOnClickEvent(btn3, function()
                if row3.func then
                    row3.func(row3.id)
                end
            end)
        end
    end

    local function switch_show()
        show_btns = not show_btns
        local tmp_list = {}
        for k, v in pairs(switch_btns) do
            local is_show = v.show or show_btns
            GUI:setVisible(v.btn, is_show)
            if is_show then
                tmp_list[v.row] = tmp_list[v.row] or {}
                table.insert(tmp_list[v.row], v.btn)
            end
        end
        -- 常亮按钮重新排列
        for _, btns in pairs(tmp_list) do
            for k, v in pairs(btns) do
                local x = (startX - 20) - k * 75
                if _ ~= 1 then
                    x = (startX + 20) - k * 75
                end                
                GUI:setPositionX(v, x)
            end
        end
        tmp_list = {}
        local path = "res/custom/top/top2.png"
        if not show_btns then
            path = "res/custom/top/top1.png"
        end
        GUI:Button_loadTextureNormal(switch_btn, path)
    end
    GUI:addOnClickEvent(switch_btn, function()
        switch_show()
    end)
    topUi = GUI:ui_delegate(layout_102)
    SL:onLUAEvent(MAIN_TOP_BTN_CHANGE)
end

function show_main_top_btn(show_type)
    if show_type == 1 then
        SL:ScheduleOnce(function ()
            create_switch_btn()
        end, 0.5)
    else
        layout_102 = GUI:Win_FindParent(102)
        local btn_parent = GUI:GetWindow(layout_102,"btn_parent")
        --若已创建顶部
        if btn_parent and GUI:Win_IsNotNull(btn_parent) then
            GUI:removeFromParent(btn_parent)
        end
    end
end
function check_top_btn_show(rowInfo)
    local merge_count = GameData.GetData("HeFuCount", false) or 0
    local open_day = GameData.GetData("OpenDay", false) or 0
    local temp_rowInfo = SL:CopyData(rowInfo)
    for i=#temp_rowInfo,1,-1 do
        local data = temp_rowInfo[i]
        if data.condition and next(data.condition) then
            for key,value in pairs(data.condition) do
                if key == "hefu_count" and merge_count < value then
                    table.remove(temp_rowInfo,i)
                end
                if key == "open_day" and  open_day < value then
                    table.remove(temp_rowInfo,i)
                end
            end
        end
        if data.gamedata_limit and next(data.gamedata_limit) then
            for key,value in pairs(data.gamedata_limit) do
                if type(value) == "number" and (GameData.GetData(key,false) or 0) ~= value then
                    table.remove(temp_rowInfo,i)
                end 
            end
        end
    end
    return temp_rowInfo
end
function check_top_btn_condition()
    local temp_row1Info = check_top_btn_show(row1Info)
    local temp_row2Info = check_top_btn_show(row2Info)
    local temp_row3Info = check_top_btn_show(row3Info)
    return temp_row1Info,temp_row2Info,temp_row3Info
end

show_main_top_btn(1)

local function callBack(data)
    if type(data) == "string" and string.find(data, "U_firstRecharge") then
        local s = GameData.GetData("U_firstRecharge", false)
        local v = row2Info[6]
        if s == 1 and v and v[1] == "_gift" then
            table.remove(row2Info, 6)
            create_switch_btn()
        end
    end

    if type(data) == "string" and (string.find(data, "U_enter_tow_map") or string.find(data, "UL_fmcf7")) then
        local has_cf = false
        local index = 7
        for k, tab in pairs(row2Info) do
            if tab[1] == "_gift" then
                index = 7
            end
            if tab[1] == "_cifu" then
                has_cf = true
                index = k
            end
        end
        local old_len = #row2Info
        local _state = GameData.GetData("UL_fmcf7", false) or 0
        local _mark_tow_map = GameData.GetData("U_enter_tow_map", false)
        if has_cf then
            if _state ~= 0 then
                table.remove(row2Info, index)
            end
        else
            if _state == 0 and _mark_tow_map == 1 then
                table.insert(row2Info, index, _cf_btn)
            end
        end
        if #row2Info ~= old_len then
            create_switch_btn()
        end
    end
    if type(data) == "string" and string.find(data,"open_buff_dark") then
        plardark()
    end

    if type(data) == "string" and string.find(data, "HeFuCount") then
        create_switch_btn()
    end
    if type(data) == "string" and (string.find(data, "OpenDay") or string.find(data, "J_everyday_recharge")) then
        create_switch_btn()
    end
end

function plardark()
    local width = SL:GetMetaValue("SCREEN_WIDTH")
    local height = SL:GetMetaValue("SCREEN_HEIGHT")

    local parent = GUI:Attach_LeftTop()
    parent = GUI:getParent(parent)
    parent = GUI:getParent(parent)

    local Image_bg = GUI:getChildByName(parent, 'FrameBG')
    if Image_bg then
        GUI:removeFromParent(Image_bg)
    end

    local Image_bg = GUI:Image_Create(parent, "FrameBG", width / 2, height / 2, "res/custom/dark.png")
    GUI:setLocalZOrder(Image_bg, -1)
    GUI:Image_setScale9Slice(Image_bg, 100, 100, 100, 100)
    GUI:setContentSize(Image_bg, width, height)
    GUI:setAnchorPoint(Image_bg, 0.5, 0.5)
    -- 删除图片
    SL:ScheduleOnce(function ()
        local Image_bg = GUI:getChildByName(parent, 'FrameBG')
        if Image_bg then
            GUI:removeFromParent(Image_bg)
        end
    end, 10)
end



SL:RegisterLUAEvent(LUA_EVENT_GAME_DATA, "TopBtn_recharge", callBack)

local function onClickNpc(npc_info)
    if npc_info.index == 95 then
        onClickTopBtn("RageOBJ")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "TopBtn", onClickNpc)
