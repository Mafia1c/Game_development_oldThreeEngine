-- 使用道具触发
UseItemTrigger = {}
UseItemTrigger.disguiseCfg = include("QuestDiary/config/disguiseCfg.lua") --#region 装扮

---双击使用道具前触发
---*  actor: 玩家对象
---@param actor string 玩家对象
---@param itemObj obj 道具对象
---@param itemIdx number 道具idx
---@param itemMakeIndex number 道具唯一id
---@param itemNum number 道具数量
---@param stdMode number 物品表stdMode参数
---@return boolean 是否允许使用
function UseItemTrigger.useItem(actor, itemObj, itemIdx, itemMakeIndex, itemNum, stdMode)
    local itemName = getstditeminfo(itemIdx,1) --#region 道具名称
    local map_name = getbaseinfo(actor, 45)     -- 当前所在地图名称
    local map_id = getbaseinfo(actor, 3)        -- 当前所在地图id
    if getbagitemcount(actor,itemName) <= 0 then
        Sendmsg9(actor, "ff0000", "背包无此物品！", 1)
        return false
    end

    local fun_tab = {  --#region 一定有返回是否允许使用     所有需要检查跨服是否可使用的道具都放到这里面实现
        ["变性卡"] = function ()
            if getbaseinfo(actor,8) == 0 then
                setbaseinfo(actor,8,1)
            else
                setbaseinfo(actor,8,0)
            end
            Sendmsg9(actor, "ffffff", "转换性别成功！", 1)
            return true
        end,
        ["盟重传送石"] = function ()
            mapmove(actor, 3, 330, 329, 4)
            setdura(actor, itemMakeIndex, "-", 1000)
            if getiteminfo(actor, itemObj, 3) <= 0 then
                delitembymakeindex(actor, itemMakeIndex, 1, "持久用完了!")
            end
            return false
        end,
        ["随机传送石"] = function ()
            map(actor, map_id)
            setdura(actor, itemMakeIndex, "-", 1000)
            if getiteminfo(actor, itemObj, 3) <= 0 then
                delitembymakeindex(actor, itemMakeIndex, 1, "持久用完了!")
            end
            return false
        end,
        ["迷失之城随机石"] = function ()
            if nil == string.find(map_name, "迷失之城") then
                Sendmsg9(actor, "ffffff", "只能在迷失之城使用！", 1)
                return false
            end
            map(actor, getbaseinfo(actor, 3))
            return true
        end,
        ["伽马药剂"] = function ()
            if nil == string.find(map_name, "武道大会") then
                Sendmsg9(actor, "ffffff", "只能在武道大会地图使用！", 1)
                return false
            end
            VarApi.setPlayerUIntVar(actor, "U_use_gamayaoji", 1)
            return true
        end,
        ["超级祝福油"] = function ()
            local eq = linkbodyitem(actor, 1)
            local v = getitemaddvalue(actor, eq, 1, 5, 1)
            if v > 6 then
                Sendmsg9(actor, "ffffff", "武器最高幸运强化到+7，请不要重复升级！", 1)
                return false
            end
            if v >= 0 and v < 7 then
                v = v + 1
                setitemaddvalue(actor, eq, 1, 5, v)
                Sendmsg9(actor, "ffffff", "武器增加幸运成功，当前武器幸运："..v, 1)
            end
            
            return true
        end,
        ["红名清洗卡"] = function ()
            setbaseinfo(actor, 46, 0)
            Sendmsg9(actor, "ffffff", "您的PK值已经清理！", 1)
            return true
        end,
        ["祝福罐"] = function ()
            local bag_count = getbagblank(actor)
            if bag_count < 5 then
                Sendmsg9(actor, "ffffff", "背包已满，请先确保背包内有足够空间！", 1)
                return false
            end
            giveitem(actor, "祝福油", 1)
            return true
        end, 
        ["金条"] = function ()
            changemoney(actor, 1, "+", 1000000 * itemNum, "消耗金条获得金币!", true)
            return true
        end,
        ["金砖"] = function ()
            changemoney(actor, 1, "+", 5000000 * itemNum, "消耗金砖获得金币!", true)
            return true
        end,
        ["金盒"] = function ()
            changemoney(actor, 1, "+", 10000000 * itemNum, "消耗金盒获得金币!", true)
            return true
        end,
        ["三倍经验卷(30分钟)"] = function ()
            addbuff(actor, 50034)
            Sendmsg9(actor, "ffffff", "使用成功！", 1)
            return true
        end,
        ["五倍经验卷(30分钟)"] = function ()
            addbuff(actor, 50035)
            Sendmsg9(actor, "ffffff", "使用成功！", 1)
            return true
        end,
        ["元宝福袋"] = function ()
            local value = math.random(100, 10000) * itemNum
            changemoney(actor, 4, "+", value, "消耗元宝福袋活得绑定元宝!", true)
            Sendmsg9(actor, "ffffff", "获得：元宝x"..value, 1)
            return true
        end,
        ["秘宝礼盒"] = function()
            local item_names = {"尸蟞丹", "摸金符", "昆仑胎", "凤凰胆", "金刚伞", "发丘印"}
            local item = item_names[math.random(1, #item_names)]
            giveitem(actor, item, 1)
            Sendmsg9(actor, "ffffff", "开启成功获得："..item, 1)
            return true
        end,
        ["秘宝宝箱"] = function()
            opendragonbox(actor, 1, 1)      -- 需要在 cfg_box表中配置
            return false
        end,
        ["千里传音"] = function ()
            local level = getbaseinfo(actor, 6)
            if level < 55 then
                Sendmsg9(actor, "ffffff", "等级达到55级可以使用！", 1)
                return false
            end
            local str1 = "<Img|img=public/bg_npc_04.jpg|bg=1|show=4|esc=1|move=0|reset=1|loadDelay=1>"
            local str2 = "<Layout|x=533.0|y=-17.0|width=80|height=80|link=@exit>"
            local str3 = "<Button|x=546.0|y=-0.0|pimg=public/1900000511.png|nimg=public/1900000510.png|link=@exit>"
            local str4 = "<RText|x=185.0|y=33|color=255|size=18|outline=1|text=<千里传音　全服喊话/FCOLOR=253>>"
            local str5 = "<RText|x=49.0|y=84|color=255|size=18|outline=1|text=<信息将显示在世界频道，全服玩家屏幕中间滚动刷屏1次！/FCOLOR=254>>"
            local str6 = "<Button|x=412.0|y=201.0|size=18|pimg=public/1900000680_1.png|color=250|submitInput=2|nimg=public/1900000680.png|text=发送喊话|link=@send_world_say>"
            local str7 = "<Img|x=75.0|y=200.0|width=320|img=public/1900015004.png|esc=0>"
            local str8 = "<Input|ax=0|ay=1|x=79.0|y=204.0|width=310|height=32|color=255|type=0|inputid=2|size=18>"
            local str9 = "<RText|x=104.0|y=135|color=255|size=18|outline=1|text=<请输入发送的内容，发送垃圾信息会被封号！/FCOLOR=249>>"
            local tmp_tab = {str1, str2, str3, str4, str5, str6, str7, str8, str9}
            say(actor, table.concat(tmp_tab))
            return false
        end,
        ["时装宝箱"] = function ()
            local item_arr = {"社团风云(装扮)","海盗船长(装扮)","海军大将(装扮)","大内密探(装扮)","月光宝盒(装扮)","三国の群英(装扮)","乘风の破浪(装扮)","仙侠の剑灵(装扮)"
            ,"假面の舞会(装扮)","西洋の剑客(装扮)","社团の街霸(装扮)","九五の之尊(装扮)"}
            local item = item_arr[math.random(1, #item_arr)]
            giveitem(actor, item, 1)
            Sendmsg9(actor, "ffffff", "获得: "..item, 1)
            return true
        end,
        ["时装自选宝箱"] = function ()
            local npc_class = IncludeNpcClass("OptionalItemNpc")
            if npc_class then
                npc_class:showSelectFashionUI(actor)
            end
            return false
        end,
        ["绝品秘宝自选宝箱"] = function ()
            local npc_class = IncludeNpcClass("OptionalItemNpc")
            if npc_class then
                npc_class:showSelectTreasureUI(actor, 1)
            end            
            return false
        end,
        ["孤品秘宝自选宝箱"] = function ()
            local npc_class = IncludeNpcClass("OptionalItemNpc")
            if npc_class then
                npc_class:showSelectTreasureUI(actor, 2)
            end            
            return false
        end,
        ["穿云箭"] = function()
            local map_tab = {"命运","屠魔秘境","惊魂神阵","云顶天宫","贵族禁地","boss禁地","天降财宝","双倍押镖","财富广场","行会争霸","激情夺宝","乱斗之王","狂暴争霸","沙巴克皇宫","盟重省",
                            "卧龙山庄", "龙之巢穴", "龙魂禁地", "龙源秘境", "龙源地牢", "卧龙庄主之家", "镇魔塔", "蛮荒", "迷惘", "诅咒", "古老", "永夜", "幽灵", "远古异界"}
            for k, v in pairs(map_tab) do
                if map_name == v then
                    Sendmsg9(actor, "ffffff", "该地图禁止召唤！", 1)
                    return false
                end
                if nil ~= string.find(map_name, v) then
                    Sendmsg9(actor, "ffffff", "该地图禁止召唤！", 1)
                    return false
                end
            end
            local member_list = getgroupmember(actor)
            if nil == member_list then
                Sendmsg9(actor, "ffffff", "你未加入任何队伍!", 1)
                return false
            end
            if #member_list <= 1 then
                Sendmsg9(actor, "ffffff", "你的队伍无其他成员!", 1)
                return false
            end
            messagebox(actor, '是否立即发起"穿云箭"\\可将队友召唤到身边\\需队友满足当前进图条件!', "@_ok_cyj_map_move,"..map_id, "@_no_map_move")
            return false
        end,
        ["风雷令"] = function ()
            local map_tab = {"命运","屠魔秘境","惊魂神阵","云顶天宫","龙之巢穴","贵族禁地","boss禁地","天降财宝","双倍押镖","财富广场","行会争霸","激情夺宝","乱斗之王","狂暴争霸","沙巴克皇宫","盟重省"}
            for k, v in pairs(map_tab) do
                if map_name == v then
                    Sendmsg9(actor, "ffffff", "该地图禁止召唤！", 1)
                    return false
                end
                if nil ~= string.find(map_name, v) then
                    Sendmsg9(actor, "ffffff", "该地图禁止召唤！", 1)
                    return false
                end
            end
            if nil ~= string.find(map_name, "跨服") or nil ~= string.find(map_name, "个人") then
                Sendmsg9(actor, "ffffff", "该地图禁止召唤！", 1)
                return false
            end
            local guild_count = getguildmembercount(actor)
            if nil == guild_count or guild_count <= 0 then
                Sendmsg9(actor, "ffffff", "你未加入任何行会!", 1)
                return false
            end
            messagebox(actor, '是否立即发起"风雷令"\\可将队友召唤到身边\\需队友满足当前进图条件!', "@_ok_fll_map_move,"..map_id, "@_no_map_move")
            return false
        end,
        ["改名卡"] = function ()
            local str1 = "<Img|width=546|height=301|move=0|img=public/bg_npc_04.jpg|loadDelay=1|show=4|bg=1|esc=1|reset=1>"
            local str2 = "<Layout|x=526.0|y=-17.0|width=80|height=80|link=@exit>"
            local str3 = "<Button|x=545.0|y=0.0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>"
            local str4 = "<Text|a=4|x=272.0|y=38.0|outline=1|color=1003|outlinecolor=0|size=18|text=角色改名功能>"
            local str5 = "<Text|a=4|x=273.0|y=078.0|outline=1|color=255|outlinecolor=0|size=18|text=改名说明：不可以修改已经被使用的角色名>"
            local str6 = "<Text|a=4|x=273.0|y=118.0|outline=1|color=251|outlinecolor=0|size=18|text=必须遵守：不可使用侮辱词汇、数字、英文、特殊字符、等>"
            local str7 = "<Text|a=4|x=273.0|y=158.0|outline=1|color=251|outlinecolor=0|size=18|text=修改角色名之前请认真阅读，违犯以上规则官方有权封号>"
            local str8 = "<Img|x=190.0|y=185.0|width=164|height=33|img=public/1900015004.png|esc=0>"
            local str9 = "<Input|x=192.0|y=187.0|width=160|height=30|place=输入要修改的名字|type=0|color=255|size=18|errortips=1|inputid=3|mincount=6|maxcount=12|isChatInput=1>"
            local str10 = "<Button|x=208.0|y=235.0|width=130|height=39|grey=0|color=1003|submitInput=3|size=18|nimg=public/1900000612.png|text=确认修改名字|link=@on_change_name>"
            local tmp_tab = {str1, str2, str3, str4, str5, str6, str7, str8, str9, str10}
            say(actor, table.concat(tmp_tab))
            return false
        end,
        ["惊喜魔盒"] = function ()
            local cfg = getWeightedCfg("1#200|2#75|3#50|4#200|5#75|6#50|7#200|8#75|9#75")
            local index = weightedRandom(cfg).value
            local reward = {"20#100", "20#200", "20#500", "21#1000", "21#2000", "21#5000", "15#10", "15#20", "15#50"}
            local str = reward[index]
            local tab = strsplit(str, "#")
            changemoney(actor, tonumber(tab[1]), "+", tonumber(tab[2]) * itemNum, "消耗惊喜魔盒获得", true)
            Sendmsg9(actor, "ffffff", "开启成功！", 1)
            return true
        end,
        ["战令*1"] = function ()
            -- local value = getstditeminfo("战令*1", 5)
            changemoney(actor, 25, "+",  itemNum, "消耗惊战令*1获得", true)
            return true
        end,
        ["根骨福袋"] = function ()
            local bag_count = getbagblank(actor)
            if bag_count < 9 then
                Sendmsg9(actor, "ffffff", "背包已满，请先确保背包内有足够空间！", 1)
                return false
            end
            for k, v in pairs({"头颅根骨", "身躯根骨", "左臂根骨", "左手根骨", "右臂根骨", "右手根骨", "左腿根骨", "左脚根骨", "右腿根骨", "右脚根骨"}) do
                if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
                    giveitem(actor, v, 9 * itemNum, 0)
                else
                    giveitem(actor, v, 9 * itemNum, 378)
                end
            end
            Sendmsg9(actor, "ffffff", "开启成功！", 1)
            return true
        end,
        ["神龙福袋"] = function ()
            local bag_count = getbagblank(actor)
            if bag_count < 5 then
                Sendmsg9(actor, "ffffff", "背包已满，请先确保背包内有足够空间！", 1)
                return false
            end
            for k, v in pairs({{"龙之心", 33, 378}, {"龙之血", 33, 378}, {"恶魔挑战卷", 3, 378}, {21, 4500}}) do
                if type(v[1]) == "number" then
                    changemoney(actor, v[1], "+", v[2] * itemNum, "消耗神龙福袋获得", true)
                else
                    if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
                        giveitem(actor, v[1], v[2] * itemNum, 0)
                    else
                        giveitem(actor, v[1], v[2] * itemNum, v[3])
                    end
                end
            end
            Sendmsg9(actor, "ffffff", "开启成功！", 1)
            return true
        end,
        ["飞升福袋"] = function ()
            local bag_count = getbagblank(actor)
            if bag_count < 5 then
                Sendmsg9(actor, "ffffff", "背包已满，请先确保背包内有足够空间！", 1)
                return false
            end
            for k, v in pairs({{"十转凭证", 10, 378}, {15, 100}}) do
                if type(v[1]) == "number" then
                    changemoney(actor, v[1], "+", v[2] * itemNum, "消耗飞升福袋获得", true)
                else
                    if VarApi.getPlayerUIntVar(actor,VarIntDef.TRUE_RECHARGE) >= 68 then
                        giveitem(actor, v[1], v[2] * itemNum, 0)
                    else
                        giveitem(actor, v[1], v[2] * itemNum, v[3])
                    end
                end
            end
            Sendmsg9(actor, "ffffff", "开启成功！", 1)
            return true
        end,
        ["帝王福袋"] = function ()
            local bag_count = getbagblank(actor)
            if bag_count < 5 then
                Sendmsg9(actor, "ffffff", "背包已满，请先确保背包内有足够空间！", 1)
                return false
            end
            local item_names = {"连环明珠", "暗黑水晶", "灵魂水晶", "魔界残魂", "帝王之心"}
            local item = item_names[math.random(1, #item_names)]
            local count = math.random(1, 10) * itemNum
            if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) >= 68 then
                giveitem(actor, item, count, 0)
            else
                giveitem(actor, item, count, 378)
            end
            Sendmsg9(actor, "ffffff", "开启成功，获得：" .. item .. "x" .. count .. "!", 1)
            return true
        end,
        ["龙神福袋"] = function ()
            local bag_count = getbagblank(actor)
            if bag_count < 5 then
                Sendmsg9(actor, "ffffff", "背包已满，请先确保背包内有足够空间！", 1)
                return false
            end
            local item_names = {"龙神石", "觉醒宝石"}
            local item = item_names[math.random(1, #item_names)]
            local count = math.random(10, 20) * itemNum
            if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) >= 68 then
                giveitem(actor, item, count, 0)
            else
                giveitem(actor, item, count, 378)
            end
            Sendmsg9(actor, "ffffff", "开启成功，获得："..item.."x"..count.."!", 1)
            return true
        end,
        ["符文福袋"] = function ()
            local bag_count = getbagblank(actor)
            if bag_count < 5 then
                Sendmsg9(actor, "ffffff", "背包已满，请先确保背包内有足够空间！", 1)
                return false
            end
            local item_names = {"紫气东来(紫)", "紫气东来(气)", "紫气东来(东)", "紫气东来(来)", "兵临城下(兵)", "兵临城下(临)", "兵临城下(城)", "兵临城下(下)", "金戈铁马(金)", "金戈铁马(戈)", "金戈铁马(铁)", "金戈铁马(马)", "烽火连城(烽)", "烽火连城(火)", "烽火连城(连)", "烽火连城(城)"}
            local item = item_names[math.random(1, #item_names)]
            local count = 1 * itemNum
            if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) >= 68 then
                giveitem(actor, item, count, 0)
            else
                giveitem(actor, item, count, 378)
            end
            Sendmsg9(actor, "ffffff", "开启成功，获得："..item.."x"..count.."!", 1)
            return true
        end,
        ["书页*100"] = function ()
            giveitem(actor, "书页", 100, 371)
            Sendmsg9(actor, "ffffff", "获得书页x100！", 1)
            return true
        end,
        ["书页福袋"] = function ()
            local count = math.random(58, 158) * itemNum
            if VarApi.getPlayerUIntVar(actor, VarIntDef.TRUE_RECHARGE) >= 68 then
                giveitem(actor, "书页", count, 0)
            else
                giveitem(actor, "书页", count, 371)
            end
            Sendmsg9(actor, "ffffff", "获得书页x"..count.."!", 1)
            return true
        end,
        ["金刚石福袋"] = function ()
            local count = math.random(100, 500) * itemNum
            changemoney(actor, 21, "+", count, "消耗金刚石福袋获得", true)
            Sendmsg9(actor, "ffffff", "获得绑定金刚石x"..count, 1)
            return true
        end,
        ["灵符福袋"] = function ()
            local count = math.random(20, 100) * itemNum
            changemoney(actor, 20, "+", count, "消耗灵符福袋获得", true)
            Sendmsg9(actor, "ffffff", "获得绑定灵符x"..count, 1)
            return true
        end,
        ["一路长虹(限定魂环)"] = function ()
            if checktitle(actor, "一路长虹魂环") then
                changemoney(actor, 21, "+", 100000, "消耗一路长虹(限定魂环)获得", true)
                Sendmsg9(actor, "ffffff", "获得绑定金刚石x10万", 1)
            else    
                confertitle(actor, "一路长虹魂环", 1)
                Sendmsg9(actor, "ffffff", "激活成功！", 1)
            end
            return true
        end,
        ["气血粽子"] = function ()
            local level = getbuffinfo(actor, 60003, 1) or 0
            local num = math.random(1, 100)
            changemoney(actor, 21, "+", 188, "188元宝", true)
            if num <= 10 and level < 20 then
                addbuff(actor, 60003)
                level = getbuffinfo(actor, 60003, 1) or 0
                Sendmsg9(actor, "ffffff", string.format("获得绑定金刚石x188，永久增加%d血量，剩余次数：%s/20！", 1, level), 1)
            else
                Sendmsg9(actor, "ffffff", "获得绑定金刚石x188!", 1)
            end
            local count = VarApi.getPlayerUIntVar(actor, "U_use_zongzi_num")
            count = count + 1
            VarApi.setPlayerUIntVar(actor, "U_use_zongzi_num", count)
            return true
        end,
        ["元素粽子"] = function ()
            local bf_6004 = getbuffinfo(actor, 60004, 1)
            local bf_6005 = getbuffinfo(actor, 60005, 1)
            local bf_6006 = getbuffinfo(actor, 60006, 1)
            local bf_6007 = getbuffinfo(actor, 60007, 1)
            local buff_cfg = {}
            if not bf_6004 or bf_6004 < 10 then
                buff_cfg[#buff_cfg + 1] = 60004
            end
            if not bf_6005 or bf_6005 < 10 then
                buff_cfg[#buff_cfg + 1] = 60005
            end
            if not bf_6006 or bf_6006 < 10 then
                buff_cfg[#buff_cfg + 1] = 60006
            end
            if not bf_6007 or bf_6007 < 10 then
                buff_cfg[#buff_cfg + 1] = 60007
            end
            local num = math.random(1, 100)
            if #buff_cfg > 0 and num <= 10 then
                local index = math.random(1, #buff_cfg)
                local buff_id = buff_cfg[index]
                addbuff(actor, buff_id)
                local str_tab = {"物理伤害减少", "魔法伤害减少", "忽视目标防御", "所有伤害反弹"}
                local level = getbuffinfo(actor, 60003, 1) or 0
                Sendmsg9(actor, "ffffff", string.format("获得绑定金刚石x588，永久增加%d%s，剩余次数：%s/10！", 1, str_tab[index], level), 1)
            else
                Sendmsg9(actor, "ffffff", "获得绑定金刚石x588!", 1)
            end
            changemoney(actor, 21, "+", 588, "588元宝", true)
            local count = VarApi.getPlayerUIntVar(actor, "U_use_zongzi_num")
            count = count + 1
            VarApi.setPlayerUIntVar(actor, "U_use_zongzi_num", count)            
            return true
        end,
        ["暴伤粽子"] = function ()
            local level = getbuffinfo(actor, 60008, 1) or 0
            local num = math.random(1, 100)
            changemoney(actor, 21, "+", 588, "188元宝", true)
            if num <= 10 and level < 10 then
                addbuff(actor, 60008)
                level = getbuffinfo(actor, 60008, 1) or 0
                Sendmsg9(actor, "ffffff", string.format("获得绑定金刚石x588，永久增加%d爆伤，剩余次数：%s/10！", 1, level), 1)
            else
                Sendmsg9(actor, "ffffff", "获得绑定金刚石x588!", 1)
            end
            local count = VarApi.getPlayerUIntVar(actor, "U_use_zongzi_num")
            count = count + 1
            VarApi.setPlayerUIntVar(actor, "U_use_zongzi_num", count)
            return true
        end,
        ["攻伤粽子"] = function ()
            local level = getbuffinfo(actor, 60009, 1) or 0
            local num = math.random(1, 100)
            changemoney(actor, 21, "+", 588, "188元宝", true)
            if num <= 10 and level < 10 then
                addbuff(actor, 60009)
                level = getbuffinfo(actor, 60009, 1) or 0
                Sendmsg9(actor, "ffffff", string.format("获得绑定金刚石x588，永久增加%d功伤，剩余次数：%s/10！", 1, level), 1)
            else
                Sendmsg9(actor, "ffffff", "获得绑定金刚石x588!", 1)
            end
            local count = VarApi.getPlayerUIntVar(actor, "U_use_zongzi_num")
            count = count + 1
            VarApi.setPlayerUIntVar(actor, "U_use_zongzi_num", count)
            return true
        end,
        ["卧龙令*1"] = function ()
            local count = getbagitemcount(actor, "卧龙令*1")
            if not takeitem(actor, "卧龙令*1", count) then
                return Sendmsg9(actor, "ffffff", "卧龙令扣除失败!", 1)
            end
            VarApi.setPlayerUIntVar(actor, "U_use_wolongling_num", VarApi.getPlayerUIntVar(actor, "U_use_wolongling_num") + 1)
            changemoney(actor, 26, "+", count, count.."卧龙令", true)
            Sendmsg9(actor, "ffffff", "使用成功，获得卧龙令x"..count.."!", 1)
            return true
        end,

        ["魔盒"] = function ()
            if IncludeNpcClass("WelfareHall") then 
                IncludeNpcClass("WelfareHall"):FlushSigleRedData(actor)
                IncludeNpcClass("WelfareHall"):upEvent(actor,0,7,true)
            end
            return false
        end,
        ["新人体验卷"] = function ()
            if checktitle(actor,"新人福利") then
                changemoney(actor, 21, "+",100, "消耗"..itemName.."获得", true)
                Sendmsg9(actor, "ffffff", "获得绑定金刚石x100", 1)
            else
                confertitle(actor,"新人福利",1)
            end
            return true
        end,
    }
    if fun_tab[itemName] then
        if checkkuafu(actor) and map_id == "祥瑞迷宫合区" and itemName == "随机传送石" then
            return fun_tab[itemName]()
        elseif checkkuafu(actor) and map_id == "迷失之城" and itemName == "迷失之城随机石" then
            return fun_tab[itemName]()
        elseif checkkuafu(actor) then
            Sendmsg9(actor, "ff0000", "跨服区域禁止使用！", 1)
            return false
        end
        return fun_tab[itemName]()
    end

    local yb_names = {"5元宝","10元宝","20元宝","50元宝","100元宝","200元宝","500元宝","1000元宝","5000元宝","10000元宝","50000元宝","10万元宝","50万元宝","100万元宝","1亿元宝"}
    if isInTable(yb_names, itemName) then
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
            return false
        end
        local value = getstditeminfo(itemIdx, 11)
        if itemName == "1亿元宝" then
            value = 100000000
        end
        local yb_id = 2
        if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) <= 0 then
            yb_id = 4
        end
        changemoney(actor, yb_id, "+", value * itemNum, "消耗元宝道具获得元宝", true)
        return true
    end

    local jgs_names = {"1金刚石","5金刚石","10金刚石","50金刚石","100金刚石","500金刚石","1000金刚石","5000金刚石","1万金刚石","5万金刚石","10万金刚石"}
    if isInTable(jgs_names, itemName) then
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
            return false
        end
        local value = getstditeminfo(itemIdx, 11)
        local jgs_id = 5
        if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) <= 0 then
            jgs_id = 21
        end
        changemoney(actor, jgs_id, "+", value * itemNum, "消耗金刚石道具获得金刚石", true)
        return true
    end

    local exp_names = {"1万经验","10万经验","百万经验","千万经验","一亿经验"}
    if isInTable(exp_names, itemName) then
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
            return false
        end          
        local value = getstditeminfo(itemIdx, 11)
        changeexp(actor, "+", value * itemNum, true)
        return true
    end

    local lf_names = {"1灵符","5灵符","10灵符","50灵符","100灵符","500灵符","1000灵符","5000灵符","1万灵符","5万灵符","10万灵符"}
    if isInTable(lf_names, itemName) then
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
            return false
        end
        local value = getstditeminfo(itemIdx, 11)
        local lf_id = 7
        if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) <= 0 then
            lf_id = 20
        end
        changemoney(actor, lf_id, "+", value * itemNum, "消耗灵符道具获得元宝", true)
        return true
    end

    local sw_names = {"1声望","10声望","100声望","1000声望"}
    if isInTable(sw_names, itemName) then
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
            return false
        end
        local value = getstditeminfo(itemIdx, 11)
        local sw_id = 15
        changemoney(actor, sw_id, "+", value * itemNum, "消耗声望道具获得声望", true)
        return true
    end    

    local pao_names = {"祥龙贺岁炮", "福运连年炮", "盛世华章炮", "瑞彩缤纷炮", "喜乐年华炮"}
    if isInTable(pao_names, itemName) then                      -- 只能在祥瑞迷宫地图使用
        if nil == string.find(map_name, "祥瑞迷宫") then
            Sendmsg9(actor, "ffffff", "只能在祥瑞迷宫地图使用！", 1)
            return false
        end
        -- local w = getconst(actor, "<$SCREENWIDTH>")
        -- local h = getconst(actor, "<$SCREENHEIGHT>")
        playeffect(actor, 86, 0, 0, 1, 0, 0)
        local pos_x = getbaseinfo(actor, 4)
        local pos_y = getbaseinfo(actor, 5)
        if checkkuafu(actor) then
            KuaFuTrigger.bfbackcall(actor, itemName)
        else
            if itemName == "祥龙贺岁炮" then
                rangeharm(actor, pos_x, pos_y, 3, 0, 6, 100000, 0, 2)
            elseif itemName == "福运连年炮" then
                rangeharm(actor, pos_x, pos_y, 3, 0, 6, 500000, 0, 2)
            elseif itemName == "盛世华章炮" then
                rangeharm(actor, pos_x, pos_y, 3, 0, 6, 1000000, 0, 2)
            elseif itemName == "瑞彩缤纷炮" then
                rangeharm(actor, pos_x, pos_y, 3, 0, 2, 60, 0, 2)
            elseif itemName == "喜乐年华炮" then
                rangeharm(actor, pos_x, pos_y, 3, 0, 12, 1, 0, 2)
            end
        end
        local str = string.sub(itemName, 1, #itemName - 2).."烟花！"
        Sendmsg9(actor, "ffffff", "成功释放"..str, 1)        
        return true
    end

    local title_name_cfg = {
        ["独孤求败(称号)"] = {},
        ["盖世英雄(称号)"] = {},
        ["热血同行(称号)"] = {},
        ["十步一殺(称号)"] = {},
        ["唯我独有(称号)"] = {},
        ["雪山孤剑鸣(称号)"] = {},
        ["一刀一个小朋友(称号)"] = {},
        ["一骑当千(称号)"] = {},
        ["以德服人(称号)"] = {},
        ["与人善良(称号)"] = {},
        ["斩尽天下不收刀(称号)"] = {
            icon_id = 40231,
        },
        ["横扫全服(称号)"] = {
            icon_id = 20687,
        },
        ["富甲天下(称号)"] = {
            icon_id = 20111,
        },
        ["卧龙1.1倍神力(称号)"] = {
            icon_id = 0,
        },
        ["屠尽天下又何妨(称号)"] = {
            money_id = 21,
            value = 20000,
            icon_id = 20010,
            tips = "获得绑定金刚石x2万"
        },
        ["神念一现死一片(称号)"] = {
            money_id = 21,
            value = 1000000,
            icon_id = 20024,
            tips = "获得绑定金刚石x100万"
        },
        ["九霄风云齐聚会(称号)"] = {
            money_id = 21,
            value = 500000,
            icon_id = 20025,
            tips = "获得绑定金刚石x50万"
        },
        ["斩断红尘多情客(称号)"] = {
            money_id = 21,
            value = 300000,
            icon_id = 20019,
            tips = "获得绑定金刚石x30万"
        }, 
        ["头号玩家(称号)"] = {
            money_id = 21,
            value = 30000,
            icon_id = 15278,
            tips = "获得绑定金刚石x3万"
        },
        ["全服最靓的仔(称号)"] = {
            money_id = 21,
            value = 100000,
            icon_id = 15277,
            tips = "获得绑定金刚石x10万"
        },
    }
    local _t_cfg = title_name_cfg[itemName]
    if nil ~= _t_cfg then
        local _name = string.sub(itemName, 1, #itemName - 6)
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
            return false
        end
        if checktitle(actor, _name) and nil ~= _t_cfg.money_id then
            changemoney(actor, _t_cfg.money_id, "+", _t_cfg.value, "消耗"..itemName.."获得", true)
            Sendmsg9(actor, "ffffff", _t_cfg.tips, 1)
        else
            confertitle(actor, _name, 1)
            if itemName == "全服最靓的仔(称号)" then
                local skill_list = getallskills(actor)
                for k, v in pairs(skill_list or {}) do
                    local skill_name = getskillname(v)
                    local cur_cd = getskillcscd(skill_name)/1000
                    local jm_per = 0
                    local occupation = getbaseinfo(actor,7) 
                    if occupation == 0 then
                        jm_per = cur_cd * 0.3
                    elseif occupation == 1 then
                        jm_per = cur_cd * 0.1
                    elseif occupation == 2 then
                        jm_per = cur_cd * 0.15
                    end
                    setskilldeccd(actor,skill_name,"-",jm_per)
                end
            end

            Sendmsg9(actor, "ffffff", "激活成功！", 1)
        end
        return true
    end

    if UseItemTrigger.disguiseCfg[itemName] then --#region 装扮系统
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
            return false
        end
        local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_disguise"))
        if hastab == "" then hastab = {} end
        if UseItemTrigger.disguiseCfg[itemName]["type"] == "时装" then
            hastab["1"] = hastab["1"] or {}
            if itemName=="霸王项羽(SP装扮)" then
                VarApi.setPlayerUIntVar(actor,"U_bawangXY",1,false)
            end
            if not isInTable(hastab["1"], itemName) then
                hastab["1"][#hastab["1"]+1] = itemName
                VarApi.setPlayerTStrVar(actor, "TL_disguise", tbl2json(hastab), true)
                delbuff(actor, 20010)
                local buffTab = {}
                for i = 1, #hastab["1"] do
                    for key, value in pairs(UseItemTrigger.disguiseCfg[hastab["1"][i]]["buff_map"] or {}) do
                        if not buffTab[key] then
                            buffTab[key] = value
                        else
                            buffTab[key] = buffTab[key] + value
                        end
                    end
                end
                addbuff(actor, 20010, 0, 1, actor, buffTab)
                VarApi.setPlayerTStrVar(actor,"UL_disguise1",UseItemTrigger.disguiseCfg[itemName]["itemName"],true)
                delbodyitem(actor,17,"穿戴时装前扣除")
                giveonitem(actor,17,UseItemTrigger.disguiseCfg[itemName]["itemName"]..getbaseinfo(actor,8),1,307,"双击物品给予时装")
                setbaseinfo(actor,57,1)
                lualib:ShowNpcUi(actor, "disguiseOBJ","")
            else
                for key, value in pairs(UseItemTrigger.disguiseCfg[itemName]["recycle_map"] or {}) do
                    changemoney(actor,getstditeminfo(key,0),"+",value,"额外时装双击得货币")
                end
            end
        elseif UseItemTrigger.disguiseCfg[itemName]["type"] == "足迹" then
            local effectTab = {["城主专属足迹"]=46139,["步步高升足迹"]=40197,}
            hastab["2"] = hastab["2"] or {}
            if not isInTable(hastab["2"], itemName) then
                hastab["2"][#hastab["2"]+1] = itemName
                VarApi.setPlayerTStrVar(actor, "TL_disguise", tbl2json(hastab), true)
                confertitle(actor,UseItemTrigger.disguiseCfg[itemName]["itemName"],1)
                VarApi.setPlayerTStrVar(actor, "UL_disguise2", UseItemTrigger.disguiseCfg[itemName]["itemName"], true)
                if effectTab[UseItemTrigger.disguiseCfg[itemName]["itemName"]] then
                    setmoveeff(actor, effectTab[UseItemTrigger.disguiseCfg[itemName]["itemName"]], 1)
                end
                lualib:ShowNpcUi(actor, "disguiseOBJ","")
            elseif isInTable(hastab["2"], itemName) and not checktitle(actor,UseItemTrigger.disguiseCfg[itemName]["itemName"]) then
                confertitle(actor,UseItemTrigger.disguiseCfg[itemName]["itemName"],1)
                VarApi.setPlayerTStrVar(actor, "UL_disguise2", UseItemTrigger.disguiseCfg[itemName]["itemName"], true)
                if effectTab[UseItemTrigger.disguiseCfg[itemName]["itemName"]] then
                    setmoveeff(actor, effectTab[UseItemTrigger.disguiseCfg[itemName]["itemName"]], 1)
                end
                lualib:ShowNpcUi(actor, "disguiseOBJ","")
            else
                for key, value in pairs(UseItemTrigger.disguiseCfg[itemName]["recycle_map"] or {}) do
                    changemoney(actor,getstditeminfo(key,0),"+",value,"额外足迹双击得货币")
                end
            end
        elseif UseItemTrigger.disguiseCfg[itemName]["type"] == "精灵" then
            hastab["3"] = hastab["3"] or {}
            if linkbodyitem(actor,45) ~= "0" then
                for key, value in pairs(UseItemTrigger.disguiseCfg[itemName]["recycle_map"] or {}) do
                    changemoney(actor,getstditeminfo(key,0),"+",value,"额外精灵双击得货币")
                end
            else
                hastab["3"][#hastab["3"]+1] = itemName
                VarApi.setPlayerTStrVar(actor, "TL_disguise", tbl2json(hastab), true)
                VarApi.setPlayerTStrVar(actor, "UL_disguise3", UseItemTrigger.disguiseCfg[itemName]["itemName"], true)
                lualib:ShowNpcUi(actor, "disguiseOBJ","")
                delbodyitem(actor,45,"穿精灵前扣除")
                giveonitem(actor,45,UseItemTrigger.disguiseCfg[itemName]["itemName"],1,307,"双击物品给予精灵")
                seticon(actor,1,1,11900,-50,-60,1,0,0)
            end
        elseif UseItemTrigger.disguiseCfg[itemName]["type"] == "宠物" then
            hastab["4"] = hastab["4"] or {}
            if not isInTable(hastab["4"], itemName) then
                hastab["4"][#hastab["4"]+1] = itemName
                VarApi.setPlayerTStrVar(actor, "TL_disguise", tbl2json(hastab), true)
                -- confertitle(actor,UseItemTrigger.disguiseCfg[itemName]["itemName"],1)
                delbuff(actor, 20011)
                local buffTab = {}
                for i = 1, #hastab["4"] do
                    for key, value in pairs(UseItemTrigger.disguiseCfg[hastab["4"][i]]["buff_map"] or {}) do
                        if not buffTab[key] then
                            buffTab[key] = value
                        else
                            buffTab[key] = buffTab[key] + value
                        end
                    end
                end
                addbuff(actor, 20011, 0, 1, actor, buffTab)
                if itemName == "洛丽塔(女仆)" then
                    addbuff(actor,20012)
                    createsprite(actor,"洛丽塔")
                    VarApi.setPlayerTStrVar(actor,"UL_disguise4","洛丽塔(女仆)",true)
                end
                lualib:ShowNpcUi(actor, "disguiseOBJ","")
            else
                for key, value in pairs(UseItemTrigger.disguiseCfg[itemName]["recycle_map"] or {}) do
                    changemoney(actor,getstditeminfo(key,0),"+",value,"额外宠物双击得货币")
                end
            end
        end
        return true
    end

    return true
end

-- 千里传音
function send_world_say(actor)
    local say_str = getconst(actor, "<$NPCINPUT(2)>")
    if string.find(say_str, "*") then
        Sendmsg9(actor, "ffffff", "请修改发送内容！", 1)
        return
    end
    if "" == say_str or nil == say_str then
        Sendmsg9(actor, "ffffff", "请先输入内容！", 1)
        return
    end
    local count = getbagitemcount(actor, "千里传音")
    if count <= 0 then
        Sendmsg9(actor, "ffffff", "需要千里传音*1！", 1)
        return
    end
    local str = "(世界传音)<%s/FCOLOR=251>:  <%s/FCOLOR=250>"
    sendmovemsg(actor, 1, 253, 0,180, 1, string.format(str, getbaseinfo(actor, 1), say_str))
    sendmovemsg(actor, 1, 253, 0,250, 1, string.format(str, getbaseinfo(actor, 1), say_str))
    sendmovemsg(actor, 1, 253, 0,320, 1, string.format(str, getbaseinfo(actor, 1), say_str))
    if not takeitem(actor, "千里传音", 1) then
        return Sendmsg9(actor, "ffffff", "千里传音扣除失败！", 1)
    end
    Sendmsg1(actor, 253, 255, "「(世界传音)」"..getbaseinfo(actor, 1)..": "..say_str, 2)
    close(actor)
end
-- 修改名字
function on_change_name(actor)
    local say_str = getconst(actor, "<$NPCINPUT(3)>")
    local count = getbagitemcount(actor, "改名卡")
    if count <= 0 then
        Sendmsg9(actor, "ffffff", "需要改名卡！", 1)
        return
    end
    local ret = changehumname(actor, say_str)
    if ret == 0 then
        if not takeitem(actor, "改名卡", 1) then
            return Sendmsg9(actor, "ffffff", "改名卡扣除失败！", 1)
        end
        close(actor)
    end
end
-- 宝箱开奖
function getboxsitem1(actor)
    local count = getbagitemcount(actor, "秘宝宝箱")
    if count <= 0 then
        Sendmsg9(actor, "ffffff", "需要秘宝宝箱！", 1)
        return
    end
    if not takeitem(actor, "秘宝宝箱", 1) then
        return Sendmsg9(actor, "ffffff", "秘宝宝箱扣除失败！", 1)
    end
    local name = getconst(actor, "<$STR(S0)>")
    Sendmsg9(actor, "ffffff", "开启成功获得："..name.."！", 1)
end
function canreopenbox1(actor)
    local count = getbagitemcount(actor, "秘宝宝箱")
    if count <= 0 then
        stop(actor)
    end
end

-- 穿云箭  风雷令
function _ok_cyj_map_move(actor, map_id)
    local x, y = getconst(actor, "<$X>"), getconst(actor, "<$Y>")
    if not takeitem(actor, "穿云箭", 1) then
        return Sendmsg9(actor, "ffffff", "穿云箭扣除失败！", 1)
    end
    local member_list = getgroupmember(actor)
    for k, v in pairs(member_list) do
        if v ~= actor then
            local str = string.format("玩家:%s使用穿云箭\n在 %s %s,%s求助，是否立即前往?",getbaseinfo(actor,1),getbaseinfo(actor,45),x, y)
            messagebox(v, str, "@_go_to_map,"..map_id..","..x ..","..y, "@______")
        end
    end
    Sendmsg9(actor, "ffffff", "使用成功！", 1)
end
function _ok_fll_map_move(actor, map_id)
    if not takeitem(actor, "风雷令", 1) then
        return Sendmsg9(actor, "ffffff", "风雷令扣除失败！", 1)
    end
    local x, y = getconst(actor, "<$X>"), getconst(actor, "<$Y>")
    local hanghui = getmyguild(actor)
    if hanghui == "0" then
        return Sendmsg9(actor, "ffffff", "没有行会", 1)
    end
    local member_list = getguildinfo(hanghui,3)
    for k, v in pairs(member_list) do
        local player = getplayerbyname(v)
        if player ~= actor then
            local str = string.format("玩家:%s使用风雷令\n在 %s %s,%s求助，是否立即前往?",getbaseinfo(actor,1),getbaseinfo(actor,45),x, y)
            messagebox(player, str, "@_go_to_map,"..map_id..","..x ..","..y, "@______")
        end
    end
    Sendmsg9(actor, "ffffff", "使用成功！", 1)
end
function _no_map_move(actor)
end
-- function _go_to_map(actor, map_id, x, y)
--     x = tonumber(x)
--     y = tonumber(y)
--     local cfg = include("QuestDiary/config/mapMoveData.lua")
--     local info = nil
--     for k, v in pairs(cfg) do
--         if isInTable(v.mapId_arr, map_id) then
--             info = v
--             break
--         end
--     end
    

--     if nil == info then
--         return
--     end
--     local npc_id = info.key_name
--     local index = VarApi.GetTableIndex(info.mapId_arr, map_id)
--     local npc_class = IncludeNpcClass("GoToMapNpc")
--     if nil == npc_class then
--         return
--     end
--     if isInTable({257,258,259,260,261,262}, npc_id) then
--         npc_class:GotoMap(actor, npc_id.."|"..index, x, y)
--     elseif isInTable({371,372,373,374,375,376}, npc_id) then
--         npc_class:GotoMap(actor, npc_id.."|"..index, x, y)
--     elseif isInTable({331,328,329,369,370}, npc_id) then
--         npc_class:GotoMap4(actor, npc_id)
--     elseif isInTable({330}, npc_id) then
--         npc_class:GotoMap4(actor, npc_id)
--     elseif isInTable({265,266,267,268,269,270}, npc_id) then
--         npc_class:GotoMap(actor, npc_id.."|"..index, x, y)
--     elseif isInTable({275, 277,278,279,280,281,282, 284}, npc_id) then
--         if npc_id == 275 then
--             npc_class:GotoMap5(actor, npc_id)
--         else
--             npc_class:GotoMap(actor, npc_id.."|"..index, x, y)
--         end
--     elseif isInTable({295, 296,297,298,299,300}, npc_id) then
--         npc_class:GotoMap(actor, npc_id.."|"..index, x, y)
--     elseif isInTable({378, 379, 380, 381, 382, 383}, npc_id) then
--         npc_class:GotoMap(actor, npc_id.."|"..index, x, y)
--     elseif isInTable({64,65,66,67,68,69,70,71}, npc_id) then
--         mapmove(actor, map_id, x, y, 2)
--         return
--     elseif isInTable({72,73,74,357,358,359,360,361,362,363,364,365,366,367,368}, npc_id) then
--         mapmove(actor, map_id, x, y, 2)
--         return
--     elseif isInTable({403,406,411,394,396,401}, npc_id) then
--         npc_class:GotoWuMap(actor, npc_id, index)
--     elseif isInTable({392,393,395,397,398,399,400,402,404,405,407,408,409,410}, npc_id) then
--         npc_class:GotoWuMap(actor, npc_id, index)
--     elseif isInTable({320,321,322,323,324}, npc_id) then
--         npc_class:GotoWDDHMap(actor, npc_id, index)
--     elseif npc_id == 263 then
--         npc_class:GotoZMTMap(actor, npc_id, index)
--     elseif npc_id == 377 then
--         npc_class:GotoYJZMMap(actor, npc_id, x, y)
--     elseif npc_id == 325 then

--         npc_class:GotoMap2(actor, "卧龙山庄", x, y, 2)
--     elseif npc_id == 264 then
--         npc_class:GotoMap2(actor, "map_fmsg", x, y, 2)
--     elseif npc_id == 307 then
--         npc_class:GotoMap2(actor, "map_cyd", x, y, 2)
--     end
-- end

function _go_to_map(actor, mapId, x, y) --#region 巡航开启和到点判断条件
    local cfg = include("QuestDiary/config/mapMoveData.lua")
    if isInTable({ "mryj2", "zs_hlxg2", "mryj2_jx" },mapId) then
        if IncludeNpcClass("GoToMapNpc") then
            IncludeNpcClass("GoToMapNpc"):GotoMap7(actor, mapId)
        end
        return
    end
    for key, value in pairs(cfg) do
        if tostring(type(value[1])) == "table" then
            for i, v in ipairs(value) do
                if v["mapId_arr"][1] == mapId then
                    if IncludeNpcClass("GoToMapNpc") then
                        IncludeNpcClass("GoToMapNpc"):GotoMap(actor, key .. "|1|"..i, x, y)
                    end
                    return
                elseif v["mapId_arr"][2] == mapId then
                    if IncludeNpcClass("GoToMapNpc") then
                        IncludeNpcClass("GoToMapNpc"):GotoMap(actor, key .. "|2|"..i,x, y)
                    end
                    return
                end
            end
        else
            if value["mapId_arr"][1] == mapId then
                if IncludeNpcClass("GoToMapNpc") then
                    IncludeNpcClass("GoToMapNpc"):GotoMap(actor,key.."|1",x, y)
                end
                return
            elseif value["mapId_arr"][2] == mapId then
                if IncludeNpcClass("GoToMapNpc") then
                    IncludeNpcClass("GoToMapNpc"):GotoMap(actor,key.."|2",x, y)
                end
                return
            end
        end
    end
end