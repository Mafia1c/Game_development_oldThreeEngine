local PosternOfFateTreasureObj = {}
PosternOfFateTreasureObj.Name = "PosternOfFateTreasureObj"
PosternOfFateTreasureObj.cfg = SL:Require("GUILayout/config/PosternOfFateCfg",true)

function PosternOfFateTreasureObj:main(layer, flush_count, reward)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/PosternOfFateTreasureUI", function () end)
    self.ui = GUI:ui_delegate(parent)
	self.layer = tonumber(layer)
	self.flush_count = flush_count or 0
	self.reward_tab = SL:Split(reward, "|")

    GUI:addOnClickEvent(self.ui.closeBtn,function ()
    	ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.reflush_btn,function ()
    	SendMsgCallFunByNpc(0,"PosternOfFateTreasure","flushKapai", "")
    end)

    for i=1,3 do
		GUI:addOnClickEvent(self.ui["award_bg_"..i],function ()
			SendMsgCallFunByNpc(0,"PosternOfFateTreasure","open_kapai", i)
		end)

		GUI:addOnClickEvent(self.ui["open_btn"..i],function ()
			SendMsgCallFunByNpc(0,"PosternOfFateTreasure","open_kapai", i)
		end)

		GUI:addOnClickEvent(self.ui["get_btn"..i],function ()
			SendMsgCallFunByNpc(0,"PosternOfFateTreasure","getAward", i)
		end)
    end

    self:flushUiInfo()
end

function PosternOfFateTreasureObj:flushUiInfo()
	for i = 1, 3 do
		local index = tonumber(self.reward_tab[1]) or 0
		local name = self.reward_tab[2]
		local num = tonumber(self.reward_tab[3])
		local get_state = tonumber(self.reward_tab[4])
		if index == i then
			GUI:ItemShow_updateItem(self.ui["ItemShow_"..i],{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME", name),look=true,bgVisible=true,count=num,color=251})
			GUI:Text_setString(self.ui["item_name"..i], name)
		else
			get_state = 0
		end

		GUI:setVisible(self.ui["ItemShow_"..i], get_state > 0)
		GUI:setVisible(self.ui["item_name"..i], get_state > 0)
		GUI:setVisible(self.ui["get_btn"..i], get_state == 1)
		GUI:setVisible(self.ui["open_btn"..i], 	get_state == 0)
		GUI:setVisible(self.ui["yilingqu_"..i], get_state == 2)
		GUI:Image_loadTexture(self.ui["award_bg_"..i], get_state > 0 and "res/custom/npc/29my/bz/pz1.png" or  "res/custom/npc/29my/bz/pz0.png")
	end

	GUI:Text_setString(self.ui.count_text, string.format("当前剩余刷新次数：%s次",self.flush_count) )
end

function PosternOfFateTreasureObj:flushView(sMsg, flush_count)
	self.flush_count = flush_count or self.flush_count
	self.reward_tab = SL:Split(sMsg or "", "|")
	self:flushUiInfo()
end
return PosternOfFateTreasureObj