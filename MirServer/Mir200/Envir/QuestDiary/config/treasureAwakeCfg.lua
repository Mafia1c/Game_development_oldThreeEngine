---alg工作台
---xls转lua table
---时间:Thu Jul 10 15:03:40 CST 2025
---本工具免费 交流QQ群:436063587
local config = {
 
	[1] = {
 		["key_name"]=1,
		["odd"]=80,
		["needMaterials_map"]={["秘宝水晶"]=1,["沙之书"]=1,},
		["needCurrency_map"]={["金刚石"]=1000,}, 
	},
	[2] = {
 		["key_name"]=2,
		["odd"]=70,
		["needMaterials_map"]={["秘宝水晶"]=2,["沙之书"]=2,},
		["needCurrency_map"]={["金刚石"]=2000,}, 
	},
	[3] = {
 		["key_name"]=3,
		["odd"]=65,
		["needMaterials_map"]={["秘宝水晶"]=3,["沙之书"]=3,},
		["needCurrency_map"]={["金刚石"]=3000,}, 
	},
	[4] = {
 		["key_name"]=4,
		["odd"]=60,
		["needMaterials_map"]={["秘宝水晶"]=4,["沙之书"]=4,},
		["needCurrency_map"]={["金刚石"]=5000,}, 
	},
	[5] = {
 		["key_name"]=5,
		["odd"]=55,
		["needMaterials_map"]={["秘宝水晶"]=5,["沙之书"]=5,},
		["needCurrency_map"]={["金刚石"]=8000,}, 
	},
	[6] = {
 		["key_name"]=6,
		["odd"]=50,
		["needMaterials_map"]={["秘宝水晶"]=6,["沙之书"]=6,},
		["needCurrency_map"]={["金刚石"]=10000,}, 
	},
	[7] = {
 		["key_name"]=7,
		["odd"]=45,
		["needMaterials_map"]={["秘宝水晶"]=7,["沙之书"]=7,},
		["needCurrency_map"]={["金刚石"]=10000,}, 
	},
	[8] = {
 		["key_name"]=8,
		["odd"]=40,
		["needMaterials_map"]={["秘宝水晶"]=8,["沙之书"]=8,},
		["needCurrency_map"]={["金刚石"]=10000,}, 
	},
	[9] = {
 		["key_name"]=9,
		["odd"]=35,
		["needMaterials_map"]={["秘宝水晶"]=9,["沙之书"]=9,},
		["needCurrency_map"]={["金刚石"]=10000,}, 
	},
	[10] = {
 		["key_name"]=10,
		["odd"]=30,
		["needMaterials_map"]={["秘宝水晶"]=10,["沙之书"]=10,},
		["needCurrency_map"]={["金刚石"]=10000,}, 
	},
	[11] = {
 		["key_name"]=11,
		["odd"]=20,
		["needMaterials_map"]={["秘宝水晶"]=11,["沙之书"]=11,},
		["needCurrency_map"]={["金刚石"]=10000,}, 
	},
	[12] = {
 		["key_name"]=12,
		["odd"]=15,
		["needMaterials_map"]={["秘宝水晶"]=12,["沙之书"]=12,},
		["needCurrency_map"]={["金刚石"]=10000,}, 
	},
	["龙骨天书"] = {
 		["key_name"]="龙骨天书", 
	},
	["青铜面具"] = {
 		["key_name"]="青铜面具", 
	},
	["蛇眉铜鱼"] = {
 		["key_name"]="蛇眉铜鱼", 
	},
	["六角铃铛"] = {
 		["key_name"]="六角铃铛", 
	},
	["战国帛书"] = {
 		["key_name"]="战国帛书", 
	},
	["龙鱼鬼玺"] = {
 		["key_name"]="龙鱼鬼玺", 
	},
	["风水秘术"] = {
 		["key_name"]="风水秘术", 
	},
	["龙纹石盒"] = {
 		["key_name"]="龙纹石盒", 
	},
	["月光宝珠"] = {
 		["key_name"]="月光宝珠", 
	},
	["紫玉宝匣"] = {
 		["key_name"]="紫玉宝匣", 
	},
	["金缕玉衣"] = {
 		["key_name"]="金缕玉衣", 
	},
	["雮尘珠"] = {
 		["key_name"]="雮尘珠", 
	},  
}
 return config;