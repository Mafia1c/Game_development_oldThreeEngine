local ExorcismVenerableOBJ = {}
ExorcismVenerableOBJ.Name = "ExorcismVenerableOBJ"
ExorcismVenerableOBJ.cfg = SL:Require("GUILayout/config/ExorcismVenerableCfg",true)
ExorcismVenerableOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
ExorcismVenerableOBJ.npcId = 389
ExorcismVenerableOBJ.RunAction = true
local attr_list  = {"攻魔道：%s","防魔御：%s","破防抵抗：%s%%","次元之力：%s"}

function ExorcismVenerableOBJ:main(spirit_level)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	--加载UI
	GUI:LoadExport(parent, "npc/ExorcismVenerableUI")
	self.ui = GUI:ui_delegate(parent)

	--关闭按钮
	GUI:addOnClickEvent(self.ui.CloseButton, function()
	  ViewMgr.close(ExorcismVenerableOBJ.Name)
	end)

	GUI:addOnClickEvent(self.ui.upBtn, function()
	  	SendMsgCallFunByNpc(ExorcismVenerableOBJ.npcId,"ExorcismVenerable","UpSpiritLevel")
	end)
	
	self:flushInfo(tonumber(spirit_level))
	
end

function ExorcismVenerableOBJ:flushView(spirit_level)
	self:flushInfo(tonumber(spirit_level))
end

function ExorcismVenerableOBJ:flushInfo(spirit_level)
	local cfg = ExorcismVenerableOBJ.cfg[spirit_level]
	local is_max = spirit_level >= #ExorcismVenerableOBJ.cfg
	local next_cfg = cfg
	if not is_max then
		next_cfg = ExorcismVenerableOBJ.cfg[spirit_level + 1]
	end
	local is_tupo = not is_max and spirit_level > 0 and (spirit_level+1) % 10 == 0
	GUI:setVisible(self.ui.ItemShow_3,is_tupo) 
	if is_tupo then
		GUI:Button_loadTextureNormal(self.ui.upBtn,"res/custom/npc/89zz/an2.png") 
	else
		GUI:Button_loadTextureNormal(self.ui.upBtn,"res/custom/npc/89zz/an1.png") 
	end
	local is_show_red = true
	for i=1,10 do
		if is_max then
			GUI:setGrey(self.ui["ball"..i],false) 
			if self.ui["line_"..i] then
				GUI:setVisible(self.ui["line_"..i],true) 
			end
		else
			GUI:setGrey(self.ui["ball"..i],spirit_level%10 + 1 < i) 
			if self.ui["line_"..i] then
				GUI:setVisible(self.ui["line_"..i],spirit_level%10+1 >= i) 
			end
		end
	end
	for i=1,2 do
		local color = 250
		if SL:GetMetaValue("ITEM_COUNT", cfg["need_item"..i]) < cfg["need_num"..i] then
			is_show_red = false 
			color = 249
		end
		ItemShow_updateItem(self.ui["ItemShow_"..i],{showCount = true,index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg["need_item"..i]),count = cfg["need_num"..i],bgVisible = true,look = true,color = color}) 
	end
	if is_tupo then
		local color = 250
		if tonumber(SL:GetMetaValue("MONEY", "灵符")) < 10000 then
			is_show_red = false 
			color = 149 
		end
		ItemShow_updateItem(self.ui.ItemShow_3,{showCount=true,index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", "灵符"),count = 10000,bgVisible = true,look = true,color=color}) 
	end
	GUI:removeAllChildren(self.ui.effect_node)
	GUI:Effect_Create(self.ui.effect_node,"spirit_effect", 80, 140, 0, cfg.effect_id,0,0,3,1)
	GUI:Text_setString(self.ui["name"],cfg.Name) 
	for i=1,4 do
		GUI:Text_setString(self.ui["text1"..i],string.format(attr_list[i],cfg["attr"..i])) 
		GUI:Text_setString(self.ui["text2"..i],string.format(attr_list[i],next_cfg["attr"..i])) 
	end

	self:flushRed(not is_max and is_show_red)
	GUI:UserUILayout(self.ui.need_box, {
        dir=2,
        autosize = true,
        gap = {x = 5}
    })
end

function ExorcismVenerableOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.upBtn)
        end
    end
end

function ExorcismVenerableOBJ:onClose( ... )
	if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
end
-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == ExorcismVenerableOBJ.npcId then
        -- ViewMgr.open(ExorcismVenerableOBJ.Name)
        SendMsgCallFunByNpc(ExorcismVenerableOBJ.npcId,"ExorcismVenerable","upEvent")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, ExorcismVenerableOBJ.Name, onClickNpc)

return ExorcismVenerableOBJ