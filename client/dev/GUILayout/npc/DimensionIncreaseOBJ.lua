local DimensionIncreaseOBJ = {}
DimensionIncreaseOBJ.Name = "DimensionIncreaseOBJ"
DimensionIncreaseOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
DimensionIncreaseOBJ.cfg = SL:Require("GUILayout/config/DimensionIncreaseCfg",true)
DimensionIncreaseOBJ.zfcfg = SL:Require("GUILayout/config/DimensionIncrease2Cfg",true)
DimensionIncreaseOBJ.npcId = 391
DimensionIncreaseOBJ.RunAction = true
local map_cfg = {}
local sort_key_list = {}
local one_name_tab = {["次元解封(战)"] = "次元(战)",["次元解封(法)"] = "次元(法)",["次元解封(道)"] = "次元(道)",["异次元增幅"] = "次元增幅"}
for i,v in ipairs(DimensionIncreaseOBJ.cfg) do
	if map_cfg[v.type] == nil then
		table.insert(sort_key_list,v.type)
	end
	map_cfg[v.type] = map_cfg[v.type] or {}
	table.insert(map_cfg[v.type],v)
end

function DimensionIncreaseOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/DimensionIncreaseUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(DimensionIncreaseOBJ.Name)
	end)

	GUI:addOnClickEvent(self.ui.jf_btn,function ()
		SendMsgCallFunByNpc(DimensionIncreaseOBJ.npcId, "DimensionIncreaseOBJ","OnClickJf",self.select_key_name or 0)
	end)

	GUI:addOnClickEvent(self.ui.zf_btn,function ()
		if self.entry_level and self.entry_level  >= 3 then
			local data = {}
	        data.str = "当前增幅词条等级："..self.entry_str.."\n是否确定重置？"
	        data.btnType = 2
	        data.callback = function(atype)
	            if atype == 1 then --确定
					SendMsgCallFunByNpc(DimensionIncreaseOBJ.npcId, "DimensionIncreaseOBJ","OnClickZf",self.select_key_name or 0)
	            end
	        end
 			SL:OpenCommonTipsPop(data)    
		else
			SendMsgCallFunByNpc(DimensionIncreaseOBJ.npcId, "DimensionIncreaseOBJ","OnClickZf",self.select_key_name or 0)
		end
	end)
	self:InitOneTypeList()
	-- SendMsgCallFunByNpc(DimensionIncreaseOBJ.npcId, "DimensionIncreaseOBJ","upEvent")
end



function DimensionIncreaseOBJ:flushView( ... )
	local tab = {...}
	if tab[1] == "init_flush" then
		self:InitOneTypeList()
	elseif tab[1] == "jf_flush" then
		local cfg =  DimensionIncreaseOBJ.cfg[tonumber(tab[2])]
		DimensionIncreaseOBJ:twoBtnEvent(cfg.key_name,cfg)
	elseif tab[1] == "zf_flush" then
		local cfg =  DimensionIncreaseOBJ.zfcfg[tonumber(tab[2])]
		self.entry_str = tab[3]
		self.entry_level = tonumber(tab[4])
		DimensionIncreaseOBJ:ZftwoBtnEvent(cfg.key_name,cfg,self.entry_str)
	end
end

function DimensionIncreaseOBJ:InitOneTypeList()
	for k,v in pairs(sort_key_list) do
		local btn = GUI:Button_Create(self.ui.oneList,"one_type_btn"..v,0,0 ,"res/custom/dayeqian2.png")
		GUI:Button_setTitleText(btn, v)
		GUI:Button_setTitleFontSize(btn, 16)
		GUI:Button_setTitleColor(btn, "#F8E6C6")
		GUI:addOnClickEvent(btn,function ()
			DimensionIncreaseOBJ:oneBtnEvent(v)
		end)		
	end
	local btn = GUI:Button_Create(self.ui.oneList,"one_type_btn异次元增幅",0,0 ,"res/custom/dayeqian2.png")
	GUI:Button_setTitleText(btn, "异次元增幅")
	GUI:Button_setTitleFontSize(btn, 16)
	GUI:Button_setTitleColor(btn, "#F8E6C6")
	GUI:addOnClickEvent(btn,function ()
		DimensionIncreaseOBJ:oneBtnEvent("异次元增幅")
	end)	
	DimensionIncreaseOBJ:oneBtnEvent("次元解封(战)")
end

function DimensionIncreaseOBJ:oneBtnEvent(key)
	GUI:setVisible(self.ui.zengfu_box,key == "异次元增幅") 
	GUI:setVisible(self.ui.DeblockingBox,key ~= "异次元增幅") 
	if self.ui.ont_btn_tag then
        GUI:removeFromParent(self.ui.ont_btn_tag)
        self.ui = GUI:ui_delegate(self._parent)
    end
	GUI:Image_Create(self.ui["one_type_btn"..key],"ont_btn_tag",-7,10,"res/custom/npc/18tj/0.png")
    GUI:removeAllChildren(self.ui.twoList)
	local btn_img = GUI:Image_Create(self.ui.twoList,"two_type_btn",0, 0,"res/custom/yeqian1.png")
	GUI:Text_Create(btn_img,"name",30,8,16,"#F8E6C6",one_name_tab[key])
	GUI:Image_Create(btn_img,"two_btn_tag",-3,6,"res/custom/npc/18tj/1.png")
	local list_cfg = key == "异次元增幅" and DimensionIncreaseOBJ.zfcfg or map_cfg[key] 
	local list = GUI:ListView_Create(btn_img,"leftListNow",0,0,118,35 * #list_cfg,1)
	GUI:setAnchorPoint(list,0,1)
	GUI:ListView_setBounceEnabled(list,false)
	if key == "异次元增幅" then
		for i,v in ipairs(DimensionIncreaseOBJ.zfcfg) do
			local img = GUI:Image_Create(list,"smallImg"..v.key_name,0,0,"res/custom/sonBox.png")
			GUI:setContentSize(img, 106,35)
			local name = GUI:Text_Create(img,"name"..i,56,20,16,"#ff0000","增幅："..v.name)
	        GUI:setAnchorPoint(name,0.5,0.5)
	        GUI:setLocalZOrder(name,20)
	        GUI:setTouchEnabled(name,true)
	        GUI:addOnClickEvent(name,function ()
	        	SendMsgCallFunByNpc(DimensionIncreaseOBJ.npcId, "DimensionIncreaseOBJ","FlushDefAttr",v.key_name or 0)
		        -- DimensionIncreaseOBJ:ZftwoBtnEvent(v.key_name,v)
		    end)
		end

    	SendMsgCallFunByNpc(DimensionIncreaseOBJ.npcId, "DimensionIncreaseOBJ","FlushDefAttr",DimensionIncreaseOBJ.zfcfg[1].key_name)
		-- DimensionIncreaseOBJ:ZftwoBtnEvent(DimensionIncreaseOBJ.zfcfg[1].key_name,DimensionIncreaseOBJ.zfcfg[1])
	else
		for i,v in ipairs(map_cfg[key]) do
			local img = GUI:Image_Create(list,"smallImg"..v.key_name,0,0,"res/custom/sonBox.png")
			GUI:setContentSize(img, 106,35)
			local name = GUI:ScrollText_Create(img,"name"..i,56,20,110,16,"#FFFFFF",v.name)
	        GUI:setAnchorPoint(name,0.5,0.5)
	        GUI:setLocalZOrder(name,20)
	        GUI:setTouchEnabled(name,true)
	        GUI:addOnClickEvent(name,function ()
		        DimensionIncreaseOBJ:twoBtnEvent(v.key_name,v)
		    end)
		end
		DimensionIncreaseOBJ:twoBtnEvent(map_cfg[key][1].key_name,map_cfg[key][1])
	end
end

function DimensionIncreaseOBJ:ZftwoBtnEvent(key_name,cfg,str)
	self.select_key_name = cfg.key_name
	if self.ui.leftSonImg then
        GUI:removeFromParent(self.ui.leftSonImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["smallImg"..key_name],"leftSonImg",50,17,"res/public/1900000678.png")
    GUI:setAnchorPoint(self.ui.leftSonImg,0.5,0.5)
    if self.ui.zferquip then
        GUI:removeFromParent(self.ui.zferquip)
        self.ui = GUI:ui_delegate(self._parent)
    end

    local need_list = {["次元魔石"] = 1,["灵符"] = 2}
   	for k,v in pairs(cfg.need_map) do
    	item_index = need_list[k]
    	local count = SL:GetMetaValue("ITEM_COUNT", k)
    	if item_index < 3 then
    		ItemShow_updateItem(self.ui["needitem"..item_index],{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",k),count = v,bgVisible = true,look = true,color = count >= v and 250 or 249})
    	end
    end 
    GUI:EquipShow_Create(self.ui.zengfu_box, "zferquip", 211, 339, cfg.part,false,{look=true,bgVisible=true})
    GUI:Text_setString(self.ui.success_rate_text,string.format("增幅成功几率：%s%%",cfg.success_rate) ) 
    GUI:Text_setString(self.ui.attr_text,str) 

end

function DimensionIncreaseOBJ:twoBtnEvent(key_name,cfg)
	self.select_key_name = cfg.key_name
	if self.ui.leftSonImg then
        GUI:removeFromParent(self.ui.leftSonImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["smallImg"..key_name],"leftSonImg",50,17,"res/public/1900000678.png")
    GUI:setAnchorPoint(self.ui.leftSonImg,0.5,0.5)
    local need_list = {["异界水晶"] = 1,["灵符"] = 2}
    local item_index = 1
    for k,v in pairs(cfg.need_map) do
    	item_index = need_list[k] or 3
    	local count = SL:GetMetaValue("ITEM_COUNT", k)
    	if item_index < 3 then
    		ItemShow_updateItem(self.ui["needitem"..item_index],{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",k),count = v,bgVisible = true,look = true,color = count >= v and 250 or 249})
    	else
    		for i=3,4 do
     			ItemShow_updateItem(self.ui["needitem"..i],{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",k),count = 1,bgVisible = true,look = true,color = count >= 2 and 250 or 249})
    		end
    	end
    end 
 	GUI:ItemShow_updateItem(self.ui.targetItem,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",cfg.name),count = 1,bgVisible = true,look = true})
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == DimensionIncreaseOBJ.npcId then
        ViewMgr.open(DimensionIncreaseOBJ.Name)
    end
end

SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, DimensionIncreaseOBJ.Name, onClickNpc)

return DimensionIncreaseOBJ