local TreasureObj = {}
TreasureObj.Name = "TreasureObj"
TreasureObj.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
TreasureObj.cfg = SL:Require("GUILayout/config/zsmbcfg",true)
TreasureObj.npcId = 103

function TreasureObj:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false,true)
	self._parent = parent
	self.old_idx = nil
	self.select_material_cell_index = 0
	self.material_key_name = 0
	--加载UI
	GUI:LoadExport(parent, "npc/TreasureUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(TreasureObj.Name)
	end)
	for i=1,4 do
		GUI:addOnClickEvent(self.ui["Button_"..i], function()
			-- TreasureObj:flushShowContent(i)
			SendMsgCallFunByNpc(0, "treasure","tabOnClick",i)
		end)
	end
	GUI:addOnClickEvent(self.ui.jueXingbutton,function ()
		SendMsgCallFunByNpc(0, "treasure", "jueXingClick",self.material_key_name)
	end) 
	local tab = {...}
	if tab[1] == "init_flush" then
		self.active_list = SL:JsonDecode(tab[3])
		TreasureObj:flushShowContent(tonumber(tab[2]))
	end
	self:FlushTagRed()
end

function TreasureObj:flushView(...)
	local tab = {...}
	if tab[1] == "init_flush" then
		self.active_list = SL:JsonDecode(tab[3])
		TreasureObj:flushShowContent(tonumber(tab[2]))
	elseif tab[1] == "shoulu_flush" then
		self.active_list = SL:JsonDecode(tab[4])
		TreasureObj:flushSigleItemCell(tonumber(tab[3]))
		TreasureObj:flushDownInfo(tonumber(tab[2]))
	elseif tab[1] == "all_shoulu_flush" then
		self.active_list = SL:JsonDecode(tab[2])
		TreasureObj:flushShowContent(1)
	elseif tab[1] == "juexing_flush" then
		TreasureObj:flushShowContent(4)
	end
	self:FlushTagRed()
end

function TreasureObj:FlushTagRed()
	if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
   	for i,v in ipairs(TreasureObj.cfg) do
   		if self:IsShowItemCellRed(v.name,v.key_name) then
   			if self.red_width == nil then
            	self.red_width = SL:CreateRedPoint(self.ui["Button_1"],{x = 105,y = 8})
            	return 
        	end
   		end
   	end
end

function TreasureObj:getIsActive(key_name)
	if self.active_list == nil then return false end
	for i,v in ipairs(self.active_list) do
		if v == key_name then
			return true
		end
	end
	return false
end

function TreasureObj:flushShowContent(tab_index)
	for i = 1, 4 do
        GUI:setVisible(self.ui["Image_"..i], tab_index == i)
    end
	local item_list = {}
	if tab_index == 1 then  --秘宝图鉴
		item_list = {}
		for k,v in pairs(TreasureObj.cfg) do
			table.insert(item_list,v)
		end
		
	elseif tab_index == 2 then  --秘宝回收
		for k,v in pairs(TreasureObj.cfg) do
			table.insert(item_list,v)
		end
	elseif tab_index == 3 then --秘宝兑换
		for k,v in pairs(TreasureObj.cfg) do
			if v.need_name1 ~= 0 then
				table.insert(item_list,v)
			end
		end
	else --秘宝觉醒
		TreasureObj:heChengGrid()
	    TreasureObj:flushHeChengInfo()
	end
	if tab_index <= 3 then
		TreasureObj:SetItemList(tab_index,item_list)
		TreasureObj:flushDownInfo(tab_index)
	end
	GUI:setVisible(self.ui.tuJianBox,tab_index < 4)
	GUI:setVisible(self.ui.heChengBox,tab_index == 4)
end

--创建道具格子
function TreasureObj:SetItemList(btn_index,list)
	GUI:ScrollView_removeAllChildren(self.ui.item_list)
	for i,v in ipairs(list) do
		local cell_obj = TreasureObj:GetItemShowCell(btn_index,i,v)
		GUI:Win_SetParam(cell_obj, v.key_name)
	end
    GUI:UserUILayout(self.ui.item_list, {
        dir=3,
        addDir=1,
        colnum= 4,
        gap = {x=20,y = 10},
        sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return GUI:Win_GetParam(a) < GUI:Win_GetParam(b)
            end)
        end
    })
end

function TreasureObj:IsShowItemCellRed(name,key_name)
	if SL:GetMetaValue("ITEM_COUNT", name) > 0 and TreasureObj:getIsActive(key_name) == false then
		return true
	end
	return false
end

--物品格子
function TreasureObj:GetItemShowCell(btn_index,i,cfg)
  	local cellObj = GUI:Image_Create(self.ui.item_list, "cell_img"..cfg.key_name, 100, 0, "res/custom/npc/07zsmb/rq.png")
  	local item = GUI:ItemShow_Create(cellObj, "cell_item"..i,65, 92,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.name),bgVisible = false,look = true})
  	GUI:setAnchorPoint(item,0.5,0.5)
  	local text = GUI:Text_Create(cellObj, "name_text"..i, 18, 0, 16, "#ffffff",cfg.name)
  	SL:SetColorStyle(text, cfg.color)
  	GUI:Text_setTextAreaSize(text,100, 150)
  	GUI:Text_setTextHorizontalAlignment(text, 1)
  	if TreasureObj:getIsActive(cfg.key_name) and btn_index == 1 then
  		GUI:Image_Create(cellObj,"actve_img",18,15,"res/custom/tag/ylq_102.png")
  	else
	  	local button = GUI:Button_Create(cellObj,"btn",18,15,"res/custom/npc/07zsmb/bt2.png")
	  	GUI:Button_setTitleFontSize(button, 18)
	  	GUI:Button_setTitleColor(button, "#ff9b00")
	  	GUI:addOnClickEvent(button,function ()
		 	SendMsgCallFunByNpc(0, "treasure", "cellBtnClick",btn_index.."|"..cfg.key_name)
		end)
	  	if btn_index == 1 then
			GUI:Button_setTitleText(button, "收录")
			if self:IsShowItemCellRed(cfg.name,cfg.key_name) then
				SL:CreateRedPoint(button,{x = 5,y=5})
			end
			
	  	elseif btn_index == 2 then
			GUI:Button_setTitleText(button, "回收")
	  	elseif btn_index == 3 then
			GUI:Button_setTitleText(button, "兑换")
	  	end
  	end
    return cellObj
end
--刷新单个格子激活状态
function TreasureObj:flushSigleItemCell(key_name)
	local cell = GUI:GetWindow(self.ui.item_list, "cell_img"..key_name)
	-- GUI:removeAllChildren(cell)
	GUI:removeChildByName(cell,"btn")
	local cfg = TreasureObj.cfg[key_name]
	if TreasureObj:getIsActive(key_name) then
  		GUI:Image_Create(cell,"actve_img",18,15,"res/custom/tag/ylq_102.png")
  	end
end

function TreasureObj:flushDownInfo(btn_index)
	GUI:removeAllChildren(self.ui.downBox)
	if btn_index == 1 then
		GUI:Text_Create(self.ui.downBox, "title_text", 5, 46, 16, "#ff9b00","[已收录属性]:")
		local num1,num2,num3,num4 = TreasureObj:getActiveAttrList()
		local str = string.format("攻魔道伤：%s%%，防御魔御：%s%%",num1,num2) 
		GUI:Text_Create(self.ui.downBox, "attr_text1", 5, 24, 16, "#00ff00",str)
		local str2 = string.format("生命加成：%s%%，攻击伤害：%s%%",num3,num4) 
		GUI:Text_Create(self.ui.downBox, "attr_text2", 5, 2, 16, "#00ffe8",str2)
		local button = GUI:Button_Create(self.ui.downBox,"down_btn",436,16,"res/custom/dayeqian2.png")
		GUI:Button_setTitleText(button, "一键收录")
		GUI:Button_setTitleColor(button, "#ff9b00")
		GUI:Button_setTitleFontSize(button, 18)
		GUI:addOnClickEvent(button,function ()
			local data = {}
	        data.str = "点击确定后将自动收录背包所有秘宝\n注意：一键收录不会区分是否已觉醒属性秘宝\n请将觉醒过得秘宝存仓，避免造成损失!"
	        data.btnType = 2
	        data.callback = function(atype)
	          if atype == 1 then --确定
				SendMsgCallFunByNpc(0, "treasure", "allShouLuClick")
	          end
	        end
	        SL:OpenCommonTipsPop(data)    
		end)

	elseif btn_index == 2 then
		GUI:Text_Create(self.ui.downBox, "title_text", 5, 46, 16, "#ff9b00","[回收说明]:")
		local str = string.format("秘宝：秘宝碎片x%s","10") 
		GUI:Text_Create(self.ui.downBox, "attr_text1", 5, 24, 16, "#ffff00",str)

		local str2 = string.format("名品：秘宝碎片x%s","20") 
		GUI:Text_Create(self.ui.downBox, "attr_text2", 167, 24, 16, "#E110CB",str2)

		local str3 = string.format("绝品：秘宝碎片x%s","30") 
		GUI:Text_Create(self.ui.downBox, "attr_text3", 5, 2, 16, "#00ffe8",str3)

		local str4 = string.format("孤品：秘宝碎片x%s","50") 
		GUI:Text_Create(self.ui.downBox, "attr_text4", 167, 2, 16, "#ff0000",str4)

		local button = GUI:Button_Create(self.ui.downBox,"down_btn",436,16,"res/custom/dayeqian2.png")
		GUI:Button_setTitleText(button, "一键回收")
		GUI:Button_setTitleColor(button, "#ff9b00")
		GUI:Button_setTitleFontSize(button, 18)
		GUI:addOnClickEvent(button,function ()
			-- SL:Print("一键回收")
			local data = {}
	        data.str = "秘宝回收说明：\n一键回收不会回收绝品与孤品秘宝\n绝品与孤品秘宝请进行单独回收\n点击确定进行一键回收!"
	        data.btnType = 2
	        data.callback = function(atype)
				if atype == 1 then --确定
					SendMsgCallFunByNpc(0, "treasure", "allHuiShouClick")
				end
	        end
	        SL:OpenCommonTipsPop(data)    
		end)

	elseif btn_index == 3 then
		GUI:Text_Create(self.ui.downBox, "title_text", 5, 46, 16, "#ff9b00","[兑换说明]:")
		local str = string.format("绝品：秘宝碎片x%s		元宝x%s万","1288","100") 
		GUI:Text_Create(self.ui.downBox, "attr_text1", 5, 24, 16, "#00ff00",str)
		local str2 = string.format("孤品：秘宝碎片x%s  	金刚石x%s","1998","8888") 
		GUI:Text_Create(self.ui.downBox, "attr_text2", 5, 2, 16, "#ff0000",str2)
	else
	end
end

function TreasureObj:getActiveAttrList()
	if self.active_list == nil then return 0,0,0,0 end
	local num1,num2,num3,num4 = 0,0,0,0
	for k,v in pairs(TreasureObj.cfg) do
		if TreasureObj:getIsActive(v.key_name) then
			if v.group == "秘宝" then
				num1 = v.treasure_attr_value / 100 + num1
			elseif v.group == "名品" then
				num2 = v.treasure_attr_value / 100 + num2
			elseif v.group == "绝品" then
				num3 = v.treasure_attr_value / 100 + num3
			elseif v.group == "孤品" then
				num4 = v.treasure_attr_value + num4
			end
		end
	end
	return num1,num2,num3,num4
end
------------------------合成---------------------------
function TreasureObj:heChengGrid()
	GUI:ScrollView_removeAllChildren(self.ui.heChengListView)
	local list = TreasureObj:getCompoundMaterialList()
	self.bag_list = {}
	for i=1,24 do
		local index = 0
		if list[i] then
			index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", list[i].name)
		end 
		self.bag_list[i] = GUI:ItemShow_Create(self.ui.heChengListView,"hecheng_item"..i,0,0,{index = index,count = 1,bgVisible = true,look = true})
		GUI:ItemShow_setItemShowChooseState(self.bag_list[i],false)
		if index > 0 then
			GUI:ItemShow_addReplaceClickEvent(self.bag_list[i],function ()
				TreasureObj:flushCompoundBag(i,list[i])
			end)
		end
		GUI:Win_SetParam(self.bag_list[i], i)
	end
	if SL:GetMetaValue("WINPLAYMODE") then
		GUI:UserUILayout(self.ui.heChengListView, {
	        dir=3,
	        addDir=0,
	        colnum= 4,
	        gap = {x=30,y = 30,l=10,t=10},
	        sortfunc = function (lists)
	            table.sort(lists, function (a, b)
	                return GUI:Win_GetParam(a) < GUI:Win_GetParam(b)
	            end)
	        end
	    })
	else
	    GUI:UserUILayout(self.ui.heChengListView, {
	        dir=3,
	        addDir=0,
	        colnum= 4,
	        gap = {x=2,y = 4},
	        sortfunc = function (lists)
	            table.sort(lists, function (a, b)
	                return GUI:Win_GetParam(a) < GUI:Win_GetParam(b)
	            end)
	        end
	    })
	end
end

function TreasureObj:flushCompoundBag(index,cur_cfg)
	local is_reset = false
	if self.select_material_cell_index == index then
		is_reset = true
		self.select_material_cell_index = 0
		self.material_key_name = 0
	end
	for i,v in ipairs(self.bag_list) do
		if is_reset then
			GUI:ItemShow_setItemShowChooseState(self.bag_list[i],false)
		else
			self.select_material_cell_index = index
			self.material_key_name = cur_cfg.key_name
			GUI:ItemShow_setItemShowChooseState(self.bag_list[i],index == i)
		end
	end
	TreasureObj:flushMaterialShow(is_reset,cur_cfg)
end

function TreasureObj:flushMaterialShow(is_reset,cfg)
	local name_str = "副孤品：未选择"
	local attr_str = "可继承属性：未选择"
	if is_reset  then
		GUI:ItemShow_updateItem(self.ui.materialItem,{index = 0,count = 0,bgVisible = false,look = true})  
	else
		name_str = string.format("副孤品：%s",cfg.name) 
		attr_str = string.format("可继承属性：%s",cfg.awakening_attr) 
		GUI:ItemShow_updateItem(self.ui.materialItem,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.name),count = 0,bgVisible = false,look = true})  
	end
	GUI:Text_setString(self.ui.selectNameText,name_str) 
	GUI:Text_setString(self.ui.jiChengAttrText,attr_str) 
end

function TreasureObj:getCompoundMaterialList()
	local list = {}
	for k,v in pairs(TreasureObj.cfg) do
		local count = SL:GetMetaValue("ITEM_COUNT", v.name)
		if v.group == "孤品" and count > 0 then
			for i=1,count do
				table.insert(list,v)
			end
		end
	end
	return list
end

function TreasureObj:flushHeChengInfo()
	GUI:removeAllChildren(self.ui.compoundBox)
	local pos = SL:GetMetaValue("EQUIP_POS_BY_STDMODE", 65)
	local equip_data = SL:GetMetaValue("EQUIP_DATA", pos)
	if equip_data ~= nil then
		local equip_cell = GUI:EquipShow_Create(self.ui.compoundBox, "equipItem", 57,146, 14, false,{bgVisible = false, look = true, doubleTakeOff = false})
		GUI:setAnchorPoint(equip_cell,0.5,0.5) 
		-- GUI:EquipShow_setAutoUpdate(equip_cell)
	end
	GUI:ItemShow_updateItem(self.ui.hcExpendItem,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", "灵符"),count = 2000,bgVisible = false,look = true,color  = 250}) 
end

function TreasureObj:onClose()
	if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == TreasureObj.npcId then
        -- ViewMgr.open(TreasureObj.Name)
        SendMsgCallFunByNpc(0, "treasure","upEvent",1)
    end

end

SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, TreasureObj.Name, onClickNpc)

return TreasureObj