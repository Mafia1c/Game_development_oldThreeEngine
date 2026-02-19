local EverydayRechargeOBJ = {}
EverydayRechargeOBJ.Name = "EverydayRechargeOBJ"
EverydayRechargeOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
EverydayRechargeOBJ.cfg = {{"秘宝礼盒",1},{"书页",100},{"灵符",180},{"上品聚灵珠",5},{"五倍秘境卷轴",1},{"金刚石",888}}
function EverydayRechargeOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	--加载UI
	GUI:LoadExport(parent, "npc/EverydayRechargeUI")
	self.ui = GUI:ui_delegate(parent)

	GUI:addOnClickEvent(self.ui.closeBtn,function ()
		ViewMgr.close(EverydayRechargeOBJ.Name)
	end)

	GUI:addOnClickEvent(self.ui.getBtn,function ()
		SendMsgCallFunByNpc(0,"EverydayRecharge","BuyEverydayRecharge")	
	end)

	for i,v in ipairs(self.cfg) do
		local item = GUI:ItemShow_Create(self.ui.award_list_view,"item"..i,(i-1) * 60 + 35,40,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", v[1]),look=true,bgVisible=true,count=v[2],color=255})
		GUI:setAnchorPoint(item,0.5,0.5)
		ItemShow_updateItem(item,{showCount = true,count = v[2],look=true,bgVisible=true,color=255})
	end
	self:flushInfo()
end

function EverydayRechargeOBJ:flushInfo()
	local buy_state = GameData.GetData("J_everyday_recharge",false) or 0
    GUI:setVisible(self.ui.getBtn,buy_state <= 0) 
	GUI:setVisible(self.ui.iconTag,buy_state > 0) 
end

function EverydayRechargeOBJ:flushView( ... )
	local tab={...}
	if tab[1] == "充值刷新" then
		self:flushInfo()
	end
end

return EverydayRechargeOBJ