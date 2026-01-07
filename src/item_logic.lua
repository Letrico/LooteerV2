
local ItemLogic = {}


--Jewerly
function ItemLogic.is_legendary_amulet(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Amulet")
 end
 function ItemLogic.is_unique_amulet(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and (item_info:get_skin_name():find("Amulet") or item_info:get_skin_name():find("Necklace"))
 end
 function ItemLogic.is_unique_ring(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and (item_info:get_skin_name():find("Ring"))
 end
 function ItemLogic.is_legendary_ring(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Ring")
 end
 --Armors
 function ItemLogic.is_legendary_helm(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("HLM")
 end
 function ItemLogic.is_unique_helm(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("HLM")
 end
 function ItemLogic.is_legendary_chest(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("TRS")
 end
 function ItemLogic.is_unique_chest(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("TRS")
 end
 function ItemLogic.is_legendary_gloves(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("GLV")
 end
 function ItemLogic.is_unique_gloves(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and (item_info:get_skin_name():find("GLV") or item_info:get_skin_name():find("Gloves"))
 end
 function ItemLogic.is_legendary_pants(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("LEG")
 end
 function ItemLogic.is_unique_pants(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and (item_info:get_skin_name():find("LEG") or item_info:get_skin_name():find("Pants"))
 end
 function ItemLogic.is_legendary_boots(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("BTS")
 end
 function ItemLogic.is_unique_boots(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("BTS")
 end
 
 --offhand
 function ItemLogic.is_legendary_focus(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("offHandsSorc")
 end
 function ItemLogic.is_legendary_totem(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("offHandsDruid")
 end
 function ItemLogic.is_legendary_shield(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("shield")
 end
 function ItemLogic.is_unique_shield(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("shield")
 end


 --1Handed Wepeons
 function ItemLogic.is_legendary_1h_mace(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("mace")
 end
 function ItemLogic.is_legendary_1h_axe(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("axe")
 end
 function ItemLogic.is_legendary_1h_sword(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("sword")
 end
 function ItemLogic.is_legendary_dagger(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("dagger")
 end
 function ItemLogic.is_legendary_wand(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("wand")
 end
 function ItemLogic.is_unique_1h_mace(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("mace")
 end
 function ItemLogic.is_unique_1h_axe(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("axe")
 end
 function ItemLogic.is_unique_1h_sword(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("sword")
 end
 function ItemLogic.is_unique_dagger(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("dagger")
 end
 function ItemLogic.is_unique_wand(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("wand")
 end
 
 --2H wepeons
 function ItemLogic.is_legendary_2h_mace(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Mace")
 end
 function ItemLogic.is_legendary_2h_axe(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Axe")
 end
 function ItemLogic.is_legendary_2h_sword(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Sword")
 end
 function ItemLogic.is_legendary_2h_polearm(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Polearm")
 end
 function ItemLogic.is_legendary_staff(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Staff")
 end
 function ItemLogic.is_legendary_bow(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Bow")
 end
 function ItemLogic.is_legendary_crossbow(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Crossbow")
 end
 function ItemLogic.is_legendary_glaive(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Glaive")
 end
 function ItemLogic.is_legendary_quarterstaff(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 5 and item_info:get_skin_name():find("Quarterstaff")
 end
 function ItemLogic.is_unique_2h_mace(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("Mace")
 end
 function ItemLogic.is_unique_2h_axe(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("Axe")
 end
 function ItemLogic.is_unique_2h_sword(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("Sword")
 end
 function ItemLogic.is_unique_2h_polearm(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("Polearm")
 end
 function ItemLogic.is_unique_staff(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("Staff")
 end
 function ItemLogic.is_unique_bow(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("Bow")
 end
 function ItemLogic.is_unique_crossbow(item)
    local item_info = item:get_item_info()
    return item_info:get_rarity() == 6 and item_info:get_skin_name():find("Crossbow")
 end
 function ItemLogic.is_unique_glaive(item)
   local item_info = item:get_item_info()
   return item_info:get_rarity() == 6 and item_info:get_skin_name():find("Glaive")
end
function ItemLogic.is_unique_quarterstaff(item)
   local item_info = item:get_item_info()
   return item_info:get_rarity() == 6 and item_info:get_skin_name():find("Quarterstaff")
end


 return ItemLogic