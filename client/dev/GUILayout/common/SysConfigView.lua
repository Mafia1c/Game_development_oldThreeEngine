--- 传奇系统面板
--- 这些id对应的面板都是定死的 任何版本都一样
ViewCfg = {}

ViewCfg.Equip                   = 1             -- 角色-装备
ViewCfg.State                   = 2             -- 角色-状态
ViewCfg.Attri                   = 3             -- 角色-属性
ViewCfg.Skill                   = 4             -- 角色-技能
ViewCfg.Title                   = 5             -- 角色-装备
ViewCfg.BestRing                = 6             -- 角色-首饰盒
ViewCfg.Bag                     = 7             -- 背包
ViewCfg.Stall                   = 8             -- 摆摊
ViewCfg.StoreHot                = 9             -- 商城-热销
ViewCfg.StoreBeauty             = 10            -- 商城-装饰
ViewCfg.StoreEngine             = 11            -- 商城-功能
ViewCfg.StoreFestival           = 12            -- 商城-节日
ViewCfg.GuildMain               = 13            -- 行会-主界面
ViewCfg.GuildMember             = 14            -- 行会成员列表
ViewCfg.GuildList               = 15            -- 行会列表
ViewCfg.Mail                    = 16            -- 邮件
ViewCfg.Team                    = 17            -- 组队
ViewCfg.NearPlayer              = 18            -- 附近玩家
ViewCfg.Buff                    = 19            -- BUFF面板
ViewCfg.SettingProtect          = 20            -- 设置保护
ViewCfg.SettingPickSet          = 21            -- 设置拾取
ViewCfg.SettingFight            = 22            -- 设置战斗
ViewCfg.SettingBase             = 23            -- 设置基础
ViewCfg.MiniMap                 = 24            -- 小地图
ViewCfg.SkillSetting            = 25            -- 技能设置
ViewCfg.StoreRecharge           = 26            -- 充值
ViewCfg.Auction                 = 27            -- 拍卖行
ViewCfg.Friend                  = 28            -- 好友
ViewCfg.ExitToRole              = 29            -- 小退
ViewCfg.GuildCreate             = 30            -- 行会创建
ViewCfg.Guild                   = 31            -- 智能行会界面
ViewCfg.Rank                    = 32            -- 排行榜
ViewCfg.Trade                   = 33            -- 面对面交易 请求
ViewCfg.ForceExitToRole         = 34            -- 强制小退
ViewCfg.TradingBank             = 35            -- 交易行
ViewCfg.GuideEnter              = 36            -- 引导进入
ViewCfg.SuperEquip              = 37            -- 角色-神装
ViewCfg.HeroEquip               = 41            -- 英雄-装备
ViewCfg.HeroState               = 42            -- 英雄-状态
ViewCfg.HeroAttri               = 43            -- 英雄-属性
ViewCfg.HeroSkill               = 44            -- 英雄-技能
ViewCfg.HeroTitle               = 45            -- 英雄-称号
ViewCfg.HeroBestRing            = 46            -- 英雄-首饰盒
ViewCfg.HeroBag                 = 47            -- 英雄-背包
ViewCfg.HeroSuperEquip          = 48            -- 英雄-神装
ViewCfg.ReinAttrPoint           = 51            -- 转生属性点
ViewCfg.Chat                    = 52            -- 聊天
ViewCfg.PCPrivate               = 53            -- PC 私聊记录页
ViewCfg.MagicJointAttack        = 99            -- 释放合击
ViewCfg.AssistChange            = 110           -- 主界面-任务栏
ViewCfg.Box996                  = 111           -- 盒子称号
ViewCfg.MainMiniMapChange       = 112           -- 小地图伸缩
ViewCfg.PCResolution            = 113           -- PC 分辨率设置
ViewCfg.ChatExtendEmoj          = 114           -- 角色-表情
ViewCfg.ChatExtendBag           = 115           -- 聊天小框-背包
ViewCfg.MainNear                = 116           -- 主界面-附近列表 玩家/怪物显示面板
ViewCfg.CallPay                 = 117           -- 调用-支付
ViewCfg.SettingBasic            = 300           -- 基础设置
ViewCfg.SettingWindowRange      = 301           -- 视距
ViewCfg.SettingFight            = 302           -- 战斗
ViewCfg.SettingProtect          = 303           -- 保护
ViewCfg.SettingAuto             = 304           -- 挂机
ViewCfg.SettingHelp             = 305           -- 帮助


--- 系统面板lua框架提供了对应打开/关闭函数
--- 这里统一管理 方便复用
--[[
    oFunc: 打开面板
    cFunc: 关闭面板
    remove: 移除对应子页id内容
--]]
--[[示例
    local cfg = ViewCfg[ViewCfg.Equip]
    if cfg and cfg.oFunc then
        cfg:oFunc()
    end
--]]
-- 玩家角色装备界面
ViewCfg[ViewCfg.Equip] = {
    oFunc = function(param) SL:OpenMyPlayerUI({extent = 1, isFast = param})  end,
    cFunc = function() SL:CloseMyPlayerUI()  end,
    remove = function() SL:CloseMyPlayerPageUI({extent = 1})  end,
}
-- 玩家角色状态界面
ViewCfg[ViewCfg.State] = {
    oFunc = function(param) SL:OpenMyPlayerUI({extent = 2, isFast = param})  end,
    cFunc = function() SL:CloseMyPlayerUI()  end,
    remove = function() SL:CloseMyPlayerPageUI({extent = 2})  end,
}
-- 玩家角色属性界面
ViewCfg[ViewCfg.Attri] = {
    oFunc = function(param) SL:OpenMyPlayerUI({extent = 3, isFast = param})  end,
    cFunc = function() SL:CloseMyPlayerUI()  end,
    remove = function() SL:CloseMyPlayerPageUI({extent = 3})  end,
}
-- 玩家角色技能界面
ViewCfg[ViewCfg.Skill] = {
    oFunc = function(param) SL:OpenMyPlayerUI({extent = 4, isFast = param})  end,
    cFunc = function() SL:CloseMyPlayerUI()  end,
    remove = function() SL:CloseMyPlayerPageUI({extent = 4})  end,
}
-- 玩家角色称号界面
ViewCfg[ViewCfg.Title] = {
    oFunc = function(param) SL:OpenMyPlayerUI({extent = 6, isFast = param})  end,
    cFunc = function() SL:CloseMyPlayerUI()  end,
    remove = function() SL:CloseMyPlayerPageUI({extent = 6})  end,
}
-- 玩家角色首饰盒界面
ViewCfg[ViewCfg.BestRing] = {
    oFunc = function() SL:OpenBestRingBoxUI(1)  end,
    cFunc = function() SL:CloseBestRingBoxUI(1) end,
}
-- 玩家角色背包
ViewCfg[ViewCfg.Bag] = {
    oFunc = function(data) SL:OpenBagUI(data)  end,     -- {pos = {x = 200, y = 0}, bag_page = 2}   pos : 背包打开位置  bag_page : 背包打开页签ID
    cFunc = function() SL:CloseBagUI() end,
}
-- 摆摊
ViewCfg[ViewCfg.Stall] = {
    oFunc = function() SL:OpenStallLayerUI()  end,
    cFunc = function() SL:CloseStallLayerUI() end,
}
-- 商城热销
ViewCfg[ViewCfg.StoreHot] = {
    oFunc = function() SL:OpenStoreUI(1)  end,
    cFunc = function() SL:CloseStoreUI() end,
}
-- 商城装饰
ViewCfg[ViewCfg.StoreBeauty] = {
    oFunc = function() SL:OpenStoreUI(2)  end,
    cFunc = function() SL:CloseStoreUI() end,
}
-- 商城功能
ViewCfg[ViewCfg.StoreEngine] = {
    oFunc = function() SL:OpenStoreUI(3)  end,
    cFunc = function() SL:CloseStoreUI() end,
}
-- 商城节日
ViewCfg[ViewCfg.StoreFestival] = {
    oFunc = function() SL:OpenStoreUI(4)  end,
    cFunc = function() SL:CloseStoreUI() end,
}
-- 行会主界面
ViewCfg[ViewCfg.GuildMain] = {
    oFunc = function() SL:OpenGuildMainUI(1)  end,
    cFunc = function() SL:CloseGuildMainUI() end,
}
-- 行会成员列表
ViewCfg[ViewCfg.GuildMember] = {
    oFunc = function() SL:OpenGuildMainUI(2)  end,
    cFunc = function() SL:CloseGuildMainUI() end,
}
-- 行会列表
ViewCfg[ViewCfg.GuildList] = {
    oFunc = function() SL:OpenGuildMainUI(3)  end,
    cFunc = function() SL:CloseGuildMainUI() end,
}
-- 邮件
ViewCfg[ViewCfg.Mail] = {
    oFunc = function() SL:OpenSocialUI(4)  end,
    cFunc = function() SL:CloseSocialUI() end,
}
-- 组队
ViewCfg[ViewCfg.Team] = {
    oFunc = function() SL:OpenSocialUI(2)  end,
    cFunc = function() SL:CloseSocialUI() end,
}
-- 附近玩家
ViewCfg[ViewCfg.NearPlayer] = {
    oFunc = function() SL:OpenSocialUI(1)  end,
    cFunc = function() SL:CloseSocialUI() end,
}
