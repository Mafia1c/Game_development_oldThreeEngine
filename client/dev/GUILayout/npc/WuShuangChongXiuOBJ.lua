local WuShuangChongXiuOBJ = {}

WuShuangChongXiuOBJ.Name = "WuShuangChongXiuOBJ"
WuShuangChongXiuOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
WuShuangChongXiuOBJ.cfg = SL:Require("GUILayout/config/WuShuangXueMaiCfg",true)

function WuShuangChongXiuOBJ:main(pos,key_name)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
      --加载UI
    GUI:LoadExport(parent, "npc/WuShuangChongXiuUI")
    self.ui = GUI:ui_delegate(parent)

    self.select_key_name = key_name

     --关闭按钮
    GUI:addOnClickEvent(self.ui.closeButton, function()
        ViewMgr.close(WuShuangChongXiuOBJ.Name)
    end)
    local is_click_ok  = false
    --灵符刷新
    GUI:addOnClickEvent(self.ui.runeRebuildButton, function()
        local data = {}
        data.str = "刷新后不选择将会失去刷新记录,是否确定重修?\n本次刷新费用：灵符x500"
        data.btnType = 2
        data.callback = function(atype)
            if atype == 1 then --确定
                is_click_ok = true
                SendMsgCallFunByNpc(0, "WuShuangXueMai", "ChongXiuFlush")
            end
        end
        if is_click_ok then
            SendMsgCallFunByNpc(0, "WuShuangXueMai", "ChongXiuFlush")
        else
            SL:OpenCommonTipsPop(data)    
        end
    end)

    GUI:addOnClickEvent(self.ui.SelectBtn,function ()
        SendMsgCallFunByNpc(0, "WuShuangXueMai", "ChongXiuSetInfo",pos .."#".. self.select_key_name)
    end)

    WuShuangChongXiuOBJ:FlushInfo(key_name,false)
end

function WuShuangChongXiuOBJ:flushView(key_name)
    self.select_key_name = key_name
    WuShuangChongXiuOBJ:FlushInfo(key_name,true)
end

function WuShuangChongXiuOBJ:FlushInfo(key_name,is_flush)
    local cfg = WuShuangChongXiuOBJ.cfg[tonumber(key_name)]
    GUI:ItemShow_updateItem(self.ui.cxItem,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.talent_name), look = true, bgVisible = false, count = 1 })
    GUI:setVisible(self.ui.SelectBtn,is_flush) 
    GUI:Text_setString(self.ui.name,cfg.talent_name) 
end

return WuShuangChongXiuOBJ
