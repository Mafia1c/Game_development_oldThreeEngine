local GrowUpGiftObj = {}
GrowUpGiftObj.Name = "GrowUpGiftObj"

function GrowUpGiftObj:main(ui,cfg,node,_parent,data)
    self.ui = ui
    self.cfg = cfg
    self.node = node

    self.award_list = data
    self:FlushInfo()
    -- SendMsgCallFunByNpc(0,"WelfareHall","FlushGrowUpGift") 
end

function GrowUpGiftObj:flushView(...)
    local tab = {...}
    if tab[1] == "flush_growup" then
        self.award_list = SL:JsonDecode(tab[2]) 
        self:FlushInfo()
    end
end
function GrowUpGiftObj:FlushInfo()
   

    local list = {}
    for i,v in ipairs(self.cfg) do
        if i < 11 then
            table.insert(list,v) 
        end
    end
    -- table.sort(list, function (a,b)
    --     local a_state =  self:IsAlreadyReceived(a.index)  and 1 or 0
    --     local b_state =  self:IsAlreadyReceived(b.index)  and 1 or 0
    --     if a_state ~= b_state then
    --         return a_state < b_state
    --     end 
    --     return a.index < b.index
    -- end)
    for _,v in ipairs(list) do
        if self.ui["growup_item_bg"..v.index] then
            GUI:removeFromParent(self.ui["growup_item_bg"..v.index])
            self.ui = GUI:ui_delegate(self.node)
        end
        local img = GUI:Image_Create(self.ui.grow_up_list,"growup_item_bg"..v.index,0,0,"res/custom/npc/20fl/017fldt3/tag14.png")
        self:CreateItem(v.index,v,img)
    end

    GUI:UserUILayout(self.ui.grow_up_list, {
        dir=2,
        addDir=1,
        -- gap = {y=2},
    })
    local special_cfg = self.cfg[#self.cfg]
    if self.ui["growup_item_bg"..special_cfg.index] then
        GUI:removeFromParent(self.ui["growup_item_bg"..special_cfg.index])
        self.ui = GUI:ui_delegate(self.node)
    end
    local special_img = GUI:Image_Create(self.ui.special_box,"growup_item_bg"..special_cfg.index,0,0,"res/custom/npc/20fl/017fldt3/tag14.png")
    self:CreateItem(special_cfg.index,special_cfg,special_img)
end

function GrowUpGiftObj:CreateItem(key,cfg,img)
    GUI:Text_Create(img,"growup_level"..key,39,325,16,"#ffff00",cfg.parame1.."级")
    local index = 0
    for k,v in pairs(cfg.award1_map) do
        local item_cell = GUI:ItemShow_Create(img,"growup"..key.."_"..k,70 * index + 55 ,275,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = true,look = true,color = 250})
        GUI:setAnchorPoint(item_cell,0.5,0.5)
        ItemShow_updateItem(item_cell,{showCount = true,count = v,bgVisible = true,look = true,color = 250})
        index = index + 1
    end
    local level_award_get,jj_award_get = self:AwardIsGet(cfg.index)
    if not level_award_get then
        local role_level = SL:GetMetaValue("LEVEL")
        local level_get_btn = GUI:Button_Create(img,"growup_level_btn"..key,18,195,"res/public/1900000611.png")
        GUI:Button_setBrightEx(level_get_btn,role_level >= cfg.parame1)
        GUI:Button_setTitleText(level_get_btn,role_level >= cfg.parame1 and "领取" or "未达成")
        GUI:Button_setTitleFontSize(level_get_btn, 16)
        if role_level >= cfg.parame1  then
            SL:CreateRedPoint(level_get_btn)
        end
        GUI:addOnClickEvent(level_get_btn,function ()
            local recharge = GameData.GetData("U_recharge", false) or 0
            if recharge > 0 then
                SendMsgCallFunByNpc(0,"WelfareHall","GetGrowUpAward","等级#"..cfg.type.."#"..cfg.index)
            else
                local data = {}
                data.str = "当前奖励可以获得双倍奖励"
                data.btnDesc  = { "继续领取", "领取双倍奖励" }
                data.callback = function(atype)
                    if atype == 1 then
                        SendMsgCallFunByNpc(0,"WelfareHall","GetGrowUpAward","等级#"..cfg.type.."#"..cfg.index)
                    else
                        ViewMgr.close("WelfareHallOBJ") 
                        ViewMgr.open("RechargeOBJ") 
                    end
                end
                ViewMgr.open("WelfareStrTipObj",data)
            end
        end) 
    else
        GUI:Image_Create(img,"growup_state"..key,15,185,"res/custom/tag/0-4.png")
    end

    local title_str = string.format("<font color='#9b00ff'>%s</font>境界",cfg.parame2) 
    local rich_text = GUI:RichText_Create(img,"growup_title"..key,55,165,title_str,80,16,"#FFFF00")
    GUI:setAnchorPoint(rich_text,0.5,0.5)
    for k,v in pairs(cfg.award2_map) do
        local item_cell = GUI:ItemShow_Create(img,"growup_jj"..key.."_"..k,55,105,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = true,look = true,color = 250})
        GUI:setAnchorPoint(item_cell,0.5,0.5)
        ItemShow_updateItem(item_cell,{showCount =true,count = v,bgVisible = true,look = true,color = 250})
    end
    if not jj_award_get then
        local jj_level = tonumber(GameData.GetData("l_masterLayer",false))
        if jj_level == nil then
            jj_level = 0
        end
        local jj_get_btn = GUI:Button_Create(img,"growup_jj_btn"..key,17,20,"res/public/1900000611.png")
        GUI:Button_setBrightEx(jj_get_btn,jj_level >= cfg.index)
        GUI:Button_setTitleText(jj_get_btn,(jj_level >= cfg.index) and "领取" or "未达成")
        GUI:Button_setTitleFontSize(jj_get_btn, 16)
        if jj_level >= cfg.index then
            SL:CreateRedPoint(jj_get_btn)
        end
        GUI:addOnClickEvent(jj_get_btn,function ()
            local active = GameData.GetData("U_zstq",false) or 0 --#region 是否激活终身特权
            if active > 0 then
                SendMsgCallFunByNpc(0,"WelfareHall","GetGrowUpAward","境界#"..cfg.type.."#"..cfg.index)
            else
                local data = {}
                data.str = "当前奖励可以获得双倍奖励"
                data.btnDesc  = { "继续领取", "领取双倍奖励" }
                data.callback = function(atype)
                    if atype == 1 then
                        SendMsgCallFunByNpc(0,"WelfareHall","GetGrowUpAward","境界#"..cfg.type.."#"..cfg.index)
                    else
                        ViewMgr.close("WelfareHallOBJ") 
                        ViewMgr.open("PrivilegeOBJ") 
                    end
                end
                ViewMgr.open("WelfareStrTipObj",data)
            end 
        end) 
    else
        GUI:Image_Create(img,"growup_jj_state"..key,10,20,"res/custom/tag/0-4.png")
    end
end

function GrowUpGiftObj:AwardIsGet(index)
    for i,v in ipairs(self.award_list) do
        if tonumber(v.id) == tonumber(index) then
           return v.level_award,v.jj_award 
        end
    end
    return false,false
end


return GrowUpGiftObj