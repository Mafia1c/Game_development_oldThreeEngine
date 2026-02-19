local CommonAwardView = {}
CommonAwardView.Name = "CommonAwardView"
CommonAwardView.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
CommonAwardView.RunAction = true

function CommonAwardView:main(params)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.queue_list = {}
	self.time = 1
	GUI:LoadExport(parent, "npc/common/commonAwardTipUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.close_btn, function()
		if #self.queue_list <= 0 then
    		GUI:unSchedule(self.ui.closeText)
    		self.time = 1
    		ViewMgr.close(CommonAwardView.Name)
    	else
    		self.time = 0
    		GUI:Text_setString(self.ui.closeText,"4秒后自动关闭")
    		CommonAwardView:flushItemList(table.remove(self.queue_list, 1))
    	end
	end)
	local award_list = SL:JsonDecode(params)
	CommonAwardView:flushItemList(award_list)
	GUI:Text_setString(self.ui.closeText,"4秒后自动关闭")
	local queue_index = 1
  
    local function showTime()
    	if self.time >= 4 then
    		if #self.queue_list <= 0 then
    			GUI:unSchedule(self.ui.closeText)
	    		self.time = 1
	    		ViewMgr.close(CommonAwardView.Name)
	    	else
    			GUI:Text_setString(self.ui.closeText,"4秒后自动关闭")
	    		self.time = 0
	    		CommonAwardView:flushItemList(table.remove(self.queue_list, 1))
	    	end
    	end
    	GUI:Text_setString(self.ui.closeText,4 - self.time .."秒后自动关闭")
    	self.time = self.time + 1
    end
    GUI:schedule(self.ui.closeText, showTime, 1)
end

function CommonAwardView:flushItemList(item_list)
	GUI:removeAllChildren(self.ui.awardList)
	local show_type = 2
	if #item_list > 6 then
		show_type = 3
	end
	for k,v in pairs(item_list) do
		local item_cell = GUI:ItemShow_Create(self.ui.awardList,"awarad_"..k,0,0,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v.name),count = v.count,bgVisible = true,look = true})
		GUI:setAnchorPoint(item_cell,0.5,0.5)
		ItemShow_updateItem(item_cell,{showCount = true,count = v.count,bgVisible = true,look = true,color = 255})
	end
	if SL:GetMetaValue("WINPLAYMODE") then
		GUI:UserUILayout(self.ui.awardList, {
	        dir= show_type or 2,
	        addDir= show_type == 3 and 1 or 2,
	        gap = {x = 30,y=20,l = 75},
	        interval = 0.05,
	        colnum = 6,
	    })
	else
		GUI:UserUILayout(self.ui.awardList, {
	        dir= show_type or 2,
	        addDir= show_type == 3 and 1 or 2,
	        gap = {l = 75},
	        interval = 0.05,
	        colnum = 6,
	    })
	end

    if show_type == 3 then
    	local count =  math.ceil(#item_list/6) 
    	GUI:ScrollView_scrollToBottom(self.ui.awardList, count, false)
    end
end

function CommonAwardView:flushView(params)
	local data = SL:JsonDecode(params)
	if #data.award_list > 0 then
		table.insert(self.queue_list, data.award_list )
	end
end

function CommonAwardView:onClose()

end

return CommonAwardView