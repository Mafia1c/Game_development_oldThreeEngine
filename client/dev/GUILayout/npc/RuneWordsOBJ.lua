local RuneWordsOBJ = {}
RuneWordsOBJ.Name = "RuneWordsOBJ"
RuneWordsOBJ.cfg = SL:Require("GUILayout/config/RuneWordsCfg",true)
RuneWordsOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
RuneWordsOBJ.npcId = 289
RuneWordsOBJ.RunAction = true

function RuneWordsOBJ:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
	self._parent = parent
	self.old_idx = nil
	self.key_index = 0
	self.active_list = {}
	--加载UI
	GUI:LoadExport(parent, "npc/RuneWordsUI")

	self.ui = GUI:ui_delegate(parent)
	--关闭按钮
	GUI:addOnClickEvent(self.ui.closeBtn, function()
	  ViewMgr.close(RuneWordsOBJ.Name)
	end)
	self.red_width_list = {}
	local tab = {...}
	self.active_list = SL:JsonDecode(tab[2])
	self:InitListView()
end

function RuneWordsOBJ:flushView(...)
	local param = {...}
	self.active_list = SL:JsonDecode(param[2])
	if param[1] == "FlushSigleItem" then
		self:FlushSigleItem(tonumber(param[3]))
	end
end

function RuneWordsOBJ:InitListView()
	for i,v in ipairs(RuneWordsOBJ.cfg) do
		local bg = GUI:Image_Create(self.ui.ListView,"item_bg"..i,0,0,"res/custom/npc/68fw/k.png")
		local item_cell = GUI:ItemShow_Create(bg,"item_cell"..i,38,43,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v.itemname),count = 1,bgVisible = false,look = true})
		GUI:setAnchorPoint(item_cell,0.5,0.5)

		local btn_img = self:GetIsActive(i) and "res/custom/npc/68fw/an1.png" or "res/custom/npc/68fw/jiemi2.png"
		local btn = GUI:Button_Create(bg,"item_cell_btn"..i,38,-20,btn_img)
		self:flushRed(i,SL:GetMetaValue("ITEM_COUNT", v.itemname) > 0)
		SL:GetMetaValue("ITEM_COUNT", itemName)
		GUI:setAnchorPoint(btn,0.5,0.5)
		GUI:addOnClickEvent(btn,function ()
			SendMsgCallFunByNpc(RuneWordsOBJ.npcId,"RuneWords","ActiveClick",i)
		end)
	end
	self.ui = GUI:ui_delegate(self._parent)
	
	GUI:UserUILayout(self.ui.ListView, {
        dir=3,
        addDir=1,
        colnum = 4,
        gap = {x = 30,y = 50,l=20},
    })
    GUI:Text_setString(self.ui.has_active_num,string.format("已解密数量：%s件",#self.active_list) ) 
end

function RuneWordsOBJ:FlushSigleItem(index)
	local btn_img = self:GetIsActive(index) and "res/custom/npc/68fw/an1.png" or "res/custom/npc/68fw/jiemi2.png"
	GUI:Button_loadTextureNormal(self.ui["item_cell_btn".. tonumber(index)],btn_img) 
	GUI:Text_setString(self.ui.has_active_num,string.format("已解密数量：%s件",#self.active_list) ) 
	local name = RuneWordsOBJ.cfg[tonumber(index)].itemname
	self:flushRed(tonumber(index),SL:GetMetaValue("ITEM_COUNT", name) > 0)
end

function RuneWordsOBJ:GetIsActive(index)
	if self.active_list == nil then return false end 
	for i,v in ipairs(self.active_list ) do
		if tonumber(v) == tonumber(index) then
			return true
		end  
	end
	return false
end
function RuneWordsOBJ:flushRed(index,is_show_red)
    if self.red_width_list[index]then
        GUI:removeFromParent(self.red_width_list[index])
        self.red_width_list[index] = nil
    end 
    if is_show_red then
        if self.red_width_list[index] == nil then
            self.red_width_list[index] = SL:CreateRedPoint(self.ui["item_cell_btn"..index])
        end
    end
end
function RuneWordsOBJ:onClose()
	for k,v in pairs(self.red_width_list) do
		if v then
			GUI:removeFromParent(v)
		end
	end
	self.red_width_list = {}
end
-- 点击npc触发(对应npcList表id)
local function onClickNpc(npc_info)
    if npc_info.index == RuneWordsOBJ.npcId then
        -- ViewMgr.open(RuneWordsOBJ.Name)
        SendMsgCallFunByNpc(RuneWordsOBJ.npcId,"RuneWords","upEvent")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, RuneWordsOBJ.Name, onClickNpc)

return RuneWordsOBJ