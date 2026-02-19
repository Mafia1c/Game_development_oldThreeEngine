BeStrongUp = {}

function BeStrongUp.main()
    local parent = GUI:Attach_Parent()
    GUI:LoadExport(parent, "be_strong/be_strong_up") 
    
    BeStrongUp._ui = GUI:ui_delegate(parent)

    GUI:setVisible(BeStrongUp._ui["Panel_bg"], false)

    local basePosX, basePosy = 0, 0

    GUI:addOnTouchEvent(BeStrongUp._ui["Button_up"], function (sender, eventType)
            -- 触摸开始
        if eventType == 0 then
            sender._clicking = true
            local pos_t = GUI:getPosition(sender)
            basePosX, basePosy = pos_t.x, pos_t.y
            -- 触摸移动
        elseif eventType == 1 then
            sender._clicking = false
            local sPos = GUI:getTouchBeganPosition(sender)
            local ePos = GUI:getTouchMovePosition(sender)
            local x = basePosX + ePos.x - sPos.x
            local y = basePosy  + ePos.y - sPos.y
            GUI:setPosition(BeStrongUp._ui["Button_up"], x, y)
            if BeStrongUp and BeStrongUp._ui["Panel_bg"] and not GUI:Win_IsNull(BeStrongUp._ui["Panel_bg"]) then
                local Panel_1 = BeStrongUp._ui["Panel_bg"]
                local pSize = GUI:getContentSize(Panel_1)
                local anchor = GUI:getAnchorPoint(Panel_1)
                GUI:setPosition(Panel_1, x-65, y+30)
            end
        end
    end)
   
   GUI:addOnClickEvent(BeStrongUp._ui["Button_up"], function ()
        local panelBg = BeStrongUp._ui["Panel_bg"]
        local isShow = GUI:getVisible(panelBg)
        GUI:setVisible(panelBg, not isShow)

        BeStrongUp.refreshBeStrongList()
    end)

    BeStrongUp.showBtnAction()
    BeStrongUp.refreshBtnPos()

    BeStrongUp.RegisterEvent()
end

function BeStrongUp.close()
    BeStrongUp.RemoveEvent()
end

-- 提升按钮位置
function BeStrongUp.showBtnAction()
    local btn_up =  BeStrongUp._ui["Button_up"]
    local action = GUI:ActionRepeatForever(GUI:ActionSequence(GUI:ActionFadeTo(0.4, 125), GUI:ActionFadeTo(0.4, 255), GUI:DelayTime(0.6)))
    GUI:runAction(btn_up, action)
end 

-- 提升按钮位置刷新
function BeStrongUp.refreshBtnPos()
    local posBtn = nil 
    local posBg = nil
    local isAlived = SL:GetMetaValue("PET_ALIVE")
    local isWinMode = SL:GetMetaValue("WINPLAYMODE")

    if isAlived then 
        posBtn = isWinMode and {x = -370, y = 400} or {x = -370, y = 300}
        posBg = isWinMode and {x = -370 - 65, y = 400 + 30} or {x = -370 - 65, y = 300 + 30}     
    else 
        posBtn = isWinMode and {x = -300, y = 400} or {x = -300, y = 300}
        posBg = isWinMode and {x = -300 - 65, y = 400 + 30} or {x = -300 - 65, y = 300 + 30}
    end 

    GUI:setPosition(BeStrongUp._ui["Button_up"], posBtn.x, posBtn.y)
    GUI:setPosition(BeStrongUp._ui["Panel_bg"], posBg.x, posBg.y)
end

function BeStrongUp.createCellBtn(i, data)
    local widget = GUI:Widget_Create(-1, "widget_" .. i, 0, 0, 0, 0)
    GUI:LoadExport(widget, "be_strong/be_strong_up_cell")
    local btn = GUI:getChildByName(widget, "Button_cell")
    GUI:Button_setTitleText(btn, data.name)

    GUI:removeFromParent(btn)
    return btn
end

-- 显示变强列表
function BeStrongUp.refreshBeStrongList()
    local data = SL:GetMetaValue("BESTRONG_DATA")
    local uniqueNames = {}		--不添加已存在重复名字的按钮
    local nums = table.nums(data)
    if nums == 0 then 
        return
    end 

    local panel = BeStrongUp._ui["Panel_bg"]
    local listview = BeStrongUp._ui["ListView"]

    GUI:ListView_removeAllItems(listview)

    local btnSize = nil

    for i, v in pairs(data) do
	   if not uniqueNames[v.name] then
			uniqueNames[v.name] = true
			local btn = BeStrongUp.createCellBtn(i, v)
			GUI:ListView_pushBackCustomItem(listview, btn)
			GUI:addOnClickEvent(btn, function()
				GUI:setVisible(panel, false)
				if v.link then
					SL:SubmitAct({Act = v.link, subid = v.id})
				elseif v.func then
					v.func()
				end
			end)
	
			if not btnSize then
				btnSize = GUI:getContentSize(btn)
			end
		end
    end

    local count = GUI:ListView_getItemCount(listview)
    local btnSize = btnSize or {width = 120, height = 40}
    local bgSize = GUI:getContentSize(panel)
    local listSize = GUI:getContentSize(listview)
    local margin = GUI:ListView_getItemsMargin(listview)
    --最多显示4条 超过的滑动显示
    local height = (btnSize.height + margin) * math.min(count, 4.5) - margin
    GUI:setContentSize(listview, listSize.width, height)
    GUI:setContentSize(panel, bgSize.width, height + 10)
end

-----------------------------------注册事件--------------------------------------
function BeStrongUp.RegisterEvent()
    SL:RegisterLUAEvent(LUA_EVENT_BESTRONG_POS_REFRESH, "BeStrongUp", BeStrongUp.refreshBtnPos)
end

function BeStrongUp.RemoveEvent()
    SL:UnRegisterLUAEvent(LUA_EVENT_BESTRONG_POS_REFRESH, "BeStrongUp")
end
