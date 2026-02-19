local SurpriseBoxBuyTipObj = {}
SurpriseBoxBuyTipObj.Name = "SurpriseBoxBuyTipObj"

---@param data table
function SurpriseBoxBuyTipObj:main(data)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/WelfareHall/SurpriseBoxBuyTipUI")
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.CloseBtn,function ()
        ViewMgr.close(SurpriseBoxBuyTipObj.Name) 
    end)
    SurpriseBoxBuyTipObj:flushView(data)
end

function SurpriseBoxBuyTipObj:flushView(data)
    local px = data.text_pox or 0
    local py = data.text_poy or 0
    local str = data.str or ""
    local width = data.str_width or 100
    local size = data.str_size or 16
    local color = data.str_color or "#ffffff"
    local vspace = data.vspace or 4
    if self.ui.rich_text then
        GUI:removeFromParent(self.ui.rich_text)
        self.ui = GUI:ui_delegate(self._parent)
    end
    local rich_text = GUI:RichText_Create(self.ui.bg,"rich_text",px,py,str,width,size,color,vspace)
    GUI:setAnchorPoint(rich_text, 0.5, 1)      -- 中 上
    local btn_data = data.btn_data or {}
    local image_list = btn_data.img_list or {}
    local str_list = btn_data.btn_str or {}
    local fun_list = btn_data.btnfun_list or {}
    btn_count = btn_data.btn_count or 0
    for i=1,btn_count do
        local btn = GUI:Button_Create(self.ui.btn_list,"btn"..i,100,0,image_list[i] or "res/custom/yeqian1.png")
        GUI:Button_setTitleText(btn,str_list[i] or "")
        GUI:Button_setTitleFontSize(btn,16)

        GUI:addOnClickEvent(btn,function ()
            if fun_list[i] then
                fun_list[i](i)
            else
                SL:Print("没有绑定按钮回调，关闭界面")
            end
        end)
    end
    GUI:UserUILayout(self.ui.btn_list, {
        dir=2,
        gap = {x=20},
        autosize = true,
    })
end


return SurpriseBoxBuyTipObj