local Settings = require("src.settings")
local Utils = require("utils.utils")
local CustomItems = require("data.custom_items")
local ItemLogic = require("src.item_logic")

local ItemManager = {}

-- Table to store item type patterns
local item_type_patterns = {
   sigil = { "Nightmare_Sigil", "BSK_Sigil" },
   equipment = { "Base", "Amulet", "Ring" },
   quest = { "Global", "Glyph", "QST", "DGN", "pvp_currency" },
   crafting = { "CraftingMaterial" },
   cinders = { "Test_BloodMoon_Currency" }
}

-- Generic function to check item type
function ItemManager.check_item_type(item, type_name)
   local item_info = item:get_item_info()
   local name = item_info:get_skin_name()

   -- Special case for sigils and equipment
   if (type_name == "sigil" or type_name == "equipment") and item_info:get_rarity() ~= 0 then
      return false
   end

   for _, pattern in ipairs(item_type_patterns[type_name] or {}) do
      if name:find(pattern) then
         return true
      end
   end
   return false
end

function ItemManager.check_is_cinders(item)
   return ItemManager.check_item_type(item, "cinders")
end

-- Specific functions using the generic check
function ItemManager.check_is_sigil(item)
   return ItemManager.check_item_type(item, "sigil")
end

function ItemManager.check_is_equipment(item)
   return ItemManager.check_item_type(item, "equipment")
end

function ItemManager.check_is_quest_item(item)
   return ItemManager.check_item_type(item, "quest")
end

function ItemManager.check_is_crafting(item)
   return ItemManager.check_item_type(item, "crafting")
end

---@param item game.object Item to check
---@param ignore_distance boolean If we want to ignore the distance check
function ItemManager.check_want_item(item, ignore_distance)
   local item_info = item:get_item_info()
   if not item_info then return false end

   local settings = Settings.get()
   local id = item_info:get_sno_id()
   local rarity = item_info:get_rarity()
   local affixes = item_info:get_affixes()

   -- Early return checks
   if not ignore_distance and Utils.distance_to(item) >= settings.distance then return false end
   if settings.skip_dropped and #affixes > 0 then return false end
   if loot_manager.is_gold(item) or loot_manager.is_potion(item) then return false end

   -- Check if the item is a special item
   local is_special_item =
       (settings.quest_items and ItemManager.check_is_quest_item(item)) or
       (settings.boss_items and CustomItems.boss_items[id]) or
       (settings.crafting_items and ItemManager.check_is_crafting(item)) or
       (settings.rare_elixirs and CustomItems.rare_elixirs[id]) or
       (settings.advanced_elixirs and CustomItems.advanced_elixirs[id]) or
       (settings.cinders and ItemManager.check_is_cinders(item)) or
       (settings.event_items and CustomItems.event_items[id]) or
       (settings.sigils and ItemManager.check_is_sigil(item))

   local is_event_item = settings.event_items and CustomItems.event_items[id]
   local is_cinders = settings.cinders and ItemManager.check_is_cinders(item)

   local is_crafting_item = settings.crafting_items and ItemManager.check_is_crafting(item)

   if is_event_item then
      if Utils.is_inventory_full() then
         return false 
      elseif Utils.is_consumable_inventory_full() then
         return true 
      end
   end

   -- If the item is crafting material or cinders, skip inventory and consumable checks
   if is_crafting_item or is_cinders then
      return true
   end

   if is_special_item then
      if is_cinders and crafting then
         return true
      end

      if (is_event_item and Utils.is_inventory_full()) or 
         (not is_event_item and Utils.is_consumable_inventory_full()) then
         return false
      end
      return true -- If it's a special item and inventory isn't full, we want it
   end

   local inventory_full = is_special_item and Utils.is_consumable_inventory_full() or Utils.is_inventory_full()
   if inventory_full then return false end

   -- If it's a special item, we want it
   if is_special_item then return true end

   -- Check rarity
   if rarity < settings.rarity then return false end

   -- Check greater affixes for high rarity items
   if rarity >= 5 then
      local greater_affix_count = Utils.get_greater_affix_count(item_info:get_display_name())
      local required_ga_count
      local foundOn = ''


      -- Check each item type explicitly and set the required GA count accordingly
      --jewerly
      if ItemLogic.is_legendary_amulet(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_amulet_ga_count
         foundOn = 'amulet'
      elseif ItemLogic.is_legendary_ring(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_ring_ga_count
         foundOn = 'ring'
      elseif ItemLogic.is_unique_amulet(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_amulet_ga_count
         foundOn = 'uniqueAmulet'
      elseif ItemLogic.is_unique_ring(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_ring_ga_count
         foundOn = 'uniqueRing'

      --Armors
      elseif ItemLogic.is_legendary_helm(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_helm_ga_count
         foundOn = 'helm'
      elseif ItemLogic.is_unique_helm(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_helm_ga_count
         foundOn = 'uniqueHelm'
      elseif ItemLogic.is_legendary_chest(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_chest_ga_count
         foundOn = 'chest'
      elseif ItemLogic.is_unique_chest(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_chest_ga_count
         foundOn = 'uniqueChest'
      elseif ItemLogic.is_legendary_gloves(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_gloves_ga_count
         foundOn = 'gloves'
      elseif ItemLogic.is_unique_gloves(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_gloves_ga_count
         foundOn = 'uniqueGloves'
      elseif ItemLogic.is_legendary_pants(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_pants_ga_count
         foundOn = 'pants'
      elseif ItemLogic.is_unique_pants(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_pants_ga_count
         foundOn = 'uniquePants'
      elseif ItemLogic.is_legendary_boots(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_boots_ga_count
         foundOn = 'boots'
      elseif ItemLogic.is_unique_boots(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_boots_ga_count
         foundOn = 'uniqueBoots'
      
      --offhand
      elseif ItemLogic.is_legendary_focus(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_focus_ga_count
         foundOn = 'focus'
      elseif ItemLogic.is_legendary_totem(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_totem_ga_count
         foundOn = 'totem'

      --Wepeons
      elseif ItemLogic.is_legendary_1h_mace(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_1h_mace_ga_count
         foundOn = '1hMace'
      elseif ItemLogic.is_legendary_1h_axe(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_1h_axe_ga_count
         foundOn = '1hAxe'
      elseif ItemLogic.is_legendary_1h_sword(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_1h_sword_ga_count
         foundOn = '1hSword'
      elseif ItemLogic.is_legendary_dagger(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_dagger_ga_count
         foundOn = 'dagger'
      elseif ItemLogic.is_legendary_wand(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_wand_ga_count
         foundOn = 'wand'
      elseif ItemLogic.is_unique_1h_mace(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_1h_mace_ga_count
         foundOn = 'unique1hMace'
      elseif ItemLogic.is_unique_1h_axe(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_1h_axe_ga_count
         foundOn = 'unique1hAxe'
      elseif ItemLogic.is_unique_1h_sword(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_1h_sword_ga_count
         foundOn = 'unique1hSword'
      elseif ItemLogic.is_unique_dagger(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_dagger_ga_count
         foundOn = 'uniqueDagger'
      elseif ItemLogic.is_unique_wand(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_wand_ga_count
         foundOn = 'uniqueWand'

         --2h
      elseif ItemLogic.is_legendary_2h_axe(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_2h_axe_ga_count
         foundOn = '2hAxe'
      elseif ItemLogic.is_legendary_2h_mace(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_2h_mace_ga_count
         foundOn = '2hMace'
      elseif ItemLogic.is_legendary_2h_sword(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_2h_sword_ga_count
         foundOn = '2hSword'
      elseif ItemLogic.is_legendary_2h_polearm(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_2h_polearm_ga_count
         foundOn = '2hPolearm'
      elseif ItemLogic.is_legendary_staff(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_staff_ga_count
         foundOn = 'staff'
      elseif ItemLogic.is_legendary_bow(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_bow_ga_count
         foundOn = 'bow'
      elseif ItemLogic.is_legendary_crossbow(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.legendary_crossbow_ga_count
         foundOn = 'crossbow'
      elseif ItemLogic.is_unique_2h_axe(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_2h_axe_ga_count
         foundOn = '2hAxe'
      elseif ItemLogic.is_unique_2h_mace(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_2h_mace_ga_count
         foundOn = '2hMace'
      elseif ItemLogic.is_unique_2h_sword(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_2h_sword_ga_count
         foundOn = '2hSword'
      elseif ItemLogic.is_unique_2h_polearm(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_2h_polearm_ga_count
         foundOn = '2hPolearm'
      elseif ItemLogic.is_unique_staff(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_staff_ga_count
         foundOn = 'staff'
      elseif ItemLogic.is_unique_bow(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_bow_ga_count
         foundOn = 'bow'
      elseif ItemLogic.is_unique_crossbow(item) and Settings.get().custom_toggle == true then
         required_ga_count = settings.unique_crossbow_ga_count
         foundOn = 'crossbow'
      else
         -- Fallback to general settings for rarity == 5 or unique/uber items
         if (rarity == 5 and  Settings.get().custom_toggle == false) then
            required_ga_count = settings.ga_count
         elseif (rarity == 6 and Settings.get().custom_toggle == false) then --and Settings.get().custom_toggle == false
            required_ga_count = settings.unique_ga_count
         elseif(rarity == 8) then
            required_ga_count = CustomItems.ubers[id] and settings.uber_unique_ga_count or settings.unique_ga_count
         else required_ga_count = 4
         end
      end
      if greater_affix_count < required_ga_count then
         return false
      end
   end
   return true
end

function ItemManager.get_nearby_item()
   local items = actors_manager:get_all_items()
   local fetched_items = {}

   for _, item in pairs(items) do
      if ItemManager.check_want_item(item, false) then
         table.insert(fetched_items, item)
      end
   end

   table.sort(fetched_items, function(x, y)
      return Utils.distance_to(x) < Utils.distance_to(y)
   end)

   return fetched_items[1]
end

function ItemManager.calculate_item_score(item)
   local score = 0
   local item_info = item:get_item_info()
   local item_id = item_info:get_sno_id()
   local display_name = item_info:get_display_name()
   local item_rarity = item_info:get_rarity()

   if CustomItems.ubers[item_id] then
      score = score + 1000
   elseif item_rarity >= 5 then
      score = score + 500
   elseif item_rarity >= 3 then
      score = score + 300
   elseif item_rarity >= 1 then
      score = score + 100
   else
      score = score + 10
   end

   local greater_affix_count = Utils.get_greater_affix_count(display_name)

   if greater_affix_count == 3 then
      score = score + 100
   elseif greater_affix_count == 2 then
      score = score + 75
   elseif greater_affix_count == 1 then
      score = score + 50
   end

   return score
end

function ItemManager.get_best_item()
   local items = actors_manager:get_all_items()
   local scored_items = {}

   for _, item in ipairs(items) do
      if ItemManager.check_want_item(item, false) then
         local item_object = { Item = item, Score = ItemManager.calculate_item_score(item) }
         table.insert(scored_items, item_object)
      end
   end

   table.sort(scored_items, function(x, y)
      return x.Score > y.Score
   end)

   return scored_items[1]
end

function ItemManager.get_item_based_on_priority()
   local settings = Settings.get()
   if settings.loot_priority == 0 then
      return ItemManager.get_nearby_item()
   else
      return ItemManager.get_best_item()
   end
end

return ItemManager