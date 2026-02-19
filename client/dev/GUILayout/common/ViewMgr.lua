-- npc 面板管理
ViewMgr = ViewMgr or {}
ViewMgr.npc_ui = {}
ViewMgr.visible_wins = {}

NPC_UI_LUA_PATH = "GUILayout/npc/"

function ViewMgr.addNpcScript(name, file)
    ViewMgr.npc_ui[name] = file
end

function ViewMgr.RequireViewLua(name, reload)
    if nil == reload then
        reload = true
    end
    local path = NPC_UI_LUA_PATH .. name
    local file = nil
    if SL:IsFileExist(path ..".lua") then
        file = SL:Require(path, reload)
        ViewMgr.npc_ui[file.Name] = file
    else
        SL:release_print("[ERROR] file not exist *******************", path)
    end
    return file
end

function ViewMgr.open(name, ...)
    name = name or "__"
    if ViewMgr.visible_wins[name] then
        return
    end
    local ui = ViewMgr.npc_ui[name]
    if nil == ui then
        ui = ViewMgr.RequireViewLua(name)
    end
    if ui and ui.main then
        ui:main(...)
        ViewMgr.visible_wins[name] = ui
        ViewMgr:adjustPos(ui)
        if ui.RunAction and nil ~= ui._parent then
            GUI:Timeline_Window1(ui._parent)
        end
        if ui._parent and ui.RunDrag then
            local layout = ui.DragLayout or ui.ui.FrameLayout
            GUI:Win_SetDrag(ui._parent, layout)
        end
        if ui.HideMain then
            GUI:Win_SetMainHide(ui._parent , true)
        end
        SL:Print("open view: ", name)
    else
        SL:release_print("[ERROR] main function does not exist *******************", name)
    end
    return ui
end

function ViewMgr.close(name, ...)
    name = name or "__"
    local ui = ViewMgr.visible_wins[name]
    if ui and ui._parent then
        if ui.onClose and "function" == type(ui.onClose) then                  -- 关闭回调
            ui:onClose(...)
        end
        if ui.HideMain then
            GUI:Win_SetMainHide(ui._parent , false)
        end
        GUI:Win_Close(ui._parent)
        ViewMgr.visible_wins[name] = nil
        SL:Print("close view: ", name)
    else
        SL:release_print("ViewMgr.Close failure ******************",name, ui)
    end
end

function ViewMgr.flushView(name, ...)
    local ui = ViewMgr.GetOpenViewByName(name)
    if ui and ui.flushView then
        ui:flushView(...)
        SL:Print("flush view: ", name)
    end
end

function ViewMgr.GetOpenViewByName(name)
    return ViewMgr.visible_wins[name]
end

function ViewMgr.IsOpen(name)
    return  nil ~= ViewMgr.visible_wins[name]
end

function ViewMgr.CloseAll()
    for k, v in pairs(ViewMgr.visible_wins) do
        ViewMgr.close(k)
    end
    ViewMgr.visible_wins = {}
    ViewMgr.npc_ui = {}
    SL:Print("CloseAll *** ")
end

function ViewMgr:adjustPos(widget)
    local win_size = cc.size(SL:GetMetaValue("SCREEN_WIDTH"), SL:GetMetaValue("SCREEN_HEIGHT"))
    if widget.ui then
        if widget.ui["CloseLayout"] then
            GUI:setContentSize(widget.ui["CloseLayout"], win_size.width, win_size.height)
        end

        if widget.ui["FrameLayout"] then
            local offset_pos = widget.location or {offsetX = 0,offsetY = 0}
            local bg_layout = widget.ui["FrameLayout"]
            local bg_size = GUI:getContentSize(bg_layout)
            local point = GUI:getAnchorPoint(bg_layout)

            local o_X = bg_size.width * 0.5 - bg_size.width * point.x
            local o_y = bg_size.height * 0.5 - bg_size.height * point.y

            local x = win_size.width * 0.5 - o_X + (offset_pos.offsetX or 0)
            local y = win_size.height * 0.5 - o_y + (offset_pos.offsetY or 0)
            GUI:setPosition(bg_layout, x, y)    
        end
    end
end

-- 小退触发
local function onLeaveWorld()
    ViewMgr.CloseAll()
end
SL:RegisterLUAEvent(LUA_EVENT_LEAVE_WORLD, "ViewMgr", onLeaveWorld)
