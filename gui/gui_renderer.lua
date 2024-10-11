local gui_renderer = {}
local mainGui = nil
local options = require("gui.gui_options")



function gui_renderer:render()
   if not mainGui then
      mainGui = require("gui.gui")
   end
   if not mainGui.elements.main_tree:push("Looter (Pirated Edition)") then
      return
   end

   mainGui.elements.main_toggle:render("Enable", "Toggles the main module on/off")
    
   if not mainGui.elements.main_toggle:get() then
      mainGui.elements.main_tree:pop()
      return
   end
    
   if mainGui.elements.general.tree:push("General Settings") then
      mainGui.elements.general.behavior_combo:render("Behavior", options.behaviors,
         "When do you want the autolooter to execute?")
      mainGui.elements.general.rarity_combo:render("Rarity", options.rarities,
         "Minimum Rarity for bot to consider picking up.")
      mainGui.elements.general.distance_slider:render("Distance", "Distance from the loot to execute pickup")
      mainGui.elements.general.skip_dropped_toggle:render("Skip Self Dropped",
         "Do you want the bot to not loot items that you dropped yourself?")
      mainGui.elements.general.loot_priority_combo:render("Loot Priority", {"Closest First", "Best First"},
         "Select the priority for looting items")
      mainGui.elements.general.tree:pop()
   end
       
   if mainGui.elements.affix_settings.tree:push("Affix Settings") then
      mainGui.elements.affix_settings.greater_affix_slider:render("Legendary GA Count",
      "Minimum GA's to consider picking up legendary")
      mainGui.elements.affix_settings.unique_greater_affix_slider:render("Unique GA Count",
      "Minimum GA's to consider picking up unique")
      mainGui.elements.affix_settings.uber_unique_greater_affix_slider:render("Uber GA Count",
      "Minimum GA's to consider picking up Uber unique")
      if mainGui.elements.affix_settings.innerTree:push("Advanced Settings") then
         mainGui.elements.affix_settings.custom_toggle:render("Force settings", "Force settings to override Legendary Ga Count")
         if mainGui.elements.affix_settings.armorsTree:push("Armors Settings") then
            mainGui.elements.affix_settings.legendary_helm_slider:render("Legendary Helm GA Count",
               "Minimum GA's to consider picking up legendary helms")
            mainGui.elements.affix_settings.legendary_chest_slider:render("Legendary Chest GA Count",
               "Minimum GA's to consider picking up legendary chests")
            mainGui.elements.affix_settings.legendary_gloves_slider:render("Legendary Gloves GA Count",
               "Minimum GA's to consider picking up legendary gloves")
            mainGui.elements.affix_settings.legendary_pants_slider:render("Legendary Pants GA Count",
               "Minimum GA's to consider picking up legendary Pants")
            mainGui.elements.affix_settings.legendary_boots_slider:render("Legendary Boots GA Count",
               "Minimum GA's to consider picking up legendary Boots")
            mainGui.elements.affix_settings.unique_helm_slider:render("Unique Helm GA Count",
               "Minimum GA's to consider picking up unique helms")
            mainGui.elements.affix_settings.unique_chest_slider:render("Unique Chest GA Count",
               "Minimum GA's to consider picking up unique chests")
            mainGui.elements.affix_settings.unique_gloves_slider:render("Unique Gloves GA Count",
               "Minimum GA's to consider picking up unique gloves")
            mainGui.elements.affix_settings.unique_pants_slider:render("Unique Pants GA Count",
               "Minimum GA's to consider picking up unique Pants")
            mainGui.elements.affix_settings.unique_boots_slider:render("Unique Boots GA Count",
               "Minimum GA's to consider picking up unique Boots")
            mainGui.elements.affix_settings.armorsTree:pop()
         end
         if mainGui.elements.affix_settings.jewerlyTree:push("Jewerly Settings") then
            mainGui.elements.affix_settings.legendary_amulet_slider:render("Legendary Amulet GA Count",
               "Minimum GA's to consider picking up legendary amulets")
            mainGui.elements.affix_settings.unique_amulet_slider:render("Unique Amulet GA Count",
               "Minimum GA's to consider picking up unique amulets")
            mainGui.elements.affix_settings.legendary_ring_slider:render("Legendary Ring GA Count",
               "Minimum GA's to consider picking up legendary rings")
            mainGui.elements.affix_settings.unique_ring_slider:render("Unique Ring GA Count",
               "Minimum GA's to consider picking up unique rings")
            mainGui.elements.affix_settings.jewerlyTree:pop()
         end
         if mainGui.elements.affix_settings.weaponsTree:push("Weapons Settings") then
            if mainGui.elements.affix_settings.oneHandedTree:push("1Handed") then
               mainGui.elements.affix_settings.legendary_1h_mace_slider:render("Legendary 1H Mace GA Count",
                  "Minimum GA's to consider picking up legendary 1H maces")
               mainGui.elements.affix_settings.legendary_1h_axe_slider:render("Legendary 1H Axe GA Count",
                  "Minimum GA's to consider picking up legendary 1H axes")
               mainGui.elements.affix_settings.legendary_1h_sword_slider:render("Legendary 1H Sword GA Count",
                  "Minimum GA's to consider picking up legendary 1H swords")
               mainGui.elements.affix_settings.legendary_dagger_slider:render("Legendary Dagger GA Count",
                  "Minimum GA's to consider picking up legendary Dagger")
               mainGui.elements.affix_settings.legendary_wand_slider:render("Legendary wand GA Count",
                  "Minimum GA's to consider picking up legendary wand")
               mainGui.elements.affix_settings.unique_1h_mace_slider:render("Unique 1H Mace GA Count",
                  "Minimum GA's to consider picking up unique 1H maces")
               mainGui.elements.affix_settings.unique_1h_axe_slider:render("Unique 1H Axe GA Count",
                  "Minimum GA's to consider picking up unique 1H axes")
               mainGui.elements.affix_settings.unique_1h_sword_slider:render("Unique 1H Sword GA Count",
                  "Minimum GA's to consider picking up unique 1H swords")
               mainGui.elements.affix_settings.unique_dagger_slider:render("Unique Dagger GA Count",
                  "Minimum GA's to consider picking up unique Dagger")
               mainGui.elements.affix_settings.unique_wand_slider:render("Unique wand GA Count",
                  "Minimum GA's to consider picking up unique wand")
               mainGui.elements.affix_settings.oneHandedTree:pop()
            end
            if mainGui.elements.affix_settings.twoHandedTree:push("2Handed") then
               mainGui.elements.affix_settings.legendary_2h_mace_slider:render("Legendary 2H Mace GA Count",
                  "Minimum GA's to consider picking up legendary 2H maces")
               mainGui.elements.affix_settings.legendary_2h_axe_slider:render("Legendary 2H Axe GA Count",
                  "Minimum GA's to consider picking up legendary 2H axes")
               mainGui.elements.affix_settings.legendary_2h_sword_slider:render("Legendary 2H Sword GA Count",
                  "Minimum GA's to consider picking up legendary 2H swords")
               mainGui.elements.affix_settings.legendary_2h_polearm_slider:render("Legendary 2H Polearm GA Count",
                  "Minimum GA's to consider picking up legendary 2H polearms")
               mainGui.elements.affix_settings.legendary_staff_slider:render("Legendary Staff GA Count",
                  "Minimum GA's to consider picking up legendary staffs")
               mainGui.elements.affix_settings.legendary_bow_slider:render("Legendary Bow GA Count",
                  "Minimum GA's to consider picking up legendary bows")
               mainGui.elements.affix_settings.legendary_crossbow_slider:render("Legendary Crossbow GA Count",
                  "Minimum GA's to consider picking up legendary crossbows")
               mainGui.elements.affix_settings.legendary_glaive_slider:render("Legendary Glaive GA Count",
                  "Minimum GA's to consider picking up legendary glaive")
               mainGui.elements.affix_settings.legendary_quarterstaff_slider:render("Legendary Quarterstaff GA Count",
                  "Minimum GA's to consider picking up legendary quarterstaff")
               mainGui.elements.affix_settings.unique_2h_mace_slider:render("Unique 2H Mace GA Count",
                  "Minimum GA's to consider picking up unique 2H maces")
               mainGui.elements.affix_settings.unique_2h_axe_slider:render("Unique 2H Axe GA Count",
                  "Minimum GA's to consider picking up unique 2H axes")
               mainGui.elements.affix_settings.unique_2h_sword_slider:render("Unique 2H Sword GA Count",
                  "Minimum GA's to consider picking up unique 2H swords")
               mainGui.elements.affix_settings.unique_2h_polearm_slider:render("Unique 2H Polearm GA Count",
                  "Minimum GA's to consider picking up unique 2H polearms")
               mainGui.elements.affix_settings.unique_staff_slider:render("Unique Staff GA Count",
                  "Minimum GA's to consider picking up unique staffs")
               mainGui.elements.affix_settings.unique_bow_slider:render("Unique Bow GA Count",
                  "Minimum GA's to consider picking up unique bows")
               mainGui.elements.affix_settings.unique_crossbow_slider:render("Unique Crossbow GA Count",
                  "Minimum GA's to consider picking up unique crossbows")
               mainGui.elements.affix_settings.unique_glaive_slider:render("Unique Glaive GA Count",
                  "Minimum GA's to consider picking up unique glaive")
               mainGui.elements.affix_settings.unique_quarterstaff_slider:render("Unique Quarterstaff GA Count",
                  "Minimum GA's to consider picking up unique quarterstaff")
               mainGui.elements.affix_settings.twoHandedTree:pop()
            end
            if mainGui.elements.affix_settings.offHandsTree:push("OffHands") then
               mainGui.elements.affix_settings.legendary_focus_slider:render("Legendary Focus GA Count",
                  "Minimum GA's to consider picking up legendary Focuses")
               mainGui.elements.affix_settings.legendary_totem_slider:render("Legendary Totem GA Count",
                  "Minimum GA's to consider picking up legendary Totems")
               mainGui.elements.affix_settings.offHandsTree:pop()
            end
            mainGui.elements.affix_settings.weaponsTree:pop()
         end
         mainGui.elements.affix_settings.innerTree:pop()
      end
      mainGui.elements.affix_settings.tree:pop()
   end
 
   if mainGui.elements.item_types.tree:push("Item Types") then
      mainGui.elements.item_types.quest_items_toggle:render("Quest Items",
         "Do you want to pickup Quest items, this includes Objectives in dungeons.")
      mainGui.elements.item_types.crafting_items_toggle:render("Crafting Items", "Do you want to pickup Crafting Items?")
      mainGui.elements.item_types.boss_items_toggle:render("Boss Items", "Do you want to pickup Boss summon items?")
      mainGui.elements.item_types.rare_elixir_items_toggle:render("Rare Elixirs",
         "Do you wanna pickup Rare Elixirs? (Momentum, Holy Bolts)")
      mainGui.elements.item_types.advanced_elixir_items_toggle:render("Advanced Elixirs",
         "Do you wanna pickup Advanced Elixirs II?")
      mainGui.elements.item_types.sigil_items_toggle:render("Sigils", "Do you want to loot dungeon sigils?")
      mainGui.elements.item_types.event_items_toggle:render("Event", "Do you want to pickup Treasure Bags?")
      mainGui.elements.item_types.event_items_toggle:render("Event", "Do you want to pickup Treasure Bags?")     
      mainGui.elements.item_types.cinders_toggle:render("Cinders", "Do you want to pickup Cinders?")
      mainGui.elements.item_types.tree:pop()
   end
 
   if mainGui.elements.debug.tree:push("Debug") then
      mainGui.elements.debug.draw_wanted_toggle:render("Draw Wanted",
         "Do you want to draw the items that the bot considers picking up? (Debug)")
      mainGui.elements.debug.tree:pop()
   end
 
   mainGui.elements.main_tree:pop()
 end


 return gui_renderer
