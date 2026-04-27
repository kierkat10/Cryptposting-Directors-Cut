SMODS.Joker {
	key = "sprinter",
	name = "Sprinter",
	config = { extra = { chips = 0, chips_mod = 75 } },
	rarity = "crp_plentiful",
	atlas = "crp_joker",
	pos = { x = 4, y = 0 },
	cost = 5,
	blueprint_compat = true,
	demicoloncompat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { lenient_bignum(card.ability.extra.chips), lenient_bignum(card.ability.extra.chips_mod) } }
	end,
	calculate = function(self, card, context)
		if (context.joker_main) or context.forcetrigger then
			return {
				chips = lenient_bignum(card.ability.extra.chips),
			}
		end
		if (context.before and next(context.poker_hands["Straight Flush"]) and not context.blueprint) or context.forcetrigger then
			SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                colour = G.C.CHIPS
            })
		end
	end,
	in_pool = function(self, args)
		return true, { allow_duplicates = true }
	end,
	crp_credits = {
		idea = { "Poker The Poker" },
		art = { "MarioFan597" },
		code = { "Glitchkat10" },
		custom = { key = "alt", text = "Runner" }
	}
}

SMODS.Joker {
	key = "pennant",
	name = "Pennant",
	config = { extra = { mult = 4 } },
	rarity = "crp_plentiful",
	atlas = "crp_placeholder",
	pos = { x = 2, y = 0 },
	cost = 5,
	blueprint_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { lenient_bignum(card.ability.extra.mult) } }
	end,
	calculate = function(self, card, context)
		if (context.joker_main) or context.forcetrigger then
			return {
				mult = lenient_bignum(lenient_bignum(G.GAME.current_round.hands_left) * lenient_bignum(card.ability.extra.mult))
			}
		end
	end,
	crp_credits = {
		idea = { "TheLampster" },
		code = { "wilfredlam0418" },
		custom = { key = "alt", text = "Banner" }
	}			
}

SMODS.Joker {
	key = "jok",
	name = "jok",
	config = { extra = { mult = -10 } },
	rarity = "crp_plentiful",
	atlas = "crp_joker2",
	pos = { x = 6, y = 2 },
	cost = 52,
	blueprint_compat = true,
	demicoloncompat = true,
	no_pool_flag = jok_existent,
	loc_vars = function(self, info_queue, card)
		return { vars = { lenient_bignum(card.ability.extra.mult) } }
	end,
    set_ability = function(self, card, initial)
		card.ability.cry_absolute = true
    end,
    add_to_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.jok_existent = true
    end,
	calculate = function(self, card, context)
		if (context.joker_main) or context.forcetrigger then
			return {
				mult = lenient_bignum(card.ability.extra.mult)
			}
		end
	end,
	crp_credits = {
		idea = { "SageSeraph", "Glitchkat10" },
		art = { "Unknown" },
		code = { "Rainstar" },
		custom = { key = "alt", text = "Cube" }
	}			
}

SMODS.Joker {
	key = "big_jok",
	name = "BIG JOK",
	config = { extra = { xmult = 100 } },
	rarity = "crp_plentiful",
	atlas = "crp_joker2",
	pos = { x = 7, y = 2 },
	cost = 52,
	blueprint_compat = true,
	demicoloncompat = true,
	yes_pool_flag = jok_existent,
	loc_vars = function(self, info_queue, card)
		return { vars = { lenient_bignum(card.ability.extra.xmult) } }
	end,
	calculate = function(self, card, context)
		if (context.joker_main) or context.forcetrigger then
			return {
				xmult = lenient_bignum(card.ability.extra.xmult)
			}
		end
	end,
	crp_credits = {
		idea = { "SageSeraph", "Glitchkat10" },
		art = { "Unknown" },
		code = { "Rainstar" },
		custom = { key = "alt", text = "Big Cube" }
	}			
}
