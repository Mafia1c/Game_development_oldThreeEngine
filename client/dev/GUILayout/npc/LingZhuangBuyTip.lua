local LingZhuangBuyTip = {}
LingZhuangBuyTip.Name = "LingZhuangBuyTip"
LingZhuangBuyTip.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
LingZhuangBuyTip.RunAction = true
function LingZhuangBuyTip:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/LingZhuangBuyTipUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.CloseBtn, function()
	  ViewMgr.close(LingZhuangBuyTip.Name)
	end)
	GUI:addOnClickEvent(self.ui.OneBtn,function ()
		SendMsgCallFunByNpc(0, "LingZhuangStrengthen","BuyGiftClick",1)
	end)

	GUI:addOnClickEvent(self.ui.TenBtn,function ()
		SendMsgCallFunByNpc(0, "LingZhuangStrengthen","BuyGiftClick",10)
	end) 
end



return LingZhuangBuyTip
