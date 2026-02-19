local DarkMonarchOBJ = {}
DarkMonarchOBJ.Name = "DarkMonarchOBJ"
DarkMonarchOBJ.cfg = SL:Require("GUILayout/config/DarkMonarchCfg",true)
DarkMonarchOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
DarkMonarchOBJ.npcId = 294
DarkMonarchOBJ.RunAction = true

function DarkMonarchOBJ:main(active_flag)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.key_index = 0
	self.active_list = {}
	--加载UI
	GUI:LoadExport(parent, "npc/DarkMonarchUI")

	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(DarkMonarchOBJ.Name)
	end)

	GUI:addOnClickEvent(self.ui.JieFengBtn,function ()
		SendMsgCallFunByNpc(DarkMonarchOBJ.npcId,"DarkMonarch","JieFengClick",self.select_btn_index) 
	end)

	for i=1,5 do
		GUI:addOnClickEvent(self.ui["section_cell"..i],function ()
			DarkMonarchOBJ:FlushBtnShow(i)
			DarkMonarchOBJ:FlushRightInfo(i)
		end) 
	end

	for i=1,5 do
		GUI:setGrey(self.ui["section_cell"..i],true)	
	end
	self.active_flag = SL:JsonDecode(active_flag)
	DarkMonarchOBJ:FlushBtnShow(1)
	DarkMonarchOBJ:FlushRightInfo(1)

end

function DarkMonarchOBJ:flushView(...)
	local tab = {...}
	self.active_flag = SL:JsonDecode(tab[1])
	self:FlushBtnShow(tonumber(tab[2]))
	self:FlushRightInfo(tonumber(tab[2]))
end

function DarkMonarchOBJ:FlushBtnShow(btn_index)
	self.select_btn_index = btn_index
	for i=1,5 do
		GUI:setGrey(self.ui["section_cell"..i],i ~= btn_index)	
	end
	local pos = GUI:getPosition(self.ui["section_cell"..btn_index])
	GUI:setPosition(self.ui.select_hl_img,pos) 
end

function DarkMonarchOBJ:FlushRightInfo(btn_index)
	local cfg = DarkMonarchOBJ.cfg[btn_index]
	local index = 1
	local is_show_red = true
	for k,v in pairs(cfg.nedd_map) do
		local count = SL:GetMetaValue("ITEM_COUNT", k)
		local color = count >= v and 250 or 249
		if count < v then
			is_show_red = false
		end 
		GUI:ItemShow_updateItem(self.ui["NeedItem_"..index],{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", k),count = v,bgVisible = true,look = true,color = color}) 
		index = index + 1 
	end
	ItemShow_updateItem(self.ui["NeedItem_3"],{showCount = true,index =SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.Name),count = 1,bgVisible = true,look = true,color = 251}) 

	self:flushRed(is_show_red and not self:GetIsActive(btn_index)) 
end

function DarkMonarchOBJ:GetIsActive(index)
    if self.active_flag == "" then
        return false
    end
    for i,v in ipairs(self.active_flag) do
        if tonumber(v) == tonumber(index)  then
           return true 
        end
    end
    return false
end

function DarkMonarchOBJ:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.JieFengBtn)
        end
    end
end
function DarkMonarchOBJ:onClose( ... )
	if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end
end
-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == DarkMonarchOBJ.npcId then
        -- ViewMgr.open(DarkMonarchOBJ.Name)
        SendMsgCallFunByNpc(DarkMonarchOBJ.npcId,"DarkMonarch","upEvent") 
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, DarkMonarchOBJ.Name, onClickNpc)

return DarkMonarchOBJ