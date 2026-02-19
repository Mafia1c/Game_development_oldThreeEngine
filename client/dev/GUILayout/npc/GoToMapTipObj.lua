local GoToMapTipObj = {}
GoToMapTipObj.Name = "GoToMapTipObj"
local imag_path = {
	[329] = "res/custom/npc/79wldt/tc1.png",
	[328] = "res/custom/npc/79wldt/tc2.png"
}
function GoToMapTipObj:main(npc_id)
    local id = tonumber(npc_id)
    local ui_path = "npc/GoToMapTipUI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, ui_path, function () end)
    self.ui = GUI:ui_delegate(parent)
    
    GUI:addOnClickEvent(self.ui.CloseLayout,function ()
    	ViewMgr.close(GoToMapTipObj.Name)
    end)
    GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close(GoToMapTipObj.Name)
    end)

    GUI:addOnClickEvent(self.ui.enter_btn,function ()
	    local sMsg = id ..""
	    SendMsgCallFunByNpc(id, "GoToMapNpc", "GotoMap4", sMsg)
	   	ViewMgr.close(GoToMapTipObj.Name)
    end)
    GUI:Image_loadTexture(self.ui.FrameBG,imag_path[id]) 
end
return GoToMapTipObj