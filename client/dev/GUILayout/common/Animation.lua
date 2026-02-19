--#region 动画特效包 
Animation = Animation or {}

---设置子控件跟随父控件透明度变化
---*  obj : 父控件
---*  opacityTemp : 透明度值(0-255)
---*  time : 变化的时间
---@param obj obj
---@param opacityTemp number
---@param time number
---@return any
function Animation.followOpacity(obj,opacityTemp,time)
    GUI:Timeline_FadeTo(obj,opacityTemp,time)
    for _, son in pairs(GUI:getChildren(obj)) do
        GUI:Timeline_FadeTo(son,opacityTemp,time)
        Animation.followOpacity(son,opacityTemp,time)
    end
end

---弹跳效果 模拟控件弹跳的效果。
---*  widget : 父控件
---*  duration : 填5
---*  pos : 填20
---@param widget obj
---@param duration number
---@param pos number
---@return any
function Animation.bounceEffect(widget, duration,pos)
    local moveUp = GUI:ActionMoveBy(0.08, 0, pos)
    local moveDown = GUI:ActionMoveBy(0.08, 0, -pos)
    local sequence = GUI:ActionSequence(moveUp, moveDown)

    if duration == 0 then
        local repeatForever = GUI:ActionRepeatForever(sequence)
        GUI:runAction(widget, repeatForever)
    else
        local repeatAction = GUI:ActionRepeat(sequence, duration)
        GUI:runAction(widget, repeatAction)
    end
end


---控件呼吸灯渐变又渐出(例如0.6，0.6)
---*  obj : 父控件
---*  outTime : 淡出时间
---*  inTime : 淡入时间
---@param widget obj
---@param outTime number
---@param inTime number
---@return any
function Animation.breathingEffect(widget, outTime,inTime)
    GUI:runAction(widget,GUI:ActionRepeatForever(GUI:ActionSequence(GUI:ActionFadeOut(outTime),GUI:ActionFadeIn(inTime))))
end


--列表项滑动动画(向内添加效果)
---*  widget : 控件对象
---*  value : 时间
---*  duration : 移动距离
---@param widget userdata
---@param value integer
---@param distance integer
---@return any
function Animation.slideInFromLeft(widget, value, distance)
    local currentPos = GUI:getPosition(widget)
    GUI:setPosition(widget, currentPos.x - distance, currentPos.y)
    local moveAction = GUI:ActionMoveTo(value, currentPos.x, currentPos.y)
    GUI:runAction(widget, moveAction)
end

--列表项滑动动画(向外移除效果)
---*  widget : 控件对象
---*  value : 时间
---*  duration : 移动距离
---@param widget userdata
---@param value integer
---@param distance integer
---@return any
function Animation.slideOutToRight(widget, value, distance)
    local currentPos = GUI:getPosition(widget)
    local moveAction = GUI:ActionMoveTo(value, currentPos.x + distance, currentPos.y)
    GUI:runAction(widget, moveAction)
end

--心跳放大缩小动画
---*  widget : 控件对象
---*  duration : 次数(大于0执行duration次，等于0循环执行)
---@param widget userdata
---@param duration integer
---@return any
function Animation.heartbeatEffect(widget, duration)
    local scaleUp = GUI:ActionScaleTo(0.5, 1.2)
    local scaleDown = GUI:ActionScaleTo(0.5, 1)
    local sequence = GUI:ActionSequence(scaleUp, scaleDown)

    if duration == 0 then
        local repeatForever = GUI:ActionRepeatForever(sequence)
        GUI:runAction(widget, repeatForever)
    else
        local repeatAction = GUI:ActionRepeat(sequence, math.ceil(duration / 1.0))
        GUI:runAction(widget, repeatAction)
    end
end

--摇晃动画
---*  widget : 控件对象
---*  duration : 次数(大于0执行duration*5次，等于0循环执行)
---@param widget userdata
---@param duration integer
---@return any
function Animation.shakeEffect(widget, duration,time)
    local moveLeft = GUI:ActionMoveBy(time, 0, -10)
    local moveRight = GUI:ActionMoveBy(time, 0, 10)
    local moveLeftBack = GUI:ActionMoveBy(time, 0, -10)
    local moveRightBack = GUI:ActionMoveBy(time, 0, 10)
    local sequence = GUI:ActionSequence(moveLeft, moveRight, moveLeftBack, moveRightBack)

    if duration == 0 then
        local repeatForever = GUI:ActionRepeatForever(sequence)
        GUI:runAction(widget, repeatForever)
    else
        local repeatAction = GUI:ActionRepeat(sequence, math.ceil(duration / 0.4))
        GUI:runAction(widget, repeatAction)
    end
end
-- 水平摇晃
function Animation.wshakeEffect(widget, duration,time)
    local moveLeft = GUI:ActionMoveBy(time,-5, 0)
    local moveRight = GUI:ActionMoveBy(time, 5, 0)
    local moveLeftBack = GUI:ActionMoveBy(time, -5, 0)
    local moveRightBack = GUI:ActionMoveBy(time, 5, 0)
    local sequence = GUI:ActionSequence(moveLeft, moveRight, moveLeftBack, moveRightBack)

    if duration == 0 then
        local repeatForever = GUI:ActionRepeatForever(sequence)
        GUI:runAction(widget, repeatForever)
    else
        local repeatAction = GUI:ActionRepeat(sequence, math.ceil(duration / 0.4))
        GUI:runAction(widget, repeatAction)
    end
end