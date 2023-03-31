require("utils/micromath")

local initialized = false

local function is_valid(entity)
	return (entity ~= nil and entity.valid)
end

local function initGlob()
    global = global or {}
    global.rgbLamps = global.rgbLamps or {}
end

local function performInit()
    if not initialized then
        initGlob()
        initialized = true
    end
end

local function update_lamps_colors(event)
    for _, lamp in ipairs(global.rgbLamps) do
        local signals = lamp.get_merged_signals()
        if signals == nil then return end
        local red = clamp(0, 255, signals[{type="virtual", name="signal-red"}])
        local green = clamp(0, 255, signals[{type="virtual", name="signal-green"}])
        local blue = clamp(0, 255, signals[{type="virtual", name="signal-blue"}])
        
        lamp.light.color = {r=red, g=green, b=blue}
        lamp.light_when_colored.color = lamp.light.color
    end
end

function on_tick(event)
    if global.rgbLamps == nil then
        initGlob()
        return
    end
    if #global.rgbLamps == 0 then return end
    update_lamps_colors(event)
end

local function remove_invalid_lamps()
    for i=#global.rgbLamps,1,-1 do
        if not is_valid(global.rgbLamps[i].entity) then
            table.remove(global.rgbLamps, i)
        end
    end
end

function on_built_entity(event)
    performInit()
	if is_valid(event.created_entity) and event.created_entity.name == "small-lamp-rgb" then
		table.insert(global.rgbLamps, event.created_entity)
	end
end

function on_remove_entity(event)
    performInit()
    remove_invalid_lamps()
end

script.on_event(defines.events.on_tick, on_tick)

script.on_event(defines.events.on_built_entity, on_built_entity)
script.on_event(defines.events.on_robot_built_entity, on_built_entity)

script.on_event(defines.events.on_entity_died, on_remove_entity)
script.on_event(defines.events.on_player_mined_item, on_remove_entity)
script.on_event(defines.events.on_robot_mined, on_remove_entity)