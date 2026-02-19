local luckEquip_LookOBJ = {}
luckEquip_LookOBJ.Name = "luckEquip_LookOBJ"
luckEquip_LookOBJ.RunDrag = true

function luckEquip_LookOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/luckEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.equip_id_tab = SL:JsonDecode(sMsg)

    self:initEvent()
    self:showEquipInfo()
end

function luckEquip_LookOBJ:initEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
end

function luckEquip_LookOBJ:showEquipInfo()
    for i = 1, 12 do
        removeOBJ(self.ui["item"..i],self)
        if self.equip_id_tab[i] == 0 then
            goto continue
        end
        local eq = SL:GetMetaValue("LOOKPLAYER_DATA_BY_MAKEINDEX", self.equip_id_tab[i])
        local setData  = {}
        setData.index = eq and eq.Index or 0
        setData.look  = true
        setData.bgVisible = false
        setData.count = 1
        local item = GUI:ItemShow_Create(self.ui["equipBox"..i],"item"..i,38,38,setData)
        GUI:setAnchorPoint(item,0.5,0.5)
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

return luckEquip_LookOBJ