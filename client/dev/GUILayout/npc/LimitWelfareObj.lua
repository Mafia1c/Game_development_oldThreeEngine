local LimitWelfareObj = {}
LimitWelfareObj.Name = "LimitWelfareObj"
LimitWelfareObj.cfg = {}
local _cfg = SL:Require("GUILayout/config/welfareHallcfg",true)
for i,v in ipairs(_cfg) do
    if v.type == 10 then
        table.insert(LimitWelfareObj.cfg,v)
    end
end
function LimitWelfareObj:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LimitWelfareUI", function () end)
    self.ui = GUI:ui_delegate(parent)
	self.remain_time = tonumber(sMsg) or 0
	
    GUI:addOnClickEvent(self.ui.closeBtn,function ()
    	ViewMgr.close(LimitWelfareObj.Name)
    end)

    GUI:addOnClickEvent(self.ui.buy_btn,function ()
    	local gift_tab = GameData.GetData("TL_Recharge_hasGift",true) or {} --#region 充值过的礼包
		local gift_index = gift_tab["gift_xsfl"..1] == nil and 1 or 2
		SendMsgCallFunByNpc(0,"WelfareHall","LimitWelfareHallBuy",gift_index) 
    end)
    self:FlushInfo()
end

function LimitWelfareObj:FlushInfo()
	if self.cfg == nil then return end
	local gift_tab = GameData.GetData("TL_Recharge_hasGift",true) or {} --#region 充值过的礼包
	local gift_index = gift_tab["gift_xsfl"..1] == nil and 1 or 2
	local cfg = self.cfg[gift_index]
	for index,item in ipairs(cfg.award1_map) do
		ItemShow_updateItem(self.ui["ItemShow_"..index],{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", item[1]),count = item[2],bgVisible = true,look = true,color=255})
	end
	local bg_img = gift_index == 1 and "res/custom/npc/42xsfl/bg.png" or "res/custom/npc/42xsfl/bg1.png"
	GUI:Image_loadTexture(self.ui.FrameBG,bg_img) 
	local btn_img = gift_index == 1 and "res/custom/npc/42xsfl/6r" or "res/custom/npc/42xsfl/12r"
	GUI:Button_loadTextureNormal(self.ui.buy_btn,btn_img..".png")
	GUI:Button_loadTexturePressed(self.ui.buy_btn,btn_img.."1.png")
	ItemShow_updateItem(self.ui["ItemShow_9"],{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",gift_index==1 and "战神盾牌" or "战神兵符"),count = 1,bgVisible = true,look = true,color=255})

	GUI:Text_COUNTDOWN(self.ui.time_text_1, self.remain_time, function ()
		SL:Print("时间到!")
	end, 1)
end

function LimitWelfareObj:flushView(_type, sMsg)
	self.remain_time = tonumber(sMsg) or 0
	self:FlushInfo()
end

return LimitWelfareObj