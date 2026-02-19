local AncientAlienWorldTwoTip = {}
AncientAlienWorldTwoTip.Name = "AncientAlienWorldTwoTip"
AncientAlienWorldTwoTip.cfg = SL:Require("GUILayout/config/AncientAlienWorldCfg",true)
AncientAlienWorldTwoTip.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
AncientAlienWorldTwoTip.RunAction = true
local str = "<font color='#ffff00' >集结队伍，击败BOSS</font><font color='#e021e0' >%s</font><br><font color='#00ff00'>120秒内击败BOSS，</font><font color='#ffff00'>副本内的角色</font><font color='#00ff00' >可获得通过次数</font><br><font color='#ffff00' >完成通关要求，可获得奖励</font><font color='#ffffff' >(累计奖励需按顺序领取)</font><br><font color='#ffff00'  >远古异界：该团本内所有伤害</font><font color='#ff0000' >降低%s%%</font><br><font color='#ffffff' >团本伤害减少不与异界大陆之力叠加</font><br><font color='#00ffe8'>该团本已通关次数：%s</font>"
function AncientAlienWorldTwoTip:main(...)
	local tab = {...}
	local index = tonumber(tab[1]) 
	local total_num = tonumber(tab[2]) 
	local week_num = tonumber(tab[3]) 
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/AncientAlienWorldTwoUI")

	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.FrameLayout1, function()
	  ViewMgr.close(AncientAlienWorldTwoTip.Name)
	end)

	GUI:addOnClickEvent(self.ui.enter_map,function ()
		SendMsgCallFunByNpc(0,"AncientAlienWorld","EneterMap",index) 		
	end)

	GUI:addOnClickEvent(self.ui.week_get_btn,function ()
		SendMsgCallFunByNpc(0,"AncientAlienWorld","GetWeekAward",index)
	end)

	GUI:addOnClickEvent(self.ui.total_get_btn,function ()
		SendMsgCallFunByNpc(0,"AncientAlienWorld","GetTotalAward",index)
	end)

	GUI:addOnClickEvent(self.ui.team_btn,function ( ... )
		SL:JumpTo(17)
	end) 

	self:FlushInfo(index,total_num,week_num)
end

function AncientAlienWorldTwoTip:FlushInfo(index,total_num,week_num)
	local cfg = AncientAlienWorldTwoTip.cfg[index]
	
	GUI:Image_loadTexture(self.ui.title_img,string.format("res/custom/npc/86yj/tb/t%s.png",index) )	
	GUI:ItemShow_updateItem(self.ui.week_item,{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.award_item),count = cfg.award_item_num,bgVisible = true,look = true}) 
	GUI:Text_setString(self.ui.week_num, (week_num > cfg.week_pass_num and cfg.week_pass_num or  week_num ) .."/"..cfg.week_pass_num.."次")
	GUI:ItemShow_updateItem(self.ui.total_item,{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.award_title),count = 1,bgVisible = true,look = true}) 
	GUI:Text_setString(self.ui.total_num,(total_num > cfg.total_pass_num and cfg.total_pass_num or total_num)  .. "/"..cfg.total_pass_num.."次")
	GUI:Text_setString(self.ui.need_desc,string.format("【%sx%s】",cfg.need_item,cfg.need_num))
	if self.ui.rich_desc then
        GUI:removeFromParent(self.ui.rich_desc)
    	self.ui = GUI:ui_delegate(self._parent)
    end
	local rich = GUI:RichText_Create(self.ui.FrameLayout1,"rich_desc",430,475,string.format(str,cfg.boss_name,cfg.resistance_harm,total_num),430,16,"#ffffff",10)
	GUI:setAnchorPoint(rich,0,1) 
	GUI:setVisible(self.ui.week_get_flag,week_num > cfg.week_pass_num)  
	GUI:setVisible(self.ui.week_get_flag,total_num > cfg.total_pass_num)  
end

function AncientAlienWorldTwoTip:flushView( ... )
	local tab = {...}
	if tab[1] == "flush_info" then
		self:FlushInfo(tonumber(tab[2]),tonumber(tab[3]),tonumber(tab[4]))
	end
end

return AncientAlienWorldTwoTip