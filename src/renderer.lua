local Settings = require("src.settings")
local ItemManager = require("src.item_manager")
local Utils = require("utils.utils")

local Renderer = {}

function Renderer.draw_stuff()
    local player = get_local_player()
    if not player then return end
    local settings = Settings.get()
    if not settings.enabled then return end

    local base_pos = get_player_position()
    if Utils.is_inventory_full() then
        graphics.text_3d("Inventory Full", base_pos, 20, color_red(255))
    end
    if Utils.is_consumable_inventory_full() then
        graphics.text_3d("Consumable Inventory Full", vec3:new(base_pos:x(), base_pos:y(), base_pos:z() + 1), 20, color_red(255))
    end
    if Utils.is_socketable_inventory_full() then
        graphics.text_3d("Socketable Inventory Full", vec3:new(base_pos:x(), base_pos:y(), base_pos:z() + 2), 20, color_red(255))
    end
    if Utils.is_sigil_inventory_full() then
        graphics.text_3d("Sigil Inventory Full", vec3:new(base_pos:x(), base_pos:y(), base_pos:z() + 3), 20, color_red(255))
    end

    if not settings.draw_wanted_items then return end

    local items = actors_manager:get_all_items()
    for _, item in pairs(items) do
        if ItemManager.check_want_item(item, true) then
            graphics.circle_3d(item:get_position(), 0.5, color_pink(255), 3)
        end
    end
end

return Renderer
