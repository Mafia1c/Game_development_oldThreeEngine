local GreatMasterAwakeOBJ = {}
GreatMasterAwakeOBJ.Name = "GreatMasterAwakeOBJ"
GreatMasterAwakeOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
GreatMasterAwakeOBJ.cfg = SL:Require("GUILayout/config/GreatMasterAwakeCfg",true)
GreatMasterAwakeOBJ.npcId = 273
GreatMasterAwakeOBJ.RunAction = true
local map_cfg = {}
local name_tab = {["宗师战"] = 1,["宗师法"] = 2,["宗师道"] = 3}
local ont_name_tab = {"宗师(战)","宗师(法)","宗师(道)"}
for i,v in ipairs(GreatMasterAwakeOBJ.cfg) do
	map_cfg[name_tab[v.tpye]] = map_cfg[name_tab[v.tpye]] or {}
	table.insert(map_cfg[name_tab[v.tpye]],v)
end

function GreatMasterAwakeOBJ:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/GreatMasterAwakeUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(GreatMasterAwakeOBJ.Name)
	end)

	GUI:addOnClickEvent(self.ui.jueXingButton,function ()
		SendMsgCallFunByNpc(GreatMasterAwakeOBJ.npcId, "GreatMasterAwake","OnClickJueXing",self.select_key_name or 0)
	end)
	local tab = {...}
	if tab[1] == "init_flush" then
		GreatMasterAwakeOBJ:InitOneTypeList()
		GreatMasterAwakeOBJ:oneBtnEvent(1)
	end
	
end

function GreatMasterAwakeOBJ:flushView( ... )
	local param = {...}
	local tab = string.split(param[1],"|")
	if tab[1] == "jx_flush" then
		local cfg =  GreatMasterAwakeOBJ.cfg[tonumber(tab[2])]
		GreatMasterAwakeOBJ:twoBtnEvent(cfg.key_name,cfg)
	end
end

function GreatMasterAwakeOBJ:InitOneTypeList()
	for k,v in pairs(map_cfg) do
		local btn = GUI:Button_Create(self.ui.oneList,"one_type_btn"..k,0,0 ,"res/custom/dayeqian2.png")
		GUI:Button_setTitleText(btn, ont_name_tab[k])
		GUI:Button_setTitleFontSize(btn, 16)
		GUI:Button_setTitleColor(btn, "#F8E6C6")
		GUI:addOnClickEvent(btn,function ()
			GreatMasterAwakeOBJ:oneBtnEvent(k)
		end)		
	end
end

function GreatMasterAwakeOBJ:oneBtnEvent(key)
	if self.ui.ont_btn_tag then
        GUI:removeFromParent(self.ui.ont_btn_tag)
        self.ui = GUI:ui_delegate(self._parent)
    end
	GUI:Image_Create(self.ui["one_type_btn"..key],"ont_btn_tag",-7,10,"res/custom/npc/18tj/0.png")
    GUI:removeAllChildren(self.ui.twoList)

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
	        GreatMasterAwakeOBJ:twoBtnEvent(v.key_name,v)
	    end)
	end
	GreatMasterAwakeOBJ:twoBtnEvent(map_cfg[key][1].key_name,map_cfg[key][1])
end

function GreatMasterAwakeOBJ:twoBtnEvent(key_name,cfg)
	self.select_key_name = cfg.key_name
	if self.ui.leftSonImg then
        GUI:removeFromParent(self.ui.leftSonImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
     GUI:Image_Create(self.ui["smallImg"..key_name],"leftSonImg",50,17,"res/public/1900000678.png")
    GUI:setAnchorPoint(self.ui.leftSonImg,0.5,0.5)
    local need_list = {["龙之心"] = 1,["金刚石"] = 2,["龙之血"] = 3}
    local item_index = 1
    for k,v in pairs(cfg.need_map) do
    	-- SL:Print( SL:GetMetaValue("ITEM_INDEX_BY_NAME",k))
    	item_index = need_list[k] or 4 
    	local count = SL:GetMetaValue("ITEM_COUNT", k)
     	ItemShow_updateItem(self.ui["needitem"..item_index],{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",k),count = v,bgVisible = false,look = true,color = count >= v and 250 or 249})
   		-- item_index  = item_index + 1
    end 
 	ItemShow_updateItem(self.ui.targetItem,{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",cfg.name),count = 1,bgVisible = false,look = true,color = 251})
 	local str = "觉醒成功率：<font color='#ffff00' >%s%%</font>+<font color='#00ff00'>%s%%</font><font color='#ff0000'>(不继承附魔、宝石等属性)</font>"
 	if self.ui.RichText_otts then
        GUI:removeFromParent(self.ui.RichText_otts)
        self.ui = GUI:ui_delegate(self._parent)
    end
    local temp_odds = GameData.GetData("U_zsjx_odds"..key_name,false) or 0
	GUI:RichText_Create(self.ui.Image_1, "RichText_otts", 380, 154, string.format(str,cfg.probability,temp_odds) , 600, 16, "#ffffff", 4)
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == GreatMasterAwakeOBJ.npcId then
        -- ViewMgr.open(GreatMasterAwakeOBJ.Name)
        SendMsgCallFunByNpc(GreatMasterAwakeOBJ.npcId, "GreatMasterAwake","upEvent")
    end
end

SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, GreatMasterAwakeOBJ.Name, onClickNpc)

return GreatMasterAwakeOBJ