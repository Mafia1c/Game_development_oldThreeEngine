---alg工作台
---xls转lua table
---时间:Wed Jul 09 16:36:47 CST 2025
---本工具免费 交流QQ群:436063587
local config = {
 
	[1] = {
 		["key_name"]=1,
		["Name"]="神龙脊",
		["nedd_map"]={["神龙脊[残]"]=1,["龙之心"]=999,["龙之血"]=999,["金刚石"]=100000,},
		["title"]="<神龙脊[残]/FCOLOR=249> <出处/FCOLOR=253>", 
		["map"]="<地图: /FCOLOR=250> <西沙海底-书院/FCOLOR=251>",
		["boss"]="<BOSS: /FCOLOR=249> <魔界神龙/FCOLOR=249>", 
		["baoLv"] = "<专属爆率: /FCOLOR=250> <1/50/FCOLOR=243>"
	},
	[2] = {
 		["key_name"]=2,
		["Name"]="飞龙皮",
		["nedd_map"]={["飞龙皮[残]"]=1,["龙之心"]=999,["龙之血"]=999,["金刚石"]=100000,},
		["title"]="<飞龙皮[残]/FCOLOR=249> <出处/FCOLOR=253>", 
		["map"]="<地图: /FCOLOR=250> <死亡之岛-禁地/FCOLOR=251>",
		["boss"]="<BOSS: /FCOLOR=249> <魔界飞龙/FCOLOR=249>", 
		["baoLv"] = "<专属爆率: /FCOLOR=250> <1/50/FCOLOR=243>"		
	},
	[3] = {
 		["key_name"]=3,
		["Name"]="暗龙角",
		["nedd_map"]={["暗龙角[残]"]=1,["龙之心"]=999,["龙之血"]=999,["金刚石"]=50000,},
		["title"]="<暗龙角[残]/FCOLOR=249> <出处/FCOLOR=253>", 
		["map"]="<地图: /FCOLOR=250> <失乐森林-魔宫/FCOLOR=251>",
		["boss"]="<BOSS: /FCOLOR=249> <魔界暗龙/FCOLOR=249>", 
		["baoLv"] = "<专属爆率: /FCOLOR=250> <1/50/FCOLOR=243>"			
	},
	[4] = {
 		["key_name"]=4,
		["Name"]="天龙眼",
		["nedd_map"]={["天龙眼[残]"]=1,["龙之心"]=999,["龙之血"]=999,["金刚石"]=50000,},
		["title"]="<天龙眼[残]/FCOLOR=249> <出处/FCOLOR=253>", 
		["map"]="<地图: /FCOLOR=250> <骨魔洞穴-坟场/FCOLOR=251>",
		["boss"]="<BOSS: /FCOLOR=249> <魔界恶龙/FCOLOR=249>", 
		["baoLv"] = "<专属爆率: /FCOLOR=250> <1/50/FCOLOR=243>"			
	},
	[5] = {
 		["key_name"]=5,
		["Name"]="邪龙爪",
		["nedd_map"]={["邪龙爪[残]"]=1,["龙之心"]=999,["龙之血"]=999,["金刚石"]=50000,},
		["title"]="<邪龙爪[残]/FCOLOR=249> <出处/FCOLOR=253>", 
		["map"]="<地图: /FCOLOR=250> <潘夜神庙-神殿/FCOLOR=251>",
		["boss"]="<BOSS: /FCOLOR=249> <魔界邪龙/FCOLOR=249>", 
		["baoLv"] = "<专属爆率: /FCOLOR=250> <1/50/FCOLOR=243>"			
	},
	[6] = {
 		["key_name"]=6,
		["Name"]="苍龙骨",
		["nedd_map"]={["苍龙骨[残]"]=1,["龙之心"]=999,["龙之血"]=999,["金刚石"]=50000,},
		["title"]="<苍龙骨[残]/FCOLOR=249> <出处/FCOLOR=253>", 
		["map"]="<地图: /FCOLOR=250> <尸魔禁地-祭坛/FCOLOR=251>",
		["boss"]="<BOSS: /FCOLOR=249> <魔界苍龙/FCOLOR=249>", 
		["baoLv"] = "<专属爆率: /FCOLOR=250> <1/50/FCOLOR=243>"			
	},
	[7] = {
 		["key_name"]=7,
		["Name"]="炎龙羽",
		["nedd_map"]={["炎龙羽[残]"]=1,["龙之心"]=999,["龙之血"]=999,["金刚石"]=50000,},
		["title"]="<炎龙羽[残]/FCOLOR=249> <出处/FCOLOR=253>", 
		["map"]="<地图: /FCOLOR=250> <苍月岛隐藏地图/FCOLOR=251>",
		["boss"]="<BOSS: /FCOLOR=249> <魔界炎龙/FCOLOR=249>", 
		["baoLv"] = "<专属爆率: /FCOLOR=250> <1/50/FCOLOR=243>"			
	},
	[8] = {
 		["key_name"]=8,
		["Name"]="恶龙鳞",
		["nedd_map"]={["恶龙鳞[残]"]=1,["龙之心"]=999,["龙之血"]=999,["金刚石"]=50000,},
		["title"]="<恶龙鳞[残]/FCOLOR=249> <出处/FCOLOR=253>", 
		["map"]="<地图: /FCOLOR=250> <苍月岛隐藏地图/FCOLOR=251>",
		["boss"]="<BOSS: /FCOLOR=249> <魔界天龙/FCOLOR=249>", 
		["baoLv"] = "<专属爆率: /FCOLOR=250> <1/50/FCOLOR=243>"			
	},  
}
 return config;