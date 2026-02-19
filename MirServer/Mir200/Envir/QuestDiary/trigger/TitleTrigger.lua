TitleTrigger = {}
--#region 有顶戴的0号位称号(特效id,x偏移,y偏移)
TitleTrigger.iconTab0 = {["诛仙之力·王"]={15276,0,0},["斩尽天下不收刀"]={40231,-70,-40},["横扫全服"]={20686,-176,-82},["富甲天下"]={20111,0,0},["屠尽天下又何妨"]={20010,0,0}
,["神念一现死一片"]={20024,0,0},["九霄风云齐聚会"]={20025,0,0},["斩断红尘多情客"]={20019,0,0},["头号玩家"]={15278,-26,60},["全服最靓的仔"]={15277,-30,60},["原始先锋"]={20092,0,0}
,["英雄回归"]={20088,0,0},["非凡勇者"]={20086,0,0},["先锋骑士"]={20085,0,0},["摸金校尉"]={20082,0,0},["血色主宰"]={20087,0,0},["头号人物"]={20089,0,0},["超群绝伦"]={20093,0,0}
,["举世无双"]={20094,0,0},["血饮·杀戮武林"]={20627,-100,-40},["泰斗·武林名宿"]={20631,-100,-40},["霸王·武动乾坤"]={20633,-100,-40},["武圣·以武入道"]={20634,-100,-40}
,["圣裁·不落巅峰"]={20650,-160,-64},["死神·终极审判"]={20649,-160,-64},["纪元·九龙真神"]={20653,-160,-64},["末日·修罗降临"]={20651,-160,-64},["起源·涅槃重生"]={20656,-110,-60}
,["毁灭·唯吾独尊"]={20615,-160,-60},["独孤求败"]={30311,-24,74},["盖世英雄"]={30312,-24,74},["热血同行"]={30313,-24,74},["十步一殺"]={30314,-24,74},["唯我独有"]={30315,-24,74}
,["雪山孤剑鸣"]={30316,-24,74},["一刀一个小朋友"]={30317,-24,74},["一骑当千"]={30318,-24,74},["以德服人"]={30319,-24,74},["与人善良"]={30320,-24,74}}
--#region 魂环顶戴的称号2号位,(特效id,x偏移,y偏移)
TitleTrigger.iconTab2 = {["至尊魂环"]={22108,-106,30},["荣耀魂环"]={22105,-86,30},["王者魂环"]={22104,-98,30},["一路长虹魂环"]={46125,0,-10}}
--#region 足迹特效
TitleTrigger.moveEffTab = {["城主专属足迹"]=46139,["步步高升足迹"]=40197,}


--#region 称号改变触发(玩家对象，称号道具id)添加,更改
function TitleTrigger.onTitlechangedex(actor,titleIdx)
    local titleName = getstditeminfo(titleIdx, 1) --#region 称号道具名

    if TitleTrigger.iconTab0[titleName] then --#region 0号位顶戴
        local infoTab = TitleTrigger.iconTab0[titleName]
        VarApi.setPlayerTStrVar(actor,VarStrDef.ICON_0,
        titleName.."#"..infoTab[1].."#"..infoTab[2].."#"..infoTab[3],true)--#region 称号顶戴(0号位)称号名称#特效id#x偏移#y偏移
        seticon(actor,0,1,infoTab[1],infoTab[2],infoTab[3],1,0,0)
    end
    if TitleTrigger.iconTab2[titleName] then --#region 2号位顶戴
        local infoTab = TitleTrigger.iconTab2[titleName]
        VarApi.setPlayerTStrVar(actor,VarStrDef.ICON_2,
        titleName.."#"..infoTab[1].."#"..infoTab[2].."#"..infoTab[3],true)--#region 称号顶戴(2号位)称号名称#特效id#x偏移#y偏移
        seticon(actor,2,1,infoTab[1],infoTab[2],infoTab[3],1,0,1)
    end
    if TitleTrigger.moveEffTab[titleName] then --#region 足迹特效
        setmoveeff(actor, TitleTrigger.moveEffTab[titleName], 1)
        VarApi.setPlayerTStrVar(actor,"UL_disguise2",titleName,true)
    end
end

--#region 称号取消触发(玩家对象，称号道具id)取消穿戴,删除
function TitleTrigger.onUntitledex(actor,titleIdx)
    local titleName = getstditeminfo(titleIdx, 1) --#region 称号道具名

    --#region 取消顶戴
    if TitleTrigger.iconTab0[titleName] then --#region 0号位顶戴
        VarApi.setPlayerTStrVar(actor,VarStrDef.ICON_0,"",true)
        seticon(actor,0,-1)
    end
    if TitleTrigger.iconTab2[titleName] then --#region 2号位顶戴
        VarApi.setPlayerTStrVar(actor,VarStrDef.ICON_2,"",true)
        seticon(actor,2,-1)
    end
    --#endregion

    if TitleTrigger.moveEffTab[titleName] then --#region 足迹特效
        setmoveeff(actor,0,1)
        VarApi.setPlayerTStrVar(actor,"UL_disguise2","",true)
    end
    if titleName == "城主专属足迹" then --#region 装扮足迹取消
        for titleID, endTime in pairs(newgettitlelist(actor) or {}) do
            if getstditeminfo(titleID, 1) == "城主专属足迹" and os.time()-endTime <= 10 then
                local hastab = json2tbl(VarApi.getPlayerTStrVar(actor, "TL_disguise"))
                for i = 1, #hastab["2"] do
                    if hastab["2"][i] == "城主专属足迹" then
                        setmoveeff(actor,0,1)
                        table.remove(hastab["2"], i)
                        VarApi.setPlayerTStrVar(actor, "TL_disguise", tbl2json(hastab), true)
                        break
                    end
                end
                break
            end
        end
    end
end