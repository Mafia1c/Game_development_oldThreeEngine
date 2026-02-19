local WuShuangXueMaiOBJ = {}
WuShuangXueMaiOBJ.Name = "WuShuangXueMaiOBJ"
WuShuangXueMaiOBJ.cfg = SL:Require("GUILayout/config/WuShuangXueMaiCfg",true)
WuShuangXueMaiOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
WuShuangXueMaiOBJ.npcId = 252
-- WuShuangXueMaiOBJ.RunAction = true

function WuShuangXueMaiOBJ:main(...)
	local tab = {...}
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.key_index = 0
	self.active_list = {}
	--加载UI
	GUI:LoadExport(parent, "npc/WuShuangXueMaiUI")

	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.close_btn, function()
	  ViewMgr.close(WuShuangXueMaiOBJ.Name)
	end)

	GUI:addOnClickEvent(self.ui.tip_btn,function ()
		local data = {}
	    data.str = "激活次数说明：\n每激活一套天命根骨\n可获得1次无双血脉激活机会，共6次激活机会！"
	    data.btnType = 1
	    SL:OpenCommonTipsPop(data)
	end) 

	GUI:addOnClickEvent(self.ui.xuemai_btn, function()
		ViewMgr.close(WuShuangXueMaiOBJ.Name)
	  	-- ViewMgr.open("xuemaiOBJ")
	  	 SendMsgCallFunByNpc(0, "xuemai", "upEvent")
	end)

	--天赋重修
	GUI:addOnClickEvent(self.ui.reset_btn,function ()
		if self.select_pos == nil then
			return SL:ShowSystemTips("未选择無双血脉!")
		end
		ViewMgr.open("WuShuangChongXiuOBJ",self.select_pos,WuShuangXueMaiOBJ:GetPosKeyName(self.select_pos))
		-- SendMsgCallFunByNpc(0, "WuShuangXueMai", "OpenChongXiu")
	end) 

	--激活
	GUI:addOnClickEvent(self.ui.active_btn,function ()
		SendMsgCallFunByNpc(0, "WuShuangXueMai", "activeClick")
	end) 

	GUI:setVisible(self.ui.xuemai_btn,SL:GetMetaValue("RELEVEL") >= 10) 
	GUI:setVisible(self.ui.wsxm_btn,SL:GetMetaValue("RELEVEL") >= 10) 

	GUI:setGrey(self.ui.wsxm_btn, true)

	-- WuShuangXueMaiOBJ:FlushInfo()
	GUI:setVisible(self.ui.select_info_box,false) 
	GUI:setVisible(self.ui.not_select_tip,true) 
	if tab[1] == "initview"  then
		self.active_list = SL:JsonDecode(tab[2])
		self.can_active_count = tonumber(tab[3])
		self:FlushInfo()
	end
end

function WuShuangXueMaiOBJ:FlushInfo()
	-- local reward_id = VarApi.getPlayerUIntVar(actor, "U_root_bone_reward")
	for i=1,6 do
		local is_active = WuShuangXueMaiOBJ:GetIsActive(i)
		GUI:setVisible(self.ui["lock_"..i],not is_active)
		if is_active  and WuShuangXueMaiOBJ:GetPosKeyName(i) then
			local key_name = WuShuangXueMaiOBJ:GetPosKeyName(i)
			local cfg =  WuShuangXueMaiOBJ.cfg[key_name]
			GUI:ItemShow_updateItem(self.ui["ItemShow_"..i],{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.talent_name), look = false, bgVisible = false, count = 1})
		end
		GUI:addOnClickEvent(self.ui["xuemai_box"..i], function ()
			if not is_active then
				return SL:ShowSystemTips("该血脉未激活!")
			end
			GUI:setVisible(self.ui.select_img,true) 
			local pos = GUI:getPosition(self.ui["xuemai_box"..i])
			GUI:setPosition(self.ui.select_img,pos.x + 6,pos.y+5) 
			self.select_pos = i
			self:FlushRightInfo(WuShuangXueMaiOBJ:GetPosKeyName(i))
		end)
	end	
	GUI:Text_setString(self.ui.active_count_text,string.format("当前可激活次数:%s次",self.can_active_count or 0)) 
	self:flushRed((self.can_active_count or 0) > 0)
end

function WuShuangXueMaiOBJ:FlushRightInfo(key_name)
	local cfg = WuShuangXueMaiOBJ.cfg[key_name]
	GUI:setVisible(self.ui.select_info_box,true) 
	GUI:setVisible(self.ui.not_select_tip,false) 
	GUI:ItemShow_updateItem(self.ui.RightItemShow,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.talent_name), look = true, bgVisible = false, count = 1}) 
	if self.ui.DescRichText then
        GUI:removeFromParent(self.ui.DescRichText)
        self.ui = GUI:ui_delegate(self._parent)
    end
	local dest_text = GUI:RichTextFCOLOR_Create(self.ui["select_info_box"], "DescRichText", 5, 210, cfg.attr_desc, 236, 16, "#FFFFFF")
	GUI:setAnchorPoint(dest_text,0,1)
	GUI:Text_setString(self.ui.XueMaiName,cfg.talent_name)

end

function WuShuangXueMaiOBJ:flushView( ... )
	local param = {...}
	local tab = string.split(param[1],"|")
	if tab[1] == "flush_view" then
		self.active_list = SL:JsonDecode(tab[2])
		self.can_active_count = tonumber(tab[3])
		self:FlushInfo()
	elseif tab[1] == "chongxiu_flush" then
		self.active_list = SL:JsonDecode(tab[2])
		self.can_active_count = tonumber(tab[3])
		self:FlushInfo()
		self:FlushRightInfo(tonumber(tab[4]))
	end
end

function WuShuangXueMaiOBJ:GetPosKeyName(pos)
	return self.active_list[pos]
end

function WuShuangXueMaiOBJ:GetIsActive(key_name)
	return self.active_list[key_name] ~= nil
end

function WuShuangXueMaiOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.active_btn)
        end
    end
end
function WuShuangXueMaiOBJ:onClose( ... )
 	if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end
-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == WuShuangXueMaiOBJ.npcId then
        -- ViewMgr.open(WuShuangXueMaiOBJ.Name)
      	SendMsgCallFunByNpc(0, "WuShuangXueMai", "upEvent") 
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, WuShuangXueMaiOBJ.Name, onClickNpc)

return WuShuangXueMaiOBJ