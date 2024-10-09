local plugin_label = "Looter (Pirated Edition) "
local gui = {}
local gui_renderer = nil
local options = require("gui.gui_options")


gui.elements = {
   main_tree = tree_node:new(0),
   main_toggle = checkbox:new(false, get_hash(plugin_label .. "_main_toggle")),
   
   general = {
      tree = tree_node:new(1),
      behavior_combo = combo_box:new(0, get_hash(plugin_label .. "_behavior_combo")),
      loot_priority_combo = combo_box:new(0, get_hash(plugin_label .. "_loot_priority_combo")), 
      rarity_combo = combo_box:new(0, get_hash(plugin_label .. "_rarity_combo")),
      distance_slider = slider_int:new(1, 30, 2, get_hash(plugin_label .. "_distance_slider")),
      skip_dropped_toggle = checkbox:new(false, get_hash(plugin_label .. "_skipped_dropped_toggle")),
   },

   affix_settings = {
      tree = tree_node:new(1),
      greater_affix_slider = slider_int:new(0, 3, 0, get_hash(plugin_label .. "_greater_affix_slider")),
      unique_greater_affix_slider = slider_int:new(0, 4, 0, get_hash(plugin_label .. "_unique_greater_affix_slider")),
      innerTree = tree_node:new(1),
      custom_toggle = checkbox:new(false, get_hash(plugin_label .. "_costum_toggle")),
      armorsTree = tree_node:new(1),
      jewerlyTree = tree_node:new(1),
      weaponsTree = tree_node:new(1),
      oneHandedTree = tree_node:new(1),
      twoHandedTree = tree_node:new(1),
      offHandsTree = tree_node:new(1),
      --armors
         legendary_helm_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_helm_slider")),
         legendary_chest_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_chest_slider")),
         legendary_gloves_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_gloves_slider")),
         legendary_pants_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_pants_slider")),
         legendary_boots_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_boots_slider")),
         unique_helm_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_helm_slider")),
         unique_chest_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_chest_slider")),
         unique_gloves_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_gloves_slider")),
         unique_pants_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_pants_slider")),
         unique_boots_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_boots_slider")),
      --jewerly
         legendary_amulet_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_amulet_slider")),
         unique_amulet_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_amulet_slider")),
         legendary_ring_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_ring_slider")),
         unique_ring_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_ring_slider")),
      --offhand
         legendary_focus_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_focus_slider")),
         legendary_totem_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_totem_slider")),
      
         --weapons
         --1h
         legendary_1h_mace_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_1h_mace_slider")),
         legendary_1h_sword_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_1h_sword_slider")),
         legendary_1h_axe_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_1h_axe_slider")),
         legendary_dagger_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_dagger_slider")),
         legendary_wand_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_wand_slider")),
         unique_1h_mace_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_1h_mace_slider")),
         unique_1h_sword_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_1h_sword_slider")),
         unique_1h_axe_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_1h_axe_slider")),
         unique_dagger_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_dagger_slider")),
         unique_wand_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_wand_slider")),
         --2h
         legendary_2h_mace_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_2h_mace_slider")),
         legendary_2h_sword_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_2h_sword_slider")),
         legendary_2h_axe_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_2h_axe_slider")),
         legendary_2h_polearm_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_2h_polearm_slider")),
         legendary_staff_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_staff_slider")),
         legendary_bow_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_bow_slider")),
         legendary_crossbow_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_crossbow_slider")),
         legendary_glaive_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_glaive_slider")),
         legendary_quarterstaff_slider = slider_int:new(0, 3, 2, get_hash(plugin_label .. "_legendary_quarterstaff_slider")),
         unique_2h_mace_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_2h_mace_slider")),
         unique_2h_sword_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_2h_sword_slider")),
         unique_2h_axe_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_2h_axe_slider")),
         unique_2h_polearm_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_2h_polearm_slider")),
         unique_staff_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_staff_slider")),
         unique_bow_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_bow_slider")),
         unique_crossbow_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_crossbow_slider")),
         unique_glaive_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_glaive_slider")),
         unique_quarterstaff_slider = slider_int:new(0, 4, 2, get_hash(plugin_label .. "_unique_quarterstaff_slider")),
         
      --ubers
      uber_unique_greater_affix_slider = slider_int:new(0, 4, 0,get_hash(plugin_label .. "_uber_unique_greater_affix_slider")),
   },

   item_types = {
      tree = tree_node:new(1),
      event_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_event_items_toggle")),
      quest_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_quest_items_toggle")),
      crafting_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_crafting_items_toggle")),
      boss_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_boss_items_toggle")),
      rare_elixir_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_rare_elixir_items_toggle")),
      advanced_elixir_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_advanced_elixir_items_toggle")),
      sigil_items_toggle = checkbox:new(false, get_hash(plugin_label .. "_sigil_items_toggle")),
      cinders_toggle = checkbox:new(false, get_hash(plugin_label .. "_cinders_toggle")),
   },

   debug = {
      tree = tree_node:new(1),
      draw_wanted_toggle = checkbox:new(false, get_hash(plugin_label .. "_draw_wanted_toggle")),
   },
}
function gui.render()
   if not gui_renderer then
      gui_renderer = require("gui.gui_renderer")
  end
  gui_renderer.render()
end

return gui