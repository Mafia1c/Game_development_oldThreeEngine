local MergeBuyTipObj = {}
MergeBuyTipObj.Name = "MergeBuyTipObj"

function MergeBuyTipObj:main(cfg,str)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.old_idx = nil
    --加载UI
    GUI:LoadExport(parent, "npc/WelfareHall/MergeBuyTipUI")
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.CloseBtn,function ()
        ViewMgr.close(MergeBuyTipObj.Name) 
    end)
    GUI:Text_Create(self.ui.Image_2,"title",143,148,16,"#c400d3","《合区特惠礼包》")
    GUI:Text_Create(self.ui.Image_2,"title2",155,116,16,"#FFFF00","礼包价格："..cfg.parame2.."元")
    GUI:Text_Create(self.ui.Image_2,"title3",150,83,16,"#FFFF00",str)
    for i=1,3 do
        GUI:setVisible(self.ui["Button_3"],cfg.parame3 <= 0)
        GUI:setVisible(self.ui["Button_2"],cfg.parame3 > 1)
        GUI:addOnClickEvent(self.ui["Button_"..i],function ()
            SendMsgCallFunByNpc(0,"WelfareHall","BuyMergerGift",cfg.index.."#"..i.."#"..cfg.parame3)
            -- SendMsgCallFunByNpc(0,"WelfareHall","BuyMergerGift",)
        end)
    end
    GUI:UserUILayout(self.ui.Panel_2, {
        dir=2,
        addDir=2,
        gap = {x=50},
        interval=0.1,
    })
end

function MergeBuyTipObj:flushView(str)
    if self.ui.title3 then
        GUI:Text_setString(self.ui.title3,str)
    end
end


return MergeBuyTipObj