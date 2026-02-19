local LingZhuangStrengthenOBJ = {}
LingZhuangStrengthenOBJ.Name = "LingZhuangStrengthenOBJ"
LingZhuangStrengthenOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
LingZhuangStrengthenOBJ.npcId = 251
LingZhuangStrengthenOBJ.cfg = SL:Require("GUILayout/config/LingZhuangStrengthenCfg",true)
LingZhuangStrengthenOBJ.suit_cfg = SL:Require("GUILayout/config/LingZhuangSuitCfg",true)
LingZhuangStrengthenOBJ.map = {}
LingZhuangStrengthenOBJ.RunAction = true
LingZhuangStrengthenOBJ.map_cfg = {}
local default_cfg = {}

for i,v in ipairs(LingZhuangStrengthenOBJ.cfg) do
	LingZhuangStrengthenOBJ.map_cfg[v.part_name] =  LingZhuangStrengthenOBJ.map_cfg[v.part_name] or {}
	table.insert(LingZhuangStrengthenOBJ.map_cfg[v.part_name],v)
	if default_cfg[v.part_index]  == nil and v.strengthen_level then
 		default_cfg[v.part_index] =  v
	end
end
function LingZhuangStrengthenOBJ:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.select_equip_cell = nil
	self.suit_text_obj = nil
	self.is_check_box = false
	self.select_part_index = nil
	--加载UI
	GUI:LoadExport(parent, "npc/LingZhuangStrengthenUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(LingZhuangStrengthenOBJ.Name)
	end)

    GUI:CheckBox_addOnEvent(self.ui["CheckBox"], function ()
        self:onClickCheckBox()
    end)

    GUI:addOnClickEvent(self.ui["suitAttrBtn_1"], function ()
        GUI:setVisible(self.ui.suit_box,true) 
        local desc = ""
        for i,v in ipairs(LingZhuangStrengthenOBJ.suit_cfg) do
        	desc = desc .. "\\"..v.desc
        end
        self.suit_text_obj = GUI:RichTextFCOLOR_Create(self.ui.suit_box_bg, "suit_text", 660, 265, desc , 640, 16, "#fffff")
        GUI:setAnchorPoint(self.suit_text_obj, 1,1) 
    end)

    GUI:addOnClickEvent(self.ui["suit_box"], function ()
        GUI:setVisible(self.ui.suit_box,false) 
        if self.suit_text_obj ~= nil  then
			GUI:removeFromParent(self.suit_text_obj)
			self.suit_text_obj = nil
		end 
    end)
    GUI:addOnClickEvent(self.ui.QuickBuyBtn,function ()
    	ViewMgr.open("LingZhuangBuyTip") 

    end)
   
    --强化按钮
	GUI:addOnClickEvent(self.ui.strengthenBtn, function()
		SendMsgCallFunByNpc(LingZhuangStrengthenOBJ.npcId, "LingZhuangStrengthen","StrengthenOnClick",self.select_part_index)
	end)
    
	local tab = {...}
	if tab[1] == "inin_check_box" then
		self.is_check_box = tonumber(tab[2]) > 0 and true or false
		GUI:CheckBox_setSelected(self.ui.CheckBox,self.is_check_box)
		LingZhuangStrengthenOBJ:flushEquipItem()
		LingZhuangStrengthenOBJ:selectFlush(20)
	end
end

function LingZhuangStrengthenOBJ:flushEquipItem()
	local equpos_map = {20,22,23,27,26,24,25,28}
	local equip_data = SL:GetMetaValue("EQUIP_DATA", 21)
	for i,v in ipairs(equpos_map) do
		GUI:addOnClickEvent(self.ui["equipPosBg"..v],function ()
			LingZhuangStrengthenOBJ:selectFlush(v)
		end)
		local euip_cell = GUI:EquipShow_Create(self.ui["equipPos"..v],"equip_cell"..v,-32,-30,v,false,{bgVisible = false, look = false, doubleTakeOff = false})
		GUI:EquipShow_setAutoUpdate(euip_cell)
	end

end

function LingZhuangStrengthenOBJ:flushView( ... )
	local param = {...}
	local tab = string.split(param[1],"|")
	
	if tab[1] == "flush_check_box" then
		self.is_check_box = tonumber(tab[2]) > 0 and true or false
		GUI:CheckBox_setSelected(self.ui.CheckBox,self.is_check_box)
		LingZhuangStrengthenOBJ:selectFlush(self.select_part_index or 1)
	elseif tab[1] == "flushqianghua" then
		LingZhuangStrengthenOBJ:selectFlush(self.select_part_index or 1)
	end
end

--
function LingZhuangStrengthenOBJ:GetEquipCfgByPartIndex(part_index)
	local name = SL:GetMetaValue("EQUIPBYPOS", part_index)
	local equip_data = SL:GetMetaValue("EQUIP_DATA", part_index)
	local equip_star = 0
	if equip_data then
		equip_star = equip_data.Star or 0
	end
	local temp_name = ""
	if name ~= "" then
		temp_name = name:gsub("%(.-%)", "")
	end
	local cfg = name == "" and default_cfg[part_index] or LingZhuangStrengthenOBJ.map_cfg[temp_name][equip_star + 1]
	return cfg
end

function LingZhuangStrengthenOBJ:selectFlush(part_index)
	local name = SL:GetMetaValue("EQUIPBYPOS", part_index)
	self.select_part_index = part_index
	local pos = GUI:getPosition(self.ui["equipPos"..part_index])
	GUI:setPosition(self.ui.select_img,pos.x,pos.y) 
	if self.select_equip_cell ~= nil  then
		GUI:removeFromParent(self.select_equip_cell)
		self.select_equip_cell = nil
	end 
	self.select_equip_cell = GUI:EquipShow_Create(self.ui.LayoutBg, "select_equip_cell", 583, 390, part_index, false, {bgVisible = false, look = true, doubleTakeOff = false})
	local equip_data = SL:GetMetaValue("EQUIP_DATA", part_index)
	local equip_star = 0
	if equip_data then
		equip_star = equip_data.Star or 0
	end
	GUI:Text_setString(self.ui.equipNameText,name) 
	GUI:setVisible(self.ui.equipNameText,name ~= "") 

	local cfg = LingZhuangStrengthenOBJ:GetEquipCfgByPartIndex(part_index)

	local cur_attr_name,cur_attr_vllue = LingZhuangStrengthenOBJ:GetCfgAttr(cfg.cur_subjoin_attr_arr)
	local value_list = string.split(cfg.att_value,"|")
	GUI:Text_setString(self.ui["cur_attr_1"],cfg.attr_name .. "：" .. value_list[1]) 
	GUI:Text_setString(self.ui["cur_attr_2"],cur_attr_name ..  cur_attr_vllue) 

	-- --下级属性
	GUI:Text_setString(self.ui["next_attr_1"],cfg.attr_name .. "：" .. value_list[2]) 
	local next_attr_name,next_attr_vllue = LingZhuangStrengthenOBJ:GetCfgAttr(cfg.next_subjoin_attr_arr)
	GUI:Text_setString(self.ui["next_attr_2"],next_attr_name .. next_attr_vllue) 
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
 	local item_color = SL:GetMetaValue("ITEM_COUNT", cfg.need_item) >= cfg.need_item_num and 250 or 249
 	local money_color = tonumber(SL:GetMetaValue("MONEY",SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.need_money_name))) >= cfg.need_money_num and 250 or 249
 	GUI:ItemShow_Create(self.ui.needBox,"need_item1",20,2,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.need_item),count = cfg.need_item_num,bgVisible = true,look = true,color = item_color})
 	GUI:ItemShow_Create(self.ui.needBox,"need_item2",99,2,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.need_money_name),count = cfg.need_money_num,bgVisible = true,look = true,color = money_color})
 	local equipos_map = {20,22,23,27,26,24,25,28}
	local all_star = 0
 	for k,v in pairs(equipos_map) do
 		local equip_data = SL:GetMetaValue("EQUIP_DATA", v)
		if equip_data then
			all_star = (equip_data.Star or 0) + all_star
		end
 	end
 	GUI:Text_setString(self.ui.strengthenLevelText,all_star .. "级") 
 	LingZhuangStrengthenOBJ:flushCheckBox(part_index)
end

function LingZhuangStrengthenOBJ:GetCfgAttr(attr_str)
	-- --当前属性
	local attList  = GUIFunction:ParseItemBaseAtt(attr_str)
	local stringAtt = GUIFunction:GetAttDataShow(attList, true, true)
	local name = ""
	local value = ""
	for k,v in pairs(stringAtt) do
		name = v.name
		if v.id == 13 or v.id == 14 then
			name ="准确敏捷："			
		end
		value = v.value
	end 
	return name,value
end

function LingZhuangStrengthenOBJ:flushCheckBox(part_index)
	local cfg = LingZhuangStrengthenOBJ:GetEquipCfgByPartIndex(part_index)
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

function LingZhuangStrengthenOBJ:onClickCheckBox()
	local count = SL:GetMetaValue("ITEM_COUNT", "幸运符")
	if count <= 0 then
		SL:ShowSystemTips("幸运符不足，可在商城购买!")
		SL:OpenStoreUI(3)
		GUI:CheckBox_setSelected(self.ui.CheckBox,false)
		SendMsgCallFunByNpc(LingZhuangStrengthenOBJ.npcId, "LingZhuangStrengthen","ClickCheckBox",0)
		return
	end
	local is_select = GUI:CheckBox_isSelected(self.ui.CheckBox)
	SendMsgCallFunByNpc(LingZhuangStrengthenOBJ.npcId, "LingZhuangStrengthen","ClickCheckBox",is_select and 1 or 0)
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == LingZhuangStrengthenOBJ.npcId then
        -- ViewMgr.open(LingZhuangStrengthenOBJ.Name)
        SendMsgCallFunByNpc(LingZhuangStrengthenOBJ.npcId, "LingZhuangStrengthen","upEvent")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, LingZhuangStrengthenOBJ.Name, onClickNpc)

return LingZhuangStrengthenOBJ
