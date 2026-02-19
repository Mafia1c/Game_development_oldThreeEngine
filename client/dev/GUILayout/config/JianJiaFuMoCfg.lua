---alg工作台
---xls转lua table
---时间:Thu Jul 03 16:16:49 CST 2025
---本工具免费 交流QQ群:436063587
local config = {
 
	[0] = {
 		["key_name"]=0,
		["index"] = 1,
		["need_map"]={["火龙石"]=3,["元宝"]=50000,},
		["probability"]=100,
		["addid_map"]={[35]=0,}, 
	},
	[1] = {
 		["key_name"]=1,
		["index"] = 1,
		["need_map"]={["火龙石"]=3,["元宝"]=50000,},
		["probability"]=100,
		["addid_map"]={[35]=2,}, 
	},
	[2] = {
 		["key_name"]=2,
		["index"] = 1,
		["need_map"]={["火龙石"]=3,["元宝"]=50000,},
		["probability"]=100,
		["addid_map"]={[35]=4,}, 
	},
	[3] = {
 		["key_name"]=3,
		["index"] = 1,
		["need_map"]={["火龙石"]=5,["金刚石"]=500,},
		["probability"]=100,
		["addid_map"]={[35]=6,}, 
	},
	[4] = {
 		["key_name"]=4,
		["index"] = 1,
		["need_map"]={["火龙石"]=5,["金刚石"]=1000,},
		["probability"]=100,
		["addid_map"]={[35]=8,}, 
	},
	[5] = {
 		["key_name"]=5,
		["index"] = 1,
		["need_map"]={["火龙石"]=5,["灵符"]=500,},
		["probability"]=100,
		["addid_map"]={[35]=10,}, 
	},
	[6] = {
 		["key_name"]=6,
		["index"] = 1,
		["need_map"]={["火龙石"]=10,["灵符"]=2000,},
		["probability"]=100,
		["addid_map"]={[35]=12,}, 
	},
	[7] = {
 		["key_name"]=7,
		["index"] = 1,
		["need_map"]={["火龙石"]=10,["灵符"]=2000,},
		["probability"]=100,
		["addid_map"]={[35]=15,}, 
	},
	[8] = {
 		["key_name"]=8,
		["index"] = 2,
		["need_map"]={["火龙石"]=3,["元宝"]=50000,},
		["probability"]=100,
		["addid_map"]={[26]=0,[27]=0,}, 
	},
	[9] = {
 		["key_name"]=9,
		["index"] = 2,
		["need_map"]={["火龙石"]=3,["元宝"]=50000,},
		["probability"]=100,
		["addid_map"]={[26]=1,[27]=1,}, 
	},
	[10] = {
 		["key_name"]=10,
		["index"] = 2,
		["need_map"]={["火龙石"]=3,["元宝"]=50000,},
		["probability"]=100,
		["addid_map"]={[26]=2,[27]=2,}, 
	},
	[11] = {
 		["key_name"]=11,
		["index"] = 2,
		["need_map"]={["火龙石"]=5,["金刚石"]=500,},
		["probability"]=100,
		["addid_map"]={[26]=3,[27]=3,}, 
	},
	[12] = {
 		["key_name"]=12,
		["index"] = 2,
		["need_map"]={["火龙石"]=5,["金刚石"]=1000,},
		["probability"]=100,
		["addid_map"]={[26]=5,[27]=5,}, 
	},
	[13] = {
 		["key_name"]=13,
		["index"] = 2,
		["need_map"]={["火龙石"]=5,["灵符"]=500,},
		["probability"]=100,
		["addid_map"]={[26]=7,[27]=7,}, 
	},
	[14] = {
 		["key_name"]=14,
		["index"] = 2,
		["need_map"]={["火龙石"]=10,["灵符"]=2000,},
		["probability"]=100,
		["addid_map"]={[26]=9,[27]=9,}, 
	},
	[15] = {
 		["key_name"]=15,
		["index"] = 2,
		["need_map"]={["火龙石"]=10,["灵符"]=2000,},
		["probability"]=100,
		["addid_map"]={[26]=12,[27]=12,}, 
	},  
}
 return config;