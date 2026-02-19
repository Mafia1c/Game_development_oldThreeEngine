local CrossShopObj = {}
CrossShopObj.Name = "CrossShopObj"
-- CrossShopObj.feijian_cfg = SL:Require("GUILayout/config/kfFeiJianMapCfg",true)
CrossShopObj.shop_cfg = SL:Require("GUILayout/config/CrossShopCfg",true)
function CrossShopObj:main( ... )
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
		--加载UI
	GUI:LoadExport(parent, "npc/CrossShopUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(CrossShopObj.Name)
	end)
	for i=1,2 do
		GUI:addOnClickEvent(self.ui["Button_"..i],function ()
			if i == 1 then
				SendMsgCallFunByNpc(0,"CrossRealmBattlefield","openFeiJianView")
			else
				SendMsgCallFunByNpc(0, "disguiseMap", "openEvent",1)
			end
		end)
	end
	self:FlushShop()
end
function CrossShopObj:FlushShop()
	local line = 0
	local list  = nil
	GUI:removeAllChildren(self.ui.ListView)
	for i,v in ipairs(self.shop_cfg) do
		if (i-1) % 4 == 0  then
			line = line + 1
			list = GUI:ListView_Create(self.ui.ListView, "list"..line, 0, 0, 726, 204, 2)
		 	GUI:ListView_setGravity(list, 2)
		 	GUI:ListView_setItemsMargin(list, 5)
			GUI:setTouchEnabled(list, false)
		end
		local bg = GUI:Image_Create(list,"item_bg"..i,0 ,0,"res/custom/npc/111kfsc/item_bg.png")
		local name = GUI:Text_Create(bg,"name"..i,89,182,16,"#00FF00",v.name)
		GUI:setAnchorPoint(name,0.5,0.5)
		GUI:ItemShow_Create(bg,"item"..i,60,93,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v.name),count = v.num,bgVisible = true,look = true})
		local pice = GUI:Text_Create(bg,"pice"..i,89,66,16,"#ffffff",string.format("%s:%s",v.need_name,v.need_num))
		GUI:setAnchorPoint(pice,0.5,0.5)
		local buy_btn = GUI:Button_Create(bg,"buy"..i,48,10,"res/custom/npc/111kfsc/duihuan1.png")
		GUI:Button_loadTextureDisabled(buy_btn, "res/custom/npc/111kfsc/duihuan1-1.png")
		GUI:addOnClickEvent(buy_btn,function ()
			SendMsgCallFunByNpc(0,"CrossRealmBattlefield","KfShopBuy",v.key_name)
		end)
	end
end

return CrossShopObj