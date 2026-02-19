local magicRingEquip_LookOBJ = {}
magicRingEquip_LookOBJ.Name = "magicRingEquip_LookOBJ"
magicRingEquip_LookOBJ.RunDrag = true

function magicRingEquip_LookOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/magicRingEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.equip_id_tab = SL:JsonDecode(sMsg)

    self:initEvent()
    self:showEquipInfo()
end

function magicRingEquip_LookOBJ:initEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
end

function magicRingEquip_LookOBJ:showEquipInfo()
    for i = 1, 4 do
        if self.equip_id_tab[i] == 0 then
            goto continue
        end
        local eq = SL:GetMetaValue("LOOKPLAYER_DATA_BY_MAKEINDEX", self.equip_id_tab[i])
        local setData  = {}
        setData.index = eq and eq.Index or 0
        setData.look  = true
        setData.bgVisible = true
        setData.count = 1
        local item = GUI:ItemShow_Create(self.ui["itemNode"..i],"item"..i,0,0,setData)
        GUI:setAnchorPoint(item,0.5,0.5)
        -- GUI:UserUILayout(self.ui["itemNode"..i], {dir=1,addDir=2,interval=0.5,gap = {y=10},})
        ::continue::
    end
    GUI:runAction(self.ui.itemNode1,GUI:ActionSequence(GUI:DelayTime(0.01),GUI:CallFunc(function()
        GUI:runAction(self.ui.itemNode1,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.2,123,287)))
    end),GUI:DelayTime(0.1),GUI:CallFunc(function()
        GUI:runAction(self.ui.itemNode3,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.2,123,112)))
    end),GUI:DelayTime(0.1),GUI:CallFunc(function()
        GUI:runAction(self.ui.itemNode4,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.2,304,112)))
    end),GUI:DelayTime(0.1),GUI:CallFunc(function()
        GUI:runAction(self.ui.itemNode2,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.2,304,287)))
    end)
    ))
end

return magicRingEquip_LookOBJ