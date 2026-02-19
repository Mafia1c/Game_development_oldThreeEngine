local DragonGodEquipOBJ = {}
DragonGodEquipOBJ.Name = "DragonGodEquipOBJ"
DragonGodEquipOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
DragonGodEquipOBJ.RunAction = true

function DragonGodEquipOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.key_index = 0
	self.active_list = {}
	--加载UI
	GUI:LoadExport(parent, "npc/DragonGodEquipUI")

	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(DragonGodEquipOBJ.Name)
	end)

end

return DragonGodEquipOBJ