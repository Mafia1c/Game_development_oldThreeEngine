local WoLongTreasure = {}
WoLongTreasure.cfg = include("QuestDiary/config/wolongTreasureCfg.lua")
local type_map = {}
for i,v in ipairs(WoLongTreasure.cfg) do
	type_map[v.group_type] = type_map[v.group_type] or {}
	table.insert(type_map[v.group_type],v)
end
function WoLongTreasure:upEvent(actor,random_index)
	self.random_index = math.random(1,3)
	local open_count = VarApi.getPlayerJIntVar(actor,"_wolong_open_count")	
	lualib:ShowNpcUi(actor,"WoLongTreasureObj","flushinfo#"..self.random_index.."#"..open_count)
end

function WoLongTreasure:ExchangeKey(actor,num)
	local need_num = tonumber(num ) * 200
	if querymoney(actor,getstditeminfo("卧龙令",0))  < need_num then
        return Sendmsg9(actor, "ffffff",  "卧龙令不足"..need_num, 1) 
	end
	if not changemoney(actor,26,"-",need_num,"卧龙宝藏兑换",true) then
		return Sendmsg9(actor, "ffffff",  "卧龙令扣除失败", 1) 
	end
	if giveitem(actor,"卧龙钥匙",tonumber(num),0,"卧龙宝藏兑换") then
		Sendmsg9(actor, "ffffff",  "兑换成功", 1) 
		lualib:FlushNpcUi(actor,"WoLongTreasureObj","flushtip")
	end
end
function WoLongTreasure:BuyKey(actor,num)
	if tonumber(num ) == 10 then
		if getbindmoney(actor,"灵符") < 998 then
			return Sendmsg9(actor, "ffffff",  "灵符数量不足", 1) 
		end
		if not  consumebindmoney(actor,"灵符",998,"卧龙钥匙购买") then
			Sendmsg9(actor, "ffffff",  "灵符扣除失败", 1) 
		end
		if giveitem(actor,"卧龙钥匙",tonumber(num),0,"卧龙宝藏兑换") then
			Sendmsg9(actor, "ffffff",  "购买成功，获得卧龙钥匙x10", 1) 
		end
	else
        if IncludeMainClass("Recharge") then
            IncludeMainClass("Recharge"):gift(actor, "gift_wlys", 1, "WoLongBzTipsOBJ") --#region 礼包名#次数#前端obj
        else
            Sendmsg9(actor, "ff0000", "充值模块异常！", 1)
        end
	end
end
function WoLongTreasure:OpenTreasure(actor,num)
	if getbagitemcount(actor,"卧龙钥匙") < tonumber(num) then
		return Sendmsg9(actor, "ffffff",  "每次开启卧龙宝藏需要卧龙钥匙x"..num, 1) 
	end
	if not takeitemex(actor, "卧龙钥匙", tonumber(num) ,0,"卧龙宝藏") then
        return Sendmsg9(actor, "ffffff",  "物品扣除失败！", 1) 
    end
	local resultCount = {}
	for i = 1, tonumber(num) do
		local prize = WoLongTreasure:drawPrize()
		local cfg =  WoLongTreasure.cfg[prize]
		table.insert(resultCount,{name = cfg.item_name,count = cfg.item_num})
		local stdmode =  getstditeminfo(cfg.item_name,2)
		if  stdmode == 41 then  --货币
			changemoney(actor,getstditeminfo(cfg.item_name, 0),"+",cfg.item_num,"卧龙宝藏",true)
		else
			giveitem(actor,cfg.item_name,cfg.item_num)
		end
	end
	lualib:ShowAwardTipUi(actor,resultCount)
	local open_count = VarApi.getPlayerJIntVar(actor,"_wolong_open_count")	
	VarApi.setPlayerJIntVar(actor,"_wolong_open_count",open_count + tonumber(num))
	if open_count + tonumber(num) >= 99 then
		local state = VarApi.getPlayerJIntVar(actor,"_wolong_all_award_isget")
		if state <= 0 then
			local  award_str =""
			for i = 1, 6 do
				local cfg = WoLongTreasure.cfg[i]
				award_str = award_str .. string.format("%s#%s",cfg.last_item,cfg.last_item_num)  .."&"
			end
			sendmail(getbaseinfo(actor,2),1,"卧龙宝藏","恭喜你今日开启卧龙宝藏达到99次\\卧龙宝藏终极大奖已发放，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时删除邮件！",award_str)
			VarApi.setPlayerJIntVar(actor,"_wolong_all_award_isget",1)

			local player_name = getbaseinfo(actor,1)
			local str =  "卧龙宝藏:恭喜<「%s」/FCOLOR=251>在卧龙山庄成功开启99次宝藏，已获得<「终极大奖」/FCOLOR=251>!"
			Sendmsg13(actor,255, string.format(str,player_name) ,2,13)
		end
	end
	local all_count = VarApi.getPlayerUIntVar(actor,"U_wolong_open_count")
	VarApi.setPlayerUIntVar(actor,"U_wolong_open_count",all_count + tonumber(num))
	Sendmsg9(actor, "ffffff",  "开启成功，今日已开启："..(open_count + tonumber(num)).. "次", 1) 
	lualib:FlushNpcUi(actor,"WoLongTreasureObj","flushinfo|"..self.random_index.."|"..open_count + tonumber(num))
end

function WoLongTreasure:drawPrize()
	local totalWeight = 0

	for _, v in ipairs(type_map[self.random_index]) do
		totalWeight = totalWeight + v.weight
	end

    local randomValue = math.random() * totalWeight
    local accumulated = 0
    for _, v in ipairs(type_map[self.random_index]) do
        accumulated = accumulated + v.weight
        if randomValue <= accumulated then
            return v.key_name
        end
    end
    
    return WoLongTreasure.cfg[1].key_name  -- 默认返回最后一个
end

return WoLongTreasure