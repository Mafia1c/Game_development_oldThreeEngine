---alg工作台
---xls转lua table
---时间:Wed Jul 16 11:13:00 CST 2025
---本工具免费 交流QQ群:436063587
local config = {
 
	[1] = {
 		["key_name"]=1,
		["name"]="异界水晶",
		["needMaterials_map"]={["龙之心"]=9,["龙之血"]=9,},
		["needCurrency_map"]={["金刚石"]=20000,}, 
	},
	[2] = {
 		["key_name"]=2,
		["name"]="异界魂石",
		["needMaterials_map"]={["龙神石"]=9,["五魂石"]=9,},
		["needCurrency_map"]={["灵符"]=100,}, 
	},
	[3] = {
 		["key_name"]=3,
		["name"]="次元魔石",
		["needMaterials_map"]={["龙神石"]=9,["觉醒宝石"]=9,},
		["needCurrency_map"]={["灵符"]=100,}, 
	},
	[4] = {
 		["key_name"]=4,
		["name"]="异界挑战书",
		["needMaterials_map"]={["恶魔挑战卷"]=9,["十转凭证"]=9,},
		["needCurrency_map"]={["金刚石"]=100000,}, 
	},
	[5] = {
 		["key_name"]=5,
		["name"]="国殇残魂",
		["needMaterials_map"]={["龙神石"]=9,},
		["needCurrency_map"]={["金刚石"]=10000,}, 
	},  
}
 return config;