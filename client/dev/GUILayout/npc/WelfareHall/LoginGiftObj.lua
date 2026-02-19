local LoginGiftObj = {}
LoginGiftObj.Name = "LoginGiftObj"

function LoginGiftObj:main(ui,cfg,node,_parent,data)
    self.ui = ui
    self.cfg = cfg
    self.node = node
    local get_flag = {}

    self.com_protor_list = data.common_list
    self.tq_protor_list = data.privilege_list
    self:FlushInfo()
    self:FlushPrivilege()
end

function LoginGiftObj:flushView(...)
    local tab = {...}
    if tab[1] == "init_login_gift" then
        self.com_protor_list = SL:JsonDecode(tab[2])
        self:FlushInfo()
    end
    if tab[1] == "init_tq_login_gift" then
        self.tq_protor_list = SL:JsonDecode(tab[2])
        self:FlushPrivilege()
    end 
end

function LoginGiftObj:FlushInfo()
    local list = {}
    for i,v in ipairs(self.cfg) do
        table.insert(list,v) 
    end
    table.sort(list, function (a,b)
        local a_state =  self:GetLoginGiftState(a.parame1) or 1
        local b_state =  self:GetLoginGiftState(b.parame1) or 1
        if a_state ~= b_state then
            return a_state < b_state
        end 
        return a.parame1 < b.parame1
    end)
    local key = 0
    for _,v in ipairs(list) do
        key = v.parame1
        local state =  self:GetLoginGiftState(key)
        if self.ui["common_item_bg"..key] then
            GUI:removeFromParent(self.ui["common_item_bg"..key])
            self.ui = GUI:ui_delegate(self.node)
        end
        local img = GUI:Image_Create(self.ui.common_list,"common_item_bg"..key,0,0,"res/custom/npc/20fl/017fldt1/tag48.png")
        local title_str = string.format("累计登陆<font color='#00ff00'>%s</font><font color='#ffffff' >天</font>",v.parame1) 
        if key > 7 then
            title_str = string.format("累计登陆<font color='#00ff00'>%s</font><font color='#ffffff' >天之后</font>",7) 
        end
        GUI:RichText_Create(img,"common_title"..key,20,70,title_str,150,16,"#ffffff")
        local index = 0
        for k,v in pairs(v.award1_map) do
            local item_cell = GUI:ItemShow_Create(img,"common_item"..key.."_"..k,70 * index + 50 ,38,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = true,look = true,color = 250})
            GUI:setAnchorPoint(item_cell,0.5,0.5)
            ItemShow_updateItem(item_cell,{showCount = true,count = v,bgVisible = true,look = true,color = 250})
            index = index + 1
        end
        local state_img = GUI:Image_Create(img,"common_state"..key,290,46,"res/custom/npc/20fl/017fldt1/tag50_1.png")
        if state < 2 then
            local get_btn = GUI:Button_Create(img,"common_btn"..key,230,20,"res/custom/npc/20fl/017fldt1/lq.png")
            GUI:addOnClickEvent(get_btn,function ()
                local active = GameData.GetData("U_zstq",false) or 0 --#region 是否激活终身特权
                if active <= 0 then
                    local data = {}
                    data.str = "当前奖励可以获得额外奖励"
                    data.btnDesc  = { "继续领取", "领取额外奖励" }
                    data.callback = function(atype)
                        if atype == 1 then
                            SendMsgCallFunByNpc(0,"WelfareHall","GetLoginCommonAward",v.type.."#"..v.parame1)
                        else
                            ViewMgr.close("WelfareHallOBJ") 
                            ViewMgr.open("PrivilegeOBJ") 
                        end
                    end
                    ViewMgr.open("WelfareStrTipObj",data)
                else
                    SendMsgCallFunByNpc(0,"WelfareHall","GetLoginCommonAward",v.type.."#"..v.parame1)
                end
            end) 
            if state == 0 then
                SL:CreateRedPoint(get_btn)
            end
        end
        if state == 0 then
            GUI:Image_loadTexture(state_img,"res/custom/npc/20fl/017fldt1/tag50.png")
        elseif state == 2 then
            GUI:Image_loadTexture(state_img,"res/custom/npc/20fl/017fldt1/tag52.png")
            GUI:setPosition(state_img,230,10)
        end
    end
    GUI:UserUILayout(self.ui.common_list, {
        dir=1,
        addDir=1,
        gap = {y=2},
    })
end

function LoginGiftObj:FlushPrivilege()
    local list = {}
    for i,v in ipairs(self.cfg) do
        if i  < 8 then
            table.insert(list,v) 
        end
    end
    table.sort(list, function (a,b)
        local a_state =  self:GetLoginTqGiftState(a.parame1) or 1
        local b_state =  self:GetLoginTqGiftState(b.parame1) or 1
        if a_state ~= b_state then
            return a_state < b_state
        end 
        return a.parame1 < b.parame1
    end)
    local key = 0
    for _,v in ipairs(list) do
        key = v.parame1
        local state =  self:GetLoginTqGiftState(key)
        if self.ui["privilege_item_bg"..key] then
            GUI:removeFromParent(self.ui["privilege_item_bg"..key])
            self.ui = GUI:ui_delegate(self.node)
        end
        local img = GUI:Image_Create(self.ui.privilege_list,"privilege_item_bg"..key,0,0,"res/custom/npc/20fl/017fldt1/tag48.png")
        GUI:Image_setScale9Slice(img, 34, 34, 31, 31)
        GUI:setContentSize(img,262,94)
        local title_str = string.format("<font color='#00ff00'>特权用户</font>第%s天额外领取",v.parame1) 
        GUI:RichText_Create(img,"privilege_title"..key,20,70,title_str,210,16,"#ffffff")
        local index = 0
        for k,v in pairs(v.award2_map) do
            local item_cell = GUI:ItemShow_Create(img,"privilege_item"..key.."_"..k,70 * index + 50 ,38,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = true,look = true,color = 250})
            GUI:setAnchorPoint(item_cell,0.5,0.5)
            ItemShow_updateItem(item_cell,{showCount = true,count = v,bgVisible = true,look = true,color = 250})
            index = index + 1
        end
        local state_img = GUI:Image_Create(img,"privilege_state"..key,210,46,"res/custom/npc/20fl/017fldt1/tag50_1.png")
        if state < 2 then
            local get_btn = GUI:Button_Create(img,"privilege_btn"..key,170,20,"res/custom/npc/20fl/017fldt1/lq.png")
            GUI:addOnClickEvent(get_btn,function ()
                local active = GameData.GetData("U_zstq",false) or 0 --#region 是否激活终身特权
                if active > 0 then
                    SendMsgCallFunByNpc(0,"WelfareHall","GetLoginTqAward",v.type.."#"..v.parame1)
                else
                    ViewMgr.close("WelfareHallOBJ") 
                    ViewMgr.open("PrivilegeOBJ") 
                end 
            end) 
            if state == 0 then
                SL:CreateRedPoint(get_btn)
            end
        end
        if state == 0 then
            GUI:Image_loadTexture(state_img,"res/custom/npc/20fl/017fldt1/tag50.png")
        elseif state == 2 then
            GUI:Image_loadTexture(state_img,"res/custom/npc/20fl/017fldt1/tag52.png")
            GUI:setPosition(state_img,170,10)
        end
    end
    GUI:UserUILayout(self.ui.privilege_list, {
        dir=1,
        addDir=1,
        gap = {y=2},
    })
end

function  LoginGiftObj:GetLoginGiftState(key)
    return self.com_protor_list[key] or 1
end

function LoginGiftObj:GetLoginTqGiftState(key)
    return self.tq_protor_list[key] or 1
end

return LoginGiftObj