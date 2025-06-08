SMODS.Atlas {
	-- Key for code to find it with
	key = "skyeAtlas",
	-- The name of the file, for the code to pull the atlas from
	path = "skyeatlas.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

skyevars ={
    lastUsedConsumeable = nil


}

SMODS.Joker {
    key = 'skye',
    loc_txt = {
        name = 'Skye, Queen of Void',
        text = { 
            'Gain {C:mult}#1#{} {C:dark_edition,E:1}Negative Blackhole{} at the end of every round',
            'plus {C:mult}#2#{} for every spade flush played that round',
            '{C:inactive,s:0.8}(currently, #3# blackholes.)',
            'Using blackholes charges this card up, to a max of 943.',
            'Use this card to consume one charge up and',
            'recreate the last used tarot, spectral or planet.',
            'Charge: #4#/#5#',
            '{C:inactive,s:0.8}(currently, #6#)',
        }
        },
        config = {
            extra = {
                baseBlackHoles = 1,
                blackHoleAdded = 1,
                blackHoleEndofR = 1,
                abilityActive = {},
                abilityCharge = 0,
                maxCharge = 943,
                lastConsume = 'none'
            }
    },
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.baseBlackHoles,
            card.ability.extra.blackHoleAdded,
            card.ability.extra.blackHoleEndofR,
            card.ability.extra.abilityCharge,
            card.ability.extra.maxCharge,
        }}
    end,
    atlas = 'skyeAtlas',
    pos = {x=0,y=1},
    soul_pos = {x=0,y=0},
    rarity = 'ocj_concept',
    cost = 50,
    in_pools = con.skye,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            for i=1,card.ability.extra.blackHoleEndofR do
               local cards = SMODS.create_card({key = 'c_black_hole'}) 
               cards:set_edition("e_negative", true)
               cards:add_to_deck()
               G.consumeables:emplace(cards)
            end
            card.ability.extra.blackHoleEndofR = card.ability.extra.baseBlackHoles
        end
        if context.before and next(context.poker_hands['Flush']) and not context.blueprint then
            local allSpade = true
            for i = 1,#context.scoring_hand do
                if context.scoring_hand[i].base.suit ~= 'Spades' then
                    allSpade = false
                end
            end
            if allSpade == true then
                card.ability.extra.blackHoleEndofR = card.ability.extra.blackHoleEndofR + card.ability.extra.blackHoleAdded

            end
        
        end
        if context.using_consumeable then
            local cardU = context.consumeable
            if cardU.label == 'Black Hole' and card.ability.extra.abilityCharge < card.ability.extra.maxCharge then
                card.ability.extra.abilityCharge = card.ability.extra.abilityCharge + 1
                print(cardU.label)
            else
                skyevars.lastUsedConsumeable = cardU.config.center.key
                card.ability.extra.lastConsume = cardU.label
            end
        end
    end

}

sk = {}

sk.active = function(card)
    local consumable = skyevars.lastUsedConsumeable
    if skyevars.lastUsedConsumeable == "SKYE" or nil then
        return
    elseif card.ability.extra.abilityCharge > 0 then
        local newcard = SMODS.create_card({key = consumable})
        G.consumeables:emplace(newcard)
        skyevars.lastUsedConsumeable = "SKYE"
    end
end

G.FUNCS.ocj_can_use = function(e)
    local card = e.config.ref_table
    if card.label == 'j_ocj_skye' then
        print("Skye ability Used")
        sk.active(card)
    end
end

