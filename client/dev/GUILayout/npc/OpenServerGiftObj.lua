local OpenServerGiftObj = {}
OpenServerGiftObj.Name = "OpenServerGiftObj"
OpenServerGiftObj.cfg = SL:Require("GUILayout/config/OpenServerGiftCfg",true)

function OpenServerGiftObj:main(is_buy)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    --加载UI
    GUI:LoadExport(parent, "npc/OpenServerGiftUI")
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.close_btn,function ()
        ViewMgr.close(OpenServerGiftObj.Name)
    end) 
    GUI:addOnClickEvent(self.ui.op_server_buy_btn,function ()
         SendMsgCallFunByNpc(0,"OpenServerGift","BuyOpenServerGift") 
    end)
    self.buy_gift = tonumber(is_buy) 
    self:FlushInfo()
end

function OpenServerGiftObj:flushView(...)
    local tab = {...}
    if tab[1] == "flush_buy" then
        self.buy_gift = tonumber(tab[2])
        self:FlushInfo()
    elseif tab[1] == "flush_sigle_open_server" then
        self.buy_gift = tonumber(tab[2])
        local index = tonumber(tab[3])
        if self.ui["op_server_btn"..index] then
            GUI:removeFromParent(self.ui["op_server_btn"..index])
        end
        self.ui = GUI:ui_delegate(self._parent)
        GUI:Image_Create(self.ui["op_server_item_bg"..index],"op_server_not_buy"..index,38,15,"res/custom/tag/ok.png")
    end
end

function OpenServerGiftObj:FlushInfo()
    GUI:setVisible(self.ui.op_server_buy_btn,not self:IsBuy())  
    GUI:setVisible(self.ui.op_server_has_get,self:IsBuy())  
    for _,v in ipairs(self.cfg) do
        if self.ui["op_server_item_bg"..v.key_name] then
            GUI:removeFromParent(self.ui["op_server_item_bg"..v.key_name])

        end
        local img = GUI:Image_Create(self.ui.open_server_list,"op_server_item_bg"..v.key_name,0,0,"res/custom/npc/20fl/017fldt8/di.png")
        GUI:Image_Create(img,"op_server_title"..v.key_name,42,227,"res/custom/npc/20fl/017fldt8/"..v.key_name..".png")
        if self:IsBuy() then
            if self:AwardIsGet(v.key_name + 1) then
                GUI:Image_Create(img,"op_server_not_buy"..v.key_name,38,15,"res/custom/tag/ok.png")
            else
                local get_btn = GUI:Button_Create(img,"op_server_btn"..v.key_name,30,15,"res/custom/npc/20fl/017fldt8/lq.png")
                local day =  GameData.GetData("U_open_server_gift") or 0 
                local day_flag =  GameData.GetData("J_open_server_gift") or 0 
                if day >= v.key_name and day_flag < 1 then
                     SL:CreateRedPoint(get_btn)
                end
                GUI:addOnClickEvent(get_btn,function ()
                    SendMsgCallFunByNpc(0,"OpenServerGift","GetOpenServerAward",v.key_name)
                end) 
            end
        else
            GUI:Image_Create(img,"op_server_not_buy"..v.key_name,30,15,"res/custom/tag/imgwjs.png")
        end
        local x_index = 0
        local y_index = 0
        for i,data in ipairs(v.award1_map) do
            if x_index >= 2 then
                x_index = 0
                y_index = 70
            end
            local item_cell = GUI:ItemShow_Create(img,"op_server_item"..v.key_name.."_"..i,70 * x_index + 40 ,180 - y_index,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", data[1]),count = data[2],bgVisible = true,look = true})
            GUI:setAnchorPoint(item_cell,0.5,0.5)
            x_index = x_index + 1
        end
    end
    GUI:UserUILayout(self.ui.open_server_list, {
        dir=2,
        addDir=1,
        gap = {x=1},
    })
end

function OpenServerGiftObj:IsBuy()
    return  self.buy_gift > 0
end

function OpenServerGiftObj:AwardIsGet(index)
    return self.buy_gift >= index
end

return OpenServerGiftObj