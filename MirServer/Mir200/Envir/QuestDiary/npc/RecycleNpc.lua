local RecycleNpc = {}
RecycleNpc.cfg = include("QuestDiary/config/recycleCfg.lua")

function RecycleNpc:onClickCheckBox(actor, index, value)
    index = tonumber(index)
    if nil == index then
        return
    end
    local tmp_list = VarApi.getPlayerTStrVar(actor, "T_recycle_info")
    if "" == tmp_list then
        tmp_list = {}
        for k, v in pairs(self.cfg) do
            tmp_list[k] = "0"
        end
    else
        tmp_list = json2tbl(tmp_list) or {}
    end
    tmp_list[index] = value
    VarApi.setPlayerTStrVar(actor, "T_recycle_info", tbl2json(tmp_list))
end

function RecycleNpc:onClickAutoBtn(actor, index, value)
    index = tonumber(index)
    local tmp_str = VarApi.getPlayerTStrVar(actor, "T_recycle_state")
    if "" == tmp_str then
        tmp_str = {}
    else
        tmp_str = json2tbl(tmp_str)
    end
    tmp_str[index] = value
    VarApi.setPlayerTStrVar(actor, "T_recycle_state", tbl2json(tmp_str))
end

function RecycleNpc:onRecycleItem(actor, page)
    if checkkuafu(actor) then
        return
    end
    -- 点击回收
    local tmp_list = VarApi.getPlayerTStrVar(actor, "T_recycle_info")
    if "" == tmp_list then
        return
    end
    tmp_list = json2tbl(tmp_list)
    local total_yb = 0
    local total_exp = 0
    local total_jgs = 0
    local total_hls = 0
    local total_lf = 0
    for k, v in pairs(tmp_list) do
        local data = self.cfg[k]
        if v == "1" then
            for _,  name in pairs(data.list_arr) do
                local count = getbagitemcount(actor, name)
                if count > 0 and takeitem(actor, name, count) then
                    total_yb = total_yb + data.yb * count
                    total_exp = total_exp + data.exp * count
                    total_jgs = total_jgs + data.jgs * count
                    total_hls = total_hls + data.hls * count
                    total_lf = total_lf + data.lf * count
                end
            end
        end
    end
    local rate = VarApi.getPlayerJIntVar(actor, "J_add_recycle_rate")
    local tips = ""
    if total_yb > 0 then
        total_yb = total_yb + total_yb * (rate / 10)
        total_yb = math.floor(total_yb)
        local yb_id = 2
        if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) <= 0 then
            yb_id = 4
        end
        local name = getstditeminfo(yb_id, 1)
        tips = tips .. name.."x"..total_yb
        changemoney(actor, yb_id, "+", total_yb, "回收元宝", true)
    end
    if total_exp > 0 then
        local add_exp = 0
        if VarApi.getPlayerUIntVar(actor, VarIntDef.FirstRecharge) ~= 0 then
            add_exp = total_exp * 0.5 + add_exp
        end
        if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) ~= 0 then
            add_exp = total_exp * 0.5 + add_exp
        end
        if checktitle(actor, "横扫全服") then
            add_exp = total_exp * 0.5 + add_exp
        end
        if checktitle(actor, "富甲天下") then
            add_exp = total_exp * 0.5 + add_exp
        end        
        total_exp = total_exp + add_exp
        tips = tips .. "," .."经验x"..total_exp
        changeexp(actor, "+", total_exp, true)
    end
    if total_jgs > 0 then
        total_jgs = total_jgs + total_jgs * (rate / 10)
        total_jgs = math.floor(total_jgs)
        local jgs_id = 5
        if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) <= 0 then
            jgs_id = 21
        end
        local name = getstditeminfo(jgs_id, 1)
        tips = tips .. "," .. name.."x"..total_jgs
        changemoney(actor, jgs_id, "+", total_jgs, "回收金刚石", true)
    end
    if total_hls > 0 then
        giveitem(actor, "火龙石", total_hls)
    end
    if total_lf > 0 then
        total_lf = total_lf + total_lf * (rate / 10)
        total_lf = math.floor(total_lf)
        local lf_id = 7
        if VarApi.getPlayerUIntVar(actor, VarIntDef.ZSTQ_LEVEL) <= 0 then
            lf_id = 20
        end
        local name = getstditeminfo(lf_id, 1)
        tips = tips .. "," .. name.."x"..total_lf
        changemoney(actor, lf_id, "+", total_lf, "回收灵符", true)
    end
    if "" ~= tips then
        Sendmsg9(actor, "ffffff", "回收获得: "..tips, 1)
    end
end

return RecycleNpc