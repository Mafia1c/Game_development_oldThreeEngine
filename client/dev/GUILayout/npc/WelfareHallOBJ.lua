local WelfareHallOBJ = {}
WelfareHallOBJ.Name = "WelfareHallOBJ"
WelfareHallOBJ.RunAction = true
local bg_name_list = {
    "res/custom/npc/20fl/017fldt1/bg.png",
    "res/custom/npc/20fl/017fldt2/bg.png",
    "res/custom/npc/20fl/017fldt3/bg.png",
    "res/custom/npc/20fl/017fldt5/bg1.png",
    "res/custom/npc/20fl/017fldt6/bg.png",
    "res/custom/npc/20fl/017fldt9/bg.png",
    "res/custom/npc/20fl/13/bg.png",
    "res/custom/npc/20fl/017fldt4/bg.png",
    "res/custom/npc/26zb/bg1.png",
    "",
    "res/custom/npc/20fl/cdk/bg.png",
}
local _cfg = SL:Require("GUILayout/config/welfareHallcfg",true)
local tmp = {}
for k, v in ipairs(_cfg) do
    tmp[v.tag_name] = tmp[v.tag_name] or {}
    table.insert(tmp[v.tag_name], v)
end

function IsOpenTab(type)
    local merge_num = GameData.GetData("HeFuCount",false) or 0
    if type == 6 then --合区特惠
        return merge_num >= 1
 	elseif type == 7 then
        return merge_num >= 1    
    elseif type == 10 then
        local gift_tab = GameData.GetData("TL_Recharge_hasGift",true) or {} 
        local is_show = false
        for i=1,2 do
            if not gift_tab["gift_xsfl"..i] then
                is_show = true
            end
        end
        return  (GameData.GetData("U_limit_time",false) and GameData.GetData("U_limit_time",false) > 0)  and is_show 
    end
    return true
end


function WelfareHallOBJ:main(...)
    local tab = {...}
    local tmp_cfg = {}
    for k, v in pairs(tmp) do
        local data = v
        data.name = k
        if IsOpenTab(v[1].type) then
            table.insert(tmp_cfg, data)
        end
    end

    table.sort(tmp_cfg, function (a, b) return a[1].sort < b[1].sort end)
    WelfareHallOBJ.cfg = tmp_cfg

    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent

    GUI:LoadExport(parent, "npc/WelfareHallUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = 1
    for i,v in ipairs(tmp_cfg) do
        if v.name == tab[1] then
            self.cur_select_index = i
            break
        end
    end
    self.page_btn = {}
    self.btn_list = {}
    self.btn_red_width = {}
    -- GUI:LoadExport(parent,"npc/WelfareHall/LoginGiftUI")

    self:createPageBtn()
    self:initClickEvent()
    self:openTagView(self.cur_select_index,tab[2])
    -- -- self:updateViewShow()


end

function WelfareHallOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
end

function WelfareHallOBJ:createPageBtn()
    for k, v in pairs(self.cfg) do
        -- local y = 500 - 42 * k - (k -1) * 1
        local btn = GUI:Button_Create(self.ui.btn_list, v.name..k, 0, 0, "res/custom/dayeqian2.png")
        local img = GUI:Image_Create(btn, k.."_img", -7, 6, "res/public/jiantou.png")
        GUI:Button_setTitleText(btn, v.name)
        if v[1].type == 6 or v[1].type == 7 or v[1].type == 10 then
            GUI:Button_setTitleColor(btn, "#ffff00")
        else
            GUI:Button_setTitleColor(btn, "#f8e6c6")
        end
        GUI:Button_setTitleFontSize(btn, 18)
        GUI:addOnClickEvent(btn, function()
            self.cur_select_index = k
            self:updateViewShow()
        end)
        self.page_btn[k] = btn
    end
    GUI:UserUILayout(self.ui.btn_list, {
        dir=1,
        addDir=1,
        colnum= 4
    })
    for k, v in pairs(self.page_btn) do
        GUI:setVisible(GUI:getChildByName(v, k.."_img"), self.cur_select_index == k)
    end
    self:flushBtnRed()
end

function WelfareHallOBJ:flushView( ... )
    local tab = {...}
    if tab[1] == "open_view" then
        self:openTagView(tonumber(tab[2]),tab[3])
    else
        if self.child_ui == nil then return end
        self.child_ui:flushView(...)
        self:flushBtnRed()
    end
end

function WelfareHallOBJ:flushBtnRed()
    for k, v in pairs(self.cfg) do
        if  self.red_data_list and self.red_data_list[v[1].type] ~= nil and self.red_data_list[v[1].type] > 0 then
            if self.btn_red_width[v[1].type] == nil then
                self.btn_red_width[v[1].type] = SL:CreateRedPoint(self.ui[(v.name..k)],{x=105,y=10})
            end
        else
            if self.btn_red_width[v[1].type] then
                GUI:removeFromParent(self.btn_red_width[v[1].type])
               self.btn_red_width[v[1].type] = nil
            end 
        end
    end
end


function WelfareHallOBJ:updateViewShow(index)
    index = index or self.cur_select_index

    for k, v in pairs(self.page_btn) do
        GUI:setVisible(GUI:getChildByName(v, k.."_img"), index == k)
    end
    local cfg = self.cfg[index]
    SendMsgCallFunByNpc(0,"WelfareHall","upEvent",index.."#"..cfg[1].type) 
end

function WelfareHallOBJ:openTagView(index,data)
    local cfg = self.cfg[index]
    GUI:removeAllChildren(self.ui.ChildLayoutBox)
    local ui_name = "" 
    if cfg[1].tag_name == "登录豪礼" then
        ui_name = "LoginGift" 
    elseif cfg[1].tag_name == "在线奖励" then
        ui_name = "OnLineGift" 
    elseif cfg[1].tag_name == "成长奖励" then
        ui_name = "GrowUpGift" 
    elseif cfg[1].tag_name == "充值回馈" then
        ui_name = "RechargeFeedback" 
    elseif cfg[1].tag_name == "客服豪礼" then
        ui_name = "ServiceGift" 
    elseif cfg[1].tag_name == "合区特惠" then
        ui_name = "MergeDistrictGift" 
    elseif cfg[1].tag_name == "惊喜魔盒" then
        ui_name = "SurpriseBoxGift" 
    elseif cfg[1].tag_name == "首爆奖励" then
        ui_name = "FirstEquipGift" 
    elseif cfg[1].tag_name == "珍宝掉落" then
        ui_name = "RarityEquipRecord" 
    elseif cfg[1].tag_name == "限时福利" then
        ViewMgr.open("LimitWelfareObj",data)
        ViewMgr.close(WelfareHallOBJ.Name)
        return
    elseif cfg[1].tag_name == "cdk兑换" then
        ui_name = "CdkGift" 
    end
    if ui_name ~= "" then
        local scirpt,ui,node = WelfareHallOBJ:GetChildUI(ui_name)
        self.child_ui = scirpt
        scirpt:main(ui,cfg,node,self._parent,SL:JsonDecode(data))
    end
    GUI:Image_loadTexture(self.ui.bg_Image,bg_name_list[cfg[1].type]) 
end

function WelfareHallOBJ:GetChildUI(ui_name)
    local node = GUI:Widget_Create(self.ui.ChildLayoutBox,"child_widget", 0, 0)
    GUI:LoadExport(node, "npc/WelfareHall/"..ui_name.."UI")
    local child_ui = GUI:ui_delegate(node)
    return SL:Require("GUILayout/npc/WelfareHall/"..ui_name.."Obj", true),child_ui,node
end

function WelfareHallOBJ:onClose( ... )
    if self.child_ui and self.child_ui.onClose then 
        self.child_ui:onClose(...)
    end
    for k,v in pairs(self.btn_red_width) do
        if v then
            GUI:removeFromParent(v)
        end
    end
    self.btn_red_width = {}
end

function WelfareHallOBJ:SetBtnRedData(type,red_num)
    if type == nil then return end
    self.red_data_list  = self.red_data_list or {}
    self.red_data_list[type] = red_num
end

local function callBack(data)
    if type(data) == "string" and string.find(data, "WelfareHall") then
        local str_list =string.split(data,"#")
        WelfareHallOBJ:SetBtnRedData(tonumber(str_list[2]),tonumber(str_list[3]))
        if string.find(data, "WelfareHall_flush") then
            WelfareHallOBJ:flushBtnRed()
        end
    end
end

SL:RegisterLUAEvent(LUA_EVENT_GAME_DATA, "WelfareHallOBJ", callBack)

return WelfareHallOBJ