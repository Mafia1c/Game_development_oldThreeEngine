local luckEquipOBJ = {}
luckEquipOBJ.Name = "luckEquipOBJ"
luckEquipOBJ.index_ids = {104,105,106,107,108,109,110,111,112,113,114,115}
luckEquipOBJ.RunDrag = true

function luckEquipOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/luckEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initEvent()
    self:showEquipInfo()
end

function luckEquipOBJ:initEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
end

function luckEquipOBJ:showEquipInfo()
    for i = 1, 12 do
        removeOBJ(self.ui["item"..i],self)
        if SL:GetMetaValue("EQUIPBYPOS", self.index_ids[i]) == "" then
            goto continue
        end
        local setData  = {}
        setData.look  = true
        setData.bgVisible = false
        setData.doubleTakeOff = true
        local equip = GUI:EquipShow_Create(self.ui["equipBox"..i],"item"..i,38,38,self.index_ids[i],false,setData)
        GUI:setAnchorPoint(equip,0.5,0.5)
        GUI:EquipShow_setAutoUpdate(equip)
        ::continue::
    end
    for i = 1, 3 do
        GUI:UserUILayout(self.ui["equipNode"..i], {dir=2,addDir=2,interval=0.5,gap = {x=24},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end

end

return luckEquipOBJ