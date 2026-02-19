local ShengLongJXOBJ = {}
ShengLongJXOBJ.Name = "ShengLongJXOBJ"
ShengLongJXOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
ShengLongJXOBJ.cfg = SL:Require("GUILayout/config/shengLongJxCfg",true)
ShengLongJXOBJ.npcId = 249
ShengLongJXOBJ.RunAction = true
local map_cfg = {}
local name_tab = {["聖龍战"] = 1,["聖龍法"] = 2,["聖龍道"] = 3}
local ont_name_tab = {"聖龍(战)","聖龍(法)","聖龍(道)"}
for i,v in ipairs(ShengLongJXOBJ.cfg) do
	map_cfg[name_tab[v.tpye]] = map_cfg[name_tab[v.tpye]] or {}
	table.insert(map_cfg[name_tab[v.tpye]],v)
end

function ShengLongJXOBJ:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.red_width_list = {}
	self.one_red_width_list = {}
	--加载UI
	GUI:LoadExport(parent, "npc/shengLongJueXingUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(ShengLongJXOBJ.Name)
	end)

	GUI:addOnClickEvent(self.ui.jueXingButton,function ()
		SendMsgCallFunByNpc(ShengLongJXOBJ.npcId, "ShengLongJX","OnClickJueXing",self.select_key_name or 0)
	end)
	-- local tab = {...}
	-- if tab[1] == "init_flush" then
	ShengLongJXOBJ:InitOneTypeList()
	ShengLongJXOBJ:oneBtnEvent(1)
	self:FlushOneRedShow()
	-- end
end

function ShengLongJXOBJ:flushView( ... )
	local param = {...}
	local tab = string.split(param[1],"|")
	if tab[1] == "jx_flush" then
		local cfg =  ShengLongJXOBJ.cfg[tonumber(tab[2])]
		ShengLongJXOBJ:twoBtnEvent(cfg.key_name,cfg)
		self:FlushBtnRedShow()
		self:FlushOneRedShow()
	end
end

function ShengLongJXOBJ:InitOneTypeList()
	for k,v in pairs(map_cfg) do
		local btn = GUI:Button_Create(self.ui.oneList,"one_type_btn"..k,0,0 ,"res/custom/dayeqian2.png")
		GUI:Button_setTitleText(btn, ont_name_tab[k])
		GUI:Button_setTitleFontSize(btn, 16)
		GUI:Button_setTitleColor(btn, "#F8E6C6")
		GUI:addOnClickEvent(btn,function ()
			ShengLongJXOBJ:oneBtnEvent(k)
		end)		
	end

end

function ShengLongJXOBJ:oneBtnEvent(key)
	self.one_btn_index = key
	if self.ui.ont_btn_tag then
        GUI:removeFromParent(self.ui.ont_btn_tag)
        self.ui = GUI:ui_delegate(self._parent)
    end
	GUI:Image_Create(self.ui["one_type_btn"..key],"ont_btn_tag",-7,10,"res/custom/npc/18tj/0.png")
    GUI:removeAllChildren(self.ui.twoList)
    self.red_width_list = {}
	local btn_img = GUI:Image_Create(self.ui.twoList,"two_type_btn",0, 0,"res/custom/yeqian1.png")
	local name = GUI:Text_Create(btn_img,"name",30,8,16,"#F8E6C6",map_cfg[key][1].tpye)
	GUI:Image_Create(btn_img,"two_btn_tag",-3,6,"res/custom/npc/18tj/1.png")
	local list = GUI:ListView_Create(btn_img,"leftListNow",0,0,118,35 * #map_cfg[key],1)
	GUI:setAnchorPoint(list,0,1)
	-- GUI:ListView_setBounceEnabled(list,true)
	for i,v in ipairs(map_cfg[key]) do
		local img = GUI:Image_Create(list,"smallImg"..v.key_name,0,0,"res/custom/sonBox.png")
		GUI:setContentSize(img, 106,35)
		local name = GUI:Text_Create(img,"name"..i,56,20,16,"#FFFFFF",v.name)
        GUI:setAnchorPoint(name,0.5,0.5)
        GUI:setLocalZOrder(name,20)
        GUI:setTouchEnabled(name,true)
        GUI:addOnClickEvent(name,function ()
	        ShengLongJXOBJ:twoBtnEvent(v.key_name,v)
	    end)
	end
	ShengLongJXOBJ:twoBtnEvent(map_cfg[key][1].key_name,map_cfg[key][1])
	self:FlushBtnRedShow()
end

function ShengLongJXOBJ:twoBtnEvent(key_name,cfg)
	self.select_key_name = cfg.key_name
	if self.ui.leftSonImg then
        GUI:removeFromParent(self.ui.leftSonImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Image_Create(self.ui["smallImg"..key_name],"leftSonImg",50,17,"res/public/1900000678.png")
    GUI:setAnchorPoint(self.ui.leftSonImg,0.5,0.5)
    local need_list = {["神灵石"] = 1,["元宝"] = 2}
    local item_index = 1
    for k,v in pairs(cfg.need_map) do
    	item_index = need_list[k] or 3 
    	local count = SL:GetMetaValue("ITEM_COUNT", k)
     	ItemShow_updateItem(self.ui["needitem"..item_index],{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",k),count = v,bgVisible = false,look = true,color = count >= v and 250 or 249})
    end 
 	ItemShow_updateItem(self.ui.targetItem,{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",cfg.name),count = 1,bgVisible = false,look = true,color= 251})
 	local str = "觉醒成功率：<font color='#ffff00' >%s%%</font>+<font color='#00ff00'>%s%%</font><font color='#ff0000'>(不继承附魔、宝石等属性)</font>"
 	if self.ui.RichText_otts then
        GUI:removeFromParent(self.ui.RichText_otts)
        self.ui = GUI:ui_delegate(self._parent)
    end
    local temp_odds = GameData.GetData("U_sljx_odds"..key_name,false) or 0 
	GUI:RichText_Create(self.ui.Image_1, "RichText_otts", 380, 154, string.format(str,cfg.probability,temp_odds) , 600, 16, "#ffffff", 4)
end

function ShengLongJXOBJ:FlushBtnRedShow()
	local two_cfg = map_cfg[self.one_btn_index]
	for k,cfg in pairs(two_cfg) do
		if self:GetSigleItemRed(cfg) then
			if self.red_width_list[cfg.key_name] == nil then
				self.red_width_list[cfg.key_name] = SL:CreateRedPoint(self.ui["smallImg"..cfg.key_name],{x= 5,y = 10})  
			end
		else
			if self.red_width_list[cfg.key_name] then
				GUI:removeFromParent(self.red_width_list[cfg.key_name])
				self.red_width_list[cfg.key_name] = nil
			end
		end
	end
end

function ShengLongJXOBJ:FlushOneRedShow()
	for k,v in pairs(map_cfg) do
		local is_show_red = false
		for _,cfg in pairs(v) do
			if self:GetSigleItemRed(cfg) then
				is_show_red = true
				break
			end
		end

		if is_show_red then
			if self.one_red_width_list[k] == nil then
				self.one_red_width_list[k] = SL:CreateRedPoint(self.ui["one_type_btn"..k],{x= 5,y = 10})  
			end
		else
			if self.one_red_width_list[k] then
				GUI:removeFromParent(self.one_red_width_list[k])
				self.one_red_width_list[k] = nil
			end
		end
	end
end

function ShengLongJXOBJ:GetSigleItemRed(cfg)
	for k,v in pairs(cfg.need_map) do
    	if  SL:GetMetaValue("ITEM_COUNT", k) < v then
    		return false
    	end
    end
    return true 
end

function ShengLongJXOBJ:onClose()
	for k,v in pairs(self.red_width_list) do
		if v then
			GUI:removeFromParent(v)
		end
	end	
	self.red_width_list = {}
	for k,v in pairs(self.one_red_width_list) do
		if v then
			GUI:removeFromParent(v)
		end
	end	
	self.one_red_width_list = {}
end
-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == ShengLongJXOBJ.npcId then
        -- ViewMgr.open(ShengLongJXOBJ.Name)
    	SendMsgCallFunByNpc(ShengLongJXOBJ.npcId, "ShengLongJX","upEvent")
    end
end

SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, ShengLongJXOBJ.Name, onClickNpc)

return ShengLongJXOBJ