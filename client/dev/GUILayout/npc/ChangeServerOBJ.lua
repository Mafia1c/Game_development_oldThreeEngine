local ChangeServerOBJ = {}
ChangeServerOBJ.Name = "ChangeServerOBJ"
ChangeServerOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
ChangeServerOBJ.npcId = 246
ChangeServerOBJ.RunAction = true

function ChangeServerOBJ:main(zhuanqu_data)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/ChangeServerUI")
	self.ui = GUI:ui_delegate(parent)

	self.money = tonumber(GameData.GetData("U_recharge",true)) or 0
	zhuanqu_data = SL:JsonDecode(zhuanqu_data) or {}
	self.can_get_all_num = zhuanqu_data.can_get_all_num or 0
	self.already_get_num = zhuanqu_data.already_get_num or 0
	self.new_can_get_num = 0
	self.wait_get_num = 0
	if self.can_get_all_num > 0 then
		self.new_can_get_num = self.money > self.can_get_all_num and self.can_get_all_num - self.already_get_num or self.money - self.already_get_num
		self.wait_get_num = self.money > self.can_get_all_num and 0 or self.can_get_all_num - self.money 
	end

	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeButton, function()
	  ViewMgr.close(ChangeServerOBJ.Name)
	end)

	--转区
	GUI:addOnClickEvent(self.ui.recharge_btn, function()
		SendMsgCallFunByNpc(ChangeServerOBJ.npcId, "ChangeServer","OnClickRechargeBtn")
	  	-- SL:ExitToLoginUI()
	end)

	--领取
	GUI:addOnClickEvent(self.ui.get_btn, function()
		if self.money <= 200 then
			return SL:ShowSystemTips("最低200起领！")
		end
		if self.new_can_get_num <= 0 then
			return SL:ShowSystemTips("没有可领取的转区金额！")
		end
		local data = {}
	    data.str = "请输入转区金额"
	    data.btnType = 2
	    data.showEdit = true
	    data.callback = function(atype, param)
	        if atype == 1 then
	            if param and param.editStr and string.len(param.editStr) > 0 then
  					SendMsgCallFunByNpc(ChangeServerOBJ.npcId, "ChangeServer","OnClickGetBtn",param.editStr)
	            end
	        end
	    end
	    SL:OpenCommonTipsPop(data)
	end)

	local data = {}
	data.str = "[提醒]：自助转区成功以后角色立即封禁，请慎重操作\n[提醒]：不想转区的玩家请勿操作，立即退出当前NPC\n[提醒]：角色转区只能转当前账号！\n[提醒]：本功能仅限当前已开新区使用！"
	data.btnType = 1
	SL:OpenCommonTipsPop(data)
	
	GUI:Text_setString(self.ui.can_change_quantity,self.money)
	GUI:Text_setString(self.ui.can_get_quantity,self.new_can_get_num .. "元")
	GUI:Text_setString(self.ui.residue_quantity,self.wait_get_num .. "元")
end

function ChangeServerOBJ:flushView(...)
	local tab = {...}
	if tab[1] == "zhuanqu_data" then
		zhuanqu_data = SL:JsonDecode(tab[2]) or {}
		self.can_get_all_num = zhuanqu_data.can_get_all_num or 0
		self.already_get_num = zhuanqu_data.already_get_num or 0
		self.new_can_get_num = 0
		self.wait_get_num = 0

		if self.can_get_all_num > 0 then
			self.new_can_get_num = self.money > self.can_get_all_num and self.can_get_all_num - self.already_get_num or self.money - self.already_get_num
			self.wait_get_num = self.money > self.can_get_all_num and 0 or self.can_get_all_num - self.money 
		end

		GUI:Text_setString(self.ui.can_change_quantity,self.money)
		GUI:Text_setString(self.ui.can_get_quantity,self.new_can_get_num .. "元")
		GUI:Text_setString(self.ui.residue_quantity,self.wait_get_num .. "元")
	end
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == ChangeServerOBJ.npcId then
        -- ViewMgr.open(ChangeServerOBJ.Name)
        SendMsgCallFunByNpc(ChangeServerOBJ.npcId,"ChangeServer","upEvent")
    end
end

SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, ChangeServerOBJ.Name, onClickNpc)

return ChangeServerOBJ