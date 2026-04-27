local mod = SMODS.current_mod
local config = SMODS.config

function update_hidden_weight_multiplier()
    if config.increase_hidden_weight then
        -- 3% chance instead of 0.3% = 10x multiplier
        G.crp_hidden_soul_rate = 0.03
    else
        -- base game rate: 0.3%
        G.crp_hidden_soul_rate = 0.003
    end
    
    -- Update soul_rate for all hidden consumables
    for _, consumable in ipairs(SMODS.Consumable.legendaries or {}) do
        if consumable then
            consumable.soul_rate = G.crp_hidden_soul_rate
        end
    end
end

-- extra tabs for mod menu
local crpTabs = function()
    return {
        {
            label = "Music",
            tab_definition_function = function()
                return {
                    n = G.UIT.ROOT,
                    config = {
                        r = 0.1,
                        minw = 7,
                        minh = 5,
                        align = "cm",
                        padding = 0.05,
                        colour = G.C.BLACK
                    },
                    nodes = {{
                        -- COLUMN NODE TO ALIGN EVERYTHING INSIDE VERTICALLY
                        n = G.UIT.C,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.BLACK
                        },
                        nodes = {
                            create_toggle({
                                label = "Enable Mythic Music",
                                ref_table = config,
                                ref_value = "music_mythic",
                                callback = function(ref_table, ref_value, old_val, new_val)
                                    if G.MUSIC then
                                        G.MUSIC:force_update()
                                    end
                                end,
                                info = { "Enable or disable music for Mythic Jokers." }
                            }),
                            create_toggle({
                                label = "Enable Exomythic Music",
                                ref_table = config,
                                ref_value = "music_exomythic",
                                callback = function(ref_table, ref_value, old_val, new_val)
                                    if G.MUSIC then
                                        G.MUSIC:force_update()
                                    end
                                end,
                                info = { "Enable or disable music for Exomythic Jokers." }
                            }),
                            create_toggle({
                                label = "Enable 22Exomythic4Mecipe Music",
                                ref_table = config,
                                ref_value = "music_22exomythic4mecipe",
                                callback = function(ref_table, ref_value, old_val, new_val)
                                    if G.MUSIC then
                                        G.MUSIC:force_update()
                                    end
                                end,
                                info = { "Enable or disable music for 22Exomythic4Mecipe Jokers. " }
                            }),
                            create_toggle({
                                label = "Enable All Joker Music",
                                ref_table = config,
                                ref_value = "music_all",
                                callback = function(ref_table, ref_value, old_val, new_val)
                                    -- trigger music system re-evaluation
                                    if G.MUSIC then
                                        G.MUSIC:force_update()
                                    end
                                end,
                                info = { "Enable or disable music for the \"All\" Joker." }
                            })
                        }
                    }}
                }
            end
        }
    }
end

-- define the main config tab for smods
SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {
            r = 0.1,
            minw = 7,
            minh = 5,
            align = "cm",
            padding = 0.05,
            colour = G.C.BLACK
        },
        nodes = {{
            -- COLUMN NODE TO ALIGN EVERYTHING INSIDE VERTICALLY
            n = G.UIT.C,
            config = {
                align = "cm",
                padding = 0.1,
                colour = G.C.BLACK
            },
            nodes = {
                create_toggle({
                    label = "Enable HTTP Requests",
                    ref_table = config,
                    ref_value = "HTTPS",
                    callback = function(ref_table, ref_value, old_val, new_val)
                        -- HTTP requests will be checked on next update attempt
                    end,
                    info = {
                        "If enabled, allows the mod to make HTTP requests to fetch Discord member count.",
                        "Disabling this will use the fallback member count."
                    }
                }),
                create_toggle({
                    label = "Increase Hidden Consumable Weight",
                    ref_table = config,
                    ref_value = "increase_hidden_weight",
                    callback = function(ref_table, ref_value, old_val, new_val)
                        -- update the soul rate when toggled
                        update_hidden_weight_multiplier()
                    end,
                    info = {
                        "If enabled, hidden consumables have a 3% chance instead of 0.3% in packs.",
                        "(Requires a game restart to take effect)"
                    }
                })
            }
        }}
    }
end

-- set the extra tabs
SMODS.current_mod.extra_tabs = crpTabs

-- delay soul rate update until after all mods are loaded
local function delayed_soul_rate_update()
    print("CRP DEBUG: Running delayed soul rate update...")
    update_hidden_weight_multiplier()
end

-- Schedule the update for after all mods are loaded (only run once)
local has_run = false
G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.1,
    func = function()
        if not has_run then
            delayed_soul_rate_update()
            has_run = true
        end
    end
}))
