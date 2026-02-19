local CdkGiftObj = {}
CdkGiftObj.Name = "CdkGiftObj"
CdkGiftObj.Cfg = SL:Require("GUILayout/config/cdk_cfg",true)

function CdkGiftObj:main(ui,cfg,node)
    self.ui = ui
    self.node = node
    GUI:addOnClickEvent(self.ui.get_btn,function ()
    	local str = GUI:TextInput_getString(self.ui.TextInput)
    	SendMsgCallFunByNpc(0,"WelfareHall","GetCdkAward",str)
    end)
end
return CdkGiftObj