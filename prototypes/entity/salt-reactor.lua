data:extend {{
    type = "item",
    name = "maraxsis-electricity",
    icon = "__maraxsis__/graphics/icons/electricity.png",
    icon_size = 64,
    hidden = true,
    stack_size = 100,
    spoil_to_trigger_result = nil, -- defined in whats-a-spoilage.lua
    flags = {"only-in-cursor", "ignore-spoil-time-modifier"},
    spoil_ticks = nil,             -- defined in whats-a-spoilage.lua
}}

data:extend {{
    type = "simple-entity-with-owner",
    name = "maraxsis-electricity",
    flags = {"not-on-map", "placeable-off-grid"},
    collision_mask = {layers = {}},
    hidden = true,
    icon = "__maraxsis__/graphics/icons/electricity.png",
    icon_size = 64,
    localised_name = {"item-name.maraxsis-electricity"},
    factoriopedia_alternative = "maraxsis-salt-reactor",
}}

local working_visualisations = {
    {
        always_draw = true,
        animation = {
            filename = "__maraxsis__/graphics/entity/salt-reactor/salt-reactor.png",
            priority = "high",
            width = 3200 / 8,
            height = 3200 / 8,
            shift = util.by_pixel(0, -16),
            frame_count = 60,
            line_length = 8,
            animation_speed = 1,
            scale = 0.5,
        },
    },
    {
        always_draw = true,
        animation = {
            filename = "__maraxsis__/graphics/entity/salt-reactor/salt-reactor-sh.png",
            priority = "high",
            width = 800,
            height = 600,
            scale = 0.5,
            frame_count = 1,
            shift = {0, -0.2},
            draw_as_shadow = true,
        },
    },
    {
        fadeout = true,
        animation = {
            filename = "__maraxsis__/graphics/entity/salt-reactor/salt-reactor-emission.png",
            priority = "high",
            width = 3200 / 8,
            height = 3200 / 8,
            shift = util.by_pixel(0, -16),
            frame_count = 60,
            line_length = 8,
            animation_speed = 1,
            scale = 0.5,
            draw_as_glow = true,
            blend_mode = "additive",
        },
    },
}

data:extend {{
    type = "furnace",
    name = "maraxsis-salt-reactor",
    icon = "__maraxsis__/graphics/icons/salt-reactor.png",
    maraxsis_buildability_rules = {water = true, dome = true, coral = true, trench = true, trench_entrance = false, trench_lava = false},
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "maraxsis-salt-reactor"},
    max_health = 1000,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    working_sound = {
        sound = {
            filename = "__maraxsis__/sounds/salt-reactor.ogg",
            volume = 1,
        },
        apparent_volume = 1.5,
        max_sounds_per_type = 3,
        audible_distance_modifier = 1,
        fade_in_ticks = 4,
        fade_out_ticks = 20
    },
    resistances = {
        {
            type = "fire",
            percent = 80
        }
    },
    collision_box = {{-2.9, -2.9}, {2.9, 2.9}},
    selection_box = {{-3, -3}, {3, 3}},
    module_slots = 6,
    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    allowed_module_categories = {"efficiency", "quality"},
    effect_receiver = {
        uses_module_effects = true,
        uses_beacon_effects = false,
        uses_surface_effects = false,
    },
    icon_draw_specification = {shift = {0, -0.5}, scale = 1.5},
    icons_positioning = {{
        inventory_index = defines.inventory.furnace_modules, shift = {0, 0.9}, max_icons_per_row = 3
    }},
    graphics_set = {
        working_visualisations = working_visualisations,
    },
    energy_source = {
        type = "burner",
        fuel_categories = {"nuclear"},
        effectivity = 1,
        fuel_inventory_size = 1,
        burnt_inventory_size = 1,
        smoke = {
            {
                name = "maraxsis-swimming-bubbles",
                frequency = 50,
                position = {2.2, -0.5},
                starting_vertical_speed = 0.03
            }
        },
        light_flicker = {
            color = defines.color.limegreen,
            minimum_intensity = 0.2,
            maximum_intensity = 0.4,
            minimum_light_size = 2.5
        }
    },
    energy_usage = "80MW",
    source_inventory_size = 1,
    result_inventory_size = 1,
    crafting_speed = 1,
    crafting_categories = {"maraxsis-salt-reactor"},
}}

data:extend {{
    type = "recipe-category",
    name = "maraxsis-salt-reactor"
}}

data:extend {{
    type = "recipe",
    name = "maraxsis-salt-reactor",
    enabled = false,
    energy_required = 10,
    ingredients = {
        {type = "item",  name = "maraxsis-glass-panes",    amount = 100},
        {type = "item",  name = "tungsten-plate",          amount = 100},
        {type = "item",  name = "processing-unit",         amount = 100},
        {type = "fluid", name = "maraxsis-brackish-water", amount = 300},
    },
    results = {
        {type = "item", name = "maraxsis-salt-reactor", amount = 1},
    },
    category = "maraxsis-hydro-plant",
    surface_conditions = maraxsis.surface_conditions(),
}}

data:extend {{
    type = "item",
    name = "maraxsis-salt-reactor",
    icon = "__maraxsis__/graphics/icons/salt-reactor.png",
    icon_size = 64,
    place_result = "maraxsis-salt-reactor",
    stack_size = 10,
}}

data:extend {{
    type = "technology",
    name = "maraxsis-salt-reactor",
    icon = "__maraxsis__/graphics/technology/salt-reactor.png",
    icon_size = 256,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "maraxsis-salt-reactor"
        },
        {
            type = "unlock-recipe",
            recipe = "maraxsis-electricity"
        }
    },
    prerequisites = {"nuclear-power", "maraxsis-hydro-plant"},
    research_trigger = {
        type = "craft-item",
        item = "salt",
        count = 100
    },
    order = "d-e",
}}

data:extend {{
    type = "recipe",
    name = "maraxsis-electricity",
    enabled = false,
    energy_required = 0.5,
    ingredients = {
        {type = "item", name = "salt", amount = 1},
    },
    results = {
        {type = "item", name = "maraxsis-electricity", amount = 1},
    },
    category = "maraxsis-salt-reactor",
    auto_recycle = false,
    allow_decomposition = false,
}}

data:extend {{
    type = "electric-energy-interface",
    name = "maraxsis-salt-reactor-energy-interface",
    icon = "__maraxsis__/graphics/icons/salt-reactor.png",
    icon_size = 64,
    localised_name = {"entity-name.maraxsis-salt-reactor"},
    localised_description = {"entity-description.maraxsis-salt-reactor"},
    gui_mode = "none",
    quality_indicator_scale = 0,
    flags = {},
    selectable_in_game = false,
    hidden = true,
    collision_mask = {layers = {}},
    factoriopedia_alternative = "maraxsis-salt-reactor",
    energy_source = {
        type = "electric",
        usage_priority = "secondary-output",
        output_flow_limit = "350MW",
        render_no_power_icon = false
    },
    collision_box = {{-2.9, -2.9}, {2.9, 2.9}},
    selection_box = {{-3, -3}, {3, 3}},
}}
