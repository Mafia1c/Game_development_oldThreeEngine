local FirstEquipGiftObj = {}
FirstEquipGiftObj.Name = "FirstEquipGiftObj"
local temp_cfg = SL:Require("GUILayout/config/FirstDropEquipCfg",true)
local first_equip_cfg = {}
local fitst_equip_max = 0
for i,v in ipairs(temp_cfg) do
    if fitst_equip_max < v.page  then
        fitst_equip_max = v.page
    end
    first_equip_cfg[v.page] = first_equip_cfg[v.page] or {}
    table.insert(first_equip_cfg[v.page],v)
end
function FirstEquipGiftObj:main(ui,cfg,node,_parent,data)
    self.ui = ui
    self.cfg = cfg
    self.node = node
    self.cur_page = 0
  
    GUI:addOnClickEvent(self.ui.last_btn,function ()
        if self.cur_page == 0 then
            SL:ShowSystemTips("已经是第一页了！")
            return
        end
        self.cur_page = self.cur_page - 1
        self:FlushInfo()
    end)
    GUI:addOnClickEvent(self.ui.next_btn,function ()
        if self.cur_page == fitst_equip_max then
            SL:ShowSystemTips("已经是最后一页了！")
            return
        end
        self.cur_page = self.cur_page + 1
        self:FlushInfo()
    end)

    GUI:addOnClickEvent(self.ui.frist_equip_all_get,function ()
        SendMsgCallFunByNpc(0,"WelfareHall","GetAllFristEquipAward",self.cur_page)
    end)
    
    self.equip_count = data.equip_count_list
    self.equip_state = data.equip_state
    self.cur_page  = 0
    self.is_zstq = tonumber(data.zstq_level) > 0
    self:FlushInfo()
end

function FirstEquipGiftObj:flushView( ... )
    local tab = {...}
    if tab[1] == "flush_frist_equip" then
        self.equip_count = SL:JsonDecode(tab[2])
        self.equip_state = SL:JsonDecode(tab[3])
        self.cur_page  = tonumber(tab[4])
        self.is_zstq = tonumber(tab[5]) > 0
        self:FlushInfo()
    end
end

function FirstEquipGiftObj:FlushInfo()
      GUI:ScrollView_removeAllChildren(self.ui.frist_equip_list)
     for _,v in ipairs(first_equip_cfg[self.cur_page]) do
        if self.ui["frist_item_bg"..v.key_name] then
            GUI:removeFromParent(self.ui["frist_item_bg"..v.key_name])
            self.ui = GUI:ui_delegate(self.node)
        end
        local img = GUI:Image_Create(self.ui.frist_equip_list,"frist_item_bg"..v.key_name,0,0,"res/custom/npc/20fl/017fldt4/di.png")
        GUI:Text_Create(img,"frist_equip_name"..v.key_name,30,30,16,"#00ff00",v.equip_name)
        for i=1,3 do
            if v["award_num"..i] ~= 0 then
                local item_cell = GUI:ItemShow_Create(img,"frist_equip_item"..v.key_name.."_"..i,70 * (i-1) + 200 ,40,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v["award_name"..i]),count = v["award_num"..i],bgVisible = true,look = true})
                GUI:setAnchorPoint(item_cell,0.5,0.5)
            end
        end
        if self.equip_count[v.equip_name] then
            GUI:Text_Create(img,"frist_equip_count"..v.key_name,420,30,16,"#00ff00",0)  
        else
            GUI:Text_Create(img,"frist_equip_count"..v.key_name,420,30,16,"#00ff00",1)  
        end
        if not self.is_zstq  then
            GUI:Image_Create(img,"frist_equip_state"..v.key_name,500,23,"res/custom/tag/no.png")
        else
            local state = self:GetFristEuipState(v.equip_name) 
            if state == 0 then
                GUI:Image_Create(img,"frist_equip_state"..v.key_name,500,23,"res/custom/tag/no.png")
            elseif state == 1 then
                local btn = GUI:Button_Create(img,"frist_equip_btn"..v.key_name,498,20,"res/custom/npc/20fl/017fldt1/lq.png")
                GUI:addOnClickEvent(btn,function ()
                    SendMsgCallFunByNpc(0,"WelfareHall","GetFristEquipAward", self.cur_page.."#"..v.key_name)
                end)
                SL:CreateRedPoint(btn)
            else
                GUI:Image_Create(img,"frist_equip_state"..v.key_name,500,23,"res/custom/tag/ok.png")
            end
        end
    end
    GUI:UserUILayout(self.ui.frist_equip_list, {
        dir=1,
        addDir=1,
    })
    GUI:Text_setString(self.ui.page_text,self.cur_page.."/"..fitst_equip_max) 
    self:flushAllBtnRed(self:GetAllBtnRedShow()) 
end

function FirstEquipGiftObj:GetAllBtnRedShow()
    if not self.is_zstq  then return false end
    for _,list in pairs(first_equip_cfg) do
        for i,v in ipairs(list) do
            if  self:GetFristEuipState(v.equip_name) == 1 then
                return true
            end       
        end
    end
end

function FirstEquipGiftObj:flushAllBtnRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.frist_equip_all_get)
        end
    end
end
--0 不可领 1 可领 2 已领取
function FirstEquipGiftObj:GetFristEuipState(name)
    if self.equip_state == nil or self.equip_state[name] == nil then
        return 0 
    end
    return self.equip_state[name]
end

return FirstEquipGiftObj