local PreviewSkillOBJ = {}
PreviewSkillOBJ.Name = "PreviewSkillOBJ"
PreviewSkillOBJ.npcId = 245
PreviewSkillOBJ.cfg = SL:Require("GUILayout/config/talentCfg",true)
local xuemai_list = {
	[1] = {10712,10344,10345,10355,10351,10346},
	[2] = {10346,10352,10344,10349,10345,10351},
	[3] = {10346,10353,10354,10352,10349,10351},
}
function PreviewSkillOBJ:main( ... )
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	--加载UI
	GUI:LoadExport(parent, "npc/PreviewSkillUI")
	self.ui = GUI:ui_delegate(parent)
	GUI:addOnClickEvent(self.ui.closeBtn,function ()
		ViewMgr.close(PreviewSkillOBJ.Name)
	end)
	self.spine = GUI:Spine38Anim_Create(self.ui.spine_box, "Spine_role", 180, 90, "res/custom/npc/245jnzs/skill_preview.json","res/custom/npc/245jnzs/skill_preview.atlas", 1, "default", true)
	for i=1,4 do
		GUI:addOnClickEvent(self.ui["Button_"..i],function ()
			self:flushRightShow(i,self.sex_index or 5)
		end)
	end
	for i=5,6 do
		GUI:addOnClickEvent(self.ui["sex_btn"..i],function ()
			self:changeSex(i)
		end)
	end
	self:changeSex(5)
	
end

function PreviewSkillOBJ:changeSex(index)
	self.sex_index= index
	for i=5,6 do
		if i == index then
			GUI:Button_loadTextureNormal(self.ui["sex_btn"..i], string.format("res/custom/npc/245jnzs/icon_cjzy_0%s_1.png",i) ) 
		else
			GUI:Button_loadTextureNormal(self.ui["sex_btn"..i], string.format("res/custom/npc/245jnzs/icon_cjzy_0%s.png",i) ) 
		end
	end
	GUI:removeAllChildren(self.ui.model_box) 
	if index == 5 then
		self.job_spine = GUI:Spine38Anim_Create(self.ui.model_box, "Spine_job", 140, 150, "res/custom/npc/245jnzs/job1_preview.json","res/custom/npc/245jnzs/job1_preview.atlas", 1, "default", true)
	else
		self.job_spine = GUI:Spine38Anim_Create(self.ui.model_box, "Spine_job", 115, 150, "res/custom/npc/245jnzs/job_preview.json","res/custom/npc/245jnzs/job_preview.atlas", 1, "default", true)
	end
	self:flushRightShow( self.job_index or 1,index)
end

function PreviewSkillOBJ:flushRightShow(index,sex)
	if index == 4 then
		index = math.random(1,3)
	end
	self.job_index = index 
	for i=1,3 do
		if i == index then
			GUI:Button_loadTextureNormal(self.ui["Button_"..i], string.format("res/custom/npc/245jnzs/icon_cjzy_0%s_1.png",i) ) 
		else
			GUI:Button_loadTextureNormal(self.ui["Button_"..i], string.format("res/custom/npc/245jnzs/icon_cjzy_0%s.png",i) ) 
		end
	end
	GUI:SpineAnim_setAnimation(self.job_spine, 0, "spine_"..index - 1, true)
	if sex == 6 then
		if index == 2 then
			GUI:setPosition(self.job_spine,115, 190)
		elseif index == 3 then
			GUI:setPosition(self.job_spine,115, 140)
		else
			GUI:setPosition(self.job_spine,115, 150)
		end
	else
		if index == 3 then
			GUI:setPosition(self.job_spine,135, 140)
		else
			GUI:setPosition(self.job_spine,140, 150)
		end
	end
	if index ==2 then
		GUI:setScale(self.job_spine,0.9)
	elseif index == 3 then
		GUI:setScale(self.job_spine,0.95)
	else
		GUI:setScale(self.job_spine,1)
	end
	GUI:SpineAnim_setAnimation(self.spine, 0, "spine_"..index - 1, true)
	for i,v in ipairs(xuemai_list[index]) do
		local item = GUI:ItemShow_updateItem(self.ui["xuemai_item"..i],{index = v,count = 1,bgVisible = false,look = false})
		GUI:addOnClickEvent(self.ui["xuemai_box"..i],function ()
			local pos = GUI:getPosition(self.ui["xuemai_box"..i])
	  		GUI:setPosition(self.ui.select_img,pos.x+5,pos.y+3)
	  		self:flushXmInfo(v)
		end)
	end 
	local pos = GUI:getPosition(self.ui["xuemai_box"..1])
	GUI:setPosition(self.ui.select_img,pos.x+5,pos.y+3)
	self:flushXmInfo(xuemai_list[index][1])

end

function PreviewSkillOBJ:flushXmInfo(id)
	local cfg = self.cfg[id] 
	GUI:removeAllChildren(self.ui.attr_box)
	GUI:ItemShow_updateItem(self.ui["ItemShow_1"], {index = id,count = 0,bgVisible = false,look = true})
	local layer_desc = string.format("		<当前层数:/FCOLOR=255><%s/FCOLOR=249>/<%s/FCOLOR=250>层",1,1)
	GUI:RichTextFCOLOR_Create(self.ui["attr_box"], "item_name", 60, 110, cfg.talent_name..layer_desc, 200, 16, "#ff9b00")
	if cfg.preview_attr_desc then
		local attr_desc = GUI:RichTextFCOLOR_Create(self.ui["attr_box"], "attr_desc", 60, 100, cfg.preview_attr_desc, 300, id ==10344 and 13 or 14, "#FFFFFF")
		GUI:setAnchorPoint(attr_desc,0,1)
	end
	if cfg.preview_com_desc then
		local attr_desc = GUI:RichTextFCOLOR_Create(self.ui["attr_box"], "attr_com_desc", 5, 70, cfg.preview_com_desc, 300, 14, "#FFFFFF")
		GUI:setAnchorPoint(attr_desc,0,1)
	end
end
-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == PreviewSkillOBJ.npcId then
        ViewMgr.open(PreviewSkillOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, PreviewSkillOBJ.Name, onClickNpc)

return PreviewSkillOBJ