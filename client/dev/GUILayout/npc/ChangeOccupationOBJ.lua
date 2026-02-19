local ChangeOccupationOBJ = {}
ChangeOccupationOBJ.Name = "ChangeOccupationOBJ"
ChangeOccupationOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
ChangeOccupationOBJ.npcId = 309
ChangeOccupationOBJ.RunAction = true
ChangeOccupationOBJ.job_enum ={"战士","法师","道士"}
function ChangeOccupationOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.key_index = 0
	--加载UI
	GUI:LoadExport(parent, "npc/ChangeOccupationUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeButton, function()
	  ViewMgr.close(ChangeOccupationOBJ.Name)
	end)

	SL:OpenCommonTipsPop({str = "必须阅读：点击转职操作不可逆，请仔细阅读转职规则！",btnType =1 })
	GUI:Text_setString(self.ui.currentOccupationText,SL:GetMetaValue("JOB_NAME")) 
	GUI:Text_setString(self.ui.change_expend,SL:GetMetaValue("LEVEL")>= 60 and "非绑灵符x588" or "60级前免费转职") 
	for i=0,2 do
		GUI:addOnClickEvent(self.ui["changeOccupationBtn"..i+1],function ()
			local job = SL:GetMetaValue("JOB")
			if i == job then
				return SL:ShowSystemTips("您现在的职业是【"..SL:GetMetaValue("JOB_NAME").."】无需转职！")
			end
			local data = {}
			if SL:GetMetaValue("LEVEL") >= 60 then
				data.str = "您确定要转职成为【"..ChangeOccupationOBJ.job_enum[i+1].."】吗？\n转职成功需扣除非绑灵符x588\n说明：该操作不可逆，请谨慎操作！"
			else
				data.str = "您确定要转职成为【"..ChangeOccupationOBJ.job_enum[i+1].."】吗？\n60级前免费转职\n说明：该操作不可逆，请谨慎操作！"
			end
			data.btnType = 2
			data.callback = function(atype, param)
		        if atype == 1 then
		         	SendMsgCallFunByNpc(ChangeOccupationOBJ.npcId, "ChangeOccupation","upEvent",i)
		        end
		    end
			SL:OpenCommonTipsPop(data)
		end)
	end
end

function ChangeOccupationOBJ:flushView(...)
	local param = {...}
	local tab = string.split(param[1],"|")
	if tab[1] == "quitgame" then
		local data = {}
		data.str = "恭喜你成功转职成为【"..ChangeOccupationOBJ.job_enum[tonumber(tab[2]+1)] .."】\n需小退重新登陆游戏！"
		data.btnType = 2
		data.callback = function(atype, param)
			SL:JumpTo(34)
	    end
		SL:OpenCommonTipsPop(data)
		local index = 1
		local function showTime()
	        if index > 4 then
	        	SL:JumpTo(34)
	        end
	        index = index + 1
	    end
		SL:ScheduleOnce(showTime, 1)
	end
end

-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == ChangeOccupationOBJ.npcId then
    	if (GameData.GetData("HeFuCount",false) or 0) > 0 then
        	ViewMgr.open(ChangeOccupationOBJ.Name)
    	else
    		SL:ShowSystemTips("转职功能合区后开放")
    	end
    end
end

SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, ChangeOccupationOBJ.Name, onClickNpc)

return ChangeOccupationOBJ