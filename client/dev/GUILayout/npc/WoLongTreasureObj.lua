local WoLongTreasureObj = {}
WoLongTreasureObj.Name = "WoLongTreasureObj"
WoLongTreasureObj.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
WoLongTreasureObj.cfg = SL:Require("GUILayout/config/wolongTreasureCfg",true)
WoLongTreasureObj.npcId = 334
WoLongTreasureObj.RunAction = true
WoLongTreasureObj.map_cfg = {}

for i,v in ipairs(WoLongTreasureObj.cfg) do
 	WoLongTreasureObj.map_cfg[v.group_type] = WoLongTreasureObj.map_cfg[v.group_type] or {}
 	table.insert(WoLongTreasureObj.map_cfg[v.group_type],v)  
end 

function WoLongTreasureObj:main(...)

	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/WoLongBaoZangUI")
	self.ui = GUI:ui_delegate(parent)
	
	if SL:GetMetaValue("WINPLAYMODE") then
		GUI:ListView_setItemsMargin(self.ui.ListView_1, 40)
	end

	--关闭按钮
	GUI:addOnClickEvent(self.ui.CloseBtn, function()
	  ViewMgr.close(WoLongTreasureObj.Name)
	end)

	GUI:addOnClickEvent(self.ui.TipBtn,function ()
		local str = "<卧龙宝藏概率公布    		/FCOLOR=251>"
		for i,v in ipairs(WoLongTreasureObj.map_cfg[self.random_index]) do
			str = str .. string.format("\\%sx%s：<%s%%/FCOLOR=254>",v.item_name,v.item_num,v.weight) 
		end
		local data = {width = 500, str = str,worldPos = {x = 400, y = 400}, anchorPoint = {x = 0, y = 0}}
		SL:OpenCommonDescTipsPop(data)
	end)
	--兑换
	GUI:addOnClickEvent(self.ui.ExchangeBtn,function ()
	    local data = {}
	    
	    local num1 = SL:GetMetaValue("MONEY_ASSOCIATED", 26)
	    local num2 = SL:GetMetaValue("ITEM_COUNT", "卧龙钥匙")
	    data.str = string.format("兑换卧龙钥匙需要：卧龙令x200#ffff00|当前卧龙令剩余：%s#00ff00|当前卧龙钥匙剩余：%s#00ff00",num1,num2) 
	    data.btnstr ={"兑换一把","兑换十把"}
	    data.list_gap = {y =20,t = 20}
	    data.callback = function (index)
    		SendMsgCallFunByNpc(WoLongTreasureObj.npcId, "WoLongTreasure","ExchangeKey",index == 1 and 1 or 10)
	    end
	   	ViewMgr.open("WoLongBzTipsOBJ",data)
	end)
	--购买
	GUI:addOnClickEvent(self.ui.BuyKeyBtn,function ()
		local data = {}
	    data.str = "兑换卧龙钥匙#ffff00|购买10把卧龙钥匙：灵符x998#00ff00|购买100把卧龙钥匙仅需：158元#00ff00"
	    data.btnstr ={"购买十把","购买百把"}
	    data.list_gap = {y =20,t = 20}
	    data.callback = function (index)
	   		SendMsgCallFunByNpc(WoLongTreasureObj.npcId, "WoLongTreasure","BuyKey",index == 1 and 10 or 100)
	    end
	   	ViewMgr.open("WoLongBzTipsOBJ",data)
	end)

	GUI:addOnClickEvent(self.ui.OpenTreasure,function ( )
		local data = {}
		local num1 = SL:GetMetaValue("ITEM_COUNT", "卧龙钥匙")
	    data.str = string.format("每次开启宝藏需要卧龙钥匙x1#ffff00|当前卧龙钥匙剩余：%s#00ff00",num1) 
	    data.btnstr ={"开启一次","开启十次"}
	    data.list_gap = {y =50,t = 20}
	    data.callback = function (index)
   			SendMsgCallFunByNpc(WoLongTreasureObj.npcId, "WoLongTreasure","OpenTreasure",index == 1 and 1 or 10)
	    end
	   	ViewMgr.open("WoLongBzTipsOBJ",data)
	end) 
	local tab = {...}
	local num1 = SL:GetMetaValue("ITEM_COUNT", "卧龙钥匙")
    local str = string.format("每次开启宝藏需要卧龙钥匙x1#ffff00|当前卧龙钥匙剩余：%s#00ff00",num1) 
	ViewMgr.flushView("WoLongBzTipsOBJ",str)
	self.random_index = tonumber(tab[2]) 
	self.open_count = tonumber(tab[3])
	WoLongTreasureObj:FlushInfo(self.random_index)
end

function WoLongTreasureObj:FlushInfo(random_index)
	local cfg = WoLongTreasureObj.map_cfg[random_index]
	for i,v in ipairs(cfg) do
		GUI:ItemShow_updateItem(self.ui["ItemShow_"..i],{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v.item_name),count = v.item_num,bgVisible = false,look = true}) 
	end
	local index = 1
	for i=20,25 do
		local total_cfg = WoLongTreasureObj.cfg[index]
		GUI:ItemShow_updateItem(self.ui["ItemShow_"..i],{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",total_cfg.last_item),count = total_cfg.last_item_num,bgVisible = true,look = true}) 
		index = index + 1
	end

	ItemShow_updateItem(self.ui.need_item,{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME","卧龙钥匙"),count = SL:GetMetaValue("ITEM_COUNT", "卧龙钥匙"),bgVisible = true,look = true,color = 255}) 
	GUI:Text_setString(self.ui.need_desc, string.format("剩余卧龙令：%s",SL:GetMetaValue("MONEY_ASSOCIATED", 26))) 
	GUI:Text_setString(self.ui.open_count,string.format("今日开启次数：%s次",self.open_count))
	GUI:Text_setString(self.ui.OpenDesc,string.format("今日开启宝藏次数满%s/99次获得全部奖励",self.open_count))
	self:flushRed(SL:GetMetaValue("ITEM_COUNT", "卧龙钥匙") > 0)
end

function WoLongTreasureObj:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.OpenTreasure)
        end
    end
end

function WoLongTreasureObj:flushView( ... )
	local param = {...}
	local tab = string.split(param[1],"|")
	if tab[1] == "flushtip" then
		local num1 = SL:GetMetaValue("MONEY_ASSOCIATED", 26)
	    local num2 = SL:GetMetaValue("ITEM_COUNT", "卧龙钥匙")
	    local str = string.format("兑换卧龙钥匙需要：卧龙令x200#ffff00|当前卧龙令剩余：%s#00ff00|当前卧龙钥匙剩余：%s#00ff00",num1,num2) 
		ViewMgr.flushView("WoLongBzTipsOBJ",str)
		WoLongTreasureObj:FlushInfo(self.random_index)
	elseif tab[1] == "flushinfo" then
		local num1 = SL:GetMetaValue("ITEM_COUNT", "卧龙钥匙")
	    str = string.format("每次开启宝藏需要卧龙钥匙x1#ffff00|当前卧龙钥匙剩余：%s#00ff00",num1) 
		ViewMgr.flushView("WoLongBzTipsOBJ",str)
		self.random_index = tonumber(tab[2]) 
		self.open_count = tonumber(tab[3])
		WoLongTreasureObj:FlushInfo(self.random_index)
	end
end
function WoLongTreasureObj:onClose( ... )
	if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end
-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == WoLongTreasureObj.npcId then
        -- ViewMgr.open(WoLongTreasureObj.Name)
        SendMsgCallFunByNpc(WoLongTreasureObj.npcId, "WoLongTreasure","upEvent")
    end
end

SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, WoLongTreasureObj.Name, onClickNpc)
return WoLongTreasureObj