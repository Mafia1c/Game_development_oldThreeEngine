local OnLineGiftObj = {}
OnLineGiftObj.Name = "OnLineGiftObj"

function OnLineGiftObj:main(ui,cfg,node,_parent,data)
    self.ui = ui
    self.cfg = cfg
    self.node = node

    self.award_list = data.award_list 
    self.online_time = data.online_time
    self:FlushInfo()
end

function OnLineGiftObj:flushView(...)
    local tab = {...}

    if tab[1] == "flush_online" then
        self.award_list = SL:JsonDecode(tab[2]) 
        self.online_time = tonumber(tab[3])  
        self:FlushInfo()
    end
end
function OnLineGiftObj:FlushInfo()
    local list = {}
    GUI:Text_setString(self.ui.online_text,string.format("今日在线时长：%s分钟",self.online_time)) 
    for i,v in ipairs(self.cfg) do
        table.insert(list,v) 
    end
    table.sort(list, function (a,b)
        local a_state =  self:IsAlreadyReceived(a.index)  and 1 or 0
        local b_state =  self:IsAlreadyReceived(b.index)  and 1 or 0
        if a_state ~= b_state then
            return a_state < b_state
        end 
        return a.index < b.index
    end)
    local key = 0
    for _,v in ipairs(list) do
        key = v.index
        if self.ui["online_item_bg"..key] then
            GUI:removeFromParent(self.ui["online_item_bg"..key])
            self.ui = GUI:ui_delegate(self.node)
        end

        local img = GUI:Image_Create(self.ui.online_list,"online_item_bg"..key,0,0,"res/custom/npc/20fl/017fldt1/tag48.png")
        GUI:Image_setScale9Slice(img, 34, 34, 31, 31)
        GUI:setContentSize(img,605,94)
        local title_str = string.format("每日累计在线<font color='#ffff00'>%s</font><font color='#ffffff' >分钟</font>",v.parame1) 
        -- if key > 7 then
        --     title_str = string.format("累计登陆<font color='#00ff00'>%s</font><font color='#ffffff' >天之后</font>",7) 
        -- end
        GUI:RichText_Create(img,"online_title"..key,20,70,title_str,170,16,"#ffffff")
        GUI:RichText_Create(img,"online2_title"..key,250,70,"<font color='#ffff00'>今日任意充值</font>额外领取",170,16,"#ffffff")
        local index = 0
        for k,v in pairs(v.award1_map) do
            local item_cell = GUI:ItemShow_Create(img,"online_item"..key.."_"..k,70 * index + 50 ,38,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = true,look = true,color = 250})
            GUI:setAnchorPoint(item_cell,0.5,0.5)
            ItemShow_updateItem(item_cell,{showCount = true,count = v,bgVisible = true,look = true,color = 250})
            index = index + 1
        end
        for k,v in pairs(v.award2_map) do
            local item_cell = GUI:ItemShow_Create(img,"online2_item"..key.."_"..k,300 ,38,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = true,look = true,color = 250})
            GUI:setAnchorPoint(item_cell,0.5,0.5)
            ItemShow_updateItem(item_cell,{showCount = true,count = v,bgVisible = true,look = true,color = 250})
        end
        local state_img = GUI:Image_Create(img,"online_state"..key,555,45,"res/custom/npc/20fl/017fldt1/tag50_1.png")
        if not self:IsAlreadyReceived(v.index) then
            local get_btn = GUI:Button_Create(img,"online_btn"..key,510,25,"res/custom/fldtBtn.png")
            -- GUI:Button_setBrightEx(get_btn,self.online_time >= v.parame1)
            GUI:Button_setTitleText(get_btn,self.online_time >= v.parame1 and "领取" or "未达成")
            GUI:Button_setTitleFontSize(get_btn, 16)
            if self.online_time >= v.parame1 then
                SL:CreateRedPoint(get_btn)
            end
            GUI:addOnClickEvent(get_btn,function ()
                -- if self.online_time >= v.parame1 then
                local day_recharge = GameData.GetData("J_DayRecharge",false) or 0 
                if day_recharge > 0 then
                    SendMsgCallFunByNpc(0,"WelfareHall","GetOnlineAward",v.type.."#"..v.index)
                else
                    local data = {}
                    data.str = "当前奖励可以获得额外奖励"
                    data.btnDesc  = { "继续领取", "领取额外奖励" }
                    data.callback = function(atype)
                        if atype == 1 then
                             SendMsgCallFunByNpc(0,"WelfareHall","GetOnlineAward",v.type.."#"..v.index)
                        else
                            ViewMgr.close("WelfareHallOBJ") 
                            ViewMgr.open("RechargeOBJ") 
                        end
                    end
                    ViewMgr.open("WelfareStrTipObj",data)
                end
                -- end
            end) 
        end

        if self:IsAlreadyReceived(v.index) then
            GUI:Image_loadTexture(state_img,"res/custom/npc/20fl/017fldt1/tag52.png")
            GUI:setPosition(state_img,500,10)
        elseif not self:IsAlreadyReceived(v.index) and self.online_time >= v.parame1 then
            GUI:Image_loadTexture(state_img,"res/custom/npc/20fl/017fldt1/tag50.png")
        end
    end
    GUI:UserUILayout(self.ui.online_list, {
        dir=1,
        addDir=1,
        gap = {y=2},
    })
end

function OnLineGiftObj:IsAlreadyReceived(key)
    for k,v in pairs(self.award_list) do
        if tonumber(v.index) == key then
            return v.is_get
        end
    end 
    return false
end

return OnLineGiftObj