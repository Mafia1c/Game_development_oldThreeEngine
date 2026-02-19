local CrossFeiJianOBJ = {}
CrossFeiJianOBJ.Name = "CrossFeiJianOBJ"
CrossFeiJianOBJ.feijian_cfg = SL:Require("GUILayout/config/kfFeiJianMapCfg",true)
CrossFeiJianOBJ.name_list = {"玄冰剑尊·紫宸","苍玄法圣·墨渊","幽蓝妖姬·溟汐","赤阳神君·燎天"}
function CrossFeiJianOBJ:main(enter_count,boss_info,layer)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
		--加载UI
	GUI:LoadExport(parent, "npc/CrossFeiJianUI")
	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(CrossFeiJianOBJ.Name)
	end)

	GUI:addOnClickEvent(self.ui.enter_btn, function()
		SendMsgCallFunByNpc(0,"CrossRealmBattlefield","GotoFeiJianMap",self.cur_feijian_index)
	end)
	self.boss_stete_obj_list = {}
	SL:Print(layer)
	self.cur_feijian_index = tonumber(layer) 
	for i,v in ipairs(self.feijian_cfg) do
		local btn = GUI:Button_Create(self.ui.btn_list_view,"feijian_page"..i,0,0,"res/custom/npc/110feijian/yeqian1.png")
		GUI:Button_setTitleText(btn,"无双飞剑"..i.."层")
		GUI:Button_setTitleFontSize(btn,16)
		GUI:addOnClickEvent(btn,function ()
			SendMsgCallFunByNpc(0,"CrossRealmBattlefield","requestBossInfo",i) 
		end)
	end
	GUI:Text_setString(self.ui.enter_num,string.format("今日剩余挑战次数：%s次",enter_count))
	self:flushFeiJianInfo()
	self:flushBossState(SL:JsonDecode(boss_info))
end

function CrossFeiJianOBJ:flushFeiJianInfo()
	for i,v in ipairs(self.feijian_cfg) do
		GUI:Button_loadTextureNormal(self.ui["feijian_page"..i],self.cur_feijian_index == i and "res/custom/npc/110feijian/yeqian1.png" or "res/custom/npc/110feijian/yeqian2.png" )
	end
	local cfg = self.feijian_cfg[self.cur_feijian_index]
	local boss_list = string.split(cfg.boss_list,"|") 
	local split_str = string.split(cfg.zhuashu_drop,"|") 
	for i=1,4 do
		GUI:Text_setString(self.ui["boss_name"..i], self.name_list[i]) 
		local drop = string.split(split_str[i],"#") 
		for item_index=1,2 do
			local item_list = string.split(drop[item_index],",") 
			ItemShow_updateItem(self.ui["drop_item"..i.."_"..item_index],{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", item_list[1]),count = tonumber(item_list[2]),bgVisible = true,look = true,color = 255})
		end
	end
	GUI:removeAllChildren(self.ui.award_list)
	local kill_award = string.split(cfg.kill_award,"&") 
	for i,v in ipairs(kill_award) do
		local str_item = string.split(v,"#") 
		local item = GUI:ItemShow_Create(self.ui.award_list,"fj_award_item"..i,33 + (i-1)*60,29,{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", str_item[1]),count = tonumber(str_item[2]) ,bgVisible = true,look = true})
		ItemShow_updateItem(item,{showCount = true, index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", str_item[1]),count = tonumber(str_item[2]) ,bgVisible = true,look = true,color = 255})
		GUI:setAnchorPoint(item,0.5,0.5) 
	end
end
function CrossFeiJianOBJ:flushView( ... )
	local tab = {...}
	if tab[1] == "flush_boss_info" then
		self.cur_feijian_index = tonumber(tab[3]) 
		self:flushBossState(SL:JsonDecode(tab[2]))
		self:flushFeiJianInfo()
	end
end

function CrossFeiJianOBJ:flushBossState(boss_info)
	for k,v in pairs(self.boss_stete_obj_list) do
		GUI:removeFromParent(v)
	end
	self.boss_stete_obj_list = {}
	self.ui = GUI:ui_delegate(self._parent)
	if boss_info == "" or boss_info == nil then
		return 
	end
	local cfg = self.feijian_cfg[self.cur_feijian_index]
	local boss_list = string.split(cfg.boss_list,"|") 
	for i=1,4 do
		local boss_name = boss_list[i]
		if boss_info and boss_info[boss_name] then
			local boss_time = tonumber(boss_info[boss_name])
			if boss_time > 0 then
				local text = GUI:Text_Create(self.ui["boss_item"..i],"time_text_desc"..i,15,14,16,"#FF0000","刷新倒计时：")
				local time_text = GUI:Text_Create(self.ui["boss_item"..i],"time_text"..i,104,13,16,"#FF0000","")
				GUI:Text_COUNTDOWN(time_text,boss_time,function ()
					GUI:Text_setString(time_text,"已刷新") 
					GUI:Text_setTextColor(time_text,"#00ff00") 
					GUI:Text_setTextColor(text,"#00ff00") 
				end,1)
				self.boss_stete_obj_list[text] = text
				self.boss_stete_obj_list[time_text] = time_text
			else
				local text = GUI:Text_Create(self.ui["boss_item"..i],"time_text"..i,90,25,16,"#00ff00","刷新状态：已刷新")
				GUI:setAnchorPoint(text,0.5,0.5)
				self.boss_stete_obj_list[text] = text
			end
		end
	end 
end
return CrossFeiJianOBJ