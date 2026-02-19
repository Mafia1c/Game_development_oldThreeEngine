local SiLingShengZuOBJ = {}
SiLingShengZuOBJ.Name = "SiLingShengZuOBJ"
SiLingShengZuOBJ.cfg = SL:Require("GUILayout/config/RuneWordsCfg",true)
SiLingShengZuOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
SiLingShengZuOBJ.npcId = 412

SiLingShengZuOBJ.RunAction = true

function SiLingShengZuOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.key_index = 0
	self.active_list = {}
	--加载UI
	GUI:LoadExport(parent, "npc/SiLingShengZuUI")

	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(SiLingShengZuOBJ.Name)
	end)

	GUI:addOnClickEvent(self.ui.active_btn, function()
		SendMsgCallFunByNpc(SiLingShengZuOBJ.npcId,"SiLingShengZu","ActiveClick")
	end)
 	SendMsgCallFunByNpc(SiLingShengZuOBJ.npcId,"SiLingShengZu","upEvent")
end

function SiLingShengZuOBJ:FlushInfo(is_active)
 	GUI:setVisible(self.ui.has_active,is_active)	
 	GUI:setVisible(self.ui.active_btn,not is_active)	
end

function SiLingShengZuOBJ:flushView(...)
	local tab = {...}
	self:FlushInfo(tonumber(tab[1]) > 0)
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == SiLingShengZuOBJ.npcId then
        ViewMgr.open(SiLingShengZuOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, SiLingShengZuOBJ.Name, onClickNpc)
return SiLingShengZuOBJ