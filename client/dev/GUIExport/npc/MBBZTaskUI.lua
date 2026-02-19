local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create ui_layout
	local ui_layout = GUI:Layout_Create(parent, "ui_layout", -240, 295, 240, 60, false)
	GUI:setAnchorPoint(ui_layout, 0.00, 0.00)
	GUI:setTouchEnabled(ui_layout, false)
	GUI:setTag(ui_layout, 0)

	-- Create bg_img
	local bg_img = GUI:Image_Create(ui_layout, "bg_img", 0, 0, "res/custom/mb/bg.png")
	GUI:setContentSize(bg_img, 240, 60)
	GUI:setIgnoreContentAdaptWithSize(bg_img, false)
	GUI:setAnchorPoint(bg_img, 0.00, 0.00)
	GUI:setTouchEnabled(bg_img, true)
	GUI:setMouseEnabled(bg_img, true)
	GUI:setTag(bg_img, 0)

	-- Create icon
	local icon = GUI:Image_Create(bg_img, "icon", 191, 11, "res/custom/mb/js.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create title_txt
	local title_txt = GUI:Text_Create(bg_img, "title_txt", 3, 33, 16, "#ffff00", [==========[[秘宝宝藏]]==========])
	GUI:Text_enableOutline(title_txt, "#000000", 1)
	GUI:setAnchorPoint(title_txt, 0.00, 0.00)
	GUI:setTouchEnabled(title_txt, false)
	GUI:setTag(title_txt, 0)

	-- Create map_name
	local map_name = GUI:Text_Create(bg_img, "map_name", 96, 32, 16, "#00ff00", [[石墓七层]])
	GUI:Text_enableOutline(map_name, "#000000", 1)
	GUI:setAnchorPoint(map_name, 0.00, 0.00)
	GUI:setTouchEnabled(map_name, false)
	GUI:setTag(map_name, 0)

	-- Create task_info
	local task_info = GUI:Text_Create(bg_img, "task_info", 4, 7, 16, "#00ff00", [[点击前往接收秘宝任务]])
	GUI:Text_enableOutline(task_info, "#000000", 1)
	GUI:setAnchorPoint(task_info, 0.00, 0.00)
	GUI:setTouchEnabled(task_info, false)
	GUI:setTag(task_info, 0)

	-- Create iconBtn
	local iconBtn = GUI:Image_Create(ui_layout, "iconBtn", 241, 0, "res/custom/mb/s1.png")
	GUI:setAnchorPoint(iconBtn, 0.00, 0.00)
	GUI:setTouchEnabled(iconBtn, true)
	GUI:setTag(iconBtn, 0)

	ui.update(__data__)
	return ui_layout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
