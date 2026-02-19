---发送提示消息
---*  actor: 玩家对象
---*  color: 颜色:  红色-ff0000，绿色-00ff00
---*  str: 文本
---*  type: 发送对象:  1-自己，2-全服，3-行会，4-当前地图，5-组队
---
NPC_TIPS_PREFIX9 = "<font color='#FFFF00'>【提示】: </font>"

---@param actor string|nil
---@param color string
---@param str string
---@param type integer
function Sendmsg9(actor,color,str,type)
    if type == 1 then
        str = NPC_TIPS_PREFIX9 .. str
    end
    sendmsg(actor,type,'{"Msg":"<font color=\'#'..color..'\'>'..str..'</font>","Type":9}')
end

---发送聊天框上方提示消息
---*  actor: 玩家对象
---*  Fcolor: 前景色 红-249，绿-250，黄-251，白-255
---*  str: 文本
---*  type: 发送对象:1-自己，2-全服，3-行会，4-当前地图，5-组队
---@param actor string|nil
---@param Fcolor integer
---@param str string
---@param type integer
function Sendmsg6(actor,Fcolor,str,type)
    sendmsg(actor,type,'{"Msg":"'..str..'","FColor":'..Fcolor..',"BColor":0,"Type":6,"Time":0}')
end

---发送聊天框提示消息
---*  actor: 玩家对象
---*  Fcolor: 前景色 红-249，绿-250，黄-251，白-255
---*  Bcolor: 背景色 红-249，绿-250，黄-251，白-255
---*  str: 文本
---*  type: 发送对象:1-自己，2-全服，3-行会，4-当前地图，5-组队
---@param actor string|nil
---@param Fcolor integer
---@param Bcolor integer
---@param str string
---@param type integer
function Sendmsg1(actor,Fcolor,Bcolor,str,type)
    sendmsg(actor,type,'{"Msg":"'..str..'","FColor":'..Fcolor..',"BColor":'..Bcolor..',"Type":1}')
end

---发送屏幕跑马灯公告
---*  actor: 玩家对象
---*  Fcolor: 前景色 红-249，绿-250，黄-251，白-255
---*  str: 文本
---*  type: 发送对象:1-自己，2-全服，3-行会，4-当前地图，5-组队
---*  Y: Y坐标
---@param actor string|nil
---@param Fcolor integer
---@param str string
---@param type integer
---@param Y integer
function Sendmsg5(actor,Fcolor,str,type,Y)
    sendmsg(actor,type,'{"Msg":"'..str..'","FColor":'..Fcolor..',"BColor":0,"Type":5,"Y":'..Y..'}')
end
-----发送提示消息系统公告缩放
---*  actor: 玩家对象
---*  Fcolor: 前景色 红-249，绿-250，黄-251，白-255
---*  str: 文本
---*  type: 发送对象:1-自己，2-全服，3-行会，4-当前地图，5-组队
---*  Y: Y坐标
function Sendmsg13(actor,Fcolor,str,type,Y)
    sendmsg(actor,type,'{"Msg":"'..str..'","FColor":'..Fcolor..',"BColor":0,"Type":13,"Y":'..Y..'}')
end

function callfunction(actor,callluafunstr, ...)
     callluafunstr = string.format(callluafunstr, ...);
     sendluamsg(actor,123,0,0,0,callluafunstr)
end