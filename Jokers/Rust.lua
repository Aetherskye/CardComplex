
SMODS.Atlas{
    key = 'multi',
    path = 'multi.png',
    px = 71,
    py = 95
}

rstGlobal = {}

rstGlobal.aetherkill = false

SMODS.Joker {
    key = 'Rust',
    config = {
        extra = {
            percent = 30,
            percentadd = 3,
            currentBonus = 2
        }
    },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.percent, card.ability.extra.percentadd, card.ability.extra.currentBonus } }
	end,
    rarity = 'ocj_concept',
    cost = 50,
    atlas = 'multi',
    pos = {x=0,y=0},
    perishable_compat = false,
    add_to_deck = function(self,card,from_debuff)
        card:set_eternal(true)

    end,
    calculate = function(self,card,context)
        if rstGlobal.aetherkill == true then
            card:set_eternal(false)
            card:start_dissolve()
        end
        if context.ending_shop then
            card.ability.extra.percent = card.ability.extra.percent + card.ability.extra.percentadd 
            card.ability.extra.currentBonus = G.GAME.dollars * (card.ability.extra.percent / 100)
        end
        if context.joker_main then
            print(card.ability.extra.currentBonus)
            return {e_mult = to_number(card.ability.extra.currentBonus)}
        end
        if context.setting_blind and card.ability.extra.percent >= 100 then
            for k,v in ipairs(G.deck.cards) do
            v:start_dissolve()
            end

        end
    end,
    calc_dollar_bonus = function(self, card)
        return to_big(card.ability.extra.currentBonus)
    end
}




--[[
local newcard = SMODS.create_card({key = consumable})
        G.consumeables:emplace(newcard)
        skyevars.lastUsedConsumeable = "SKYE"

]]--
-- OLD [NONFUNCTIONAL]scrapped code where Rust would come back even if he was removed by some mod thru eternal (like yawetag) but i decided it would
-- be better to let players experiment with ways to get rid of this man.
    -- local jokers = {}
        -- for k,v in ipairs(G.jokers.cards) do
        --     jokers[k] = v.config.center_key
        -- end
        -- local owned = glf.findstring('j_ocj_rust', jokers)
        -- if rstGlobal.alive == true and owned == false then
        --     print("Hello")
        --     local createcard = SMODS.create_card({key = 'j_ocj_Rust'})
        --     G.jokers:emplace(createcard)
        -- end