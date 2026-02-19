XueMaiTuJianOBJ = {}
XueMaiTuJianOBJ.Name = "XueMaiTuJianOBJ"
XueMaiTuJianOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
local _cfg = SL:Require("GUILayout/config/talentCfg",true)
XueMaiTuJianOBJ.cfg = {}
for k,v in pairs(_cfg) do
	table.insert(XueMaiTuJianOBJ.cfg,v)
end
table.sort(XueMaiTuJianOBJ.cfg , function (a,b)
	return a.buff_id < b.buff_id
end )
function XueMaiTuJianOBJ:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
		--加载UI
	GUI:LoadExport(parent, "npc/XueMaiTuJianUI")
	self.ui = GUI:ui_delegate(parent)

	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
		ViewMgr.close(XueMaiTuJianOBJ.Name)
	end)
	self:flushInfo()
end
function XueMaiTuJianOBJ:flushInfo()
	for i,v in ipairs(self.cfg) do
		local cell = GUI:Image_Create(self.ui.tujian_listview, "cell"..i, 0, 0, "res/custom/npc/27jnds/rq1.png")
		local item = GUI:ItemShow_Create(cell,"item_"..i,48,38,{index = v.key_name,count = 0,bgVisible = false,look = true})
		GUI:setAnchorPoint(item,0.5,0.5)
		local desc = string.format("<%s/FCOLOR=243>		",v.talent_name)..v.color_desc
		local name_rich = GUI:RichTextFCOLOR_Create(cell, "rich_name"..i, 79,40, desc, 200, 16, 250)
		GUI:setAnchorPoint(name_rich,0,0.5)
		local rich = GUI:RichTextFCOLOR_Create(cell, "rich_text"..i, 194,40, v.tujian_desc, 525, 16, 250)
		GUI:setAnchorPoint(rich,0,0.5)
	end
end

return XueMaiTuJianOBJ
