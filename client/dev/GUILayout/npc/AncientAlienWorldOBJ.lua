local AncientAlienWorldOBJ = {}
AncientAlienWorldOBJ.Name = "AncientAlienWorldOBJ"
AncientAlienWorldOBJ.cfg = SL:Require("GUILayout/config/AncientAlienWorldCfg",true)
AncientAlienWorldOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
AncientAlienWorldOBJ.npcId = 385
AncientAlienWorldOBJ.RunAction = true
AncientAlienWorldOBJ.HideMain = true            -- 打开时隐藏主界面

function AncientAlienWorldOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/AncientAlienWorldUI")
	self.ui = GUI:ui_delegate(parent)

	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(AncientAlienWorldOBJ.Name)
	end)

	for i=1,5 do
		GUI:addOnClickEvent(self.ui["btn_cell_"..i],function ()
			SendMsgCallFunByNpc(AncientAlienWorldOBJ.npcId,"AncientAlienWorld","OpenCellInfoView",i) 		
		end)
	end

end

function AncientAlienWorldOBJ:onClose()
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == AncientAlienWorldOBJ.npcId then
        ViewMgr.open(AncientAlienWorldOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, AncientAlienWorldOBJ.Name, onClickNpc)

return AncientAlienWorldOBJ