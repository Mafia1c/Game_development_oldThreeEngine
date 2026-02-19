local GoldForestOBJ = {}
GoldForestOBJ.Name = "GoldForestOBJ"
GoldForestOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
GoldForestOBJ.cfg = SL:Require("GUILayout/config/goldForestCfg",true)
GoldForestOBJ.npcId = 271
GoldForestOBJ.RunAction = true
local type_map = {}
for i,v in ipairs(GoldForestOBJ.cfg) do
	type_map[v.name] = type_map[v.name] or {}
	table.insert(type_map[v.name],v)
end


function GoldForestOBJ:main(...)
	local tab = {...}
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/GoldForestUI")
	self.ui = GUI:ui_delegate(parent)

	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(GoldForestOBJ.Name)
	end)

	--点击进入
	GUI:addOnClickEvent(self.ui.EnterBtn, function()
	 	SendMsgCallFunByNpc(GoldForestOBJ.npcId, "GoldForest","EnterMap") 
	end)

	GUI:addOnClickEvent(self.ui.DescBtn,function ()
		GUI:setVisible(self.ui.TipPanel,true) 
	end)

	GUI:addOnClickEvent(self.ui.TipPanel,function ()
		GUI:setVisible(self.ui.TipPanel,false) 
	end)
	--跳过动画
	GUI:CheckBox_addOnEvent(self.ui.CheckBox,function ()
		SL:Print(GUI:CheckBox_isSelected(self.ui.CheckBox)) 
		local state = GUI:CheckBox_isSelected(self.ui.CheckBox) == true and 1 or 0
		SendMsgCallFunByNpc(GoldForestOBJ.npcId, "GoldForest","SetJumpAniState",state)
	end)

	--开启宝藏
	GUI:addOnClickEvent(self.ui.LotteryBtn,function ()
		SendMsgCallFunByNpc(GoldForestOBJ.npcId, "GoldForest","StartLottery")
	end)

	for k,v in pairs(GoldForestOBJ.cfg[1].reward_arr) do
		local item = GUI:ItemShow_Create(self.ui.dropBox,"dropitem"..k,(k -1) * 60+35,40,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v),count = 1,bgVisible = true,look = true})	
		GUI:setAnchorPoint(item,0.5,0.5)
	end

	local data = SL:JsonDecode(tab[2])
	self.random_award_list = data.random_list
	self.has_lottery_list = data.has_lottery_list
	self.is_jump_ani =  tonumber(data.is_jump_ani) > 0 
	self.cur_plan = tonumber(data.has_lottery_num)
	self.is_active_enter = tonumber(data.active_enter) > 0
	GoldForestOBJ:FlushAward()
end

function GoldForestOBJ:flushView( ... )
	local param = {...}
	local tab = string.split(param[1],"|")
	-- if tab[1] == "init_flush" then

	if tab[1] == "flush_jump_state" then
		self.is_jump_ani = tonumber(tab[2]) > 0 
		GoldForestOBJ:FlushJumpAni()
	elseif tab[1] == "flush_lottery" then
		self.has_lottery_list = SL:JsonDecode(tab[2])
		self.cur_plan = tonumber(tab[3])
		self.is_active_enter = tonumber(tab[4]) > 0
		GoldForestOBJ:FlushAward()
	elseif tab[1] == "reset_lottery" then
		self.random_award_list = SL:JsonDecode(tab[2])
		self.has_lottery_list = SL:JsonDecode(tab[3])
		self.cur_plan = tonumber(tab[4])
		GoldForestOBJ:FlushAward()
	end
end
function GoldForestOBJ:FlushAward()
	for i,v in ipairs(self.random_award_list) do
	 	local cfg = GoldForestOBJ.cfg[tonumber(v)]
	 	GUI:ItemShow_updateItem(self.ui["ItemShow_"..i],{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",cfg.item_name),count = cfg.item_count,bgVisible = false,look = true}) 
	 	GUI:ItemShow_setIconGrey(self.ui["ItemShow_"..i],GoldForestOBJ:GetIsGet(cfg.key_name))
	end 
	local index = 1
	for i=13,16 do
		local cfg = type_map["四格"][index]
	 	GUI:ItemShow_updateItem(self.ui["ItemShow_"..i],{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",cfg.item_name),count = cfg.item_count,bgVisible = false,look = true}) 
	 	GUI:ItemShow_setIconGrey(self.ui["ItemShow_"..i],GoldForestOBJ:GetIsGet(cfg.key_name))
	 	index = index + 1
	end
	GUI:ItemShow_updateItem(self.ui.ItemShow_22,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",type_map["中心"][1].item_name),count = type_map["中心"][1].item_count,bgVisible = false,look = true})	
	--进度奖励
	local plan_index = 1  
	for i=17,21 do
		local cfg = GoldForestOBJ.cfg[plan_index]
		local color = self.cur_plan < cfg.accumulative and 'E11010' or '00FF00'
		if self.ui["paln_richtext"..plan_index] then
	        GUI:removeFromParent(self.ui["paln_richtext"..plan_index])
	        self.ui = GUI:ui_delegate(self._parent)
	    end
	    local cur_plan = self.cur_plan < cfg.accumulative and self.cur_plan or  cfg.accumulative
		GUI:RichText_Create(self.ui.DownBox, "paln_richtext"..plan_index, 74 + (plan_index-1) * 75, 79,string.format("<font color='#%s'>%s/%s次</font>",color,cur_plan,cfg.accumulative), 100, 16, "#ffffff")
	 	GUI:ItemShow_updateItem(self.ui["ItemShow_"..i],{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",cfg.accumulative_item),count = cfg.accumulative_item_num,bgVisible = false,look = true}) 
	 	plan_index = plan_index + 1
	end
	GUI:LoadingBar_setPercent(self.ui.LoadingBar, (self.cur_plan/30) * 100)

	GUI:Text_setString(self.ui.stateText,self.is_active_enter and "已激活" or "未激活")
	GUI:Text_setTextColor(self.ui.stateText, self.is_active_enter and "#00FF00" or "#E11010") 
	self:FlushJumpAni()
	self:flushRed(SL:GetMetaValue("ITEM_COUNT", "黄金骰子") > 0)
end

function GoldForestOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.LotteryBtn)
        end
    end
end

function GoldForestOBJ:GetIsGet(key_name)
	for i,v in ipairs(self.has_lottery_list or {}) do
		if tonumber(v) == tonumber(key_name) then
			return true
		end 
	end
	return false
end

function GoldForestOBJ:FlushJumpAni()
   	GUI:CheckBox_setSelected(self.ui.CheckBox, self.is_jump_ani)
end

function GoldForestOBJ:onClose( ... )
	if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == GoldForestOBJ.npcId then
    	SendMsgCallFunByNpc(GoldForestOBJ.npcId, "GoldForest","upEvent")
        -- ViewMgr.open(GoldForestOBJ.Name)
    end
end

SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, GoldForestOBJ.Name, onClickNpc)

return GoldForestOBJ