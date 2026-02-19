---alg工作台
---xls转lua table
---时间:Tue Jul 01 17:19:50 CST 2025
---本工具免费 交流QQ群:436063587
local config = {
 
	[1] = {
 		["key_name"]=1,
		["skillid_def"]="26#22#13",
		["skillname"]="烈火剑法#火墙#灵魂火符",
		["skillid_pow"]={26,22,13},
	},
	[2] = {
 		["key_name"]=2,
		["skillid_def"]="66#45#52",
		["skillname"]="开天斩#灭天火#飓风破",
		["skillid_pow"]={66,31,55},
	},
	[3] = {
 		["key_name"]=3,
		["skillid_def"]="56#58#57",
		["skillname"]="逐日剑法#流星火雨#噬血术",
		["skillid_pow"]={56,58,52},
	},  
	["needitem_sy"]={20,50,100,150,300,},
	["needitem_jgs"]={100,200,300,400,500,},
	["attribute_def"]="0#1#2#3#4#5",
	["attribute_pow"]="0#3#4#5#8#10",
}
 return config;