local WoLongBzTipsOBJ = {}
WoLongBzTipsOBJ.Name = "WoLongBzTipsOBJ"
WoLongBzTipsOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移

function WoLongBzTipsOBJ:main(params)
	self.params = params
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/WoLongBaoZangTipUi")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.CloseBtn, function()
	  ViewMgr.close(WoLongBzTipsOBJ.Name)
	end)
	GUI:addOnClickEvent(self.ui.close_btn, function()
	  ViewMgr.close(WoLongBzTipsOBJ.Name)
	end)
	
	for i=1,2 do
		GUI:addOnClickEvent(self.ui["Button_"..i], function()
			if params.callback then
				params.callback(i)
				return 
			end
			ViewMgr.close(WoLongBzTipsOBJ.Name)
		end)
	end

	WoLongBzTipsOBJ:FlushShow()
end

function WoLongBzTipsOBJ:flushView( ... )
	local tab =  {...}
	if self.params ~= nil then
		self.params.str = tab[1]
		WoLongBzTipsOBJ:FlushShow()
	end
end

function WoLongBzTipsOBJ:FlushShow()
	if type(self.params.str) == "string" then
		local str_list = string.split(self.params.str,"|")
		for i,v in ipairs(str_list) do
			if self.ui["text"..i] then
		        GUI:removeFromParent(self.ui["text"..i])
		        
		    end
			local desc_list = string.split(v,"#")
			local color = desc_list[2] and desc_list[2] or "ffffff"
			local text = GUI:Text_Create(self.ui.Panel,"text"..i,0,i,18,"#ffffff",desc_list[1])
			GUI:Text_setTextColor(text,"#"..color)
			GUI:Text_setTextHorizontalAlignment(text,1)
		end
	end
	self.ui = GUI:ui_delegate(self._parent)

	GUI:UserUILayout(self.ui.Panel, {
        dir=1,
        addDir=1,
        gap = self.params.list_gap or nil
    })

	if self.params.btnstr then
		if self.params.btnstr[1] then
			GUI:Button_setTitleText(self.ui.Button_1,self.params.btnstr[1])
		end
		if self.params.btnstr[2] then
			GUI:Button_setTitleText(self.ui.Button_2,self.params.btnstr[2])
		end
	end
end

return WoLongBzTipsOBJ