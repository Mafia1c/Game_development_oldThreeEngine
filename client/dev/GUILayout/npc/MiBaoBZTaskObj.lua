local MiBaoBZTaskObj = {}
MiBaoBZTaskObj.Name = "MiBaoBZTaskObj"

function MiBaoBZTaskObj:main(state_str, map_name, npc_id, state)
    local ui_path = "npc/MBBZTaskUI"
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, ui_path, function () end)
    self.ui = GUI:ui_delegate(parent)
    self.map_name = map_name
    self.task_state_str = state_str
    self.show_ui_state = true
    self.npc_id = npc_id
    self.cur_state = tonumber(state)

    self:initClickEvent()
    self:updateUiShow()
    self:showTaskInfo()
end

function MiBaoBZTaskObj:initClickEvent()
    GUI:addOnClickEvent(self.ui.iconBtn, function()
        self:updateUiShow()
    end)

    GUI:addOnClickEvent(self.ui.bg_img, handler(self, self.clickTask))
end

function MiBaoBZTaskObj:clickTask()
    SendMsgCallFunByNpc(self.npc_id, "BossSkullNpc", "onClickUiTask", self.npc_id)
end

function MiBaoBZTaskObj:updateUiShow()
    self.show_ui_state = not self.show_ui_state
    local init_pos_x = -240
    local move_dis = 240
    local icon_path = "res/custom/mb/s1.png"
    if self.show_ui_state then
        init_pos_x = 0
        move_dis = -240
        icon_path = "res/custom/mb/s2.png"
    end
    GUI:setPosition(self.ui.ui_layout, init_pos_x, 300)
    GUI:runAction(self.ui.ui_layout, GUI:ActionEaseExponentialInOut(GUI:ActionMoveBy(0.3, move_dis, 0)))
    GUI:Image_loadTexture(self.ui.iconBtn, icon_path)
end

function MiBaoBZTaskObj:showTaskInfo()
    GUI:Text_setString(self.ui.map_name, self.map_name)
    GUI:Text_setString(self.ui.task_info, self.task_state_str)

    local res = "res/custom/mb/js.png"
    if self.cur_state == 1 then
        res = "res/custom/mb/jx.png"
    end
    GUI:Image_loadTexture(self.ui.icon, res)
end

function MiBaoBZTaskObj:flushView(state_str, map_name, npc_id, state)
    self.task_state_str = state_str
    self.map_name = map_name
    self.cur_state = tonumber(state)
    self:showTaskInfo()
end

function MiBaoBZTaskObj:onClose()
end

return MiBaoBZTaskObj