local StrengthenObj = {}
StrengthenObj.Name = "StrengthenObj"
StrengthenObj.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
StrengthenObj.npcId = 248
StrengthenObj.cfg = SL:Require("GUILayout/config/strengthenMasterCfg",true)
StrengthenObj.suit_cfg = SL:Require("GUILayout/config/suitAttrCfg",true)
StrengthenObj.map = {}
StrengthenObj.RunAction = true
function StrengthenObj:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.select_equip_cell = nil
	self.suit_text_obj = nil
	self.is_check_box = false
	self.select_part_index = nil
	--加载UI
	GUI:LoadExport(parent, "npc/strengthenUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(StrengthenObj.Name)
	end)

    GUI:CheckBox_addOnEvent(self.ui["CheckBox"], function ()
        self:onClickCheckBox()
    end)

    GUI:addOnClickEvent(self.ui["suitAttrBtn_1"], function ()
        GUI:setVisible(self.ui.suit_box,true) 
        local desc = ""
        for i,v in ipairs(StrengthenObj.suit_cfg) do
        	desc = desc .. "\\"..v.desc
        end
        self.suit_text_obj = GUI:RichTextFCOLOR_Create(self.ui.suit_box_bg, "suit_text", 620, 370, desc , 640, 16, "#fffff")
        GUI:setAnchorPoint(self.suit_text_obj, 1,1) 
    end)

    GUI:addOnClickEvent(self.ui["suit_box"], function ()
        GUI:setVisible(self.ui.suit_box,false) 
        if self.suit_text_obj ~= nil  then
			GUI:removeFromParent(self.suit_text_obj)
			self.suit_text_obj = nil
		end 
    end)
    
   	GUI:addOnClickEvent(self.ui.quick_btn,function ()
    	ViewMgr.open("LingZhuangBuyTip") 
    end)

    --强化按钮
	GUI:addOnClickEvent(self.ui.strengthenBtn, function()
		SendMsgCallFunByNpc(StrengthenObj.npcId, "Strengthen","strengthenOnClick",self.select_part_index)
	end)
    
	SendMsgCallFunByNpc(StrengthenObj.npcId, "Strengthen","upEvent")
end

function StrengthenObj:flushEquipItem()
	local equpos_map = {1,4,6,8,10,0,3,5,7,11}
	for i,v in ipairs(equpos_map) do
		local equip_data = SL:GetMetaValue("EQUIP_DATA", v)
		GUI:addOnClickEvent(self.ui["equipPosBg"..v],function ()
			StrengthenObj:selectFlush(v)
			if equip_data == nil then
				SL:ShowSystemTips("该部位未穿戴装备，无法强化!")
			end
		end)
		local euip_cell = GUI:EquipShow_Create(self.ui["equipPos"..v],"equip_cell"..v,-32,-30,v,false,{bgVisible = false, look = false, doubleTakeOff = false})
		GUI:EquipShow_setAutoUpdate(euip_cell)
	end

end

function StrengthenObj:flushView( ... )
	local param = {...}
	local tab = string.split(param[1],"|")
	if tab[1] == "inin_check_box" then
		self.is_check_box = tonumber(tab[2]) > 0 and true or false
		GUI:CheckBox_setSelected(self.ui.CheckBox,self.is_check_box)
		StrengthenObj:flushEquipItem()
		StrengthenObj:selectFlush(1)
	elseif tab[1] == "flush_check_box" then
		self.is_check_box = tonumber(tab[2]) > 0 and true or false
		GUI:CheckBox_setSelected(self.ui.CheckBox,self.is_check_box)
		StrengthenObj:selectFlush(self.select_part_index or 1)
	elseif tab[1] == "flushqianghua" then
		StrengthenObj:selectFlush(self.select_part_index or 1)
	end
end

function StrengthenObj:selectFlush(part_index)

	self.select_part_index = part_index
	local pos = GUI:getPosition(self.ui["equipPos"..part_index])
	GUI:setPosition(self.ui.select_img,pos.x,pos.y) 
	if self.select_equip_cell ~= nil  then
		GUI:removeFromParent(self.select_equip_cell)
		self.select_equip_cell = nil
	end 
	self.select_equip_cell = GUI:EquipShow_Create(self.ui.LayoutBg, "select_equip_cell", 585, 390, part_index, false, {bgVisible = false, look = true, doubleTakeOff = false})
	local equip_data = SL:GetMetaValue("EQUIP_DATA", part_index)
	local equip_star = 0
	if equip_data then
		equip_star = equip_data.Star or 0
		GUI:Text_setString(self.ui.equipNameText,equip_data.Name) 
	end
	local is_max = self:isMaxLevel(part_index,equip_star)
	GUI:setVisible(self.ui.strengthenBtn,not is_max) 
	GUI:setVisible(self.ui.yimanji,is_max) 

	if is_max then
		equip_star = equip_star 
	end
	GUI:setVisible(self.ui.equipNameText,equip_data ~= nil) 
	local cfg = StrengthenObj.cfg[part_index][equip_star]

	local job = SL:GetMetaValue("JOB")

	-- --当前属性
	local attr_tab = cfg.cur_job_attr_map[job]
	local cur_attr_cfg1 = SL:GetMetaValue("ATTR_CONFIG", tonumber(attr_tab[1]))
	GUI:Text_setString(self.ui["cur_attr_1"],cur_attr_cfg1.name .. ":" .. tonumber(attr_tab[2])) 

	local cur_attr_cfg2 = SL:GetMetaValue("ATTR_CONFIG", tonumber(cfg.cur_subjoin_attr_arr[1]))
	GUI:Text_setString(self.ui["cur_attr_2"],cur_attr_cfg2.name .. ":" .. tonumber(cfg.cur_subjoin_attr_arr[2]/100).."%") 

	--下级属性
	local next_attr_tab = cfg.next_job_attr_map[job]
	local next_attr_cfg1 = SL:GetMetaValue("ATTR_CONFIG", tonumber(next_attr_tab[1]))
	GUI:Text_setString(self.ui["next_attr_1"],next_attr_cfg1.name .. ":" .. tonumber(next_attr_tab[2])) 

	local next_attr_cfg2 = SL:GetMetaValue("ATTR_CONFIG", tonumber(cfg.next_subjoin_attr_arr[1]))
	GUI:Text_setString(self.ui["next_attr_2"],next_attr_cfg2.name .. ":" .. tonumber(cfg.next_subjoin_attr_arr[2]/100).."%") 
	if self.is_check_box then
		if cfg.odds + 10 > 100 then
			GUI:Text_setString(self.ui["oddsText"],100 .."%") 
		else
			GUI:Text_setString(self.ui["oddsText"],cfg.odds + 10 .."%") 
		end
	else
		GUI:Text_setString(self.ui["oddsText"],cfg.odds.."%") 
	end

 	GUI:removeAllChildren(self.ui.needBox)
 	local need_item = GUI:ItemShow_Create(self.ui.needBox,"need_item1",20,2,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.need_item),count = cfg.need_item_num,
 		bgVisible = true,look = true,color = SL:GetMetaValue("ITEM_COUNT", cfg.need_item) >= cfg.need_item_num and  250 or 249})
 	
 	local money_color = tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.need_money_name))) >= cfg.need_money_num and 250 or 249
 	local money_item = GUI:ItemShow_Create(self.ui.needBox,"need_item2",99,2,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.need_money_name),count = cfg.need_money_num,bgVisible = true,look = true,color = money_color})
 	ItemShow_updateItem(need_item,{showCount = true,count = cfg.need_item_num,bgVisible = true,look = true,color = SL:GetMetaValue("ITEM_COUNT", cfg.need_item) >= cfg.need_item_num and  250 or 249})
 	ItemShow_updateItem(money_item,{showCount = true,count = cfg.need_money_num,bgVisible = true,look = true,color = money_color})
 	local equpos_map = {1,4,6,8,10,0,3,5,7,11}
	local all_star = 0
 	for k,v in pairs(equpos_map) do
 		local equip_data = SL:GetMetaValue("EQUIP_DATA", v)
		if equip_data then
			all_star = (equip_data.Star or 0) + all_star
		end
 	end
 	GUI:Text_setString(self.ui.strengthenLevelText,all_star .. "级") 
 	StrengthenObj:flushCheckBox(part_index)
end

function StrengthenObj:flushCheckBox(part_index)
	local equip_data = SL:GetMetaValue("EQUIP_DATA", part_index)
	local equip_star = 0
	if equip_data then
		equip_star = equip_data.Star or 0
	end
	if self:isMaxLevel(part_index,equip_star) then
		equip_star = equip_star 
	end
	local cfg = StrengthenObj.cfg[part_index][equip_star]
	if self.is_check_box then
		if cfg.odds + 10 > 100 then
			GUI:Text_setString(self.ui["oddsText"],100 .."%") 
		else
			GUI:Text_setString(self.ui["oddsText"],cfg.odds + 10 .."%") 
		end
	else
		GUI:Text_setString(self.ui["oddsText"],cfg.odds.."%") 
	end
end

function StrengthenObj:onClickCheckBox()
	local count = SL:GetMetaValue("ITEM_COUNT", "幸运符")
	if count <= 0 then
		SL:ShowSystemTips("幸运符不足，可在商城购买!")
		SL:OpenStoreUI(3)
		GUI:CheckBox_setSelected(self.ui.CheckBox,false)
		SendMsgCallFunByNpc(StrengthenObj.npcId, "Strengthen","ClickCheckBox",0)
		return
	end
	local is_select = GUI:CheckBox_isSelected(self.ui.CheckBox)
	SendMsgCallFunByNpc(StrengthenObj.npcId, "Strengthen","ClickCheckBox",is_select and 1 or 0)

end

function StrengthenObj:isMaxLevel(part_index,cur_level)
	local max_level = 0
	for k,v in pairs(StrengthenObj.cfg[part_index]) do
		max_level = max_level + 1
	end
	return cur_level >= max_level - 1
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == StrengthenObj.npcId then
        ViewMgr.open(StrengthenObj.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, StrengthenObj.Name, onClickNpc)

return StrengthenObj
