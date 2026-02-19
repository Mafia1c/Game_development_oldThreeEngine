local xuemaiChongXiuObj = {}

xuemaiChongXiuObj.Name = "xuemaiChongXiuObj"
xuemaiChongXiuObj.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
xuemaiChongXiuObj.cfg = SL:Require("GUILayout/config/talentCfg",true)

function xuemaiChongXiuObj:main(param)
  local tab = string.split(param,"|") 
  self.select_item_id = tonumber(tab[1])
  local select_index = tonumber(tab[2])
  local tm_select_list = SL:JsonDecode(tab[3])
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
  self._parent = parent
  self.old_idx = nil
    --加载UI
  GUI:LoadExport(parent, "npc/xuemaiChongXiuUI")
  self.ui = GUI:ui_delegate(parent)
  self.ui.text_list = {}
    --关闭按钮
  GUI:addOnClickEvent(self.ui.closeButton, function()
      ViewMgr.close(xuemaiChongXiuObj.Name)
  end)
  local tequan_level = GameData.GetData("U_zstq") or 0
 
  --书页刷新
  GUI:addOnClickEvent(self.ui.bookRebuildButton,function ()
      local used_tq_num = GameData.GetData("tqfwcx") or 0
      local zscx_num = GameData.GetData("U_zsmf_fwcx") or 0  --终生重修次数
      if zscx_num < 5 then
          xuemaiChongXiuObj:openZsmfTip(select_index)
      elseif tequan_level > 0 and used_tq_num > 0 then
         xuemaiChongXiuObj:openTeQuanTip(select_index)
      else
        local data = {}
        data.str = select_index <= 30 and  "刷新后不选择将会失去刷新记录,是否确定重修天赋?\n本次刷新费用：书页x199" or "是否确定重修天赋?\n本次刷新费用：书页x199"
        data.btnType = 2
        data.callback = function(atype)
          if atype == 1 then --确定
            SendMsgCallFunByNpc(0, "xuemai", "flushChongXiuKaPai", "书页|"..select_index) 
          end
        end
        SL:OpenCommonTipsPop(data)    
      end
  end)

  --灵符刷新
  GUI:addOnClickEvent(self.ui.runeRebuildButton,function ()
    local used_tq_num = GameData.GetData("tqfwcx") or 0
    local zscx_num = GameData.GetData("U_zsmf_fwcx") or 0  --终生重修次数
    if zscx_num < 5 then
        xuemaiChongXiuObj:openZsmfTip(select_index)
    elseif tequan_level > 0 and used_tq_num > 0  then
      xuemaiChongXiuObj:openTeQuanTip(select_index)
    else
      local data = {}
      data.str = select_index <= 30 and "刷新后不选择将会失去刷新记录,是否确定重修天赋?\n本次刷新费用：灵符x100" or "是否确定重修天赋?\n本次刷新费用：灵符x100"
      data.btnType = 2
      data.callback = function(atype)
        if atype == 1 then --确定
          SendMsgCallFunByNpc(0, "xuemai", "flushChongXiuKaPai","灵符|"..select_index) 
        end
      end
      SL:OpenCommonTipsPop(data)    

    end
  end)
  if select_index <= 30 or #tm_select_list <= 0 then
      xuemaiChongXiuObj:flushKaPai(xuemaiChongXiuObj.cfg[self.select_item_id])
  else
      xuemaiChongXiuObj:flushXMShow(tm_select_list,select_index)
  end
  local zscx_num = GameData.GetData("U_zsmf_fwcx") or 0  --终生重修次数
  if zscx_num < 5 then
      GUI:Text_setString(self.ui.expendTip,string.format("花费：书页x199 或 灵符x100,即可刷新一次当前天赋(剩余免费次数：%s)",5-zscx_num) ) 
  else
      GUI:Text_setString(self.ui.expendTip,"花费：书页x199 或 灵符x100,即可刷新一次当前天赋(特权拥有免费次数)") 
  end
end

function xuemaiChongXiuObj:openTeQuanTip(select_index)
    local used_tq_num = GameData.GetData("tqfwcx") 
    local data = {}
    if select_index <= 30 then
      data.str = string.format("刷新后不选择将会失去刷新记录,是否确定重修天赋?\n本次刷新费用：免费刷新！\n特权剩余免费重修次数：%s次",used_tq_num) 
    else
      data.str = string.format("是否确定重修天赋?\n本次刷新费用：免费刷新！\n特权剩余免费重修次数：%s次",used_tq_num) 
    end
    data.btnType = 2
    data.callback = function(atype)
      if atype == 1 then --确定
        SendMsgCallFunByNpc(0, "xuemai", "flushChongXiuKaPai", "特权|"..select_index) 
      end
    end
    SL:OpenCommonTipsPop(data)
end
function xuemaiChongXiuObj:openZsmfTip(select_index)
    local zsmf_num = GameData.GetData("U_zsmf_fwcx") or 0
    local data = {}
    if select_index <= 30 then
      data.str = string.format("刷新后不选择将会失去刷新记录,是否确定重修天赋?\n本次刷新费用：免费刷新！\n免费重修次数：%s次",5-zsmf_num) 
    else
      data.str = string.format("是否确定重修天赋?\n本次刷新费用：免费刷新！\n免费重修次数：%s次",5-zsmf_num) 
    end
    data.btnType = 2
    data.callback = function(atype)
      if atype == 1 then --确定
        SendMsgCallFunByNpc(0, "xuemai", "flushChongXiuKaPai", "免费|"..select_index) 
      end
    end
    SL:OpenCommonTipsPop(data)
end

function xuemaiChongXiuObj:flushKaPai(cfg)
  GUI:setVisible(self.ui.tm_kaipai_box,false)
  GUI:setVisible(self.ui.flushKaPaiBox,false)
  GUI:setVisible(self.ui.cxKaPaiImg,true)
  GUI:setPosition(self.ui.cxKaPaiImg,198,112)
  GUI:Image_loadTexture(self.ui.cxKaPaiImg,"res/custom/npc/23xm/type_"..cfg.talent_type..".png") 
  GUI:ItemShow_updateItem(self.ui.cxItem, {index = cfg.key_name,count = 0,bgVisible = false,look = true})
  GUI:Text_setString(self.ui.cueSelectText,"当前选择重修天赋："..cfg.talent_name) 
  local rich = GUI:RichTextFCOLOR_Create(self.ui["cxKaPaiImg"], "item_name", 85, 213, string.format("<%s/FCOLOR=%s>",cfg.talent_name,cfg.tanlebt_color) , 100, 16, "#fffff")
  GUI:setAnchorPoint(rich,0.5,0.5)
end

function xuemaiChongXiuObj:flushView( ... )
  local param = {...}
  local tab = string.split(param[1],"|")
  GUI:setVisible(self.ui.flushKaPaiBox,true)
  GUI:setVisible(self.ui.cxKaPaiImg,false)
  local zscx_num = GameData.GetData("U_zsmf_fwcx") or 0  --终生重修次数
  if zscx_num < 5 then
      GUI:Text_setString(self.ui.expendTip,string.format("花费：书页x199 或 灵符x100,即可刷新一次当前天赋(剩余免费次数：%s)",5-zscx_num) ) 
  else
      GUI:Text_setString(self.ui.expendTip,"花费：书页x199 或 灵符x100,即可刷新一次当前天赋(特权拥有免费次数)") 
  end

  if tonumber(tab[2]) <= 30  then --天赋
    xuemaiChongXiuObj:flushTFShow(SL:JsonDecode(tab[1]),tonumber(tab[2]))
  else
    xuemaiChongXiuObj:flushXMShow(SL:JsonDecode(tab[1]),tonumber(tab[2]))
  end
end
--刷新出来天赋展示
function xuemaiChongXiuObj:flushTFShow(selected,select_index)
  for k,v in pairs(self.ui.text_list) do
      if v then
          GUI:removeFromParent(v)
      end
  end
  self.ui.text_list = {}
  for k,v in pairs(selected) do
    local data = xuemaiChongXiuObj.cfg[v]
    GUI:Image_loadTexture(self.ui["kaPaiImg"..k],"res/custom/npc/23xm/type_"..data.talent_type..".png" )
    GUI:ItemShow_updateItem(self.ui["kpItem"..k], {index = data.key_name,count = 0,bgVisible = false,look = true})
    local rich = GUI:RichTextFCOLOR_Create(self.ui["kaPaiImg"..k], "item_name"..k, 85, 212, string.format("<%s/FCOLOR=%s>",data.talent_name,data.tanlebt_color) , 100, 16, "#fffff")
    GUI:setAnchorPoint(rich,0.5,0.5)
    table.insert(self.ui.text_list,rich ) 
    GUI:addOnClickEvent(self.ui["kpSelectBtn"..k],function ()
      SendMsgCallFunByNpc(0, "xuemai", "setTianFuInfo",data.key_name.."|"..select_index)
      ViewMgr.close(xuemaiChongXiuObj.Name)
    end) 
  end
end

--刷新出来血脉展示
function xuemaiChongXiuObj:flushXMShow(selected,select_index)
  GUI:setVisible(self.ui.tm_kaipai_box,true)
  GUI:setVisible(self.ui.flushKaPaiBox,false)
  GUI:setVisible(self.ui.cxKaPaiImg,false)
  if self.ui.xm_item_name  then
     GUI:removeFromParent(self.ui.xm_item_name)
     self.ui = GUI:ui_delegate(self._parent)
  end
  for k,v in pairs(selected) do
      local data = xuemaiChongXiuObj.cfg[v]
      GUI:Image_loadTexture(self.ui["tm_kapai2"],"res/custom/npc/23xm/type_"..data.talent_type..".png" )
      GUI:ItemShow_updateItem(self.ui["tm_kpItem2"], {index = data.key_name,count = 0,bgVisible = false,look = true})
      if self.ui.xm_item_name == nil then
        GUI:RichTextFCOLOR_Create(self.ui["tm_kapai2"], "xm_item_name", 67, 199, string.format("<%s/FCOLOR=%s>",data.talent_name,data.tanlebt_color) , 100, 16, "#fffff")
      end
      GUI:addOnClickEvent(self.ui["tm_kpSelectBtn2"],function ()
        SendMsgCallFunByNpc(0, "xuemai", "setXueMaiInfo",data.key_name.."|"..select_index)
        ViewMgr.close(xuemaiChongXiuObj.Name)
      end) 
  end
  local old_cfg = xuemaiChongXiuObj.cfg[self.select_item_id]
  GUI:Image_loadTexture(self.ui["tm_kapai1"],"res/custom/npc/23xm/type_"..old_cfg.talent_type..".png" )
  GUI:ItemShow_updateItem(self.ui["tm_kpItem1"], {index = old_cfg.key_name,count = 0,bgVisible = false,look = true})
  if self.ui.old_xm_item_name == nil then
    GUI:RichTextFCOLOR_Create(self.ui["tm_kapai1"], "old_xm_item_name", 67, 199, string.format("<%s/FCOLOR=%s>",old_cfg.talent_name,old_cfg.tanlebt_color) , 100, 16, "#fffff")
  end
  GUI:addOnClickEvent(self.ui["tm_kpSelectBtn1"],function ()
    ViewMgr.close(xuemaiChongXiuObj.Name)
  end) 
end

return xuemaiChongXiuObj
