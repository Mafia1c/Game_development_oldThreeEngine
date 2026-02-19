local ActivityLdzwOBJ = {}
ActivityLdzwOBJ.Name = "ActivityLdzwOBJ"

function ActivityLdzwOBJ:main(...)
	
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	--加载UI
	GUI:LoadExport(parent, "npc/ActivityTjcbUI")
	self.ui = GUI:ui_delegate(parent)

	local tab = {...}
	local list = SL:JsonDecode(tab[1]) or {}
	local time = tonumber(tab[2]) 
	local layout = ssr.Layout:create()
	GUI:setAnchorPoint(layout, 0.5, 1)
	GUI:setPosition(layout, 100,170)
	local showText = GUI:Text_Create(layout,"ldzw_title",0,10,16,"#ff9b00","《乱斗之王》") 
	GUI:setAnchorPoint(showText, 0.5, 1)  
	local desc1 = GUI:Text_Create(layout,"ldzw_desc1",0,-15,16,"#00ff00","每次活动共持续15分钟")
	GUI:setAnchorPoint(desc1 , 0.5, 1)  

	for i=1,3 do
		local rank_desc = list[i] and "玩家：".. list[i].name .."	生存值：".. list[i].value or "玩家：暂未玩家上榜	生存值：0"
		local rank_img = GUI:Image_Create(layout,"rank"..i,-100,-(65 + (i - 1) * 30) ,"res/private/rank_ui/rank_ui_mobile/19000200"..24+i..".png")
		local desc = GUI:ScrollText_Create(rank_img,"rank_desc"..i,35,18,160,16,"#E110CB",rank_desc,5) 
		GUI:setAnchorPoint(desc, 0, 0.5) 	
	end

	local desc5 = GUI:Text_Create(layout,"ldzw_desc5",0,-120,16,"#00ff00","我的生存值："..SL:GetMetaValue("MONEY", 22))
	GUI:setAnchorPoint(desc5, 0.5, 1) 

	local desc7 = GUI:Text_Create(layout,"ldzw_desc7",-30,-145,16,"#ffff00","结束时间：")
	GUI:setAnchorPoint(desc7, 0.5, 1) 

	local desc6 = GUI:Text_Create(layout,"ldzw_desc6",40,-145,16,"#ffff00","结束时间：00:00:00")
	GUI:setAnchorPoint(desc6, 0.5, 1) 
	GUI:Text_COUNTDOWN(desc6, tonumber(time), function ()

	end,1)
  	ssr.AttachOrUnAttachSUI({index = 110, subid = 223, content = layout})  -- 添加到任务面板
end

function ActivityLdzwOBJ:flushView(rank_list)
	local list = SL:JsonDecode(rank_list) or {}
	self.task_ui = GUI:ui_delegate(GUI:Win_FindParent(110))
	if self.task_ui then
		for i=1,3 do
			local rank_desc = list[i] and "玩家：".. list[i].name .."	生存值：".. list[i].value or "玩家：暂未玩家上榜	生存值：0"
		 	GUI:ScrollText_setString(self.task_ui["rank_desc"..i],rank_desc)
		end
		GUI:Text_setString(self.task_ui["ldzw_desc5"],"我的生存值："..SL:GetMetaValue("MONEY", 22))
	end 
end

function ActivityLdzwOBJ:onClose( ... )
	ssr.AttachOrUnAttachSUI({index = 110, subid = 223, type = 1}) 
end

return  ActivityLdzwOBJ
