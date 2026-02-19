local WelfareStrTipObj = {}
WelfareStrTipObj.Name = "WelfareStrTipObj"
WelfareStrTipObj.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
WelfareStrTipObj.RunAction = true

function WelfareStrTipObj:main(data)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	GUI:LoadExport(parent, "npc/WelfareHall/WelfareStrTipUI")
	self.ui = GUI:ui_delegate(parent)
	for i=1,2 do
		GUI:Button_setTitleText(self.ui["btn"..i],data.btnDesc[i]) 
		GUI:addOnClickEvent(self.ui["btn"..i],function ()
			data.callback(i)
			ViewMgr.close(WelfareStrTipObj.Name)
		end)
	end
	GUI:Text_setString(self.ui.str_text,data.str) 
	GUI:addOnClickEvent(self.ui.CloseLayout,function ()
		ViewMgr.close(WelfareStrTipObj.Name)
	end)
	GUI:addOnClickEvent(self.ui.close_btn,function ()
		ViewMgr.close(WelfareStrTipObj.Name)
	end)
end
return WelfareStrTipObj
