---alg工作台
---xls转lua table
---本工具免费 交流QQ群:436063587
local config = {
 
	[1] = {
 		["key_name"]=1,
		["equip_idx"]=50340,
		["equip_name"]="战神头盔", 
	},
	[2] = {
 		["key_name"]=2,
		["equip_idx"]=50341,
		["equip_name"]="战神项链", 
	},
	[3] = {
 		["key_name"]=3,
		["equip_idx"]=50342,
		["equip_name"]="战神手镯", 
	},
	[4] = {
 		["key_name"]=4,
		["equip_idx"]=50343,
		["equip_name"]="战神戒指", 
	},
	[5] = {
 		["key_name"]=5,
		["equip_idx"]=50344,
		["equip_name"]="战神圣靴", 
	},
	[6] = {
 		["key_name"]=6,
		["equip_idx"]=50345,
		["equip_name"]="战神腰带", 
	},
	[7] = {
 		["key_name"]=7,
		["equip_idx"]=50346,
		["equip_name"]="圣魔头盔", 
	},
	[8] = {
 		["key_name"]=8,
		["equip_idx"]=50347,
		["equip_name"]="圣魔项链", 
	},
	[9] = {
 		["key_name"]=9,
		["equip_idx"]=50348,
		["equip_name"]="圣魔手镯", 
	},
	[10] = {
 		["key_name"]=10,
		["equip_idx"]=50349,
		["equip_name"]="圣魔戒指", 
	},
	[11] = {
 		["key_name"]=11,
		["equip_idx"]=50351,
		["equip_name"]="圣魔法靴", 
	},
	[12] = {
 		["key_name"]=12,
		["equip_idx"]=50350,
		["equip_name"]="圣魔腰带", 
	},
	[13] = {
 		["key_name"]=13,
		["equip_idx"]=50353,
		["equip_name"]="真魂头盔", 
	},
	[14] = {
 		["key_name"]=14,
		["equip_idx"]=50354,
		["equip_name"]="真魂项链", 
	},
	[15] = {
 		["key_name"]=15,
		["equip_idx"]=50355,
		["equip_name"]="真魂手镯", 
	},
	[16] = {
 		["key_name"]=16,
		["equip_idx"]=50356,
		["equip_name"]="真魂戒指", 
	},
	[17] = {
 		["key_name"]=17,
		["equip_idx"]=50358,
		["equip_name"]="真魂道靴", 
	},
	[18] = {
 		["key_name"]=18,
		["equip_idx"]=50357,
		["equip_name"]="真魂腰带", 
	},
	[19] = {
 		["key_name"]=19,
		["equip_idx"]=50363,
		["equip_name"]="火龙战盔", 
	},
	[20] = {
 		["key_name"]=20,
		["equip_idx"]=50364,
		["equip_name"]="火龙战链", 
	},
	[21] = {
 		["key_name"]=21,
		["equip_idx"]=50365,
		["equip_name"]="火龙战镯", 
	},
	[22] = {
 		["key_name"]=22,
		["equip_idx"]=50366,
		["equip_name"]="火龙战戒", 
	},
	[23] = {
 		["key_name"]=23,
		["equip_idx"]=50367,
		["equip_name"]="火龙战靴", 
	},
	[24] = {
 		["key_name"]=24,
		["equip_idx"]=50368,
		["equip_name"]="火龙战带", 
	},
	[25] = {
 		["key_name"]=25,
		["equip_idx"]=50370,
		["equip_name"]="火龙魔盔", 
	},
	[26] = {
 		["key_name"]=26,
		["equip_idx"]=50371,
		["equip_name"]="火龙魔链", 
	},
	[27] = {
 		["key_name"]=27,
		["equip_idx"]=50372,
		["equip_name"]="火龙魔镯", 
	},
	[28] = {
 		["key_name"]=28,
		["equip_idx"]=50373,
		["equip_name"]="火龙魔戒", 
	},
	[29] = {
 		["key_name"]=29,
		["equip_idx"]=50374,
		["equip_name"]="火龙魔靴", 
	},
	[30] = {
 		["key_name"]=30,
		["equip_idx"]=50375,
		["equip_name"]="火龙魔带", 
	},
	[31] = {
 		["key_name"]=31,
		["equip_idx"]=50377,
		["equip_name"]="火龙道盔", 
	},
	[32] = {
 		["key_name"]=32,
		["equip_idx"]=50378,
		["equip_name"]="火龙道链", 
	},
	[33] = {
 		["key_name"]=33,
		["equip_idx"]=50379,
		["equip_name"]="火龙道镯", 
	},
	[34] = {
 		["key_name"]=34,
		["equip_idx"]=50380,
		["equip_name"]="火龙道戒", 
	},
	[35] = {
 		["key_name"]=35,
		["equip_idx"]=50381,
		["equip_name"]="火龙道靴", 
	},
	[36] = {
 		["key_name"]=36,
		["equip_idx"]=50382,
		["equip_name"]="火龙道带", 
	},
	[37] = {
 		["key_name"]=37,
		["equip_idx"]=50383,
		["equip_name"]="天龙战盔", 
	},
	[38] = {
 		["key_name"]=38,
		["equip_idx"]=50384,
		["equip_name"]="天龙战链", 
	},
	[39] = {
 		["key_name"]=39,
		["equip_idx"]=50385,
		["equip_name"]="天龙战镯", 
	},
	[40] = {
 		["key_name"]=40,
		["equip_idx"]=50386,
		["equip_name"]="天龙战戒", 
	},
	[41] = {
 		["key_name"]=41,
		["equip_idx"]=50388,
		["equip_name"]="天龙战靴", 
	},
	[42] = {
 		["key_name"]=42,
		["equip_idx"]=50387,
		["equip_name"]="天龙战带", 
	},
	[43] = {
 		["key_name"]=43,
		["equip_idx"]=50392,
		["equip_name"]="天龙魔盔", 
	},
	[44] = {
 		["key_name"]=44,
		["equip_idx"]=50393,
		["equip_name"]="天龙魔链", 
	},
	[45] = {
 		["key_name"]=45,
		["equip_idx"]=50394,
		["equip_name"]="天龙魔镯", 
	},
	[46] = {
 		["key_name"]=46,
		["equip_idx"]=50395,
		["equip_name"]="天龙魔戒", 
	},
	[47] = {
 		["key_name"]=47,
		["equip_idx"]=50397,
		["equip_name"]="天龙魔靴", 
	},
	[48] = {
 		["key_name"]=48,
		["equip_idx"]=50396,
		["equip_name"]="天龙魔带", 
	},
	[49] = {
 		["key_name"]=49,
		["equip_idx"]=50399,
		["equip_name"]="天龙道盔", 
	},
	[50] = {
 		["key_name"]=50,
		["equip_idx"]=50400,
		["equip_name"]="天龙道链", 
	},
	[51] = {
 		["key_name"]=51,
		["equip_idx"]=50401,
		["equip_name"]="天龙道镯", 
	},
	[52] = {
 		["key_name"]=52,
		["equip_idx"]=50402,
		["equip_name"]="天龙道戒", 
	},
	[53] = {
 		["key_name"]=53,
		["equip_idx"]=50404,
		["equip_name"]="天龙道靴", 
	},
	[54] = {
 		["key_name"]=54,
		["equip_idx"]=50403,
		["equip_name"]="天龙道带", 
	},
	[55] = {
 		["key_name"]=55,
		["equip_idx"]=50406,
		["equip_name"]="神龙战盔", 
	},
	[56] = {
 		["key_name"]=56,
		["equip_idx"]=50407,
		["equip_name"]="神龙战链", 
	},
	[57] = {
 		["key_name"]=57,
		["equip_idx"]=50408,
		["equip_name"]="神龙战镯", 
	},
	[58] = {
 		["key_name"]=58,
		["equip_idx"]=50409,
		["equip_name"]="神龙战戒", 
	},
	[59] = {
 		["key_name"]=59,
		["equip_idx"]=50411,
		["equip_name"]="神龙战靴", 
	},
	[60] = {
 		["key_name"]=60,
		["equip_idx"]=50410,
		["equip_name"]="神龙战带", 
	},
	[61] = {
 		["key_name"]=61,
		["equip_idx"]=50415,
		["equip_name"]="神龙魔盔", 
	},
	[62] = {
 		["key_name"]=62,
		["equip_idx"]=50416,
		["equip_name"]="神龙魔链", 
	},
	[63] = {
 		["key_name"]=63,
		["equip_idx"]=50417,
		["equip_name"]="神龙魔镯", 
	},
	[64] = {
 		["key_name"]=64,
		["equip_idx"]=50418,
		["equip_name"]="神龙魔戒", 
	},
	[65] = {
 		["key_name"]=65,
		["equip_idx"]=50420,
		["equip_name"]="神龙魔靴", 
	},
	[66] = {
 		["key_name"]=66,
		["equip_idx"]=50419,
		["equip_name"]="神龙魔带", 
	},
	[67] = {
 		["key_name"]=67,
		["equip_idx"]=50422,
		["equip_name"]="神龙道盔", 
	},
	[68] = {
 		["key_name"]=68,
		["equip_idx"]=50423,
		["equip_name"]="神龙道链", 
	},
	[69] = {
 		["key_name"]=69,
		["equip_idx"]=50424,
		["equip_name"]="神龙道镯", 
	},
	[70] = {
 		["key_name"]=70,
		["equip_idx"]=50425,
		["equip_name"]="神龙道戒", 
	},
	[71] = {
 		["key_name"]=71,
		["equip_idx"]=50427,
		["equip_name"]="神龙道靴", 
	},
	[72] = {
 		["key_name"]=72,
		["equip_idx"]=50426,
		["equip_name"]="神龙道带", 
	},
	[73] = {
 		["key_name"]=73,
		["equip_idx"]=50429,
		["equip_name"]="聖龍战盔", 
	},
	[74] = {
 		["key_name"]=74,
		["equip_idx"]=50430,
		["equip_name"]="聖龍战链", 
	},
	[75] = {
 		["key_name"]=75,
		["equip_idx"]=50431,
		["equip_name"]="聖龍战镯", 
	},
	[76] = {
 		["key_name"]=76,
		["equip_idx"]=50432,
		["equip_name"]="聖龍战戒", 
	},
	[77] = {
 		["key_name"]=77,
		["equip_idx"]=50434,
		["equip_name"]="聖龍战靴", 
	},
	[78] = {
 		["key_name"]=78,
		["equip_idx"]=50433,
		["equip_name"]="聖龍战带", 
	},
	[79] = {
 		["key_name"]=79,
		["equip_idx"]=50438,
		["equip_name"]="聖龍魔盔", 
	},
	[80] = {
 		["key_name"]=80,
		["equip_idx"]=50439,
		["equip_name"]="聖龍魔链", 
	},
	[81] = {
 		["key_name"]=81,
		["equip_idx"]=50440,
		["equip_name"]="聖龍魔镯", 
	},
	[82] = {
 		["key_name"]=82,
		["equip_idx"]=50441,
		["equip_name"]="聖龍魔戒", 
	},
	[83] = {
 		["key_name"]=83,
		["equip_idx"]=50443,
		["equip_name"]="聖龍魔靴", 
	},
	[84] = {
 		["key_name"]=84,
		["equip_idx"]=50442,
		["equip_name"]="聖龍魔带", 
	},
	[85] = {
 		["key_name"]=85,
		["equip_idx"]=50445,
		["equip_name"]="聖龍道盔", 
	},
	[86] = {
 		["key_name"]=86,
		["equip_idx"]=50446,
		["equip_name"]="聖龍道链", 
	},
	[87] = {
 		["key_name"]=87,
		["equip_idx"]=50447,
		["equip_name"]="聖龍道镯", 
	},
	[88] = {
 		["key_name"]=88,
		["equip_idx"]=50448,
		["equip_name"]="聖龍道戒", 
	},
	[89] = {
 		["key_name"]=89,
		["equip_idx"]=50450,
		["equip_name"]="聖龍道靴", 
	},
	[90] = {
 		["key_name"]=90,
		["equip_idx"]=50449,
		["equip_name"]="聖龍道带", 
	},
	[91] = {
 		["key_name"]=91,
		["equip_idx"]=50360,
		["equip_name"]="火龙战刃", 
	},
	[92] = {
 		["key_name"]=92,
		["equip_idx"]=50369,
		["equip_name"]="火龙魔刃", 
	},
	[93] = {
 		["key_name"]=93,
		["equip_idx"]=50376,
		["equip_name"]="火龙道刃", 
	},
	[94] = {
 		["key_name"]=94,
		["equip_idx"]=50361,
		["equip_name"]="火龙神袍", 
	},
	[95] = {
 		["key_name"]=95,
		["equip_idx"]=50362,
		["equip_name"]="火龙神甲", 
	},
	[96] = {
 		["key_name"]=96,
		["equip_idx"]=50389,
		["equip_name"]="天龙战刃", 
	},
	[97] = {
 		["key_name"]=97,
		["equip_idx"]=50398,
		["equip_name"]="天龙魔刃", 
	},
	[98] = {
 		["key_name"]=98,
		["equip_idx"]=50405,
		["equip_name"]="天龙道刃", 
	},
	[99] = {
 		["key_name"]=99,
		["equip_idx"]=50390,
		["equip_name"]="天龙神甲", 
	},
	[100] = {
 		["key_name"]=100,
		["equip_idx"]=50391,
		["equip_name"]="天龙神袍", 
	},
	[101] = {
 		["key_name"]=101,
		["equip_idx"]=50412,
		["equip_name"]="神龙战刃", 
	},
	[102] = {
 		["key_name"]=102,
		["equip_idx"]=50421,
		["equip_name"]="神龙魔刃", 
	},
	[103] = {
 		["key_name"]=103,
		["equip_idx"]=50428,
		["equip_name"]="神龙道刃", 
	},
	[104] = {
 		["key_name"]=104,
		["equip_idx"]=50413,
		["equip_name"]="神龙神甲", 
	},
	[105] = {
 		["key_name"]=105,
		["equip_idx"]=50414,
		["equip_name"]="神龙神袍", 
	},
	[106] = {
 		["key_name"]=106,
		["equip_idx"]=50435,
		["equip_name"]="聖龍战刃", 
	},
	[107] = {
 		["key_name"]=107,
		["equip_idx"]=50444,
		["equip_name"]="聖龍魔刃", 
	},
	[108] = {
 		["key_name"]=108,
		["equip_idx"]=50451,
		["equip_name"]="聖龍道刃", 
	},
	[109] = {
 		["key_name"]=109,
		["equip_idx"]=50436,
		["equip_name"]="聖龍神甲", 
	},
	[110] = {
 		["key_name"]=110,
		["equip_idx"]=50437,
		["equip_name"]="聖龍神袍", 
	},
	[111] = {
 		["key_name"]=111,
		["equip_idx"]=50452,
		["equip_name"]="宗师战盔", 
	},
	[112] = {
 		["key_name"]=112,
		["equip_idx"]=50453,
		["equip_name"]="宗师战链", 
	},
	[113] = {
 		["key_name"]=113,
		["equip_idx"]=50454,
		["equip_name"]="宗师战镯", 
	},
	[114] = {
 		["key_name"]=114,
		["equip_idx"]=50455,
		["equip_name"]="宗师战戒", 
	},
	[115] = {
 		["key_name"]=115,
		["equip_idx"]=50456,
		["equip_name"]="宗师战带", 
	},
	[116] = {
 		["key_name"]=116,
		["equip_idx"]=50457,
		["equip_name"]="宗师战靴", 
	},
	[117] = {
 		["key_name"]=117,
		["equip_idx"]=50458,
		["equip_name"]="宗师战刃", 
	},
	[118] = {
 		["key_name"]=118,
		["equip_idx"]=50459,
		["equip_name"]="宗师神甲", 
	},
	[119] = {
 		["key_name"]=119,
		["equip_idx"]=50460,
		["equip_name"]="宗师神袍", 
	},
	[120] = {
 		["key_name"]=120,
		["equip_idx"]=50461,
		["equip_name"]="宗师魔盔", 
	},
	[121] = {
 		["key_name"]=121,
		["equip_idx"]=50462,
		["equip_name"]="宗师魔链", 
	},
	[122] = {
 		["key_name"]=122,
		["equip_idx"]=50463,
		["equip_name"]="宗师魔镯", 
	},
	[123] = {
 		["key_name"]=123,
		["equip_idx"]=50464,
		["equip_name"]="宗师魔戒", 
	},
	[124] = {
 		["key_name"]=124,
		["equip_idx"]=50465,
		["equip_name"]="宗师魔带", 
	},
	[125] = {
 		["key_name"]=125,
		["equip_idx"]=50466,
		["equip_name"]="宗师魔靴", 
	},
	[126] = {
 		["key_name"]=126,
		["equip_idx"]=50467,
		["equip_name"]="宗师魔刃", 
	},
	[127] = {
 		["key_name"]=127,
		["equip_idx"]=50468,
		["equip_name"]="宗师道盔", 
	},
	[128] = {
 		["key_name"]=128,
		["equip_idx"]=50469,
		["equip_name"]="宗师道链", 
	},
	[129] = {
 		["key_name"]=129,
		["equip_idx"]=50470,
		["equip_name"]="宗师道镯", 
	},
	[130] = {
 		["key_name"]=130,
		["equip_idx"]=50471,
		["equip_name"]="宗师道戒", 
	},
	[131] = {
 		["key_name"]=131,
		["equip_idx"]=50472,
		["equip_name"]="宗师道带", 
	},
	[132] = {
 		["key_name"]=132,
		["equip_idx"]=50473,
		["equip_name"]="宗师道靴", 
	},
	[133] = {
 		["key_name"]=133,
		["equip_idx"]=50474,
		["equip_name"]="宗师道刃", 
	},
	[134] = {
 		["key_name"]=134,
		["equip_idx"]=51073,
		["equip_name"]="异次元:宗师道盔", 
	},
	[135] = {
 		["key_name"]=135,
		["equip_idx"]=51074,
		["equip_name"]="异次元:宗师道链", 
	},
	[136] = {
 		["key_name"]=136,
		["equip_idx"]=51075,
		["equip_name"]="异次元:宗师道镯", 
	},
	[137] = {
 		["key_name"]=137,
		["equip_idx"]=51076,
		["equip_name"]="异次元:宗师道戒", 
	},
	[138] = {
 		["key_name"]=138,
		["equip_idx"]=51077,
		["equip_name"]="异次元:宗师道带", 
	},
	[139] = {
 		["key_name"]=139,
		["equip_idx"]=51078,
		["equip_name"]="异次元:宗师道靴", 
	},
	[140] = {
 		["key_name"]=140,
		["equip_idx"]=51079,
		["equip_name"]="异次元:宗师魔盔", 
	},
	[141] = {
 		["key_name"]=141,
		["equip_idx"]=51080,
		["equip_name"]="异次元:宗师魔链", 
	},
	[142] = {
 		["key_name"]=142,
		["equip_idx"]=51081,
		["equip_name"]="异次元:宗师魔镯", 
	},
	[143] = {
 		["key_name"]=143,
		["equip_idx"]=51082,
		["equip_name"]="异次元:宗师魔戒", 
	},
	[144] = {
 		["key_name"]=144,
		["equip_idx"]=51083,
		["equip_name"]="异次元:宗师魔带", 
	},
	[145] = {
 		["key_name"]=145,
		["equip_idx"]=51084,
		["equip_name"]="异次元:宗师魔靴", 
	},
	[146] = {
 		["key_name"]=146,
		["equip_idx"]=51085,
		["equip_name"]="异次元:宗师战盔", 
	},
	[147] = {
 		["key_name"]=147,
		["equip_idx"]=51086,
		["equip_name"]="异次元:宗师战链", 
	},
	[148] = {
 		["key_name"]=148,
		["equip_idx"]=51087,
		["equip_name"]="异次元:宗师战镯", 
	},
	[149] = {
 		["key_name"]=149,
		["equip_idx"]=51088,
		["equip_name"]="异次元:宗师战戒", 
	},
	[150] = {
 		["key_name"]=150,
		["equip_idx"]=51089,
		["equip_name"]="异次元:宗师战带", 
	},
	[151] = {
 		["key_name"]=151,
		["equip_idx"]=51090,
		["equip_name"]="异次元:宗师战靴", 
	},
	[152] = {
 		["key_name"]=152,
		["equip_idx"]=51091,
		["equip_name"]="异次元:宗师战刃", 
	},
	[153] = {
 		["key_name"]=153,
		["equip_idx"]=51092,
		["equip_name"]="异次元:宗师魔刃", 
	},
	[154] = {
 		["key_name"]=154,
		["equip_idx"]=51093,
		["equip_name"]="异次元:宗师道刃", 
	},
	[155] = {
 		["key_name"]=155,
		["equip_idx"]=51094,
		["equip_name"]="异次元:宗师神甲", 
	},
	[156] = {
 		["key_name"]=156,
		["equip_idx"]=51095,
		["equip_name"]="异次元:宗师神袍", 
	},  
}
 return config;