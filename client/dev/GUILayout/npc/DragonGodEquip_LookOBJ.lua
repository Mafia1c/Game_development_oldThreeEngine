local DragonGodEquip_LookOBJ = {}
DragonGodEquip_LookOBJ.Name = "DragonGodEquip_LookOBJ"
DragonGodEquip_LookOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
DragonGodEquip_LookOBJ.RunAction = true
DragonGodEquip_LookOBJ.cfg = SL:Require("GUILayout/config/DarkMonarchCfg",true)

function DragonGodEquip_LookOBJ:main(sMsg)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.key_index = 0
	self.active_list = {}
	--加载UI
	GUI:LoadExport(parent, "npc/DragonGodEquipLoolUI")

	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(DragonGodEquip_LookOBJ.Name)
	end)
	self.equip_id_tab = SL:JsonDecode(sMsg)
	for i=1,5 do
 		local eq = SL:GetMetaValue("LOOKPLAYER_DATA_BY_MAKEINDEX", self.equip_id_tab[i])
        local setData  = {}
        setData.index = eq and eq.Index or 0
        setData.look  = true
        setData.bgVisible = true
        setData.count = 1
        setData.itemData = eq

	  	GUI:ItemShow_updateItem(self.ui["EquipShow_"..i], setData)
	end
end

return DragonGodEquip_LookOBJ