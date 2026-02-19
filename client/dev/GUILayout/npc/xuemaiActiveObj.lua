local xuemaiActiveObj = {}

xuemaiActiveObj.Name = "xuemaiActiveObj"
xuemaiActiveObj.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
xuemaiActiveObj.cfg = SL:Require("GUILayout/config/talentCfg",true)

function xuemaiActiveObj:main(selected)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    self.item_name_obj = nil
      --加载UI
    GUI:LoadExport(parent, "npc/xuemaiActiveUI")
    self.ui = GUI:ui_delegate(parent)
     --关闭按钮
    GUI:addOnClickEvent(self.ui.closeButton, function()
        ViewMgr.close(xuemaiActiveObj.Name)
    end)
    --书页刷新
    GUI:addOnClickEvent(self.ui.bookReflushButton, function()
        SendMsgCallFunByNpc(0, "xuemai", "flushKaiPai","书页|血脉")
    end)
    --灵符刷新
    GUI:addOnClickEvent(self.ui.runeReflushButton, function()
        SendMsgCallFunByNpc(0, "xuemai", "flushKaiPai","灵符|血脉")
    end)
    xuemaiActiveObj:refreshShow(SL:JsonDecode(selected))
end

function xuemaiActiveObj:flushView( ... )
    local tab = {...}
    local data = SL:JsonDecode(tab[1])
    xuemaiActiveObj:refreshShow(data)
end

function xuemaiActiveObj:refreshShow(selected)
    if  self.item_name_obj then
        GUI:removeFromParent(self.item_name_obj)
        self.item_name_obj = nil
    end
	for k,v in pairs(selected) do
		local data = xuemaiActiveObj.cfg[v]
		GUI:Image_loadTexture(self.ui["kaipai"],"res/custom/npc/23xm/type_"..data.talent_type..".png" )
		GUI:ItemShow_updateItem(self.ui["ItemShow"], {index = data.key_name,count = 0,bgVisible = false,look = true})
        self.item_name_obj = GUI:RichTextFCOLOR_Create(self.ui["kaipai"], "item_name", 67, 199, string.format("<%s/FCOLOR=%s>",data.talent_name,data.tanlebt_color) , 100, 16, "#fffff")
		GUI:addOnClickEvent(self.ui["selectButton"],function ()
			SendMsgCallFunByNpc(0, "xuemai", "setXueMaiInfo",v)
			ViewMgr.close(xuemaiActiveObj.Name)
		end) 
	end
end

return xuemaiActiveObj
