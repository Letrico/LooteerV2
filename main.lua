local Settings = require("src.settings")
local ItemManager = require("src.item_manager")
local Renderer = require("src.renderer")
local GUI = require("gui")
local Utils = require("utils.utils")
local explorerlite = require "core.explorerlite"

-- Track the last walk-over loot target so we can stop pathing if it vanishes (e.g., pet pickup)
local last_walkover_target_id = nil
local FAILED_ATTEMPT_WINDOW = 2.5
local FAILED_ATTEMPT_LIMIT = 4
local failed_loot_attempts = {}

local function clear_failed_attempt(id)
   if id then
      failed_loot_attempts[id] = nil
   end
end

local function register_failed_attempt(id)
   if not id then
      return false
   end
   local now = get_time_since_inject()
   local entry = failed_loot_attempts[id]
   if entry and now - entry.last_time <= FAILED_ATTEMPT_WINDOW then
      entry.count = entry.count + 1
      entry.last_time = now
      if entry.count >= FAILED_ATTEMPT_LIMIT then
         ItemManager.blacklist_item(id, 8.0)
         failed_loot_attempts[id] = nil
         return true
      end
   else
      failed_loot_attempts[id] = { count = 1, last_time = now }
   end
   return false
end

local function prune_failed_attempts()
   if not next(failed_loot_attempts) then
      return
   end
   local active_ids = {}
   local items = actors_manager:get_all_items()
   for _, it in pairs(items) do
      active_ids[it:get_id()] = true
   end
   for id in pairs(failed_loot_attempts) do
      if not active_ids[id] then
         failed_loot_attempts[id] = nil
      end
   end
end

-- Determine if an item should be looted by walking over it (no click)
local function is_walkover_loot(obj)
   if not obj then return false end

   -- Quick reject: if it's clearly equipment-like we don't walk-over
   if ItemManager.check_is_equipment(obj) or ItemManager.check_is_item_cache(obj) then return false end

   -- Retrieve basic info (protected)
   local ok_info, item_info = pcall(function() return obj:get_item_info() end)
   local id = nil
   if ok_info and item_info then
      local ok_id, sno = pcall(function() return item_info:get_sno_id() end)
      if ok_id then id = sno end
   end

   -- Name heuristic (for aether-like objects)
   local ok_name, name_raw = pcall(function() return obj:get_skin_name() end)
   local lname = (ok_name and name_raw and name_raw:lower()) or ""

   local ok_interact, interactable = pcall(function() return obj:is_interactable() end)

   -- Explicit currency/material categories that should always be walk-over
   local walkover_flag = false
   if ItemManager.check_is_cinders(obj) or 
      ItemManager.check_is_infernal_warp(obj) or 
      ItemManager.check_is_crafting(obj) then
      walkover_flag = true
   end

   local is_rune = ItemManager.check_is_rune(obj)
   local is_prism = ItemManager.check_is_prism(obj)

   if is_rune or is_prism then
      if ok_interact and interactable ~= false then
         walkover_flag = false
      else
         walkover_flag = true
      end
   end

   -- Obducite (custom rare resource)
   if not walkover_flag and id and require("data.custom_items").obducite[id] then
      walkover_flag = true
   end

   -- Aether heuristic
   if not walkover_flag and lname:find("aether") then
      walkover_flag = true
   end

   -- Exclusions: objects we should still click
   if walkover_flag then
      if ItemManager.check_is_sigil(obj) or
         ItemManager.check_is_compass(obj) or
         ItemManager.check_is_tribute(obj) or
         ItemManager.check_is_scroll(obj) or
         ItemManager.check_is_recipe(obj) or
         ItemManager.check_is_quest_item(obj) then
         walkover_flag = false
      end
   end

   -- Fallback: if engine reports non-interactable AND not in exclusion buckets, treat as walk-over
   if not walkover_flag then
      if ok_interact and interactable == false then
         -- Avoid false positives for sigils / special tokens
         if not (ItemManager.check_is_sigil(obj) or ItemManager.check_is_compass(obj) or ItemManager.check_is_tribute(obj)) then
            walkover_flag = true
         end
      end
   end

   return walkover_flag
end

-- Check if an object with a specific id still exists among world items
local function item_exists_by_id(id)
   if not id then return false end
   local items = actors_manager:get_all_items()
   for _, it in pairs(items) do
      if it:get_id() == id then
         return true
      end
   end
   return false
end

local function handle_loot(wanted_item)
   if not wanted_item then return end

   -- If we were previously moving to a walk-over item and it's now gone (e.g., pet picked it up), clear target
   if last_walkover_target_id and not item_exists_by_id(last_walkover_target_id) then
      explorerlite:clear_path_and_target()
      clear_failed_attempt(last_walkover_target_id)
      last_walkover_target_id = nil
   end

   local walkover = is_walkover_loot(wanted_item)
   local distance = Utils.distance_to(wanted_item)
   local item_position = wanted_item:get_position()

   -- Use a smaller stop distance for walk-over currencies; larger for interactables
   local stop_dist = walkover and 0.9 or 2.0

   if distance > stop_dist then
      explorerlite:set_custom_target(item_position)
      explorerlite:move_to_target()
      -- Remember walk-over target id so we can cancel if it disappears
      if walkover then
         last_walkover_target_id = wanted_item:get_id()
      else
         last_walkover_target_id = nil
         clear_failed_attempt(wanted_item:get_id())
      end
      return
   end

   -- We're within range
   if walkover then
      -- Do not click; continue walking directly over the item until it disappears (pickup or pet pickup)
      explorerlite:set_custom_target(item_position)
      explorerlite:move_to_target()
      last_walkover_target_id = wanted_item:get_id()
      return
   end

   -- Default behavior for normal items: interact to pick up
   interact_object(wanted_item)
   local item_id = wanted_item:get_id()
   if register_failed_attempt(item_id) then
      explorerlite:clear_path_and_target()
      last_walkover_target_id = nil
      return
   end
end

local function main_pulse()
   if not get_local_player() then return end

   prune_failed_attempts()

   Settings.update()

   if not Settings.get().enabled then return end

   if not Settings.should_execute() then return end

   orbwalker.set_auto_loot_toggle(false)

   -- If we were pursuing a walk-over target and it disappeared (e.g., pet pickup), stop pathing
   if last_walkover_target_id and not item_exists_by_id(last_walkover_target_id) then
      explorerlite:clear_path_and_target()
      last_walkover_target_id = nil
   end

   local loot_priority = GUI.elements.general.loot_priority_combo:get()

   if loot_priority == 0 then
      local wanted_item = ItemManager.get_nearby_item()
      if wanted_item then
         Settings.get().looting = true
         handle_loot(wanted_item)
      else
         Settings.get().looting = false
         -- Extra safety: clear any lingering walk-over target
         if last_walkover_target_id then
            explorerlite:clear_path_and_target()
            last_walkover_target_id = nil
         end
      end
   elseif loot_priority == 1 then
      local best_item_data = ItemManager.get_best_item()
      if best_item_data then
         Settings.get().looting = true
         handle_loot(best_item_data.Item)
      else
         Settings.get().looting = false
         -- Extra safety: clear any lingering walk-over target
         if last_walkover_target_id then
            explorerlite:clear_path_and_target()
            last_walkover_target_id = nil
         end
      end
   end
end

-- Set Global access for other plugins
LooteerPlugin = {
   getSettings = function (setting)
      if Settings.get()[setting] then
          return Settings.get()[setting]
      else
          return nil
      end
  end,
  setSettings = function (setting, value)
      if Settings.get()[setting] then
          Settings.get()[setting] = value
          return true
      else
          return false
      end
  end,
}

on_update(main_pulse)
on_render_menu(GUI.render)
on_render(Renderer.draw_stuff)