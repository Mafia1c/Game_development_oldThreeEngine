local EquipTuJianObj = {}
EquipTuJianObj.Name = "EquipTuJianObj"
EquipTuJianObj.cfg = SL:Require("GUILayout/config/equipTuJianCfg",true)
EquipTuJianObj.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
EquipTuJianObj.npcId = 112
EquipTuJianObj.RunAction = true
function EquipTuJianObj:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.key_index = 0
	self.red_width_list=  {}
	--加载UI
	GUI:LoadExport(parent, "npc/EquipTuJianUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(EquipTuJianObj.Name)
	end)

	--一键收集
	GUI:addOnClickEvent(self.ui.shoujiBtn, function()
	  	SendMsgCallFunByNpc(EquipTuJianObj.npcId, "EquipTuJian","OnClickShouJi",self.key_index)
	end)

	--图鉴属性
	GUI:addOnClickEvent(self.ui.tujian_btn, function()
		GUI:setVisible(self.ui.tujianAttrDescBg,true) 
        local desc = "<图鉴属性介绍:/FCOLOR=251>\\\\<每收集一件头盔、项链，生命值： +10/FCOLOR=250>\\\\<每收集一件手镯、戒指，攻魔道：+1/FCOLOR=250>\\\\<每收集一件腰带、靴子、防御魔御：+1/FCOLOR=250>\\\\<每收集一整套装备，生命加成：+2%/FCOLOR=250>"
        self.suit_text_obj = GUI:RichTextFCOLOR_Create(self.ui.tujianAttrDescBg, "suit_text", 18, 40, desc , 331, 18, "#fffff")
	end)

	
	GUI:addOnClickEvent(self.ui.tujianBtnBox, function()
	  	GUI:setVisible(self.ui.tujianAttrDescBg,false) 
	  	if self.suit_text_obj ~= nil  then
			GUI:removeFromParent(self.suit_text_obj)
			self.suit_text_obj = nil
		end 
	end)
	local tab = {...}
	if tab[1] == "initFlush" then
		self.active_state_list = SL:JsonDecode(tab[3])
		self.suit_active_state_list = SL:JsonDecode(tab[4])
		EquipTuJianObj:InitOneTypeList()
		EquipTuJianObj:oneTypeBtnEvent(tonumber(tab[2]))
	end
	-- SendMsgCallFunByNpc(EquipTuJianObj.npcId, "EquipTuJian","upEvent",1)
end

function EquipTuJianObj:flushView( ... )
	local param = {...}
	local tab = string.split(param[1],"|")
	self.active_state_list = SL:JsonDecode(tab[3])
	self.suit_active_state_list = SL:JsonDecode(tab[4])
	-- if tab[1] == "initFlush" then
	-- 	EquipTuJianObj:InitOneTypeList()
	-- 	EquipTuJianObj:oneTypeBtnEvent(tonumber(tab[2]))
	if tab[1] == "flushState" then
		local cfg = EquipTuJianObj.cfg[tonumber(tab[2])]
		EquipTuJianObj:twoTypeBtnEvent(cfg.two_group,self.equip_map[cfg.one_group])
	end
end

function EquipTuJianObj:InitOneTypeList()
	self.equip_map = {}
	for i,v in ipairs(EquipTuJianObj.cfg) do
		if self.equip_map[v.one_group] == nil then
			self.equip_map[v.one_group] = {}
		end
		table.insert(self.equip_map[v.one_group],v) 
	end
	local index = 0
	for k,v in pairs(self.equip_map) do
		local btn = GUI:Button_Create(self.ui.equipTypelist,"one_type_btn"..k,4,400 - index * 43 ,"res/custom/dayeqian2.png")
		GUI:Button_setTitleText(btn, v[1].one_group_name .."系列")
		GUI:Button_setTitleFontSize(btn, 16)
		GUI:Button_setTitleColor(btn, "#F8E6C6")
		GUI:addOnClickEvent(btn,function ()
			EquipTuJianObj:oneTypeBtnEvent(k)
		end)
		index = index + 1
	end
end

function EquipTuJianObj:oneTypeBtnEvent(key)
	if self.ui.ont_btn_tag then
        GUI:removeFromParent(self.ui.ont_btn_tag)
        self.ui = GUI:ui_delegate(self._parent)
    end
	GUI:Image_Create(self.ui["one_type_btn"..key],"ont_btn_tag",-7,10,"res/custom/npc/18tj/0.png")
    -- GUI:setAnchorPoint(self.ui.leftTag1,0.5,0.5)
    GUI:removeAllChildren(self.ui.equipChildTypelist)


	for i,v in ipairs(self.equip_map[key]) do
    	local btn = GUI:Button_Create(self.ui.equipChildTypelist,"two_type_btn"..i,0, 392 - ((i-1)*42),"res/custom/dayeqian2.png")
    	GUI:Win_SetParam(btn,i)
		GUI:Button_setTitleText(btn, v.two_group_name)
		GUI:Button_setTitleFontSize(btn, 16)
		GUI:Button_setTitleColor(btn, "#F8E6C6")
		-- self.ui = GUI:ui_delegate(self._parent)
		GUI:Image_Create(btn,"two_btn_tag"..i,0,10,"res/custom/npc/18tj/0.png")
		GUI:addOnClickEvent(btn,function ()
			EquipTuJianObj:twoTypeBtnEvent(i,self.equip_map[key],v)
		end)
	end	
	EquipTuJianObj:twoTypeBtnEvent(1,self.equip_map[key])
	self.ui = GUI:ui_delegate(self._parent)
end

function EquipTuJianObj:twoTypeBtnEvent(index,two_cfg_list)
	self.key_index = two_cfg_list[index].key_name
	for i=1,#two_cfg_list do
		if index == i then
			GUI:Image_loadTexture(self.ui["two_btn_tag"..i],"res/custom/npc/18tj/1.png")
			if self.ui.three_tag then
		        GUI:removeFromParent(self.ui.three_tag)
		        self.ui = GUI:ui_delegate(self._parent)
		    end
			local three_tag =  GUI:Image_Create(self.ui.equipChildTypelist,"three_tag",0,0,"res/custom/sonBox.png")
			GUI:Image_Create(three_tag,"three_tag_bg",-10,4,"res/public/1900000678.png")
			GUI:Text_Create(three_tag,"three_text",20,10,16,"#00ff00","普通图鉴")
			GUI:Win_SetParam(three_tag,GUI:Win_GetParam(self.ui["two_type_btn"..index])+0.1) 
			if self:GetTherrRedShow(two_cfg_list[index]) then
				SL:CreateRedPoint(three_tag,{x = 10,y=10})
			end
		else
			GUI:Image_loadTexture(self.ui["two_btn_tag"..i],"res/custom/npc/18tj/0.png")
		end
	end

	GUI:UserUILayout(self.ui.equipChildTypelist, {
        dir=1,
        addDir=1,
        colnum= 4,
        sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return GUI:Win_GetParam(a) < GUI:Win_GetParam(b)
            end)
        end
    })

	EquipTuJianObj:flushRightInfo(two_cfg_list[index])
	self:FlushOneTagRed()
	
end

function EquipTuJianObj:flushRightInfo(cfg)
	for i=1,6 do
		GUI:ItemShow_updateItem(self.ui["ItemShow_"..i],{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg["pos"..i]),count = 1,bgVisible = false,look = true})
		GUI:Text_setString(self.ui["item_name"..i],cfg["pos"..i])
		GUI:setVisible(self.ui["lock"..i],not EquipTuJianObj:isActive(cfg.key_name,i)) 
	end
	for i=1,2 do
		GUI:ItemShow_updateItem(self.ui["award_item"..i],{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg["award_money"..i]),count = cfg["award_money_num"..i],bgVisible = true,look = true})
	end
	local hp,attack,defense,hp_up =  EquipTuJianObj:getHasActiveAttr()
	local str = string.format("生命值：%s，攻魔道：%s，防魔御：%s，生命加成：%s%%",hp,attack,defense,hp_up) 
	GUI:Text_setString(self.ui.attr_text,str) 
	GUI:setVisible(self.ui.shoujiBtn,not EquipTuJianObj:suitIsActive(cfg.key_name))	
	GUI:setVisible(self.ui.yiWanCheng,EquipTuJianObj:suitIsActive(cfg.key_name))	
end

function EquipTuJianObj:isActive(key_name,pos_index)
	if self.active_state_list  == nil then return false end
	for k,v in pairs(self.active_state_list) do
		if v.key_name == key_name and v.pos_index == pos_index then
			return v.is_active
		end
	end
	return false
end

function EquipTuJianObj:getHasActiveAttr()
	if self.active_state_list  == nil then return 0,0,0,0 end
	local hp,attack,defense,hp_up = 0,0,0,0
	for k,v in pairs(self.active_state_list) do
		if v.is_active then
			if v.pos_index <= 2 and v.is_active then
				hp = 10 + hp
			elseif v.pos_index > 2 and v.pos_index <= 4 then
				attack = attack + 1
			elseif v.pos_index > 4 and v.pos_index <= 6 then
				defense = defense + 1
			end
		end
	end
	for k,v in pairs(EquipTuJianObj.cfg) do
		if  EquipTuJianObj:suitIsActive(v.key_name) then
			hp_up = hp_up + 2
		end
	end
	return hp,attack,defense,hp_up
end

function EquipTuJianObj:suitIsActive(key_name)
	for k,v in pairs(self.suit_active_state_list) do
	 	if tonumber(v) == tonumber(key_name) then
	 		return true
	 	end 
	end 
	return false
end

function EquipTuJianObj:FlushOneTagRed()
	local checkred = function (cfg)
		for i,item in ipairs(cfg) do
			if self:GetTherrRedShow(item) then
				return true
			end
		end
		return false
	end
	for k,v in pairs(self.equip_map) do
		if checkred(v) then
			if GUI:Win_IsNull(self.red_width_list["one_type_btn"..k]) and self.ui["one_type_btn"..k] then
                self.red_width_list["one_type_btn"..k] = SL:CreateRedPoint(self.ui["one_type_btn"..k] ,{x=102,y=10})
           	end
		else
        	if not GUI:Win_IsNull(self.red_width_list["one_type_btn"..k])  then
                GUI:removeFromParent(self.red_width_list["one_type_btn"..k] )
                self.red_width_list["one_type_btn"..k]  = nil
            end
        end
	end
end

function EquipTuJianObj:GetTherrRedShow(cfg)
	for i=1,6 do
		if SL:GetMetaValue("ITEM_COUNT", cfg["pos"..i]) > 0 and not self:isActive(cfg.key_name,i) then
			return true
		end
	end
	return false
end

--#region 关闭前回调
function EquipTuJianObj:onClose(...)
    for k,v in pairs(self.red_width_list) do
        if v then
            GUI:removeFromParent(v)
        end
    end
    self.red_width_list = {}
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == EquipTuJianObj.npcId then
        -- ViewMgr.open(EquipTuJianObj.Name)
        SendMsgCallFunByNpc(EquipTuJianObj.npcId, "EquipTuJian","upEvent",1)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, EquipTuJianObj.Name, onClickNpc)

return EquipTuJianObj
