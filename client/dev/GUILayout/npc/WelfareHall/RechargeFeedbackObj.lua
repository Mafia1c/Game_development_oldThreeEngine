local RechargeFeedbackObj = {}
RechargeFeedbackObj.Name = "RechargeFeedbackObj"

function RechargeFeedbackObj:main(ui,cfg,node,_parent,data)
    self.ui = ui
    self.cfg = cfg
    self.node = node
    self.recharge_red_list = {}
    self.award_list = data.award_list
    self.day_recharge =  data.day_recharge
    self.accumulate_recharge = data.accumulate_recharge
    self:FlushInfo()

end

function RechargeFeedbackObj:flushView(...)
    local tab = {...}
    if tab[1] == "init_recharge" then
        self.award_list = SL:JsonDecode(tab[2]) 
        self.day_recharge = tonumber(tab[3]) 
        self.accumulate_recharge = tonumber(tab[4]) 
        self:FlushInfo()
    elseif tab[1] == "flush_recharge" then
        self.award_list = SL:JsonDecode(tab[3]) 
        self:FlushSingle(tonumber(tab[2]))
    end
end

function RechargeFeedbackObj:FlushSingle(index)
    if index ~= 7 then
        GUI:Button_setBrightEx(self.ui["recharge_btn"..index],false)
        GUI:Button_setTitleText(self.ui["recharge_btn"..index],"已领取") 
        if self.recharge_red_list[index] then
            GUI:removeFromParent(self.recharge_red_list[index])
            self.recharge_red_list[index]  = nil
        end
    else
        if self.recharge_red_list[index] and not self:SpecialRechargeIndexCanGet() then
            GUI:removeFromParent(self.recharge_red_list[index])
            self.recharge_red_list[index]  = nil
        end
    end
end

function RechargeFeedbackObj:FlushInfo()
    local list = {}
    for i,v in ipairs(self.cfg) do
        if i < 11 then
            table.insert(list,v) 
        end
    end
    table.sort(list, function (a,b)
        local a_state =  self:AwardIsGet(a.index)  and 1 or 0
        local b_state =  self:AwardIsGet(b.index)  and 1 or 0
        if a_state ~= b_state then
            return a_state < b_state
        end 
        return a.index < b.index
    end)
    for _,v in ipairs(list) do
        if self.ui["recharge_item_bg"..v.index] then
            GUI:removeFromParent(self.ui["recharge_item_bg"..v.index])
            self.ui = GUI:ui_delegate(self.node)
        end
        local img = GUI:Image_Create(self.ui.recharge_list,"recharge_item_bg"..v.index,0,0,"res/custom/npc/20fl/017fldt5/di1.png")
        if v.parame1 == 0 then
            GUI:Text_Create(img,"recharge_level"..v.index,16,68,16,"#ff9b00","每日免费领取回馈")
        else
            if v.index > 6 then
                GUI:Text_Create(img,"recharge_level"..v.index,16,68,16,"#00ff00",string.format("每充值满%s元",v.parame1) )
            else
                GUI:Text_Create(img,"recharge_level"..v.index,16,68,16,"#ff9b00",string.format("今日充值达到%s元",v.parame1) )
            end
        end
        local index = 0
        for i,data in ipairs(v.award1_map) do
            local item_cell = GUI:ItemShow_Create(img,"recharge"..v.index.."_"..data[1],65 * index + 50 ,35,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", data[1]),count = data[2],bgVisible = true,look = true,color = 250})
            GUI:setAnchorPoint(item_cell,0.5,0.5)
            ItemShow_updateItem(item_cell,{showCount = true,count = data[2],bgVisible = true,look = true,color = 250})   
            index = index + 1
        end

        if v.index > 6 then
            GUI:Text_Create(img,"recharge2_level"..v.index,250,68,16,"#00ff00","特权用户额外领取" )
        else
            GUI:Text_Create(img,"recharge2_level"..v.index,250,68,16,"#ff9b00","特权用户额外领取" )
        end
        local index2 = 0
        for i,data in ipairs(v.award2_map) do
            local item_cell = GUI:ItemShow_Create(img,"recharge_tq"..v.index.."_"..data[1],65 * index2 + 280 ,35,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", data[1]),count = data[2],bgVisible = true,look = true,color = 250})
            GUI:setAnchorPoint(item_cell,0.5,0.5)
            ItemShow_updateItem(item_cell,{showCount =true,count = data[2],bgVisible = true,look = true,color = 250})
            index2 = index2 + 1
        end
        local get_btn = GUI:Button_Create(img,"recharge_btn"..v.index,480,25,"res/public/1900000611.png")
        GUI:Button_setBrightEx(get_btn,not self:AwardIsGet(v.index))
        GUI:Button_setTitleText(get_btn,self:AwardIsGet(v.index) and "已领取" or "领取")
        if not self:AwardIsGet(v.index) and self.day_recharge >= v.parame1 then
            if v.index == 7 then
                if self.recharge_red_list[v.index] == nil and self:SpecialRechargeIndexCanGet() then
                    self.recharge_red_list[v.index] = SL:CreateRedPoint(get_btn)
                end 
            else
                if self.recharge_red_list[v.index] == nil then
                    self.recharge_red_list[v.index] = SL:CreateRedPoint(get_btn)
                end  
            end
        end
        GUI:Button_setTitleFontSize(get_btn, 16)
        GUI:addOnClickEvent(get_btn,function ()
            SendMsgCallFunByNpc(0,"WelfareHall","GetRechargeBackAward",v.type.."#"..v.index)
        end) 
    end

    GUI:Text_setString(self.ui.today_recharge,string.format("今日充值金额：%s元",self.day_recharge)) 
    GUI:Text_setString(self.ui.accumulate_recharge,string.format("累积充值金额：%s元",self.accumulate_recharge)) 
    GUI:UserUILayout(self.ui.recharge_list, {
        dir=1,
        addDir=1,
        -- gap = {y=2},
    })
end

function RechargeFeedbackObj:AwardIsGet(index)
    if index == 7 then
        return false
    end
    for i,v in ipairs(self.award_list) do
        if tonumber(v.index) == tonumber(index) then
           return v.is_get
        end
    end
    return false
end

function RechargeFeedbackObj:SpecialRechargeIndexCanGet()
    for k, v in pairs(self.award_list) do
        if tonumber(v.index) == 7 then
            if tonumber(v.recharge) >= 100 then
                return self.day_recharge - tonumber(v.recharge)  >= 100
            else
                return self.day_recharge >= 100
            end
        end
    end
    return self.day_recharge >= 100
end

return RechargeFeedbackObj