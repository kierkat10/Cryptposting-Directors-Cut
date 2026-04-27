

SMODS.Joker { -- IT'S ALIVE
	key = "all",
	name = "All",
	rarity = "crp_all",
	atlas = "crp_joker",
	pos = { x = 4, y = 7 },
	soul_pos = { x = 6, y = 7, extra = { x = 5, y = 7 } },
	cost = 9827982798279827,
	blueprint_compat = false,
	demicoloncompat = true,
	perishable_compat = false,
	config = {
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
			}
		}
	end,
	calculate = function(self, card, context)
		if context.selling_self then
			for i = 1, #G.P_CENTER_POOLS.Joker do
				SMODS.add_card({ set = 'Joker', key = G.P_CENTER_POOLS["Joker"][i].key, discovered = false })
			end
			for i = 1, #G.P_CENTER_POOLS.Consumeables do
				SMODS.add_card({ set = 'Consumeable', key = G.P_CENTER_POOLS["Consumeable"][i].key, discovered = false })
			end
		end
	end,
	in_pool = function(self, args)
		return true, { allow_duplicates = true }
	end,
	crp_credits = {
		idea = { "lord.ruby" },
		art = { "thingifithinker" },
		code = { "Rainstar" },
		custom = { key = "music", text = "ottermatter" }
	}
}