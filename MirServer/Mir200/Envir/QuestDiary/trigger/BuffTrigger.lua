BuffTrigger = {}

--#region buff表间隔触发(actor,buffId)
function BuffTrigger.onBuffTrigger(actor, buffId)

    local buffFunTab = {
        [20011] = function () BuffTrigger.test1(actor) end,
    }
    if buffFunTab[buffId] then
        buffFunTab[buffId]()
    end
end

function BuffTrigger.test1(actor) --#region 示例

end