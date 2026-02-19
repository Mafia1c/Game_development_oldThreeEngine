local FristEquipTipObj = {}
FristEquipTipObj.Name = "FristEquipTipObj"

function FristEquipTipObj:main(index,equipName)
    local ui_path = "npc/WelfareHall/FristEquipTipUI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, ui_path, function () end)
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close(FristEquipTipObj.Name)
    end)
    GUI:ItemShow_updateItem(self.ui.equip_item,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", equipName),count = 1,bgVisible = true,look = true})
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/tc/bg".. index ..".png")
    GUI:Image_loadTexture(self.ui.title_img,"res/custom/tc/icon".. index ..".png")
    GUI:Text_setString(self.ui.equip_name,equipName)
    GUI:Text_COUNTDOWN(self.ui.close_time, 5,function ( )
        ViewMgr.close(FristEquipTipObj.Name)
    end)
end
return FristEquipTipObj