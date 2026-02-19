local ExorcismVenerable = {}
ExorcismVenerable.cfg = include("QuestDiary/config/ExorcismVenerableCfg.lua")

function ExorcismVenerable:upEvent(actor)
    local spirit_level = VarApi.getPlayerUIntVar(actor,"U_EV_spirit_level")
    lualib:ShowNpcUi(actor,"ExorcismVenerableOBJ", spirit_level) 
end

function ExorcismVenerable:UpSpiritLevel(actor)
    local spirit_level = VarApi.getPlayerUIntVar(actor,"U_EV_spirit_level")
    local cfg = ExorcismVenerable.cfg[spirit_level]
    if ExorcismVenerable:IsMax(spirit_level) then
        Sendmsg9(actor, "ffffff", "元神之力等级已满", 1)
    else
        for i = 1, 2 do
            if getbagitemcount(actor,cfg["need_item"..i]) < cfg["need_num"..i] then
               return  Sendmsg9(actor, "ffffff", cfg["need_item"..i] .. "不足！", 1)
            end
        end
        for i = 1, 2 do
            if not takeitemex(actor,cfg["need_item"..i],cfg["need_num"..i],0,"驱魔尊者扣除") then
               return  Sendmsg9(actor, "ffffff", cfg["need_item"..i] .. "不足！", 1)
            end
        end
        local is_tupo = spirit_level > 0 and (spirit_level+1) % 10 == 0
        if is_tupo then
            if getbindmoney(actor,"灵符") < 10000 then
               return  Sendmsg9(actor, "ffffff",  "灵符不足！", 1)
            end
            if not consumebindmoney(actor,"灵符",10000,"驱魔尊者扣除") then
               return  Sendmsg9(actor, "ffffff",  "扣除失败！", 1)
            end
        end
        Sendmsg9(actor, "ffffff", "提升元神成功", 1)
        local next_cfg = ExorcismVenerable.cfg[spirit_level+1]
         
        if spirit_level >= 1 then
            deprivetitle(actor,cfg.Name)
        end
        VarApi.setPlayerUIntVar(actor,"U_EV_spirit_level",spirit_level + 1)
        confertitle(actor,next_cfg.Name)
        lualib:FlushNpcUi(actor,"ExorcismVenerableOBJ", spirit_level + 1) 
    end
end
function ExorcismVenerable:IsMax(spirit_level)
    return spirit_level >= #ExorcismVenerable.cfg
end

return ExorcismVenerable
