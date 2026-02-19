local WuShuangActiveOBJ = {}

WuShuangActiveOBJ.Name = "WuShuangActiveOBJ"
WuShuangActiveOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
WuShuangActiveOBJ.cfg = SL:Require("GUILayout/config/WuShuangXueMaiCfg",true)

function WuShuangActiveOBJ:main(key_name)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
      --加载UI
    GUI:LoadExport(parent, "npc/WuShuangActiveUI")
    self.ui = GUI:ui_delegate(parent)

     --关闭按钮
    GUI:addOnClickEvent(self.ui.closeButton, function()
        ViewMgr.close(WuShuangActiveOBJ.Name)
    end)
    
    --灵符刷新
    GUI:addOnClickEvent(self.ui.runeReflushButton, function()
        SendMsgCallFunByNpc(0, "WuShuangXueMai", "flushKaiPai")
    end)
    self.select_key_name = key_name
    GUI:addOnClickEvent(self.ui.selectButton,function ()
        SendMsgCallFunByNpc(0, "WuShuangXueMai", "SlectActiveClick",self.select_key_name) 
    end) 
    WuShuangActiveOBJ:refreshShow(key_name)
end

function WuShuangActiveOBJ:flushView(key_name)
     self.select_key_name = key_name
     WuShuangActiveOBJ:refreshShow(key_name)
end

function WuShuangActiveOBJ:refreshShow(key_name)
    local cfg = WuShuangActiveOBJ.cfg[tonumber(key_name)]
    GUI:ItemShow_updateItem(self.ui.ItemShow,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.talent_name), look = true, bgVisible = false, count = 1 })
    GUI:Text_setString(self.ui.name,cfg.talent_name) 
end

return WuShuangActiveOBJ
