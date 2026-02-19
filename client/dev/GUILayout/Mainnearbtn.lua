MainNearBtn = {}
local screenW = SL:GetMetaValue("SCREEN_WIDTH")
local screenH = SL:GetMetaValue("SCREEN_HEIGHT")
local iswin32 = SL:GetMetaValue('WINPLAYMODE')
function MainNearBtn:main()
    local _Parent = GUI:Win_Create("MainNearBtnLayer", 0, 0, screenW, screenH, false, false, true, false, false, 0, 0)
    GUI:LoadExport(_Parent, "main/Main_Near_btn");
	self._ui = GUI:ui_delegate(_Parent);
	GUI:setPosition(self._ui.Main_Panel, iswin32 and 320 or screenW - 400, iswin32 and 161 or 182)
    GUI:setSwallowTouches(self._ui.targetBtn, false)
    local basePosX, basePosy = 0, 0
    GUI:addOnTouchEvent(self._ui.Main_Panel, function (sender, eventType)
			-- 触摸开始
        if eventType == 0 then
            local pos_t = GUI:getPosition(sender)
            basePosX, basePosy = pos_t.x, pos_t.y
			-- 触摸移动
        elseif eventType == 1 then
            local sPos = GUI:getTouchBeganPosition(sender)
            local ePos = GUI:getTouchMovePosition(sender)
            local x = basePosX + ePos.x - sPos.x
            local y = basePosy  + ePos.y - sPos.y
			GUI:setPosition(self._ui.Main_Panel, x, y)
            if MainNear and MainNear._ui["Panel_1"] and not GUI:Win_IsNull(MainNear._ui["Panel_1"]) then
                local Panel_1 = MainNear._ui["Panel_1"]
                local pSize = GUI:getContentSize(Panel_1)
                local anchor = GUI:getAnchorPoint(Panel_1)
                GUI:setPosition(Panel_1, x - pSize.width * anchor.x, y + pSize.height)
            end
			-- 触摸结束 or 触摸取消
        elseif eventType == SLDefine.TouchEventType.ended or eventType == SLDefine.TouchEventType.canceled then
			-- 执行点击事件
            SL:JumpTo(116)
		end
	end)
end
MainNearBtn:main()
