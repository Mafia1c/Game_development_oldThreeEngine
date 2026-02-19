local XueMai_LookOBJ = {}
XueMai_LookOBJ.Name = "XueMai_LookOBJ"
XueMai_LookOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
XueMai_LookOBJ.cfg = SL:Require("GUILayout/config/talentCfg",true)


function XueMai_LookOBJ:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.text_list = {}
		--加载UI
	GUI:LoadExport(parent, "npc/xuemaiUI")

	self.ui = GUI:ui_delegate(parent)

	--关闭按钮
	GUI:addOnClickEvent(self.ui.CloseButton, function()
		ViewMgr.close(XueMai_LookOBJ.Name)
	end)
	GUI:setVisible(self.ui.leftDownBox,false) 
	GUI:setVisible(self.ui.rebuildButton,false) 
	GUI:setVisible(self.ui.rebuildText,false) 
	GUI:setVisible(self.ui.selectTipText,true)
	GUI:setVisible(self.ui.rightInfoBox,false)
	GUI:setVisible(self.ui.xuemai_btn,false)
	GUI:setVisible(self.ui.wsxm_btn,false)
	local tab = {...}
	local data = SL:JsonDecode(tab[1])
	if data.tianfu_data == "" then
		data.tianfu_data = {}
	end
	if data.xuemai_data == "" then
		data.xuemai_data = {}
	end
	self.tianfu_data = data.tianfu_data
	self.xuemai_data = data.xuemai_data
	self.selectImg = GUI:Image_Create(self.ui.FrameBG,"selectImg",0,0,"res/public/bg_bossdi_05.png")
	GUI:setVisible(self.selectImg,false)
	GUI:setContentSize(self.selectImg,38,38)
	self:refreshXueMaiItem(data.tianfu_data,data.xuemai_data)
end
function XueMai_LookOBJ:refreshXueMaiItem(tianfu_data,xuemai_data)
	--上面的天赋格子
  	for i=1,30 do
  		local is_active =  i <= (#tianfu_data)
  		GUI:setTouchEnabled(self.ui["itemBox1_"..i], true)
  		GUI:setVisible(self.ui["itemBoxlock"..i],not is_active)
  		if is_active then
			local item = GUI:ItemShow_Create(self.ui["itemBox1_"..i],"item_"..i,30,30,{index = tianfu_data[i],count = 0,bgVisible = false,look = false})
	        GUI:setAnchorPoint(item,0.5,0.5)
	        GUI:setPosition(item,20,20)
	  		GUI:addOnClickEvent(self.ui["itemBox1_"..i],function ()
				GUI:setContentSize(self.selectImg,45,45)
		  		local pos = GUI:getPosition(self.ui["itemBox1_"..i])
		  		GUI:setPosition(self.selectImg,pos.x-2,pos.y-3)
				GUI:setVisible(self.selectImg,true)
				self:refreshRightInfo(self.cfg[tonumber(tianfu_data[i])])
	  		end)
  		end
  	end
  	--底部血脉格子
  	for i=1,6 do
  		local is_active = i <= (#xuemai_data)
  		GUI:setTouchEnabled(self.ui["itemBox2_"..i], true)
  		GUI:setVisible(self.ui["itemBoxlock2_"..i],not is_active)
  		if is_active then
			local item = GUI:ItemShow_Create(self.ui["itemBox2_"..i],"itemBox2_"..i,40,35,{index = xuemai_data[i],count = 0,bgVisible = false,look = false})
	        GUI:setAnchorPoint(item,0.5,0.5)
	        GUI:setPosition(item,38,35)
	  		GUI:addOnClickEvent(self.ui["itemBox2_"..i],function ()
	  			local pos = GUI:getPosition(self.ui["itemBox2_"..i])
	  			GUI:setContentSize(self.selectImg,60,55)
	  			GUI:setPosition(self.selectImg,pos.x+8,pos.y+10)
				GUI:setVisible(self.selectImg,true)
				self:refreshRightInfo(self.cfg[tonumber(xuemai_data[i])])
	  		end)
  		end
  	end

end

--刷新选中的信息
function XueMai_LookOBJ:refreshRightInfo(cur_cfg)
	GUI:setVisible(self.ui.rightInfoBox,true)
	GUI:setVisible(self.ui.selectTipText,false)
	for k,v in pairs(self.text_list) do
		if v then
			GUI:removeFromParent(v)
		end
	end
	self.text_list = {}
	table.insert(self.text_list,GUI:RichTextFCOLOR_Create(self.ui["rightInfoBox"], "item_name", 78, 237, cur_cfg.talent_name, 200, 16, "#ff9b00"))  
	table.insert(self.text_list,GUI:RichTextFCOLOR_Create(self.ui["rightInfoBox"], "item_color_desc", 78, 172, cur_cfg.color_desc, 200, 18, "#FFFFFF"))
	local layer_desc = string.format("<%s/FCOLOR=249>/<%s/FCOLOR=250>层",self:getCurTFNum(cur_cfg,cur_cfg.maxlevel),cur_cfg.maxlevel)
	table.insert(self.text_list,GUI:RichTextFCOLOR_Create(self.ui["rightInfoBox"], "tianfu_num", 150, 204, layer_desc, 80, 16, "#FFFFFF"))  
	
	local attr_desc = GUI:RichTextFCOLOR_Create(self.ui["rightInfoBox"], "item_desc", 30, 170, cur_cfg.attr_desc, 190, 16, "#FFFFFF")
	GUI:setAnchorPoint(attr_desc,0,1)
	table.insert(self.text_list,attr_desc)
	GUI:ItemShow_updateItem(self.ui["ItemShow"], {index = cur_cfg.key_name,count = 0,bgVisible = false,look = true})
end

--获取激活了多少相同的
function XueMai_LookOBJ:getCurTFNum(cur_cfg,maxlevel)
	local num = 0 
	if cur_cfg.talent_group == "天赋" then
		for k,v in pairs(self.tianfu_data) do
		 	if cur_cfg.key_name == tonumber(v)  then
		 		num = num + 1 
		 	end
		end 
	else
		for k,v in pairs(self.xuemai_data) do
		 	if cur_cfg.key_name == tonumber(v)  then
		 		num = num + 1 
		 	end
		end
	end
	return num < maxlevel and num or maxlevel
end
return XueMai_LookOBJ