local gui = require("gui")

local Settings = {}

local settings = {
   enabled = false,
   custom_toggle = false,
   isArmor = false ,
   behavior = 0,
   rarity = 0,
   distance = 2,
   skip_dropped = false,
   loot_priority = 0,
   ga_count = 0,
   unique_ga_count = 0,
   uber_unique_ga_count = 0,
   quest_items = false,
   crafting_items = false,
   cinders = false,
   boss_items = false,
   rare_elixirs = false,
   advanced_elixirs = false,
   basic_elixirs = false,
   sigils = false,
   rune = false,
   tribute = false,
   scroll = false,
   event_items = true,
   --jewerly
   legendary_amulet_ga_count = 0,
   legendary_ring_ga_count = 0,
   unique_amulet_ga_count = 0,
   unique_ring_ga_count = 0,
   --armors
   legendary_helm_ga_count = 0,
   legendary_chest_ga_count = 0,
   legendary_gloves_ga_count = 0,
   legendary_pants_ga_count = 0,
   legendary_boots_ga_count = 0,
   unique_helm_ga_count = 0,
   unique_chest_ga_count = 0,
   unique_gloves_ga_count = 0,
   unique_pants_ga_count = 0,
   unique_boots_ga_count = 0,
   --offhand
   legendary_focus_ga_count = 0,
   legendary_totem_ga_count = 0,

   --wepeons
   --1h
   legendary_1h_mace_ga_count = 0,
   legendary_1h_sword_ga_count = 0,
   legendary_1h_axe_ga_count = 0,
   legendary_dagger_ga_count = 0,
   legendary_wand_ga_count = 0,
   unique_1h_mace_ga_count = 0,
   unique_1h_sword_ga_count = 0,
   unique_1h_axe_ga_count = 0,
   unique_dagger_ga_count = 0,
   unique_wand_ga_count = 0,
   --2h
   legendary_2h_mace_ga_count = 0,
   legendary_2h_sword_ga_count = 0,
   legendary_2h_axe_ga_count = 0,
   legendary_2h_polearm_ga_count = 0,
   legendary_staff_ga_count = 0,
   legendary_bow_ga_count = 0,
   legendary_crossbow_ga_count = 0,
   legendary_glaive_ga_count = 0,
   legendary_quarterstaff_ga_count = 0,
   unique_2h_mace_ga_count = 0,
   unique_2h_sword_ga_count = 0,
   unique_2h_axe_ga_count = 0,
   unique_2h_polearm_ga_count = 0,
   unique_staff_ga_count = 0,
   unique_bow_ga_count = 0,
   unique_crossbow_ga_count = 0,
   unique_glaive_ga_count = 0,
   unique_quarterstaff_ga_count = 0,

   draw_wanted_items = false
}

function Settings.update()
   settings = {
      enabled = gui.elements.main_toggle:get(),
      
      -- General Settings
      behavior = gui.elements.general.behavior_combo:get(),
      rarity = gui.elements.general.rarity_combo:get(),
      distance = gui.elements.general.distance_slider:get(),
      skip_dropped = gui.elements.general.skip_dropped_toggle:get(),
      loot_priority = gui.elements.general.loot_priority_combo:get(),
      
      -- Affix Settings
      ga_count = gui.elements.affix_settings.greater_affix_slider:get(),
      unique_ga_count = gui.elements.affix_settings.unique_greater_affix_slider:get(),
      uber_unique_ga_count = gui.elements.affix_settings.uber_unique_greater_affix_slider:get(),
      legendary_amulet_ga_count = gui.elements.affix_settings.legendary_amulet_slider:get(),
      unique_amulet_ga_count = gui.elements.affix_settings.unique_amulet_slider:get(),
      unique_ring_ga_count = gui.elements.affix_settings.unique_ring_slider:get(),
      legendary_ring_ga_count = gui.elements.affix_settings.legendary_ring_slider:get(),
      
      -- Armors Settings
      custom_toggle = gui.elements.affix_settings.custom_toggle:get(),
      legendary_helm_ga_count = gui.elements.affix_settings.legendary_helm_slider:get(),
      legendary_chest_ga_count = gui.elements.affix_settings.legendary_chest_slider:get(),
      legendary_gloves_ga_count = gui.elements.affix_settings.legendary_gloves_slider:get(),
      legendary_pants_ga_count = gui.elements.affix_settings.legendary_pants_slider:get(),
      legendary_boots_ga_count = gui.elements.affix_settings.legendary_boots_slider:get(),
      unique_helm_ga_count = gui.elements.affix_settings.unique_helm_slider:get(),
      unique_chest_ga_count = gui.elements.affix_settings.unique_chest_slider:get(),
      unique_gloves_ga_count = gui.elements.affix_settings.unique_gloves_slider:get(),
      unique_pants_ga_count = gui.elements.affix_settings.unique_pants_slider:get(),
      unique_boots_ga_count = gui.elements.affix_settings.unique_boots_slider:get(),
      --offhand
      legendary_focus_ga_count = gui.elements.affix_settings.legendary_focus_slider:get(),
      legendary_totem_ga_count = gui.elements.affix_settings.legendary_totem_slider:get(),

      --Wepeons Settings
         --1h
         legendary_1h_mace_ga_count = gui.elements.affix_settings.legendary_1h_mace_slider:get(),
         legendary_1h_sword_ga_count = gui.elements.affix_settings.legendary_1h_sword_slider:get(),
         legendary_1h_axe_ga_count = gui.elements.affix_settings.legendary_1h_axe_slider:get(),
         legendary_dagger_ga_count = gui.elements.affix_settings.legendary_dagger_slider:get(),
         legendary_wand_ga_count = gui.elements.affix_settings.legendary_wand_slider:get(),
         unique_1h_mace_ga_count = gui.elements.affix_settings.unique_1h_mace_slider:get(),
         unique_1h_sword_ga_count = gui.elements.affix_settings.unique_1h_sword_slider:get(),
         unique_1h_axe_ga_count = gui.elements.affix_settings.unique_1h_axe_slider:get(),
         unique_dagger_ga_count = gui.elements.affix_settings.unique_dagger_slider:get(),
         unique_wand_ga_count = gui.elements.affix_settings.unique_wand_slider:get(),
         --2h
         legendary_2h_mace_ga_count = gui.elements.affix_settings.legendary_2h_mace_slider:get(),
         legendary_2h_sword_ga_count = gui.elements.affix_settings.legendary_2h_sword_slider:get(),
         legendary_2h_axe_ga_count = gui.elements.affix_settings.legendary_2h_axe_slider:get(),
         legendary_2h_polearm_ga_count = gui.elements.affix_settings.legendary_2h_polearm_slider:get(),
         legendary_staff_ga_count = gui.elements.affix_settings.legendary_staff_slider:get(),
         legendary_bow_ga_count = gui.elements.affix_settings.legendary_bow_slider:get(),
         legendary_crossbow_ga_count = gui.elements.affix_settings.legendary_crossbow_slider:get(),
         legendary_glaive_ga_count = gui.elements.affix_settings.legendary_glaive_slider:get(),
         legendary_quarterstaff_ga_count = gui.elements.affix_settings.legendary_quarterstaff_slider:get(),
         unique_2h_mace_ga_count = gui.elements.affix_settings.unique_2h_mace_slider:get(),
         unique_2h_sword_ga_count = gui.elements.affix_settings.unique_2h_sword_slider:get(),
         unique_2h_axe_ga_count = gui.elements.affix_settings.unique_2h_axe_slider:get(),
         unique_2h_polearm_ga_count = gui.elements.affix_settings.unique_2h_polearm_slider:get(),
         unique_staff_ga_count = gui.elements.affix_settings.unique_staff_slider:get(),
         unique_bow_ga_count = gui.elements.affix_settings.unique_bow_slider:get(),
         unique_crossbow_ga_count = gui.elements.affix_settings.unique_crossbow_slider:get(),
         unique_glaive_ga_count = gui.elements.affix_settings.unique_glaive_slider:get(),
         unique_quarterstaff_ga_count = gui.elements.affix_settings.unique_quarterstaff_slider:get(),

      
      -- Item Types
      quest_items = gui.elements.item_types.quest_items_toggle:get(),
      crafting_items = gui.elements.item_types.crafting_items_toggle:get(),
      boss_items = gui.elements.item_types.boss_items_toggle:get(),
      rare_elixirs = gui.elements.item_types.rare_elixir_items_toggle:get(),
      basic_elixirs = gui.elements.item_types.basic_elixir_items_toggle:get(),
      advanced_elixirs = gui.elements.item_types.advanced_elixir_items_toggle:get(),
      sigils = gui.elements.item_types.sigil_items_toggle:get(),
      rune = gui.elements.item_types.rune_items_toggle:get(),
      cinders = gui.elements.item_types.cinders_toggle:get(),
      tribute = gui.elements.item_types.tribute_items_toggle:get(),
      scroll = gui.elements.item_types.scroll_items_toggle:get(),
      event_items = gui.elements.item_types.event_items_toggle:get(),

      -- Debug
      draw_wanted_items = gui.elements.debug.draw_wanted_toggle:get()
   }
end

function Settings.get()
   return settings
end

function Settings.should_execute()
   return settings.behavior == 0 or
       (settings.behavior == 1 and orbwalker.get_orb_mode() == orb_mode.clear)
end

return Settings
