local MergeDistrictGiftObj = {}
MergeDistrictGiftObj.Name = "MergeDistrictGiftObj"

function MergeDistrictGiftObj:main(ui,cfg,node)
    self.ui = ui
    self.cfg = cfg
    self.node = node
    local merge_num = GameData.GetData("HeFuCount",false) or 0
    self:FLushInfo()
    local end_time = 0 
    local server_time = SL:GetMetaValue("SERVER_TIME")
    local merge_time =  GameData.GetData("T_merge_time") or SL:GetMetaValue("MERGE_SERVER_TIME")
    if merge_num > 0 then
        end_time = merge_time + 3600 * 24
    end
    if end_time - server_time > 0 then
        local function showTime()
            if end_time -  SL:GetMetaValue("SERVER_TIME") <=0 then
                SL:UnSchedule(self.merge_sch1)
                GUI:Text_setString(self.ui.merge_end_time,"已结束") 
            end
            GUI:Text_setString(self.ui.merge_end_time,"限购倒计时："..FormatSecond2CN_DHMS2( end_time -  SL:GetMetaValue("SERVER_TIME"))) 
        end
        self.merge_sch1 = GUI:schedule(self.ui.merge_end_time, showTime, 1)
    end
    GUI:Text_setString(self.ui.merge_end_time,"限购倒计时："..FormatSecond2CN_DHMS2( end_time -  SL:GetMetaValue("SERVER_TIME"))) 
end

function MergeDistrictGiftObj:flushView( ... )
    local tab = {...}
    if tab[1] == "充值刷新" then
        self:flushSigleItem()
        ViewMgr.close("MergeBuyTipObj")
    end
end

function MergeDistrictGiftObj:FLushInfo()
    local list = {}
    local merge_num = GameData.GetData("HeFuCount",false) or 0
    local hefu_index = merge_num
    if hefu_index  > 5 then
        hefu_index = 5
    end
    for i,v in ipairs(self.cfg) do
        if v.parame1 == hefu_index then
            table.insert(list,v)
        end
    end
    table.sort( list, function (a,b )
        return a.parame2 < b.parame2    
    end )

    for i,v in ipairs(list) do
        if self.ui["merge_item_bg"..v.index] then
            GUI:removeFromParent(self.ui["merge_item_bg"..v.index])
            self.ui = GUI:ui_delegate(self.node)
        end
        local img = GUI:Image_Create(self.ui.merge_district_list,"merge_item_bg"..v.index,0,0,"res/custom/npc/20fl/017fldt9/rq.png")
        local x_index = 0
        local y_index = 0
        for i,data in ipairs(v.award1_map) do
            if x_index >= 2 then
                x_index = 0
                y_index = 70
            end
            local item_cell = GUI:ItemShow_Create(img,"merge_item"..v.index.."_"..i,70 * x_index + 110 ,220 - y_index,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", data[1]),count = data[2],bgVisible = true,look = true})
            GUI:setAnchorPoint(item_cell,0.5,0.5)
            ItemShow_updateItem(item_cell,{showCount = true,count = data[2],bgVisible = true,look = true,color = 255})
            x_index = x_index + 1
        end
        GUI:Text_Create(img,"merge_title"..v.index,100,85,16,"#ffff00","售价："..v.parame2.."元")
        local str = "每日限购：不限"
        if v.parame3 > 0 then
            str = string.format("每日限购：%s/%s",self:GetHasBuyCount(merge_num,v.index),v.parame3)
        end
        GUI:Text_Create(img,"merge_limit"..v.index,85,60,16,"#ffffff",str)
        local get_btn = GUI:Button_Create(img,"merge_btn"..v.index,80,10,"res/custom/npc/20fl/017fldt9/an.png")
        GUI:addOnClickEvent(get_btn,function ()
            if self:GetHasBuyCount(merge_num,v.index) >= v.parame3 and v.parame3 ~= 0 then
                return SL:ShowSystemTips("购买次数不足！")
            end
            self.cur_item_cfg = v
            if v.parame3 > 0 then
                str = string.format("每日限购：%s/%s",self:GetHasBuyCount(merge_num,v.index),v.parame3)
            end
            ViewMgr.open("MergeBuyTipObj",v,str) 
        end) 
    end

    GUI:UserUILayout(self.ui.merge_district_list, {
        dir=2,
        addDir=1,
        gap = {x=1},
    })
end

function MergeDistrictGiftObj:flushSigleItem(index)
    local merge_num = GameData.GetData("HeFuCount",false) or 0
    if self.cur_item_cfg == nil then return end
    local str = string.format("每日限购：%s/%s",self:GetHasBuyCount(merge_num,self.cur_item_cfg.index),self.cur_item_cfg.parame3)
    if self.cur_item_cfg.parame3 <= 0 then
        str = "每日限购：不限"
    end
    if self.ui["merge_limit"..self.cur_item_cfg.index] then
        GUI:Text_setString(self.ui["merge_limit"..self.cur_item_cfg.index], str)
    end
    ViewMgr.flushView("MergeBuyTipObj",str) 
end

function MergeDistrictGiftObj:GetHasBuyCount(merge_num,index)
    local data = GameData.GetData("Z_gift_thlb",true)  
    if data == nil or data == "" then
        return 0
    end
    return data[tostring(merge_num)..tostring(index)] or 0
end

return MergeDistrictGiftObj