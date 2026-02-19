local CrossRealmBattlefieldOBJ = {}
CrossRealmBattlefieldOBJ.Name = "CrossRealmBattlefieldOBJ"
CrossRealmBattlefieldOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
CrossRealmBattlefieldOBJ.cfg = SL:Require("GUILayout/config/CrossRealmBattleCfg",true)
CrossRealmBattlefieldOBJ.shop_cfg = SL:Require("GUILayout/config/CrossRealmShopCfg",true)
function CrossRealmBattlefieldOBJ:main( ... )
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
		--加载UI
	GUI:LoadExport(parent, "npc/CrossRealmBattlefieldUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(CrossRealmBattlefieldOBJ.Name)
	end)
	for i=1,3 do
		GUI:addOnClickEvent(self.ui["btn"..i],function ()
			self.cur_page = i
			self:flushInfo()
			self:FlushBtnShow(i)
		end)
	end
	self:FlushBtnShow(1)
	self.cur_page = 1
	self:flushInfo()
end

function CrossRealmBattlefieldOBJ:FlushBtnShow(index)
	for i=1,3 do
		if i == index then
			GUI:Button_loadTextureNormal(self.ui["btn"..i],"res/custom/npc/48kf/c_"..i.."_1.png")
		else
			GUI:Button_loadTextureNormal(self.ui["btn"..i],"res/custom/npc/48kf/c_"..i.."_0.png")
		end
	end
	GUI:Image_loadTexture(self.ui.bg_Image,"res/custom/npc/48kf/bg"..index ..".png") 	
end
function CrossRealmBattlefieldOBJ:flushView(...)
	local tab = {...}
	if tab[1] == "flush_zhanling" then
		if self.ui.down_desc then
	        GUI:removeFromParent(self.ui.down_desc)
	        self.ui = GUI:ui_delegate(self._parent)
	    end
		local zhanling_num = SL:GetMetaValue("MONEY_ASSOCIATED",25)
		GUI:RichText_Create(self.ui.view_box,"down_desc",5,5,string.format("<font color='#ffff00'>当前战令数量：%s</font><font color='#00ff00'>（提示：战令唯一获得方式为参与跨服活动）</font>",zhanling_num) ,700)
	end
end
function CrossRealmBattlefieldOBJ:flushInfo()
	GUI:removeAllChildren(self.ui.view_box)
	if self.cur_page == 1 then  --跨服沙城
		local str = "<font color='#ffff00'>进入条件：</font><font color='#00ff00'>等级60级+狂暴之力+4转！</font>\n<font color='#ffff00'>参与跨服沙城的胜利方可获得胜方行会奖励\n活动结束时，奖励自动结算，必须在跨服区域！！</font>\n合区后，每周三，周六<font color='#9b00ff'>21:05-22:05</font>点开放"
		GUI:RichText_Create(self.ui.view_box,"rich_desc1",5,35,str,380)
		local bg = GUI:Image_Create(self.ui.view_box,"right_bg",385,230,"res/custom/npc/48kf/rq3.png")
		GUI:Image_setScale9Slice(bg, 32, 32, 28, 28)
		GUI:setContentSize(bg, 324,169)
		GUI:Text_Create(bg,"award_title",10,140,16,"#ffff00","城主专属足迹奖励")
		local str2 = "<font color='#00FF00'>攻魔道：9-9\n防魔御：9-9</font>\n<font color='#E11010'>生命值：9%</font>\n自获得起持续7天"
		GUI:RichText_Create(bg,"rich_desc2",10,20,str2,160,16,"#ffffff",10)
		GUI:Effect_Create(bg,"effect",200,100,0,46139)
		GUI:Text_Create(self.ui.view_box,"award_desc",400,180,16,"#ffff00","灵符*200 战令*500 金刚石*1000 声望*100")
		GUI:Text_Create(self.ui.view_box,"award_desc2",387,125,16,"#00FF00","跨服沙城攻城区域，每10秒获得【战令*1】")
		GUI:Text_Create(self.ui.view_box,"award_desc3",387,100,16,"#00FF00","跨服沙城皇宫区域，每10秒获得【战令*3】")
		local goto_btn = GUI:Button_Create(self.ui.view_box,"btn",500,45,"res/public/1900001023.png")
		GUI:Button_setTitleText(goto_btn,"立即前往")
		GUI:Button_setTitleFontSize(goto_btn,16)
		GUI:Button_setTitleColor(goto_btn,"#efd6ad")
		GUI:addOnClickEvent(goto_btn,function ()
			SendMsgCallFunByNpc(0,"CrossRealmBattlefield","GotoShaCheng")
		end)
		GUI:Text_Create(self.ui.view_box,"down_desc",0,5,17,"#00FF00","系统结算奖励时，仅计算在跨服区域内的角色，不在区域内的一概无法获得活动奖励，请各位注意")
	elseif self.cur_page == 2 then  --跨服战场
		for i,v in ipairs(CrossRealmBattlefieldOBJ.cfg) do
			local bg = GUI:Image_Create(self.ui.view_box,"right_bg"..i,360 * (i -1)+8 ,33,"res/custom/npc/48kf/rq1.png")
			GUI:Image_Create(bg,"bibao"..i,280,210,"res/custom/npc/48kf/b"..i..".png")
			local effect = GUI:Effect_Create(bg,"effect"..i,180,180,2,v.boss_id,0,0,5)
			GUI:setScale(effect,0.5,0.5)
			GUI:Image_Create(bg,"title"..i,125,368,"res/custom/npc/48kf/t"..i..".png")
			GUI:RichText_Create(bg,"enter_desc"..i,40,165,"<font color='#ffff00'>进入条件：</font><font color='#00ff00'>等级60级+狂暴之力+4转！</font>",300)
			for index,item in ipairs(v.reward_arr) do
				GUI:ItemShow_Create(bg,"award_item"..i.."_"..index,65 *(index - 1) + 45,90,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", item),count = 1,bgVisible = true,look = true})
			end
			local goto_btn = GUI:Button_Create(bg,"goto"..i,135,40,"res/public/1900001023.png")
			GUI:addOnClickEvent(goto_btn,function ()
				SendMsgCallFunByNpc(0,"CrossRealmBattlefield","GotoBoss",i)
			end)
			GUI:Button_setTitleText(goto_btn,"立即前往")
			GUI:Button_setTitleFontSize(goto_btn,16)
			GUI:Button_setTitleColor(goto_btn,"#efd6ad")
			GUI:RichText_Create(bg,"time"..i,80,15,string.format("合区后，每日<font color='#00ff00'>%s</font>开放",v.open_time) ,200)
		end
		GUI:Text_Create(self.ui.view_box,"down_desc",5,5,17,"#00FF00","参加跨服战场需加入行会，BOSS无归属，击杀方行会成员奖励【战令*200金刚石*500声望*500】")
	else  --战令商城
		local scroll_list = GUI:ScrollView_Create(self.ui.view_box, "scroll_list", 0,30, 727, 414, 1)
		GUI:ScrollView_setBounceEnabled(scroll_list, true)
		local line = 0
		local list  = nil
		for i,v in ipairs(CrossRealmBattlefieldOBJ.shop_cfg) do
			if (i-1) % 4 == 0  then
				line = line + 1
				list = GUI:ListView_Create(scroll_list, "list"..line, 0, 0, 726, 204, 2)
			 	GUI:ListView_setGravity(list, 2)
			 	GUI:ListView_setItemsMargin(list, 5)
				GUI:setTouchEnabled(list, false)
			end
			local bg = GUI:Image_Create(list,"item_bg"..i,0 ,0,"res/custom/npc/48kf/rq2.png")
			local name = GUI:Text_Create(bg,"name"..i,40,170,16,"#00FF00",v.item_name)
			GUI:Text_setTextAreaSize(name, {width = 100, height = 20})
			GUI:Text_setTextHorizontalAlignment(name,1)
			GUI:ItemShow_Create(bg,"item"..i,60,93,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v.item_name),count = v.num,bgVisible = true,look = true})
			local pice = GUI:Text_Create(bg,"pice"..i,45,55,16,"#ffffff","战令价格:"..v.need)
			GUI:Text_setTextAreaSize(pice, {width = 100, height = 20})
			GUI:Text_setTextHorizontalAlignment(pice,1)
			local buy_btn = GUI:Button_Create(bg,"buy"..i,53,10,"res/custom/npc/48kf/an.png")
			GUI:addOnClickEvent(buy_btn,function ()
				SendMsgCallFunByNpc(0,"CrossRealmBattlefield","BuyItem",v.key_name)
			end)
		end
		local zhanling_num = SL:GetMetaValue("MONEY_ASSOCIATED",25)
		GUI:RichText_Create(self.ui.view_box,"down_desc",5,5,string.format("<font color='#ffff00'>当前战令数量：%s</font><font color='#00ff00'>（提示：战令唯一获得方式为参与跨服活动）</font>",zhanling_num) ,700)
		GUI:UserUILayout(scroll_list, {
	        dir=1,
	        addDir=1,
	        gap = {y=2},
	    })
	end
end

return CrossRealmBattlefieldOBJ