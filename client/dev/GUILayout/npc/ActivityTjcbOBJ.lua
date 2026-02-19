local ActivityTjcbOBJ = {}
ActivityTjcbOBJ.Name = "ActivityTjcbOBJ"

function ActivityTjcbOBJ:main(wave_num, time1,time2,time3)
	local tab = {time1,time2,time3}
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	--加载UI
	GUI:LoadExport(parent, "npc/ActivityTjcbUI")
	self.ui = GUI:ui_delegate(parent)
	local layout = ssr.Layout:create()
	GUI:setAnchorPoint(layout, 0.5, 1)
	GUI:setPosition(layout, 100,170)
	local showText = GUI:Text_Create(layout,"active_title",0,0,18,"#ff9b00","《天降财宝活动介绍》") 
	GUI:setAnchorPoint(showText, 0.5, 1)  
	local desc1 = GUI:Text_Create(layout,"active_desc1",0,-30,18,"#00ff00","每次活动持续十分钟")
	GUI:setAnchorPoint(desc1 , 0.5, 1)  
	local desc2 = GUI:Text_Create(layout,"active_desc2",0,-60,18,"#00ff00","每次活动发放3波奖励") 
	GUI:setAnchorPoint(desc2, 0.5, 1) 
	local desc3 = GUI:Text_Create(layout,"active_desc3",0,-90,18,"#ffff00",string.format("当前发放：第%s波",wave_num) ) 
	GUI:setAnchorPoint(desc3, 0.5, 1) 
	local str = "下拨倒计时："
	if tonumber(wave_num) > 2 then
	 	str = "结束倒计时："
	end
	local desc4 = GUI:Text_Create(layout,"active_desc4",-32,-120,18,"#ffff00",str) 
	GUI:setAnchorPoint(desc4, 0.5, 1) 
	local desc5 = GUI:Text_Create(layout,"active_desc5",57,-120,18,"#ffff00",time) 
	GUI:setAnchorPoint(desc5, 0.5, 1) 
	-- SL:Print(time1,time2,time3)
	local countdown_time = 0
	local index = 1
	if tonumber(time1) > 0 then
		index = 1
	elseif tonumber(time2) > 0 then
		index = 2
	elseif tonumber(time3) > 0 then
		index = 3
	else
		index = 4
	end
	self:FlushCountdown(desc5,tab,index,desc3)
  	ssr.AttachOrUnAttachSUI({index = 110, subid = 222, content = layout})  -- 添加到任务面板
end

function ActivityTjcbOBJ:FlushCountdown(desc,tab,index,wave_desc)
	if index > 3 then
		GUI:Text_setString(wave_desc,"当前发放：第3波")
		GUI:Text_setString(desc,"00:00:00")
		return 
	end
	GUI:Text_COUNTDOWN(desc, tonumber(tab[index]), function()
		self:FlushCountdown(desc,tab,index+1,wave_desc)
		if index +1 > 3 then
			GUI:Text_setString(wave_desc,"当前发放：第3波")
		else
			GUI:Text_setString(wave_desc,string.format("当前发放：第%s波",index + 1) )
		end
	end,1)
end

function ActivityTjcbOBJ:onClose( ... )
	ssr.AttachOrUnAttachSUI({index = 110, subid = 222, type = 1}) 
end

return  ActivityTjcbOBJ
