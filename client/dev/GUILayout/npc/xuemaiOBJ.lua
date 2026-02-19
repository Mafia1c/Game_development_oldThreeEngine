local xuemaiOBJ = {}

xuemaiOBJ.Name = "xuemaiOBJ"
xuemaiOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
xuemaiOBJ.cfg = SL:Require("GUILayout/config/talentCfg",true)


function xuemaiOBJ:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
		--加载UI
	GUI:LoadExport(parent, "npc/xuemaiUI")

	self.ui = GUI:ui_delegate(parent)
	self.ui.text_list = {}
	self.ui.box_list = {}
	self.ui.xuemai_box_list = {}
	self.select_tf_index = 0

	local tab = {...}
    local data = SL:JsonDecode(tab[1])
	if #data.tianfu_data <= 0 then
		self.tianfu_data = {}
	else
		self.tianfu_data = data.tianfu_data
	end

	if #data.xuemai_data <= 0 then
		self.xuemai_data = {}
	else
		self.xuemai_data = data.xuemai_data
	end

	--关闭按钮
	GUI:addOnClickEvent(self.ui.CloseButton, function()
		ViewMgr.close(xuemaiOBJ.Name)
	end)
	--图鉴
	GUI:addOnClickEvent(self.ui.tujian_btn,function ()
		ViewMgr.open("XueMaiTuJianOBJ") 
	end)

	GUI:addOnClickEvent(self.ui.tip_btn, function()
		local data = {}
	    data.str = "角色40级后，每级可获得1次天赋激活机会，共30次！每激活5次天赋，可觉醒一次血脉！"
	    data.btnType = 1
	    SL:OpenCommonTipsPop(data)
	end)
	
	--关闭按钮
	GUI:addOnClickEvent(self.ui.wsxm_btn, function()
		ViewMgr.close(xuemaiOBJ.Name)
		-- ViewMgr.open("WuShuangXueMaiOBJ")
		SendMsgCallFunByNpc(0, "WuShuangXueMai", "upEvent") 
	end)
	GUI:setGrey(self.ui.xuemai_btn, true)
	
	self.selectImg = GUI:Image_Create(self.ui.FrameBG,"selectImg",0,0,"res/public/bg_bossdi_05.png")
	GUI:setVisible(self.selectImg,false)
	GUI:setContentSize(self.selectImg,38,38)

	GUI:setVisible(self.ui.selectTipText,true)
	GUI:setVisible(self.ui.rightInfoBox,false)

	--点击激活
	local function click_callback()
		SendMsgCallFunByNpc(0, "xuemai", "activeClick")
	end
	GUI:addOnClickEvent(self.ui.activateButton, function()
		click_callback()
	end)

	--重修天赋
	GUI:addOnClickEvent(self.ui.rebuildButton, function()
		if self.select_tf_index <= 0 then
			SL:ShowSystemTips("未选择天赋")
			return
		end
		SendMsgCallFunByNpc(0, "xuemai", "rebuildClick",self.select_tf_index)
	end)

    GUI:setVisible(self.ui.xuemai_btn,SL:GetMetaValue("RELEVEL") >= 10) 
	GUI:setVisible(self.ui.wsxm_btn,SL:GetMetaValue("RELEVEL") >= 10)


	
	xuemaiOBJ:refreshXueMaiItem()

    local navigation = tonumber(GameData.GetData("U_navigation_task_step", false))
    if navigation == 3 then
        GUI:runAction(self.ui.xuemai_btn, GUI:ActionSequence(GUI:DelayTime(0.1), GUI:CallFunc(function()
			local function callback()
				click_callback()
			end
			local _data = {}
			_data.dir           = 1                -- 方向（1~8）从左按瞬时针
			_data.guideWidget   = self.ui["activateButton"]        -- 当前节点
			_data.guideParent   = self._parent          -- 父窗口
			_data.guideDesc     = "点击领取"           -- 文本描述
			_data.clickCB       = callback         -- 回调
			_data.autoExcute    = 86400            -- 自动执行秒数
			_data.isForce       = true             -- 强制引导
			_data.hideMask      = true             -- 隐藏蒙版 [仅不强制引导时有效]
			SL:StartGuide(_data)
        end)))  
    end	
end

function xuemaiOBJ:isActiveXueMai()
	if #self.tianfu_data > 0 and  #self.tianfu_data % 5 == 0 and #self.xuemai_data < math.floor(#self.tianfu_data/5) then
		return true
	end
	return  false
end

function xuemaiOBJ:flushView(...)
	local param = {...}
	local tab = string.split(param[1],"|")

	local data = SL:JsonDecode(tab[1])
	if #data.tianfu_data <= 0 then
		self.tianfu_data = {}
	else
		self.tianfu_data = data.tianfu_data
	end

	if #data.xuemai_data <= 0 then
		self.xuemai_data = {}
	else
		self.xuemai_data = data.xuemai_data
	end
	xuemaiOBJ:refreshXueMaiItem()
	local index = tonumber(tab[3]) 
	if tab[2] == "重修" then
		if index > 30 then
			xuemaiOBJ:refreshRightInfo(xuemaiOBJ.cfg[tonumber(self.xuemai_data[index - 30])])
		else
			xuemaiOBJ:refreshRightInfo(xuemaiOBJ.cfg[tonumber(self.tianfu_data[index])])
		end
	end
end

function xuemaiOBJ:refreshXueMaiItem()
	--上面的天赋格子
  	for i=1,30 do
  		local is_active =  i <= (#self.tianfu_data)
  		GUI:setTouchEnabled(self.ui["itemBox1_"..i], true)
  		GUI:setVisible(self.ui["itemBoxlock"..i],not is_active)
  		if is_active then
  			if self.ui.box_list[i] == nil then
  					self.ui.box_list[i] = GUI:ItemShow_Create(self.ui["itemBox1_"..i],"item_"..i,30,30,{index = self.tianfu_data[i],count = 0,bgVisible = false,look = false})
  			else
  					GUI:ItemShow_updateItem(self.ui.box_list[i] , {index = self.tianfu_data[i],count = 0,bgVisible = false,look = false})
  			end
  			-- local item = GUI:ItemShow_Create(self.ui["itemBox1_"..i],"item_"..i,30,30,{index =xuemaiOBJ.cfg[self.tianfu_data[i]].buff_id,count = 0,bgVisible = false,
        GUI:setAnchorPoint(self.ui.box_list[i],0.5,0.5)
        GUI:setPosition(self.ui.box_list[i],20,20)
	  		GUI:addOnClickEvent(self.ui["itemBox1_"..i],function ()
					GUI:setContentSize(self.selectImg,45,45)
		  		local pos = GUI:getPosition(self.ui["itemBox1_"..i])
		  		GUI:setPosition(self.selectImg,pos.x-2,pos.y-3)
					GUI:setVisible(self.selectImg,true)
					xuemaiOBJ:refreshRightInfo(xuemaiOBJ.cfg[tonumber(self.tianfu_data[i])])
					self.select_tf_index = i
	  		end)
  		else
  			GUI:addOnClickEvent(self.ui["itemBox1_"..i],function ()
					SL:ShowSystemTips("请先激活该天赋")
	  		end)
  		end
  	end
  	--底部血脉格子
  	for i=1,6 do
  		local is_active = i <= (#self.xuemai_data)
  		GUI:setTouchEnabled(self.ui["itemBox2_"..i], true)
  		GUI:setVisible(self.ui["itemBoxlock2_"..i],not is_active)

  		if is_active then
  			if self.ui.xuemai_box_list[i] == nil then
  					self.ui.xuemai_box_list[i] = GUI:ItemShow_Create(self.ui["itemBox2_"..i],"itemBox2_"..i,40,35,{index = self.xuemai_data[i],count = 0,bgVisible = false,look = false})
  			else
  					GUI:ItemShow_updateItem(self.ui.xuemai_box_list[i] , {index = self.xuemai_data[i],count = 0,bgVisible = false,look = false})
  			end
        GUI:setAnchorPoint(self.ui.xuemai_box_list[i],0.5,0.5)
        GUI:setPosition(self.ui.xuemai_box_list[i],38,35)

	  		GUI:addOnClickEvent(self.ui["itemBox2_"..i],function ()
	  			local pos = GUI:getPosition(self.ui["itemBox2_"..i])
	  			GUI:setContentSize(self.selectImg,60,55)
	  			GUI:setPosition(self.selectImg,pos.x+8,pos.y+10)
					GUI:setVisible(self.selectImg,true)
					xuemaiOBJ:refreshRightInfo(xuemaiOBJ.cfg[tonumber(self.xuemai_data[i])])
					self.select_tf_index = 30 + i
	  		end)
  		else
  			GUI:addOnClickEvent(self.ui["itemBox2_"..i],function ()
					SL:ShowSystemTips("请先激活该天赋")
	  		end)
  		end
  	end
	local level = SL:GetMetaValue("LEVEL")
	if level > 70 then
		level = 70
	end
	local can_active_num = level - 40 - #self.tianfu_data
	if can_active_num <= 0 or level < 40  then
		GUI:Text_setString(self.ui.activateNumText,"当前可激活次数：0次") 
		self:flushRed(false)
	else
		GUI:Text_setString(self.ui.activateNumText,string.format("当前可激活次数：%s次",can_active_num > 30 and 30 or can_active_num)) 
		self:flushRed(true)
	end

  	if self:isActiveXueMai() then
  		self:flushRed(true)
	end
end
--刷新选中的信息
function xuemaiOBJ:refreshRightInfo(cur_cfg)
	GUI:setVisible(self.ui.rightInfoBox,true)
	GUI:setVisible(self.ui.selectTipText,false)
	for k,v in pairs(self.ui.text_list) do
		if v then
			GUI:removeFromParent(v)
		end
	end
	self.ui.text_list = {}
	table.insert(self.ui.text_list,GUI:RichTextFCOLOR_Create(self.ui["rightInfoBox"], "item_name", 78, 237, cur_cfg.talent_name, 200, 16, "#ff9b00"))  
	table.insert(self.ui.text_list,GUI:RichTextFCOLOR_Create(self.ui["rightInfoBox"], "item_color_desc", 78, 172, cur_cfg.color_desc, 200, 18, "#FFFFFF"))
	-- SL:Print(xuemaiOBJ:getCurTFNum(cur_cfg.key_name,cur_cfg.maxlevel),cur_cfg.maxlevel)
	local layer_desc = string.format("<%s/FCOLOR=249>/<%s/FCOLOR=250>层",xuemaiOBJ:getCurTFNum(cur_cfg,cur_cfg.maxlevel),cur_cfg.maxlevel)
	table.insert(self.ui.text_list,GUI:RichTextFCOLOR_Create(self.ui["rightInfoBox"], "tianfu_num", 150, 204, layer_desc, 80, 16, "#FFFFFF"))  
	
	local attr_desc = GUI:RichTextFCOLOR_Create(self.ui["rightInfoBox"], "item_desc", 30, 170, cur_cfg.attr_desc, 190, 16, "#FFFFFF")
	GUI:setAnchorPoint(attr_desc,0,1)
	table.insert(self.ui.text_list,attr_desc)
	GUI:ItemShow_updateItem(self.ui["ItemShow"], {index = cur_cfg.key_name,count = 0,bgVisible = false,look = true})
end

--获取激活了多少相同的
function xuemaiOBJ:getCurTFNum(cur_cfg,maxlevel)
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

function xuemaiOBJ:flushRed(is_show_red)
	if self.red_width ~= nil then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.activateButton)
        end
    end
end

--#region 关闭前回调
function xuemaiOBJ:onClose(...)
	if self.red_width ~= nil then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 

end

return xuemaiOBJ