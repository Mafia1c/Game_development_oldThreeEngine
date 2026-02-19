GMBoxMgr = {}
GMBoxMgr.cfg = include("QuestDiary/config/godAwakeCfg.lua")
GMBoxMgr.suit_cfg = include("QuestDiary/config/GiveSuitEquipCfg.lua")
local page_ui_list = {
    [1] = [[
        <Text|x=363.0|y=148.0|size=18|color=254|text=《玩家信息查询》>
        <RText|x=190.0|y=189.0|color=255|size=18|text=<累计充值      :    %s/FCOLOR=254>>
        <RText|x=190.0|y=214.0|color=255|size=18|text=<今日充值      :    %s/FCOLOR=254>>
        <RText|x=190.0|y=237.0|color=255|size=18|text=<直购点        :    %s/FCOLOR=254>>
        <RText|x=190.0|y=261.0|color=255|size=18|text=<元宝          :    %s/FCOLOR=254>>
        <RText|x=190.0|y=288.0|color=255|size=18|text=<金刚石        :    %s/FCOLOR=254>>
        <RText|x=190.0|y=314.0|color=255|size=18|text=<灵符          :    %s/FCOLOR=254>>
        <RText|x=190.0|y=339.0|color=255|size=18|text=<绑定元宝      :    %s/FCOLOR=254>>
        <RText|x=190.0|y=364.0|color=255|size=18|text=<绑定金刚石    :    %s/FCOLOR=254>>
        <RText|x=190.0|y=389.0|color=255|size=18|text=<绑定灵符      :    %s/FCOLOR=254>>
        <RText|x=190.0|y=415.0|color=255|size=18|text=<当前等级      :    %s/FCOLOR=254>>
        <Button|x=619|y=150|size=18|color=249|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=解除锁定|link=@_unlock_user>
        <Button|x=619|y=200|size=16|color=249|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=删除觉醒属性|link=@@inputstring1066_0(输入需要删除的装备槽位ID)>
        <Button|x=619|y=250|size=16|color=249|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=删除物品|link=@@inputstring1067_0(输入需要删除的物品的名称#数量)>
    ]],
    [2] = [[
        <ListView|children={2,3,4,5}|x=180|y=189|width=700|height=350|direction=1|bounce=1|margin=2|reload=1>
        <Layout|id=2|children={22,23,24,25,26,27,28}|x=0|y=0|width=700|height=100|scale9b=10|scale9t=10|scale9l=10|esc=0|scale9r=10>
        <Text|id=22|x=0|y=0|size=18|color=251|text=输入全局变量:|link=@@inputstring1000_0(例子：G1、A10)>
        <Text|id=23|x=0|y=50|size=18|color=255|text=查询变量结果:>
        <Img|id=24|x=170.0|y=0|width=150|height=31|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Text|id=25|x=170.0|y=5|size=18|color=255|text=%s>
        <Img|id=26|x=170.0|y=45|width=150|height=31|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Text|id=27|x=170.0|y=50|size=18|color=255|text=%s>
        <Text|id=28|x=380|y=20|size=18|color=250|text=修改全局变量:|link=@@inputstring1003_0(确认要修改变量后在此输入修改值)>

        <Layout|id=3|children={32,33,34,35,36,37,38}|x=0|y=0|width=700|height=100|scale9b=10|scale9t=10|scale9l=10|esc=0|scale9r=10>`
        <Text|id=32|x=0|y=0|size=18|color=251|text=输入个人型变量:|link=@@inputstring1002_0(例子:U,J,Z,T)>
        <Text|id=33|x=0|y=50|size=18|color=255|text=查询变量结果:>
        <Img|id=34|x=170.0|y=0|width=150|height=31|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Text|id=35|x=170.0|y=5|size=18|color=255|text=%s>
        <Img|id=36|x=170.0|y=45|width=150|height=31|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Text|id=37|x=170.0|y=50|size=18|color=255|text=%s>
        <Text|id=38|x=380|y=20|size=18|color=250|text=修改个人变量:|link=@@inputstring1004_0(确认要修改变量后在此输入修改值)>
    ]],
    [3] = [[
        <Text|x=190|y=170|size=18|color=251|text=输入货币名称:|link=@@inputstring1005_0(输入货币名称，例：元宝)>
        <Img|x=400|y=165|width=150|height=31|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Text|x=400|y=170|size=18|color=255|text=%s>
        <Text|x=190|y=220|size=18|color=251|text=修改货币数量:|link=@@inputstring1006_0(确认要修改后在此输入修改)>
        <Img|x=400|y=215|width=150|height=31|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Text|x=400|y=220|size=18|color=255|text=%s>
        <Text|x=190|y=270|size=18|color=251|text=给予玩家道具:|link=@@inputstring1007_0(输入道具名称，例万年雪霜)>
        <Img|x=400|y=265|width=150|height=31|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Text|x=400|y=270|size=18|color=255|text=%s>
        <Text|x=190|y=320|size=18|color=251|text=给予道具数量:|link=@@inputstring1008_0(防止出错，请先输入道具名，在输入数量，数量请大于0)>
        <Img|x=400|y=310|width=150|height=31|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Text|x=400|y=315|size=18|color=255|text=%s>
        <Text|x=600|y=300|size=18|color=250|text=确定补发道具|link=@gmsenditem>
        <Text|x=200|y=400|size=18|color=250|text=扣除背包仓库所有道具|link=@@inputstring1009_0(防止出错，请输入，当前版本道具表，的名称)>
        <Text|x=450|y=400|size=18|color=250|text=扣身上装备|link=@@inputstring1010_0(防止出错，输入物品名称)>
        <Text|x=600|y=400|size=18|color=250|text=扣除唯一ID道具|link=@@inputstring1011_0(防止出错，请输入，玩家物品的唯一ID号)>
        <Button|x=180|y=450|size=18|color=241|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=扣任意称号|link=@@inputstring1012_0>
        <Button|x=300|y=450|size=18|color=241|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=发任意称号|link=@@inputstring1013_0>
        <Button|x=420|y=450|size=18|color=251|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=修复隐藏装备|link=@repair_all_equip>
        <Button|x=540|y=450|size=18|color=251|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=清理转区数据|link=@clear_change_server>
    ]],
    [5] = [[
        <Text|x=190|y=175|size=18|color=251|text=输入要封禁的玩家:>
        <Img|x=400|y=170|width=150|height=25|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Input|inputid=8|isChatInput=0|x=400|y=168|width=150|height=25|type=0|place=输入玩家名称|color=255|size=16>
        <Button|x=600|y=165|submitInput=8|pimg=public/1900000679_1.png|color=255|nimg=public/1900000679.png|size=18|text=永久封禁|link=@role_banned_operate,1>
        <Text|x=190|y=230|size=18|color=251|text=输入要解禁的玩家:>
        <Img|x=400|y=230|width=150|height=25|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Input|inputid=7|isChatInput=0|x=400|y=230|width=150|height=25|type=0|place=输入玩家名称|color=255|size=16>
        <Button|x=600|y=225|submitInput=7|pimg=public/1900000679_1.png|color=255|nimg=public/1900000679.png|size=18|text=确定|link=@role_banned_operate,2>
        <Text|x=190|y=350|size=18|color=251|text=按天数封禁玩家:>
        <Img|x=400|y=350|width=150|height=25|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Input|inputid=6|isChatInput=0|x=400|y=350|width=150|height=25|type=0|place=输入玩家名称|color=255|size=16>
        <Img|x=400|y=400|width=150|height=25|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Input|inputid=5|isChatInput=0|x=400|y=400|width=150|height=25|type=0|place=输入封禁天数|color=255|size=16>
        <Button|x=600|y=350|submitInput=6|pimg=public/1900000679_1.png|color=255|nimg=public/1900000679.png|size=18|text=按天封禁|link=@role_banned_operate,3>
    ]],
    [6] = [[
        <Text|x=190|y=175|size=18|color=251|text=输入玩家BUFFID:>
        <Img|x=500|y=170|width=150|height=25|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Input|inputid=8|isChatInput=0|x=500|y=168|width=150|height=25|type=0|place=输入玩家BUFFID|color=255|size=16>
        <Button|x=200|y=250|submitInput=8|pimg=public/1900000679_1.png|color=255|nimg=public/1900000679.png|size=18|text=查询|link=@check_buff_and_attr,1>
        <Button|x=350|y=250|submitInput=8|pimg=public/1900000679_1.png|color=255|nimg=public/1900000679.png|size=18|text=删除|link=@check_buff_and_attr,2>
        <Button|x=500|y=250|submitInput=8|pimg=public/1900000679_1.png|color=255|nimg=public/1900000679.png|size=18|text=添加|link=@check_buff_and_attr,3>
        <Text|x=190|y=330|size=18|color=251|text=输入玩家ATTID:>
        <Img|x=500|y=330|width=150|height=25|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
        <Input|isChatInput=0|x=500|y=330|width=150|height=25|type=0|place=输入玩家ATTID|color=255|inputid=7|size=16>
        <Button|x=200|y=400|submitInput=7|pimg=public/1900000679_1.png|color=255|nimg=public/1900000679.png|size=18|text=查询|link=@check_buff_and_attr,4>
    ]],
    [7] = [[
        <Button|x=190|y=175|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=250|text=调整等级|link=@@inputstring1014_0(输入需要调整的玩家等级)>
        <Button|x=300|y=175|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=250|text=调整转生|link=@@inputstring1015_0(输入需要调整的转生等级)>
        <Button|x=190|y=230|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=251|text=神龙脊等级|link=@@inputstring1016_0(输入需要调整的神龙脊强化等级)>
        <Button|x=300|y=230|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=251|text=暗龙角等级|link=@@inputstring1017_0(输入需要调整的暗龙角强化等级)>
        <Button|x=410|y=230|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=251|text=邪龙爪等级|link=@@inputstring1018_0(输入需要调整的邪龙爪强化等级)>
        <Button|x=520|y=230|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=251|text=炎龙羽等级|link=@@inputstring1019_0(输入需要调整的炎龙羽强化等级)>
        <Button|x=190|y=280|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=251|text=飞龙皮等级|link=@@inputstring1020_0(输入需要调整的飞龙皮强化等级)>
        <Button|x=300|y=280|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=251|text=天龙眼等级|link=@@inputstring1021_0(输入需要调整的飞龙皮强化等级)>
        <Button|x=410|y=280|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=251|text=苍龙骨等级|link=@@inputstring1022_0(输入需要调整的飞龙皮强化等级)>
        <Button|x=520|y=280|pimg=public/1900000663.png|size=18|nimg=public/1900000662.png|color=255|color=251|text=恶龙鳞等级|link=@@inputstring1023_0(输入需要调整的飞龙皮强化等级)>
        ]],
    }
local backend_ui = [[
    <Img|x=-1.0|y=2.0|width=770|height=540|bg=1|img=public/1900000610.png|show=4|loadDelay=1|move=0|esc=1|reset=1>
    <Layout|x=768.0|y=1.0|width=80|height=80|link=@exit>
    <Button|x=767.0|y=2.0|pimg=public/1900000511.png|nimg=public/1900000510.png|link=@exit>
    <Input|isChatInput=0|x=25.0|y=95.0|width=100|height=25|type=0|place=输入玩家名称|color=255|inputid=9|size=16|text=%s>
    <Text|x=25.0|y=61.0|size=18|color=255|text=账号唯一ID: %s>
    <RText|x=282.0|y=62.0|size=18|color=255|text=<角色名: %s/FCOLOR=250>>
    <Text|x=640.0|y=63.0|size=18|color=251|text=GM管理模式|link=@give_gm_level>
    <Button|x=141.0|y=88.0|size=18|color=255|submitInput=9|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=检查玩家|link=@check_player>
    <Button|x=376.0|y=88.0|size=18|color=255|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=踢他下线|link=@player_offline>
    <Button|x=259.0|y=88.0|size=18|color=255|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=跟踪玩家|link=@follow_player>
    <Button|x=619.0|y=88.0|size=18|color=249|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=补发直购|link=@give_zhigou>
    <Button|x=494.0|y=88.0|size=18|color=249|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=补发充值|link=@@inputstring1024_0(请输入)>
    <Img|x=3.0|y=141.0|width=770|esc=0|img=public/1900000667.png>
    <Button|x=30.0|y=159.0|size=18|color=250|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=玩家信息|link=@player_info>
    <Button|x=30.0|y=204.0|size=18|color=251|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=变量查询|link=@var_query>
    <Button|x=30.0|y=249.0|size=18|color=251|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=货币道具|link=@money_item>
    <Button|x=30.0|y=295.0|size=18|color=251|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=键值操作|link=@key_value>
    <Button|x=30.0|y=341.0|size=18|color=251|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=封禁操作|link=@ban_op>
    <Button|x=30.0|y=387.0|size=18|color=251|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=BUFF操作|link=@buff_op>
    <Button|x=30.0|y=431.0|size=18|color=251|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=等级调整|link=@change_level>
    <Button|x=30.0|y=475.0|size=18|color=249|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=测试脚本界面|link=@show_gm_test_end>
    <Text|x=19.0|y=23.0|size=18|color=255|text=控制后台>
    ]]
local inquire_role_name = ""
local fixed_txt_str = ""
local amend_t_var_list ={
    "xuemaibuff"
} 
-- GM 后台
function GMBoxMgr.showGMBackend(actor)
    if not lualibgm:playerIsGm(actor) then return end
    inquire_role_name = ""
    local name = getbaseinfo(actor, 1)
    local str = "未输入玩家名称"
    local account_id = getconst(actor, "<$USERACCOUNT>")
    fixed_txt_str = str.format(backend_ui,inquire_role_name,account_id,name) 
    local ui_str = fixed_txt_str .. string.format(page_ui_list[1],str, str, str, str, str, str, str, str, str, str)
    say(actor, ui_str)
end
-- 根据玩家名称获取玩家
function GMBoxMgr.GetPlayer(actor)
    local name_str = inquire_role_name
    if getplayerbyname(name_str) == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
    end
    return getplayerbyname(name_str)
end
-- gm 权限
function give_gm_level(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    setgmlevel(obj, 10)
end
-- 检查玩家
function check_player(actor)
    inquire_role_name = getconst(actor, "<$NPCINPUT(9)>")
    local obj = GMBoxMgr.GetPlayer(actor)
    local tips = "名称输入错误或该玩家不在线!"
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", tips, 1)
        return
    else
        tips = "该玩家正在游戏中!"
    end
    local account_id = getconst(obj, "<$USERACCOUNT>")
    fixed_txt_str = string.format(backend_ui,inquire_role_name,account_id,getbaseinfo(actor, 1)) 
    Sendmsg9(actor, "ffffff", tips, 1)
end
-- 踢他下线
function player_offline(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end   
    lualib:CallFuncByClient(obj, "GMBoxMgr")
end
-- 跟踪玩家
function follow_player(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local map_id = getbaseinfo(obj,3)
    local pos_x = getbaseinfo(obj,4)
    local pos_y = getbaseinfo(obj,5)
    mapmove(actor,map_id,pos_x,pos_y)    
end
-- 补发直购
function give_zhigou(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return  Sendmsg9(actor, "ffffff", "请输入玩家名字", 1)
    end    
    messagebox(actor,'可在货币道具初补发货币"直购点"')
end

-- 玩家信息
function player_info(actor)
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local total_recharge = VarApi.getPlayerUIntVar(obj, VarIntDef.TRUE_RECHARGE)
    local today_recharge = VarApi.getPlayerJIntVar(obj, VarIntDef.DAY_RECHARGE)
    local zhi_gou_point = querymoney(obj, 23)
    local yuan_bao = querymoney(obj, 2)
    local jin_gang_shi = querymoney(obj, 5)
    local ling_fu = querymoney(obj, 7)
    local bind_yuan_bao = querymoney(obj, 4)
    local bind_jgs = querymoney(obj, 21)
    local bind_lf = querymoney(obj, 20)
    local level = getbaseinfo(obj, 6)
    local tabs = {total_recharge, today_recharge, zhi_gou_point, yuan_bao, jin_gang_shi, ling_fu, bind_yuan_bao, bind_jgs, bind_lf, level}
    local ui_str = fixed_txt_str .. string.format(page_ui_list[1], unpack(tabs, 1))
    say(actor, ui_str)
end
--解除玩家锁定
function _unlock_user(actor)
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local user_id = getbaseinfo(obj, 2)
    setplaydef(obj, "U88", 0)
    setplaydef(obj, "U89", 0)
    changemode(obj, 10, 1)
    cache_money_change_log[user_id] = {}
    senddelaymsg(obj, "<数据异常, 将在%s秒后解除锁定, 请勿退出游戏!/FCOLOR=249>", 1, 255, 0, "@_____")
    Sendmsg9(actor, "ffffff", "已解除对玩家"..getbaseinfo(obj,1).."的锁定", 1)
end
-- 变量查询
function var_query(actor)
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local tabs = {"←未输入","←未输入","←未输入","←未输入"}
    local ui_str = fixed_txt_str .. string.format(page_ui_list[2], unpack(tabs, 1))
    say(actor, ui_str)
end
-- 货币道具
function money_item(actor)
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end    
    local tabs = {"←未输入","←未输入","←未输入","←未输入"}
    local ui_str = fixed_txt_str .. string.format(page_ui_list[3], unpack(tabs, 1))
    say(actor, ui_str)
end
-- 键值对操作
function key_value(actor)
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end 
    Sendmsg9(actor, "ffffff", "无效按钮", 1)
end
-- 封禁操作
function ban_op(actor) 
    local ui_str = fixed_txt_str .. page_ui_list[5]
    say(actor, ui_str) 
end
-- buff操作
function buff_op(actor)
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end  
    local ui_str = fixed_txt_str .. page_ui_list[6]
    say(actor, ui_str)  
end
-- 等级调整
function change_level(actor)
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end    
    local ui_str = fixed_txt_str .. page_ui_list[7]
    say(actor, ui_str)
end
-- 删除装备
function inputstring1066(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local equip_pos = getconst(actor,"<$NPCPARAMS(1,S22)>")
    equip_pos = tonumber(equip_pos)
    if equip_pos == "" or nil == equip_pos then
        messagebox(actor,"输入为空，请检查输入") 
        return
    end
    local equip = linkbodyitem(obj, equip_pos)
    if equip == "0" then
        Sendmsg9(actor, "ffffff", "装备位上没有装备!", 1)
    else
        local name = getiteminfo(obj, equip, 7)
        local attr_str = getitemcustomabil(actor, equip)
        local attr_tab = json2tbl(attr_str)
        if "" == attr_tab or nil == attr_tab then
            attr_tab = {
                ["abil"] = {}
            }
        end
        attr_tab.abil[1] = nil
        setitemcustomabil(obj, equip, tbl2json(attr_tab))
        Sendmsg9(actor, "ffffff", name.."觉醒属性删除成功", 1)
    end
end
-- 删除物品
function inputstring1067(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    local itemName,itemCount = string.match(str, "([^#]+)#(.+)")
    itemCount = tonumber(itemCount)
    if str == "" or nil == str then
        messagebox(actor,"输入为空，请检查输入") 
        return
    end
    delstorageitembyidx(obj,getstditeminfo(itemName,0))
    local bagCount = getbagitemcount(obj,itemName,0)
    if itemCount >= bagCount then
        itemCount=bagCount
    end
    if not takeitem(obj,itemName,itemCount,0,"gm扣物品") then
        Sendmsg9(actor, "ffffff", itemName.."扣除失败!", 1)
    else
        Sendmsg9(actor, "ffffff", itemName.."扣除"..itemCount.."成功!", 1)
    end
end

--查询全局变量
function inputstring1000(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        messagebox(actor,"输入为空，请检查输入") 
        return
    end
    local var = getsysvar(input_str) 
    if var == nil then
        messagebox(actor,"变量结果为空") 
        return
    end
    GMBoxMgr.global_var_name = input_str 
    messagebox(actor,input_str.."变量结果"..var)
    local tabs = {"变量:"..input_str,"结果:" ..var,"←未输入","←未输入"}
    local ui_str = fixed_txt_str .. string.format(page_ui_list[2], unpack(tabs, 1))
    say(actor, ui_str)
end 
--查询个人变量
function inputstring1002(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        messagebox(actor,"输入为空，请检查输入") 
        return
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        messagebox(actor,"变量结果为空") 
        return
    end
    local var = nil
    if string.find(input_str,"U_") then
        var = VarApi.getPlayerUIntVar(obj, input_str)
    elseif string.find(input_str,"T_") or  isInTable(amend_t_var_list,input_str)  then
        var = VarApi.getPlayerTStrVar(obj, input_str)
    elseif string.find(input_str,"J_") then
        var = VarApi.getPlayerJIntVar(obj, input_str)
    elseif string.find(input_str,"Z_") then
        var = VarApi.getPlayerZStrVar(obj, input_str)
    end
    if var == nil then
        messagebox(actor,"变量结果为空") 
        return 
    end
    GMBoxMgr.private_var_name = input_str 
    messagebox(actor,input_str.."变量结果"..var)
    local tabs = {"←未输入","←未输入","变量:"..input_str,"结果:" ..var,}
    local ui_str = fixed_txt_str .. string.format(page_ui_list[2], unpack(tabs, 1))
    say(actor, ui_str)
end 
--修改全局变量
function inputstring1003(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return
    end

    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "检测玩家为空", 1)
        return
    end
    
    if GMBoxMgr.global_var_name == nil then
        return Sendmsg9(actor, "ffffff", "未设置要修改的变量", 1) 
    end
    messagebox(actor,GMBoxMgr.global_var_name.."变量修改"..input_str) 
    setsysvar(GMBoxMgr.global_var_name,tonumber(input_str) )
    if GMBoxMgr.global_var_name == "G493" or GMBoxMgr.global_var_name == "g493" then
        HeFuTrigger.CleanSysVar()
    end
    if GMBoxMgr.global_var_name == "G495" or GMBoxMgr.global_var_name == "g495" then
        local player_list = getplayerlst(0)
        for i, player in ipairs(player_list or {}) do
            lualib:CallFuncByClient(actor, "OpenDay", getsysvar(VarEngine.OpenDay))
        end
    end
end
--修改个人变量
function inputstring1004(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "检测玩家为空", 1)
        return
    end
    if string.find(GMBoxMgr.private_var_name,"U_") then
        VarApi.setPlayerUIntVar(obj, GMBoxMgr.private_var_name, tonumber(input_str),true)
    elseif string.find(GMBoxMgr.private_var_name,"T_") then
        VarApi.setPlayerTStrVar(obj,  GMBoxMgr.private_var_name,input_str,true)
    elseif string.find(GMBoxMgr.private_var_name,"J_") then
        VarApi.setPlayerJIntVar(obj,  GMBoxMgr.private_var_name,tonumber(input_str),true)
    elseif string.find(GMBoxMgr.private_var_name,"Z_") then
        VarApi.setPlayerZStrVar(obj,  GMBoxMgr.private_var_name,input_str,true)
    else
        return messagebox(actor,"修改失败") 
    end
    messagebox(actor,GMBoxMgr.private_var_name.."变量修改"..input_str) 
end

function inputstring1005(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "检测玩家为空", 1)
        return
    end
    GMBoxMgr.give_money_name = input_str
    flushMoneyAndItemView(actor)
end
function inputstring1006(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "检测玩家为空", 1)
        return
    end
    input_str = tonumber(input_str)
    if input_str == 0 then
        changemoney(obj,getstditeminfo(GMBoxMgr.give_money_name,0),"=",0,"gm",true)
    else
        changemoney(obj,getstditeminfo(GMBoxMgr.give_money_name,0),"+",input_str,"gm",true)
    end
    GMBoxMgr.give_money_count = tonumber(input_str) 
    flushMoneyAndItemView(actor)
    RecordBackendOperationLog(actor, obj, "修改货币", GMBoxMgr.give_money_name, GMBoxMgr.give_money_count)
end
function inputstring1007(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == ""  then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "检测玩家为空", 1)
        return
    end
    local name = getbaseinfo(obj, 1)
    GMBoxMgr.give_item_name = input_str
    flushMoneyAndItemView(actor)
    Sendmsg9(actor, "ffffff", "锁定人物名："..name.."---锁定道具名："..GMBoxMgr.give_item_name , 1)
end
function inputstring1008(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "检测玩家为空", 1)
        return
    end
    GMBoxMgr.give_item_count = tonumber(input_str) 
    flushMoneyAndItemView(actor)
    local name = getbaseinfo(obj, 1)
    Sendmsg9(actor, "ffffff", "锁定人物名："..name.."---锁定道具数："..GMBoxMgr.give_item_count , 1)
end
--扣除背包仓库所有道具
function inputstring1009(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or input_str ~= "cfg_item" then
        Sendmsg9(actor, "ffffff", "表名不正确", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    for k, v in pairs( getbagitems(obj) or {}) do
        local name = getiteminfo(obj,v,7)
        local count = getbagitemcount(obj,name)
        if count > 0 then
            takeitemex(obj,name,tonumber(count))
        end
    end
    for k, v in pairs(getstorageitems(obj) or {}) do
        local idx = getiteminfo(obj,v,1)
        if idx then
            delstorageitem(obj,idx)
        end
    end 
    Sendmsg9(actor, "ffffff", "操作成功", 1)
    RecordBackendOperationLog(actor, obj, "扣除背包仓库所有道具", "道具表", input_str)
end
--扣除身上装备
function inputstring1010(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    if takew(obj,input_str,1,"gm") then
        Sendmsg9(actor, "ffffff", input_str.."扣除成功", 1)
        RecordBackendOperationLog(actor, obj, "扣除身上装备", input_str, "1")
    else
        Sendmsg9(actor, "ffffff", input_str.."扣除失败", 1)
    end
end

--扣除唯一id道具
function inputstring1011(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local item = getitembymakeindex(obj, input_str)
    if delitembymakeindex(obj,tostring(input_str) ) then
        Sendmsg9(actor, "ffffff", input_str.."扣除成功", 1)

        local item_name = getiteminfo(obj, item, 7)
        RecordBackendOperationLog(actor, obj, "扣除唯一ID道具", item_name, "1")
    else
        Sendmsg9(actor, "ffffff", input_str.."扣除失败", 1)
    end
end
--扣除称号
function inputstring1012(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    if deprivetitle(obj,input_str) then
        Sendmsg9(actor, "ffffff", input_str.."扣除成功", 1)
        RecordBackendOperationLog(actor, obj, "删除称号", input_str, "1")
    else
        Sendmsg9(actor, "ffffff", input_str.."扣除失败", 1)
    end
end
--扣除称号
function inputstring1013(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    if confertitle(obj,input_str) then
        Sendmsg9(actor, "ffffff", input_str.."添加成功", 1)
        RecordBackendOperationLog(actor, obj, "添加称号", input_str, "1")
    else
        Sendmsg9(actor, "ffffff", input_str.."添加失败", 1)
    end
end
--修复所有装备
function repair_all_equip(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    repairall(obj)
    Sendmsg9(actor, "ffffff","修复成功", 1)
end
--清理转区数据
function clear_change_server(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local mainServiceId = getconst(actor, "<$MAINTONGSERVER>")
    if tonumber(mainServiceId) <= 0 then
        return Sendmsg9(actor, "ffffff", "未设置主区", 1)
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local account_id = getconst(obj, "<$USERACCOUNT>")
    deliniitem('QuestDiary/zhuanqu.ini', "zq", account_id)
    updatemaintongfile(mainServiceId, '..\\QuestDiary\\zhuanqu.ini', '..\\QuestDiary\\zhuanqu.ini')
    local server_Id = globalinfo(11)
    local zq_data = {}
    zq_data.can_get_all_num = 0
    zq_data.already_get_num =  0
    zq_data.zhuanqu_id = server_Id
    VarApi.setPlayerTStrVar(obj,"zhuanqu_data",tbl2json(zq_data))
end

--封禁操作
--1 封禁  2 解禁 3 天数封禁  暂时没用
function role_banned_operate(actor,click_type)
    if not lualibgm:playerIsGm(actor) then return end
    click_type = tonumber(click_type)
    local banned_name = "" 
    if click_type == 1 then
        banned_name = getconst(actor, "<$NPCINPUT(8)>")
        if banned_name == "" then
            return Sendmsg9(actor, "ffffff", "请输入玩家名字", 1)
        end
        local res1 = checktextlist('..\\DenyChrNameList.txt',banned_name)
        if res1 then
            messagebox(actor,"玩家名："..banned_name.."\\该玩家已被封禁")
            return     
        end
        gmexecute(actor,"DenyCharNameLogon",banned_name,1)
        messagebox(actor,"已经封禁玩家："..banned_name)
        local obj = getplayerbyname(banned_name)
        if obj ~= nil and obj ~= "" then
            messagebox(obj,"【系统提示】：当前角色已被封禁\\如有疑问请联系客服处理！","@gm_banned_ok,"..obj)
            delaygoto(obj,5000,"gm_quit_game",0)
        end
    elseif click_type == 2 then
        banned_name = getconst(actor, "<$NPCINPUT(7)>")
        if banned_name == "" then
            return Sendmsg9(actor, "ffffff", "请输入玩家名字", 1)
        end
        local res1 = checktextlist('..\\DenyChrNameList.txt',banned_name)
        if res1 then
            gmexecute(actor,"DelDenyCharNameLogon",banned_name)
        else
            messagebox(actor,"该玩家未被封禁")
        end
    elseif click_type == 3 then
        banned_name = getconst(actor, "<$NPCINPUT(6)>")
        if banned_name == "" then
            return Sendmsg9(actor, "ffffff", "请输入玩家名字", 1)
        end
        local res1 = checktextlist('..\\DenyChrNameList.txt',banned_name)
        if res1 then
            messagebox(actor,"玩家名："..banned_name.."\\该玩家已被封禁")
            return     
        end
        gmexecute(actor,"DenyCharNameLogon",banned_name,0)
        messagebox(actor,"已经封禁玩家："..banned_name)
        local obj = getplayerbyname(banned_name)
        if obj ~= nil and obj ~= "" then
            messagebox(obj,"【系统提示】：当前角色已被封禁\\如有疑问请联系客服处理！","@gm_banned_ok,"..obj)
            delaygoto(obj,5000,"gm_quit_game",0)
        end
    end
end
--1 查询buff，2删除，3 添加 4查询属性id
function check_buff_and_attr(actor,click_type)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    click_type = tonumber(click_type)
    local input_str = click_type < 4 and getconst(actor, "<$NPCINPUT(8)>") or getconst(actor, "<$NPCINPUT(7)>")
    if click_type < 4 then
        if tonumber(input_str) == nil then
            return Sendmsg9(actor, "ffffff", "请正确输入BUFFID", 1)
        end 
    end 
    if click_type == 1 then
        local buff_level = getbuffinfo(obj,tonumber(input_str) ,1) or 0
        messagebox(actor,"本次查询的BUFFID:"..input_str..",BUFF层数："..buff_level)
    elseif click_type == 2 then
        delbuff(obj,tonumber(input_str))
        Sendmsg9(actor, "ffffff", "本次删除BUFF:"..input_str ,1)
    elseif click_type == 3 then
        addbuff(obj,tonumber(input_str))
        local buff_level = getbuffinfo(obj,tonumber(input_str) ,1)
        Sendmsg9(actor, "ffffff", "本次添加BUFF:"..input_str.."BUFF层数："..buff_level, 1)
    elseif click_type == 4 then
        local attr_value =  getbaseinfo(obj,51,tonumber(input_str))
        messagebox(actor,"本次查询的ATTID:"..input_str.."|属性值"..attr_value)
    end
end
--调整等级
function inputstring1014(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local name = getbaseinfo(obj,1)
    changelevel(obj,"=",tonumber(input_str))
    Sendmsg9(actor, "ffffff", "调整玩家"..name.."等级为："..input_str, 1)
end
--调整转生
function inputstring1015(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "输入为空", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local name = getbaseinfo(obj,1)
    setbaseinfo(obj,39,tonumber(input_str))
    Sendmsg9(actor, "ffffff", "调整玩家"..name.."转生等级为："..input_str, 1)
end
--调整神龙脊强化等级
function inputstring1016(actor)
    if not lualibgm:playerIsGm(actor) then return end
    GMBoxMgr.setzongshi_level(actor,87)
end

--调整暗龙角强化等级
function inputstring1017(actor)
    if not lualibgm:playerIsGm(actor) then return end
    GMBoxMgr.setzongshi_level(actor,89)
end
--调整邪龙爪强化等级
function inputstring1018(actor)
    if not lualibgm:playerIsGm(actor) then return end
    GMBoxMgr.setzongshi_level(actor,91)
end
--调整炎龙羽强化等级
function inputstring1019(actor)
    if not lualibgm:playerIsGm(actor) then return end
    GMBoxMgr.setzongshi_level(actor,93)
end
--调整飞龙皮强化等级
function inputstring1020(actor)
    if not lualibgm:playerIsGm(actor) then return end
    GMBoxMgr.setzongshi_level(actor,88)
end
--调整天龙眼强化等级
function inputstring1021(actor)
    if not lualibgm:playerIsGm(actor) then return end
    GMBoxMgr.setzongshi_level(actor,88)
end
--调整苍龙骨强化等级
function inputstring1022(actor)
    if not lualibgm:playerIsGm(actor) then return end
    GMBoxMgr.setzongshi_level(actor,92)
end

--调整恶龙鳞强化等级
function inputstring1023(actor)
    if not lualibgm:playerIsGm(actor) then return end
    GMBoxMgr.setzongshi_level(actor,94)
end
-- 补发充值
function inputstring1024(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end 
    local name = getbaseinfo(obj,1)
    messagebox(actor,string.format("是否为玩家：%s，补发充值%s元",name, input_str),"@gm_recharge_ok,"..obj..","..input_str,"@gm_recharge_no")
end
function gm_recharge_ok(actor,obj,gold)
    if not lualibgm:playerIsGm(actor) then return end
    gold = tonumber(gold) 
    VarApi.setPlayerJIntVar(obj, VarIntDef.DAY_RECHARGE,VarApi.getPlayerJIntVar(obj, VarIntDef.DAY_RECHARGE) + gold,true)        -- 今日充值
    VarApi.setPlayerUIntVar(obj, VarIntDef.TRUE_RECHARGE, VarApi.getPlayerUIntVar(obj, VarIntDef.TRUE_RECHARGE) + gold,true)     -- 总充值
    changemoney(obj,7,"+",gold*10,"gm",true)

    RecordBackendOperationLog(actor, obj, "补发充值", "真充", gold)
end 
function gm_banned_ok(actor,obj)
    openhyperlink(obj,34,0)
end
function gm_quit_game(actor)
    openhyperlink(actor,34,0)
end
function GMBoxMgr.setzongshi_level(actor,equip_pos)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local star = tonumber(input_str)
    if star <= 0 then
        Sendmsg9(actor, "ffffff", "等级需大于0", 1)
        return 
    end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local equipObj = linkbodyitem(obj,equip_pos)
    setitemaddvalue(obj,equipObj,2,3,star)
    VarApi.setPlayerUIntVar(obj,"UL_godAwake"..equip_pos,star,true)
    local attrstr = GMBoxMgr.getattrstr(actor,1,star)
    setaddnewabil(obj, equip_pos, "=", attrstr)
    Sendmsg9(actor, "ffffff", "调整成功",1)
    lualib:FlushNpcUi(obj,"godAwakeOBJ","强化")
end
function GMBoxMgr.getattrstr(actor,index,star)
    if not lualibgm:playerIsGm(actor) then return end
    if GMBoxMgr.cfg[index]["level_arr"][star] == nil then
        return Sendmsg9(actor, "ffffff", "请正确输入等级", 1)
    end
    local infoTab = GMBoxMgr.cfg[GMBoxMgr.cfg[index]["level_arr"][star]]
    local attrstr = ""
    for i = 1, 8 do
        if i == 1 then
            attrstr = infoTab["attrstr" .. i]
        elseif infoTab["attrstr" .. i] then
            attrstr = attrstr .. "|" .. infoTab["attrstr" .. i]
        end
    end
    return attrstr
end
function flushMoneyAndItemView(actor)
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local tabs = {GMBoxMgr.give_money_name or "←未输入",GMBoxMgr.give_money_count or "←未输入", GMBoxMgr.give_item_name or "←未输入",GMBoxMgr.give_item_count or "←未输入"}
    local ui_str = fixed_txt_str .. string.format(page_ui_list[3], unpack(tabs, 1))
    say(actor, ui_str)
end
function gmsenditem(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    if  GMBoxMgr.give_item_name == nil or tonumber(GMBoxMgr.give_item_count) == nil then
        return 
    end
    local name = getbaseinfo(obj, 1)
    messagebox(actor,"请确认给玩家:"..name.."\\发送道具：" .. GMBoxMgr.give_item_name .. "发送数量："..GMBoxMgr.give_item_count.."个！\\请谨慎操作，以免错误！","@func_ok","@func_no")
end
function func_ok(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetPlayer(actor)
    if nil == obj or "" == obj then
        return
    end
    local name = getbaseinfo(obj, 1)
    sendmail(getbaseinfo(obj, 2),1,"系统补发","你好【"..name.."】以下是你反馈获BUG的补发物品！",GMBoxMgr.give_item_name.."#"..GMBoxMgr.give_item_count)
    flushMoneyAndItemView(actor)
    RecordBackendOperationLog(actor, obj, "补发道具", GMBoxMgr.give_item_name, GMBoxMgr.give_item_count)
    GMBoxMgr.give_item_name = nil
    GMBoxMgr.give_item_count = nil
end
----------------------------------------------------------GM测试脚本---------------------------------------------------------------------------------------
local testbackend_ui = [[
    <Img|x=-1.0|y=2.0|width=770|height=540|bg=1|img=public/1900000610.png|show=4|loadDelay=1|move=0|esc=1|reset=1>
    <Layout|x=768.0|y=1.0|width=80|height=80|link=@exit>
    <Button|x=767.0|y=2.0|pimg=public/1900000511.png|nimg=public/1900000510.png|link=@exit>
    <Text|ax=0|ay=1|x=28|y=60|color=254|size=18|text=当前区服： 服务器ID：%s>
    <Text|ax=0|ay=1|x=28.0|y=90|size=18|color=254|text=开区天数：%s天>
    <Text|ax=0|ay=1|x=28.0|y=120|size=18|color=254|text=开区分钟：%s分钟>
    <Text|ax=0|ay=1|x=28|y=150|size=18|color=251|text=合区次数：%s合>
    <Text|ax=0|ay=1|x=28.0|y=180|color=251|size=18|text=合服天数：%s>
    <Text|ax=0|ay=1|x=28|y=210|color=255|size=18|text=跨服状态：%s>
    <Text|ax=0|ay=1|x=28.0|y=240|color=255|size=18|text=攻城状态：%s>
    <Text|ax=0|ay=1|x=200|y=23|color=249|size=18|text=通区主区id：%s>
    <Button|x=350|y=65.0|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=开启攻城|link=@shabake_state,1>
    <Button|x=350|y=110|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=结束攻城|link=@shabake_state,2>
    <Button|x=350|y=155|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=开启沙奖|link=@shabake_state,3>
    <Button|x=490|y=65|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=开启天数|link=@@inputstring1025_0(最低天数为1)>
    <Button|x=490|y=110|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=开区分钟|link=@@inputstring1048_0(最低为1)>
    <Button|x=490|y=155|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=合区次数|link=@@inputstring1026_0(请输入)>
    <Button|x=630|y=65|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=装备套装|link=@open_equip_view>
    <Button|x=630|y=110|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=调整等级|link=@@inputstring1027_0(请输入)>
    <Button|x=630|y=155|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=调整转生|link=@@inputstring1028_0(请输入)>
    <Button|x=630|y=200|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=添加称号|link=@@inputstring1029_0(添加称号：输入具体称号全名)>
    <Button|x=630|y=245|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=删除称号|link=@@inputstring1030_0(删除称号：输入具体称号全名，输入0清空所有称号)>
    <Button|x=630|y=290|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=重载所有表格|link=@no_fun_tip>
    <Button|x=270|y=210|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=253|text=激情粽王开关|link=@no_fun_tip>
    <Button|x=400|y=210|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=253|text=龙舟竞速开关|link=@no_fun_tip>
    <Button|x=520|y=210|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=253|text=清理祥瑞排名|link=@clear_xiangrui>
    <Button|x=30|y=268|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=开启押镖|link=@set_activity_state,普通押镖,9>
    <Button|x=150|y=268|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=天降财宝|link=@set_activity_state,天降财宝,1>
    <Button|x=270|y=268|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=财富广场|link=@set_activity_state,财富广场,3>
    <Button|x=400|y=268|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=行会争霸|link=@set_activity_state,行会争霸,4>
    <Button|x=520|y=268|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=激情夺宝|link=@set_activity_state,激情夺宝,6>
    <Button|x=30|y=330|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=道具操作|link=@@inputstring1031_0(输入格式：元宝#3000，输入元宝#0为清空)>
    <Button|x=150|y=330|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=在线充值|link=@@inputstring1032_0>
    <Button|x=270|y=330|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=乱斗之王|link=@set_activity_state,乱斗之王,7>
    <Button|x=400|y=330|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=250|text=双倍押镖|link=@set_activity_state,双倍押镖,2>
    <Button|x=30|y=392|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=开启秒怪|link=@open_miaosha>
    <Button|x=150|y=392|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=添加BUFF|link=@@inputstring1033_0>
    <Button|x=270|y=392|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=删除BUFF|link=@@inputstring1034_0>
    <Button|x=400|y=392|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=清理首爆|link=@clear_first_drop>
    <Button|x=30|y=454|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=临时测试|link=@no_fun_tip>
    <Button|x=150|y=454|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=技能效果|link=@no_fun_tip>
    <Button|x=270|y=454|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=调整属性|link=@@inputstring1035_0>
    <Button|x=400|y=454|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=249|text=管理员模式|link=@no_fun_tip>
    <Button|x=520|y=330|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=253|text=刷新年兽BOSS|link=@flush_nianshou>
    <Button|x=520|y=392|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=253|text=端午活动开关|link=@no_fun_tip>
    <Button|x=520|y=454|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=清理远古异界|link=@clear_ygyj>
    <Button|x=630|y=454|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=清理背包|link=@clean_self_bag>
    <Button|x=630|y=392|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=关闭活动|link=@@inputstring1053_0(输入ActivityCfg配置对应活动名字)>
    <Text|x=19.0|y=23.0|size=18|color=255|text=测试后台>
    ]]
    
local taozhuang_ui = [[
    <Img|x=-1.0|y=2.0|width=770|height=540|bg=1|img=public/1900000610.png|show=4|loadDelay=1|move=0|esc=1|reset=1>
    <Layout|x=768.0|y=1.0|width=80|height=80|link=@exit>
    <Button|x=767.0|y=2.0|pimg=public/1900000511.png|nimg=public/1900000510.png|link=@exit>
    <Button|x=20|y=66|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=祖玛首饰(无)|link=@give_suit_self,1>
    <Button|x=140|y=66|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=赤月系列|link=@give_suit_self,2>
    <Button|x=260|y=66|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=雷霆系列|link=@give_suit_self,3>
    <Button|x=400|y=66|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=强化系列|link=@give_suit_self,4>
    <Button|x=520|y=66|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=战神首饰|link=@give_suit_self,5>
    <Button|x=640|y=66|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=圣魔首饰|link=@give_suit_self,6>
    <Button|x=20|y=120|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=真魂首饰|link=@give_suit_self,7>
    <Button|x=140|y=120|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=火龙战首饰|link=@give_suit_self,8>
    <Button|x=260|y=120|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=火龙魔首饰|link=@give_suit_self,9>
    <Button|x=400|y=120|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=火龙道首饰|link=@give_suit_self,10>
    <Button|x=520|y=120|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=天龙战首饰|link=@give_suit_self,11>
    <Button|x=640|y=120|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=天龙魔首饰|link=@give_suit_self,12>
    <Button|x=20|y=174|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=天龙道首饰|link=@give_suit_self,13>
    <Button|x=140|y=174|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=神龙战首饰|link=@give_suit_self,14>
    <Button|x=260|y=174|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=神龙魔首饰|link=@give_suit_self,15>
    <Button|x=400|y=174|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=神龙道首饰|link=@give_suit_self,16>
    <Button|x=520|y=174|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=聖龍战首饰|link=@give_suit_self,17>
    <Button|x=640|y=174|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=聖龍魔首饰|link=@give_suit_self,18>
    <Button|x=20|y=228|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=聖龍道首饰|link=@give_suit_self,19>
    <Button|x=140|y=228|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=宗师战首饰|link=@give_suit_self,20>
    <Button|x=260|y=228|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=宗师魔首饰|link=@give_suit_self,21>
    <Button|x=400|y=228|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=宗师道首饰|link=@give_suit_self,22>
    <Button|x=520|y=228|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=宗师战.圣|link=@give_suit_self,23>
    <Button|x=640|y=228|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=宗师魔.圣|link=@give_suit_self,24>
    <Button|x=20|y=282|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=宗师道.圣|link=@give_suit_self,25>
    <Button|x=140|y=282|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=战神剑甲|link=@give_suit_self,26>
    <Button|x=260|y=282|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=火龙剑甲|link=@give_suit_self,27>
    <Button|x=400|y=282|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=天龙剑甲|link=@give_suit_self,28>
    <Button|x=520|y=282|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=神龙剑甲|link=@give_suit_self,29>
    <Button|x=640|y=282|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=聖龍剑甲|link=@give_suit_self,30>
    <Button|x=20|y=336|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=宗师剑甲|link=@give_suit_self,31>
    <Button|x=140|y=336|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=宗师剑甲.圣|link=@give_suit_self,32>
    <Button|x=260|y=336|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=魔血石|link=@give_suit_self,33>
    <Button|x=400|y=336|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=斗笠|link=@give_suit_self,34>
    <Button|x=520|y=336|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=盾牌|link=@give_suit_self,35>
    <Button|x=640|y=336|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=勋章|link=@give_suit_self,36>
    <Button|x=20|y=390|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=神符|link=@give_suit_self,37>
    <Button|x=140|y=390|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=生肖|link=@give_suit_self,38>
    <Button|x=20|y=480|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=临时测试|link=@no_fun_tip>
    <Button|x=640|y=480|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=清理背包|link=@clean_self_bag>
    ]]
---GM测试脚本
function show_gm_test_end(actor)
    local cur_server_id = globalinfo(11)
    local open_day =  getsysvar(VarEngine.OpenDay)
    local open_sever_time = math.floor(getsysvar(VarEngine.RunTime)/60) 
    local hefu_count = getsysvar(VarEngine.HeFuCount)
    local hefu_day = getconst("0", "<$HFDAYS>")
    local kuafu_str = checkkuafuconnect() and "已连接" or "跨服未连接"
    local gongsha_str = castleinfo(5) and "攻沙中" or "未开启"
    local mainServiceId = getconst(actor, "<$MAINTONGSERVER>")
    local tabs ={cur_server_id,open_day,open_sever_time,hefu_count,hefu_day,kuafu_str,gongsha_str,mainServiceId}
    say(actor, string.format(testbackend_ui,unpack(tabs, 1)))
end
--沙巴克操作
function shabake_state(actor,click_type)
    if not lualibgm:playerIsGm(actor) then return end
    click_type = tonumber(click_type)
    if click_type < 3 then
        addtocastlewarlistex("*")
        gmexecute(actor,"ForcedWallConQuestwar")
    else
        local point = VarApi.getPlayerJIntVar(actor, "J_castlewar_point")
        if castleidentity(actor) == 0 then
            if point >= 1200 then
                changemoney(actor, 7, "+", CastleWarTrigger.loser_reward, "攻沙奖励~~", true)
                Sendmsg9(actor, "ffffff", "获得攻沙奖励x"..CastleWarTrigger.loser_reward.."灵符", 1)
            else
                Sendmsg9(actor, "ffffff", "无奖励领取", 1)
            end
        elseif castleidentity(actor) > 0 then
            changemoney(actor, 7, "+", CastleWarTrigger.winner_reward, "攻沙奖励~~", true)
            Sendmsg9(actor, "ffffff", "获得攻沙奖励x"..CastleWarTrigger.winner_reward.."灵符", 1)
        end
    end
    show_gm_test_end(actor)
end
--调整开区分钟
function inputstring1048(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil or tonumber(input_str) < 1  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local time = getsysvar(VarEngine.OpenServerTime) 
    if time > 0 and getsysvar(VarEngine.ActiveStartFlag) > 0  then
        local old_run_time = os.time() - time
        setsysvar(VarEngine.RunTime, old_run_time)
        setsysvar(VarEngine.OpenServerTime,0) 
        if not hasscheduled("gm_update_全局机器人_runtime") then
            addscheduled("gm_update_全局机器人_runtime",'SEC',3,'@_update_run_time2')
        end
        show_gm_test_end(actor)
        return Sendmsg9(actor, "ffffff", "本次更新旧开区分钟，请再次设置开区时间", 1)
    end
    setsysvar(VarEngine.RunTime,tonumber(input_str) * 60)
    ActivityMgr.FlushRunMinActivityState() 
    show_gm_test_end(actor)
end 
function _update_run_time2()
    local start_sever_time = getsysvar(VarEngine.RunTime)
    start_sever_time = start_sever_time + 3
    setsysvar(VarEngine.RunTime, start_sever_time)
end
--调整开区天数
function inputstring1025(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil or tonumber(input_str) < 0  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    setsysvar(VarEngine.OpenDay,tonumber(input_str))
    lualib:CallFuncByClient(actor, "OpenDay", getsysvar(VarEngine.OpenDay))
    ActivityMgr.FlushRunMinActivityState() 
    show_gm_test_end(actor)
end
--调整合区次数
function inputstring1026(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    setsysvar(VarEngine.HeFuCount,tonumber(input_str) )
    HeFuTrigger.CleanSysVar()
    show_gm_test_end(actor)
end
--调整自身等级
function inputstring1027(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end

    changelevel(actor,"=",tonumber(input_str))
    Sendmsg9(actor, "ffffff", "等级为："..input_str, 1)
end
--调整自身转生等级
function inputstring1028(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    setbaseinfo(actor,39,tonumber(input_str))
    Sendmsg9(actor, "ffffff", "转生等级为："..input_str, 1)
end
--添加自身称号
function inputstring1029(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if confertitle(actor,input_str) then
        Sendmsg9(actor, "ffffff", "已添加称号："..input_str, 1)
    else
        Sendmsg9(actor, "ffffff", "添加称号失败！", 1)
    end
end
--删除自身称号
function inputstring1030(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if tonumber(input_str) and tonumber(input_str) == 0 then
        local list = newgettitlelist(actor)
        for k, v in pairs(list or {}) do
            local titleName = getstditeminfo(k,1)
            deprivetitle(actor,titleName)
        end
        Sendmsg9(actor, "ffffff", "删除所有称号", 1)
    else
        if deprivetitle(actor,input_str) then
            Sendmsg9(actor, "ffffff", "已删除称号："..input_str, 1)
        else
            Sendmsg9(actor, "ffffff", "删除称号失败！", 1)
        end
    end 
end
--开启活动
function set_activity_state(actor,active_name,index)
    if not lualibgm:playerIsGm(actor) then return end
    local open_state = ActivityMapLogic:GetActiveIsOpen(tonumber(index))
    if active_name == "双倍押镖" then
        ActivityMgr:CompelActivityState("双倍押镖活动1",open_state ~= 1)
    elseif active_name == "普通押镖" then
        ActivityMgr:CompelActivityState("押镖活动",open_state ~= 1)
    elseif active_name == "天降财宝" then
        ActivityMgr:CompelActivityState("天降财宝1",open_state ~= 1)
    elseif active_name == "财富广场" then
        ActivityMgr:CompelActivityState("财富广场1",open_state ~= 1)
    elseif active_name == "行会争霸" then
        ActivityMgr:CompelActivityState("行会争霸1",open_state ~= 1)
    elseif active_name == "激情夺宝" then
        ActivityMgr:CompelActivityState("激情夺宝1",open_state ~= 1)
    elseif active_name == "乱斗之王" then
        ActivityMgr:CompelActivityState("乱斗之王1",open_state ~= 1)
    end
end
function inputstring1053(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    ActivityMgr:CompelActivityState(input_str,false)
end

--道具操作
function inputstring1031(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if string.find(input_str,"#") then
       local item_tab = strsplit(input_str,"#") 
       if #item_tab == 2 and tonumber(item_tab[2]) ~= nil then
            if tonumber(item_tab[2]) == 0 then --清空道具
                local item_id = getstditeminfo(item_tab[1],0)
                if item_id < 10000 then
                    changemoney(actor,item_id,"=",0,"gm清空",true)
                else
                    local count = getbagitemcount(actor,item_tab[1])
                    takeitemex(actor,item_tab[1],count)
                end
                RecordBackendOperationLog(actor, actor, "清空道具", item_tab[1], item_tab[2])
            else  --增加
                gives(actor,input_str,"[gives]刷物品")
                RecordBackendOperationLog(actor, actor, "道具补发", item_tab[1], item_tab[2])
            end
       end
    end
end
--在线充值
function inputstring1032(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local gold = tonumber(input_str) 
    VarApi.setPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE,VarApi.getPlayerJIntVar(actor, VarIntDef.DAY_RECHARGE) + gold,true)        -- 今日充值
    VarApi.setPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE, VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) + gold,true)     -- 总充值
    changemoney(actor,7,"+",gold*10,"gm",true)
end
--添加buff
function inputstring1033(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if addbuff(actor,tonumber(input_str)) then
        local layer = getbuffinfo(actor,tonumber(input_str),1)
        Sendmsg9(actor, "ffffff", "本次添加buff"..input_str.."层数"..layer, 1)
    else
        Sendmsg9(actor, "ffffff", "添加失败", 1)
    end
end
--删除buff
function inputstring1034(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end

    delbuff(actor,tonumber(input_str))
    Sendmsg9(actor, "ffffff", "删除BUFF"..input_str, 1)

end
--清理首爆
function clear_first_drop(actor)
    if not lualibgm:playerIsGm(actor) then return end
    setsysvar(VarEngine.FristEquip, tbl2json({}))
    VarApi.setPlayerTStrVar(actor,VarStrDef.FRIST_EQUIP,tbl2json({}))
    Sendmsg9(actor, "ffffff", "操作成功", 1)
end
--调整属性
function inputstring1035(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    addattlist(actor,"gm属性","=","3#"..input_str)
end
--一键秒杀
function open_miaosha(actor)
    if not lualibgm:playerIsGm(actor) then return end
    addattlist(actor,"对怪秒杀","=","3#74#9999999999999")
end
--清理自己背包
function clean_self_bag(actor)
    if not lualibgm:playerIsGm(actor) then return end
    gmexecute(actor,"clearbag")
    Sendmsg9(actor, "ffffff", "操作成功", 1)
end
--装备套装ui
function open_equip_view(actor)
    if not lualibgm:playerIsGm(actor) then return end
    say(actor, taozhuang_ui)
end
function give_suit_self(actor,index)
    if not lualibgm:playerIsGm(actor) then return end
    index = tonumber(index)
    local cfg = GMBoxMgr.suit_cfg[index]
    if cfg and cfg.equip_list  then
        for i,v in ipairs(cfg.equip_list) do
            giveitem(actor, v, 1, 127)
        end
    end
end
function clear_ygyj(actor)
    if not lualibgm:playerIsGm(actor) then return end
    for i = 1, 5 do
        VarApi.setPlayerUIntVar(actor, "T_ygyj_week_defeat_num"..i,0)
    end
    Sendmsg9(actor, "ffffff", "清理成功", 1)
    messagebox(actor,"周奖励清理成功,是否清理总奖励","@clear_ygyj_total","@no_clear_ygyj_total")
end
function clear_ygyj_total(actor)
    if not lualibgm:playerIsGm(actor) then return end
    for i = 1, 5 do
        VarApi.setPlayerUIntVar(actor, "T_ygyj_defeat_num"..i,0)
    end
    Sendmsg9(actor, "ffffff", "清理成功", 1)
end
-------------------------------------------------------------GS后台---------------------------------------------------
local gs_page_ui_list = {
    [1] ={
        [1] = [[
            <Text|x=350|y=150|size=18|color=255|text=本页设定仅生效一次>
            <Button|x=200|y=160|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉武器|link=@set_equip_assign_dorp,1>
            <Button|x=200|y=200|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉衣服|link=@set_equip_assign_dorp,0>
            <Text|x=350|y=180|size=18|color=249|text=已锁定玩家：%s>
            <Text|x=350|y=210|size=18|color=31|text=死亡后必掉：%s>
            <Button|submitInput=9|x=200|y=240|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉头盔|link=@set_equip_assign_dorp,4>
            <Button|x=280|y=240|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉项链|link=@set_equip_assign_dorp,3>
            <Button|x=360|y=240|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉左镯|link=@set_equip_assign_dorp,6>
            <Button|x=440|y=240|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉左戒|link=@set_equip_assign_dorp,8>
            <Button|x=200|y=280|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉右镯|link=@set_equip_assign_dorp,5>
            <Button|x=280|y=280|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉右戒|link=@set_equip_assign_dorp,7>
            <Button|x=360|y=280|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉腰带|link=@set_equip_assign_dorp,10>
            <Button|x=440|y=280|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉靴子|link=@set_equip_assign_dorp,11>
            <Button|x=520|y=280|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=掉秘宝|link=@set_equip_assign_dorp,14>
            <Img|x=3.0|y=320|width=770|esc=0|img=public/1900000667.png>
            <Button|x=600|y=400|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=清空产出|link=@reset_monster_drop>
        ]],
        [2]=[[
            <Text|x=300|y=325|size=16|color=251|text=锁定玩家打怪爆出指定物品>
            <Text|x=200|y=350|size=18|color=255|text=输入怪物名字：>
            <Text|x=330|y=345|size=18|width=300|color=255|text=%s|link=@@inputstring1036_0>
            <Text|x=200|y=380|size=18|color=255|text=输入装备名字：>
            <Text|x=330|y=380|size=18|color=255|width=300|text=%s|link=@@inputstring1037_0(输入掉落装备，多个装备#分割。例子：木剑#腰带)>
            <Button|x=600|y=345|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=确定设置|link=@set_monster_drop>
        ]],
        [3]=[[
            <Text|x=300|y=450|size=18|color=250|text=剑甲大师必出最高属性次数：%s|link=@@inputstring1045_0(输入次数)>
        ]]
    },
    [2] = [[
        <Text|x=150|y=160|size=18|color=250|text=攻速+%s|link=@@inputstring1038_0(输入要加的数值)>
        <Text|x=300|y=160|size=18|color=250|text=攻击力+%s|link=@@inputstring1039_0(输入要加的数值)>
        <Text|x=450|y=160|size=18|color=250|text=防御+%s|link=@@inputstring1040_0(输入要加的数值)>
        <Text|x=600|y=160|size=18|color=250|text=pk增伤+%s|link=@@inputstring1041_0(输入要加的数值)>
        <Text|x=150|y=200|size=18|color=250|text=杀人爆装几率+%s|link=@@inputstring1042_0(输入要加的数值)>
        <Text|x=320|y=200|size=18|color=250|text=防爆装几率+%s|link=@@inputstring1043_0(输入要加的数值)>
        <Text|x=470|y=200|size=18|color=250|text=pk减伤+%s|link=@@inputstring1044_0(输入要加的数值)>
        <Button|x=600|y=200|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=清空设定|link=@clear_gs_attr>
    ]],
    [3] = [[
        <Text|x=150|y=170|size=18|color=255|text=加白账号：>
        <Text|x=250|y=170|size=18|color=250|text=%s|link=@@inputstring1046_0(输入账号唯一id)>
        <Text|x=150|y=210|size=18|color=255|text=加强化概率：>
        <Text|x=250|y=210|size=18|color=250|text=%s|link=@@inputstring1047_0(输入增加概率)>
        <Text|x=450|y=210|size=18|color=255|text=当前概率提升：%s%%>
        <Text|x=150|y=250|size=18|color=255|text=加秘宝觉醒强化概率：>
        <Text|x=330|y=250|size=18|color=250|text=%s|link=@@inputstring1049_0(输入增加概率)>
        <Text|x=450|y=250|size=18|color=255|text=当前概率提升：%s%%> 
        <Text|x=150|y=290|size=18|color=255|text=加幸运项链概率：>
        <Text|x=300|y=290|size=18|color=250|text=%s|link=@@inputstring1050_0(输入增加概率)>
        <Text|x=450|y=290|size=18|color=255|text=当前概率提升：%s%%> 
        <Text|x=150|y=330|size=18|color=255|text=加灵装强化概率：>
        <Text|x=300|y=330|size=18|color=250|text=%s|link=@@inputstring1051_0(输入增加概率)>
        <Text|x=450|y=330|size=18|color=255|text=当前概率提升：%s%%> 
        <Text|x=150|y=370|size=18|color=255|text=一大陆秘宝觉醒概率：>
        <Text|x=330|y=370|size=18|color=250|text=%s|link=@@inputstring1052_0(输入增加概率)>
        <Text|x=450|y=370|size=18|color=255|text=当前概率提升：%s%%> 

        <Text|x=150|y=410|size=18|color=255|text=三大陆根骨概率：>
        <Text|x=330|y=410|size=18|color=250|text=%s|link=@@inputstring1054_0(输入增加概率)>
        <Text|x=450|y=410|size=18|color=255|text=当前概率提升：%s%%> 

        <Text|x=150|y=450|size=18|color=255|text=四大陆根骨概率：>
        <Text|x=330|y=450|size=18|color=250|text=%s|link=@@inputstring1055_0(输入增加概率)>
        <Text|x=450|y=450|size=18|color=255|text=当前概率提升：%s%%> 

        <Text|x=150|y=490|size=18|color=255|text=专属强化概率：>
        <Text|x=330|y=490|size=18|color=250|text=%s|link=@@inputstring1056_0(输入增加概率)>
        <Text|x=450|y=490|size=18|color=255|text=当前概率提升：%s%%> 
        <Button|x=650|y=150|nimg=public/1900000679.png|pimg=public/1900000679_1.png|size=18|color=255|text=血石觉醒|link=@@inputstring1057_0(格式：位置#属性id。等级填72,忽视防御 58，暴击 66，例子2#72代表二号位置必出等级+1)>
        ]],
    }
local gsbackend_ui = [[
    <Img|x=-1.0|y=2.0|width=770|height=540|bg=1|img=public/1900000610.png|show=4|loadDelay=1|move=0|esc=1|reset=1>
    <Layout|x=768.0|y=1.0|width=80|height=80|link=@exit>
    <Button|x=767.0|y=2.0|pimg=public/1900000511.png|nimg=public/1900000510.png|link=@exit>
    <Input|isChatInput=0|x=400|y=90|width=150|height=25|type=0|place=输入玩家名称|color=255|inputid=9|size=16|text=%s>
    <Img|x=400|y=90|width=150|height=25|esc=0|img=public/1900000676.png|scale9r=10|scale9t=10|scale9b=10|scale9l=10>
    <RText|x=200|y=90|size=18|color=255|text=<角色名: %s/FCOLOR=250>>
    <Button|x=600|y=80|size=18|color=255|submitInput=9|mimg=public/1900000661.png|nimg=public/1900000660.png|pimg=public/1900000660_1.png|text=检查玩家|link=@check_gs_player>
    <Img|x=3.0|y=141.0|width=770|esc=0|img=public/1900000667.png>
    <Button|submitInput=9|x=20|y=159|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=装备发射器|link=@assign_equip_drop>
    <Button|x=20|y=204|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=255|text=调整属性|link=@change_attr_self_or_role>
    <Button|x=20|y=249|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=调整概率|link=@change_odds>
    <Button|x=20|y=295|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=清天下第一|link=@clear_txdy>
    <Button|x=20|y=340|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=清理捐献|link=@clear_juanxian>
    <Button|x=20|y=385|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=后台日志|link=@show_backend_log>
    <Button|x=20|y=430|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=觉醒路目标1|link=@change_awake_road_point1>
    <Button|x=20|y=475|nimg=public/1900000680.png|pimg=public/1900000680_1.png|size=18|color=251|text=查转区数据|link=@_look_player_zhuanqu>
    <Text|x=19.0|y=23.0|size=18|color=255|text=GS后台>
    ]]
local equip_pos_name = {
    [0] = "衣服",
    [1] = "武器",
    [3] = "项链",
    [4] = "头盔",
    [5] = "右镯",
    [6] = "左镯",
    [7] = "右戒",
    [8] = "左戒",
    [10] = "腰带",
    [11] = "靴子",
    [14] = "秘宝",
    }
local monster_equip_name ,target_monster_name = nil,nil
local gs_init_role_name = ""
--打开gs后台
function GMBoxMgr.show_gm_gs_end(actor)
    if not lualibgm:playerIsGm(actor) then return end
    gs_init_role_name = ""
    monster_equip_name = nil
    target_monster_name = nil
    fixed_txt_str = string.format(gsbackend_ui,"",getbaseinfo(actor, 1)) 
    say(actor,fixed_txt_str)
end
function GMBoxMgr.GetGsPlayer(actor)
    local name_str = gs_init_role_name
    if getplayerbyname(name_str) == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
    end
    return getplayerbyname(name_str)
end
-- 检查玩家
function check_gs_player(actor)
    gs_init_role_name = getconst(actor, "<$NPCINPUT(9)>")
    local obj = GMBoxMgr.GetGsPlayer(actor)
    local tips = "名称输入错误或该玩家不在线!"
    if nil == obj or "" == obj then
        gs_init_role_name = ""
    else
        tips = "该玩家正在游戏中!"
    end
    fixed_txt_str = string.format(gsbackend_ui,gs_init_role_name,getbaseinfo(actor, 1)) 
    Sendmsg9(actor, "ffffff", tips, 1)
end
local equip_top_str,equip_down_str,jj_dashi_str = ""
--打开装备发射器
function assign_equip_drop(actor)
    if not lualibgm:playerIsGm(actor) then return end
    equip_top_str = string.format(gs_page_ui_list[1][1],"","")
    equip_down_str = string.format(gs_page_ui_list[1][2],"点我输入","点我输入")
    jj_dashi_str = string.format(gs_page_ui_list[1][3],0)
    say(actor,fixed_txt_str.. equip_top_str..equip_down_str..jj_dashi_str)
end

--调整属性
function change_attr_self_or_role(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetGsPlayer(actor)
    if obj == nil then return end
    local gs_attr_value_list = json2tbl(VarApi.getPlayerTStrVar(obj,"T_gs_attr_value_list"))
    if gs_attr_value_list == "" then
        gs_attr_value_list = {
            [1] = {[1] = {attr_id = 20,value = 0},},
            [2] = {[1] = {attr_id = 3,value = 0},[2] = {attr_id = 4,value = 0}},
            [3] = {[1] = {attr_id = 9,value = 0},[2] = {attr_id = 10,value = 0}},
            [4] = {[1] = {attr_id = 76,value = 0},},
            [5] = {[1] = {attr_id = 32,value = 0},},
            [6] = {[1] = {attr_id = 33,value = 0},},
            [7] = {[1] = {attr_id = 77,value = 0},},
        }
        VarApi.setPlayerTStrVar(obj,"T_gs_attr_value_list",tbl2json(gs_attr_value_list))
    end
    say(actor,fixed_txt_str.. string.format(gs_page_ui_list[2],gs_attr_value_list[1][1].value,gs_attr_value_list[2][1].value,
    gs_attr_value_list[3][1].value,gs_attr_value_list[4][1].value,gs_attr_value_list[5][1].value,gs_attr_value_list[6][1].value,gs_attr_value_list[7][1].value))
end
--#region 完成觉醒之路目标1
function change_awake_road_point1(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetGsPlayer(actor)
    if obj == nil then return end
    local hastab = json2tbl(VarApi.getPlayerTStrVar(obj,"TL_awakeRoadNode"))--#region 节点是否领取变量
    if hastab == "" then;hastab = {} end
    for i = 1, 19 do
        hastab[tostring(i).."1"] = 1
    end
    hastab = tbl2json(hastab)
    VarApi.setPlayerTStrVar(obj, "TL_awakeRoadNode", hastab, true)
    Sendmsg9(actor,"ff0000",gs_init_role_name.."觉醒之路任务目标1已全完成！",1)
    RecordBackendOperationLog(actor, obj, "觉醒之路任务目标1已全完成记录", "", "")
end

--调整概率
local gs_add_account = nil
local gs_odds_list = {}

function change_odds(actor)
    if not lualibgm:playerIsGm(actor) then return end
    gs_add_account = nil
    gs_odds_list = {}
    say(actor,fixed_txt_str .. string.format(gs_page_ui_list[3],"请输入账号", "请输入概率",0,"请输入概率",0,"请输入概率",0,"请输入概率",0,"请输入概率",0,
    "请输入概率",0,"请输入概率",0,"请输入概率",0))
end
function set_equip_assign_dorp(actor,pos)
    if not lualibgm:playerIsGm(actor) then return end
    pos = tonumber(pos)
    release_print(pos)
    if gs_init_role_name == "" or gs_init_role_name == nil then
       return Sendmsg9(actor, "ffffff", "请检查玩家是否在线", 1)
    end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
        return
    end

    local equip_name = getiteminfo(obj, linkbodyitem(obj, pos), 7)
    local obj_name = getbaseinfo(obj,1) 
    if equip_name == "" or equip_name == nil then
        equip_name = "无穿戴"
    else
        setitemstate(linkbodyitem(obj, pos),7,1)
        Sendmsg9(actor, "ffffff", string.format("已设置玩家：%s,%s 死亡必定掉落",obj_name,equip_pos_name[pos]), 1)
    end
    equip_top_str = string.format(gs_page_ui_list[1][1],obj_name,equip_pos_name[pos].."："..equip_name)
    say(actor,fixed_txt_str..equip_top_str..equip_down_str..jj_dashi_str)
end
--设置指定怪物
function inputstring1036(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    target_monster_name = input_str
    equip_down_str = string.format(gs_page_ui_list[1][2],target_monster_name,monster_equip_name or "点我输入")
    say(actor,fixed_txt_str..equip_top_str..equip_down_str..jj_dashi_str)
end
function inputstring1037(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    monster_equip_name = input_str
    equip_down_str = string.format(gs_page_ui_list[1][2],target_monster_name or "点我输入",monster_equip_name)
    say(actor,fixed_txt_str..equip_top_str..equip_down_str..jj_dashi_str)
end
--攻速
function inputstring1038(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
        return
    end
    set_gs_attr_value(obj,actor,1,input_str)
end
--攻击力
function inputstring1039(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
        return
    end
    set_gs_attr_value(obj,actor,2,input_str)
end
--防御
function inputstring1040(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
        return
    end
    set_gs_attr_value(obj,actor,3,input_str)
end
--pk增伤
function inputstring1041(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
        return
    end
    set_gs_attr_value(obj,actor,4,input_str)
end
--杀人爆装几率
function inputstring1042(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
        return
    end
    set_gs_attr_value(obj,actor,5,input_str)
end
--防爆装几率
function inputstring1043(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
        return
    end
    set_gs_attr_value(obj,actor,6,input_str)
end
--pk减伤
function inputstring1044(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
        return
    end
    set_gs_attr_value(obj,actor,7,input_str)
end
function set_gs_attr_value(obj,actor,index,value)
    if not lualibgm:playerIsGm(actor) then return end
    local gs_attr_value_list = json2tbl(VarApi.getPlayerTStrVar(obj,"T_gs_attr_value_list"))
    if gs_attr_value_list == "" then
        gs_attr_value_list = {}
    end
    for k,v in pairs( gs_attr_value_list[index]) do
        v.value = v.value + tonumber(value) 
    end
    VarApi.setPlayerTStrVar(obj,"T_gs_attr_value_list",tbl2json(gs_attr_value_list))
    say(actor,fixed_txt_str.. string.format(gs_page_ui_list[2],gs_attr_value_list[1][1].value,gs_attr_value_list[2][1].value,
    gs_attr_value_list[3][1].value,gs_attr_value_list[4][1].value,gs_attr_value_list[5][1].value,gs_attr_value_list[6][1].value,gs_attr_value_list[7][1].value))

    delbuff(obj,30004)
    local buff_attr = {}
    for i,v in ipairs(gs_attr_value_list) do
        for k,info in pairs(v) do
            buff_attr[info.attr_id] = info.value 
        end
    end
    addbuff(obj,30004,0,1,actor,buff_attr)
end
function clear_gs_attr(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        Sendmsg9(actor, "ffffff","请检查玩家", 1)
        return
    end
    delbuff(obj,30004)
    local gs_attr_value_list = {
        [1] = {[1] = {attr_id = 20,value = 0},},
        [2] = {[1] = {attr_id = 3,value = 0},[2] = {attr_id = 4,value = 0}},
        [3] = {[1] = {attr_id = 9,value = 0},[2] = {attr_id = 10,value = 0}},
        [4] = {[1] = {attr_id = 76,value = 0},},
        [5] = {[1] = {attr_id = 32,value = 0},},
        [6] = {[1] = {attr_id = 33,value = 0},},
        [7] = {[1] = {attr_id = 77,value = 0},},
    }
    VarApi.setPlayerTStrVar(obj,"T_gs_attr_value_list",tbl2json(gs_attr_value_list))
    say(actor,fixed_txt_str.. string.format(gs_page_ui_list[2],gs_attr_value_list[1][1].value,gs_attr_value_list[2][1].value,
    gs_attr_value_list[3][1].value,gs_attr_value_list[4][1].value,gs_attr_value_list[5][1].value,gs_attr_value_list[6][1].value,gs_attr_value_list[7][1].value))
    Sendmsg9(actor, "ffffff","清空成功", 1)
end

function set_monster_drop(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        return
    end
    if target_monster_name == "" or target_monster_name == nil then
        return Sendmsg9(actor, "ffffff", "请输入怪物名字", 1)
    end
    if monster_equip_name == "" or monster_equip_name == nil then
        return Sendmsg9(actor, "ffffff", "请设置怪物掉落装备", 1)
    end
    local data = {monster_name = target_monster_name,equip_list_str = string.gsub(monster_equip_name,"#","|")}
    Sendmsg9(actor, "ffffff", string.format("已设置怪物：%s 死亡必定掉落：%s",target_monster_name,monster_equip_name) , 1)
    VarApi.setPlayerTStrVar(obj,"T_set_target_drop_equip", tbl2json(data))
end
function reset_monster_drop(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        return
    end
    Sendmsg9(actor, "ffffff", "已还原怪物必掉", 1)
    VarApi.setPlayerTStrVar(obj,"T_set_target_drop_equip", "")
end
--剑甲大师概率
function inputstring1045(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        return
    end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    VarApi.setPlayerUIntVar(obj,"U_gs_wq_certainly_count",tonumber(input_str))
    VarApi.setPlayerUIntVar(obj,"U_gs_yf_certainly_count",tonumber(input_str))
    jj_dashi_str = string.format(gs_page_ui_list[1][3],input_str)
    if tonumber(input_str)  > 0 then
        Sendmsg9(actor, "ffffff", string.format("已设置剑甲大师%s次必出最高属性",input_str) , 1)
    end
    say(actor,fixed_txt_str..equip_top_str..equip_down_str..jj_dashi_str)
end 
--增加白名单
function inputstring1046(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    gs_add_account = input_str
    GMBoxMgr.flush_gs_odds_view(actor)
end
--设置装备强化概率
function inputstring1047(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if gs_add_account == nil then
        Sendmsg9(actor, "ffffff", "请先输入账号", 1)
        return 
    end
    gs_odds_list[1] = input_str
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    if type(list) ~= "table"  then
        list = {}
    end
    list[gs_add_account] = list[gs_add_account] or {}
    list[gs_add_account]["equip_stren_odds"] = gs_odds_list[1]
    setsysvar(VarEngine.StrenthenAccountList,tbl2json(list)) 
    Sendmsg9(actor, "ffffff", string.format("已设置账号%s强化概率提升%s%%",gs_add_account,gs_odds_list[1]) , 1)
    GMBoxMgr.flush_gs_odds_view(actor)
end
--设置秘宝觉醒概率
function inputstring1049(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if gs_add_account == nil then
        Sendmsg9(actor, "ffffff", "请先输入账号", 1)
        return 
    end
    gs_odds_list[2] = input_str
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    if type(list) ~= "table"  then
        list = {}
    end
    list[gs_add_account] = list[gs_add_account] or {}
    list[gs_add_account]["mibaoawake_odds"] = gs_odds_list[2]
    setsysvar(VarEngine.StrenthenAccountList,tbl2json(list)) 
    Sendmsg9(actor, "ffffff", string.format("已设置账号%s秘宝觉醒概率提升%s%%",gs_add_account,gs_odds_list[2]) , 1)
    GMBoxMgr.flush_gs_odds_view(actor)
end

--设置幸运项链概率
function inputstring1050(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if gs_add_account == nil then
        Sendmsg9(actor, "ffffff", "请先输入账号", 1)
        return 
    end
    gs_odds_list[3] = input_str
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    if type(list) ~= "table"  then
        list = {}
    end
    list[gs_add_account] = list[gs_add_account] or {}
    list[gs_add_account]["luck_necklace_odds"] = gs_odds_list[3]
    setsysvar(VarEngine.StrenthenAccountList,tbl2json(list)) 
    Sendmsg9(actor, "ffffff", string.format("已设置账号%s秘宝觉醒概率提升%s%%",gs_add_account,gs_odds_list[3]) , 1)
    GMBoxMgr.flush_gs_odds_view(actor)
end

--设置灵装强化概率
function inputstring1051(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if gs_add_account == nil then
        Sendmsg9(actor, "ffffff", "请先输入账号", 1)
        return 
    end
    gs_odds_list[4] = input_str
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    if type(list) ~= "table"  then
        list = {}
    end
    list[gs_add_account] = list[gs_add_account] or {}
    list[gs_add_account]["lzqh_odds"] = gs_odds_list[4]
    setsysvar(VarEngine.StrenthenAccountList,tbl2json(list)) 
    Sendmsg9(actor, "ffffff", string.format("已设置账号%s秘宝觉醒概率提升%s%%",gs_add_account,gs_odds_list[4]) , 1)
    GMBoxMgr.flush_gs_odds_view(actor)
end

--设置一大陆秘宝觉醒概率
function inputstring1052(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if gs_add_account == nil then
        Sendmsg9(actor, "ffffff", "请先输入账号", 1)
        return 
    end
    gs_odds_list[5] = input_str
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    if type(list) ~= "table"  then
        list = {}
    end
    list[gs_add_account] = list[gs_add_account] or {}
    list[gs_add_account]["one_mbjx_odds"] = gs_odds_list[5]
    setsysvar(VarEngine.StrenthenAccountList,tbl2json(list)) 
    Sendmsg9(actor, "ffffff", string.format("已设置账号%s一大陆秘宝觉醒概率提升%s%%",gs_add_account,gs_odds_list[5]) , 1)
    GMBoxMgr.flush_gs_odds_view(actor)
end

--三大陆根骨
function inputstring1054(actor)
    release_print(444545)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if gs_add_account == nil then
        Sendmsg9(actor, "ffffff", "请先输入账号", 1)
        return 
    end
    gs_odds_list[6] = input_str
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    if type(list) ~= "table"  then
        list = {}
    end
    list[gs_add_account] = list[gs_add_account] or {}
    list[gs_add_account]["tm1_bodds"] = gs_odds_list[6]
    setsysvar(VarEngine.StrenthenAccountList,tbl2json(list)) 
    Sendmsg9(actor, "ffffff", string.format("已设置账号%s三大陆根骨概率提升%s%%",gs_add_account,gs_odds_list[6]) , 1)
    GMBoxMgr.flush_gs_odds_view(actor)
end
--四大陆根骨
function inputstring1055(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if gs_add_account == nil then
        Sendmsg9(actor, "ffffff", "请先输入账号", 1)
        return 
    end
    gs_odds_list[7] = input_str
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    if type(list) ~= "table"  then
        list = {}
    end
    list[gs_add_account] = list[gs_add_account] or {}
    list[gs_add_account]["tm2_bodds"] = gs_odds_list[7]
    setsysvar(VarEngine.StrenthenAccountList,tbl2json(list)) 
    Sendmsg9(actor, "ffffff", string.format("已设置账号%s四大陆根骨概率提升%s%%",gs_add_account,gs_odds_list[7]) , 1)
    GMBoxMgr.flush_gs_odds_view(actor)
end
--专属强化
function inputstring1056(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" or tonumber(input_str) == nil  then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if gs_add_account == nil then
        Sendmsg9(actor, "ffffff", "请先输入账号", 1)
        return 
    end
    gs_odds_list[8] = input_str
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    if type(list) ~= "table"  then
        list = {}
    end
    list[gs_add_account] = list[gs_add_account] or {}
    list[gs_add_account]["zsqh_bodds"] = gs_odds_list[8]
    setsysvar(VarEngine.StrenthenAccountList,tbl2json(list)) 
    Sendmsg9(actor, "ffffff", string.format("已设置账号%s专属强化概率提升%s%%",gs_add_account,gs_odds_list[8]) , 1)
    GMBoxMgr.flush_gs_odds_view(actor)
end
function inputstring1057(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        return
    end
    local tab = strsplit(input_str,"#")
    if tab[1] == nil or tab[2] == nil then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return
    end
    VarApi.setPlayerTStrVar(obj,"T_gs_xueshijuexing",input_str)
    Sendmsg9(actor, "ffffff", "下次血石觉醒必出属性", 1)
end

function GMBoxMgr.flush_gs_odds_view(actor)
    if not lualibgm:playerIsGm(actor) then return end   
    local list = json2tbl(getsysvar(VarEngine.StrenthenAccountList)) 
    local equip_strent_odds ,mibao_awake_odds ,luck_necklace_odds,lzqh_odds,one_mbjx_odds,tm1_bodds,tm2_bodds,zsqh_bodds= 0,0,0,0,0,0,0,0
    if type(list) == "table" and list[gs_add_account] then
        equip_strent_odds = list[gs_add_account]["equip_stren_odds"] or 0
        mibao_awake_odds = list[gs_add_account]["mibaoawake_odds"] or 0
        luck_necklace_odds = list[gs_add_account]["luck_necklace_odds"] or 0
        lzqh_odds = list[gs_add_account]["lzqh_odds"] or 0
        one_mbjx_odds = list[gs_add_account]["one_mbjx_odds"] or 0
        tm1_bodds = list[gs_add_account]["tm1_bodds"] or 0
        tm2_bodds = list[gs_add_account]["tm2_bodds"] or 0
        zsqh_bodds = list[gs_add_account]["zsqh_bodds"] or 0
    end
    local tip_str = "请输入概率"
    local str = string.format(gs_page_ui_list[3],gs_add_account,gs_odds_list[1] or tip_str,equip_strent_odds,
    gs_odds_list[2] or tip_str,mibao_awake_odds,gs_odds_list[3] or tip_str,luck_necklace_odds ,gs_odds_list[4] or tip_str,lzqh_odds,
    gs_odds_list[5] or tip_str,one_mbjx_odds,gs_odds_list[6] or tip_str,tm1_bodds,gs_odds_list[7] or tip_str,tm2_bodds,
    gs_odds_list[8] or tip_str,zsqh_bodds
    )
    say(actor,fixed_txt_str .. str)
end
--清理天下第一
function clear_txdy(actor)
    if not lualibgm:playerIsGm(actor) then return end
    messagebox(actor,"是否确定清理天下第一数据","@clear_txdy_ok","@no_clear")
end
function clear_txdy_ok(actor)
    if not lualibgm:playerIsGm(actor) then return end
    setsysvar(VarEngine.WorldNo1Rank, "")
    Sendmsg9(actor, "ffffff", "清理成功", 1)
end
--清理捐献
function clear_juanxian(actor)
    -- setsysvar(VarEngine.donate, "")
    -- Sendmsg9(actor, "ffffff", "已清理", 1)
end
--清理祥瑞
function clear_xiangrui(actor)
    if not lualibgm:playerIsGm(actor) then return end
    setsysvar(VarEngine.luckTreasure, "")
    Sendmsg9(actor, "ffffff", "已清理", 1)
end
--刷新年兽
function flush_nianshou(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local mon_list = {"子鼠启运兽", "丑牛耕耘兽", "寅虎驱邪兽", "卯兔捣药兽", "辰龙赐福兽", "巳蛇蜕厄兽","午马奔腾兽","未羊护生兽","申猴闹春兽","酉鸡报喜兽","戌狗守岁兽","亥猪纳福兽",}
    local number = getsysvar(VarEngine.HeFuCount) --#region 合服次数
    local map_id = number == 0 and "祥瑞迷宫新区" or "祥瑞迷宫合区"
    for index, value in ipairs(mon_list) do
        if getmoncount(map_id, getdbmonfieldvalue(value, "idx"), true) < 1 then
            genmon(map_id,0,0,value,1000,1,249) --#region 刷怪
        end
    end
    Sendmsg9(actor, "ffffff", "已刷新", 1)
end
--无功能
function no_fun_tip(actor)
    Sendmsg9(actor, "ffffff", "按钮无功能", 1)
end


-- 显示后台操作日志
function show_backend_log(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local tmp_list = {"2", "1354735642"}
    if not isInTable(tmp_list, account_id) then
        Sendmsg9(actor, "ff0000", "无效操作!", 1)
        return
    end
    local op_log_tab = GetBackendOperationLog()
    local list = "<ListView|children={%s}|x=130|y=150|width=700|height=370|direction=1|bounce=1|margin=10|reload=1>"
    local format = "<Text|id=%s|x=0|y=0|size=16|color=150|text=%s>"
    local show_str = ""
    local id = ""
    for i = 1, #op_log_tab do
        show_str = show_str .. string.format(format, i, op_log_tab[i])
        id = i .. "," ..id
    end
    local say_str = string.format(list, id)
    say_str = say_str .. show_str
    say_str = string.format(gsbackend_ui,"",getbaseinfo(actor, 1)) .. say_str
    say(actor, say_str)
end

-- 记录gm后台操作日志
function RecordBackendOperationLog(op_actor, target_obj, op_type, param1, param2)
    local gm_name = getbaseinfo(op_actor, 1)
    local name = getbaseinfo(target_obj, 1)
    local time = GetMonth().. "/" .. GetDay() .. "-" .. GetHour() .. ":" .. GetMin()
    local op_log = getsysvar(VarEngine.SysOpLog)
    if "" == op_log then
        op_log = {}
    else
        op_log = json2tbl(op_log)
    end
    local str = string.format("【%s】: [%s] - [GM后台] -给玩家 【%s】 %s [%s # %s]", gm_name, time, name, op_type, param1, param2)
    op_log[#op_log + 1] = str
    setsysvar(VarEngine.SysOpLog, tbl2json(op_log))
end
-- 获取gm后台操作日志
function GetBackendOperationLog()
    local op_log = getsysvar(VarEngine.SysOpLog)
    if "" == op_log then
        op_log = {}
    else
        op_log = json2tbl(op_log)
    end
    return op_log
end

function _look_player_zhuanqu(actor)
    if not lualibgm:playerIsGm(actor) then return end
    local obj = GMBoxMgr.GetGsPlayer(actor)  
    if obj == nil then
        return
    end
    local account_id = getconst(obj, "<$USERACCOUNT>")
    local strfmt = [[
        <ListView|children={1}|x=130|y=150|width=700|height=300|direction=1|bounce=1|margin=10|reload=1>
        <RText|id=1|width=600|text=%s|color=255|>

        ]]
    local str =  readini('QuestDiary/zhuanqu.ini',"zq",account_id)
    if str == nil or str == "" then
        str = VarApi.getPlayerTStrVar(obj,"zhuanqu_data")
    end
   
    if str == nil or str == "" then
        str = "没有此玩家数据！！！！"
    end
    local str = "账号id："..account_id .."数据：\\"..  str
    strfmt =string.format(strfmt,str)
    say(actor, fixed_txt_str..strfmt)
end