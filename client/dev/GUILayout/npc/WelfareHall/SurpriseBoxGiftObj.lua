local SurpriseBoxGiftObj = {}
SurpriseBoxGiftObj.Name = "SurpriseBoxGiftObj"

function SurpriseBoxGiftObj:main(ui,cfg,node,_parent,data)
    self.ui = ui
    self.cfg = cfg
    self.node = node
    GUI:addOnClickEvent(self.ui.buy_box,function ()
        local data = {}
        data.text_pox = 210
        data.text_poy = 170
        data.str = "<font color='#ffff00'>  购买惊喜魔盒</font>\n魔盒价格：<font color='#ffff00'>20元</font>"
        data.str_width = 150
        data.vspace = 20
        local function onclickBuy(index)
            SendMsgCallFunByNpc(0,"WelfareHall","BuySurpriseBox",index) 
        end
        data.btn_data = {btn_count = 3,btn_str={"购买一个","购买十个","购买百个"},btnfun_list = {onclickBuy,onclickBuy,onclickBuy}}
        ViewMgr.open("SurpriseBoxBuyTipObj",data)
    end)

    GUI:addOnClickEvent(self.ui.open_box,function ()
        local count = SL:GetMetaValue("ITEM_COUNT", "魔盒")
        local data = {}
        data.text_pox = 210
        data.text_poy = 170
        data.str = string.format("<font color='#ffff00'>  开启惊喜魔盒</font>\n魔盒数量：<font color='#00ff00'>%s个</font>",count) 
        data.str_width = 150
        data.vspace = 20
        local function onclickOpen(index)
            SendMsgCallFunByNpc(0,"WelfareHall","OpenSurpriseBox",self.cfg[1].type.."#"..index) 
        end
        data.btn_data = {btn_count = 2,btn_str={"开启一次","开启十次"},btnfun_list = {onclickOpen,onclickOpen}}
        ViewMgr.open("SurpriseBoxBuyTipObj",data)
    end)
    -- SendMsgCallFunByNpc(0,"WelfareHall","InitSurpriseBoxInfo") 

    self:flushSurpriseBox(data.critical,data.double)

    GUI:Text_setString(self.ui.box_price,self.cfg[1].parame3.."元") 
    GUI:Text_setString(self.ui.box_num,SL:GetMetaValue("ITEM_COUNT", "魔盒").."个")  
    self:flushSurpriseBoxRed(SL:GetMetaValue("ITEM_COUNT", "魔盒") > 0)
end

function SurpriseBoxGiftObj:flushOpenBoxTip()
    local count = SL:GetMetaValue("ITEM_COUNT", "魔盒")
    local data = {}
    data.text_pox = 210
    data.text_poy = 170
    data.str = string.format("<font color='#ffff00'>  开启惊喜魔盒</font>\n魔盒数量：<font color='#00ff00'>%s个</font>",count) 
    data.str_width = 150
    data.vspace = 20
    ViewMgr.flushView("SurpriseBoxBuyTipObj",data)
end

function SurpriseBoxGiftObj:flushView( ... )
    local tab = {...}
    if tab[1] == "flush_surprisebox" then
       self:flushSurpriseBox(tab[2],tab[3])
    end
end

function SurpriseBoxGiftObj:flushSurpriseBox(critical,double)
    critical = tonumber(critical)
    GUI:Text_setString(self.ui.box_price,self.cfg[1].parame3.."元") 
    GUI:Text_setString(self.ui.box_num,SL:GetMetaValue("ITEM_COUNT", "魔盒").."个")  
    GUI:Text_setString(self.ui.critical_text,(critical > 0 and critical or 10 ).."%") 
    GUI:Text_setString(self.ui.box_double, tonumber(double) > 0 and "已触发" or "未触发")
    GUI:Text_setTextColor(self.ui.box_double,tonumber(double) > 0 and "#00FF00" or "#E11010")
    self:flushOpenBoxTip()
    self:flushSurpriseBoxRed(SL:GetMetaValue("ITEM_COUNT", "魔盒") >0)
end

function SurpriseBoxGiftObj:flushSurpriseBoxRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.open_box)
        end
    end
end
return SurpriseBoxGiftObj