-- 引擎全局变量 engine
VarEngine = {}
-- 字符型系统变量 重启服务器保存.500个(A0 - A499) 存放在Mir200/GlobalVal.ini文件里面
VarEngine.WorldNo1Rank = "A499"                 --　天下第一
VarEngine.donate = "A498"                       --  捐献
VarEngine.WuDaoDaHuiBoss = "A497"               -- 武道大会Boss击杀
VarEngine.FristEquip = "A496"                   -- 装备首爆
VarEngine.EquipDropRecord = "A495"              -- 珍宝掉落记录
VarEngine.luckTreasure = "A494"                 -- 祥瑞宝藏积分榜
VarEngine.ActivityLdzwRank = "A492"             -- 乱斗之王排名 
VarEngine.ActivityState = "A491"                -- 活动状态 
VarEngine.StrenthenAccountList = "A490"         -- 增加强化概率账号
VarEngine.CdkNum = "A489"                       -- Cdk剩余
VarEngine.SysOpLog = "A444"                     -- gm操作日志
VarEngine.Offline = "A400"                      -- 离线挂机人数
VarEngine.KuafShaCheng = "A399"                 -- 跨服沙城胜利方
VarEngine.WoLongJiTan = "A398"                  -- 卧龙祭台胜利方
VarEngine.ywjd_npc = "A397"                     -- 遗忘禁地隐藏npc坐标
VarEngine.emzy_npc = "A396"                     -- 噩梦之渊隐藏npc坐标


-- 数字型系统变量 重启服务器保存.500个(G0 - G499) 存放在Mir200/GlobalVal.ini文件里面
VarEngine.OpenServerTime = "G499"                 -- 开服时间  秒
VarEngine.KuangBaoDieCount = "G498"               -- 保存宗师狂暴累计死亡次数
VarEngine.TjcbActivity = "G497"                   -- 活动--天降财宝当前波数
VarEngine.JqdbBoxTime = "G496"                    -- 激情夺宝撒旦宝箱时间 
VarEngine.OpenDay = "G495"                        -- 开服天数
VarEngine.CastEndTime = "G494"                    -- 攻沙结束时间
VarEngine.HeFuCount = "G493"                      -- 合服次数
VarEngine.TjcbStartTime = "G492"                      -- 天降财宝开始时间
VarEngine.LdzwEndTime = "G491"                      -- 乱斗之王结束时间
VarEngine.ActiveStartFlag = "G490"                  -- 活动机器人开始运行标识
VarEngine.RunTime = "G489"                          -- 游戏运行时间
VarEngine.MonUpdateVar = {                          -- 怪物刷新时间
    ["G87"] = 240,["G92"] = 360,["G91"] = 360,["G90"] = 360,["G89"] = 360,["G88"] = 360,["G99"] = 240,
    ["G98"] = 360,["G97"] = 240,["G96"] = 120,["G95"] = 120,["G94"] = 360,["G93"] = 360,["G86"] = 360,
    ["G85"] = 360,["G84"] = 300,["G83"] = 300,["G82"] = 300,["G81"] = 360,["G80"] = 360,["G79"] = 360,
    ["G78"] = 360,["G77"] = 360,["G76"] = 360,["G75"] = 360,["G74"] = 720,["G73"] = 360}
VarEngine.GsGJ = "G488"                             -- 火龙gs主播攻击伤害 25
VarEngine.GsPK2 = "G487"                            -- 火龙gs主播PK减伤 77
VarEngine.WuDaoDaHuiTipFlag = "G486"                -- 武道大会提示
VarEngine.GsZQ = "G485"                             -- 火龙gs主播准确 13
VarEngine.GsBJ = "G484"                             -- 火龙gs主播暴击几率 21
VarEngine.GsPK = "G483"                             -- 火龙gs主播pk增伤 76
VarEngine.WuDaoDaHuiBossflag = "G482"
VarEngine.WlsxBossTime1 = "G479"                    -- 卧龙山庄boss斩浪首杀时间
VarEngine.WlsxBossTime2 = "G478"                    -- 卧龙山庄boss青城首杀时间
VarEngine.WlsxBossTime3 = "G477"                    -- 卧龙山庄boss新月首杀时间
VarEngine.WlsxBossTime4 = "G476"                    -- 卧龙山庄boss御风首杀时间
VarEngine.WlsxBossTime5 = "G475"                    -- 卧龙山庄boss风云首杀时间 
VarEngine.MonDropRate = "G474"                      -- 怪物掉落金刚石几率 新需求
VarEngine.GsHSFY = "G473"                           -- 火龙gs主播忽视防御 28
VarEngine.GsFBD = "G472"                            -- 火龙gs主播防冰冻 90
VarEngine.GsMFZ = "G471"                            -- 火龙gs主播加蓝量 6000


-- 玩家个人变量的一些定义
-- int型   返回值为int
VarIntDef = {}
VarIntDef.ZSTQ_LEVEL = "U_zstq"                     -- 终身特权
VarIntDef.VIP_LEVEL = "U_vip"                       -- vip等级  
VarIntDef.KB_LEVEL = "U_kb"                         -- 狂暴           1.开启   0.未开启
VarIntDef.TRUE_RECHARGE = "U_recharge"              -- 真实充值金额   总充值
VarIntDef.DAY_RECHARGE = "J_DayRecharge"              -- 今日充值金额  
VarIntDef.ENTER_TIME = "U_entertime"                -- 玩家第一次进入游戏时间
VarIntDef.LOGIN_DAY = "U_loginday"                  -- 玩家累计登录天数
VarIntDef.FirstRecharge = "U_firstRecharge"         -- 首充豪礼
VarIntDef.EverydayRecharge = "J_everyday_recharge"  -- 每日充值


-- string型  返回值为string
VarStrDef = {}
VarStrDef.XMTF = "T_xmtf"                            -- 天赋血脉
VarStrDef.ZSMB = "T_zsmb"                            -- 宗师秘宝    
VarStrDef.QHDS = "T_qhds"                            -- 强化大师   
VarStrDef.ZBTJ = "T_zbtj"                            -- 装备图鉴   
VarStrDef.ICON_0 = "T_icon_0"                        -- 角色0号位顶戴(特效id#称号名称) 作为称号顶戴用
VarStrDef.ICON_2 = "T_icon_2"                        -- 角色2号位顶戴(特效id#称号名称#x偏移#y偏移) 作为称号魂环用
VarStrDef.FRIST_EQUIP = "T_frist_equip"              -- 装备首爆

--引擎个人变量 数字型 每晚自动12点重置,
VarEngine.OnLine_TimeStamp = "J499"                  --玩家在线时长    

--#region 玩家gm白名单
VarGmWhitePlayer = {"1053102755","1354735642","1409186809","1723319956","1030957727","1614262072"}

-- 需要初始化的数字型自定义变量
VarCustomIntDef = {
    "l_masterLayer",
    "U_skill_master_1",
    "U_skill_master_2",
    "U_skill_master_3",
    "U_skill_master_4",
    "U_skill_master_5",
    "U_skill_master_6",
    "U_skill_master_7",
    "U_skill_master_8",
    "U_skill_master_9",
    "U_skill_master_10",
    "U_skill_master_11",
    "U_skill_master_12",
    "U_wxzl_level_1",
    "U_wxzl_level_2",
    "U_wxzl_level_3",
    "U_wxzl_level_4",
    "U_wxzl_level_5",
    "U_zsmb_state_1",
    "U_zsmb_state_2",
    "U_zsmb_state_3",
    "U_zsmb_state_4",
    "U_zsmb_state_5",
    "U_zsmb_state_6",
    "U_zsmb_state_7",
    "U_zsmb_state_8",
    "U_zsmb_state_9",
    "U_zsmb_state_10",
    "U_zsmb_state_11",
    "U_zsmb_state_12",
    "U_zsmb_state_13",
    "U_zsmb_state_14",
    "U_zsmb_state_15",
    "U_zsmb_state_16",
    "U_zsmb_state_17",
    "U_zsmb_state_18",
    "U_zsmb_state_19",
    "U_zsmb_state_20",
    "U_zsmb_state_21",
    "U_zsmb_state_22",
    "U_zsmb_state_23",
    "U_zsmb_state_24",
}
-- 需要初始化的字符型自定义变量
VarCustomStrDef = {

}

--#region 跨天需要清理的个人变量(补充服务器重启或没人在线时未清理缺少的变量)
VarClearKeyList_J = { 
    "J_lf_open_count",            
    "J_mf_open_time",      
    "J_mf_open_time",      
    "JL_blackShop3151",
    "JL_blackShop3152",
    "JL_blackShop3153",
    "JL_blackShop3161",
    "JL_blackShop3162",
    "JL_blackShop3163",
    "J__yabiaocishu",
    "_goldforest_jump_ani",
    "_notsamenum",
    "_goldforest_active_enter",
    "_has_lottery_num",
    "J_yjcy_hand_in_num",
    "JL_fmcf_today",
    "J_exchange_eml_count",
    "JL_luckForce",
    "JL_treasureOne",
    "JL_treasureOpen",
    "JL_treasureTodayPoint",
    "J_open_server_gift",
    "J_myzm_jj_type",
    "J_today_zstq",
    "tqfwcx",
    "J_myzm_flush_count",
    "J_castlewar_reward",
    "J_days_later",
    "J_surpise_box_double",
    "_wolong_open_count",
    "_wolong_all_award_isget",
    "tqfwcx",
    "J_add_attr_value",
    "J_add_recycle_rate",
    "J_castlewar_point",
    "J_castlewar_reward",
    "JL_treasureOpen",
    "JL_treasureTodayPoint",
    VarIntDef.DAY_RECHARGE,
    "J_today_buy_cycf",
    "JL_cycf1",
    "JL_cycf10",
    "JL_ggfd",
    "J_today_buy_hssr",
    "JL_slfd",
    "J_today_buy_hssr",
    "JL_fsfd",
    "J_today_buy_hssr",
    "JL_dwfd",
    "J_today_buy_hssr",
    "JL_lsfd",
    "JL_fwfd",
    VarIntDef.EverydayRecharge,
    VarIntDef.DAY_RECHARGE,
    "J_molongcheng_in_num",
    "J_kill_mon_count",
    "J_disguiseMapTime",
    "J_enter_num",
    "J_disguiseMapTime",
    "J_myzm_dh_count",
}
VarClearKeyList_Z = { 
    "_gold_has_lottery",
    "_goldforesrProgress",
    "Z_map_join_count",
    "Z_myzm_jj_award",
    "Z_online_gift_award",
    "Z_recharge_back_gift_award",
    "Z_one_day_look",
    "Z_gift_thlb",
}