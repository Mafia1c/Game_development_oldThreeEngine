local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 0, 0, "res/custom/npc/44zq/bg.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, true)
	GUI:setTag(Image_1, 0)

	-- Create recharge_btn
	local recharge_btn = GUI:Button_Create(FrameLayout, "recharge_btn", 584, 132, "res/custom/npc/44zq/an1.png")
	GUI:setContentSize(recharge_btn, 146, 40)
	GUI:setIgnoreContentAdaptWithSize(recharge_btn, false)
	GUI:Button_setTitleText(recharge_btn, [[]])
	GUI:Button_setTitleColor(recharge_btn, "#ffffff")
	GUI:Button_setTitleFontSize(recharge_btn, 16)
	GUI:Button_titleEnableOutline(recharge_btn, "#000000", 1)
	GUI:setAnchorPoint(recharge_btn, 0.00, 0.00)
	GUI:setTouchEnabled(recharge_btn, true)
	GUI:setTag(recharge_btn, 0)

	-- Create get_btn
	local get_btn = GUI:Button_Create(FrameLayout, "get_btn", 585, 80, "res/custom/npc/44zq/an2.png")
	GUI:setContentSize(get_btn, 146, 40)
	GUI:setIgnoreContentAdaptWithSize(get_btn, false)
	GUI:Button_setTitleText(get_btn, [[]])
	GUI:Button_setTitleColor(get_btn, "#ffffff")
	GUI:Button_setTitleFontSize(get_btn, 16)
	GUI:Button_titleEnableOutline(get_btn, "#000000", 1)
	GUI:setAnchorPoint(get_btn, 0.00, 0.00)
	GUI:setTouchEnabled(get_btn, true)
	GUI:setTag(get_btn, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 173, 394, [[<font color='#00ff00' size='18' >真实充值达到200元，即可自助转入任意新区，可批量领取，最低200起领！ </font><br><font color='#00ff00' size='18' >转区后当前角色</font><font color='#ff0000' size='18' >【永久封禁】</font><font color='#00ff00' size='18' >玩家可以前往新区充值，并且领取对应</font><br><font color='#00ff00' size='18' >的转区额度！</font><font color='#ffff00' size='18' >领取转区金额后，如果想继续转区需补齐200可转金额！</font>]], 650, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create closeButton
	local closeButton = GUI:Button_Create(FrameLayout, "closeButton", 820, 487, "res/custom/closeBtn.png")
	GUI:setContentSize(closeButton, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeButton, false)
	GUI:Button_setTitleText(closeButton, [[]])
	GUI:Button_setTitleColor(closeButton, "#ffffff")
	GUI:Button_setTitleFontSize(closeButton, 16)
	GUI:Button_titleEnableOutline(closeButton, "#000000", 1)
	GUI:setAnchorPoint(closeButton, 0.00, 0.00)
	GUI:setTouchEnabled(closeButton, true)
	GUI:setTag(closeButton, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 86, 448, 16, "#ff9b00", [[转区规则：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 86, 348, 16, "#ff9b00", [[转区说明：]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(FrameLayout, "RichText_2", 172, 224, [[<font color='#ffffff' size='16' >转区可以前往</font><font color='#ff0000' size='16' >【当前已正式开区】</font><font color='#ffffff' size='16' >的分区，使用相同账号注册角色进行领取！</font><br><font color='#ffffff' size='16' >转区额度只能在一个角色数据上领取，不可分多个角色领取转区金额！</font><br><font color='#ffffff' size='16' >新区充值多少金额，可分批领取多少转区额度！</font><font color='#ff0000' size='16' >（领取额度不能超过转区额度）</font><br><font color='#ffffff' size='16' >转区成功后新区可领取转区金额的充值货币（转区金额不计算真实充值总数）</font><br><font color='#ffff00' size='16' >请注意：领取转区金额必须合区之前领完，合区后将无法领取转区额度！！！</font><br><font color='#00ff00' size='16' >如实在看不懂上面的转区规则，请联系游戏客服进行详细了解！</font>]], 610, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create can_change_quantity
	local can_change_quantity = GUI:Text_Create(FrameLayout, "can_change_quantity", 294, 150, 16, "#ffffff", [[0元]])
	GUI:Text_enableOutline(can_change_quantity, "#000000", 1)
	GUI:setAnchorPoint(can_change_quantity, 0.00, 0.00)
	GUI:setTouchEnabled(can_change_quantity, false)
	GUI:setTag(can_change_quantity, 0)

	-- Create can_get_quantity
	local can_get_quantity = GUI:Text_Create(FrameLayout, "can_get_quantity", 291, 110, 16, "#ffffff", [[0元]])
	GUI:Text_enableOutline(can_get_quantity, "#000000", 1)
	GUI:setAnchorPoint(can_get_quantity, 0.00, 0.00)
	GUI:setTouchEnabled(can_get_quantity, false)
	GUI:setTag(can_get_quantity, 0)

	-- Create residue_quantity
	local residue_quantity = GUI:Text_Create(FrameLayout, "residue_quantity", 292, 66, 16, "#ffffff", [[0元]])
	GUI:Text_enableOutline(residue_quantity, "#000000", 1)
	GUI:setAnchorPoint(residue_quantity, 0.00, 0.00)
	GUI:setTouchEnabled(residue_quantity, false)
	GUI:setTag(residue_quantity, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
