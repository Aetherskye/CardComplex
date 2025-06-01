-------------------------------------INFO: AETHER
ae = {
    cards_destroyed = 0
} -- Table of functions for Aether but might be used Elsewhere
function ae.destroyTarget(target, aethLoc)
	local destroyed = aethLoc + target
	print(G.jokers.cards[destroyed].config.center_key)
	if G.jokers.cards[destroyed].config.center_key == 'j_ocj_skye' then
		G.jokers.cards[destroyed]:start_dissolve()
		G.jokers.cards[aethLoc]:start_dissolve()
		local toothspawn = SMODS.create_card({key = 'j_ocj_2ether'})
		G.jokers:emplace(toothspawn)
		print("2ethered!")
	else
	G.jokers.cards[destroyed]:start_dissolve()
    ae.cards_destroyed = ae.cards_destroyed + 1
	end
end

function abilityMove(num)
	local finalnum = ae.aethSearch(num)
	local c = num
    if finalnum == nil then return
    elseif finalnum == 1 or finalnum == -1 then
		if finalnum == 1 then
			ae.destroyTarget(finalnum,num)
		elseif finalnum == -1 then
			ae.destroyTarget(finalnum,num)
		end
		
	elseif finalnum > 0 then
			glf.moveJokerDown(c, 'up')
							
	elseif finalnum < 0 then
			glf.moveJokerDown(c, 'down')
				
	end
end

function ae.aethSearch(aethLoc)
    local validtargs = 0
    local distance = {}
    for k,v in ipairs(G.jokers.cards) do
        if glf.findstring(v.label, aetherHunts) then
            local dist1 = v.rank - aethLoc
            distance[dist1] = dist1
        end
    end
    local absoluteval = {}
	for c,m in pairs(distance) do
		absoluteval[c] = math.abs(m)
	end
    local min = returnMin(absoluteval)
    local inverseTable = invert_table(absoluteval) -- make the abso value the key and therefore accessible
	return distance[min]
end

SMODS.Atlas {
    key = 'aether_atlas',
    path = 'aetheratlas.png',
    px = 71,
    py = 95
}

--- actually him lol
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'aethercard',
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Aether',
		text = {
			"{B:2,V:1,s:1.2,E:2}~THE HUNTER~",
			"{C:mult}^#1# {} mult.",
			"Mult based off of the last sold card. (Highest number)",
			"Subracted by {C:mult}#2# {} every round."
		}
	},
	config = { 
		extra = { 
			lastCardCost = 1,
			debuff = 1,
			selfLocation = 0,
			abilitytrig = 0,
            cards_calced = 0,
		} 
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { 
			card.ability.extra.lastCardCost,
			card.ability.extra.debuff,
			colours = {dj_colours.aether.textcol,
            dj_colours.aether.bgcol}
		 } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary. < Document this too smh
	rarity = 'ocj_concept',
	-- Which atlas key to pull from.
	atlas = 'aether_atlas',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
    soul_pos = {x=4,y=1},
	-- Cost of card in shop.
	cost = 50,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)
		if not context.ending_shop and context.cardarea == G.jokers  then
			card.ability.extra.abilityTrig = 0
            if ae.cards_destroyed > card.ability.extra.cards_calced then

                card.ability.extra.debuff = 1 -  (ae.cards_destroyed /(1+ae.cards_destroyed))
                card.ability.extra.cards_calced = card.ability.extra.cards_calced + 1
                print(card.ability.extra.cards_calced)
                print((ae.cards_destroyed /(1+ae.cards_destroyed)))
            end
            
		end
		if context.joker_main then
				return {
					e_mult = card.ability.extra.lastCardCost	
			}
		end
		if context.selling_card then
			if card.ability.extra.lastCardCost < context.card.sell_cost then
				card.ability.extra.lastCardCost = context.card.sell_cost
			end
		end
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.lastCardCost = card.ability.extra.lastCardCost - card.ability.extra.debuff
		end
		if context.ending_shop and context.main_eval  then
			
			if card.ability.extra.abilityTrig == 0 then
				card.ability.extra.abilityTrig = 1
				card.ability.extra.selfLocation = card.rank
				print("Aether is located at:   ".. card.ability.extra.selfLocation)
    			return {func = abilityMove(card.ability.extra.selfLocation)}
			end
			
            
			
		end
	end
		}

aetherHunts = {
	prej .. 'sydtest',
	prej .. 'test2',
	prej .. 'skye'
	
}

