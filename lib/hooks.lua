-- make the box debuff plentiful jokers too
local og_box_debuff = SMODS.Blinds.bl_cry_box.recalc_debuff
SMODS.Blinds.bl_cry_box.recalc_debuff = function(self, card, from_blind)
    if og_box_debuff and og_box_debuff(self, card, from_blind) then
        return true
    end
    return card.config.center.rarity == "crp_plentiful"
end

-- make the windmill debuff unplentiful jokers too
local og_windmill_debuff = SMODS.Blinds.bl_cry_windmill.recalc_debuff
SMODS.Blinds.bl_cry_windmill.recalc_debuff = function(self, card, from_blind)
    if og_windmill_debuff and og_windmill_debuff(self, card, from_blind) then
        return true
    end
    return card.config.center.rarity == "crp_unplentiful"
end

-- make the pin debuff cipe+ jokers too
local og_pin_debuff = SMODS.Blinds.bl_cry_pin.recalc_debuff
SMODS.Blinds.bl_cry_pin.recalc_debuff = function(self, card, from_blind)
    if og_pin_debuff and og_pin_debuff(self, card, from_blind) then
        return true
    end
    return
        card.config.center.rarity == "crp_cipe" or
        card.config.center.rarity == "crp_incredible" or
        card.config.center.rarity == "crp_extraordinary" or
        card.config.center.rarity == "crp_awesome" or
        card.config.center.rarity == "crp_divine" or
        card.config.center.rarity == "crp_outlandish" or
        card.config.center.rarity == "crp_mythic" or
        card.config.center.rarity == "crp_exomythic" or
        card.config.center.rarity == "crp_2exomythic4me" or
        card.config.center.rarity == "crp_22exomythic4mecipe" or
        card.config.center.rarity == "crp_exomythicepicawesomeuncommon2mexotic22exomythic4mecipe" or
        card.config.center.rarity == "crp_supa_rare" or
        card.config.center.rarity == "crp_all"
end

-- initialize hidden soul rate variable (will be set by config)
G.crp_hidden_soul_rate = G.crp_hidden_soul_rate or 0.003

-- hook to override soul replacement for guaranteed hidden consumables
local function create_card_override()
    -- hook into the soul replacement system
    local og_create_card = create_card
    function create_card(forced_type, area, legendary, key, forced_rarity, materialize, skip_materialize, soulable, hidden, offset_y, forced_key, silent, from_buffer)
        if G.crp_hidden_soul_rate >= 1 and soulable and not forced_key and not hidden then
            -- force a hidden consumable when soul_rate is >= 1
            local hidden_consumables = {}
            for _, consumable in ipairs(SMODS.Consumable.legendaries or {}) do
                if consumable and (forced_type == consumable.type.key or forced_type == consumable.soul_set) and not (G.GAME.used_jokers[consumable.key] and not SMODS.showman(consumable.key) and not consumable.can_repeat_soul) and SMODS.add_to_pool(consumable) then
                    table.insert(hidden_consumables, consumable)
                end
            end
            
            if #hidden_consumables > 0 then
                local chosen = hidden_consumables[math.random(#hidden_consumables)]
                return og_create_card(forced_type, area, legendary, chosen.key, forced_rarity, materialize, skip_materialize, soulable, true, offset_y, chosen.key, silent, from_buffer)
            end
        end
        
        return og_create_card(forced_type, area, legendary, key, forced_rarity, materialize, skip_materialize, soulable, hidden, offset_y, forced_key, silent, from_buffer)
    end
end

create_card_override()