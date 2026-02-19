local wolongGuard = {}
wolongGuard.cfg = {"智慧魔石","力量魔石","自然魔石","权利魔石","黑暗魔石",}
function wolongGuard:click(actor)
    for index, value in ipairs(self.cfg) do
        if 1 > getbagitemcount(actor, value) then
            return Sendmsg9(actor, "ff0000", "当前" .. value .. "物品不足！", 1)
        end
    end
    for index, value in ipairs(self.cfg) do
        if not takeitem(actor, value, 1, 0) then
            return Sendmsg9(actor, "ff0000", value .. "扣除失败！", 1)
        end
    end
    sendmsgnew(actor,255,255,"卧龙守卫ぐ：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=251>集齐五颗魔石，成功召唤"
    .."<『卧龙庄主』/FCOLOR=249>！",1,8)
    genmon("ddnb",46,36,"卧龙庄主",2,1,249)
end

return wolongGuard