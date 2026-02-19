---alg工作台
---xls转lua table
---本工具免费 交流QQ群:436063587
local config = {
 
	[1] = {
 		["key_name"]=1,
		["map_name"]="混沌战场",
		["map_id"]="hdzc_kf",
		["need_level"]=70,
		["need_zs"]=10,
		["is_open_kb"]=1,
		["reward_arr"]={"火龙装备","天龙装备","神龙装备","游戏货币",},
		["open_time"]="15-16点",
		["boss_name"]="混沌异兽",
		["boss_id"]=20011, 
	},
	[2] = {
 		["key_name"]=2,
		["map_name"]="通灵战场",
		["map_id"]="tlzc_kf",
		["need_level"]=70,
		["need_zs"]=10,
		["is_open_kb"]=1,
		["reward_arr"]={"火龙装备","天龙装备","神龙装备","游戏货币",},
		["open_time"]="22-23点",
		["boss_name"]="通灵异兽",
		["boss_id"]=23023, 
	},  
}
 return config;