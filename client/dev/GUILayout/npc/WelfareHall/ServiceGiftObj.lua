local ServiceGiftObj = {}
ServiceGiftObj.Name = "ServiceGiftObj"

function ServiceGiftObj:main(ui,cfg,node,_parent,data)
    self.ui = ui
    self.cfg = cfg
    self.node = node
    -- SendMsgCallFunByNpc(0,"WelfareHall","InitService") 

    self:FlushInfo()
    GUI:addOnClickEvent(self.ui.get_btn,function ()
        SendMsgCallFunByNpc(0,"WelfareHall","GetServiceAward",self.cfg[1].type)
    end) 

    local navigation = tonumber(GameData.GetData("U_navigation_task_step", false))
    if navigation == 1 then
        GUI:runAction(self.ui.service_list, GUI:ActionSequence(GUI:DelayTime(0.1), GUI:CallFunc(function()
            local function callback()
                SendMsgCallFunByNpc(0,"WelfareHall","GetServiceAward",self.cfg[1].type)
            end
            local data = {}
            data.dir           = 1                -- 方向（1~8）从左按瞬时针
            data.guideWidget   = self.ui["get_btn"]        -- 当前节点
            data.guideParent   = _parent          -- 父窗口
            data.guideDesc     = "点击领取"           -- 文本描述
            data.clickCB       = callback         -- 回调
            data.autoExcute    = 86400            -- 自动执行秒数
            data.isForce       = true             -- 强制引导
            data.hideMask      = true             -- 隐藏蒙版 [仅不强制引导时有效]
            SL:StartGuide(data)
        end)))  
    end
    local is_get = tonumber(data.is_get) > 0
    GUI:setVisible(self.ui.get_btn,not is_get)
    GUI:setVisible(self.ui.has_get,is_get)
    self:flushRed(not is_get)
end

function ServiceGiftObj:FlushInfo()
    for i,data in ipairs(self.cfg[1].award1_map) do
        local item_cell = GUI:ItemShow_Create(self.ui.service_list,"service_item"..i,65 * i + 0 ,35,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", data[1]),count = data[2],bgVisible = true,look = true,color = 250})
        GUI:setAnchorPoint(item_cell,0.5,0.5)
        ItemShow_updateItem(item_cell,{showCount = true,count = data[2],bgVisible = true,look = true,color = 250})
    end
    -- GUI:UserUILayout(self.ui.service_list, {
    --     dir=2,
    --     addDir=2,
    --     gap = {x=2},
    -- })
end
function ServiceGiftObj:flushView( ... )
    local tab = {...}
    if tab[1] == "flush_service" then
        local is_get = tonumber(tab[2]) > 0
        GUI:setVisible(self.ui.get_btn,not is_get)
        GUI:setVisible(self.ui.has_get,is_get)
        self:flushRed(not is_get)
    end
end
function ServiceGiftObj:flushRed(is_show_red)
    if self.red_width then
        GUI:removeFromParent(self.red_width)
        self.red_width = nil
    end 
    if is_show_red then
        if self.red_width == nil then
            self.red_width = SL:CreateRedPoint(self.ui.get_btn)
        end
    end
end

return ServiceGiftObj