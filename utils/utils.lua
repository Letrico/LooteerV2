local Utils = {}

function Utils.distance_to(object)
   return get_player_position():dist_to_ignore_z(object:get_position())
end

function Utils.get_greater_affix_count(display_name)
   local count = 0
   for _ in display_name:gmatch("GreaterAffix") do
      count = count + 1
   end
   return count
end

function Utils.is_lowest_stack_below(inventory, item_id, max_stack, looted_stack)
   if not inventory then return true end  -- Return true if no inventory (safer to try pickup)

   local lowest_stack = max_stack  -- Initialize with max_stack

   for _, item in pairs(inventory) do
       if item:get_sno_id() == item_id then
           local stack_count = item:get_stack_count()
           if stack_count < lowest_stack then
               lowest_stack = stack_count
           end
       end
   end

   -- Return true only if lowest stack + looted stack is less than equals max_stack
   return (lowest_stack + looted_stack) <= max_stack
end

function Utils.is_inventory_full()
   return get_local_player():get_item_count() == 33
end

function Utils.is_consumable_inventory_full()
   return get_local_player():get_consumable_count() == 33
end

function Utils.is_sigil_inventory_full()
   return #get_local_player():get_dungeon_key_items() == 33
end

local SOCKETABLE_CAPACITY = 96 -- conservative cap to accommodate expanded socketable storage

function Utils.is_socketable_inventory_full()
   local local_player = get_local_player()
   if not local_player then
      return false
   end
   local socketables = local_player:get_socketable_items()
   return #socketables >= SOCKETABLE_CAPACITY
end

function Utils.player_in_zone(zname)
    return get_current_world():get_current_zone_name() == zname
end

return Utils
