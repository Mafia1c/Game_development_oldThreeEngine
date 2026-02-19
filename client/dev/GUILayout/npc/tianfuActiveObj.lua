local tianfuActiveObj = {}

tianfuActiveObj.Name = "tianfuActiveObj"
tianfuActiveObj.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
tianfuActiveObj.cfg = SL:Require("GUILayout/config/talentCfg",true)

function tianfuActiveObj:main(selected)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
      --加载UI
    GUI:LoadExport(parent, "npc/tianfuActiveUI")
    self.ui = GUI:ui_delegate(parent)
     --关闭按钮
    GUI:addOnClickEvent(self.ui.closeButton, function()
        ViewMgr.close(tianfuActiveObj.Name)
    end)
    --书页刷新
    GUI:addOnClickEvent(self.ui.bookReflushButton, function()
        SendMsgCallFunByNpc(0, "xuemai", "flushKaiPai","书页|天赋")
    end)
    --灵符刷新
    GUI:addOnClickEvent(self.ui.runeReflushButton, function()
        SendMsgCallFunByNpc(0, "xuemai", "flushKaiPai","灵符|天赋")
    end)
    self.ui.text_list = {}
    tianfuActiveObj:refreshShow(SL:JsonDecode(selected))
end

function tianfuActiveObj:flushView( ... )
    local tab = {...}
    local data = SL:JsonDecode(tab[1])
    tianfuActiveObj:refreshShow(data)
end

function tianfuActiveObj:refreshShow(selected)
    for k,v in pairs(self.ui.text_list) do
        if v then
            GUI:removeFromParent(v)
        end
    end
    self.ui.text_list = {}
	for k,v in pairs(selected) do
		local data = tianfuActiveObj.cfg[v]
		GUI:Image_loadTexture(self.ui["kaipai"..k],"res/custom/npc/23xm/type_"..data.talent_type..".png" )
		GUI:ItemShow_updateItem(self.ui["ItemShow_"..k], {index = data.key_name,count = 0,bgVisible = false,look = true})
        table.insert(self.ui.text_list, GUI:RichTextFCOLOR_Create(self.ui["kaipai"..k], "item_name"..k, 67, 199, string.format("<%s/FCOLOR=%s>",data.talent_name,data.tanlebt_color) , 100, 16, "#fffff")) 
		GUI:addOnClickEvent(self.ui["selectButton"..k],function ()
			SendMsgCallFunByNpc(0, "xuemai", "setTianFuInfo",v)
			ViewMgr.close(tianfuActiveObj.Name)
		end) 
	end
end

return tianfuActiveObj
