-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Kasaroro
-- Type: Consulate Representative
-- Involved in Mission: 2-3 Windurst
-- !pos -72 -3 34 231
-----------------------------------
package.loaded["scripts/zones/Northern_San_dOria/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Northern_San_dOria/TextIDs");
require("scripts/globals/keyitems");
require("scripts/globals/missions");
-----------------------------------

function onTrade(player,npc,trade)

    if (player:getQuestStatus(SANDORIA,FLYERS_FOR_REGINE) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(532,1) and trade:getItemCount() == 1) then -- Trade Magicmart_flyer
            player:messageSpecial(FLYER_REFUSED);
        end
    end

end;

function onTrigger(player,npc)

    pNation = player:getNation();
    if (pNation == NATION_WINDURST) then
        currentMission = player:getCurrentMission(pNation);
        MissionStatus = player:getVar("MissionStatus");

        if (currentMission == THE_THREE_KINGDOMS) then
            if (MissionStatus == 2) then
                player:startEvent(546);
            elseif (MissionStatus == 6) then
                player:showText(npc,KASARORO_DIALOG + 7);
            elseif (MissionStatus == 7) then
                player:startEvent(547);
            elseif (MissionStatus == 11) then
                player:showText(npc,KASARORO_DIALOG + 20);
            end
        elseif (currentMission == THE_THREE_KINGDOMS_SANDORIA) then
            if (MissionStatus == 3) then
                player:showText(npc,KASARORO_DIALOG);
            elseif (MissionStatus == 4) then
                player:startEvent(549);
            elseif (MissionStatus == 5) then
                player:startEvent(550); -- done with Sandy first path, now go to bastok
            end
        elseif (currentMission == THE_THREE_KINGDOMS_SANDORIA2) then
            if (MissionStatus == 8) then
                player:showText(npc,KASARORO_DIALOG);
            elseif (MissionStatus == 10) then
                player:startEvent(551);
            end
        elseif (player:hasCompletedMission(WINDURST,THE_THREE_KINGDOMS)) then
            player:startEvent(604);
        else
            player:startEvent(548);
        end
    else
        player:startEvent(548);
    end

end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);

    if (csid == 546) then
        player:addMission(WINDURST,THE_THREE_KINGDOMS_SANDORIA);
        player:delKeyItem(LETTER_TO_THE_CONSULS_WINDURST);
        player:setVar("MissionStatus",3);
    elseif (csid == 550) then
        player:addMission(WINDURST,THE_THREE_KINGDOMS);
        player:setVar("MissionStatus",6);
    elseif (csid == 547) then
        player:addMission(WINDURST,THE_THREE_KINGDOMS_SANDORIA2);
        player:setVar("MissionStatus",8);
    elseif (csid == 551) then
        player:addMission(WINDURST,THE_THREE_KINGDOMS);
        player:delKeyItem(KINDRED_CREST);
        player:addKeyItem(KINDRED_REPORT);
        player:messageSpecial(KEYITEM_OBTAINED,KINDRED_REPORT);
        player:setVar("MissionStatus",11);
    end

end;