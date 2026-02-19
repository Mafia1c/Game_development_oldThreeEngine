local RarityEquipRecordObj = {}
RarityEquipRecordObj.Name = "RarityEquipRecordObj"
local temp_cfg = SL:Require("GUILayout/config/RarityEquipRecordCfg",true)
local _cfg = {}
for k,v in pairs(temp_cfg) do
	_cfg = v
end
RarityEquipRecordObj.cfg = _cfg
function RarityEquipRecordObj:main(ui,cfg,node,_parent,data)
    self.ui = ui
    self.cfg = cfg
    self.node = node
    self.cur_page = 1
    GUI:addOnClickEvent(self.ui.last_btn,function ()
        if self.cur_page == 1 then
            SL:ShowSystemTips("已经是第一页了！")
            return
        end
        self.cur_page = self.cur_page - 1
        self:FlushInfo()
    end)

    GUI:addOnClickEvent(self.ui.next_btn,function ()
        if self.cur_page >= math.ceil(#self.record_list / 9)  then
            SL:ShowSystemTips("已经是最后一页了！")
            return
        end
        self.cur_page = self.cur_page + 1
        self:FlushInfo()
    end)

    self.record_list = data
    table.sort( self.record_list,function (a,b )
        return a.timestamp > b.timestamp 
    end)
    self:FlushInfo()
end
function RarityEquipRecordObj:flushView( ... )
	local tab = {...}
	if tab[1] == "flush_equip_drop_record" then
		self.record_list = SL:JsonDecode(tab[2])
		table.sort( self.record_list,function (a,b )
			return a.timestamp > b.timestamp 
		end)
		self:FlushInfo()
	end
end
function RarityEquipRecordObj:FlushInfo()
    local index = (self.cur_page - 1 ) * 9 + 1 
    local maxindex = self.cur_page * 9
    GUI:ScrollView_removeAllChildren(self.ui.record_equip_list)
    for i= index,maxindex do
        if self.ui["record_bg"..i] then
            GUI:removeFromParent(self.ui["record_bg"..i])
            self.ui = GUI:ui_delegate(self.node)
        end
        local img = GUI:Image_Create(self.ui.record_equip_list,"record_bg"..i,0,0,"res/custom/npc/26zb/xt.png")
        local data = self.record_list[i]
        if data then
            GUI:ScrollText_Create(img,"player_name"..i,2,5,120,16,"#ffffff",data.player_name)
            local equip_name = GUI:ScrollText_Create(img,"equip_name"..i,125,5,115,16,"#E11010",data.equip_name)
            GUI:ScrollText_Create(img,"boss_name"..i,245,5,115,16,"#E110CB",data.boss_name)
            GUI:ScrollText_Create(img,"map_name"..i,365,5,115,16,"#ffff00",data.map_name)
            GUI:ScrollText_Create(img,"time_text"..i,485,5,115,16,"#00FF00",data.time)
        end
    end

    GUI:UserUILayout(self.ui.record_equip_list, {
        dir=1,
        addDir=1,
    })
    GUI:Text_setString(self.ui.page_text,string.format("第%s页",self.cur_page)) 
end
return RarityEquipRecordObj