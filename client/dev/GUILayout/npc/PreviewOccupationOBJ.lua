local PreviewOccupationOBJ = {}
PreviewOccupationOBJ.Name = "PreviewOccupationOBJ"
PreviewOccupationOBJ.npcId = 419
PreviewOccupationOBJ.xeumai_cfg = SL:Require("GUILayout/config/talentCfg",true)
PreviewOccupationOBJ.recommend_cfg = SL:Require("GUILayout/config/PreviewRecommendCfg",true)
PreviewOccupationOBJ.RunDrag = true

function PreviewOccupationOBJ:main( ... )
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	--加载UI
	GUI:LoadExport(parent, "npc/PreviewOccupationUI",function () end)
	self.ui = GUI:ui_delegate(parent)
	GUI:addOnClickEvent(self.ui.closeBtn,function ()
		ViewMgr.close(PreviewOccupationOBJ.Name)
	end)

	for i=1,9 do
		GUI:addOnClickEvent(self.ui["occupation_btn"..i],function ()
			self:ClickOneBtnCallback(i)	
		end)
	end
	self:ClickOneBtnCallback(1)	
end

function PreviewOccupationOBJ:ClickOneBtnCallback(index)
	for i=1,9 do
		GUI:Button_loadTextureNormal(self.ui["occupation_btn"..i],index == i and "res/custom/npc/666lpxz/tips2.png" or "res/custom/npc/666lpxz/tips.png")
	end
	self:FlushRightInfo(index)
end

function PreviewOccupationOBJ:FlushRightInfo(index)
	for i,v in ipairs(self.recommend_cfg[index].xuemai_key_list) do
		local item = GUI:ItemShow_updateItem(self.ui["xuemai_item"..i],{index = v,count = 1,bgVisible = false,look = false})
		GUI:addOnClickEvent(self.ui["xuemai_box"..i],function ()
			local pos = GUI:getPosition(self.ui["xuemai_box"..i])
	  		GUI:setPosition(self.ui.select_img,pos.x+4,pos.y+2)
	  		self:flushXmInfo(v)
		end)
	end 

	local pos = GUI:getPosition(self.ui["xuemai_box"..1])
	GUI:setPosition(self.ui.select_img,pos.x+4,pos.y+2)
	--血脉
	self:flushXmInfo(self.recommend_cfg[index].xuemai_key_list[1])
	-- --技能
	-- self:FlushSkillInfo(self.recommend_cfg[index].skill_list)
	--动画
	self:FlushXueMaiAni(index)
	self:FlushSkillAni(index)
 	local desc = self.recommend_cfg["desc_"..index]
 	GUI:removeAllChildren(self.ui.skill_desc_box)
	local attr_desc = GUI:RichTextFCOLOR_Create(self.ui["skill_desc_box"], "skill_desc", 6, 155, desc, 300, 13, "#FFFFFF")
		GUI:setAnchorPoint(attr_desc,0,1)
	-- self.ui.skill_desc_box
end

--血脉
function PreviewOccupationOBJ:flushXmInfo(id)
	local cfg = self.xeumai_cfg[id] 
	GUI:removeAllChildren(self.ui.attr_box)
	local name = string.format("</FCOLOR=255><%s/FCOLOR=249>	",cfg.talent_name) 
	if cfg.preview_attr_desc then
		local attr_desc = GUI:RichTextFCOLOR_Create(self.ui["attr_box"], "attr_desc", 6, 155, name..cfg.preview_attr_desc, 300, id == 10344 and 14 or 15, "#FFFFFF")
		GUI:setAnchorPoint(attr_desc,0,1)
	end
	if cfg.preview_com2_desc then
		local attr_desc = GUI:RichTextFCOLOR_Create(self.ui["attr_box"], "attr_com_desc", 5, 130, cfg.preview_com2_desc, 295, 15, "#FFFFFF")
		GUI:setAnchorPoint(attr_desc,0,1)
	end
end
-- --技能
-- function PreviewOccupationOBJ:FlushSkillInfo(skill_list)
-- 	GUI:removeAllChildren(self.ui.ListView_4)
-- 	for i,v in ipairs(skill_list) do
-- 		local cell = GUI:Layout_Create(self.ui.ListView_4, "_cell"..i, 0, 0, 310, 51, false)
-- 	 	local icon = GUI:Image_Create(cell, "_icon"..i, 2, 9, "res/custom/npc/27jnds/icon/"..v..".png")
-- 	 	GUI:setScale(icon,0.7)
-- 	 	local rich = GUI:RichTextFCOLOR_Create(cell, "_rich"..i, 52, 31, self.recommend_cfg[v], 260, 13, "#ffffff")
-- 	 	GUI:setAnchorPoint(rich,0,0.5)
-- 	end 
-- end

function PreviewOccupationOBJ:FlushXueMaiAni(index)
	local occupation_index = math.ceil(index/3)
	GUI:removeAllChildren(self.ui.xuemai_box)
	local ext = {
		count = 181,
		speed = 100,
		loop = -1,
 	}
    local frames = GUI:Frames_Create(self.ui.xuemai_box, "Frames_1", 0,0, "res/custom/npc/666lpxz/"..occupation_index .."/"..index .."/frame_", ".png", 1, 181, ext)
    GUI:setScale(frames,0.8)
end

function PreviewOccupationOBJ:FlushSkillAni(index)
	local occupation_index = math.ceil(index/3)
	local count = 0
	if occupation_index == 1 then
		count = 84
	elseif occupation_index == 2 then
		count = 116
	else
		count = 119
	end
	GUI:removeAllChildren(self.ui.skill_box)
	local ext = {
		count = count,
		speed = 100,
		loop = -1,
 	}
    local frames = GUI:Frames_Create(self.ui.skill_box, "Frames_2", 0,0, "res/custom/npc/666lpxz/jineng/"..occupation_index .."/frame_", ".png", 1, count, ext)
    GUI:setScale(frames,0.8)
end

-- -- 点击npc触发(对应npcList表id)
-- local function onClickNpc(npc_info)
--     if npc_info.index == PreviewOccupationOBJ.npcId then
--         ViewMgr.open(PreviewOccupationOBJ.Name)
--     end
-- end

-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, PreviewOccupationOBJ.Name, onClickNpc)

return PreviewOccupationOBJ